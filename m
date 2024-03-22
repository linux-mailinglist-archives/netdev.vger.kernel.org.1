Return-Path: <netdev+bounces-81324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373C588739A
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 20:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A721C20944
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5247E77649;
	Fri, 22 Mar 2024 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp7OSOtd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017377645
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134597; cv=none; b=BYwbhm7sQf4bMDXWUgYixKEvFyjyA8G9idX7UjxrdNbj6Ne1A3oy4GWVbuau89kj8wab5WpmcuhQ0ZulDC2Ay7DWTohIfYK9pwwHc4RYuFQsEyYMx+UlbtxOuZNC5Nj3K+t2ZcIYncNmTKQtzDXnvTn1IE++lX5/RBrFOH81UFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134597; c=relaxed/simple;
	bh=Dii4B/GDONqZC92D2Yx3ZUE86PZgNfy0Sq1RFO1tg4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3ukf0LqCGGevcGBFoMj7t+0bxzJQ9Ut4a3te7kaWlEBQlnvYX2BAU64iLQdz+1cfUk/bF3fw3N73RRx9+p+z8iqGLZ5o8XZR7JRIP3h0Z+qcJ8zPO4RtMyQkcQmiV1HDE76fSK197Cqk2PDed8VaN3VQoqJRrAxXGkIbeQFNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp7OSOtd; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso4336838e87.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711134594; x=1711739394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HSQr+CLd9lHiwoJr1IAPlmNPUSAVt2q0xRHLwbhYjjA=;
        b=Jp7OSOtdD2IKjCkrY8vHYu0L43gQrrDjL7cANFEAmDXU99TLT2XVv4CudxXWp4+pzM
         8HRD1GTLUGdyx4WTuxuIsaE+daWg+xPVh+22SAzfLqe/LdNSKIxW46AJGJTqRlc5VO0Y
         ddEQ7qKZ7pRBDt4ZcsJlnI3HI12hZgxSFdMUzu0no/mH+19swFZ4w9dqEBi03RfouFr0
         rERlBfusVSt0nihDxjmMRfpco5Vj+K1Qk0yY1xi9HbxPhGS3vTBwkFsiv8hQBZjG+cKq
         md5Z8XQMuvlKhvyJ7Wgc5+xfU+/43Zj4m5aekXBmNfflY3rjXEk7Z3lJAtlic2N3kJhB
         r2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711134594; x=1711739394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSQr+CLd9lHiwoJr1IAPlmNPUSAVt2q0xRHLwbhYjjA=;
        b=AJe8y9XoGfgMqyhAWIm39OePOWFc7Cpe9xlSg8nqxb0zM2WWlKzyOJ7B2DQ6ZjShpg
         uFAmawYIEPl46oPIijDiqT5vf9fDwTrdMmQT65tK3XVDVok+74CxYwwOmhEIrWE7Fe8m
         osbJ+7/fbUSa/z+YOYeCWiKphxtrIKr+F6HdANktFczgdkiKvyhMFHS0+fFefM69sghV
         e4hf5lb2eeIvj7g599WKKuUieeIV1L9Yv7PYbkCayzFczmi7z0YYy1uYNDK90eqsg5vR
         2RJV/mUcai6ChhjEAx2+ukJG2p29bafNGhzohJrqBoxCQ/6W7WCNeJ8OHwFf8vSkYGmb
         tInA==
X-Forwarded-Encrypted: i=1; AJvYcCWWpkOkk9jdXlXmBaVKA46F0eRPS+IEw2jorkToeX+xVny4STT8GAUlix7gsO8J/UAWkPV7H+uxjvt8Iqih7bmNcRbIppTF
X-Gm-Message-State: AOJu0Ywar0rfw1NKR/O9C9VZUCqCFYSBPQqWdPcGFcozrt7AiIDFbroY
	vqDCP2Xui8KDEMcj+SEnbuuGYbfFklT1wKCeiYtN/D6MocoH23zZ
X-Google-Smtp-Source: AGHT+IFX1ZsCoA1KgyTR9M6iC3tUcJcepoxzDlNp1KFkacedLDBAih7SLNb9xkSvXxO2BDK75MLS9A==
X-Received: by 2002:a19:9108:0:b0:513:e6db:5bee with SMTP id t8-20020a199108000000b00513e6db5beemr274032lfd.64.1711134593556;
        Fri, 22 Mar 2024 12:09:53 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id u20-20020a196a14000000b005159eaf5c35sm15833lfu.276.2024.03.22.12.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 12:09:52 -0700 (PDT)
Date: Fri, 22 Mar 2024 22:09:50 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET
 support
Message-ID: <2lljn7cqgnh3l3mfr3h6ztgs3bk4vqziavicij2ak4guiup6v4@y47wrn5arodt>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <027b4ee29d4d7c8a22d2f5c551f5c21ced3fb046.1706601050.git.siyanteng@loongson.cn>
 <ftqxjh67a7s4iprpiuw5xxmncj3bveezf5vust7cej3kowwcvj@m7nqrxq7oe2f>
 <d0e56c9b-9549-4061-8e44-2504b6b96897@loongson.cn>
 <466f138d-0baa-4a86-88af-c690105e650e@loongson.cn>
 <x6wwfvuzqpzfzstb3l5adp354z2buevo35advv7q347gnmo3zn@vfzwca5fafd3>
 <a9958d92-41da-4c3a-8c57-615158c3c8a2@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9958d92-41da-4c3a-8c57-615158c3c8a2@loongson.cn>

On Thu, Mar 21, 2024 at 05:13:45PM +0800, Yanteng Si wrote:
> 
> 在 2024/3/19 23:03, Serge Semin 写道:
> > > > > >   >> +static int loongson_gnet_data(struct pci_dev *pdev,
> > > > > > +			      struct plat_stmmacenet_data *plat)
> > > > > > +{
> > > > > > +	loongson_default_data(pdev, plat);
> > > > > > +
> > > > > > +	plat->multicast_filter_bins = 256;
> > > > > > +
> > > > > > +	plat->mdio_bus_data->phy_mask =  ~(u32)BIT(2);
> > > > > > +
> > > > > > +	plat->phy_addr = 2;
> > > > > > +	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
> > > > > Are you sure PHY-interface is supposed to be defined as "internal"?
> > > > Yes, because the gnet hardware has a integrated PHY, so we set it to internal，
> > > > 
> ...
> > kdoc in "include/linux/phy.h" defines the PHY_INTERFACE_MODE_INTERNAL
> > mode as for a case of the MAC and PHY being combined. IIUC it's
> > reserved for a case when you can't determine actual interface between
> > the MAC and PHY. Is it your case? Are you sure the interface between
> > MAC and PHY isn't something like GMII/RGMII/etc?
> Hmmm. the interface between MAC and PHY is GMII, so let's use
> 

> PHY_INTERFACE_MODE_GMII?

If MAC<->PHY interface is GMII, then PHY_INTERFACE_MODE_GMII should be
used to indicate that.

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 

