Return-Path: <netdev+bounces-100019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E968D7760
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 19:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF05D1C20C11
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721075CDE9;
	Sun,  2 Jun 2024 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4oxG1L86"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A32135A;
	Sun,  2 Jun 2024 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717351000; cv=none; b=a2LqC1exC+SqkFax0Wp8hgrJn7OZxTfSeZqBlNNymi0I6/4fUgvS3ePCU5GGtY3JqWm2OrLlT/000O/doZBMj7+FGLYyY0mPYP8YhpbDFy7Vvob5NJdex0wn7/G/p/Gunz9vyT9cmRrJyiPy8nABre5eC8XMShdw/lOLFRF/tYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717351000; c=relaxed/simple;
	bh=EMRIof0eAiKmC/dGSA2KADzTmcrBWC02Jz5xngEj2ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoIJQGmqT+2v03dyN71hYEZmHtGJA0NznqxqnPFBOOt/I3IRZDzRLJFMUg20aDvElx7+vp6J5v9xzj45cWfbDrXL7sN2HIO06xmbDtVVRusu/WTjxP89jBlX+EhZ+0EoRGQjc9beT8kPHlNySQvC+6sf7jqjmx7iTqfFZBLMh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4oxG1L86; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z/ADx/BiXPR3gfBa2xcYZRXGOwBtNlA4xIjYz6DfzYo=; b=4oxG1L86PJ6dXtBfEAcVtsdKJk
	yVJtIWt+tlazZbie97+509sG2Z5W569PZWVCFeu7ZF+jBgTCK2t6tCNHjv6Hei9AHg6UMszkHNyUD
	UDQhBwctrsvVM7Rut5oJfev/SvXSTP2A1AxvmAjoPLntERV9/kcuraViMcE+isfwRppQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDpRU-00GeLw-G5; Sun, 02 Jun 2024 19:56:28 +0200
Date: Sun, 2 Jun 2024 19:56:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"nbd@nbd.name" <nbd@nbd.name>,
	"lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"conor@kernel.org" <conor@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"upstream@airoha.com" <upstream@airoha.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"benjamin.larsson@genexis.eu" <benjamin.larsson@genexis.eu>
Subject: Re: [EXTERNAL] [PATCH net-next 3/3] net: airoha: Introduce ethernet
 support for EN7581 SoC
Message-ID: <1c03c641-4727-4b75-b2b7-7dc48aebe8e8@lunn.ch>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <4d63e7706ef7ae12aade49e41bb6d0bb6b429706.1717150593.git.lorenzo@kernel.org>
 <CO1PR18MB4666E38DC1596C5B86B64155A1FC2@CO1PR18MB4666.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR18MB4666E38DC1596C5B86B64155A1FC2@CO1PR18MB4666.namprd18.prod.outlook.com>

> >+static void airoha_set_port_fwd_cfg(struct airoha_eth *eth, u32 addr, u32 val)
> >+{
> >+	airoha_fe_rmw(eth, addr, GDM1_OCFQ_MASK,
> >+		      FIELD_PREP(GDM1_OCFQ_MASK, val));
> 
> Not sure this is problem of my email client, but none of the functions args are aligning with above parenthesis
>               airoha_fe_rmw(eth, addr, GDM1_OCFQ_MASK,
>                                            FIELD_PREP(GDM1_OCFQ_MASK, val));

They look good to me. But they can 

I see from your mail headers you are using Exchange and other M$
things. Outlook is well known to corrupt emails, destroying white
space, wrapping lines etc. Your reply appears to of had some tabs
replaced by spaces, etc. Outlook is unusable for software engineers
handling patches.

	 Andrew

