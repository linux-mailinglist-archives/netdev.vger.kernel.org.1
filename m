Return-Path: <netdev+bounces-252101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBPNE4pVcWkNEwAAu9opvQ
	(envelope-from <netdev+bounces-252101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:39:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F6E5EF1E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2FF6545012
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6300844BC80;
	Wed, 21 Jan 2026 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iulFsUZd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65983EF0D8
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769035047; cv=none; b=un1Jxtc9iOyqQ5I3UEo1zkybaXYgDvGW+5NfbnQ87wFE67GDTxelINIKyZBhxGLFYRA7BLhuB98yyrnzcJezGAHNLFnch9Z+3CueiFZ8e1RuKEARpbUadaRd4PHWcA+WguBWnZHv5rc5UiQyqqfiA0HYVGKHmMmPhXHYOwnWLT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769035047; c=relaxed/simple;
	bh=SlWwyculiBABzhQdRSWezuPYqL5XqkaaZzBL+IrKxxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pw5ve0EjTFD5YrH5+c/newPpqieZcY7xBNQ+0FuoLqYF0kLhcNoRsHAuNYkySNC171b/U7ILjRTsei7S8YfU41uZUy/qlLifUf40ePt5B9ZeX/aGPu4nW5OacQNqJtf8wo9kSYaIrrAukUEf8TKegk92PamdY9fhtqgsOQL/iHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iulFsUZd; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b720bb90d0so379250eec.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769035044; x=1769639844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgjMJi+m/42Lvq5w641HEHT7p6jawBc1Rvrn2olmX9o=;
        b=iulFsUZdcfU2RmfnBl3Xo0JAL3ZrrW6bB5wKZJlzpAYyjN7he+yvxN+IRvpt423oRg
         Gdwy3aw2VzKQmDyN9N4FufRxaf0TrcsprdRcCtegQxAQOrnatB+v8rgwxjQSyam2ypvp
         yO2ophwmoWOyVONDK0+4hECDbeby9Jy+kIFrsZ7BmOIUQV0I+4VmhCdf71GEpMhfNcnF
         EN2UcLI7If3b6CaKFqiC6H5X6rHuPgnTI2FxEZsIrY7/Cxii+BClBpmxF/fyAmnQ3eLK
         3wNeZuFZktGiQ5gHWBTIl0JBzy955FAyK6QzrS0XKCx0yEavcD8o/IRPof3ChelvrDt6
         kNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769035044; x=1769639844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgjMJi+m/42Lvq5w641HEHT7p6jawBc1Rvrn2olmX9o=;
        b=HNxT462A+8CCwb/Y5fSyuH5f6X2g2vdRsLLSGIrS77pUnTRZpPWUSCWJSAdyOtPbF8
         AXOBPDWYN0AYmpD4l+FyxHdpQokmFglMXctq2LbypOSNh6qenwri5DZr0faVIEdB//Nx
         f/k4flp8emTp+s6veOn3WTEakJzR2BAHpBmDHMzjpA/oP6+GbcmWpkqZy75Mn/2v+h1L
         Wjj/9yEREwUllSfJqJFFZMi7ZPhE1g03NFh8yUQ6EDM8B39OR/kk/AU1GMgzjfTu+FZ/
         FJPEwACnKtzt8vysjObY3fNMgQ/zZb3GWXkCxFhZ990LUyTx6jMljSnm7G29KqD7pFmC
         C2JA==
X-Forwarded-Encrypted: i=1; AJvYcCWiaOgKGib2jdWA/49y3dw+Hx8fpX9AazfUN3zkm+MWv/zd2SLMUI9UHE6lKOjMG5oFLzJcyU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZgHvLGOIFSmzDXcGAOEi7BN332LZ3bsLh9umsBGNlzX+2khi
	wCdm7ojDnBjKwea1UeT7OQvJTQ+3uWiT8EMEDnIeINGsZsQkuoXaYc6Q
X-Gm-Gg: AZuq6aIXhnfBXTBXCsgTLh7AvFhRXSAk30fd22xA0xUeuxJBb3P1/DeK3t3nrkzrquF
	2jEB2hC2Espx0kFSIqs1awywuNR3IRm5ihiYIa19mXhM1O4crKyBNYajDjoIw515npZwbisETFC
	ThrCPcwV04vSbdU8P4NsrYxppt8PywcsM57JCg8/+avAHMalybTJwH5kBzTUXs6hSy0WS44Gdq9
	pEvW/3p+rpidxy0Q7w3gyVtnl6aYyKxae72INfVmOhS9/+FPO1mPD/KqpoPQwEo/4vaWwuR2qa+
	6CByQYiy5TCCl5pc3DqYxHeKznOTeGmVab7n+yociic8WacTY6D6Q13MyD99VSRj2PDFWwuTaiK
	oM8L9VSfHGANeb0pM7an8PGoS02G2YpAVG/tNuzCYidB2XyunClm/l7W0n13QvA3diDK3khhwie
	IZQUgyRbddpA==
X-Received: by 2002:a05:7300:8b14:b0:2ae:5555:4880 with SMTP id 5a478bee46e88-2b6b4713257mr14102244eec.13.1769035043476;
        Wed, 21 Jan 2026 14:37:23 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b70d7f729bsm6725736eec.16.2026.01.21.14.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:37:23 -0800 (PST)
Date: Thu, 22 Jan 2026 06:37:12 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Inochi Amaoto <inochiama@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <ziyao@disroot.org>, 
	Yanteng Si <siyanteng@cqsoftware.com.cn>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Choong Yong Liang <yong.liang.choong@linux.intel.com>, Shangjuan Wei <weishangjuan@eswincomputing.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Boon Khai Ng <boon.khai.ng@altera.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Add glue layer for Spacemit
 K3 SoC
Message-ID: <aXFVAoChTPZhjnGu@inochi.infowork>
References: <20260121071315.940130-1-inochiama@gmail.com>
 <20260121071315.940130-4-inochiama@gmail.com>
 <aXDBCsfaNrgfGjNK@shell.armlinux.org.uk>
 <73bf2977-ad1a-45fa-9b06-5df083c060a8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73bf2977-ad1a-45fa-9b06-5df083c060a8@lunn.ch>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252101-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,disroot.org,cqsoftware.com.cn,nxp.com,bp.renesas.com,linux.intel.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: E7F6E5EF1E
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 02:45:24PM +0100, Andrew Lunn wrote:
> On Wed, Jan 21, 2026 at 12:05:30PM +0000, Russell King (Oracle) wrote:
> > On Wed, Jan 21, 2026 at 03:13:11PM +0800, Inochi Amaoto wrote:
> > > +	mask = RGMII_RX_DLINE_STEP | RGMII_TX_DLINE_CODE | RGMII_TX_DLINE_EN |
> > > +	       RGMII_TX_DLINE_STEP | RGMII_RX_DLINE_CODE | RGMII_RX_DLINE_EN;
> > > +	val = FIELD_PREP(RGMII_TX_DLINE_STEP, tx_config) |
> > > +	      FIELD_PREP(RGMII_TX_DLINE_CODE, tx_code) | RGMII_TX_DLINE_EN |
> > > +	      FIELD_PREP(RGMII_RX_DLINE_STEP, rx_config) |
> > > +	      FIELD_PREP(RGMII_RX_DLINE_CODE, rx_code) | RGMII_RX_DLINE_EN;
> > 
> > So your reply where you basically stated that all the RGMII.*DLINE.*
> > constants here should be the same was nonsense. How can we trust your
> > replies?
> > 
> > > +static int spacemit_dwmac_fix_delay(struct plat_stmmacenet_data *plat_dat,
> > > +				    struct regmap *apmu,
> > > +				    unsigned int dline_offset,
> > > +				    unsigned int tx_delay, unsigned int rx_delay)
> > > +{
> > > +	bool mac_rxid = rx_delay != 0;
> > > +	bool mac_txid = tx_delay != 0;
> > > +	unsigned int rx_config = 0;
> > > +	unsigned int tx_config = 0;
> > > +	int rx_code;
> > > +	int tx_code;
> > > +
> > > +	plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
> > > +								  mac_txid,
> > > +								  mac_rxid);
> > 
> > Maybe Andrew can confirm, but this function was to fix up existing
> > broken DT, and shouldn't be used by brand new drivers.
> 
> Hi Russell, thanks for pointing this out.
> 
> This function should not be used in this case. MAC drivers in general
> only add small delays, in order to do fine tuning. The PHY adds the
> 2ns delay. There are however some MACs who cannot disable their 2ns
> delay, or have historically been broken, and add 2ns delay. In such
> cases, the phy_interface passed to the PHY needs masking, to indicate
> the PHY should not add the 2ns delays. That is what this function
> does.
> 
> Please don't call it. Pass phy_interface as is to the PHY.
> 

Great, I will remove this call and pass the phy_interface.

Regards,
Inochi

