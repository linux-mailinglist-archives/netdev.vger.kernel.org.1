Return-Path: <netdev+bounces-199988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD88AE29DE
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E7D1895DCF
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCDC7262C;
	Sat, 21 Jun 2025 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEY0w/4S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8A29CE6;
	Sat, 21 Jun 2025 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750519992; cv=none; b=PNuuMylQVYf6E5mrOkMj7paqkS73DeS97M5XFWADW6ixV9byWKUUAl7mSR+tzBm/31WaPnB9gw8ov/st3/iemNA9X1uV8TYAEGmnsdIQXprfjEQ94Rm3KyM6XgNK89103ZzEwShCVSxahmvPpY9YRKJ5/AFrg6LtRw0VU6ZUwzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750519992; c=relaxed/simple;
	bh=U/RN8GW7mor8ejgTlIjriP4mx+AbIOvbp9cokVPSrYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFwl/Mp63uQx6c5NCC8Dl54HBawBsUKm3hyht9jZ8VVdAFzGCGkHUwpxo94IHkxHmSOPpti0uSENuhWJITMlI/fegRJeGK7G5sX5PXczhlD4Xd7+qSkgu+SoqSLHpZsYG0cKi7kbquyRLesgwwoJ4o9BhxMulAYp1soert9wtv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEY0w/4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567BFC4CEE7;
	Sat, 21 Jun 2025 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750519992;
	bh=U/RN8GW7mor8ejgTlIjriP4mx+AbIOvbp9cokVPSrYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bEY0w/4Soicls0I1mXAKwU88xLyBngt9W34C6ktqE6ikZSPEwhweW7MoP1WMjUVFb
	 yKujJ8p95shGrdifbAnZ9e3964IkQojWhvCkZEzcRbaIDdiEnAb9TnjIE2u7O+zWq9
	 Cp6lFkAk9zJ+uKIKcMFanNXRPnXTQbxt4Mg8ZiQXAouZinfIyaNdNsLkDxJKuyc/+i
	 6DfZcdz233kErRU4tRTZu3x3bxCN1+Jqk7bBBvRX9t5f8sUWnWQQ27o1agCJccHLTt
	 cxsjDr0nkivJsDxBx57PqhodwsY6R6I7r4qy5d3ZsyqtWEqlO4+CH6Y+jplFRM23Vu
	 +/clMz6QKZeUQ==
Date: Sat, 21 Jun 2025 08:33:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net-next 5/8] net: hns3: set the freed pointers to
 NULL when lifetime is not end
Message-ID: <20250621083310.52c8e7ae@kernel.org>
In-Reply-To: <20250619144057.2587576-6-shaojijie@huawei.com>
References: <20250619144057.2587576-1-shaojijie@huawei.com>
	<20250619144057.2587576-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 22:40:54 +0800 Jijie Shao wrote:
> ChangeLog:
> v2 -> v3:
>   - Remove unnecessary pointer set to NULL operation, suggested by Simon Horman.
>   v2: https://lore.kernel.org/all/20250617010255.1183069-1-shaojijie@huawei.com/

You removed a single case, but I'm pretty sure Simon meant _all_
cases setting local variables to NULL in this patch are pointless.
-- 
pw-bot: cr

