Return-Path: <netdev+bounces-254213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KLfFvDxeWnT1AEAu9opvQ
	(envelope-from <netdev+bounces-254213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:24:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9796A0467
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3E55303746A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF5344DB3;
	Wed, 28 Jan 2026 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+KcOV2J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515F33FE0A
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599344; cv=none; b=BNs1UziqTGlkS7acga3M5YBKuQSHGHJB5PBXAF+6SfgEKigWvGKUKArvrXqkZGyP70GhTRKC68ZzE2A3Tcp0m5VnRkdkQ0FnsYlCbadVSRDqYZJyOJQess18mc+8nVEHTBUUk2fUZfIYSC/IujZ4vmiNOOTAuzM0eFxlT/QPvIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599344; c=relaxed/simple;
	bh=XNI1PdxzUMCdX20UCO6iHB0ZsB5uIDvd2qbamyYZI5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9bDUExR5L5/4TzLrED2gvz4AqX2M8+05lSRdnWhWkLJK1VsuYozbIOKeXkwXqYeCYlAgvJEmse5i6rwuYByrEm8zncHk7g4QP4kwNhJmJI5wkHuldCw1cD7R1AzdnJ7HEa3NdkwP/8DBnwRtyNF6/+e86DUANJq6iMHcMG0ukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+KcOV2J; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-124a95e592fso325508c88.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 03:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769599341; x=1770204141; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJUI8NJKVSDnIT+QSuw3y5qsdf/HcwP4R02WUPv/Zns=;
        b=U+KcOV2JO58Jj7i04m+T8AYbKXUUCEDwamVIz8AFpmgLIcrimxphPntYYDUeFPVG8z
         SCNXgWq3X87/5LOJZ7sCg1F7fkivA2ocgM738bj1F7a5pPFX30VoBdgRuKfsTqWR7Y2l
         OphdO3BJ2zE+stG0BOtAABDHpc01m+NFWTwtYVLU53O03vT7JkfXMAFARlXe/EbknLW3
         bgY+MMavaPS2Yk4lEhob+AYRNqNruMWCH1ZKXM8c2hFYYWrE1xudFz9/wdYfXYyRPnHy
         nBSKjjtx46l7aF8cSyhpSFn7Uy2zMYwP2MUDxxG7KCi70/65nKe/fY2ZTWzfDGf5fvre
         Na4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599341; x=1770204141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJUI8NJKVSDnIT+QSuw3y5qsdf/HcwP4R02WUPv/Zns=;
        b=BhtdL9pZige1cy5gEYFT7j8fZQkfC2RVsbfKIWjCdnVc6u99h28CDFfYJc3qbESRv5
         0G8qUupif+6BPKdiUxH7XEry1QhIFjr2PCgmZXGHtZ/9XgtT4M0hX19Zca9E5Vs3YPH/
         u8NtxMYcfoIpDlPy4YSveaNuwZ7cLJm5yCfA8cLUvp96wxP1SPRzx2xGaRyJGw2RiiOi
         Y0X0cSvoQbMlwPlYqoNoCPi/Rxjxj68spXXShA0ktSFpx+yIC9bxVu9lBm0mMDb0AgFR
         DxIopIPTCvHySMzGXNWC35MW84DimaNUse3zL7k/3P5VvWc8k9A2cuQ6AUx0F7XCi0d2
         QYVg==
X-Gm-Message-State: AOJu0YwQ19lDu+NzRAaG9gnJQl5Alm+ZHOfy4s/2YiGZIHlcnEaklmzH
	64uB4vHAxdyUJXGApOWhF1sdiMTu/k5ESUid5Ioyi0ixvHhS8nNYLJjE
X-Gm-Gg: AZuq6aLHiTsLQoUIVCTmMNo4NlYEsweMz4ns4aPDv6n3B6P+umVpWXuZYmKIdhK93GX
	IyhZYQEzEe7Iq0ZvuUNG5zPL0QSYAny2IzHKmzjj8axw3bS8uZ/xRMwAJWffAaw3LJRnEkCf0na
	L+KxA/upj1Dw/VC26pFJobYGqi/kyPR0q/LwHfZGITNg3uXL8TlMot2B873mhIadWPwvTztG3B+
	r/OpcNS/nqiwhOJb+obtYajOuuEOHLhDd4xyZeF7R5aVZHnN2UzN0LibUfxIcDcmQZW0RWn0+8i
	HnFIHlvWNfIvpoep2emDz3DdW0BXr2vVkrmsF/MF8vU22GR+d/GiGI8weOSFCVg3Ns3ZTbWLGiD
	RP1JLf9BvdTT2U9e0/8B9WNxqmvVd5wVV6BFWRxfkRW0df0USX0npdkXjZsazd+BTjDanB38nZa
	DgJJdvjNlYtQ==
X-Received: by 2002:a05:7022:eb47:20b0:11d:fd26:234e with SMTP id a92af1059eb24-124a0070cbdmr2385944c88.16.1769599341399;
        Wed, 28 Jan 2026 03:22:21 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8d6sm2140833eec.3.2026.01.28.03.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:22:20 -0800 (PST)
Date: Wed, 28 Jan 2026 19:22:02 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>, 
	Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Yao Zi <ziyao@disroot.org>, Yanteng Si <siyanteng@cqsoftware.com.cn>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Choong Yong Liang <yong.liang.choong@linux.intel.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Shangjuan Wei <weishangjuan@eswincomputing.com>, Boon Khai Ng <boon.khai.ng@altera.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add glue layer for Spacemit
 K3 SoC
Message-ID: <aXnxDlExQRYrbf6s@inochi.infowork>
References: <20260128072931.875041-1-inochiama@gmail.com>
 <20260128072931.875041-4-inochiama@gmail.com>
 <f73fc83c-b38d-4974-ba3c-80c5e5556e7e@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f73fc83c-b38d-4974-ba3c-80c5e5556e7e@iscas.ac.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254213-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[iscas.ac.cn,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,disroot.org,cqsoftware.com.cn,bp.renesas.com,bootlin.com,linux.intel.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,inochi.infowork:mid]
X-Rspamd-Queue-Id: C9796A0467
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 05:16:46PM +0800, Vivian Wang wrote:
> Hi Inochi,
> 
> I have some comments below.
> 
> On 1/28/26 15:29, Inochi Amaoto wrote:
> > The etherenet controller on Spacemit K3 SoC is Synopsys DesignWare
> Typo: etherenet -> ethernet
> > MAC (version 5.40a), with the following special point:
> Nit: point -> points 

Thanks

> > 1. The rate of the tx clock line is auto changed when the mac speed
> >    rate is changed, and no need for changing the input tx clock.
> > 2. This controller require a extra syscon device to configure the
> >    interface type, enable wake up interrupt and delay configuration
> >    if needed.
> >
> > Add Spacemit dwmac driver support on the Spacemit K3 SoC.
> >
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
> >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> >  .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 218 ++++++++++++++++++
> >  3 files changed, 231 insertions(+)
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> >
> > [...]
> >
> > +
> > +/* dline register bits */
> > +#define RGMII_RX_DLINE_EN		BIT(0)
> > +#define RGMII_RX_DLINE_STEP		GENMASK(5, 4)
> > +#define RGMII_RX_DLINE_CODE		GENMASK(15, 8)
> > +#define RGMII_TX_DLINE_EN		BIT(16)
> > +#define RGMII_TX_DLINE_STEP		GENMASK(21, 20)
> > +#define RGMII_TX_DLINE_CODE		GENMASK(31, 24)
> > +
> > +#define MAX_DLINE_DELAY_CODE		0xff
> > +#define MAX_WORKED_DELAY		2800
> > +
> > +/* Note: the delay step value is at 0.1ps */
> > +static const unsigned int k3_delay_step_10x[4] = {
> > +	367, 493, 559, 685
> > +};
> > +
> > +static int spacemit_dwmac_set_delay(struct regmap *apmu,
> > +				    unsigned int dline_offset,
> > +				    unsigned int tx_code, unsigned int tx_config,
> > +				    unsigned int rx_code, unsigned int rx_config)
> > +{
> > +	unsigned int mask, val;
> > +
> > +	mask = RGMII_TX_DLINE_STEP | RGMII_TX_DLINE_CODE | RGMII_TX_DLINE_EN |
> > +	       RGMII_RX_DLINE_STEP | RGMII_RX_DLINE_CODE | RGMII_RX_DLINE_EN;
> > +	val = FIELD_PREP(RGMII_TX_DLINE_STEP, tx_config) |
> > +	      FIELD_PREP(RGMII_TX_DLINE_CODE, tx_code) | RGMII_TX_DLINE_EN |
> > +	      FIELD_PREP(RGMII_RX_DLINE_STEP, rx_config) |
> > +	      FIELD_PREP(RGMII_RX_DLINE_CODE, rx_code) | RGMII_RX_DLINE_EN;
> > +
> > +	return regmap_update_bits(apmu, dline_offset, mask, val);
> > +}
> > +
> > +static int spacemit_dwmac_detected_delay_value(unsigned int delay,
> > +					       unsigned int *config)
> > +{
> > +	unsigned int best_delay = 0;
> > +	unsigned int best_config = 0;
> > +	int best_code = 0;
> > +	int i;
> > +
> > +	if (delay == 0)
> > +		return 0;
> > +
> > +	if (delay > MAX_WORKED_DELAY)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Note K3 require a specific factor for calculate
> > +	 * the delay, in this scenario it is 0.9. So the
> > +	 * formula is code * step / 10 * 0.9
> > +	 */
> > +	for (i = 0; i < ARRAY_SIZE(k3_delay_step_10x); i++) {
> > +		unsigned int step = k3_delay_step_10x[i];
> > +		int code = DIV_ROUND_CLOSEST(delay * 10 * 10, step * 9);
> > +		unsigned int tmp = code * step * 9 / 10 / 10;
> > +
> > +		if (abs(tmp - delay) < abs(best_delay - delay)) {
> > +			best_code = code;
> > +			best_delay = tmp;
> > +			best_config = i;
> > +		}
> > +	}
> > +
> > +	*config = best_config;
> > +
> > +	return best_code;
> 
> Is this really necessary? For K1 I just used the smallest step size.
> 
> It seems to me you have, for the smallest step size, about 36.7ps * 0.9
> = 33ps per step. Theoretically speaking that lets you fine tune the
> delay to within 1% of the 2ns total required RGMII delay (MAC + PCB +
> PHY). In practice this number shouldn't be that marginal. 
> 

I think it is reasonable, I will take you advice and use the
smallest step size.

Regards,
Inochi

