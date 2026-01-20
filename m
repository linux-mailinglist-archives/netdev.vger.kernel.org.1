Return-Path: <netdev+bounces-251466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHA6KrVAcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:57:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EA5501DE
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D79462B116
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD34842317D;
	Tue, 20 Jan 2026 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBoPr2th"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9C3BF2E6
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909429; cv=none; b=sT96mDSi2CuoVcIuuAwXgU3NTol/Of6AYozy2yYpammsQV1N/RxJyA3E0hdNi+cN2+G8Ja8AzLJZETpYRwfYmRrPfYZK4FgGPlcymTJPTZoUcOGsI7fRJqcbuzYB7/8WDRRol3b7x6ujcwdV5V/vMFDWxlERenooUcVtcUIVwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909429; c=relaxed/simple;
	bh=gcLF48OQAJqjairFH8eR92suY9fBYKsnj8NxKel1wV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ21VxIeSRT8BjNUy+AOnFd6i7bNJNxXGCUN6AyKZVUyldAprlJI+CMVJyizMr6VI2dXgvxAOuwZ0DKnpRVCS063lsqL80PPdTPsDiQhMdWB8E2L42hvH8Ye88fmNam2GPg+oYWjzw23icJ/NER/D+8/pBChUHaKxb1Et2ZF2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBoPr2th; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6a93d15ddso5084914eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 03:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768909427; x=1769514227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEeKRKNgnXmWzaKf1C0tW6uj5QVjxVimCmm99Tj3C3c=;
        b=fBoPr2thtrJ7IKXqOqlk3jkwWCLQZ78B67lQ/mVvViQCxtCtqI1qpv3jwIgLjiKd+Y
         /XDUv5FrDOO8JGdJY1bYBRxXo5BiI9kFZI7ZP0MIy/NjK0PVNZkkzZFrlnlPBg96/xKA
         cZdCUrvnoILnw3CNjNSDAWrXHTSMtReMbLN4aQ2f4QRs8Qsn56vUhmmud+D3zkeNpOX6
         6rvvkgzyeq7ThI3/OLBTWniItCcJQpTvMaWqzpwvRiHgIW7aBSeQ4sH/mbmzoo6D1jaI
         zzBFbztWoN2eFnFrlOqx0xNu8fJUwqszvXkMfiYPFxA205HdDeuOubM+0DtAeXx5zP/c
         VuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768909427; x=1769514227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEeKRKNgnXmWzaKf1C0tW6uj5QVjxVimCmm99Tj3C3c=;
        b=EJ0+bxYyyCKuwvn6UQbFqJOB94kElkfLkVBUGM7QMQ1f4PslDNeNELviBVWkruVlj1
         GXL7A9ntEKAhSG6kCpiHVRcHGasVexRgMhgYg4abtHiDsFiSWwPZsdQdn8IbWQexasoG
         adoz8u7H6Dx74H99CvPlTIAEQ39jmD1cHKPiQ7v/hFQS23njjr4PuIOsfmVonuAFRvmN
         rSJfo4CloFWP6vyQLU59f3GDJRukUkL2RN8uS/06Es3NIOJS8v+U2HJX5v9RX6f+iFyD
         8yd1R2R8gJaq6X5v+jb9ffsBugzmuRz1sZvSRvhNpfNRvH14dGtuwFD2ItjGLTmcQv+S
         j7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWvzdBcUXHK7V6ZBTC4MTHwHj5qMPXvZDO7nA+YLRgpLiShlDQtOqQqtVHdw0w63NddMW2NXuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9k4VNxZfk93f24QPboOVXolpgrKlYi0wblagqMHz/F2t3RO7V
	fc4NuLYSdqCq/oCxuYHHRhxAsqtyOU0le6gfWGqVrCFSQjUHfHc93VlB
X-Gm-Gg: AZuq6aJ8GElJUvExriU/y5m2B53cueup5tkX77TItHimoSu9n6D5xORTEnksuxZfCYF
	BGxuWnyVel/P9kTNoEuvPdfISWUndp0zCDz82tkxZWDwENcIQ6Ppy3EDUWrXkyhEMc9h15K4RxR
	SOpLJ9oL2ylHCjC11EAAJJZXSZpcV217Y84xK+RHtTtt9Lc2V8tBRn/Ctlp+cj4Mxdozr64lbwM
	EwCC2MDVtmYK2ukK+68T5+uw5Dua/iTV1XOuE47751g2/zUrmgbrLEqEP67k5ccFsohM5flZgup
	+e8wDtWw0mivIdNWlpfS0lJKVqXa/FxAcHKQcIEWAg44bIwhb3fRJsiWecOJSCuI6v0moV0oUCS
	vMXWgHO/NxNMQjSbsAC7PdltpkOpkYxZTTHTjL3vyPia5IrkHXb3c18A0XYA0mwOX6Xh+5mvPDR
	6Zs8JDv9FN0A==
X-Received: by 2002:a05:7301:2b05:b0:2b0:5929:4d1f with SMTP id 5a478bee46e88-2b6fd7add4emr884545eec.33.1768909426655;
        Tue, 20 Jan 2026 03:43:46 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11dasm18506224eec.2.2026.01.20.03.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:43:46 -0800 (PST)
Date: Tue, 20 Jan 2026 19:43:36 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Yao Zi <me@ziyao.cc>
Cc: Inochi Amaoto <inochiama@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
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
Message-ID: <aW9p9By1ZW5i4iWw@inochi.infowork>
References: <20260120043609.910302-1-inochiama@gmail.com>
 <20260120043609.910302-4-inochiama@gmail.com>
 <aW9jbqBSgkiLLw8r@pie>
 <aW9m8YOVO1ClIQOd@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9m8YOVO1ClIQOd@shell.armlinux.org.uk>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251466-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,cqsoftware.com.cn,disroot.org,nxp.com,bp.renesas.com,linux.intel.com,bootlin.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com];
	RCPT_COUNT_TWELVE(0.00)[39];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,inochi.infowork:mid]
X-Rspamd-Queue-Id: 85EA5501DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:28:49AM +0000, Russell King (Oracle) wrote:
> On Tue, Jan 20, 2026 at 11:13:50AM +0000, Yao Zi wrote:
> > On Tue, Jan 20, 2026 at 12:36:08PM +0800, Inochi Amaoto wrote:
> > > +static int spacemit_dwmac_probe(struct platform_device *pdev)
> > > +{
> > 
> > ...
> > 
> > > +	of_property_read_u32(pdev->dev.of_node, "tx-internal-delay-ps", &tx_delay);
> > > +	of_property_read_u32(pdev->dev.of_node, "rx-internal-delay-ps", &rx_delay);
> > 
> > According to of.h, of_property_read_u32, which in turn calls
> > of_property_read_u32_array, could fail with -ENODATA if there's no value
> > associated with the property. Should the case be handled?
> 
> You cut too much. This had:
> 
> 	unsigned int tx_delay = 0;
> 	unsigned int rx_delay = 0;
> 
> at the start of the function.
> 
> of_property_read_u32_array() says:
> 
>  * @out_values: pointer to return value, modified only if return value is 0.
> 
> and of_property_read_u32() passes &tx_delay or &rx_delay to this. Thus,
> if any error occurs, these will be zero. In other words, a missing
> property is equivalent to setting these to zero, which is entirely
> reasonable.
> 
> However, "unsigned int" _may_ be type equivalent to "u32", but really
> these should be "u32" if of_property_read_u32_array() is used.
> 

Good catch! I always treat "unsigned int" to "u32" implictly, I will 
change to u32 for as an precise type.

Regards,
Inochi

