Return-Path: <netdev+bounces-115595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E14C947190
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 01:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF181C208F7
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 23:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050EA13AD26;
	Sun,  4 Aug 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o1EaUPvh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89647F7A;
	Sun,  4 Aug 2024 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722813098; cv=none; b=EUYIHoHxi0m/HthGyWg4uOhIgffNMiXleGzYt7r3n5WYc2I1ylPBI6zThsUDR1HELe3jCzqchUJL1Gf6BuoQYPwJIiwrxu21pGKnctOBQoSflohPMARmi14oNHwAi26+uZYaccqbj2KLYRDO+NlnlY5+NH1YSf8rml1+5hq6z1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722813098; c=relaxed/simple;
	bh=UNiXlj5M8SXeYpYWbfrxumlBJJdXhZWtjjEyA0VZj7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTOPaRTfEg3zBJYVS3XCoqe66ddUtB3/BTTmyp7X2rQehc6QT94Orl8uW+ZXlSKa/O0IMY5KgBjwuX+u+VWgVAPzJAZ+qryyzArpjeHka+T8882SB4AAcUT3xx9VW+2X2R3hCj6+S/cOcRvTDiNSgUhuu6mAgR5RPOWJC+xG5Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o1EaUPvh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xPcQPhnjefrAYPKlbLal+dPjivGLLzQxviFzFKK6nPM=; b=o1EaUPvhdYVisztqS0ZbOVFM/6
	pssJF8sIgd1ISQUE9aqJ2rAWcyyEi0u2LIfIKBkBWOZ7t/JoKVGQvhaSDPFd/xpjTzp7n0tPhW2Bc
	Hg6RaeP/x3HXbc1Z7zpWNAGjur30Z/Lh7FBLNzxg/NLIlGRika+eKz9ydYgCKOorRgRc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sakNg-003zgl-0j; Mon, 05 Aug 2024 01:11:16 +0200
Date: Mon, 5 Aug 2024 01:11:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dl-S32 <S32@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net: driver: stmmac: extend CSR calc support
Message-ID: <8aa45bc5-b819-4979-80b5-6d90a772b117@lunn.ch>
References: <AM9PR04MB850628457377A486554D718AE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB850628457377A486554D718AE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>

>  #define	STMMAC_CSR_20_35M	0x2	/* MDC = clk_scr_i/16 */
>  #define	STMMAC_CSR_35_60M	0x3	/* MDC = clk_scr_i/26 */
>  #define	STMMAC_CSR_150_250M	0x4	/* MDC = clk_scr_i/102 */
> -#define	STMMAC_CSR_250_300M	0x5	/* MDC = clk_scr_i/122 */
> +#define	STMMAC_CSR_250_300M	0x5	/* MDC = clk_scr_i/124 */

That should probably be called out in the commit message. It is not a
fix as such, since it is just a comment, but as a reviewer i had a
double take when i noticed this.,


    Andrew

---
pw-bot: cr

