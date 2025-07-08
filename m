Return-Path: <netdev+bounces-204755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 161A3AFBFA6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A0E7A7C72
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 01:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603681552FD;
	Tue,  8 Jul 2025 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE0sXEr7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F20800
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936780; cv=none; b=e5s5lwvM4GEjeBqppLRDxCOptaWpbukYWKs/pi2cBBAfu9MbAuzeyRqt7Ncep6KJ5keMIh7h0oSXX1GA7MXJmMFIKzbZQH8EB1BilE7uW3bfxal6ZChYdeYtD+7bnGF3wCfCDMAyQ36bjneRJIDq+hEGm/wcV6r7x3TkJ0f/mDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936780; c=relaxed/simple;
	bh=/fT/NmXMuVa3zCMvooo8p3zOpfWbMfhF8Yi8tZSEURs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=I6Py+FzRCDq4uxkVffoGIaAmGNwiFU+XvxNtG3TAnxJYQ+7s2WXcJVuWxLT4o9rPvsdoGO8bZ6UvSe+ebvRAcqYl9BhO2pcUxBIPU4K9YgZJaV+kSZE5oFhROSPjrH87CCJitrmXbvWN+LknrTwGJNs6h45QqvpagTRGsjOYBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TE0sXEr7; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e82278e3889so2790758276.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 18:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751936777; x=1752541577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsLlTnDeaQzxI/x9yKHoCPOzvBNsBs2AFj5oKDUt38k=;
        b=TE0sXEr7m6O6jFO6r6FaC16OmEYHW2atFLPSj71iWV8IeQkfG5gehrbxoiOsGOlVi3
         +t80tNBbOML3+st2VVIMQBwU3OKNVTeTVY0PwGJvKHYxRh0kK07w4I+JUeTyO+UVayND
         ACilRjJcs7Xe43JAfE6XuC//mtk5ruEkGMOw5Gq2ePOUHSoccE2kd6V9o/Br22Udlrne
         kI02SDed4MHA6M+zxfz+mOvOGMK9APW+MHJHzMwR5PcEs4nxdYPqhmZZpXj017Olh9up
         2VcpQqmnUBFhP/AWQ/3SfHwOAOHf/iZJHQ0F84QFCsvXcVXzNZG2eWI2S8FteJMRBXqL
         7t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751936777; x=1752541577;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VsLlTnDeaQzxI/x9yKHoCPOzvBNsBs2AFj5oKDUt38k=;
        b=KXib2B6aV/1Nr9DVOq/NWx8jVgMlzv8XiR6d/q3oI3ufTfamB9wGvwzVByK02TjsiM
         XcMS/WpI+mCMEJ1VRPif8GQ4Iwbs1Bbm6aPGDa2jDQpZtmC8uqjuYvYOhbzCYPA4ZIn1
         Xcysn4viMm9542TTVX3TrBbHxls/o9T6ZtK6hkbiXlKK1yRiSy9C2aWTzNAhK7f0FISL
         gF/vDCQwGv5WKhEwreb3pEftZ1Q8o0iQ/CTXMn1NKE7bRDwWXL+0S36nitBATYMAvaPb
         pzPJAoeFLGQhPe652W+/YuNdSZLhwN1BDYfv7/K/qRvpwJUV7nrpc2aGGmi2bGwRV1OA
         OD7A==
X-Forwarded-Encrypted: i=1; AJvYcCW77YIbpk4aHMTGCWzQ8KJytCUp3M0YM8zS/Wn1yB+yMVLLLGnwtHt2HsIi6FqrF+YtTetPw7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7++KAvZMc7R7BX6BcA0+95H/sHiZYYQwEiEFq8GoHxKtnPoIi
	oRLa7D1z96sdgG4rpMHvo6oAXUbmd1Db+scTwu4DrzjNkK2/glDGXum5
X-Gm-Gg: ASbGncsK6DQV7sbjTT4RTJfkTjcOxs/cd2NawXPaqHFI56JOcLBFo+QfV2SDsK2C/cN
	VrtkP+DvEwewhuIxvMRn6vi3vOaI6uJUgIbJGq2w4huDiTMjpPxV6v7N1lmRCiqeaRZfUPTJBHd
	qV7BB8qrBYiW+ScE571Iyn9W5V4r4WMIUkouI3fZRlxgCmWEWUHjrpUIcVQwkQlB9mbM1RXsOns
	sNaS3H1o9qaBXn8ukLyAHsDuVx1ILVWJRLxCgP2LSqXE4FsSSdgNzEHlv7UMYtR4EVWgTPdIzte
	RSinJ7iD+HOXcNkIyyxAIxbQTu9zfp19fKlRLvmaToZJ12OzZcnBvNqY5HGRxDrTtiqdHM27SqH
	HavhgaCEfovLOMcJUwRKot6AZral6EclIK6sDDz0=
X-Google-Smtp-Source: AGHT+IE4qAfvwzCqIZ7cWhk0QyUr+XAUyEf94c5MEmSy9nwAFyAP5PJPzChOsNrGxp7/IWjcLCwKlA==
X-Received: by 2002:a05:690c:740a:b0:710:f470:154f with SMTP id 00721157ae682-717a0464c48mr12169247b3.34.1751936776682;
        Mon, 07 Jul 2025 18:06:16 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71665b121cesm18671057b3.90.2025.07.07.18.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 18:06:15 -0700 (PDT)
Date: Mon, 07 Jul 2025 21:06:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686c6f073133f_266852946c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250707141919.3a69d35f@kernel.org>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-11-daniel.zahka@gmail.com>
 <686aaac58f744_3ad0f32943d@willemb.c.googlers.com.notmuch>
 <20250707141919.3a69d35f@kernel.org>
Subject: Re: [PATCH v3 10/19] psp: track generations of device key
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski wrote:
> On Sun, 06 Jul 2025 12:56:37 -0400 Willem de Bruijn wrote:
> > > There is a (somewhat theoretical in absence of multi-host support)
> > > possibility that another entity will rotate the key and we won't
> > > know. This may lead to accepting packets with matching SPI but
> > > which used different crypto keys than we expected.   =

> > =

> > The device would not have decrypted those? As it only has two keys,
> > one for each MSB of the SPI.
> > =

> > Except for a narrow window during rotation, where a key for generatio=
n
> > N is decrypted and queued to the host, then a rotation happens, so th=
at
> > the host updates its valid keys to { N+1, N+2 }. These will now get
> > dropped. That is not strictly necessary.
> =

> Yes, it's optional to avoid any races.

Ok. I think on respin the commit can be revised a bit to make
clearer that it is an optional good, no packets will
accidentally be accepted with matching SPI but wrong key.

> > > Maintain and compare "key generation" per PSP spec.  =

> > =

> > Where does the spec state this?
> > =

> > I know this generation bit is present in the Google PSP
> > implementation, I'm just right now drawing a blank as to its exact
> > purpose -- and whether the above explanation matches that.
> =

> I think this:
> =

>   Cryptography and key management status:
>    =E2=97=8F Key generation (a counter incremented each time a master k=
ey
>      rotation occurs), when master keys are managed on the NIC.

Ack. I saw that too. Unfortunately it has explanation why it's there.

