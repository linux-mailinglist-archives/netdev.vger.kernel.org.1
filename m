Return-Path: <netdev+bounces-241801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F4AC88586
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B302341A8F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D7321FF46;
	Wed, 26 Nov 2025 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="cvIdG2ZG"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E467714F125;
	Wed, 26 Nov 2025 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764140608; cv=none; b=Vju3vclsWoM6PPgDYFf3rUCoJslSRUWZ/mlanPwyHLuLQfxoOMorqtCkOBv6fhUT3ylXU45Fo0eT9dx1cJjR5HMuSp7EL4bdI0sim1FDBHtz31zzO46i8atZ6d9Di45p51Z3BBdkDV2/92RdHP9eL69bHlVVIvIFeBgv7xU8SzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764140608; c=relaxed/simple;
	bh=Bmmkv7T6dGQcJdSedI3iuVD30ai2V9CJ2hnh9q1tMKY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gs0Jt7UtwGYzYzgbUYKGGGFL+okFCzBfeO/WxE7zVbhowVQSUbh80dXBD0nXoV/jFBJer1s9pSElS7zyVbWcwWBxkIHAXHXbacr7P6vMehMNLJ9bTaPswjTJbLT6IEK3kxyURA969Kav22VL246eVWu4yznqtnLG686XtySMpUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=cvIdG2ZG; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id CC562A07F4;
	Wed, 26 Nov 2025 08:03:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=ehBqv8v0apj+HEXDWptk3ipMZQiMB58+XRdwFmrPYpU=; b=
	cvIdG2ZGGp0GnUReJKVpRdwWvTYwt1ZTG/1J4ABP8CNMrEdEQE7SRt+Dlyxs1lRi
	3zGL7j81RYrjOIDC0bGLPdEzMke1SiCrW9Dw3clyzblavQvRxnyEuLe6Tmb4l6ah
	vOXb12Tw/cGE6K13OeX1yHdefjgmvv3OyHLemLunHsosl4YCi/Fw9KTRqVAj6fj+
	MLwBrpns50JlL9dmGniUnzGTrb0BBVV5UTJVI35sGHWy0780kBWGHOL/1pCutjyo
	I4n/LFNgNyDnkNUMn6J1RBY80fLcEFHSfDimo4o+pEkMFOXSGd143/hmbN6okhsl
	Nj0K1UT5rOJH7vHofi7vxOcvfTbvuRCPUPCaz517EpoLmzkirIdefobfNxgfgZGp
	yGjRhKKKQHoThBsVYCwd5Wote0rmdnQU714yZOkHz0QJiCDSrvtre43/kwXsiQsP
	YrkTSwZHYUZlGS8KWwP2WmnON03R2X6e3oB9d25H4ZtEaT5yRqfE9/M3X66tjPWL
	RF87ZkqHmoEuCbEeJ/aHD/s8FedfHGjJ0dyx43yhliHdV6pkwEsLDcySekV9//9r
	Zgy9sqyXJq6CuedYAC66Tja6+yRy9ZbDXmAIZYTvrkajy4A4DmZeO95QYmyi7n+y
	XawInvhNFkXAbW2QqMjPVSjQ4h3KBHqEuxeim0iIqDc=
Date: Wed, 26 Nov 2025 08:03:21 +0100
From: Buday Csaba <buday.csaba@prolan.hu>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/1] net: mdio: reset PHY before attempting to
 access ID register
Message-ID: <aSamOWYSdMC0117A@debianbuilder>
References: <6cb97b7bfd92d8dc1c1c00662114ece03b6d2913.1764069248.git.buday.csaba@prolan.hu>
 <20251125184335.040f015e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251125184335.040f015e@kernel.org>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1764140601;VERSION=8002;MC=1114099128;ID=129138;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F607362

On Tue, Nov 25, 2025 at 06:43:35PM -0800, Jakub Kicinski wrote:
> On Tue, 25 Nov 2025 12:15:51 +0100 Buday Csaba wrote:
> > When the ID of an Ethernet PHY is not provided by the 'compatible'
> > string in the device tree, its actual ID is read via the MDIO bus.
> > For some PHYs this could be unsafe, since a hard reset may be
> > necessary to safely access the MDIO registers.
> 
> You may be missing exports because it doesn't build with allmodconfig:
> 
> ERROR: modpost: "mdio_device_register_reset" [drivers/net/mdio/fwnode_mdio.ko] undefined!
> ERROR: modpost: "mdio_device_unregister_reset" [drivers/net/mdio/fwnode_mdio.ko] undefined!
> -- 
> pw-bot: cr
> 

I do not know how, but I missed that.

The previous version has built fine, but the declarations were moved to
an internal header file, so I guess that EXPORT_SYMBOL on either of these
functions would not be appropriate anymore.

I must find an other solution.

Regards,
Csaba


