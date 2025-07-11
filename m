Return-Path: <netdev+bounces-206253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A4B0249C
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CB53AE477
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1201F19CD17;
	Fri, 11 Jul 2025 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IJiXPFIV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3061469D
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262250; cv=none; b=D2ZxWrMOQiWNfJO4uDyO8ZDAgzIZ0eeHehUEve4xYPKdlimj36B1/xFWG4082uv4boFrE1vw184MKHwsbm8uc08gpcbI39c46lzhukiG3brqqB2qdQHL0slRbFf28KA1q+ZbWeBDshcblotTmiN2b1pzYlxymNY9hOBbmil12Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262250; c=relaxed/simple;
	bh=fFeiBWFwEu6yivVJrS3VCjAHsiIzHVVSjwe6FIgy23I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4CvNNjt51LoBUKrAb+oV5nQDwr9G6fji0sYED9llVpZ3QGL+ptqzTmUZyNf27dAdVq0iJB9gZLTwpubOIbRw670iKfJG/+C80mM/NXCjJolpfMjEccjrx/qyZj9uD2AXnmpk8i/3RDMeh1UjXsB3jUua3J7V7Q2NhOyBNpCZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IJiXPFIV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so4693223a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752262246; x=1752867046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W42wqNZ6CmAMcEVUi0DgirOnpBMSt1r3eJzW5nHOkPQ=;
        b=IJiXPFIV4nLUlO0Na3colxhV3qwNgy3S7s1i/NXZe5dDnP7NH6io8lb5hDrWPntILf
         T7s1QvZkzLu/Yly3fmV9BDGyVKmwFmvw71wL+ur2UoSqIE28/m7ngRZr/3T7Y05b+37D
         tKio/rMUQC65mwrcZWK1lVfrqzGus+cuoEzCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262246; x=1752867046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W42wqNZ6CmAMcEVUi0DgirOnpBMSt1r3eJzW5nHOkPQ=;
        b=r0TRvrpLxpDd1mNuZcd7bpaOECaKwDYeeLgxiI9dsWy2oOXpNX7RiHmvPwuQGaIG7k
         LJKMeMSttpVYNC/Ai9KJpVjwMYKs90UPc9Lo/YNETOFzFaLevYNp/pEGPvK5BU3UQi1d
         2ESBxKoo6zYIZAANbQi23K38OCMB3iWn/wzFXpJLuxaywJnffr2fbW28QbE8YndtJvYs
         VI8zQfqjSKUwp9iYvBHhxM1lofLs6SQSKW7SpbJ5l564CkQwAYOY/A6g+WFCWnYWwi3f
         V3l4HdrkiVuqle0mLImJBkHKHC3Y+lPkrtQxkRsHTFMEtdtuwb8Ax7/jYWVJfcKkwIt2
         d+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEpTUk/fpueKWTERP3fTDQ/PjRF3BhRqN7GrhHSxG75Hmgc6ekzxIGznrP2wGBYzedMZ33+c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQytNE6Su+RGsB/Pxq0Hb+9wcbDr/PlerAvywqz6yq3Fveki5B
	cVSMQVc4CStoHFeEChTd5/w1O8UDsTprB+YTpfbc8rkJ7DzJEbGy/4CPlP17bUHBaaCSxAA4o75
	hNiwIhJTYEg==
X-Gm-Gg: ASbGnctIuPuTI+GI7heB4WuEtZ3SDK+lNfL6JcQhKHp2o6qscnhoc2JVdC9DHoZ/Mfo
	qem8021I/HPwZalKuSypUNcDi17QvZd7GCDw+ihnoqSP3iCLezcFtLKfHF4JMWk3UvtdH7SoPUF
	wvrCiywE2DBks5jqkFsqCB7crqmSUGdfLSVI4cP9rpVb9HgN0JJQy4z4kNT3EKbD/0Pp+iWGWWr
	RCHmGIyr1yOXNuGnDsouUhqKyzrTnDY7U68I9PifxQiUf8pI5kzq5LFFiO5RIc+t4htdT1d5QIp
	jlTXQxPGK3BrTr442GSS5O0u9h1hh5VtbVgWMeHK4AVMbI8mDYjf9O/ffmbXN71F2RWyxpxEomw
	vum7BNAR0T44uOPWIyB55P1RZN7vqPyxG7sFGkpvTE2wDBWOXxX8rBLVVm/fUdGtspPzTdHZ8B5
	roV8pYZ6c=
X-Google-Smtp-Source: AGHT+IF2skrN9fuIfRUlNWk5ah638FRRI8Dv1Vl7jUCBVi8unAvfLVZnUnl3gEWlcDKdNkP6hbzgFw==
X-Received: by 2002:a17:907:1b1b:b0:ad5:3055:a025 with SMTP id a640c23a62f3a-ae6fbc1278fmr488298266b.6.1752262245859;
        Fri, 11 Jul 2025 12:30:45 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82645f2sm337409466b.89.2025.07.11.12.30.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:30:45 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso4700173a12.2
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:30:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+9RtmLISdzZyzOz3RKwAe+8AJkT1cqDCBJjH8Rod5xYa98IMxXeUnqxRimWtlVdaT6qAojr0=@vger.kernel.org
X-Received: by 2002:a05:6402:13d5:b0:601:e99c:9b19 with SMTP id
 4fb4d7f45d1cf-611eefbd8ccmr2998361a12.1.1752262244860; Fri, 11 Jul 2025
 12:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org> <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
 <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 12:30:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
X-Gm-Features: Ac12FXz05ddJJmdKtsU0c732bvFnqaJPd5imXrgLsnwoQ6msxaZ9czwbq-1pfJM
Message-ID: <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 12:18, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I spent several hours yesterday chasing all the wrong things (because
> I thought it was in drm), and often thought "Oh, that fixed it". Only
> to then realize that nope, the problem still happens.
>
> I will test the reverts. Several times.

Well, the first boot with those three commits reverted shows no problem at all.

But as mentioned, I've now had "Oh, that fixed it" about ten times.

So that "Oh, it worked this time" has been tainted by past experience.
Will do several more boots now in the hope that it's gone for good.

            Linus

