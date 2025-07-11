Return-Path: <netdev+bounces-206264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6834B025D3
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 22:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E631B1CA6A84
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 20:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765D01F875A;
	Fri, 11 Jul 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HcLdUIIR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752961E5B97
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266126; cv=none; b=pvs3fNqaKdgk/OxVmkGQZ1e/4D/B6d2j4VCjwZqPyKg6ozRuWwHQhH6FDZ9W72t8CQ+cQwmIpaMVusMnd6RY1ozJD8uoXHr/FHcjsvd/8A+CyPdt78kfk65QvvkQK4UOjqp8C5if4Nrvh+4WZlqrHgVSA22fZK2hLcFzI4FBip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266126; c=relaxed/simple;
	bh=b1VDAFqxBEw3uXSyuwPQh26CLi4QbJOh8mtJ/aaAzlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7X50PhcLZtiq0yxYD1Kk2J51rGZxKZgiC04t5bfl47tnqQ4K303YgXubFg4MciFr+7864MGH9/RyAtTXQv/3hsR15sjV7zEaivqUtLXygYOnM+O2MPO9K8zoNchNOhPLXxvUBTaCxEa3CGuOWoirv4WV6aFqS5so5ojF+VDbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HcLdUIIR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso3531350a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752266123; x=1752870923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3WSd1C2YEpBcSCAUHObR5B794dxVqLICPHfsBmrzbCQ=;
        b=HcLdUIIRVCaw9AsUzVvwS3YVmwJvuFYyhiYwchz0rYdSTXaCvp1Qr9zBW2XFdjdehc
         gu9BM7mIuBCqHMrNHN2tkaHyFaaX7fucyR187n5uH5iErD1ka+sJF22sOuQJjMFoNwVl
         5u9m5C0JWn78VDSc4Ys5Epf6SN4MSmLWKfeCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752266123; x=1752870923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WSd1C2YEpBcSCAUHObR5B794dxVqLICPHfsBmrzbCQ=;
        b=A7coZ8tVHxPfxOKA/rDKTAvwHIc30Qxie/uBTnYv/GPMkYxK56E605uraVHDfkQges
         QmmnB3wMSUzKO9mhr0BWMsvjISTSCcB60/SQQjWPleWCJU/sRF6ZR4mAlxQaG7zdmCUc
         qXJ/I1kYSEYQ4LAe0GRqdJNG1WyASpK6Bbhgl3BN2Iqme+lpm8cYaP9AHvFNiIDB3uaS
         R1Id32TCa/gRmG1Gj6S6Vdm2pyWjvRtOnfiq1lKBeuvEEwriyOT0kJi9C87p3+FjH/YU
         YkkRLNsZ1wdubDEQkLDBZKKSwbbl15dyW1UWaUk04QczNaAORgZD56w3B8j5wo4YIXPV
         WMfg==
X-Forwarded-Encrypted: i=1; AJvYcCULMNfguh/IDMekv0iAZWOV/P8VjdHc8B82S66CXAhzQVKmL59erfR8PEiCxhzdgkKYNBsf3tE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7zjta7MVYQ7P8nQ+rWIMepJ+QKGWCGyc3m0m2G1zSX7Hli1x/
	UZjsiS39I0lMkYipzgL5Bgl712mRyldPtSaG/MpwSaJNzYKeroeTE+ZxnwEZEj4r2RojVovLMeN
	/+1wQRlZf9g==
X-Gm-Gg: ASbGnctmaS3IntQjERZJyjq8/GyHPzfiEVIxUWVllDZUgjCrsZj2PXUP7O3H9Obunrh
	6Hwk4N0X9NX5PiWCqTLwW7ujzqvwVHF6baRv6vy5Mp+LuW4GKwkcSqmXzPtD6m9aUGcEjNQ9boW
	cywffAmwv6M7RY4jxcQalipiHW4ppYNe0tr4fndPIAnA4STmJNzfmzU/CtWJt8+0e2fil//Kk9P
	Ez9odwHOT8WZSduOfsxa+6sGVYyVj84zmqNZhDBQQzGKjgRvDWNqiUZ04e9EVedlg11pXZtGE7t
	UgmAjsTHRDLairYq2MRDIAaZ0U5mxz9TUvNJXwoy+YhiwmzqBTJxMWlw9E5wDGik8SdToGfijsZ
	aqMiFtGvhPwG/ZEd3F32qaogaAAG6B+eT9R/ctWIXiF7SaXtzJpRP9TPyqQnFWAw4lTbXlQj4Yy
	enNmuEmDM=
X-Google-Smtp-Source: AGHT+IGZEIc47IJ02MwQ6Ez1T9acpRkMl1ONYVmkE3lL8K7xWm09A9XR1aep2i0Hq3UUgK6yebEkGA==
X-Received: by 2002:a17:907:9612:b0:add:ed0d:a581 with SMTP id a640c23a62f3a-ae6fbfa7d26mr502709966b.17.1752266122607;
        Fri, 11 Jul 2025 13:35:22 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e910f3sm353418066b.31.2025.07.11.13.35.20
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 13:35:21 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0df6f5758so445110966b.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 13:35:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5Dkpwx/9171pw4QW5Lqo/gmqNGO9dXKnTApf9aLcGMVdxUaTjoB4yjr1K8goMpnhUoCCGa24=@vger.kernel.org
X-Received: by 2002:a17:906:9fd1:b0:ae6:e1ba:30a with SMTP id
 a640c23a62f3a-ae6fc3d7e07mr437795566b.54.1752266120408; Fri, 11 Jul 2025
 13:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org> <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
 <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
 <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
 <CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com>
 <20250711125349.0ccc4ac0@kernel.org> <CAHk-=wjp9vnw46tJ_7r-+Q73EWABHsO0EBvBM2ww8ibK9XfSZg@mail.gmail.com>
In-Reply-To: <CAHk-=wjp9vnw46tJ_7r-+Q73EWABHsO0EBvBM2ww8ibK9XfSZg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 13:35:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjv_uCzWGFoYZVg0_A--jOBSPMWCvdpFo0rW2NnZ=QyLQ@mail.gmail.com>
X-Gm-Features: Ac12FXw06ng89sgg6lACD8raxtg8tIsOj2V4Q2Quo5hdT7JGF5RzQP8YU9BhymY
Message-ID: <CAHk-=wjv_uCzWGFoYZVg0_A--jOBSPMWCvdpFo0rW2NnZ=QyLQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 13:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oh well. I think I'll just have to go back to bisecting this thing.
> I've tried to do that several times, and it has failed due to being
> too flaky, but I think I've learnt the signs to look out for better
> too.

Indeed. It turns out that the problem actually started somewhere
between rc4 and rc5, and all my previous bisections never even came
close, because kernels usually work well enough that I never realized
that it went back that far.

                Linus

