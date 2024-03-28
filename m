Return-Path: <netdev+bounces-82772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C1888FAF6
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 10:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331F2290442
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DBD5102E;
	Thu, 28 Mar 2024 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ge8+E60J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B373F9DE
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617510; cv=none; b=tLYz2/xwF3ige7OuiCrrgJZsagvsh2ysjzBEmcAuQ0t4Ts8CzAArwvscFcgbIHSh+yar1YN7nlk4oumIWlwBJGO8XCjavVzeAj0lR7wapwD7RBDVG4yNKIa2UunbozAc8eQ16q3Vk0PkStE1aniXEPZnsp7CWxs3qlQPFVapYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617510; c=relaxed/simple;
	bh=JdlPi/D8q9gRz0rC7iT/EQjBcreVsogwectsXFf1ljg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezkXJAHzcph3u4oy9SUJE3nROmpEeMxBnQtjsY/aiJIqHnhvV0KeK+RHrGMzv3Nn4lEj5r0cUB2dh7NYvO5CWUtCdRECDpBx2bE36Cx9dzVVA/mvDI3nJnr5+/K61BzAItpwu1MKmLsHMCnLaf+B6g+5bNZ3XbTCr7Snv19LqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ge8+E60J; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc71031680so665179276.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 02:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711617508; x=1712222308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdlPi/D8q9gRz0rC7iT/EQjBcreVsogwectsXFf1ljg=;
        b=Ge8+E60J8rUtUpEjf/SYxfz+LLF1ltrNfOwUG9itZ2RRzLSKLJ2iogWDjw5ubV2vs3
         hFdW4nfCcibBd54P09d8/XzggdSF16IIkVIpakX/b/MmpsdHfgUhJw0x75fkrcw5RmnQ
         /7EcdXNLgTu4Yxdq9u4KAts/9VZnPeMYNrj1/KK7H5vN6W5A5y1C7cjg0NlqICwg6m5X
         g3dR8R3AYg1i6a+3WDdQjHa1NA4ecsMEPTA2RW+hjcTtJ4K/cLwx+wgxBON6L4w6IyKA
         P6YY5nk0PgPKPEwmarQ7FOlC8bysJ2CCgsB1nAEE+L494xyoWNzlRe5pXIVS74zPnTZn
         yZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617508; x=1712222308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdlPi/D8q9gRz0rC7iT/EQjBcreVsogwectsXFf1ljg=;
        b=YxD1EWkeNsTGR/EdBk5gf6X5JIUSK6d7+/8adaWXr4SQeqZRSMty5rovoWFF0ciuw/
         xZaN/dYLFKNBGJO9GHx1I6GQ3BBVh90Xe2ipOlWewdYyBiUyqodHjWtPJFfMkJc0pPrb
         v83kDaHTmu4NU9/0lMoswyJ5EpnZs7IVn71dPMV5+N9paj+kDi3PpfTNCnXPZEZhD7VL
         hHLiDW7moHg6W90td0lS7VrrhbVpifTwc+d6jfgKI1fuqah6gYsK4ZwBNkS3Ol+ow/Pu
         fBbf/b/EC+oSrN1Rodimk/z6VJWrN+9zxRlWkpKvYLxIeMXAPgkR7Sp4/Atc9XNXhhuf
         MH9g==
X-Forwarded-Encrypted: i=1; AJvYcCW8HM50DurajrTIKourJU/SSIUtNrcH9lEfvFq8Jpz3SYivIGPtst1OaFDy6uJuSDbPHq2sPhD9JCljwKWmVTiCOS3efwqk
X-Gm-Message-State: AOJu0YyGogRBZk7puucLSjXHfT2qVAUvWH49SwJJv+VshA3A42OBFcVT
	aWqA3JCSTuJUugnI2LCGCEQE+/gYklTG0UxTpLOBlRo6dgaWcel+GLqCnvuFRqBSqGQ0rNO6YUx
	rqV0/8gnUOQiyya1CeH7Nu7CHEwOQ7bsAifVHnQ==
X-Google-Smtp-Source: AGHT+IHUYiXsFEyaSrFSbE/Sr9EQQEbq6LIDEHkAK2tUEMiEJLOv+Yp1LaCp4ieBZ7Wds5RI7onQUIkumjvsdiSFxmI=
X-Received: by 2002:a25:9091:0:b0:dca:e4fd:b6d6 with SMTP id
 t17-20020a259091000000b00dcae4fdb6d6mr2028363ybl.61.1711617507999; Thu, 28
 Mar 2024 02:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326144741.3094687-1-arnd@kernel.org> <20240326144741.3094687-2-arnd@kernel.org>
In-Reply-To: <20240326144741.3094687-2-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 10:18:17 +0100
Message-ID: <CACRpkdbSsgzzwkTLTBvyc6JRVrAuVF=iFVQX7RZFJw5UyGuwyQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] kbuild: make -Woverride-init warnings more consistent
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Harry Wentland <harry.wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 3:49=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The -Woverride-init warn about code that may be intentional or not,
> but the inintentional ones tend to be real bugs, so there is a bit of
> disagreement on whether this warning option should be enabled by default
> and we have multiple settings in scripts/Makefile.extrawarn as well as
> individual subsystems.
>
> Older versions of clang only supported -Wno-initializer-overrides with
> the same meaning as gcc's -Woverride-init, though all supported versions
> now work with both. Because of this difference, an earlier cleanup of
> mine accidentally turned the clang warning off for W=3D1 builds and only
> left it on for W=3D2, while it's still enabled for gcc with W=3D1.
>
> There is also one driver that only turns the warning off for newer
> versions of gcc but not other compilers, and some but not all the
> Makefiles still use a cc-disable-warning conditional that is no
> longer needed with supported compilers here.
>
> Address all of the above by removing the special cases for clang
> and always turning the warning off unconditionally where it got
> in the way, using the syntax that is supported by both compilers.
>
> Fixes: 2cd3271b7a31 ("kbuild: avoid duplicate warning options")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Neat!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

