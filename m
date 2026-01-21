Return-Path: <netdev+bounces-252135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHsDDQuCcWk1IAAAu9opvQ
	(envelope-from <netdev+bounces-252135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:48:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE01A60815
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7638734E4FB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CF031326C;
	Thu, 22 Jan 2026 01:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIUJzk3T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871A1CFBA
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046499; cv=none; b=fx5rEfN15q61Qfes0vZrFS1b9rjTJzhFWeytaYClcvpOZats02QAQo5DKaqenFUDfe56kUqE8IY/pVLYseo9mfQ4ZA+WekIZhtkORFYxVA/1FTVQms3zVo+60CY463/TNZz5Ox74X20SPDnECrpVdy2n58k7KWiDs/OYrkjGW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046499; c=relaxed/simple;
	bh=ms5pWR92u/Sb/qm5qVz6BRpgwmPmV2/bOD5kn3A20VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alWvOXvGwv7xDaGVYd9Vregk+YOuzVTg6yt36ggG1rIZVdFN0VU/XkezNPxiuG5EEHJj9faOJJXhOZz3sp9kWS4ceLAUpf/iWOX3reFvOhnSJYG/K4cbtWfBWA8/wwiBBDhDYqMeSmJhuzHR/HIjLmu+0seXaXLGM/hGexKCFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIUJzk3T; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45c719bb855so284299b6e.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 17:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769046496; x=1769651296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGEOJU/uiNboJwAtLEE6S07BEXT+vA5BV+sOD/aPObo=;
        b=UIUJzk3Ts4rVsXrNp2fvstCY5VkG8b6y9w5yLdm/cofsVIdXdxxFTZTPfBNgWC8RRv
         vL9MOKRRRbyz1ZfiJzXy+UM5oDL9bWTWOfpsg3Wbc70ZEUFWg0yVAD9/+hYfQx6aRu0v
         aCFDj8LA77GGTUxqa3S7rUw1+F2pbrcXpkS9acsRRvDs0HwjzLEOYfdyxV+BwBU10UuL
         skNdMvFBh+Z8SODekze0jNi18z+zlg2y+Nqa9zhEtjgwWqNa5ijv+KfWZO7t53gf8GtB
         yHAMbGVFCzCfZxOaJnk0Bt9jTsVc3NWRBfpDUuI6TljeCepM58b3NF0JYXqM0gkFD31X
         esLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769046496; x=1769651296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGEOJU/uiNboJwAtLEE6S07BEXT+vA5BV+sOD/aPObo=;
        b=XvQyqSoO6rbG09nFV3lqPfFTCR+qBUPFPsnMZmYry3eDGjPE9o3fMsPo28TQrIXTGK
         3pBVTcio9D3jvt7+VHRwtVVMCdwbem6TzGhm+HpLl/7clGs6Ehqgr9gfyn/lQl0+SRHF
         ISWQQpPe2S4QkFxttmXhfltbVLpC2WucX5ar+aXPDuBx0UoZ0cwv+4cs501WzmC2UpZn
         s93DcPv1Mp5lywU3UQIWr/ecjIP59pxG1PhShCo45PY6RLzpF7zOGXg2o8/HCws0qQAV
         QTNA1jdGNNvvCsIRd1RWodzxer8+847Knzu2J/Dyx4jfq5TzB9fwNjmPubkDkc1Y2KET
         15WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs83intXk66Ps3xjfqmeqH9cKrLikgxfD/V7WPU18CME3UWLh2j74p2qZ6qRoWY5yXH7ok7sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgqFeAi/Qbwx35Aqg8icMJxBb7Gon820mhPPr4SvC3vZYHD7PM
	ZvCY20XGjyPDq8FqV3iKBdxZL19kPcTjgz6fuC1NIdx/HB/h2G5UCLZq2q2u3twK
X-Gm-Gg: AZuq6aKLkDegr3MIXTNGQFSgXAe0nBTdZiWt+6obcxLFAOxJ6bsbUnNlr714aSIRkvZ
	YYN0MUXAsV6FYZkG7TdYFU42z0Wv1cV6PU8V07Q7q5CMpLvX4RcmqFgranURpJ84HUAGFyVeP0T
	8ZPhzRRHgyARENUl4gdcc7PKfmtSy9Mid/2mr/mYRk/bYILlI2nWOsgzcZ/EXyoLh09xmCOR2Pn
	auH5jD7SEypNfHq57hI5fVPV6zTcGlX6eeHNgWRKnNZUgdzsRZkvarvw9t8bxWJOul/Wc6G8Hp2
	WbQaCcKsDJ92d0wGcNkjDBa6o+paACuTxbdBnB5O8GBl1KUH518dBCJxqUdLMAJNm62ofj0yKI0
	NnRn2yuG5REk/osuU8KHKT5TkH5X0mnV+B/pkiaWvb8efYMjkavg//KT7BWk4H0O5affdUjVDJZ
	ZpS79ap83hVA==
X-Received: by 2002:a05:7301:408c:b0:2b7:143a:9a8f with SMTP id 5a478bee46e88-2b7143a9e6bmr2183820eec.7.1769039928585;
        Wed, 21 Jan 2026 15:58:48 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b361f5d4sm23459514eec.17.2026.01.21.15.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 15:58:48 -0800 (PST)
Date: Thu, 22 Jan 2026 07:58:37 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
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
Message-ID: <aXFVIK57ZNMD_Sbg@inochi.infowork>
References: <20260121071315.940130-1-inochiama@gmail.com>
 <20260121071315.940130-4-inochiama@gmail.com>
 <aXDBCsfaNrgfGjNK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDBCsfaNrgfGjNK@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252135-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,disroot.org,cqsoftware.com.cn,nxp.com,bp.renesas.com,linux.intel.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,armlinux.org.uk:url,inochi.infowork:mid]
X-Rspamd-Queue-Id: CE01A60815
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 12:05:30PM +0000, Russell King (Oracle) wrote:
> On Wed, Jan 21, 2026 at 03:13:11PM +0800, Inochi Amaoto wrote:
> > +	mask = RGMII_RX_DLINE_STEP | RGMII_TX_DLINE_CODE | RGMII_TX_DLINE_EN |
> > +	       RGMII_TX_DLINE_STEP | RGMII_RX_DLINE_CODE | RGMII_RX_DLINE_EN;
> > +	val = FIELD_PREP(RGMII_TX_DLINE_STEP, tx_config) |
> > +	      FIELD_PREP(RGMII_TX_DLINE_CODE, tx_code) | RGMII_TX_DLINE_EN |
> > +	      FIELD_PREP(RGMII_RX_DLINE_STEP, rx_config) |
> > +	      FIELD_PREP(RGMII_RX_DLINE_CODE, rx_code) | RGMII_RX_DLINE_EN;
> 
> So your reply where you basically stated that all the RGMII.*DLINE.*
> constants here should be the same was nonsense. How can we trust your
> replies?
> 

Sorry, I have found there is a mistake for replying you.
Now I give a detailed description about this registers.
You can check it at 
https://lore.kernel.org/netdev/aXFnmXIwSdKCS9Uc@inochi.infowork/

Regards,
Inochi

> > +static int spacemit_dwmac_fix_delay(struct plat_stmmacenet_data *plat_dat,
> > +				    struct regmap *apmu,
> > +				    unsigned int dline_offset,
> > +				    unsigned int tx_delay, unsigned int rx_delay)
> > +{
> > +	bool mac_rxid = rx_delay != 0;
> > +	bool mac_txid = tx_delay != 0;
> > +	unsigned int rx_config = 0;
> > +	unsigned int tx_config = 0;
> > +	int rx_code;
> > +	int tx_code;
> > +
> > +	plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
> > +								  mac_txid,
> > +								  mac_rxid);
> 
> Maybe Andrew can confirm, but this function was to fix up existing
> broken DT, and shouldn't be used by brand new drivers.
> 
> > +	plat_dat->clk_tx_i = devm_clk_get_enabled(&pdev->dev, "tx");
> > +	if (IS_ERR(plat_dat->clk_tx_i))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat->clk_tx_i),
> > +				     "failed to get tx clock\n");
> 
> As stated on the previous series, please don't abuse clk_tx_i for
> soemthing that isn't the dwmac's clk_tx_i signal.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

