Return-Path: <netdev+bounces-275491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPy8Olbb0mnebgcAu9opvQ
	(envelope-from <netdev+bounces-275491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 23:59:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 759EA39FEFF
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 23:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 221E83006B15
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 21:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F17384237;
	Sun,  5 Apr 2026 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fYO8GHPJ"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCDE17B50F;
	Sun,  5 Apr 2026 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775426387; cv=none; b=Dnqs8k4e71zBiA8XAVgjbAXWDELqzisNjjyeI5/b+pxDEzDXcJ7KoKwT9zqgIVOrPxvvL9xb7PpZoJVrEIsj62GQZXSXrpri8VjW6MldasFhbxgS5P0B1yve+OYkX46ILqlp7ebzYgN5HgUY0mN1g2G5aiFY6LBbCks3OWiD5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775426387; c=relaxed/simple;
	bh=MZNUFi8yolT6aQUoB/vtAsxmU189jDW1XJ3mYuqqJU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i97mC98I78JtzK9PuU3Mm/L3pAf0bwexAtw/HQLXQupD7A0kXA7xlfrIhs4O0Xi8uBAAFJZABpk/zIY7lPaQiosNeqhezPAREoxJ5yPuMiI3+yglXO9u+nK9o+Y2DtR4c+Ebwcc7PRhABnbRKBew2tlRjEluP49hcE2FcBp8KyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fYO8GHPJ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fpmb26LCHz9sl4;
	Sun,  5 Apr 2026 23:59:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775426382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ti02GCS8WYepRt+Ng0w1SPSsT5rII3vNDFgxuu2wZz4=;
	b=fYO8GHPJ2w9Sj3dzyfXpU++cIf6KcDfByLcXI9h7UU68W3U0DRuOtcTZg0N14k4xHEcXk9
	QsHLBLmgwtuP+2gKyqBlm4nGND5GwfZ+NJ/xOD+zMiMt/8QCGLVzw7ax6GKfd0H3YErTCG
	iDVybZnUQnWp+gJRhH2tXZRhvP6W1S+vSwbe93xiBKKPOGB2itm8BU7O1Vb8hoRk1u+qHO
	qSGHo6May1Xhm+VUDv/MKNz6mMR6JkDWMEX0sQs0Qkky02JqnhZ2csnMbZYgyjvDfg8c0p
	qv8EcE4aIFjJbbLuBYsZFH969CSeP1rBDaiwhViOESI/SxBPnM659PMLw+3J/g==
Message-ID: <22564dd5-c2b5-46ec-b083-6239a3ff5a2f@mailbox.org>
Date: Sun, 5 Apr 2026 23:59:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH v5 3/3] net: phy: realtek: Add property to enable
 SSC
To: Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20260326210704.58912-1-marek.vasut@mailbox.org>
 <20260326210704.58912-3-marek.vasut@mailbox.org>
 <a03960a2-f313-4c12-98f2-d032ce4a45ad@wp.pl>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a03960a2-f313-4c12-98f2-d032ce4a45ad@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gja1sh77d7xw1qxacetsgq4njcw9hwu6
X-MBO-RS-ID: b05c571556b657abfb4
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275491-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk,nxp.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:mid]
X-Rspamd-Queue-Id: 759EA39FEFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/5/26 10:23 PM, Aleksander Jan Bajkowski wrote:

Hi,

>> +static int rtl8211f_config_clkout_ssc(struct phy_device *phydev)
>> +{
>> +    struct rtl821x_priv *priv = phydev->priv;
>> +    struct device *dev = &phydev->mdio.dev;
>> +    int ret;
>> +
>> +    /* The value is preserved if the device tree property is absent */
>> +    if (!priv->enable_clkout_ssc)
>> +        return 0;
>> +
>> +    /* RTL8211FVD has PHYCR2 register, but configuration of CLKOUT SSC
>> +     * is not currently supported by this driver due to different bit
>> +     * layout.
>> +     */
>> +    if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
>> +        return 0;
>> +
>> +    /* Unnamed registers from EMI improvement parameters application 
>> note 1.2 */
>> +    ret = phy_write_paged(phydev, 0xd09, 0x10, 0xcf00);
>> +    if (ret < 0) {
>> +        dev_err(dev, "CLKOUT SSC initialization failed: %pe\n", 
>> ERR_PTR(ret));
>> +        return ret;
>> +    }
>> +
>> +    ret = phy_write(phydev, RTL8211F_SSC_CLKOUT, 0x38c3);
> 
> Only registers 0x10–0x17 require paged operations. The remaining registers
> are mapped directly into the PHY address space. This is mentioned in commit
> 650e55f224a575cdb18c984b95036109519502d1. Paged and direct access return
> the same results. With this in mind, I believe that RTL8211F_SSC_CLKOUT is
> an alias for RTL8211F_PHYCR2 and is described on page 45 of the 
> datasheet[1].
> 
> 1. RTL8211F(I)-CG/RTL8211FD(I)-CG Datasheet
This is a good point indeed, I think I can simply set PHYCR2 bits 
7,12,13 to enable the CLKOUT SSC ?

