Return-Path: <netdev+bounces-279433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIZQNvan4mnW8gAAu9opvQ
	(envelope-from <netdev+bounces-279433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:36:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F03441EBC5
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5696C3088B80
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB6A37D13D;
	Fri, 17 Apr 2026 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZI6qWAk+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FW48bxc0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77237D108
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776461796; cv=none; b=ebUz1Jv7lN4++9XA/k+a4OQzAsWkvOYjW95mc7K55aiSvgRuGKiw6Tas6HQrKrbOj49ekE13arVOcn4rI0LtU9wAJsZh8/mGtAafqRhAefrAFQHdwFcPIyk6uaZAMEJ6hMNvMta9jVLuG8hF7o5FqPzG6qAd17B6VjeFTYEHxl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776461796; c=relaxed/simple;
	bh=45mII1+xcjg6myIsPEEJz+gygn1qFcoTPSB9uHRcm84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNJxzildWiosBwNpSl5ieoHUQPm09w9XEaC4mFMKsqeCPvmsrBgsy5b3zOGZux5eLIFXurfEHKP9w8J9q9613LmNa3tyy4GciM5ZpJeA2MaeJ92o8pNOPnBmiq0KvnHgQqZiLM0hiwDpn94+/KhfvfCRw/f2Ycpi5kb/wRdnK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZI6qWAk+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FW48bxc0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776461791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfbRBXQJE7XBqTPyM/9pBB24pVjmhOJfH/25m2T2XAw=;
	b=ZI6qWAk+90WC0TTEtw2ItUjAWluk48WWMzv4E7aWVqPpNTndov+DATRMIvxo/00qgPaQH3
	6LoTBcgWKOnQ0f1gnlnnrj09XTW60fndpUeve7pBXsiqoo+MA4pt5V4fdQcP+jYC0J+h73
	Mr4KhKBewHGl8GyuJQ0pzi67gNjjb2Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-t0wh0A2rNMiAqeZPxHhSuA-1; Fri, 17 Apr 2026 17:36:30 -0400
X-MC-Unique: t0wh0A2rNMiAqeZPxHhSuA-1
X-Mimecast-MFC-AGG-ID: t0wh0A2rNMiAqeZPxHhSuA_1776461790
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d9a6a853bso30100331cf.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776461790; x=1777066590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfbRBXQJE7XBqTPyM/9pBB24pVjmhOJfH/25m2T2XAw=;
        b=FW48bxc0FQMVHpljUXKUvM1LpVesp5FCqYfRIFYS2NQMRI6GpmGOMq3mREK5We4Rya
         TK5002mcyfFsnasB0H3Xk3jz3ilxk7Tzgi6le/jyre8/ii2fjsjaDB5ujhEkuODQKm4f
         02E2CsfYEx0K3oPuLmnv64ZtI4Gn7dJVBeEkj1UYzBCfQ+hCyAx0neauOBrtIAf6SM2W
         hS58RBDiuOlhlhXBqqQVg+ycKJr3IpjHwK6exMRXLXlnh4zAhle9nZCK7NjdvD/JX3Zz
         rY0ko/uyF2dlZKAxo5VmAIV337XRyolpZdXe4IdaGnXRx2LoFyGqHDdhtIJCuLhg+GkV
         sW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776461790; x=1777066590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfbRBXQJE7XBqTPyM/9pBB24pVjmhOJfH/25m2T2XAw=;
        b=AfQASIraEgcNy3p9pUYmmi8NZC3Y5Fecsl4hNQMYwzsUSxJ8zpGNLUTd/I8ZfB1aBA
         WFxHGOv0/N87OIeYzSqYwx4tQd17jp1fcDdZUAptoLNMXtuuSPwIrPHzRecNscnhlJI3
         uJvFqYPCIC7XM6NvYQ+dClHJ7jSlUxsmWc3pBdF73Gi9Sc7XLURwiXKymf9ZRv+zJwRA
         P8M/rF2F6ZxcgXFh4gpXfrdi1ZTLY8/TU3Q1o0Jk5R7aLMU3LeVRuXNkirEFHg3MyJ7U
         od/dOTlfnY15oXg4YUmEI5uObYi8zPZ7CxTqF8i+dkj6V0V8zIBjUEXjStzB0EAJ/icI
         Lorg==
X-Forwarded-Encrypted: i=1; AFNElJ/voh6g8Ps2kFUEvANIwA5xvVpnB5HO0ESjwE3JZcBtO4FSoDuXjOGAu+h/8b8OzHwVr1+gER4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoBoI3Ru920rz9XIAiivrG+uX6kjUSoJbu3BSqffwfrerBbXoC
	7biBtz1sj4rufClqkLhKP211ZZPtWHgQGNKq78JeTjvlnZVOwWbFIMQOPm/jH35oh6sm/VHucV4
	SFZ2fXbYIQkhqdAz1rX07xDOuKEISuJtna3FqgJM3SI2BRE+KUCBj4IH6pQ==
X-Gm-Gg: AeBDieuS+SJn8Lpb3ZZDyk+RWJwi5JgusDhsskAHh78vaXZK6TQmSpxTQKTqz/hbUoU
	Ad/Uu2i3ZCJOMvUTil7tXPbt5RkQl6crYCmXeh48yiljRCWAoyNdC4nS01xcrstHt9t1XzhD5Ti
	WK4B1o6dP7txe5/hjtPQdt6cAFCh094qjgK2sIjQfZ2tbQlKauzZ/bDVnn4FikVsn5o6Bwi9MmW
	YYcqen6pc91McRSTdyieNZexIyCR7ktix9j+hrH9ZQZOdoZ3DdZKvYd5JyfoxNui4o/1wMA3/q0
	oVH9+qJInjS3q4QW7LgjB+jXb3CDAmFeNqbXqlxQd5gKBdTUkFtmuqEpasotmfv00hglM4PISc1
	Ns1KHrmX5niTseofRCmUToBoivlMC7InCqTiEUAhnWBjTgaKbiLGo6GylBoqY3Rql
X-Received: by 2002:a05:622a:1650:b0:50b:2eef:c8fb with SMTP id d75a77b69052e-50e36effb95mr67588471cf.56.1776461789556;
        Fri, 17 Apr 2026 14:36:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1650:b0:50b:2eef:c8fb with SMTP id d75a77b69052e-50e36effb95mr67588171cf.56.1776461789124;
        Fri, 17 Apr 2026 14:36:29 -0700 (PDT)
Received: from jkangas-thinkpadp1gen3.rmtuswa.csb ([2601:1c2:4400:6bf0:7677:bcee:4ef0:e09d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e393ff941sm20825251cf.19.2026.04.17.14.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 14:36:28 -0700 (PDT)
Date: Fri, 17 Apr 2026 14:36:25 -0700
From: Jared Kangas <jkangas@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
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
Message-ID: <aeKn2dvOOO43zdev@jkangas-thinkpadp1gen3.rmtuswa.csb>
References: <cover.1769764941.git.dan.carpenter@linaro.org>
 <0e922537c02d1c47734142090f98eb78e921ed34.1769764941.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e922537c02d1c47734142090f98eb78e921ed34.1769764941.git.dan.carpenter@linaro.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,kernel.org,lists.infradead.org,lists.linux.dev,vger.kernel.org,linaro.org];
	TAGGED_FROM(0.00)[bounces-279433-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkangas@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[64.7.192.0:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[4007c000:email,jkangas-thinkpadp1gen3.rmtuswa.csb:mid,4033c000:email,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,400a4000:email]
X-Rspamd-Queue-Id: 6F03441EBC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dan,

On Fri, Jan 30, 2026 at 04:19:52PM +0300, Dan Carpenter wrote:
> Add the GPR syscon region for the s32 chipset.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>
> [snip]
>
> diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> index e314f3c7d61d..be03db737384 100644
> --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> @@ -383,6 +383,11 @@ usdhc0-200mhz-grp4 {
>  			};
>  		};
>  
> +		gpr: syscon@4007c000 {
> +			compatible = "nxp,s32g3-gpr", "syscon";
> +			reg = <0x4007c000 0x3000>;
> +		};
> +
>  		ocotp: nvmem@400a4000 {
>  			compatible = "nxp,s32g3-ocotp", "nxp,s32g2-ocotp";
>  			reg = <0x400a4000 0x400>;
> @@ -808,6 +813,7 @@ gmac0: ethernet@4033c000 {
>  			compatible = "nxp,s32g2-dwmac";
>  			reg = <0x4033c000 0x2000>, /* gmac IP */
>  			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> +			nxp,phy-sel = <&gpr 0x4>;
>  			interrupt-parent = <&gic>;
>  			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "macirq";

I gave this a test on an S32G-VNP-RDB3 and didn't see any issues on the
dwmac-s32 side, but this appears to trigger a panic when reading the new
debugfs regmap/*/registers file for the syscon node:

    # grep 4007c000 /proc/vmallocinfo
    0xffff800083da8000-0xffff800083dac000   16384 ioremap_prot+0x74/0xe0 phys=0x000000004007c000 ioremap
    # cat /sys/kernel/debug/regmap/dummy-syscon@0x000000004007c000/registers
    Internal error: synchronous external abort: 0000000096000210 [#1]  SMP
    [...]
    CPU: 0 UID: 0 PID: 4344 Comm: cat Tainted: G   M        E  X   ------  ---  6.12.0+ #226 PREEMPT_RT
    Tainted: [M]=MACHINE_CHECK, [E]=UNSIGNED_MODULE, [X]=AUX
    [...]
    pc : regmap_mmio_read32le+0x44/0xa0
    lr : regmap_mmio_read32le+0x44/0xa0
    [...]
    x23: ffff00080c080000 x22: ffff000802ac4c00 x21: ffff800087b13c9c
    x20: ffff800080a46494 x19: ffff800083da810c x18: 0000000000000004
    [...]
    x5 : ffff800080a46448 x4 : ffff800083da8000 x3 : ffff800080a46494
    x2 : ffff800080a47230 x1 : ffff800083da810c x0 : 0000000000000020
    Call trace:
     regmap_mmio_read32le+0x44/0xa0 (P)
     regmap_mmio_read+0x4c/0x80
     [...]
    Code: 52800400 8b214093 aa1303e1 97f4caf0 (b9400275)
    ---[ end trace 0000000000000000 ]---
    Kernel panic - not syncing: synchronous external abort: Fatal exception

Running this through decodecode gives:

    All code
    ========
       0:   52800400        mov     w0, #0x20                       // #32
       4:   8b214093        add     x19, x4, w1, uxtw
       8:   aa1303e1        mov     x1, x19
       c:   97f4caf0        bl      0xffffffffffd32bcc
      10:*  b9400275        ldr     w21, [x19]              <-- trapping instruction

    Code starting with the faulting instruction
    ===========================================
       0:   b9400275        ldr     w21, [x19]

x19's offset from the base address in /proc/vmallocinfo is 0x10c, which
points to a bad read at physical address 0x4007c10c; I also confirmed
that the preceding memory reads back without issues:

    # head -c 990 /sys/kernel/debug/regmap/dummy-syscon@0x000000004007c000/registers | tail -1
    0104: 00000000
    # head -c 1005 /sys/kernel/debug/regmap/dummy-syscon@0x000000004007c000/registers | tail -1
    0108: 00000000
    # head -c 1020 /sys/kernel/debug/regmap/dummy-syscon@0x000000004007c000/registers | tail -1
    <panic>

Best,
Jared


