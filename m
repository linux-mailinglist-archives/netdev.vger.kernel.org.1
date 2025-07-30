Return-Path: <netdev+bounces-210993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C020FB160F9
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A72716D74F
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674AE239E66;
	Wed, 30 Jul 2025 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkyQETrw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF08420298D
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880818; cv=none; b=geB/uxcPnGOjBrI8O5u3pd4k/jmfWJ7l/AAxTCFIcYHj5FFgTarzK9jNnFHIKiYjUc+K/UHFNaE0uQmjOrWJe96n844ZlZ/dq+rrzJeSnEdGjL0f6CspbQbXqLVgNZgDsAQcDUZmvoGSAU8UJ4nVGQ+tbIlyg/J1ZcBDFx14J7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880818; c=relaxed/simple;
	bh=H6HrHP9Z6j7fVd9VELJ9mCga3Ltp+SqW2gCi4mxumR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKsNYHGhMIyHqTqcV6dXndjwmXMd8gQEwBSnAGY8cC2zVyb4Z47F1KjLbxO79ffP3o7ebGXY8oXi0BFeEIlHcDeyEMHbxBzavQcVo5zCOWrLMLXU9NYPlo2AftGEBQJAlOoZ3rEygx6JhxfB9xxBsWUiV0hPDLN0p6LIs2wv9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IkyQETrw; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4aba1bc7f44so7960651cf.0
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 06:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753880815; x=1754485615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Gd4gZDAU/H/TP06oCUARLggQtU0wLz7dj+H+6HJ5Gc=;
        b=IkyQETrwmWMYv7+TSX8vjoOrAIcdSkxfzzwou9nGigr41SbcIzP1pmV3RpI7NbI73O
         vVTSS/n7fdmJQdtYsiqmdrS1J69xtihlyjvhJruSuQAlYYMOWEJ9LnjRS0QaNVI0C+SZ
         jtT6ZiH1i87h+JNaeojnA8JSiPXFJvlQiVgcplTMw2e3EoLQucElC9V9bVLaAQNk5zio
         vlP06b3gkPAaRINeVAebDw2A9KJ2P13FRWb8S/vF6QPVEEmHg5Qyr2pitnzovEv7BQPJ
         q7wYdw0r/JL4zm1iHqIN8v7e3ITPr23PaRJoSc6eirejXxCc5jaccBl2fuVfudw+SUEr
         GGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753880815; x=1754485615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Gd4gZDAU/H/TP06oCUARLggQtU0wLz7dj+H+6HJ5Gc=;
        b=LQwkGyStECrQq2iIxi/eGA1JZxNBKYqNF6KTv+uR0tcLYC5z85j3EyF5gD2+r9kwMY
         VyHOGJZfRGOTOa35cH9Un6JTOI72vIuDxyDIbpH0tnXpzg1dfFSyjdKD9IPbXoF8zV3N
         gFWjBJbd3wREc0D5HE0d4Y6cFyvOqaw33zPQyyBAtENcatriaugZRYi9GNjx6H+g4vfM
         0Fv+BzlydNNCotAd7R6YV21aMoDuqCAwuBj53L8KLBYjWNdTcjoJfBfXRPs1A+vdiVgE
         FqM8Shxjd5lb0ZSPV+qiCJfQycC0XW4Y3Kz36WoJsCH9AdonxTthTMi0h6qg9Mrx3alA
         i95A==
X-Forwarded-Encrypted: i=1; AJvYcCWe7Gq2YXIpax3c+1tRK2BIthFS+9VFmAxYfO7019Ry7dPJRsFSn7SD6U/zd24reyhug2aEGHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGX4C4fLekiPVdFprruAIfOYfuVr35YHSSwXVw6VK2fVHys25
	W3IWcnofHEIzhNwW1oRbQYIEOpR9oFFUWVxw/WrnTieWJDQ+NcciugltpIG8CwPtR+we2CjxpCa
	kvld/V3B5X4/iKZWz3JivygN9FIfMcTOMJB3cU2kt
X-Gm-Gg: ASbGncsEJF1j9YAl+eRuEpGzK1bvGM8TAOW7veWXwsUX5rMywoROWkVnBSA1HFSYt0o
	cSL+LkfkLJWMvBYjt9PsDiDTm+NJwG+TOk9HiqipLJfiyCvYYzrh8+A7ufkP6Y/f9wl/AcMgNTX
	EywjmJAJdd3AvfJunQ6MpDJq5cZ6vQ3gROaE9i5zO43804SfkPTjysU0DYRRRGCsNHtwK3t01W8
	1refQn0
X-Google-Smtp-Source: AGHT+IG4JZQFw0UFe1lylbd1YIKZPZNSrOXSl2m9Q7QGXSNaa3P4gY/WPiHjXgJtrlRpmoVZbvK7lwSU+dk6o5qf8Lg=
X-Received: by 2002:a05:622a:15cf:b0:494:9d34:fca5 with SMTP id
 d75a77b69052e-4aedc4578fdmr56402831cf.13.1753880814865; Wed, 30 Jul 2025
 06:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730105118.GA26100@hu-sharathv-hyd.qualcomm.com> <CANn89i+24eme6OE-Q2TVQfyDqHTtMqatwyimxt_nX15OMKincg@mail.gmail.com>
In-Reply-To: <CANn89i+24eme6OE-Q2TVQfyDqHTtMqatwyimxt_nX15OMKincg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Jul 2025 06:06:43 -0700
X-Gm-Features: Ac12FXwD9r-w5iForxhB3h6UaSiRTkR2bWdNG3qeF8RNRgYiyeNdz8CFFFxTTmk
Message-ID: <CANn89i+srU_hJcfRbxcNg0cg02VkGmcPWCUV2k9vgh2+rzhU7A@mail.gmail.com>
Subject: Re: [PATCH v3] net: Add locking to protect skb->dev access in ip_output
To: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, quic_kapandey@quicinc.com, 
	quic_subashab@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 6:01=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jul 30, 2025 at 3:51=E2=80=AFAM Sharath Chandra Vurukala
> <quic_sharathv@quicinc.com> wrote:
> >
> > In ip_output() skb->dev is updated from the skb_dst(skb)->dev
> > this can become invalid when the interface is unregistered and freed,
> >
> > Introduced new skb_dst_dev_rcu() function to be used instead of
> > skb_dst_dev() within rcu_locks in ip_output.This will ensure that
> > all the skb's associated with the dev being deregistered will
> > be transnmitted out first, before freeing the dev.
> >
> > Given that ip_output() is called within an rcu_read_lock()
> > critical section or from a bottom-half context, it is safe to introduce
> > an RCU read-side critical section within it.
> >
> > Multiple panic call stacks were observed when UL traffic was run
> > in concurrency with device deregistration from different functions,
> > pasting one sample for reference.
> >
> > [496733.627565][T13385] Call trace:
> > [496733.627570][T13385] bpf_prog_ce7c9180c3b128ea_cgroupskb_egres+0x24c=
/0x7f0
> > [496733.627581][T13385] __cgroup_bpf_run_filter_skb+0x128/0x498
> > [496733.627595][T13385] ip_finish_output+0xa4/0xf4
> > [496733.627605][T13385] ip_output+0x100/0x1a0
> > [496733.627613][T13385] ip_send_skb+0x68/0x100
> > [496733.627618][T13385] udp_send_skb+0x1c4/0x384
> > [496733.627625][T13385] udp_sendmsg+0x7b0/0x898
> > [496733.627631][T13385] inet_sendmsg+0x5c/0x7c
> > [496733.627639][T13385] __sys_sendto+0x174/0x1e4
> > [496733.627647][T13385] __arm64_sys_sendto+0x28/0x3c
> > [496733.627653][T13385] invoke_syscall+0x58/0x11c
> > [496733.627662][T13385] el0_svc_common+0x88/0xf4
> > [496733.627669][T13385] do_el0_svc+0x2c/0xb0
> > [496733.627676][T13385] el0_svc+0x2c/0xa4
> > [496733.627683][T13385] el0t_64_sync_handler+0x68/0xb4
> > [496733.627689][T13385] el0t_64_sync+0x1a4/0x1a8
> >
> > Changes in v3:
> > - Replaced WARN_ON() with  WARN_ON_ONCE(), as suggested by Willem de Br=
uijn.
> > - Dropped legacy lines mistakenly pulled in from an outdated branch.
> >
> > Changes in v2:
> > - Addressed review comments from Eric Dumazet
> > - Used READ_ONCE() to prevent potential load/store tearing
> > - Added skb_dst_dev_rcu() and used along with rcu_read_lock() in ip_out=
put
> >
> > Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Note: I have more patches coming, fixing IPv6 of course.

