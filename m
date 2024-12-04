Return-Path: <netdev+bounces-148767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B47689E316F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4403BB228AD
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4928027715;
	Wed,  4 Dec 2024 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUjXJLv5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210024A1A;
	Wed,  4 Dec 2024 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279601; cv=none; b=Svk9P6veRHnQWBQhlvvPwHobLRtdijXRfAw381eC94mBoEPW5CoFQrHf7pCsoJccJ7fvPa3qt7wNsjA5WCbtjY5PpPQ4Mj/SFcLxSsfX5BgBCfj5MbSLH/vv3vntVgMpcXFnda23RBaIqU47ReonaqJWP8CWrFBcRaQRL6bZBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279601; c=relaxed/simple;
	bh=kFb0rO3TxtbGxN3/nPIRlPs1nEorK5PCvPSOAdSv86M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElG9niZ2V+pW93NWqT5kQV73CJsPnjOKlsFyxSEapjaX9tHymEngod665jWOnu/tNnmnZZ+5+V0xins2k7f+aOLWAS2J/DFCSP+zjDTRw7tt5zRaAXBLgNNuW9yYI4vzmFFtNpVdSoKF3FC21obvgB/ZWw7ja/QVKYBYAHpazwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUjXJLv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D11C4CEDC;
	Wed,  4 Dec 2024 02:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733279599;
	bh=kFb0rO3TxtbGxN3/nPIRlPs1nEorK5PCvPSOAdSv86M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GUjXJLv5IOsXbzV42sdnlCt9Mpus0V7DLd1/Y9jvKi24I/vaWAOQh1EZ3aqDUDstV
	 P41guXFt9GSnuECX0ccr2J0TG9rkvx0L2ZDDLDROq0NxavBQB6NauYskV/HrY0sd4M
	 5+/0WlGQBOPbIzkgQkgVDekxDP5menUwNU1eFDiAvsYGzpZwd81aDspd1dGvESylZq
	 iAJor368X2aB9vGp7Y0qSFS0CrVHE7l/ObDiZsGGYwijOmRD7KrhcOmpNTR65+A3GS
	 cvyDECQJRuYC2tLWZHpZ8W8M69QFfX5AcJHbzGzl8pgcX+xlZZfvUo5OIRu5gHSIzg
	 2VNII2eHGck5g==
Date: Tue, 3 Dec 2024 18:33:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
 <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
 <einstein.xue@synaxg.com>, Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 RESEND] octeon_ep: add ndo ops for VFs in PF
 driver
Message-ID: <20241203183318.16f378d1@kernel.org>
In-Reply-To: <20241202183219.2312114-1-srasheed@marvell.com>
References: <20241202183219.2312114-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 10:32:18 -0800 Shinas Rasheed wrote:
> These APIs are needed to support applications that use netlink to get VF
> information from a PF driver.

> +	ivi->vf = vf;
> +	ether_addr_copy(ivi->mac, oct->vf_info[vf].mac_addr);
> +	ivi->spoofchk = true;
> +	ivi->linkstate = IFLA_VF_LINK_STATE_ENABLE;
> +	ivi->trusted = oct->vf_info[vf].trusted;
> +	ivi->max_tx_rate = 10000;

I still feel like this is using the rate limiting API to report fixed
link speed, which is tangential to rate limiting..

Unless the user can set the max_tx_rate why would they want to know
what the limit is at? Ideally reporting rate limit would be done
in a patch set which supports setting it.

> +	ivi->min_tx_rate = 0;

No need to set this to 0, AFAIR core initializes to 0.
>  /**
> @@ -1560,9 +1601,12 @@ static void octep_remove(struct pci_dev *pdev)
>  static int octep_sriov_enable(struct octep_device *oct, int num_vfs)
>  {
>  	struct pci_dev *pdev = oct->pdev;
> -	int err;
> +	int i, err;
>  
>  	CFG_GET_ACTIVE_VFS(oct->conf) = num_vfs;
> +	for (i = 0; i < num_vfs; i++)
> +		oct->vf_info[i].trusted = false;

I don't see it ever getting set to true, why track it if it's always
false?

>  	err = pci_enable_sriov(pdev, num_vfs);
>  	if (err) {
>  		dev_warn(&pdev->dev, "Failed to enable SRIOV err=%d\n", err);

