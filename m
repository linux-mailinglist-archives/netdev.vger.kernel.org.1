Return-Path: <netdev+bounces-128408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7DD979767
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 17:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A89281FF5
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1671C7B87;
	Sun, 15 Sep 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB2ck6LO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3B1C57B8;
	Sun, 15 Sep 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726413052; cv=none; b=Ybn8AAK+87ZdVNxxT+TRFLG92eKdskX23qDcTq4dxv/5TsEFfPk6aQQ4d4xRwkR021PvN6JrOXXruxqqtPeTdynUCQLqOHW7RrZ8Td1Y0xyzU2/BeBIjKrnao0SiSoYm81KoSD+E5fVMUH9zMAoY+vEnrEAb40QhyL+kLtqNRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726413052; c=relaxed/simple;
	bh=hAljY3mqLmDyrRESMjPEfAlnjfcZQGA6TEo7XIMHy+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1gljs03ikpchHluCBvni/v9VpmPEVDUJ86JAuRF7kYenuABRgdu82bJEq5Nc8tWZ5T1yjTz0oi/CPJRhGny+MYIACM1YjM/1pwTJqo8buLfXLlhHCbBo/8adBCILQr6E0jqSeUwzVq5ijqf4FqD/jlMUZtSvkuBk4/mRtfauAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB2ck6LO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F52C4CEC3;
	Sun, 15 Sep 2024 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726413051;
	bh=hAljY3mqLmDyrRESMjPEfAlnjfcZQGA6TEo7XIMHy+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fB2ck6LOv9CeWE0OFLOfenosPxBvPQKW3H5z+yCvw4rFZs2K9PPbGqA9Z0qqtlK6s
	 vIvDXFBiTVR9Pn+tss9ujnPrev2mE9DJddQ/48jrrsH+4tJyrLHzUDSiVY5egF6VLi
	 LScCt+3fs1T2Jl0ui4gqszpozqwiU1emfK916o3/nNojoBbmam8afXsz5EFmTt4h9b
	 Ayu+kHbxDWODVwkrstvhO3AKwLNPQqfWmVKw582XSkT9+YxIdPRh0whNwAsfkVQkpJ
	 xGPszF7qoAPbr5J/N3HVoNJRn0X6OpDqUAnkdjt8wDsD2TqyCnDdKkhAqFHmezXMOg
	 aOsbWn2bx+U+g==
Date: Sun, 15 Sep 2024 17:10:44 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>,
 <kalesh-anakkur.purayil@broadcom.com>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V10 net-next 01/10] net: hibmcge: Add pci table
 supported in this module
Message-ID: <20240915171044.72aed6cd@kernel.org>
In-Reply-To: <20240912025127.3912972-2-shaojijie@huawei.com>
References: <20240912025127.3912972-1-shaojijie@huawei.com>
	<20240912025127.3912972-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 10:51:18 +0800 Jijie Shao wrote:
> +	netdev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
> +						      struct pcpu_sw_netstats);
> +	if (!netdev->tstats)
> +		return -ENOMEM;
> +	netdev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;

take a look at how pcpu_stat_type is used in net/core/dev.c
core will automatically allocate the stats for you and handle them in
the ndo for reading stats
your current code repeats what core already does so it will leak the
memory and I think double count

