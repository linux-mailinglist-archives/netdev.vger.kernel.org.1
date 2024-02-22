Return-Path: <netdev+bounces-74104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D4D86002A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 18:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222881C237DF
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E115697D;
	Thu, 22 Feb 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LzI27tNp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA215531B
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624642; cv=none; b=ttTo5+dXZ3O/0B42Xa3Kl08ZBn1PFlLISXPlUBrNVJp4DQtuf2rGtBGaolqNMFk9Mfl/jEkzCSRyvlFVp0KxOJ0Dcr1mF/Qa/tw+dN6oslC38vRFCQmCzRCPZuphLxvUTgqjlsZ1pOaBW2a2OmMIjgm/rq81Zt2jpqkWvY7+DdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624642; c=relaxed/simple;
	bh=hlPKjlQSc0kMs/W05kmcLVH3IEjiTit6toh7GkaAPKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vE63tDdK2Vgnho4uoyQD+Go0w/n2TKwtoUohuMl8Wu90vE9L7iUg+PpiavEjP5klGgLdWtSFG1MGxEwx54w3qskE7onFIezg9ekk/aT2Hp0XqVjKyfB3k9tt3xNxPwxxG48ovjWMhWa3yXv9g++cd4ACJhk2SKSf2PGWfd6gj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LzI27tNp; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d2533089f6so569521fa.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708624638; x=1709229438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2n36AeyXiuh8a+bUOx1L+r2cwQosoX8vn/3R6qLfBBs=;
        b=LzI27tNpWi75HOEGy25hCc71RgKcKAUGfxffz8GmDfam4I2V+MU41aKTFeKjd0zRzk
         NO9CA1DlzFI8pXTLPThgTU1ewGfQPyTzC483xhm+c/bD7Cp92h4InhMb0KxAV9UsUAT7
         IB3MAHjQi70V1je60+d29jj/L7PN+o+agOeHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624638; x=1709229438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2n36AeyXiuh8a+bUOx1L+r2cwQosoX8vn/3R6qLfBBs=;
        b=rgW/3Pg5ffO6F6v+TG/fiHQgq9cKqKj1OJtDHPRQUb+ZsGucXSt4SNv73sTxvo+ovz
         CIVZn0RP3/8trXGXykILw32kcZIdt4I00hkwjBDhEtN3RZg3gsP+W1+ydxq9nRevuuBV
         Jd/7Ka5agKVGDjFYMc1Zf+6plhIxGt+Oq39KAZFBRUeDFiP0eV/jQDgTmZTnWxe2xueX
         /MQTceVru4y0LyxUzMUNA16pQnx7ONsQZuj4S4sw/fePvkZmaCYa/vSvxRufUszn+ehW
         eNyo0CkZiHBNp61JVLYpRYIX+Yvgv3NsKKG7nGFTkuShBFMpNjmRIobetFn9L96K0fJ0
         roUg==
X-Forwarded-Encrypted: i=1; AJvYcCVtSbPkUxKM3BoZdp1Nm+isDWhemE7DRPlI4OkyXXi4s3aD+Bou0SA/2+nuGGEC8VRPCl8N5d2tG9x9bxXfEhDfB2B1CJou
X-Gm-Message-State: AOJu0Yyex1SrUTKvNnZR+JqkCoYXahZmT/bMijydh5j4gZhPuQv2A8sY
	kEzGeyzknJCGJ4ub06jGsA2v7t28VTyw2e3G8b9IpxxGCLWCAlhd+2P/4L6Ggv+/xSfkqrlRQrX
	VHTJI5g==
X-Google-Smtp-Source: AGHT+IEKpPGanP/Uj/h17MR0/44MObELr2UDIVqM6JlJWefGy/ogpaUTEaL8afu+CXlpHrg52x9PgQ==
X-Received: by 2002:a2e:b2cf:0:b0:2d1:749:cbdf with SMTP id 15-20020a2eb2cf000000b002d10749cbdfmr15536654ljz.22.1708624638348;
        Thu, 22 Feb 2024 09:57:18 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m10-20020a2e910a000000b002d11f907489sm2332853ljg.2.2024.02.22.09.57.17
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 09:57:18 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d2533089f6so569221fa.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 09:57:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/HnhEYqXE4TvO42C08JbvGOohI8H+b3XJnhiMRy4KP1Tvw1xACkJK1f11mH4RTSgWzG0xQbfHusjCUP9qdYOhRNG8iynu
X-Received: by 2002:a05:6512:3089:b0:512:acf1:6970 with SMTP id
 z9-20020a056512308900b00512acf16970mr11555378lfd.35.1708624617484; Thu, 22
 Feb 2024 09:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-3-davidgow@google.com>
 <20240221201008.ez5tu7xvkedtln3o@google.com> <CABVgOSn+VxTb5TOmZd82HN04j_ZG9J2G-AoJmdxWG8QDh9xGxg@mail.gmail.com>
 <CAGS_qxoW0v0eM646zLu=SWL1O5UUp5k08SZsQO51gCDx_LnhcQ@mail.gmail.com>
In-Reply-To: <CAGS_qxoW0v0eM646zLu=SWL1O5UUp5k08SZsQO51gCDx_LnhcQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2024 09:56:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiODww51Kz-TTWn0ka5T8oMtt0AfbO9t0U3iJqfLZO+8w@mail.gmail.com>
Message-ID: <CAHk-=wiODww51Kz-TTWn0ka5T8oMtt0AfbO9t0U3iJqfLZO+8w@mail.gmail.com>
Subject: Re: [PATCH 2/9] lib/cmdline: Fix an invalid format specifier in an
 assertion msg
To: Daniel Latypov <dlatypov@google.com>
Cc: David Gow <davidgow@google.com>, Justin Stitt <justinstitt@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rae Moar <rmoar@google.com>, Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 09:36, Daniel Latypov <dlatypov@google.com> wrote:
>
> Copying the line for context, it's about `p-r` where
>   p = memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
> `p-r` should never be negative unless something has gone horribly
> horribly wrong.

Sure it would - if 'p' is NULL.

Of course, then a negative value wouldn't be helpful either, and in
this case that's what the EXPECT_PTR_EQ checking is testing in the
first place, so it's a non-issue.

IOW, in practice clearly the sign should simply not matter here.

I do think that the default case for pointer differences should be
that they are signed, because they *can* be.

Just because of that "default case", unless there's some actual reason
to use '%tu', I think '%td' should be seen as the normal case to use.

That said, just as a quick aside: be careful with pointer differences
in the kernel.

For this particular case, when we're talking about just 'char *', it's
not a big deal, but we've had code where people didn't think about
what it means to do a pointer difference in C, and how it can be often
unnecessarily expensive due to the implied "divide by the size of the
pointed object".

Sometimes it's actually worth writing the code in ways that avoids
pointer differences entirely (which might involve passing around
indexes instead of pointers).

                 Linus

