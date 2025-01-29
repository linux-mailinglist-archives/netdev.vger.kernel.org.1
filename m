Return-Path: <netdev+bounces-161568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F738A226B8
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3941887A48
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 23:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FC21B2182;
	Wed, 29 Jan 2025 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4LNlWQ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A699418FDCE;
	Wed, 29 Jan 2025 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738191957; cv=none; b=gTcUH6Argbn20hh4AkfuZE8roS7pvEu55P9ErJMD7mDpxNMglpO0me+foPWljtei22hSJZr/UsbsykxcBA/WsIAAlC8khwCkwJpsGBN0dKwkYz2N+D/PHXjKEwygxGZ1lMtb050g3F+7n73joeEdPlTX14CtZOSc+T9tXwU4xaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738191957; c=relaxed/simple;
	bh=eGB7EU0+KT3Ap1+TnHRMG1ml3S6am1E5snFCowyRa28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARWVmWeecphKwR2ta8zx8/OZ4yAMZq7zujl2g5BSK9F9kESpnbgwUX+Wnu2b3AfpZKDeYNZPmr48cY4LgOcy1NoNweu57i1FNyai1/GfzU08hn1d7bTir8ioLd+c27Z5vQqk48ck7KHuhqZRuqx1usvoP2efIiZp+1fHTS10dBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4LNlWQ4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361f09be37so201635e9.1;
        Wed, 29 Jan 2025 15:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738191954; x=1738796754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vhJy7H4KcFCSsvJKzQUjNnHzXiiIoy2boSBlTP0erE=;
        b=m4LNlWQ4B+5gufu5cYinBv8vSOkbdjTiUBbHJ2Jtcoc7vuE47HVopzQIbVhiqR1g0k
         eOlPzhweFnwZZ+y/pVRc/NsxsE1PjGMxOaR5rLvQxAYqGCzio0uFjDmKr/pAvlf9lzrR
         2ZqT0C5qkC6HZtLM2NI22lrAhoR7pJ1LkGzJjiWyO4ymR4zNhihDxSw+oYsBlh3dTJnQ
         bDtqL6KkrHsFNEgm81rmFhsJlpwybQbSmYRZjyA8zXq3bp2I06vPlBupFfrjE+gJqCXR
         WGTdZWNTUkU0KA9ysjAkZV4b+emVWjM3i8/NiHSwVnY2OLsRhzp/CdrAUhGScS4M4kng
         jYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738191954; x=1738796754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vhJy7H4KcFCSsvJKzQUjNnHzXiiIoy2boSBlTP0erE=;
        b=mjdEdPACWSDbaoyx6ibvcA3jQnWBE3q71b0rvYR3oG05rcijjHwGhOZ49OkR0mww7d
         DNIIchs1XJVxkWos2Md8vTg4BDMsMDh6AD9rjZ/xtnTS5EOXnaqA6Us4oTkFQ6k/VAn7
         4ALzU2pPuSREl8quHAAjjahSF18CsBhFFW4xj4AUhKeJcs05kqiB2qkHOnefRQjfKwxX
         l83h6owAb7PMcetUdM0AGnPZeJu5XIqjUOJPMTp6BzI4OdNabd8Q776v6iaSOIolm/Da
         zXzNW8XxH1sYjNAHGgcdJJ6ZoEiwA4Zs4vuxfEgjLL91ss7HKpb/a4HgMIDkbKksBDTx
         x6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVreqvHhodBZGjHaXwM0eIbMi8zsnajxnfsdb9+NPnOk1XOdyyUiC2ZuqQxhXlaxYYc16DbU9Xb@vger.kernel.org, AJvYcCXwSX3JOCKdoAiYjGkHv7auG1voBHyYSJq8EYNHSkUytP51L6+EHfNzz3U3acijkL5sWCimk5Cstg3dMgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0K3Zo9ALdaq95EBqJY0RSIykSx+gPAZTGLWakuV87g/kd742d
	8jdZyT1Trifr1wJFtdy6Lx/iz7+oIlrUFa+9Oqwa26/xrP/8qTGw
X-Gm-Gg: ASbGncuEspO+WmGUuN+lGJtyIl60ldFM7bWqjnKix0DkDM0rUWVlJPvaHjQP3wwGX0D
	nxszVJQRhr0MEaUqjbGAwIjqfgRgIhUjQW/y2Ycsh64l9Fi2NvLC5/MOeBJqaI/yEJwGOKii/S2
	WNg/ABYmAa9DPt5lCc1F9aLoGFyQ30rPkImIa9qhODWKv7cMKMeizXqdJHteKwGVqdd9tnOkZrN
	EwgXKJmOyod7crnMVxj/BrY27KWIZazXtGVxA1qkRgvQA3zK9dPTyJAZxxxIApSJ16y8XrnIQ0x
	UEE=
X-Google-Smtp-Source: AGHT+IHIln2YpE/G8pTT0XOA/9jvLkrnHI6mJHDAhP1XgmTfQAo7KflnVCbfr/2N/VRnUoaG2yKdUg==
X-Received: by 2002:a05:6000:2c7:b0:385:e10a:4d9f with SMTP id ffacd0b85a97d-38c5166e54amr1710532f8f.0.1738191953755;
        Wed, 29 Jan 2025 15:05:53 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b5780sm138552f8f.67.2025.01.29.15.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 15:05:53 -0800 (PST)
Date: Thu, 30 Jan 2025 01:05:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Tristram.Ha@microchip.com, Woojung.Huh@microchip.com, andrew@lunn.ch,
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <20250129230549.kwkcxdn62mghdlx3@skbuf>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>

On Wed, Jan 29, 2025 at 10:05:20PM +0000, Russell King (Oracle) wrote:
> > > It does have the intended effect of separating SGMII and 1000BaseX modes
> > > in later versions.  And DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL is used along
> > > with it.  They are mutually exclusive.  For SGMII SFP
> > > DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW is set; for 1000BaseX SFP
> > > DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL is set.
> > 
> > It's difficult for me to understand what you are trying to communicate here.
> 
> I think it makes sense - MAC_AUTO_SW is meaningless in 1000base-X mode
> because the speed is fixed at 1G, whereas in Cisco SGMII MAC mode this
> bit allows the PCS to change its speed setting according to the AN
> result.

The bit which you've just explained is the only portion that made some
sense to me. What did not make sense was:

- What is the subject of the first sentence? "it has the intended effect
  of separating SGMII and 1000BaseX modes" <- who?

- "For 1000BaseX SFP, PHY_MODE_CTRL is set"? How come, and according to whom?
  PHY_MODE_CTRL, as I've previously pasted from the XPCS data book in a
  previous table, is a field which selects, while in SGMII PHY mode,
  whether the contents of the auto-negotiation code word comes from
  wires (when set to 1) or from registers (when set to 0).

For this second reply, I even went back to triple-check this, and I am
copying this additional sentence about PHY_MODE_CTRL.

| Note: This bit should be set only when XPCS is configured as
| SGMII/QSGMII PHY i.e., TX_CONFIG=1
| In other configurations, this field is reserved and read-only.

So it is very confusing to me that Tristram would be talking about
PHY_MODE_CTRL in the context of 1000Base-X. I don't know what this
denotes, but it just makes me question whether whatever he's been
calling 1000Base-X all along is something else entirely. This
"guessing what Tristram is trying to say" game is hard.

> For Vladimir: I've added four hacky patches that build on top of the
> large RFC series I sent earlier which add probably saner configuration
> for the SGMII code, hopefully making it more understandable in light
> of Wangxun's TXGBE using PHY mode there (they were adamant that their
> hardware requires it.) These do not address Tristram's issue.

Ok, let's sidetrack Tristram's thread, sure.

Patch 2: correct but

+	/* PHY_MODE_CTRL only applies for PHY-side SGMII. When PHY_MODE_CTRL
+	 * is set, the SGMII tx_config register bits 15 (link), 12 (duplex)
+	 * and 11:10 (speed) sent is derived from hardware inputs to the XPCS.
+	 * When clear, bit 15 comes from DW_VR_MII_AN_CTRL bit 4, bit 12 from
+	 * MII_ADVERTISE bit 5, and bits 11:10 from MII_BMCR speed bits. In
+	 * the latter case, some implementation documentatoin states that
                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                 integration documentation
+	 * MII_ADVERTISE must be written last.
+	 */

Patch 3: "DW_XPCS_SGMII_10_100_UNCHANGED" instead of "UNSET", maybe?
Maybe it's just me, but "unset" sounds like "set to 0"/"cleared".

Patch 4: same "documentatoin" typo.

Otherwise I think there is value in these clarification patches.

