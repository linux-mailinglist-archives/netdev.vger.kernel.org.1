Return-Path: <netdev+bounces-244158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C10ECB0DFB
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 19:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AF45301510E
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 18:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE73303A1A;
	Tue,  9 Dec 2025 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgmPErcd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098F22FBDF5
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765306497; cv=none; b=ZwZpm4xbqC9C6f8R+h5kRZMjEKdIFf+T1Nhywbde/fvw7NDeU+uNZPQ6FLEz/KYJRkmwxHDNYPyS5rK0EIekBAE0oqcF/KDoA4rzHu9s0hoPaDi29lMJGuzi09OrsY14Y2oaXjx+0qC6auhPzZMANtx1nRa96pXcGHByY3IVJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765306497; c=relaxed/simple;
	bh=oxnsSzSSQAu/Bk/v2zSRSRpD8UW0cATc07H6GarnzDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrVO4PhXhCDzvosam8x/xiCZ/N80GzdjXpeUpqFZCuKlhlmrHGiKiTgUjTbhH2SeK4HvOCLEC/jgUh6a+3/f5sw5CQtYJBKyB85E3MHFXSuiJ1eTujw4ovaseGu+VXfGjqVX8Cb6aZmEMbZ6sfxZJkdGo1ZLDxrKOkOpR6zTClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgmPErcd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so51557355e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 10:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765306494; x=1765911294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpdLUaMszOte+9P9trLbr49o0T/8IL0zVkv1y9a6ACQ=;
        b=hgmPErcdpbOmWNv97DFI6MjvwovMomPavckD2iQ/zkYmw1PxLyXmJNwIWcKt5I0EDk
         U+5r5ujCHuKSyWjPGyaBIqyP4UmwKS+lUsWnqCCLTwKg5GbDGIkrA16ZidVCfyFlDwCU
         hPT2D9Ki5Tl88Y0jMGMa3SPDMA7LYl2LbkUT2fOsuwB1psGSHE93Twai/5sDGyyyeBSI
         TPQxA6fONxJKZjbFxAa53IJsk3n2T4gytPU7mD5H2QKFqRi9ESqMzGwApHiWW0P9uciX
         N17Av0DtfJjkw7TJ6YyWk/JmhOV8uS7XcLGfr2WhQHXYLXg35yxesgy4BqgXfzIYdr6A
         0iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765306494; x=1765911294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HpdLUaMszOte+9P9trLbr49o0T/8IL0zVkv1y9a6ACQ=;
        b=pxSDf1CIDIVUSdqLZ+zbLVg4Clz54IgL+K7SGFYXUHCIIfMSYzGAIHUkDwssCMa3GA
         pOSAK5i+rioq7JBwpbWduiBZ5elhqI/ZhDgZ6HGqSRTMyEz+3UCuJRAzz3u1192QfB3l
         GHSaIu6jjhZxLxgJFyatBav6grY/rhj1SaQB9fryJL1LkMbZkFcsH3w+wlHrjr51WBfI
         8kUYORwyP2FUj6kFglI5AHync+BbtPZ8CIH/eNW+kFFXkoWBgQ2Gp/uhLStxTipogK/A
         yaKhyb45Ev8I4+vdxzRv6ZqOjg0+Zr+o1egcN3T62XBWw7ozSwxufDxLfKujJrNuJjM9
         OlEA==
X-Forwarded-Encrypted: i=1; AJvYcCXtuxG3b4jlnz8/PClHPTe+d7sOZxoCuC88rsXXy8PKFcJRAqpCpTdPN+2ecMTraDlPGZ5dJpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIN6xJXfhUuq39MM6Q3Vv1fAqMC7udFlhzIi15ZImO9PCY8Zw
	6ZMgm9SGse1ffzlf5fyjIIH2E2piuxcA2WzoPDpXEg2xp3HWtKlW2Tat
X-Gm-Gg: ASbGncumLuRiZMaZizbUm4tUYqUQF10HEQ5grvrayVgOTQ+4hC52r3cHFHEL+FH1GhL
	r51mSVFoQOihsQeiHWTQfKYofTsxtaEMG/Ru0umwuYNFahJVfXYssZyToP3jnr+Z5E/MSeTGnlo
	DNI1QkrwE7FcB0uisNXBrDqmpwpgWYY1WiEmzt4/DKh0MpG99ZDE9GHTR30cr/l/0nLpbJLe1MM
	K3sbNgWLUkyFGhdoJ7aE/zatr/pD80lRILuUvf25ALNCOfhvAw3zHx/FgkpHz52hPf0v0JebHf2
	i2Y+ZUU5MfRnoaNCn+dG972xzOz/Ua0XGrqKkDKwVf4Y9VdgHXY1OkRW7IIvOixMlQ2R9CAYX2I
	TGXC8nzC5OnCBa6vB9gpEeYmcyxSnnyvIRWg+oXlnWZniYPCh18OHcEgXQAMjhahpVSdusalzhl
	wsr5zLP3nN+qzXUe+lkK6qNEZTU4lMtimWDxxSY1F5M+akoKSUfVjAJKB/OWvt3r8=
X-Google-Smtp-Source: AGHT+IFirw91TWSXU8QHpRvuGGX1U+haycOXGSNcwfW+RwtLxsf2h/xkUvj8XnU+zmLfR4fhgmr1+A==
X-Received: by 2002:a05:600c:444a:b0:477:6e02:54a5 with SMTP id 5b1f17b1804b1-47939e20a92mr115156485e9.18.1765306494210;
        Tue, 09 Dec 2025 10:54:54 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331092sm33581359f8f.30.2025.12.09.10.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 10:54:53 -0800 (PST)
Date: Tue, 9 Dec 2025 18:54:52 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Simon
 Horman <simon.horman@netronome.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 3/9] bitmap: Use FIELD_PREP() in expansion of
 FIELD_PREP_WM16()
Message-ID: <20251209185452.707f4dbe@pumpkin>
In-Reply-To: <aThETSRch_okmCbe@smile.fi.intel.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
	<20251209100313.2867-4-david.laight.linux@gmail.com>
	<aThETSRch_okmCbe@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Dec 2025 17:46:21 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Dec 09, 2025 at 10:03:07AM +0000, david.laight.linux@gmail.com wrote:
> 
> > Instead of directly expanding __BF_FIELD_CHECK() (which really ought
> > not be used outside bitfield) and open-coding the generation of the
> > masked value, just call FIELD_PREP() and add an extra check for
> > the mask being at most 16 bits.  
> 
> ...
> 
> > +#define FIELD_PREP_WM16(mask, val)				\
> > +({								\
> > +	__auto_type _mask = mask;				\
> > +	u32 _val = FIELD_PREP(_mask, val);			\  
> 
> > +	BUILD_BUG_ON_MSG(_mask > 0xffffu,			\
> > +			 "FIELD_PREP_WM16: mask too large");	\  
> 
> Can it be static_assert() instead?

No, they have to be 'integer constant expressions' not just
'compile time constants'.
Pretty useless for anything non-trivial.

	David

> 
> > +	_val | (_mask << 16);					\
> > +})  
> 


