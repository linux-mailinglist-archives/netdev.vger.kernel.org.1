Return-Path: <netdev+bounces-73887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B0B85F13B
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 07:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53F11C22794
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 06:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43E116439;
	Thu, 22 Feb 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IEC2gufM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80B12E4F
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708581613; cv=none; b=jZpi4AmeIEiBzIUoLQZG+LY5pDhWTYrhj5/Y66f2ZZGA5l8GPUIY3RnwoJHbBy2jGMHw0e9CGgv4xadViIfM4ZMMCe3KcQ++jrpPcD4SS+kDlsMO1rEPbQseewDq4qm+e3xqPq8/4JewMSqG4+7PUWqvFkVqVOMNQcvF5iuqBls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708581613; c=relaxed/simple;
	bh=jfydpiinpYlW5lz/CxxcHMi0x0ZILrRNe4+Fx00kgU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0ThecmTclqD9ogTpZdElvSU2rs/RbfJCr+3qtR0JtQ9HRwo5lXPBsEQINZkxIwH0iXHcXwfU97zKWctXRu2MOaDXUumm5pO2ZKLaauzYsWbStI5X5iP+jlEV0B1vhb4w6ZGisy2nF9lRNDTqWEmF9i9QsC/zp50GJu+xCXLSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IEC2gufM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512d6bcd696so500406e87.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 22:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708581610; x=1709186410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrfADjbK9wBe+Anypf28Boz5+FV1y2DabiZpnaLd2+Y=;
        b=IEC2gufMSinVC27jsu0IJ7ALFiWV9PDw88scIpYamJdobjrdfitx0un16GjbwzY43i
         XBuMIgYmEPSjw6CNZkSVryBLTtV5Minketam57ACNeUZkJX7YW3kI4DM4L91NAJ+oRNf
         irzP2UsYd03OOGyVCftaO468Lez319xvjsEIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708581610; x=1709186410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrfADjbK9wBe+Anypf28Boz5+FV1y2DabiZpnaLd2+Y=;
        b=erTy9FzN2WL/asHAEc8D/JqKZl4uEhhV3pSQcgS4hN04ZACnkVzH52O6MStCbBeCII
         n1UKK8fa6W+jKIDTQKTAXPKrjomKW/BOQmw0R/BxkughkMuwXMY97F1N0a3seewOY81U
         MSCqwgMBQSr6ME5dgLqUGL3c6y/QVAB6ox4qOd53OeN0KJyKmkyMhs4292YcESWDuKyg
         rQ26yJu5uHXFrXJvZBwsfvU908s9o43wPS4U1uQOSsHZPFRwW9Xt1WeSA7bk63alSjqM
         Z3cU6S5Kdavabpp23Hyq3kf8oFIhkfLDB4mDkv4/5MwkjvCu4lhImrOk52JGyGLE/vWD
         MMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8O8o4eFpBOL7HC80n2IAfafkTcy9XTcgM2r7jC2PeBYbWCHFwEFXtLWcvzfqr78VRVO4NDKSSKvPx/g9rtC2bObo+B0Gi
X-Gm-Message-State: AOJu0YwgY/gaRJgMxx1Q367pmSVV8IWcJ8nef57O3lDcMkKp1czQNgX4
	fpxHSLYyDi0mKlwpB6/JxXk2Eq9bGa32bWcgMmpo9cQwzjfrq5zu/+vch0mSngx5E4sIVa21sAi
	DpOp/Dw==
X-Google-Smtp-Source: AGHT+IGeSGE2gNH9XpNMKlWmrtgE91vb92RYLKNfDGLPkKRqy3e6r9tbEmhMkmCAU5bmQ9GviZgl5g==
X-Received: by 2002:a19:654b:0:b0:511:a0db:5062 with SMTP id c11-20020a19654b000000b00511a0db5062mr466492lfj.17.1708581610043;
        Wed, 21 Feb 2024 22:00:10 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id o24-20020a056512051800b00512ac349016sm1624452lfb.306.2024.02.21.22.00.08
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 22:00:09 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0cd9871b3so5159121fa.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 22:00:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXM/Xli6/cTlsaxwxEP8IeM0V4lLkcVG7ATxQi3oSFBGRFznZk2v1qaBUvBcu9armkqC4hvXQs7R1Kk2ZGCqJIlir50RSnQ
X-Received: by 2002:a17:906:f0c4:b0:a3e:719b:c049 with SMTP id
 dk4-20020a170906f0c400b00a3e719bc049mr1321213ejb.28.1708581587292; Wed, 21
 Feb 2024 21:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-9-davidgow@google.com>
 <anz6qjyb2oqkz6wdy4ehnlpoujy4rz2itohpglgfqzadtonxtj@ljakgnqmfxxh>
In-Reply-To: <anz6qjyb2oqkz6wdy4ehnlpoujy4rz2itohpglgfqzadtonxtj@ljakgnqmfxxh>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2024 21:59:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgafXXX17eKx9wH_uHg=UgvXkngxGhPcZwhpj7Uz=_0Pw@mail.gmail.com>
Message-ID: <CAHk-=wgafXXX17eKx9wH_uHg=UgvXkngxGhPcZwhpj7Uz=_0Pw@mail.gmail.com>
Subject: Re: [PATCH 8/9] drm/xe/tests: Fix printf format specifiers in
 xe_migrate test
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 21:05, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> this has a potential to cause conflicts with upcoming work, so I think
> it's better to apply this through drm-xe-next. Let me know if you agree.

I disagree. Violently.

For this to be fixed, we need to have the printf format checking enabled.

And we can't enable it until all the problems have been fixed.

Which means that we should *not* have to wait for [N] different trees
to fix their issues separately.

This should get fixed in the Kunit tree, so that the Kunit tree can
just send a pull request to me to enable format checking for the KUnit
tests, together with all the fixes.  Trying to spread those fixes out
to different git branches will only result in pain and pointless
dependencies between different trees.

Honestly, the reason I noticed the problem in the first place was that
the drm tree had a separate bug, that had been apparently noted in
linux-next, and *despite* that it made it into a pull request to me
and caused new build failures in rc5.

So as things are, I am not IN THE LEAST interested in some kind of
"let us fix this in the drm tree separately" garbage.  We're not
making things worse by trying to fix this in different trees.

We're fixing this in the Kunit tree, and I do not want to get *more*
problems from the drm side. I've had enough.

               Linus

