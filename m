Return-Path: <netdev+bounces-252105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBaHEtNncWmaGgAAu9opvQ
	(envelope-from <netdev+bounces-252105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:57:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBDA5FBB4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33A6E4EE5D3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA689423A64;
	Wed, 21 Jan 2026 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft9/Dp86"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5B451054
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769039820; cv=none; b=trQ/a+WSX3UOc18KvxRVEcO7xfaPRtZ2WprlGnnISSANhSW5ZJ6WI6vaAUss3ZqzwV7cz8tR/tJqETgxu+IZj7J65/xPKDa39mGjfHTYyzp5/j/9RzMoofEZVZZpohLOl+O2VKFuhLXk/8pa4tPugOjJ+ybXSjbPdG9DPewV0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769039820; c=relaxed/simple;
	bh=SeCqNM8GWvX5mggx4Dkj2yTgrU7KsCaM5jxCJB7vXaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaV9T0oUGbgOdYYfe72cEFF1mTN4rY/Z/aMTBaE8RUhOvpwbhKapkOeAa0Zs8YI7I39/tOAW98HXh2+1x/P9rLJcM/Rb26Q1u+kd0UKYl/WBEjxFabm4QrzY3J44dq3S+UU5Xik0oMzX39E/OWDtTZgqDpRDSO4J4CZTb1cfk+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft9/Dp86; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233702afd3so744216c88.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769039817; x=1769644617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jp0I2O5rvzmCmzT9e9dhaVxnINQFtm8fPyCPAakfKbA=;
        b=ft9/Dp86rVU7vchnIfAccFy6xz88bv1vzC07AdmLho+Rg2/nfdAZQ6KcYQ3D6l6/Jw
         T0ueosBtycoxEzWx+LB2NakaFmFVUFb/CP3K38lstAqBgOSvGt5nifn+2D96NyvFPzLz
         2qkSM/3mq9xJ6lN37UKmEDKpLjEeO+n8i1NIKOY79CPsruWGW5nWArkKR7Yj7Yw+umG9
         GZwrx7FcTkNu7Papsy3sWMJXJRoQn99IuMiYoIHPxEn37w8j8yv6vcJckKmpTWyKdIZS
         KmHabxjabvfhRL0JLIsAF0XnsvErv6OtQdaXdhueMcMLBSe5wXOr7LrT364lzESCIH43
         MwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769039817; x=1769644617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jp0I2O5rvzmCmzT9e9dhaVxnINQFtm8fPyCPAakfKbA=;
        b=gXzadQay7QrdRS9CGUpYaRk3SiDJa7txXcT0xnD5HOLjeGzwgIUEHTpWzbCwQMKM9A
         pPCSAb4rET2I2NmYM3UcTFyfJurjIcvex3uE+BjnD+e75TbS4kl18oe4kXtsTjKP/vCx
         F0/WyAITJatYG1cBwncns9FedPjG7FX2LHIa5JkUD8MCxpm/5fo99brSQluoqusv+mXr
         oqyJWrYaGRTknTsyI6EPcbvQ3de+K1K2Y0jGYYjnWugcbNNoXsreIX4KgoqAIKRJEDFI
         s93F+rN6gpwb6bQ5VtkBw2jXov9yaNbWcLL6k0IMmLM6B5doHvqPf83GEMjnMgefpK9c
         h13A==
X-Forwarded-Encrypted: i=1; AJvYcCU4yQFk2CYVCUh/11mN/trSviySg5Xeta3J6rp6YRgkRTrQ1VXVbsZZYTtcTM5qEgSByPh3Omk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3/mEdHCz9i4zBRtiiXR9rFL0syzX3i+vb5MbsasV+skRdAA+
	jdrJO2IPU7A8csdDPwHNqsVOBzr7QegAKg513+g5IbH71R7XgXsyB0br
X-Gm-Gg: AZuq6aLP/tL8qNvy9i4BDKeKRvi6YjzdJL/HjDG8hWVkCikuD+5i3ZR6MB6ig0O/TpO
	aH45ovQoWKMxgzSmK1eN8GKyKWBSuhqp+yNBCblpk4POHm+5jkqxULazucCbSNY6etfYEkNiCr3
	s5JUAp9/kKZ/dwQ1X8xZU8ZIdGcrd93DLGEIJlKRAlKaZFjJwLiki6TpkC9sfS4E2uURmKybnNQ
	zEuch+cMgT1rkVxfhl3dhn8pVFiu4Lkwhj1BIYzl4iesTQ/mPu7FyosSm4ZbISrqpBQjAnumBvl
	zBa3OZFzGu+h2+vVzNAbgQoN8QN6SNHQ35zIHJ28YB3IkPlBJ8SCoP9i6ivBeVvVFTZ1qGc43tI
	5/ZkHN07jeHadR02fOMDnHOguKYXOm6MjLOSsqWsh2aN/mPx+7enfz5PlV/ksBn83RCc/GPt3aX
	FR6hkvB5GK8w==
X-Received: by 2002:a05:7022:4389:b0:122:33e:6d41 with SMTP id a92af1059eb24-1246aaac67cmr4335389c88.23.1769039816566;
        Wed, 21 Jan 2026 15:56:56 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac5842csm27914226c88.1.2026.01.21.15.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 15:56:56 -0800 (PST)
Date: Thu, 22 Jan 2026 07:56:45 +0800
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
	Alexandre Ghiti <alex@ghiti.fr>, Yanteng Si <siyanteng@cqsoftware.com.cn>, 
	Yao Zi <ziyao@disroot.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Choong Yong Liang <yong.liang.choong@linux.intel.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Shangjuan Wei <weishangjuan@eswincomputing.com>, Boon Khai Ng <boon.khai.ng@altera.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add glue layer for Spacemit K3
 SoC
Message-ID: <aXFnmXIwSdKCS9Uc@inochi.infowork>
References: <20260120043609.910302-1-inochiama@gmail.com>
 <20260120043609.910302-4-inochiama@gmail.com>
 <aW8LAFhCRWlMVemz@shell.armlinux.org.uk>
 <aW8MJpERR3TmsiKg@inochi.infowork>
 <aXDAmDEpUArE1_en@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDAmDEpUArE1_en@shell.armlinux.org.uk>
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
	TAGGED_FROM(0.00)[bounces-252105-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,cqsoftware.com.cn,disroot.org,nxp.com,bp.renesas.com,linux.intel.com,bootlin.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: ADBDA5FBB4
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 12:03:36PM +0000, Russell King (Oracle) wrote:
> On Tue, Jan 20, 2026 at 01:05:39PM +0800, Inochi Amaoto wrote:
> > > > +	mask = RGMII_RX_DLINE_STEP | RGMII_TX_DLINE_CODE | RGMII_TX_DLINE_EN |
> > > > +	       RGMII_TX_DLINE_STEP | RGMII_RX_DLINE_CODE | RGMII_RX_DLINE_EN;
> > > > +	val = FIELD_PREP(RGMII_TX_DLINE_CODE, tx_config) |
> > > > +	      FIELD_PREP(RGMII_TX_DLINE_CODE, tx_code) | RGMII_TX_DLINE_EN |
> > > > +	      FIELD_PREP(RGMII_TX_DLINE_CODE, rx_config) |
> > > > +	      FIELD_PREP(RGMII_RX_DLINE_CODE, rx_code) | RGMII_RX_DLINE_EN;
> > > 
> > > These FIELD_PREP() fields look wrong. Did you mean to use DLINE_CODE
> > > both tx_config and tx_code, and did you mean to use TX_DLINE_CODE for
> > > rx_config ?
> > > 
> > 
> > This should be RGMII_TX_DLINE_CODE. This is a copy paste error, I
> > will fix it.
> 
> Are you sure?
> 
> In that case, please change this to:
> 
> 	val = FIELD_PREP(RGMII_TX_DLINE_CODE, tx_config | tx_code |
> 					      rx_config | rx_code) |
> 	      RGMII_TX_DLINE_EN | RGMII_RX_DLINE_EN;
> 
> If that isn't what you meant, then your reply is wrong, and it seems
> you're confused, which makes me then question how reliable your
> replies are.
> 

That's wrong, I think I have reply it in a wrong way, it should be

RGMII_TX_DLINE_STEP -> tx_config
RGMII_TX_DLINE_CODE -> tx_code
RGMII_RX_DLINE_STEP -> rx_config
RGMII_RX_DLINE_CODE -> rx_code

The RGMII_[RX|TX]_DLINE_STEP register selects which step is used for
rx/tx delay. The RGMII_[RX|TX]_DLINE_CODE register provides the factor
used for calculating the delay. These register are computed in the
spacemit_dwmac_detected_delay_value(). And finally we can got a delay
with "code * step / 10 * 0.9" for both rx and tx.

> > > > +	plat_dat->clk_tx_i = devm_clk_get_enabled(&pdev->dev, "tx");
> > > > +	if (IS_ERR(plat_dat->clk_tx_i))
> > > > +		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat->clk_tx_i),
> > > > +				     "failed to get tx clock\n");
> > > 
> > > You set plat_dat->clk_tx_i, but you don't point
> > > plat_dat->set_clk_tx_rate at anything, which means the stmmac core
> > > does nothing with this.
> > > 
> > 
> > Yes, the vendor told me that the internal tx clock rate will be auto
> > changed when the speed rate is changed. So no software interaction
> > is needed.
> 
> Please do not assign a clock to clk_tx_i that is not the dwmac
> clk_tx_i input. clk_tx_i is a name used by the Synopsys DWMAC for a
> specific clock.
> 
> As you don't need to do anything with it other than to get and enable
> it, consider using just a local variable here.
> 

OK, I will use a local variable here.

Regards,
Inochi

