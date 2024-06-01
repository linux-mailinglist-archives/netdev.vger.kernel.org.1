Return-Path: <netdev+bounces-99910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7252A8D6FA2
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 14:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EFDDB219E1
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 12:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CE914F9D9;
	Sat,  1 Jun 2024 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTWNcZGD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B312B9D5;
	Sat,  1 Jun 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717243421; cv=none; b=aHV6snt7+Qql9Nkxm2DEJJilsmPppUIPeN+rw24szP/QgYpxXtZM60Bn+GHckM7IXT6bERaO2z+zU/tcPYPZAVJldNb1J7iPzRR1n1HOWm3wSDtI4O3felfw5COPEyRo52Rex2y1nf9i9NbJdJvM9Dp3BkSnySFHycs35dKIEPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717243421; c=relaxed/simple;
	bh=UNsWjC/ISWYgvv61GcoYqy5Ul2KBLFUzp8qiwLD2F6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlZIsNhuNqAejjfZbu5S8zKoKn/afqTnqgOGaiZUs8WHfYs+JSJYXiLTGm+JYmfJGUGDo+ClUAQ+JXC11I1X8/8uks/nDtIgbnA7dTCsNoNPncDFGyE2IWIwAxlmQmSRZZRJSzKDIAn41ve+nxguTBig1nhQF6zf0e6kg/2uQEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTWNcZGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561D3C116B1;
	Sat,  1 Jun 2024 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717243420;
	bh=UNsWjC/ISWYgvv61GcoYqy5Ul2KBLFUzp8qiwLD2F6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTWNcZGDeKaJe4TqGxS4n6zAiabGPLMCbYV/PpW0EAdHSkbbkaK14HoZ1nenMBDpN
	 OiBg85fbOaDDNe3MizLlIdSUDXNrNrjJ53mb7FnNaRI0As/4dPIN5emm4ItHVAo0Xg
	 rM22eCrwnoiNcvqPSMAWYRS/B9yMPvwwSNhfkkl8rvnUyzY2977dVy8WPc9Ira2TeM
	 8M4TWG8i9hZ8LUuVWcjfUuITk9cHutPnPAKSO1ttJsCz2ueOugNlq3go6QcK4pPZ/A
	 GgQxGd9d913aGuwA1FmJ0ogtqAQS4QYaAM6pUCsgR7UADG2MN9mLR6ZbZG9wbgChjM
	 r9T50TsOglwnw==
Date: Sat, 1 Jun 2024 13:03:34 +0100
From: Simon Horman <horms@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] net: ti: icssg-prueth: Enable PTP timestamping
 support for SR1.0 devices
Message-ID: <20240601120334.GF491852@kernel.org>
References: <20240529-iep-v1-0-7273c07592d3@siemens.com>
 <20240529-iep-v1-1-7273c07592d3@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-iep-v1-1-7273c07592d3@siemens.com>

On Wed, May 29, 2024 at 05:05:10PM +0100, Diogo Ivo wrote:
> Enable PTP support for AM65x SR1.0 devices by registering with the IEP
> infrastructure in order to expose a PTP clock to userspace.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 49 +++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> index 7b3304bbd7fc..01cad01965dc 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -1011,16 +1011,42 @@ static int prueth_probe(struct platform_device *pdev)
>  	dev_dbg(dev, "sram: pa %llx va %p size %zx\n", prueth->msmcram.pa,
>  		prueth->msmcram.va, prueth->msmcram.size);
>  
> +	prueth->iep0 = icss_iep_get_idx(np, 0);
> +	if (IS_ERR(prueth->iep0)) {
> +		ret = dev_err_probe(dev, PTR_ERR(prueth->iep0), "iep0 get failed\n");

Hi Diogo,

A minor nit from my side.
No need to address this unless there will be a v2 for some other reason.

Networking still prefers code to be 80 columns wide or less.
It looks like that can be trivially achieved here.

Flagged by checkpatch.pl --max-line-length=80


> +		goto free_pool;
> +	}
> +
> +	prueth->iep1 = icss_iep_get_idx(np, 1);
> +	if (IS_ERR(prueth->iep1)) {
> +		ret = dev_err_probe(dev, PTR_ERR(prueth->iep1), "iep1 get failed\n");

Likewise, here.

> +		goto put_iep0;
> +	}

...

