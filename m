Return-Path: <netdev+bounces-186457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A48A9F369
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D3E5A251C
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84AB26D4FC;
	Mon, 28 Apr 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GuTa/GwU"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777EA26B962;
	Mon, 28 Apr 2025 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745850560; cv=none; b=K9g79Fv0kcye7b2HmZsh5gE2eixUxtKCd5DZ+1a+66B33g3XCt76fv+ZoCL2P9a6BoaCxhViYtLUY8tayNTHi03ZJuKJQRNFLEKFqBgHQQyGZ5wKPs/KBxv11XmfcyevFCfN4jSeeSKS5CxDBb1ebLaFl6FspCizkDMtlKjwsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745850560; c=relaxed/simple;
	bh=rJLdBVQbvCv+TluCWMpZ9vIsstIJLp+u2Vh5mAtrQnQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiRyNJiId7z+sr3EIppydHh+GXgSfaMGIzZfycpYon07OeODiKudKtqgfUGz+TnCkbaRhNsZWjoE96oawbSigjD6gcw1JHFaqhpKQXM/RueS1nIdaVyPcb4t3wOvzEyl0j7zvSW/Qw029w+GiViRVSzaStBYOt7FICnO5Qp3mwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GuTa/GwU; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53SESiWF2797224
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 09:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745850524;
	bh=RBnt6oCOdXftASOE020D1oKxhactwZNgt5XQP4zEG/g=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=GuTa/GwUemjpMPB21SqSYZEWi8J73Q9cSTDCHdOGiWTFgWJZx3Jmjo8ep6SYaL4mT
	 Sem9HbvtdPMacM3XxfBBejYAxRVA4XBuZ5HlbmNuysJDAgvoSPgF85+JXJcbOJjq0U
	 jpzx7fhACyOWooFH+E1/3X3luNknWIBdRuTJfFBA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53SESivY077126
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 09:28:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 09:28:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 09:28:44 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53SESgc4076217;
	Mon, 28 Apr 2025 09:28:43 -0500
Date: Mon, 28 Apr 2025 19:58:42 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "Russell King
 (Oracle)" <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Whitcroft
	<apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn
	<lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux@ew.tq-group.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <8b166e41-8d21-4519-bd59-01b5ae877655@ti.com>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <aAaafd8LZ3Ks-AoT@shell.armlinux.org.uk>
 <a53b5f22-d603-4b7d-9765-a1fc8571614d@lunn.ch>
 <aAe2NFFrcXDice2Z@shell.armlinux.org.uk>
 <fdc02e46e4906ba92b562f8d2516901adc85659b.camel@ew.tq-group.com>
 <9b9fc5d0-e973-4f4f-8dd5-d3896bf29093@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9b9fc5d0-e973-4f4f-8dd5-d3896bf29093@lunn.ch>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, Apr 28, 2025 at 04:08:10PM +0200, Andrew Lunn wrote:
> > > However, with the yaml stuff, if that is basically becoming "DT
> > > specification" then it needs to be clearly defined what each value
> > > actually means for the system, and not this vague airy-fairy thing
> > > we have now.
> 
>  
> > I agree with Russell that it seems preferable to make it unambiguous whether
> > delays are added on the MAC or PHY side, in particular for fine-tuning. If
> > anything is left to the implementation, we should make the range of acceptable
> > driver behavior very clear in the documentation.
> 
> I think we should try the "Informative" route first, see what the DT
> Maintainers think when we describe in detail how Linux interprets
> these values.
> 
> I don't think a whole new set of properties will solve anything. I
> would say the core of the problem is that there are multiple ways of
> getting a working system, many of which don't fit the DT binding. But
> DT developers don't care about that, they are just happy when it
> works. Adding a different set of properties won't change that.

Isn't the ambiguity arising due to an incomplete description wherein we
are not having an accurate description for the PCB Traces?

A complete description might be something like:

mac {
	pcb-traces {
		mac-to-phy-trace-delay = <X>; // Nanoseconds
		phy-to-mac-trace-delay = <Y>; // Nanoseconds
	};
	phy-mode = "rgmii-*";
	phy-handle = <&phy>;
};

In some designs, the "mac-to-phy-trace" and the "phy-to-mac-trace" are
treated as a part of the MAC block for example. Depending on which block
contains the trace, the delay is added accordingly.

Regards,
Siddharth.

