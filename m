Return-Path: <netdev+bounces-200634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A896AE65BA
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87EF4074DF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E335299943;
	Tue, 24 Jun 2025 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx+wNX8K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0066291C01;
	Tue, 24 Jun 2025 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769972; cv=none; b=k8AiJlJhTaCpL/IgplAVdjH16KyI1EAApFzwKDaK8FSBCXTixF0kshODao++z5P8IOaZBEsdMJcdcHuo5HjxeMSD3FqfMoBQiNet5jgumHwu0rvQbrsasvCPDhPWuUdU1g3Wi8+3+mqltEF6Gb/Pdoh8PyksNNnoca0vwPrWcCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769972; c=relaxed/simple;
	bh=dAYn0EfssAKk4QNI5cjNInqaycsqKktvQcISKWckjNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVFHnq8PyVuX2kgdE9yCz96cq3qrhhrw0QNjOgNlVJp4rEfXw7es78FHAZ4Ch2uA7QfDuI156Js1/YorkQ1KglhQqlIwuG1SZCQZ4kevZQlB6b0Sjtdlgxw9InhF8QgNXqZsBcxCApWLU9UEpfmJJOZNCG5dy1oj7vtX6qaZ1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx+wNX8K; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8179a42475so388593276.0;
        Tue, 24 Jun 2025 05:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750769970; x=1751374770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXEGXnz0a+df5W+FfhZnrWhPAiPAElZm0f8fsVZX0Fw=;
        b=Kx+wNX8K70MK+tvgRdFYoE8xp/gTt95iZAa5PRJ+W+ORn31V04zsrCIDcBbGQNEI3f
         qMiRg/zwt5QDZZMVju9rB/1BsoVn/cjeAc9DWwHUhPOLRwrV0YWW7znVHs/Ki83aJKak
         U9xM14+GaSXqNhyCoMzIsIYN2ZXsxw0LHUxpltH48LDhQIQeeGJ8N9g+amYh4+pgqlQk
         bkQabxypoYNpzZrHqcmti+kcbFW2Zbvo8iKMv3bn6dYXnAYi79kPtoAPCEJZjfQd6ew/
         rq/pJ1U99wXe5oF91d0S3Vn6AF+dx1jxFjw+qWomFtc4z8ibN5Owu3GE/EKguylZPXNT
         FHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750769970; x=1751374770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXEGXnz0a+df5W+FfhZnrWhPAiPAElZm0f8fsVZX0Fw=;
        b=dqDxCmWA8j0E+DE6SdNUD3YHRQKs5WRf9O9HJ+yumQAtg9DA5SDHF35AOJJWL+94X3
         x1f/0Z9/yzq7ooieAaa0dwVFYSSgX1zqbVW6mf3T4pKUl9wWnzdO6EuUdmGT6cuY2ufT
         /VKBQRULTJ2RiykG7/ddvqrBOtx/edzCxDAFqXCKcCcZFstaDLbzAQbS6E9xOrGT/MsJ
         OW9kf6xi9Fnl+KnM/jQgHfmOmsjTmpDoZfGWi7Z3CTvhwlO1++VcD0fsWbBLLGWkdyyr
         WECAmkKZSjGlrHJUsXrHgNKLHfBMhaY73bsm5E5EoqV/e5V+EyNlS6EqETyp2jvwVMHi
         LV9w==
X-Forwarded-Encrypted: i=1; AJvYcCUCrRyurOkbPresZ7auMSmmDiZNy/SZ2/LlgNbACo2AGVtEFj+UTcbzuvaHOntzdWXuTyQCFLLpBGGK7bzA@vger.kernel.org, AJvYcCX74vUESwk7qVuMxs2XPlzBUnA7B9/JYSEId6yLjvqSHt/hLT98PE8XCxltYNV1wKLf4WpYb5qs@vger.kernel.org, AJvYcCXD8wAPyaRJNxAqk/dEATOJh38DAxCokVg3hTi6AZrpkDHunCfVb16r9INiLXCToj3Jx4btb4kS0xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbep/vU9x7pyD1dlZQTUs1kpEe4hntODIqch7dPws8FEIX1CYl
	6KlUCeDwBLKw7654he6BLoWyKT2cmUX2Mt1Ussvcv/ZeNNK8jDEEWNZfgcWnhzu3hyVJg+h051/
	xB/i0XtSnryQbZFL+CyI4RTG5UykZOyw=
X-Gm-Gg: ASbGnct+vGiVXw1c5nUbUr6jzd9Ouu9NFicam03gImLE4SpYNbmIUfT1IhpOObvRMon
	19utBg19pFHfhdLJPyhBGZFGc4W6dNq+GlYb+RpqiQ4/1SmRIJmt8aNGpqX8IFzlXbZlyhtNbQt
	StYPGd+sTxbv9102H0C98eQ/w4CQh9XwotTNshr+P5to2n+IQwvmCWeKw=
X-Google-Smtp-Source: AGHT+IFvCeaZzKHMdYWrE1NUmXGqOeTl6mqBUnlIc9WE5OJM9ZB0ZpndjNLaByWjgS1VW99YxVSV89DUdGGvZOd+CoM=
X-Received: by 2002:a05:6902:2e09:b0:e82:14ac:77eb with SMTP id
 3f1490d57ef6-e842bd144bamr8550147276.8.1750769969472; Tue, 24 Jun 2025
 05:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622090720.190673-1-abdelrahmanfekry375@gmail.com> <fb0f1e3c-2229-4860-b46a-b99f6dbfdfe6@redhat.com>
In-Reply-To: <fb0f1e3c-2229-4860-b46a-b99f6dbfdfe6@redhat.com>
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Date: Tue, 24 Jun 2025 15:59:18 +0300
X-Gm-Features: AX0GCFvvC-fqrHPcAXlNkROP7sMaBEpAgC6_zly4W-ELrMge3AhPG2o-bdZmr3E
Message-ID: <CAGn2d8OguuLUkRaT68MkL0_VJ5hh5CZfONCaruEHcASdxfJbDA@mail.gmail.com>
Subject: Re: [PATCH net-next v5] docs: net: sysctl documentation cleanup
To: Paolo Abeni <pabeni@redhat.com>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.com, jacob.e.keller@intel.com, 
	alok.a.tiwari@oracle.com, bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 3:54=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 6/22/25 11:07 AM, Abdelrahman Fekry wrote:
> > @@ -593,10 +629,16 @@ tcp_min_rtt_wlen - INTEGER
> >       Default: 300
> >
> >  tcp_moderate_rcvbuf - BOOLEAN
> > -     If set, TCP performs receive buffer auto-tuning, attempting to
> > +     If enabled, TCP performs receive buffer auto-tuning, attempting t=
o
> >       automatically size the buffer (no greater than tcp_rmem[2]) to
> > -     match the size required by the path for full throughput.  Enabled=
 by
> > -     default.
> > +     match the size required by the path for full throughput.
> > +
> > +     Possible values:
> > +
> > +     - 0 (disabled)
> > +     - 1 (enabled)
> > +
> > +     Default: 0 (disabled)
>
> This uncorrectly changes the default value: should be 1.
>
> >  icmp_echo_ignore_broadcasts - BOOLEAN
> > -     If set non-zero, then the kernel will ignore all ICMP ECHO and
> > +     If enabled, then the kernel will ignore all ICMP ECHO and
> >       TIMESTAMP requests sent to it via broadcast/multicast.
> >
> > -     Default: 1
> > +     Possible values:
> > +
> > +     - 0 (disabled)
> > +     - 1 (enabled)
> > +
> > +     Default: 0 (disabled)
>
> Same here.
>
Thanks for feedback , will change it and look for other mistakes
> /P
>

