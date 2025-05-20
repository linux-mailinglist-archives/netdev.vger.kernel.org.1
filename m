Return-Path: <netdev+bounces-192084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD35ABE81D
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3053C4A6D48
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 23:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2F4256C6A;
	Tue, 20 May 2025 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omv9fjTb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224001E570B
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784257; cv=none; b=JrZCR7/pYSJmm27CLZqPM+bson6E8tmu1PGVfdbiF2pXRAuaShHC/bcqWcd8SRBC2z5M3Zsrt996+BKbqU9uc6PDzz+jADTHJjwMJNQQJ+bURjXF23KQoB2vuVwfjgMbY14pZV1dP/viQhQxBLitASZJHN4gthmYfX0oA28wojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784257; c=relaxed/simple;
	bh=PGZYBlj/OCgCz8/PGNGSAJeArIWm5gf75vjKd0N4XO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSMz7Ni7iVJSKt5yA+yBnlScMNWmYSqSBwuXIC/g4jrVyb3299idbT0DmuGlimKiqx3LiHfCkEcyNoAjlL+fyJYIm1JZdB62sIfFhlai5gTl85V7pl47Km8/qNvQYU5r+S0HY8cEvEq4LTh0BpIx7ZgZWZyASAV1F7nXEnG7IjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Omv9fjTb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22d95f0dda4so65230145ad.2
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747784254; x=1748389054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGZYBlj/OCgCz8/PGNGSAJeArIWm5gf75vjKd0N4XO8=;
        b=Omv9fjTb4kLhF0rguVuvwrwiPNF9FpxdwMRZROXeM+/JaqUi0MJLhIUiu3HGLV0QnN
         OmfwjbUrNGZ/mANY41yH8HTdKsrygR2VhAhst4IhUqMHlB6NnZ8Ma2MUMQMIYGD4yKYe
         gfnR+OaeLTi96rXGsKnRqIscFbc66es0+Di7xHduGUk1zvjGnYsixjpBQvOLUvLBmM6N
         jMhG4PPvp7xjO0s7UY120x0rG76XF6Z21WxeMTzSLjdVVEjRM1VdWaWwX4EN7UNZQtTg
         aFBIdSDScoLHcKnZEsZHTA8P+ziuBHwsf/bGBvtoHjBpkEa1dPML3pqx8n+IFbdwHP8L
         tO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747784254; x=1748389054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGZYBlj/OCgCz8/PGNGSAJeArIWm5gf75vjKd0N4XO8=;
        b=H+XU5FUXGCmULOLBTUOr7Q4aNFzNDVXpWmZwDHfR3c8XnEKsWGlpcgzU/ZL7+wSiG4
         qpTq+DFvlmbSGGSsj4Uh5w+5c2dtihtEknwWe9Qy2Pqf9cDnRdmXIMZYUUGzoey1YK+6
         sxCZ/d7eobr5cdNwQ2cfdAy+tL7Otaq8Wm48PqWmZGsHyW33a6q3LY+kXsaOPArb2pNk
         X7yN17hddy/1xFaxYeXyLX7DmgkLUpmlkiy+QA9RgF8wCGKqJDDCSiYaATrtUyghJOcY
         g9zYU/UD3P5BKHSbBbNgE6J2opKF9YOcuF/dYoRg/eyAK9k/yBozFPH7RVhHiikmUAQW
         8jOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJtWdWrDflHCr78aPc8ODAG3b9T0srdhZl9zy86E0BImyZDUplWm4mVcoSrMmcuzncp14wMOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBsZPbzEGzqcsfsV/TkPY9yIts6Rrsy+oZ6+81vwq7PZ271Un
	RVIg85R4Lhq7RCYl+G90OQb05HzNxEs78g6EOHiBcxZ8BgSLe7Y4jysXMyNHrpZaj/X5HisBnHM
	YyVbIcKNaf17wm1mJkQ0fx+CbXxor6Wk=
X-Gm-Gg: ASbGncsIbCuDNyZlx8iLSAfDnzQs/WHOcAVXLiqIVEUW/9VK9Vu+s/RuKJyVEQ8rrFZ
	eyjvZTtg35LuYM/yb5tiwD/HaNdQrkjYkEZ2olfemRgq3VxFBCwrLKVAn17rdoL0AOBXRF+7AhK
	lizP6qG4i2Kmreh8Ha82VnKcnZ2ulOv96LpYl2EbKI/rIN5eeittRiCpLMtxTScsl6uGQ=
X-Google-Smtp-Source: AGHT+IEp4cUBW/sIbXbeqATMyNwkGqxRE7jOps6AQj/YAiR1kKEmoq/k+XU1YhzO8x8leIr1xMVwqfXwHSOBVSGPdgE=
X-Received: by 2002:a17:902:db05:b0:231:c792:205 with SMTP id
 d9443c01a7336-231d43dcad8mr275480585ad.4.1747784254267; Tue, 20 May 2025
 16:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520050205.2778391-1-krikku@gmail.com> <4068bd0c-d613-483f-8975-9cde1c6074d6@intel.com>
 <CACLgkEb+5OU+op+FvrrqiA1mgsp7NbA=KB_dCa532R6AL2c3Kw@mail.gmail.com> <7d901760-460b-491e-986a-4c5a4ac1fe17@molgen.mpg.de>
In-Reply-To: <7d901760-460b-491e-986a-4c5a4ac1fe17@molgen.mpg.de>
From: Krishna Kumar <krikku@gmail.com>
Date: Wed, 21 May 2025 05:06:56 +0530
X-Gm-Features: AX0GCFvqeNt1kCX2i3ZfOSHmodrvEnJ9kSi4e3UlJp3TkFC-sqabBsv2opWnKmI
Message-ID: <CACLgkEZo4HPfdCSPbKXku3sZkPDzgibDi4XhbuQfUYqcEWa_Hw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] net: ice: Perform accurate aRFS flow match
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, edumazet@google.com, 
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch, kuba@kernel.org, 
	pabeni@redhat.com, sridhar.samudrala@intel.com, krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 12:41=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:

> >> Also, please add instructions on how to get these values, so that
> >> validation team may be able to replicate.
> >
> > I have a large set of scripts that measure each of these parameters.
> > If you wish, I can send you the set of scripts separately.
> It=E2=80=99d be great if you could share the scripts with instructions. M=
aybe
> you could even publish them in a git archive.

Sure, I am happy to share them! I need a little time to clean them
up, replace hardcoded values, make them more robust, etc. I will
publish them soon and share the link here.

Regards,
- Krishna

