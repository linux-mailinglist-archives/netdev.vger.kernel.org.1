Return-Path: <netdev+bounces-129066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C610B97D4CD
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 13:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 609CAB22124
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C33143738;
	Fri, 20 Sep 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sqL4adBu"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04101422D3
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726831592; cv=none; b=MS8AIj/QH2k3Jj8XkjwOyDKuqcZ83oUVr/Ay1ZffGI4Xt6F/G+sYa/14ng0+P2Nlwd+WJhZ5y9E6xBIEfkJyrZX9/EGU71D7ITFrs0707vbCvtrWHe28GHHM1zLOb0UIWqtrKdFSEkzBCA8AX+UlPcPC0YV2tXF2AQq2gpR7TP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726831592; c=relaxed/simple;
	bh=ypaKHctEX9fgrItsYNSVNA1/+alOChFA1XGDJgVaOSY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmUIFigoDM49Eo+aoGc1kgG9tu9sdu3HSYRXkTCpEpnuh5yQ5jxzFhd+L+8MqWBmQnOWpRIstUpq9XF9YWBjpHnJPglYvhbLBb3k3ZpTf/vxkDS3Q2UdVsMko45Nz853YTYGqdi/yYSn/x/oBlZyLGDm1ZgvakzeWm4owyPvc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sqL4adBu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48KBQGFf045466;
	Fri, 20 Sep 2024 06:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726831576;
	bh=wc6ounJ0L3a7+Jl1lhdKkoB0bwTcukkbr16QNFYjtJs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=sqL4adBu55uQNYcQB3ZENkEv8lAKyRQQ8ZJ6uKmfKPNkLgAvNpFXkInyeBw61yeLQ
	 s6MQ2cvkImL84QhMCeQCdG6QOWnDjzzQlQKko4NXrecLeTVrUmhqDw88CNNKGye98J
	 rej47IccmXla9eF/GNh6hMmgOiLszBPBuIA1yapc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48KBQGuk079901
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Sep 2024 06:26:16 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Sep 2024 06:26:16 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Sep 2024 06:26:16 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48KBQGDs071175;
	Fri, 20 Sep 2024 06:26:16 -0500
Date: Fri, 20 Sep 2024 06:26:16 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>, <netdev@vger.kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <maxime.chevallier@bootlin.com>, <o.rempel@pengutronix.de>,
        <spatton@ti.com>, <r-kommineni@ti.com>, <e-mayhew@ti.com>,
        <praneeth@ti.com>, <p-varis@ti.com>, <d-qiu@ti.com>
Subject: Re: [PATCH 5/5] net: phy: dp83tg720: fixed Linux coding standards
 issues
Message-ID: <20240920112616.7bz3uwuehenbczxi@reconvene>
References: <cover.1726263095.git.a-reyes1@ti.com>
 <dcf72baf9ff9a82799edd40f06c8d255f5c71b1c.1726263095.git.a-reyes1@ti.com>
 <25904339-bc6c-4ace-988c-cc6e832a18f2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <25904339-bc6c-4ace-988c-cc6e832a18f2@lunn.ch>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 23:47-20240919, Andrew Lunn wrote:
> On Thu, Sep 19, 2024 at 02:01:19PM -0700, Alvaro (Al-vuh-roe) Reyes wrote:
> > Driver patches was checked against the linux coding standards using scripts/checkpatch.pl.
> > 
> > This patch meets the standards checked by the script.
> 
> This patch should be first, to cleanup any existing issues. New code
> you add should already be checkpatch clean as you add it.
> 
> These patches need quite a lot of work. Maybe you can find somebody
> inside TI who can mentor you and point out issues before posting to
> the list.


Sorry about that Andrew. I will work with the team and try and
straighten this out.

Thank you for your patience.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

