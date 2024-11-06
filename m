Return-Path: <netdev+bounces-142444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959249BF2F3
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EB61F213D2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047572038A1;
	Wed,  6 Nov 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hU/YAvu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727841DEFC7
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909609; cv=none; b=u0BaeAzWuMnOEunSu2Zzt+T7dZy4IakZG5ZftzPH16hdKhlV9V+zoDaO07PIFoN/TJkhVieGaBhBpjlmv7vtdB4/DTJ+8hOeDEwVNLmn1Xp1o8AUrMo/8nKEO26EahTkC8A+NdJgu1f/64Ej1zj7bfzG2MdwUrkBRtPvXMy3uCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909609; c=relaxed/simple;
	bh=bv3/rlPRDtLUJmWm0YAo7VqvOVpmHgyu+NFk1LMsekg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rE0BVBoDlZEum2w7fwwNxUDBBWB8CNSfgsJEVEyWPcIUPBN9jrLZ9qEUo5r1jTvotWeEHuzW2acrmVj8o2Ke7rY7yIUg1Ua3inT5L3P0b+2AWBucNxRIGsVj6s499IQ6LTyRc7JQ54Ox/Thj54i/bSZxmYUXwo1i40zYujsnJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hU/YAvu3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so44022a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730909606; x=1731514406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv3/rlPRDtLUJmWm0YAo7VqvOVpmHgyu+NFk1LMsekg=;
        b=hU/YAvu3V3AKoCL0JQeAwrYpOeqIzwE1bk9WndnCxcDQe2rVvHAu/zO6xOHqI2MG2t
         Kfu47KcbINiUWk3IyPoxp+gZy3KrpmhAQlowXZ90SnMGJVX+KmY30CPcJ5QFWJTunkM3
         vHF+XmTFmUzmj8P6E0FS/AvQLkncgsBmdhMlhd+Nrog9r8LL2scepdGqSq2arA9MP6Te
         HTXFficdROcgyNmHsi9jxq6NwwJUKTQwOeO863YzM3HjwgbI07KjkNHQ67WVR6DJ36GT
         deJMWUfzWokpF1ZuxV+7jjJmCshTEVXeknkNnUWb0Ue4aK0S0Q8v3fiMFtYfijgpQ3UF
         iG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909606; x=1731514406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bv3/rlPRDtLUJmWm0YAo7VqvOVpmHgyu+NFk1LMsekg=;
        b=J0ffhVyDW1Yyyq5l+pEIgrO0W2rM4A6Yg3KPTcHqsMwJR8kaam9xKQkwabcOOyH1u/
         47Y+HydBDHMDEzdXssshxllspj9t7UTBzlhAqFn1jQViXBBytUhs41xwXIjlPNIKD8ao
         ZwRKkvhvZ/cvRjgN4N0B/WOhMZLoaC9/lVlP5IzP1OS4iAZ+qie3kxZWf/Iubh0QYDwv
         puNnFUIhFpbzuxLW8r3r6I0xQeaBVp48ExqdPo3CkVRNZIpPA2PTiev1hW5VnpMw7Zsg
         9eFV3VEMDsudGt7/3gg64hsUo95BH8723ssC8Z6zhkG4Hu6GTmfkk18mmVWvYKmwJE7U
         xn0g==
X-Forwarded-Encrypted: i=1; AJvYcCU+vlug+b9R8OfoRKcrPX684RajROGRF3KoySh2tJvyg8YEphuhGgGhbL7QhE1YAdqRqOnk8hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTcixgJ5ETTsoC223KDNCX7SYgknsWRwdDv+CMeYJ0RRSDn7nW
	FtmDVHOOL1v2wl+EtkDSgf5vXHW/hY0oZXam/JMLOoeZ3C9eadcw90wniIy6KSZafo1aey1Xifn
	ByAGDsiRvz9q444/dBPmZuwDzFtyn7FU7uPSX
X-Google-Smtp-Source: AGHT+IG31oDzIcRRZTXFrc4mSbTzWqOQQfaIeoJMNJyfUTYdBMy9A+Bq3DpljUJqC6apMGKNF0ibhLvsqlER0Z4uNjo=
X-Received: by 2002:a05:6402:280a:b0:5ce:dc71:5928 with SMTP id
 4fb4d7f45d1cf-5cef54d1b5emr3165558a12.12.1730909605487; Wed, 06 Nov 2024
 08:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106155509.1706965-1-omosnace@redhat.com>
In-Reply-To: <20241106155509.1706965-1-omosnace@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Nov 2024 17:13:14 +0100
Message-ID: <CANn89iKag19EPvnQRthsG98pfjriRwtS+YND0359xFijGAoEYg@mail.gmail.com>
Subject: Re: [PATCH] selinux,xfrm: fix dangling refcount on deferred skb free
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 4:55=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> SELinux tracks the number of allocated xfrm_state/xfrm_policy objects
> (via the selinux_xfrm_refcount variable) as an input in deciding if peer
> labeling should be used.
>
> However, as a result of commits f35f821935d8 ("tcp: defer skb freeing
> after socket lock is released") and 68822bdf76f1 ("net: generalize skb
> freeing deferral to per-cpu lists"), freeing of a sk_buff object, which
> may hold a reference to an xfrm_state object, can be deferred for
> processing on another CPU core, so even after xfrm_state is deleted from
> the configuration by userspace, the refcount isn't decremented until the
> deferred freeing of relevant sk_buffs happens. On a system with many
> cores this can take a very long time (even minutes or more if the system
> is not very active), leading to peer labeling being enabled for much
> longer than expected.
>
> Fix this by moving the selinux_xfrm_refcount decrementing to just after
> the actual deletion of the xfrm objects rather than waiting for the
> freeing to happen. For xfrm_policy it currently doesn't seem to be
> necessary, but let's do the same there for consistency and
> future-proofing.
>
> We hit this issue on a specific aarch64 256-core system, where the
> sequence of unix_socket/test and inet_socket/tcp/test from
> selinux-testsuite [1] would quite reliably trigger this scenario, and a
> subsequent sctp/test run would then stumble because the policy for that
> test misses some rules that would make it work under peer labeling
> enabled (namely it was getting the netif::egress permission denied in
> some of the test cases).
>
> [1] https://github.com/SELinuxProject/selinux-testsuite/
>
> Fixes: f35f821935d8 ("tcp: defer skb freeing after socket lock is release=
d")
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lis=
ts")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

Can we explain why TCP packets sitting in TCP receive queues would
need to keep xfrm_state around ?

With thousands of TCP sockets. I would imagine that a similar issue
would be hit,
regardless of f35f821935d8 ("tcp: defer skb freeing after socket lock
is released") and 68822bdf76f1 ("net: generalize skb freeing deferral
to per-cpu lists")

We remove the dst from these incoming packets (see skb_dst_drop() in
tcp_data_queue() and tcp_add_backlog()),
I do not see how XFRM state could be kept ?

