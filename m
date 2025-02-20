Return-Path: <netdev+bounces-168322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CF3A3E82E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1323B973B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6691B264631;
	Thu, 20 Feb 2025 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuCvYQgE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDF1E9B01;
	Thu, 20 Feb 2025 23:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093433; cv=none; b=eBxwAMeGJj6MC5S5hHMaS4ibUXLK/N+A7MqOa8je7Doz4v7XsG4eCo8b8FZDPRBEB/b1N358bp5rXGFSUQaxhMldhPhCagF0BN8f4zyzRPM7BCv8wsnhismTxjKVVjKuuelEaGdh5agbOyd0uQ+FFciKZSOWcV+q7ZH8a3Oi0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093433; c=relaxed/simple;
	bh=gzeRT2rEa3gciNYtGeSo44oJEobQzVvMyWoE8aOk0Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4rcSZFZnKK5uW2DqYSqULJYfLlKk6Z79NKpgKKkYcf9cUdTT2X/qYLC/wQjNaLChBIYbWUGPPB3qIb7EaQXjI8bC+5kLbYi0gVIeJPMl3yuN/xK/Lp5m9TBsQy7ZkiKP7/E9pp2fdgXZeKOBzc120iRH1mRNI0i725rhmR8MV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuCvYQgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E50C4CED1;
	Thu, 20 Feb 2025 23:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740093432;
	bh=gzeRT2rEa3gciNYtGeSo44oJEobQzVvMyWoE8aOk0Xk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CuCvYQgEOS6mJBiONjn9Y2kZ2c6UpbuBhjL0Awt+OX3cZwdGqQQVKrvVT0qenPpn5
	 5062tQ3TA9afMSuUI4EHyx3lx19RhQAz5RJN7XBUx67MQ9IWzdglDfQ7nIaBHSIF4Y
	 W5EYwP8fx4rK5j2pZ2cwnJnGnZwySTzeERDd9iHkZJ1Z6vYRVIZDqh6xPD5jFWPHEr
	 nN1BWjVcZvHrbcf81VSBNu1DtW5TNrtX0XSGkrgk/cXaQPbdB740jkhHSc9Il8MZZ0
	 FCTPNfPAaN/xJD3HLVc2PtfHmeeRgiG07EFjW4mzXbTwijESQNNoydgS1PceHsrj7g
	 BvW1aNoVvHvSQ==
Date: Thu, 20 Feb 2025 15:17:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 1/6] net: hibmcge: Add dump statistics
 supported in this module
Message-ID: <20250220151710.78f4893f@kernel.org>
In-Reply-To: <20250218085829.3172126-2-shaojijie@huawei.com>
References: <20250218085829.3172126-1-shaojijie@huawei.com>
	<20250218085829.3172126-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 16:58:24 +0800 Jijie Shao wrote:
> Subject: [PATCH v2 net-next 1/6] net: hibmcge: Add dump statistics supported in this module

In addition to addressing my comment about fix_features please 
also remove the "in this module" from all patch titles.

Other than that code LGTM.

