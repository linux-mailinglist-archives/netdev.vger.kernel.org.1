Return-Path: <netdev+bounces-99999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BCC8D7688
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 17:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2CE1C20919
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B3433C9;
	Sun,  2 Jun 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="19z0dVig"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907EB66F;
	Sun,  2 Jun 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717341594; cv=none; b=CpSxFV1ZSsKakALt7jb3UtgwiqiQakMs9gnhHxzUPTmiJL6IaU8jVSgZqyhS+s1vYJVVcgVa47wbXXOkNexws+6HlKclNPwJ3iCfNvZJo8QQtlq8RrxP04kZ/0MQkWe6AaIEVV7wuUJYRYI7ndzXrIfGVJc7XQ/1pWszHzo8hvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717341594; c=relaxed/simple;
	bh=SQPi2dhR+hrDRiZHBXwEL9RYbOgNyAjNeqon/0CFbvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GukhEVpenvoBDt7OH4RHNqmqk7qgdio2wMC/ALqz0tUC4CW/MT2QV8bHjwB4cD9ECHz6sMdwT6YRnw1DNcebeb3SDmYLlz2yYUPnSOGLlw2H0UXKsQ4hD3Ow8zNaaKMiObD3E9EYPiGw3E37EJO8mUXIC19LoYd5BD2OogK8FUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=19z0dVig; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nqavnFoJZa1xwelaw40YOoUGVHNLrYxcxg9LB1wcUDc=; b=19z0dVig33YnGNy2632d3m3fcl
	jiLjbxL6hgfaKJoRbsPfAGcOqsdDmkKKMSvtYX59YruXV2+8istZwECGDh8KmSYPy0FY+7PSm1p4H
	VZaQ2YoSz0U+k7m3Ot9OWrwNmWOTvwvyTDkYJbQ34iMyhx4Ra2CiJiT3QLBcXIsA1UyA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDmzg-00Gcco-M6; Sun, 02 Jun 2024 17:19:36 +0200
Date: Sun, 2 Jun 2024 17:19:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc: Diogo Ivo <diogo.ivo@siemens.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH 2/3] net: ti: icss-iep: Enable compare events
Message-ID: <c4fb16a9-7b5f-4ba2-98ea-ac554fbe313f@lunn.ch>
References: <20240529-iep-v1-0-7273c07592d3@siemens.com>
 <20240529-iep-v1-2-7273c07592d3@siemens.com>
 <BY3PR18MB47377FBF88724DD5A4814BCEC6FC2@BY3PR18MB4737.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR18MB47377FBF88724DD5A4814BCEC6FC2@BY3PR18MB4737.namprd18.prod.outlook.com>

> >+	iep->cap_cmp_irq = platform_get_irq_byname_optional(pdev,
> >"iep_cap_cmp");
> >+	if (iep->cap_cmp_irq < 0) {
> >+		if (iep->cap_cmp_irq == -EPROBE_DEFER)
> >+			return iep->cap_cmp_irq;
> 
> This info is coming from DT, is PROBE_DIFFER error return value possible ?

static int __platform_get_irq_byname(struct platform_device *dev,
				     const char *name)
{
	struct resource *r;
	int ret;

	ret = fwnode_irq_get_byname(dev_fwnode(&dev->dev), name);
	if (ret > 0 || ret == -EPROBE_DEFER)
		return ret;

This suggests it can happen.

	Andrew

