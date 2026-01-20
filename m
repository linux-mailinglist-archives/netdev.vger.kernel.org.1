Return-Path: <netdev+bounces-251630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NNNLJEMcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:15:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8794D9D0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFA1F54FF81
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3013EF0C0;
	Tue, 20 Jan 2026 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLAySThh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA023E95A0
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948575; cv=none; b=mNWU6dQWUgIGrq4LOAy/+RQ9nnoiS0olR3jpi9hd+rWQHMMXy6VTIn6Oc8pWCKnKNw+SyGMHdocTGsm+RiFqY5NGC+R96bGX38FIOblGdb3WXAwzd7iWaVaolri2J2yX49qrjydOt/sTuZshuqxq6AQkxoMkLJdk1lCuQ2NMMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948575; c=relaxed/simple;
	bh=lYHvzcjsxYt0A+0br3h1GQXTMMOJydVerfEIbtr67k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3DrBrHKEHFMiAtN3mxxXI36wN9QafCqCzi6eY9uSFazci6FWbQ/vgHgXuvuNu9vtlKCYcPVHCF93LNb5VFBvXZPeccPJmqon4es65prG6KKxuxa0fq4OkzmEmxhnjAa8RKGoMvlFOzBID0zhDyGid9NgyW0pnAsY20z+zlf2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLAySThh; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b6f5a9cecaso2387918eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768948572; x=1769553372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NrbRZd+8qIGar6808P7aL6qI6sgZozZ7npqpjV5nqsk=;
        b=nLAySThhSy9ij1N6pkNJ3zrxUaeBB9cBuZ2D9wLwaAJeOXfnxse+ncUymem/fqpAkd
         6Jk2oqyzl0tL9e+19CcPWLDlKI3w0l9C8oZvmuqW1HYVVDopUIU/m7cdfaHX6ieGkT/a
         LiyWtyq9I64CVKznXcO5MIgvCnrcbUSwmRsjFEQ9NAOZqEdm5QQSv2RCjXro2UJECv5U
         jPfplYci6HglXUE4HnIH7S1vneLStxQaSOUu924efKy3I2OHYmYLE9Q+2Fy6vmCJWAOB
         GswoYeifv0egiGt5I0Z96ac4ircx48NW5Sew8Ur2V5YsF2Ia3w0KZEsz0usMr/lFKn4W
         GX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768948572; x=1769553372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrbRZd+8qIGar6808P7aL6qI6sgZozZ7npqpjV5nqsk=;
        b=E2MB4rP/RITPNDX+IJjJVA855loYH+P/+WMp7NG3TqmlSn60vV9nqqEKosuRtqMs9e
         MeaEOaC7FWmChhkUvRRyVQ35cnuOyZNWHDxDCxVbZik5hBhSRN/zKGXUXeZMhHvV5TcP
         ijbNM7eD3hlJI1OQ3dpykN6rxB543YyQdWgj2PsAw3Uf0UCxQpuIUXAnL/csR09pSSjk
         96MvYlqxUZEosTHZSnjnGf4kFfQXJrr5kSKb5SHcXOeE+lH71i08EmlZfh1z5sfLXkgH
         WHR1GY2GrWk4bB4dv3d4OnY1f7OaC/7r/WG9WvTJKY4aVCXAPU9mw7Trcj1gx0kbRh7M
         yvPw==
X-Forwarded-Encrypted: i=1; AJvYcCV7ogk4PWNJ2yoPBbvOKAA+Uo0+EEpIxdNcNHG/wkj2jfh7fdNC77/2XBlDFYxJ4P/u7bdsAVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2L81bE7MoT2+woVT0QRoIcpxfpECJveECmg+Q8HVZIHAtsxX
	eSdmUZLbDVS9O9N/iI2S07EKu56GmFAZKmz5KYbXYdUvhjoqZyHqxgJt
X-Gm-Gg: AZuq6aIxZAkrDJl++k9jNUs5uhBdasH3l6efUqn3hdemnIfXwHpnAKNsBYN+PWzKMlE
	rfhy818Q4G5y37gLye6BW6Q9BIBq0l6zY3LIzWkNUduq++07AHzoK0tbBSDauTKuu9JnN7Tsc1K
	EHSHwbLtITnx8I1oK0jGkk+C7AAljhq7HRF7P5K9AVJpxWH6U06j5sFbIjYTFAFJMD/aWJiaiVz
	1+/bAXuAhEE67WeuDh6tTMu0OM44pUNj5xW4PiVxm6U9W3gHPEYMzQjizs+zauBCirROhfcNvth
	U+Pr6n7p7R2onenej++xNg6t222HupjJ5hIDDoNYQLuKGXCLCaF6wKA5u9GaPmX90PcGQThUB0z
	9Zhs4xsR+SbsD4NbCdDsqS8UHeH63d6V4mNmgawKuYR1BegTKtnKXTDhvYGTaESU9c04YNcp/n4
	kC0RRZw7W+Bw==
X-Received: by 2002:a05:7300:fb94:b0:2ae:614a:3307 with SMTP id 5a478bee46e88-2b6fd7eee95mr2453605eec.42.1768948572147;
        Tue, 20 Jan 2026 14:36:12 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm21042996eec.32.2026.01.20.14.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 14:36:11 -0800 (PST)
Date: Wed, 21 Jan 2026 06:36:01 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Yanteng Si <siyanteng@cqsoftware.com.cn>, Yao Zi <ziyao@disroot.org>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Choong Yong Liang <yong.liang.choong@linux.intel.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Shangjuan Wei <weishangjuan@eswincomputing.com>, 
	Boon Khai Ng <boon.khai.ng@altera.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add glue layer for Spacemit K3
 SoC
Message-ID: <aXACRN7BaumIySp3@inochi.infowork>
References: <20260120043609.910302-1-inochiama@gmail.com>
 <20260120043609.910302-4-inochiama@gmail.com>
 <f8e4c5ec-94b1-4da0-8a40-976770514828@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e4c5ec-94b1-4da0-8a40-976770514828@lunn.ch>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251630-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,cqsoftware.com.cn,disroot.org,nxp.com,bp.renesas.com,linux.intel.com,bootlin.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,inochi.infowork:mid]
X-Rspamd-Queue-Id: 6F8794D9D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 02:56:26PM +0100, Andrew Lunn wrote:
> > +/* Note: the delay step value is at 0.1ps */
> > +static const unsigned int k3_delay_step_10x[4] = {
> > +	367, 493, 559, 685
> > +};
> 
> Am i reading it correctly that RGMII delays are limited to these four
> values?
> 
> If so, please add this list to the DT binding.
> 

No, these value are just adjustment interval, and it is also
controlled by another code register, the final delay is calculated
by the following formula:

delay = delay_step * delay_code * 0.9;

So the delay configuration needs to be calculated instead of
directly assigned.

> > +static int spacemit_dwmac_detected_delay_value(unsigned int delay,
> > +					       unsigned int *config)
> > +{
> > +	int i;
> > +	int code, best_code = 0;
> > +	unsigned int best_delay = 0;
> > +	unsigned int best_config = 0;
> > +
> > +	if (delay == 0)
> > +		return 0;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(k3_delay_step_10x); i++) {
> > +		unsigned int step = k3_delay_step_10x[i];
> > +
> > +		for (code = 1; code <= MAX_DLINE_DELAY_CODE; code++) {
> > +			/*
> > +			 * Note K3 require a specific factor for calculate
> > +			 * the delay, in this scenario it is 0.9. So the
> > +			 * formula is code * step / 10 * 0.9
> > +			 */
> > +			unsigned int tmp = code * step * 9 / 10 / 10;
> > +
> > +			if (abs(tmp - delay) < abs(best_delay - delay)) {
> > +				best_code = code;
> > +				best_delay = tmp;
> > +				best_config = i;
> > +			}
> > +		}
> > +	}
> 
> With the four values listed in DT, i would make this a straight match,
> not the nearest, and return -EINVAL otherwise.
> 
>     Andrew

Regards,
Inochi

