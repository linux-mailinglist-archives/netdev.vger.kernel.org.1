Return-Path: <netdev+bounces-96493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADB78C6306
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5462284478
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 08:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC964F1F1;
	Wed, 15 May 2024 08:46:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout37.expurgate.net (mxout37.expurgate.net [194.37.255.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D2B4D10A;
	Wed, 15 May 2024 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715762789; cv=none; b=lvhhiRHMGVLeqZq+jjcihKV0Ds21gqfK7OyV8R6CcMZ7xM8RU+MvK/V5GBQsS3C0Pu3gS1UDEN8D3eEsvN49wC+H66Gbpwja6DXNQcaAn3RbrWyh2+GqLFsU61QOKVpGCwxez5hILTlierytNm39QPuiklo8hqYjxrc7VWwH82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715762789; c=relaxed/simple;
	bh=OPP0/BdnjTmMqLoXGVui34c+ShJMz0RlIoV3RjL9SNA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f1bigRedPS7hGtgCXhlOXDLFIGrv9/tV54sdn14DafZnt9Ws1wF2MYMiOxf16SqW3pcVXiD2zta+oON/f2cDyA8oNlAHneGZSRM8pRPR9CkdfRbj1goh6ruQXJCHxqVUFSHuNanKCsiHtD+SCz1ddQgPHLQLxA1rCFO2JotcOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de; spf=pass smtp.mailfrom=brueckmann-gmbh.de; arc=none smtp.client-ip=194.37.255.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brueckmann-gmbh.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <gessler_t@brueckmann-gmbh.de>)
	id 1s7AH3-00CmdK-OL; Wed, 15 May 2024 10:46:09 +0200
Received: from [217.239.223.202] (helo=zimbra.brueckmann-gmbh.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <gessler_t@brueckmann-gmbh.de>)
	id 1s7AH2-003Shd-I1; Wed, 15 May 2024 10:46:08 +0200
Received: from zimbra.brueckmann-gmbh.de (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPS id 60B83CABF0E;
	Wed, 15 May 2024 10:46:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTP id 52392CABF0C;
	Wed, 15 May 2024 10:46:07 +0200 (CEST)
Received: from zimbra.brueckmann-gmbh.de ([127.0.0.1])
 by localhost (zimbra.brueckmann-gmbh.de [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 25_cI0TGBhRh; Wed, 15 May 2024 10:46:07 +0200 (CEST)
Received: from [10.0.11.14] (unknown [10.0.11.14])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPSA id 365B6CABF0B;
	Wed, 15 May 2024 10:46:07 +0200 (CEST)
Date: Wed, 15 May 2024 10:45:17 +0200 (CEST)
From: =?ISO-8859-15?Q?Thomas_Ge=DFler?= <gessler_t@brueckmann-gmbh.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
cc: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>, 
    Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, MD Danish Anwar <danishanwar@ti.com>, 
    Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: Re: [PATCH 2/2] net: phy: dp83869: Fix RGMII-SGMII and 1000BASE-X
In-Reply-To: <ZkNhfXYxFTdB+weJ@shell.armlinux.org.uk>
Message-ID: <16cfda60-4319-be9a-1df7-026199b85c5@brueckmann-gmbh.de>
References: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de> <20240514122728.1490156-2-thomas.gessler@brueckmann-gmbh.de> <ZkNhfXYxFTdB+weJ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-purgate-ID: 151534::1715762769-00D3D148-8A47A4C7/0/0
X-purgate: clean
X-purgate-type: clean

On Tue, 14 May 2024, Russell King (Oracle) wrote:
> On Tue, May 14, 2024 at 02:27:28PM +0200, Thomas Gessler wrote:
> > This patch adds
> > device-specific get_features(), config_aneg(), aneg_done(), and
> > read_status() functions for these modes. They are based on the genphy_*
> > versions with the correct registers and fall back to the genphy_*
> > versions for other modes.
> 
> I'm reading this, and wondering... do you have a use case for this,
> or are you adding it because "the PHY supports this" ?

We use this chip in both modes. The driver did not work for the 1000BASE-X
and RGMII-to-SGMII modes out of the box, so I started a thread in the TI
forum and tried to get some info there.

https://e2e.ti.com/support/interface-group/interface/f/interface-forum/1320180/dp83869hm-link-not-working-with-rgmii---sgmii-bridge---1000base-t-using-linux/

This led to the development of this patch, which makes the modes work for
our use cases.

> If you don't have a use case for this, then it would be better not to
> add support for it at this stage, otherwise it may restrict what we can
> do in the future when coming up with a solution for stacked PHY support.

I understand, it would be fine for me to leave this unmerged for now,
especially because of the unclear RGMII-to-SGMII situation, and continue
patching this locally. The only problem I see for other users is that the
driver ostensibly supports all modes the chip supports and can enable each
of them with device-tree settings. Several of the modes, however, can
simply not work because the driver accesses the wrong registers (BMCR/BMSR
instead of the specialized FX_CTRL/FX_STS). This is the main reason why
the custom config_aneg(), read_status() etc. are necessary.

Thomas

