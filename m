Return-Path: <netdev+bounces-79445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453BA879438
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 13:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EDE281C53
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7806041C66;
	Tue, 12 Mar 2024 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zphrWtR1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C792D27711
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246897; cv=none; b=SO5HIv09laN1+Qq4yljXPmUfAZCYNomQdxvZF/BIRgyoD4INeebFxlr53MGTt8ZIO6LkyLToFU3b8MCGALnkaD0tvvSsfRFLHYDU3+5sNPnG8ERw8pj/kxxE9jpsKjgxO+VYoOicnHijpkb5qQkyMC72ZRB+7kMhxE+Y8OTj0H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246897; c=relaxed/simple;
	bh=kR0tEDOgKaIUv+cPTORVbcVMByNslT3pwaH0KnUvoyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAvQ5FTTvlFfxL5b0IdJGmjunnnAzNEHx/ES4UIYcjTUDY0YJ/+VrbtjWTeO6VJrtmSbE4xyBWlYpnNgrFF9DsXMyIf4QVq0kv9R/vk/InIWY0uNZm8S5iGI/Jivs0uCbq4kGhLr4T2NRV6Py+GtjDXHeuKqPbz86N1l9orzUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zphrWtR1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso8062a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710246894; x=1710851694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mfh1UjKD83DIxA9AQa8yYjvPesUNU0GzJOlhCtJkyho=;
        b=zphrWtR1BnghL2Uhs2GSYRgcDav8sifScTYtLFZDWbAODt+1JDPSF7OGTM/YUe/Z57
         lLVU40aBbTM1TzLIZ9Qx94vjKYN2HuSQU+7zL6f7/X+49dwyiUzJvAr+Ysva89vn3UCs
         TWl4I9O6e52381bDl9BgORXXzbcLovSx477BCVxQ/mSXrsr2BXT3xbZlGBpBZ/w1ECM9
         JSs8iOX5WTpdxV3xJiqOB15g7/f9SOeODnyxEsSL/x63i4NHaMixHjYJi+U+zNREEi5f
         Dj5q9+Iz/Sv1t9MLYauQTWoGawu9E5Rg8xjeGZjt4Nrd7ZNB1D5MrLRIrjP5kZ8iuDOs
         3pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710246894; x=1710851694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mfh1UjKD83DIxA9AQa8yYjvPesUNU0GzJOlhCtJkyho=;
        b=dodZ1ktT1EKGy3gbEKJpEJjmBxSk4TZWyu86YNuZV97IyGiWFFm/+ipkNUuMGz51Tk
         Ia2R/e+ql6gdwZDgPKuh57zUSjshHc5ktKPijOWu4Hq6QKKJTz+O0DkDsqmq3FYoFNIM
         oVnxqBlw1u7YJ7k7sqs8T9oBtlt57dDTzIMHbwd8xzJAKXuumE1bSrEaqlfNVoFZDXJp
         rC8dGtl+7JgjNwqpjPyWaN+v89/xsqLFN//Ay6GxJb/4cOVcRKjhl9JsBsxO5oFcQXVK
         IciVvJBge5VQGa0qWJ2aciDZbVWC+jDs99dJoFM2aFkguVyE3hUPwwMEitFYJSMVL6bp
         ZDHA==
X-Forwarded-Encrypted: i=1; AJvYcCXdNsgKKtv/Lmw5c+pEBNvtXCh+pX9oHy1nMl6F6vlQgCWR6wnQB68fX3MeOQ3+kHAnaF+ovN1qk2u3IhVNRbKofevhx4RM
X-Gm-Message-State: AOJu0Ywhi4vgIecWux9qZwypG6KutJTqqF95IptkOCGJZIRF6D54sZkH
	BWdvb5GD0gqFPwBpzv1tltP0MjNG1VtaySUMeLaLVysGLlURIqsVx7le9R9bxF+21xMEA+gbEIS
	+DqvsBeWqu2iL1WwZbybZK+ezHDxjkA6J3Ckm
X-Google-Smtp-Source: AGHT+IG1DK0iOGIVXmV1a+IPHupfSkd3uPey87zgHgHK67atM7sAV5q2StsWOfCWdAKL9cbjYg03uvGJIFo0wakVF2I=
X-Received: by 2002:a50:ee90:0:b0:568:271a:8c13 with SMTP id
 f16-20020a50ee90000000b00568271a8c13mr134341edr.1.1710246893822; Tue, 12 Mar
 2024 05:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308200122.64357-1-kuniyu@amazon.com> <20240308200122.64357-3-kuniyu@amazon.com>
 <6bc2bab66d3bc7aebbde92d4f268effe6b62db35.camel@redhat.com>
In-Reply-To: <6bc2bab66d3bc7aebbde92d4f268effe6b62db35.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Mar 2024 13:34:39 +0100
Message-ID: <CANn89iKcY54osPG-5kJFhpG4EOodhfoacsM3GNSHJrDM=b3AMw@mail.gmail.com>
Subject: Re: [PATCH v5 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, syzkaller <syzkaller@googlegroups.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Allison Henderson <allison.henderson@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 12:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Fri, 2024-03-08 at 12:01 -0800, Kuniyuki Iwashima wrote:
> > syzkaller reported a warning of netns tracker [0] followed by KASAN
> > splat [1] and another ref tracker warning [1].
> >
> > syzkaller could not find a repro, but in the log, the only suspicious
> > sequence was as follows:
> >
> >   18:26:22 executing program 1:
> >   r0 =3D socket$inet6_mptcp(0xa, 0x1, 0x106)
> >   ...
> >   connect$inet6(r0, &(0x7f0000000080)=3D{0xa, 0x4001, 0x0, @loopback}, =
0x1c) (async)
> >
> > The notable thing here is 0x4001 in connect(), which is RDS_TCP_PORT.
> >

>
> Eric, the patches LGTM, and I can see your suggested-by tag, but better
> safe then sorry: could you please confirm it is ok for you too?

Sure thing.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

