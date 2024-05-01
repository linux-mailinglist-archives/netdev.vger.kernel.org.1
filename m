Return-Path: <netdev+bounces-92685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74278B841B
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 03:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2682AB214E3
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C46F522A;
	Wed,  1 May 2024 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKr0fJDz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639748831
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714528793; cv=none; b=i/1pQikgGm2tsZbJR0B5XEgLIZyJhoPC9NtJiyMyTYIInUQumFi76u4iWwsRx7GIwAvEAonVYRX1uYdPCYlfpFUa05AmB39pJTB4QAJprSoYveDxXh/ygNCioeAWbdUakX6JT4bYe48CiFiyO7qY51Esj030HvInpWJ3f4Fa8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714528793; c=relaxed/simple;
	bh=rp5OH52ha8HSN6lyCYj9IlqquxeOKpsSry+qWfo8eW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEL81dcWx+eun0e7DfexlXtwsa2/D8K+HMBcam2kMhZCW7Yr5ifkccz3yfqOz2j+JHhJUoHtaGq4yHVzmV7lM7rxCAc51zVArk3zjqfN2zEK1ws/R4Cwjp7DH6BddE3zQ0h0pWZ0VS3fA+JgZTvrsevi6GiQptM+Xtv9vCF4jR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKr0fJDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622BEC2BBFC;
	Wed,  1 May 2024 01:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714528792;
	bh=rp5OH52ha8HSN6lyCYj9IlqquxeOKpsSry+qWfo8eW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GKr0fJDzGXmdTq5D3WNPk/cuCPtikx6bf+wLB6GOHKxIkAqLYEzkVAb1f1vr2eZ8Q
	 5840IGJnTzpQvVbQEKuAiw8nwpy3DZc1RsJcNxpoPwHXe28lbuY1qo2Mohq62JWhq0
	 hccw65xnYrJBgdO92wXZq0veiOafzAFZdHO8r0DdE27wGCjQdW5BOGyQUJO5kRnYK6
	 bSDrRNBceo+eTqMAEDNjXjJl4hmMx9fHOgWqz773ZUXuvnYe5SPRBcZWYW+ulVO4ks
	 MaLZRcOFGycE1GdT1n+M1+nbCVGrFmxCk0rcxdAciODEP45lKmQFBn6JP+cy1WQAfP
	 AKjJPIvTD+lwg==
Date: Tue, 30 Apr 2024 18:59:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, andrew@lunn.ch, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com, duanqiangwen@net-swift.com
Subject: Re: [PATCH net v2 1/4] net: wangxun: fix the incorrect display of
 queue number in statistics
Message-ID: <20240430185951.5005ff96@kernel.org>
In-Reply-To: <20240429102519.25096-2-jiawenwu@trustnetic.com>
References: <20240429102519.25096-1-jiawenwu@trustnetic.com>
	<20240429102519.25096-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 18:25:16 +0800 Jiawen Wu wrote:
> When using ethtool -S to print hardware statistics, the number of
> Rx/Tx queues printed is greater than the number of queues actually
> used.

The ethtool API fetches the number of stats and the values in an
unsafe, non-atomic way. If someone increases the number of queues
while someone else is fetching the stats the memory of the latter
process will get corrupted. The code is correct as is.

