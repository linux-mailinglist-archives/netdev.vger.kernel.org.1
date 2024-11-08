Return-Path: <netdev+bounces-143155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C089C1463
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897601C20A10
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2017C14012;
	Fri,  8 Nov 2024 03:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj+auV+8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C491BD9C2;
	Fri,  8 Nov 2024 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034916; cv=none; b=Et765aAwmpAvjykARfWwg3zPC+JRgX6oy26CHXVFsnNVv/g3vhuwudZvitN4bWlkGzrBIHdhLvSQdV7I2DWoz3By7RbJxhcqzUUIYS+T8Ux0XRIP/avgUJfG/QpSbAOH2syNxDg3WpEZX4873BbB55wCabRiC/Exbe2nnCRcgpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034916; c=relaxed/simple;
	bh=jh5QLIklCuSffsX5HHrs2unmHbDfZrVTv4LkHr+NLfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gus5AydZMWshXSddPE7F82ui8ZMbRtlsq9jZgdVfWN5AZln+x3AYlXO7g2zQSKTNqa0g/5CraKj2kTE+VnOWt8OK2+A3FuIK27PvdmK2oyJ7WpOsVPpCgcxeTnvVIRIWDUEsJn3ulLrP/TRsSq3g1dRbdUGRfZhC8pDsPnibJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xj+auV+8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ce65c8e13so18622615ad.1;
        Thu, 07 Nov 2024 19:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731034914; x=1731639714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2AFkIv1SzzbZMo5JYC3sgbdI5jWNWjyyxyaxG1ONBas=;
        b=Xj+auV+8XIovxNqcvhKoldS7Y5n3MfAv48k34QToSREWR8sML3jUr3833UPI8phvb9
         sNbCkgfU1tcrK2j5dmO6RcxKjkLP6USpeBurfCPOWXNk8C1Fh59xrmKkh8aeWaUNgki/
         S2y2VqCixpgT6M2TEAanjxpelXD6UHVrNXsBrZSwitBPxYQK1loRcyH4zcdPlNZpd3Xa
         v4ulEPWA6TwMqcmYdUlKaxI6yt8UR7MqF+zA6r5yzmL5h+dg6J9BUeyWfb7Nz79rZ5hT
         /jpLmNu9ylcNnGDX4EZYjPX2cPmsj6Yx6I0iTpcDzjcXC8TErlc2g5WRygOGFvhpsvbP
         6FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731034914; x=1731639714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AFkIv1SzzbZMo5JYC3sgbdI5jWNWjyyxyaxG1ONBas=;
        b=JiywJtlTpXEAcZagz4Atr1YMZTLgO9M2vBHH1vryF3w3TmVRhQwfhylP+c0aE7g79+
         trhGg2j91qfOZQDfj4oAJELZJz2zkFLnTH3Gwwn142B0lLLKRgzFYcEljfQKy+kF/wKT
         WMi3gVbMViQJoXoRoopFNqCHUiOXqJ2Pcpaibow/o2XK43bx8kx/0SA58lkWveS/OHoH
         3hXbt4WlmHhtt2aFw0wUTVfJ7UM7As6faBzrCoeLf43X/LNRhAfSMK52TCha1xjW7i2G
         KIQqghR7zPktdqB8ubV3MNGk/kp6KQCVSckvfU16A/EgK/7jitAbBTbLiL5lDuRvyl6p
         ItzA==
X-Forwarded-Encrypted: i=1; AJvYcCW0cJKHFJluuXVegUzlANKex0RK0PFHZ5mWOTdQuyUYOaJBioSBFnEJznNjCNKasJ/TfcyEbq0j6BQ=@vger.kernel.org, AJvYcCWmvzrQEYf2rONjGW1HMQedas06A/tnRb2VJgZo7xropvfCYowJbXSDzmoxi3y2rw2gHA8nbVRY+THR4w0X@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gFizOHbC4a3wP+Lb5B6hmFFCjry3c8vxT9VS3YzAEGkuqo1v
	wT7aQA4cFw433KJsI3GJSM8sRGVJdAXwJQupjg/taCFATxCHQOg=
X-Google-Smtp-Source: AGHT+IHUqWILqJFNgB/xW1oz/3+eUiw2vIPL5tpyxz94DFjCJ6fiCYhx2hDJejDi2PBvvkZtB2NTaw==
X-Received: by 2002:a17:902:e805:b0:20c:5c6b:2eac with SMTP id d9443c01a7336-211835ccb49mr14277365ad.49.1731034913729;
        Thu, 07 Nov 2024 19:01:53 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc8264sm20525145ad.33.2024.11.07.19.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:01:53 -0800 (PST)
Date: Thu, 7 Nov 2024 19:01:52 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Yi Lai <yi1.lai@linux.intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net v2 2/2] net: clarify SO_DEVMEM_DONTNEED behavior in
 documentation
Message-ID: <Zy1_IG9v1KK8u2X4@mini-arch>
References: <20241107210331.3044434-1-almasrymina@google.com>
 <20241107210331.3044434-2-almasrymina@google.com>
 <Zy1priZk_LjbJwVV@mini-arch>
 <CAHS8izOJSd2-hkOBkL0Cy40xt-=1k8YdvkKS98rp2yeys_eGzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOJSd2-hkOBkL0Cy40xt-=1k8YdvkKS98rp2yeys_eGzg@mail.gmail.com>

On 11/07, Mina Almasry wrote:
> On Thu, Nov 7, 2024 at 5:30 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 11/07, Mina Almasry wrote:
> > > Document new behavior when the number of frags passed is too big.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > ---
> > >  Documentation/networking/devmem.rst | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> > > index a55bf21f671c..d95363645331 100644
> > > --- a/Documentation/networking/devmem.rst
> > > +++ b/Documentation/networking/devmem.rst
> > > @@ -225,6 +225,15 @@ The user must ensure the tokens are returned to the kernel in a timely manner.
> > >  Failure to do so will exhaust the limited dmabuf that is bound to the RX queue
> > >  and will lead to packet drops.
> > >
> > > +The user must pass no more than 128 tokens, with no more than 1024 total frags
> > > +among the token->token_count across all the tokens. If the user provides more
> > > +than 1024 frags, the kernel will free up to 1024 frags and return early.
> > > +
> > > +The kernel returns the number of actual frags freed. The number of frags freed
> > > +can be less than the tokens provided by the user in case of:
> > > +
> >
> > [..]
> >
> > > +(a) an internal kernel leak bug.
> >
> > If you're gonna respin, might be worth mentioning that the dmesg
> > will contain a warning in case of a leak?
> 
> We will not actually warn in the likely cases of leak.
> 
> We warn when we find an entry in the xarray that is not a net_iov, or
> if napi_pp_put_page fails on that net_iov. Both are very unlikely to
> happen honestly.
> 
> The likely 'leaks' are when we don't find the frag_id in the xarray.
> We do not warn on that because the user can intentionally trigger the
> warning with invalid input. If the user is actually giving valid input
> and the warn still happens, likely a kernel bug like I mentioned in
> another thread, but we still don't warn.

In this case, maybe don't mention the leaks at all? If it's not
actionable, not sure how it helps?

