Return-Path: <netdev+bounces-224044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855D6B7FE88
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE949624BFD
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C975292936;
	Wed, 17 Sep 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hruhWcjs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1395291C07
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118181; cv=none; b=Diw7s8vs+T7eCCUI5Jgqwk2JHVXI04uZgzWu6N9oAujFDgeGLWY/BAjLAgepv4mzTdILLx4XCJlV77TK8TmaXZXVyKInKX2MWNOnpZcYYt42dzouIVKNe9YhgQkJLYLamJBWqzlBzBYjXGtsrJNXA4iVaCT5x4UBm4wjDV5Vp6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118181; c=relaxed/simple;
	bh=ZothtfKO7aaqFLyfUGVAsvQjW0P77GqQnn6jpX8mzag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eh2w7ViD6WUu6sgGNQvlommTyb18m7rjG3ULGTiZ+6HQSn80xl0JUTFLpS/tioy4ez0ad2N0i/pdqc5YXcJHfXRMNc1DNTW8B0ba4ecWcuk+WTHZ1qOOI9VTqSZL0vqV0gom+kX7896U73+U8CBT3cvhZo60Yx2FT6fnQRO7GZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hruhWcjs; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ea5c612297bso451323276.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758118179; x=1758722979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZothtfKO7aaqFLyfUGVAsvQjW0P77GqQnn6jpX8mzag=;
        b=hruhWcjsPqAkPak6faTUh/fuSYnhlfpQ/+Up9Zvqb3ilXRDoRtG7E/chCdjB6NftOG
         mcVUeXwOmNzqXoHYIsz29pawSvEYfFyRLzG5sa4gb4d7sM/ZAXi7YqDN3aKm23VnM92B
         NAJWKkxvZ22R4RtzR5XjbtgmN2hm1kGWrXTpJRjmDT2iXVgx6zL4L0R5tB1g8wUquaT7
         Oy7iuFDe3a0GSYQy2P9tTJfR3g1zlLUfOFYzFSjjVtYjYHqbcOvEAQ3BGHoEUJ8mtanS
         oMHM58aQYN6qe0HwoA7PC8yA4pbJYYCz7cgLHTNB6gPXuBxqyUd19mXguldLH6Cgighw
         wl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118179; x=1758722979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZothtfKO7aaqFLyfUGVAsvQjW0P77GqQnn6jpX8mzag=;
        b=VZ+zz9MTIq/EPkTrR/m5RbVUqPkrx+T6TN0BgX5Icf73Cu16sXulfIC1TSYqsZEQTQ
         ICZyx/kpvQxoyeLLT0kpMfvH6/fY1b6AXchHGYsxbxlX9SlV/0KolP5//9dHmtV1whwf
         z/9K/+xjxL/fSv+f21tcwTlmiMWTQMkNtB4IAI0H+eUXaVObeWcz2GeGeNw8Rea+mT3Q
         xEMTOywhVon053FhPeydtrbOYxGgEoASdSt0OQQYPlqwJH5XrLs87ynprOMXF+444Pgn
         DycxO3md5wjNP7Od16e86AUApXPIuntcE7lxenm8uopgOJH4UzE/oAtFpAGtiVPXVFj2
         q4kw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+nsTCYBC6zrglMu0PIxO0vxodlTfEYlloKWss2t3/FUyFF3fuZte5qekDLkuWQeemdXOMyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd4XNpS3NDjDKnlCx8ltewKAACwStYns2YZDA9d+GwRGF6wCfg
	jWmSyyFwascR8y8k08sExZPi6tyP9VootzcRd1meRN6E/s6wJOwdOdr9GWOkuTBsq3rIErfw7Jt
	nrwWafd4IQtDAVfBj7EUiG+hdy8/6xXQgH2ueC6BV
X-Gm-Gg: ASbGncspGVx7H/aXJYZK0wnpKcakQ3dqTWT808eN4Tvol1d0tI79p2QLel10rtl0Ec2
	iPCaOapRjEPRpAhEMIQibzIjVdcdV38HYXJjXSY35ZNdQX8faOh4ej88ZcsO3r/8ojqca9QpSZL
	JKJ4gQxqDaSnhWcv0Grfrel11775bRLP5BT0nbkT1j8iHerb3ZHMINqlB+uYUug0HTXwFoqJcze
	HJ8sMb9XG6P
X-Google-Smtp-Source: AGHT+IGPsm9qlvsaWaOQ0Up4+YrvSYG//gaNCGpPq4PzflQy70uPMncGPfmgc7QX+79taCdvY65HUJ++xh0Q6CvLepk=
X-Received: by 2002:a05:6902:4209:b0:ea3:c162:3f3f with SMTP id
 3f1490d57ef6-ea5c0360690mr1757885276.15.1758118178039; Wed, 17 Sep 2025
 07:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com> <20250916214758.650211-5-kuniyu@google.com>
 <e1bae4d7-98f7-4fe6-96ba-c237330c5a64@linux.ibm.com>
In-Reply-To: <e1bae4d7-98f7-4fe6-96ba-c237330c5a64@linux.ibm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 07:09:26 -0700
X-Gm-Features: AS18NWBHtWj3yNRxOprYEXtavqN9ZTcr5UVf6xvEmYzKrCXN4clJXGpKjhe9LCU
Message-ID: <CANn89iL39xRi1Fw0N4Wu6fbNjbbNjnYS4Q8BD3q+8HrY2XB_4A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/7] smc: Use __sk_dst_get() and dst_dev_rcu()
 in smc_vlan_by_tcpsk().
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:14=E2=80=AFAM Mahanta Jambigi <mjambigi@linux.ibm=
.com> wrote:
>
>
>
> On 17/09/25 3:17 am, Kuniyuki Iwashima wrote:
> > Note that the returned value of smc_vlan_by_tcpsk() is not used
> > in the caller.
>
> I see that smc_vlan_by_tcpsk() is called in net/smc/af_smc.c file & the
> return value is used in if block to decide whether the ini->vlan_id is
> set or not. In failure case, the return value has an impact on the CLC
> handshake.

I guess Kuniyuki wanted to say the precise error (-ENODEV or
-ENOTCONN) was not used,
because his patch is now only returning -ENODEV

Reviewed-by: Eric Dumazet <edumazet@google.com>

