Return-Path: <netdev+bounces-244280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A66CB3BF6
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 19:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E36F8302DB65
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 18:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C544312815;
	Wed, 10 Dec 2025 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcRY/Epd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581321767D
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765390820; cv=none; b=bHu0ggzcOMRXToIKXmvOSB2QqnzlbokeGQgf8DJndgzYbsVgkvGPQ4F5VEIQqzkVfKubAbOEVv2ddwcK8BA4zNSYT+J5P+0OU/+anzsFqqdvZ0p1ZiMmZ0e5EOl2TNf9gbPfUCEMq39Ra16247D28OXk4FW6MbrBf/Y61d6dKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765390820; c=relaxed/simple;
	bh=OMUV2lsVO0vgVB97nGcWM2iaIieqmLn31V/i6wQ/4Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sazOpQb1lR6hiYiYgER9fMXpIJ7SQZDLX+45hqosVCY5+bac7QR3Ms8jD0QkwGmGsBr8wWI7HMArCNFkPWNXJc1wQQhhMqhVDyQ7nVz4GERwrt3o3AesA1LLLgjcW+WR3cAY8BLop1i7b5wpUVSz0xuA6IjJFFqW/EQM8DKNk2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcRY/Epd; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78d6a3c3b77so1515637b3.0
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 10:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765390817; x=1765995617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=26ZykUE68kYzxY2osVKqbTWmByRt6J5f7oLz9O5oLCs=;
        b=UcRY/Epdkux9tCOuz/idsmMCeT5muwsywT4jVrD+B2GQfQ8dcxVr/khT7mYEDIURmy
         neRZXhcgeAvAwRheq/P4CmlilpZKnYEEGCusRG3u4NHpAArbuF8QtYxp++cud6McqbCc
         JHQ1TSG8pqEAQXOjfrIG5WRwGiA/BYXgB4LBMERPa4m41CZNfAycf0IRwsSWYbwRtWIH
         oMSlos0fuFf+kwCY8imNbAF1qQjc/xIgsGqctCHh1kpWPr9VoMesA+ecDmjrp4XAq2jx
         A1+VZlzNk2uq/x0tZF5/g/moaflrXL9TR7Q2BG4wH3hL7BimhddVFXWTfRxYi46zYtZb
         2qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765390817; x=1765995617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26ZykUE68kYzxY2osVKqbTWmByRt6J5f7oLz9O5oLCs=;
        b=bXw+VsZJpiOVK5G7MX8KxRbP7QBrB5vOj1AT1Es10LYO9pfFULDSvZDpolCBYihoSE
         /k9rPlfYxdKBD+M76wZ/wmJKc8wo2c2YbqqDNEDD0mgruYXRkY92NJGXalAbAGfxHU1V
         6HCJgs3eYvLhWwkNVMOKQS5e8KublFu1NJJgslUq69PQvR/BnKe/Np/O0XY3kY0Ige7n
         joRCxRVyWWvWjKYaoie3Aqs3zSP4sU68ZxYh8wmId4gF6NX/aDX08T7O9GRKnQ5i6s5H
         Mey0UUMgeOfXi/lo8id2BXDEYHvfsFZG0chvAXUmEQP6DBLJzGTDZfxuza/o+YmFA2b5
         cQdw==
X-Forwarded-Encrypted: i=1; AJvYcCUMyMWD7sB1utCKZEuEMpR28YjVixUWrzBceq+Bt8OHvYoB+4ZAPvwQlcW9Dj2v/x6gKNVQnU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZr3lnad7r57D1KUf0chXs6p6z0hiliGo99H++iadorpDHLTLW
	fi1lX5COhJ2V3EFs4j4ooW8jJ42TM5F6/cMNrlX2Z5BXRO5J2yACpHJB
X-Gm-Gg: AY/fxX66zkX2OAslgVG6pNcrPK7eBick7tRsqBkuFijMhew0FDwqfsfsij90lpKHELL
	sIKabdgeOe09kejxPsN4qV2fWRNN0a7Ll7YkTNacpYtbHfraHy710h1LLG9JZCBlYlQ4B+A1BrI
	+v0j1iBLG0My6yUehKu6bTD+V/gvssM1a47os+Bo3kZpwubHFV4IflVs7aDlKEdoEtJW/0H8DXu
	xvNAyPZFrNjcom4hEAFUFUk+oNVt0jf47ziGmC8+YEETqR2mRva/PH30VmdlJcFZmWB45VXvNI7
	Om9WDebb5CXE3cM8d7A2/Nqsv4cb+YC1DPmrwDJ96Hb6UKa1/24pMTWfGHDnWfxdigfmu54B5Ix
	W6Iz9NGAd6vSQkINWWx7WXCNmPq1EwQbaTMLgSYYQLbK3zh82SnpI3VYLyDrNQ93JbAi1nw5k3q
	jQApTeftc=
X-Google-Smtp-Source: AGHT+IG4pdaOgBhaD/ogNnuNZowdk6sXIUNM9GSwkyT/kLByNCRMGoQEZX93AEfCrKwGDkqhTH4aGQ==
X-Received: by 2002:a05:690e:4198:b0:641:f5bc:692e with SMTP id 956f58d0204a3-644785e41d6mr233379d50.39.1765390817101;
        Wed, 10 Dec 2025 10:20:17 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:74ed:2211:108a:e77a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477cca6bcsm179533d50.0.2025.12.10.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 10:20:16 -0800 (PST)
Date: Wed, 10 Dec 2025 13:20:16 -0500
From: Yury Norov <yury.norov@gmail.com>
To: david.laight.linux@gmail.com
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@netronome.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 0/9] bitfield: tidy up bitfield.h
Message-ID: <aTm54HCyCTm5k5ci@yury>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100313.2867-1-david.laight.linux@gmail.com>

On Tue, Dec 09, 2025 at 10:03:04AM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Re-send with patches going to everyone.
> (I'd forgotten I'd set 'ccCover = 0'.)

And this one again appeared in my spambox. Have you any ideas why?
 
> I noticed some very long (18KB) error messages from the compiler.
> Turned out they were errors on lines that passed GENMASK() to FIELD_PREP().
> Since most of the #defines are already statement functions the values
> can be copied to locals so the actual parameters only get expanded once.
> 
> The 'bloat' is reduced further by using a simple test to ensure 'reg'
> is large enough, slightly simplifying the test for constant 'val' and
> only checking 'reg' and 'val' when the parameters are present.

So, can you share the before/after?

> The first two patches are slightly problematic.
> 
> drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c manages to use
> a #define that should be an internal to bitfield.h, the changed file
> is actually more similar to the previous version.
> 
> drivers/thunderbolt/tb.h passes a bifield to FIELD_GET(), these can't
> be used with sizeof or __auto_type. The usual solution is to add zero,
> but that can't be done in FIELD_GET() because it doesn't want the value
> promoted to 'int' (no idea how _Generic() treated it.)
> The fix is just to add zero at the call site.
> (The bitfield seems to be in a structure rad from hardware - no idea
> how that works on BE (or any LE that uses an unusual order for bitfields.)
> 
> Both changes may need to to through the same tree as the header file changes.
> 
> The changes are based on 'next' and contain the addition of field_prep()
> and field_get() for non-constant values.
> 
> I also know it is the merge window.
> I expect to be generating a v2 in the new year (someone always has a comment).
> 
> David Laight (9):
>   nfp: Call FIELD_PREP() in NFP_ETH_SET_BIT_CONFIG() wrapper
>   thunderblot: Don't pass a bitfield to FIELD_GET
>   bitmap: Use FIELD_PREP() in expansion of FIELD_PREP_WM16()
>   bitfield: Copy #define parameters to locals
>   bitfield: FIELD_MODIFY: Only do a single read/write on the target
>   bitfield: Update sanity checks
>   bitfield: Reduce indentation
>   bitfield: Add comment block for the host/fixed endian functions
>   bitfield: Update comments for le/be functions
> 
>  .../netronome/nfp/nfpcore/nfp_nsp_eth.c       |  16 +-
>  drivers/thunderbolt/tb.h                      |   2 +-
>  include/linux/bitfield.h                      | 278 ++++++++++--------
>  include/linux/hw_bitfield.h                   |  17 +-
>  4 files changed, 166 insertions(+), 147 deletions(-)
> 
> -- 
> 2.39.5

