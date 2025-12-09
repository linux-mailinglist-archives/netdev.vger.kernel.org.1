Return-Path: <netdev+bounces-244085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 954A2CAF7E9
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 10:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE7D83054CBE
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D9B2F60A4;
	Tue,  9 Dec 2025 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAOqwt/I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7F28FFE7
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273479; cv=none; b=eISSmb3+FZcRtf5HBvdhXL1oO2GheVAwShyq1BEPHPKOj+M64MYxCzlVk/+DDPvBp4trNGfjfhdFI058AsPnj2b5ALb/g81Cw9thFtH48MV/dOKfRhCYmCxHqg2VtMiGdvRyh1l2lH/E8o9p9pKvJ/XUcLxj0hcDvsLsRytejAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273479; c=relaxed/simple;
	bh=8vdv4yr8ba5Mi4hoItSJoOgm+sx3gDJTt66t3a7BHyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAa0Xm1OUMT2wDFPnTCj4T2YpyHes/2taYNezt1YQYvXWCMrONpzwU/KpCwSLIoXZ5RJA/L4A7uWyg42kv3ww7cgNz/T8/AQ02N1eAUJLbh3W8Is3AkZAtxpAtOmc+Rns8s1Ib2xH+1Z7RqPuuuYTHmupRAL1hRyauS8HH0f3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAOqwt/I; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so2523327f8f.0
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 01:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765273476; x=1765878276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTFO6ZSVbqg5cNw3sne2kKUbTWQNeVaUcpcLa/7h/qo=;
        b=bAOqwt/IYqF6oG8i8/v6a5PdK3yoIxBSoGS1cCcfxQQpfQ6B7hJU7AXJ1zcitb35p6
         CBxcvua4BnxDapiT4gXl1I6FEMyVU8QZVC5lFwrybRlB1lk2u8PCXda9u5fFNAJvwMt2
         KanAxLwvyWwRpuk4FJ7cq07rz6d+ycDe/xhcG7u2FFQkvqJ1LRJGagR/3F3fDRqQ9h8x
         cwsAc44P/0hCyQKAaZOVRifGN8DpFOhre27gn1dB6I16n6ThvktljwUNXLnaQ4TNrgDy
         7tmjqfR3aAgD3gGaKauSdMftJeSOutT9OXlnv0JI1qKKXJOD1gMFKSohygb1Knpd1RZj
         C3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765273476; x=1765878276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eTFO6ZSVbqg5cNw3sne2kKUbTWQNeVaUcpcLa/7h/qo=;
        b=sYJiE9KPoiGGxoZp6jbZIzUWF5M11gb1AyXlcRLFrn/gtMs9iBycJPtuFi6wrfVZ3J
         9GTYneKi61J1SwkJK/Lwhfqibpq/ZriszupRRy3jr1LxwGpBb80As4UnQWwK9huZIoXk
         Hz3rysWSTBCbQK2wqFW4y612batlcuS5L70gPcXIERuQ1tBIqt+JESnEjLYbbzh3bkiV
         rvaIGU56uZX4UQxTw6crE5sUeuq9lUOSweR9QmqrRiM/UnliwYs2t93Io3xR23NgZaq6
         KLWvj3y72nwme95+dg3HdRmwmmTTWuF7+pEaLfl3S+WI7NJVGKd4YYSA17mKLX/ajOuy
         L6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCX/uIrb6UHAjUGL4lZQvJv7OfSRi/jbmN5P1uwgWVP9rh9GL6o7+e9rmNv1JUWEVBHGgIyvA8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPUE1if78hVzW4bzDd9/Z/mmC/4HDrkzbH6kI2yO1awu2kQXaF
	ly+JeveTaU35dTudqC+XQHFkYSobc5v2ilI9aPYzKNhpGVxFsU8N+Ior
X-Gm-Gg: AY/fxX7yfyc4RplQ1Hk5VVVBWUze5KmaM9w4bC4ZJOt44nkPgh7l2s6bqUPRjrOUoK3
	bpb5Tk/pByyOqD5mtix12L+YJMTFiQHYZSDgavPdQlXrAB5adCPO28jCeD4BgUAt6J532itKrLK
	bTvTnLpRrZUkTG4xN/csICYR7HJxPb4XpRQ0nWFdVCqeDYUP2yXEuwmFCARys1KpLnT6hKl+oaq
	aSzK3dlVXBajKp0BguIdhJR7yvIaBbROabv/pvAwtth9ZClRdALB0hexj+9/DOCE2HRIZ+10lfY
	/QsHynvhQvtJhX3nOGX4aSi6TEQnfDbavzcu4QLEWerUpEe4ITjY3NAMzTssbrmcilQgqbE9DvB
	OjmNq4/YOJTMXDHZQl7x5X5F0b2OnLdigekpx6btTLwFOyT4OsoVAYQdfatKn4NrNO94T2Im5g7
	8SnPZ0XkqDf7Ts0Ip+F/hAh+75/QRXHg41HH/MDmp6Lo33STds6XeN
X-Google-Smtp-Source: AGHT+IHrJDrWaABHIRTeuvG2zFhXIU+ST2jOsXds0P3glgaBQZcSHGkgwT0Qbc1qhO2zyeSs/kfp/w==
X-Received: by 2002:a5d:6952:0:b0:42f:8816:ee6d with SMTP id ffacd0b85a97d-42fa091ec48mr832773f8f.31.1765273476003;
        Tue, 09 Dec 2025 01:44:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeae9sm30973774f8f.13.2025.12.09.01.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 01:44:35 -0800 (PST)
Date: Tue, 9 Dec 2025 09:44:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Simon
 Horman <simon.horman@netronome.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 0/9] bitfield: tidy up bitfield.h
Message-ID: <20251209094433.768a76ae@pumpkin>
In-Reply-To: <20251209070806.GB2275908@black.igk.intel.com>
References: <20251208224250.536159-1-david.laight.linux@gmail.com>
	<20251209070806.GB2275908@black.igk.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Dec 2025 08:08:06 +0100
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi David,
> 
> On Mon, Dec 08, 2025 at 10:42:41PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > I noticed some very long (18KB) error messages from the compiler.
> > Turned out they were errors on lines that passed GENMASK() to FIELD_PREP().
> > Since most of the #defines are already statement functions the values
> > can be copied to locals so the actual parameters only get expanded once.
> > 
> > The 'bloat' is reduced further by using a simple test to ensure 'reg'
> > is large enough, slightly simplifying the test for constant 'val' and
> > only checking 'reg' and 'val' when the parameters are present.
> > 
> > The first two patches are slightly problematic.
> > 
> > drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c manages to use
> > a #define that should be an internal to bitfield.h, the changed file
> > is actually more similar to the previous version.
> > 
> > drivers/thunderbolt/tb.h passes a bifield to FIELD_GET(), these can't
> > be used with sizeof or __auto_type. The usual solution is to add zero,
> > but that can't be done in FIELD_GET() because it doesn't want the value
> > promoted to 'int' (no idea how _Generic() treated it.)
> > The fix is just to add zero at the call site.
> > (The bitfield seems to be in a structure rad from hardware - no idea
> > how that works on BE (or any LE that uses an unusual order for bitfields.)  
> 
> Okay but can you CC me the actual patch too? I only got the cover letter
> ;-)

Ah, sorry I'd changed the git settings..
I'll resend it all.

	David

