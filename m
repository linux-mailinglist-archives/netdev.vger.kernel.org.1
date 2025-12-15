Return-Path: <netdev+bounces-244768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 621BFCBE466
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E073027A62
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C5F346E58;
	Mon, 15 Dec 2025 14:21:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934D533A6EA;
	Mon, 15 Dec 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808518; cv=none; b=OAV3o2c+Ji3LRNu/POqXD9DPA75TGDXB98+g0o3XsZpcApOwQ1h2DMSmwTdTlniaNj1VTudYiXt1JAGm/xfeqb5claFvJ1H4lvlOkU2NAmnkoGIurVj3n9Js/B0xTV+Fj7ZjSH+qv29fb6AjB5P4/DRoV1GRZ9ZZrIQTORQE/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808518; c=relaxed/simple;
	bh=1jiC7tLvfTljWwxSViOobwzo5qZqygy+PmOQVIW3PXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUeOCSg689Xyon+4MAnub0j6AsQDgejBl8byLBaopfDRi7s5fWtNDdGZyFZ/yosfV+02cBkXMiosgiXB0L7DOej0tA9710pN1gJdcgDkz5IjTIOZhKDUha9bE8omm09Bi2M9i9p+VXddtbhjQFulrnS9MRIFeVGRa4ovKf9jbSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C6191A0190;
	Mon, 15 Dec 2025 15:21:49 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7EB131A0173;
	Mon, 15 Dec 2025 15:21:49 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 36DC0202DC;
	Mon, 15 Dec 2025 15:21:49 +0100 (CET)
Date: Mon, 15 Dec 2025 15:21:49 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] stmmac: s32: enable multi irqs mode
Message-ID: <aUAZfcMbHD+BHNSi@lsv051416.swis.nl-cdc01.nxp.com>
References: <20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com>
 <20251214-dwmac_multi_irq-v1-4-36562ab0e9f7@oss.nxp.com>
 <d1eba807-c45d-434f-b272-ed0841c728bf@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1eba807-c45d-434f-b272-ed0841c728bf@lunn.ch>
X-Virus-Scanned: ClamAV using ClamSMTP

On Sun, Dec 14, 2025 at 11:37:51PM +0100, Andrew Lunn wrote:
> On Sun, Dec 14, 2025 at 11:15:40PM +0100, Jan Petrous via B4 Relay wrote:
> > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> > 
> > Signalize support for multi irq mode.
> > 
> > >From now, if yoused old DT node, without channel IRQs set,
> > the driver fails to init with the following error:
> > 
> > [4.925420] s32-dwmac 4033c000.ethernet eth0: stmmac_request_irq_multi_msi: alloc rx-0  MSI -6 (error: -22)
> 
> Sorry, but that is not acceptable. You cannot break old DT blobs.
> 
> Please reverse the logic. If you find all the needed properties in DT
> enable STMMAC_FLAG_MULTI_MSI_EN. If none of the properties are there,
> continue using one interrupt, and if only some of the needed
> properties are there but some are missing, then you can error out with
> EINVAL, because the DT blob is invalid.
> 

Yeh, that was the main reason of marking it as RFC, I was not sure
if I can break old DT blobs or not.

Thanks for answer. I will change the procedure to stay
backward compatible.

/Jan

