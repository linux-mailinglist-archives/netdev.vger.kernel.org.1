Return-Path: <netdev+bounces-279862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDCUC/1O5mkgugEAu9opvQ
	(envelope-from <netdev+bounces-279862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:06:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C6D42EFB4
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCC92301B8FF
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D73733EAF9;
	Mon, 20 Apr 2026 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlhqX5Mi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqPeuJW1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870EA33F5BC
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701055; cv=none; b=RJcLXz1yJjXaDANi9n5prjMIBlyf7156XaX6WRJ2UVCa6pEocK0b8s64ad+Jl8m2NwasXBx2b3z/ps5blHMoXygEkxxQYvz/VZ04atOL0+y6lwJuvXTu0uTRcZCQ6zL/TR0uT5FAmJayy3+g5HuOJgnRctsjbouJ0drD6/TCIco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701055; c=relaxed/simple;
	bh=KIlPPGo0X7J+Rerxz9y7CSMVwywBHEeJRRBbryutCu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoIJTBeCfpOXL0YJwcEs8f0ApBaqMFRNZdE8FFeSVrAAG+FKKkH2cX3KxySahG2OYyzZebRehS+18YLR9oihwe4SHTdZtrwdIXegMXPlKzLowO5YX8LBU36rTCg7VAdJa4muWSrOnTPyH5q1hzARzmeFzzKwVnUrqNkkjLQXDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlhqX5Mi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqPeuJW1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776701053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jj5sN2uTms9dvgIclsPIFzN9As6sQ9fjVMFAHrqzo4M=;
	b=WlhqX5MikZC3CuGa2PEoTwgntFQ+pn274pIxHeX8G46H85tcQl2FxEeSBae9yMs+1HPNfl
	DhICptOmn8nfAUq8NS2uMEpCCPLc1f3h6hot54Z56PCqyRmiEq5Vf/3NuJRkoVU1+wXq1F
	bDPX9RhJon5tIZgx4qWSlB7F39uSljE=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-QYsW0hDbOSezdOAlTek3MQ-1; Mon, 20 Apr 2026 12:04:07 -0400
X-MC-Unique: QYsW0hDbOSezdOAlTek3MQ-1
X-Mimecast-MFC-AGG-ID: QYsW0hDbOSezdOAlTek3MQ_1776701046
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6059d4c73d5so1026949137.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776701046; x=1777305846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jj5sN2uTms9dvgIclsPIFzN9As6sQ9fjVMFAHrqzo4M=;
        b=bqPeuJW1thtdRbFw6wivd+IoUIWe9qiZMHRSDqBqRQaloeaBP6ZTHLz/soOttFzsvE
         LbfGKseWT2xCOEc6uymyVEIBRuMITWRMWbuPSSfLbLkKNDakJgS0raMw8eAcib8Zp9nv
         PRzK2g875AOk3S5oRo+PPQTUXIY5W4XQKIJ2KV22K4old/jObOOv+qKRq4aXvxc3rbcs
         ogbTMaPiG4k5Rp0MxiJXPP/7Uxoz6NRBP/E8bTrin166DHWReU2kx+fPsqS2PGm0LbIb
         Pz1KyjxjJ73yZeYnUltJti+md1mvGYOYEwxN8tmFK+V9PTAgqOgBf+A3gBWQJ74Uyxbo
         vXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776701046; x=1777305846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jj5sN2uTms9dvgIclsPIFzN9As6sQ9fjVMFAHrqzo4M=;
        b=EvF5uLyrBd8rT4RS/FEsX9kimcMOtLanGZuw+v2KTwpiThC4BEsGIbbrah8iSiWs7A
         ULHFDpITwyQUZ4mvg1toIMbO624ueW6AiLuzPhGsCRdS5Re5gF6KOws53bLBi3FmQ7Xg
         glbNRU39Ff8f/WBMelPBa7irfeVSCoeq2eg1a5F1veKHovesO902rW26B+dK2ffzMf7V
         gBZ2BFOFQn7VEM0RLZnizi5YvXnOOx2n2JfXlXUuljS2gu5JymbEhazl1TXDrm+lg51V
         iSw0FBRtaQnRky/9QuGiTFVI5tb0LvW45YzVBd13p0yJcFdXBvpfjfy7A1uBDw1A2+43
         a4Tg==
X-Forwarded-Encrypted: i=1; AFNElJ8KsDYsYjaSR49Hz5rD83IpF9W1unuMF44jbsfzTo7CgEaki4vVl2l0pqgpUj/Ys6joSFuAk4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYWqhXtA98AG/prB/VjmB3Xqx6M5gpuCQLjpj0XwaJfX1sWFjU
	QW9OfoaRERtZOVqK1hO9QGXlYl0ej+KjoQCVyxES8Ad0PMjpUKYtAudMM65XlY7Uhf9Z6ALJGaL
	PDfbJAsZtk4qEiU7801cSuuB7Hyy1RyZb2Fp2XKIv/PqO3MODbqhnq/7AtA==
X-Gm-Gg: AeBDiesSJQkVMuhtyTY2EuJB5NjMCZAnYi7nLrKRPHbT1wBiLyyFb2sfhd4ttz7JFUH
	rJ5QOfC8VdMH4LefGxf45Hrh0lRmkz/WH2WbDqklsEaMTc8hTZiJBy6T6R2q1jwa50LwPlFxvLi
	2WubM1HPSaJaVvL4pe8qynFgzgMSKl4Mmh+Lnnr8C6S8ot9MqMY0k18e2bA9Haltx0oMOYzs17J
	CXv7JWuktt9B7RxM1Fmbz/YVbtVShc7fFw15IVRfJ5bzkhUub60JMvDV3LOO2uTyi6krXS1yI51
	Sweihw8ddefNTh43kHWl/Lqi2I1ObHlRAiBo/DPcPM6wMfh2NZ8zQ7GSTTmCCfYeJbz0YZP7b8h
	wTWsUdbHTLJU61ZCjWxaCo6QANzMDV3aNGLuEXfG6Qw==
X-Received: by 2002:a05:6102:1611:b0:605:7a45:c7c0 with SMTP id ada2fe7eead31-616f70f0572mr5907116137.13.1776701046000;
        Mon, 20 Apr 2026 09:04:06 -0700 (PDT)
X-Received: by 2002:a05:6102:1611:b0:605:7a45:c7c0 with SMTP id ada2fe7eead31-616f70f0572mr5907043137.13.1776701045394;
        Mon, 20 Apr 2026 09:04:05 -0700 (PDT)
Received: from rh-jkangas-kernel ([2601:1c2:4400:6bf0:7677:bcee:4ef0:e09d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69abee3sm817868185a.17.2026.04.20.09.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:04:04 -0700 (PDT)
Date: Mon, 20 Apr 2026 09:04:00 -0700
From: Jared Kangas <jkangas@redhat.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/3] dts: s32g: Add GPR syscon region
Message-ID: <aeZOcCOgMy2g9wqp@rh-jkangas-kernel>
References: <cover.1769764941.git.dan.carpenter@linaro.org>
 <0e922537c02d1c47734142090f98eb78e921ed34.1769764941.git.dan.carpenter@linaro.org>
 <aeKn2dvOOO43zdev@jkangas-thinkpadp1gen3.rmtuswa.csb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeKn2dvOOO43zdev@jkangas-thinkpadp1gen3.rmtuswa.csb>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-279862-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,kernel.org,lists.infradead.org,lists.linux.dev,vger.kernel.org,linaro.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DBL_PROHIBIT(0.00)[64.7.192.0:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkangas@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,4007c000:email,400a4000:email]
X-Rspamd-Queue-Id: C2C6D42EFB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fixing Dan's address based on mailmap update, sorry for the noise.

On Fri, Apr 17, 2026 at 02:36:25PM -0700, Jared Kangas wrote:
> Hi Dan,
> 
> On Fri, Jan 30, 2026 at 04:19:52PM +0300, Dan Carpenter wrote:
> > Add the GPR syscon region for the s32 chipset.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >
> > [snip]
> >
> > diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> > index e314f3c7d61d..be03db737384 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> > @@ -383,6 +383,11 @@ usdhc0-200mhz-grp4 {
> >  			};
> >  		};
> >  
> > +		gpr: syscon@4007c000 {
> > +			compatible = "nxp,s32g3-gpr", "syscon";
> > +			reg = <0x4007c000 0x3000>;
> > +		};
> > +
> >  		ocotp: nvmem@400a4000 {
> >  			compatible = "nxp,s32g3-ocotp", "nxp,s32g2-ocotp";
> >  			reg = <0x400a4000 0x400>;
> > @@ -808,6 +813,7 @@ gmac0: ethernet@4033c000 {
> >  			compatible = "nxp,s32g2-dwmac";
> >  			reg = <0x4033c000 0x2000>, /* gmac IP */
> >  			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> > +			nxp,phy-sel = <&gpr 0x4>;
> >  			interrupt-parent = <&gic>;
> >  			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> >  			interrupt-names = "macirq";
> 
> I gave this a test on an S32G-VNP-RDB3 and didn't see any issues on the
> dwmac-s32 side, but this appears to trigger a panic when reading the new
> debugfs regmap/*/registers file for the syscon node:
> 
>     # grep 4007c000 /proc/vmallocinfo
>     0xffff800083da8000-0xffff800083dac000   16384 ioremap_prot+0x74/0xe0 phys=0x000000004007c000 ioremap
>     # cat /sys/kernel/debug/regmap/dummy-syscon@0x000000004007c000/registers
>     Internal error: synchronous external abort: 0000000096000210 [#1]  SMP
>     [...]
>     CPU: 0 UID: 0 PID: 4344 Comm: cat Tainted: G   M        E  X   ------  ---  6.12.0+ #226 PREEMPT_RT
>     Tainted: [M]=MACHINE_CHECK, [E]=UNSIGNED_MODULE, [X]=AUX
>     [...]
>     pc : regmap_mmio_read32le+0x44/0xa0
>     lr : regmap_mmio_read32le+0x44/0xa0
>     [...]
>     x23: ffff00080c080000 x22: ffff000802ac4c00 x21: ffff800087b13c9c
>     x20: ffff800080a46494 x19: ffff800083da810c x18: 0000000000000004
>     [...]
>     x5 : ffff800080a46448 x4 : ffff800083da8000 x3 : ffff800080a46494
>     x2 : ffff800080a47230 x1 : ffff800083da810c x0 : 0000000000000020
>     Call trace:
>      regmap_mmio_read32le+0x44/0xa0 (P)
>      regmap_mmio_read+0x4c/0x80
>      [...]
>     Code: 52800400 8b214093 aa1303e1 97f4caf0 (b9400275)
>     ---[ end trace 0000000000000000 ]---
>     Kernel panic - not syncing: synchronous external abort: Fatal exception
> 
> Running this through decodecode gives:
> 
>     All code
>     ========
>        0:   52800400        mov     w0, #0x20                       // #32
>        4:   8b214093        add     x19, x4, w1, uxtw
>        8:   aa1303e1        mov     x1, x19
>        c:   97f4caf0        bl      0xffffffffffd32bcc
>       10:*  b9400275        ldr     w21, [x19]              <-- trapping instruction
> 
>     Code starting with the faulting instruction
>     ===========================================
>        0:   b9400275        ldr     w21, [x19]
> 
> x19's offset from the base address in /proc/vmallocinfo is 0x10c, which
> points to a bad read at physical address 0x4007c10c; I also confirmed
> that the preceding memory reads back without issues:
> 
>     # head -c 990 /sys/kernel/debug/regmap/dummy-syscon@0x000000004007c000/registers | tail -1
>     0104: 00000000
>     # head -c 1005 /sys/kernel/debug/regmap/dummy-syscon@0x000000004007c000/registers | tail -1
>     0108: 00000000
>     # head -c 1020 /sys/kernel/debug/regmap/dummy-syscon@0x000000004007c000/registers | tail -1
>     <panic>
> 
> Best,
> Jared
> 


