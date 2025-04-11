Return-Path: <netdev+bounces-181755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6F8A865CF
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE2F1777B1
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09726F450;
	Fri, 11 Apr 2025 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGWB7rMd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18D182B7
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744397676; cv=none; b=cGHkn+zGfbQ9jKDGtgtj/4e5ZhLcp//bkXis0CSV/MiAwkJcOoNPdmh4yJTm146c+X8q8fhpJCdy9YOa8dkxt8mbAv/jM7AqehrFFTo6Ss/y8FN4ov7gM3H3mvnsNjTDNfOLZSbAEdNjvPzE+PgBuG02EQ4SinzhhuVLpzNoDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744397676; c=relaxed/simple;
	bh=E9tub37qIsRg8mxDMZKrIlR9HIEDicz/Jj5u8DH7+o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHu3RfNmpwNMLkQuRtlFNwOPeJzikXWhV6gFpFmURU2pjtYZxoRLyrJG3If20dDMODruVvAx1oT5Rgdsk0Qp2OziatgkY3dSUys/3DlI5Afcy5CockhsI5obi9h/jtD6VbGFea5KrcFbz6W9W+MxykxJDtds56LCOFzwAfZguFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGWB7rMd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c2688e2bbso200897f8f.1
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744397673; x=1745002473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QXk1kHlRLRrzch1OptFRzVqFH3H73+Kcq9x/qWUSD8=;
        b=iGWB7rMdx6iNNEeJwKut+iekk1i/vccfNY8YqBIAQyrOrRGfBfav8/I8pOM2lClPrh
         +jrWJsg8TZF1BCSwGfc6Pln+16Cinh0zO2/gM5exjCycbUDyqXPltdmcCjJybGChgeiv
         mM4HxrUOCxUrEE2yMbViX0eU2N564VeApBFbnIeVHCsAGnLFA10/fCG/nnnoRbicLOhu
         ngnn/rgs5oKVvrKdluZWIW7E8D3Zgams/OlHkgHwy6qdeieePoR1DCcW0W5j7dVpE0fp
         UCSIm3uGwLVPHm0ONBg7PJeZWSetozKHh9IWnIdCJvS5DEKkcagHaDnDUqVhBa4aknkT
         7utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744397673; x=1745002473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QXk1kHlRLRrzch1OptFRzVqFH3H73+Kcq9x/qWUSD8=;
        b=meqf8bFQzt5233SnUG4Uy++XUFu9ucpeE8LJ6qljqBXvuasHThSYEIrDBQP8GY0TeQ
         3AEThX13C124jEzQS2dd/qe+mr5f6hOAJAGn/yo14FO0Viydv7oAs6IizyN9NkJ0a2fP
         /HbADrLiLRkltrWp5ba/dJ9no2pI2CHMQ/SK/yEd5Eusi7d8ke71jmONoOf9uoVlmJlA
         qnOkvl+cDfKw35QtSK2ZDn8xuO8yJF89W/ha6BScFy5dr98K08ihs9AiPEqtp50lSbjs
         svyy3gW186U3+leye8Lm52HQWlxxHUlRKeIARjF91W84vDPaASQaHtd3Iwow3OiBVeU+
         UbQQ==
X-Gm-Message-State: AOJu0YydCYoKv45MOABd4fx9gUUaqfWdt4lVSqrxNU/ULsZHMhhKjCjF
	3mIDv51NeuWvitSti+5v4SEknGcHA0ziSY26vNSgcXmOUX42ML7A
X-Gm-Gg: ASbGncsurta0ytpsT7uG/n/mcBfL5T5W4BcNG0lKdAv1M5Vi8zsFApX9eh0zYy/nKPE
	Tf3VcTEltm7VxAnyOacx9T7XbrPI7l1eT3eyEqNgWnBxvSx7vM2l58x1wZ899z2NYfcfTyD2ZXj
	jBuJmHeWDnMiBxJL33Jo61KnXj3w2JBuiqmdMHm1/hOrxhLa6tNDP4p6l9Hx0s1FKbII8TDh3yW
	3q9raY8j2fNRH6P8UYru4I4kxokOElGDMYLNM8tbC+iYTPI42uKumO4yZ/4AljV7Ic6wMXjZkK2
	lqJgJT0ZouLPMU+8ByV/srd6Pl9D
X-Google-Smtp-Source: AGHT+IHmuYu+e51bTOnhw9WIlDxYOGxvzaxxyaDznaLbT0vzGBfHTQmXtdHYw+2roGMvhOs5TB/lCA==
X-Received: by 2002:a05:6000:1acf:b0:394:d0c3:da7a with SMTP id ffacd0b85a97d-39ea51f25a8mr1099521f8f.3.1744397672942;
        Fri, 11 Apr 2025 11:54:32 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf4458a8sm2946992f8f.99.2025.04.11.11.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 11:54:32 -0700 (PDT)
Date: Fri, 11 Apr 2025 21:54:30 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [BUG] unbinding mv88e6xxx device spews
Message-ID: <20250411185430.ywnlnkba4jyb7rie@skbuf>
References: <Z_lRkMlTJ1KQ0kVX@shell.armlinux.org.uk>
 <20250411180159.ukhejcmuqd3ypewl@skbuf>
 <Z_li8Bj8bD4-BYKQ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_li8Bj8bD4-BYKQ@shell.armlinux.org.uk>

On Fri, Apr 11, 2025 at 07:44:00PM +0100, Russell King (Oracle) wrote:
> On Fri, Apr 11, 2025 at 09:01:59PM +0300, Vladimir Oltean wrote:
> > On Fri, Apr 11, 2025 at 06:29:52PM +0100, Russell King (Oracle) wrote:
> > > Hi,
> > > 
> > > Unbinding a mv88e6xxx device spews thusly:
> > 
> > Odd. I never saw this on the 6190 and 6390 I've been testing on, and I
> > think I know why. Could you please confirm that the attached patch fixes
> > the issue?
> 
> What else can go wrong... well, the build PC can inexplicably lose
> power just before it transfers the kernel to the TFTP server and
> modules to the target... yep, it's one of those days that if something
> can go wrong it will go wrong. I'm expecting a meteorite to destroy
> the earth in the next few minutes.
> 
> Your patch seems to fix that issue, so:
> 
> Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks for testing.

> but... of course there's another issue buried beneath:
> 
> [   73.552305] WARNING: CPU: 0 PID: 398 at net/dsa/dsa.c:1486 dsa_switch_release_ports+0x114/0x118 [dsa_core]
> [   73.562504] Modules linked in: caam_jr ofpart caamhash_desc caamalg_desc reset_gpio tag_dsa crypto_engine cmdlinepart authenc libdes i2c_mux_pca954x lm75 at24 mv88e6xxx spi_nor mtd dsa_core eeprom_93xx46 caam vf610_adc error industrialio_triggered_buffer fsl_edma kfifo_buf virt_dma spi_gpio sfp spi_bitbang iio_hwmon sff mdio_mux_gpio mdio_i2c industrialio mdio_mux rpcsec_gss_krb5 auth_rpcgss
> [   73.597676] CPU: 0 UID: 0 PID: 398 Comm: bash Tainted: G        W          6.14.0+ #966
> [   73.597716] Tainted: [W]=WARN
> [   73.597724] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
> [   73.597737] Call trace:
> [   73.597758] [<c0009c44>] (unwind_backtrace) from [<c0022b78>] (show_stack+0x10/0x14)
> [   73.597849] [<c0022b78>] (show_stack) from [<c0019b5c>] (dump_stack_lvl+0x50/0x64)
> [   73.597921] [<c0019b5c>] (dump_stack_lvl) from [<c0043cd4>] (__warn+0x80/0x128)
> [   73.597986] [<c0043cd4>] (__warn) from [<c0043ee4>] (warn_slowpath_fmt+0x168/0x16c)
> [   73.598034] [<c0043ee4>] (warn_slowpath_fmt) from [<bf0b8764>] (dsa_switch_release_ports+0x114/0x118 [dsa_core])
> [   73.598297] [<bf0b8764>] (dsa_switch_release_ports [dsa_core]) from [<bf0b929c>] (dsa_unregister_switch+0x28/0x184 [dsa_core])
> [   73.598654] [<bf0b929c>] (dsa_unregister_switch [dsa_core]) from [<bf105b30>] (mv88e6xxx_remove+0x34/0xbc [mv88e6xxx])
> [   73.599326] [<bf105b30>] (mv88e6xxx_remove [mv88e6xxx]) from [<c066f838>] (mdio_remove+0x1c/0x30)
> [   73.599577] [<c066f838>] (mdio_remove) from [<c05e15f8>] (device_release_driver_internal+0x180/0x1f4)
> [   73.599666] [<c05e15f8>] (device_release_driver_internal) from [<c05df3bc>] (unbind_store+0x54/0x90)
> [   73.599726] [<c05df3bc>] (unbind_store) from [<c02f9388>] (kernfs_fop_write_iter+0x10c/0x1cc)
> [   73.599790] [<c02f9388>] (kernfs_fop_write_iter) from [<c02608a4>] (vfs_write+0x2a4/0x3dc)
> [   73.599839] [<c02608a4>] (vfs_write) from [<c0260adc>] (ksys_write+0x50/0xac)
> [   73.599876] [<c0260adc>] (ksys_write) from [<c0008320>] (ret_fast_syscall+0x0/0x54)
> [   73.599912] Exception stack(0xe0b25fa8 to 0xe0b25ff0)
> [   73.599940] 5fa0:                   00000010 024dd820 00000001 024dd820 00000010 00000001
> [   73.599964] 5fc0: 00000010 024dd820 b6bb5d50 00000004 00000010 0055db68 00000000 00000000
> [   73.599982] 5fe0: 00000004 bea469a0 b6b4e3fb b6ac7656
> [   73.767849] ---[ end trace 0000000000000000 ]---
> bash-5.0# [   74.466821] fec 400d0000.ethernet eth0: Graceful transmit stop did not complete!
> [   74.474953] fec 400d0000.ethernet eth0: Link is Down
> 
> which seems to be due to:
> 
>                 WARN_ON(!list_empty(&dp->vlans));
> 
> This is probably due to the other issue I reported:
> 
> [   44.485597] br0: port 9(optical2) entered disabled state
> [   44.498847] br0: port 9(optical2) failed to delete vlan 1: -ENOENT
> [   44.505353] ------------[ cut here ]------------
> [   44.510052] WARNING: CPU: 0 PID: 438 at net/bridge/br_vlan.c:433 nbp_vlan_flu
> sh+0xc0/0xc4

No, they're not related. This is the third one, and I already know about it,
but it's relatively harmless.  Since I knocked down 2 already, let me
just go and take care of this one as well.

