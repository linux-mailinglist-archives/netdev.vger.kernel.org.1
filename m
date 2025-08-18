Return-Path: <netdev+bounces-214699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00949B2AEC2
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F33564528
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685DD345745;
	Mon, 18 Aug 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4F5RbZP/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D49343D69
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536338; cv=none; b=XmLfy5JL/pShHDojUINnQJUlV6AnG2Aw2jECTJW6++cGTOcqZeMryhtAIhJWppP/g3l4nLBwVJt/+tsiZu4osTHqeFDw1vcQV+P8PWN+2u7zoUVcXzDGXyTSyU7QZXzZ2wj/uo3NEDn6la7gofqLrulPQ7OsCz4ElJUMVZQkts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536338; c=relaxed/simple;
	bh=p3B2R6aWiPs6A7CSWvjKLk6T3ok9VaClfEOPI/l8ICQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvyQeq1xxQ9hR6B/FSYCWB0WzU+aoRpd7BE2z8NWS03dVjbOuUZ3QcG2PgGwjGsSlZCbPCJWoxt/+qLBUmGvHp6p3aH6OXvLdtau+C/USg9fzo3c0X5Rk5s8bC0i7gmQwEOKkwTcmKjTFLh8oPZAwWe5dCkrFOokAVePblLC3vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4F5RbZP/; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109c6b9fcso41840571cf.3
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755536335; x=1756141135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDHDb/C2H84Q+lQJukTeAn8mnYueu1KVL2ulPYI19q8=;
        b=4F5RbZP/D9JTkvUenJLR8BvXcBpgjQNrdH0OCHARd6Uh/2BdehfSYz9i8XmIbpizR9
         /BWn1maJdZstCTf4iVNh0EzkoSMWgxVxBYPgyPUo13M9HysBwny+yqPJEeybxXIsywO3
         XaSiw6pW859wV3daY3IidEv0G+Dv17/Dh+T0EI9ysxCSvzDGc5MnkWqkYRNtcrx53gen
         CISpMsdQB9wm9Uv5/q8I4IYUQ2ylYVeosKpOeLNAajmooKJn9U/B3/2GA6ovEpVHoxhq
         +NLdWaAsPSXgc/RnBuPZB3MjmMw6/cRIdTMNivo8n1qyyrUYV6i800s2xbEeEUMSREip
         TdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755536335; x=1756141135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDHDb/C2H84Q+lQJukTeAn8mnYueu1KVL2ulPYI19q8=;
        b=RyWhWSpfc6rqmDiNAn/pI/ncDMFWkxKdd1gGshchHul2VpTpGUUFPhD/Irdx5OnQTd
         zWq8lRrR2+Vs3VYcZfx2CIiC+6z39CPjjmko+TcHZRG3sdxvTs9E/JULt5YaO0GCwF/1
         +4zowxr8mrR2OYnOOYhrLdPiQSXuucuuy/KZYvvTeeZO0Q0VBBRzcM7SnNN1x7FNB0pY
         LwBB4zvzH04oByyA7XtgCVWqISAOSTji3eEbksWe2yKGiUxKx94pYZHJkRtI5Xz5D9b5
         DpHqztWI6VM4nYsTf+y7R0Z8cdX894SIByFB6bRcmc3cQZbaF+CW5AQRZixJxxb0IoZm
         97xA==
X-Forwarded-Encrypted: i=1; AJvYcCWiCSVjsVlTDTIu9NwGVAdmWHTT14+yrEswsnoXuYaLeMZdsRi3pDl/lH1VTOq8TyIJ6SK76Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmRNruUPWTNxj/+xz4zJq35L+X5XSbT6EX8Y6Dl8LfZHsTpWv
	c6UEzBK/LQDZ/yJC0PfIwgT21WKYlAXptTAmtwCdEzhR9W/wlZYN4cjnDU+B/6kH+tosxE293G/
	Wgb6rNX5MoFDgZyfWsx+b8mlLj81mEvou16Rew3IM
X-Gm-Gg: ASbGnct0UUclNaGIeOwGRLtnFhHRlMNrekzMlp4iBZbJ/oNZ6hqF5o9Wb7VVeLdqmDC
	AsKpe8WiKo9AT9RGo7mJJerXPYywBPEHDFiapdm5u2LeZdwtMsfjlGfJwRYHChGxL3YuQuDnKkE
	LX5RntmdbrX3NlBXAftpQrUR9vrjTYvx6MmZFz+cVDxMaat9Zkr436N+uulQXjr68s1M5CSdCJ6
	EBlg5w4h1nG+qBil60=
X-Google-Smtp-Source: AGHT+IGmJ4mnfL5FqQtImDyqbmLr8KCmFM75FY8ubsT1KIUDOiNywm2giVJ2jvVz1iup0LaOvKLIDCWtQ0/OJN4WkYU=
X-Received: by 2002:ac8:5813:0:b0:4b1:d6e:f03a with SMTP id
 d75a77b69052e-4b11e2cd43fmr148785111cf.63.1755536334704; Mon, 18 Aug 2025
 09:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3edfd3ac-8127-41c2-afc5-3967b8b45410@kzalloc.com>
In-Reply-To: <3edfd3ac-8127-41c2-afc5-3967b8b45410@kzalloc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Aug 2025 09:58:42 -0700
X-Gm-Features: Ac12FXwchqtMPDdyef8PmWwAFtLMe2-HRyv7KFfiL8tS-4s9vEtEjMcDaXkbhpg
Message-ID: <CANn89iKCE2ofvPTAcUbLCKE46_y3gMs_tdh1D5214WnAs8Fjmg@mail.gmail.com>
Subject: Re: [RFC] net: inet: Potential sleep in atomic context in
 inet_twsk_hashdance_schedule on PREEMPT_RT
To: Yunseong Kim <ysk@kzalloc.com>
Cc: "David S. Miller" <davem@davemloft.net>, Florian Westphal <fw@strlen.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 9:46=E2=80=AFAM Yunseong Kim <ysk@kzalloc.com> wrot=
e:
>
> Hi everyone,
>
> I'm looking at the inet_twsk_hashdance_schedule() function in
> net/ipv4/inet_timewait_sock.c and noticed a pattern that could be
> problematic for PREEMPT_RT kernels.
>
> The code in question is:
>
>  void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>                                    struct sock *sk,
>                                    struct inet_hashinfo *hashinfo,
>                                    int timeo)
>  {
>      ...
>      local_bh_disable();
>      spin_lock(&bhead->lock);

Note this pattern is quite common, you should look at other instances
like inet_put_port(),
inet_csk_listen_stop(), __inet_hash(), __tcp_close(), tcp_abort(),

>      spin_lock(&bhead2->lock);
>      ...
>  }
>
> The sequence local_bh_disable() followed by spin_lock(), In a PREEMPT_RT
> enabled kernel, spin_lock() is replaced by a mutex that an sleep.
> However, local_bh_disable() creates an atomic context by incrementing
> preempt_count, where sleeping is forbidden.
>
> If the spinlock is contended, this code would attempt to sleep inside an
> atomic context, leading to a "BUG: sleeping function called from invalid
> context" kernel panic.
>
> While this pattern is correct for non-RT kernels (and is essentially what
> spin_lock_bh() expands to), it causes critical issues in an RT environmen=
t.
>
> A possible fix would be to replace this sequence with calls to
> spin_lock_bh(). Given that two separate locks are acquired, the most dire=
ct
> change would look like this:
>
>  // local_bh_disable();  <- removed
>  spin_lock_bh(&bhead->lock);
>  // The second lock is already protected from BH by the first one
>  spin_lock(&bhead2->lock);
>
> Or, to be more explicit and safe if the logic ever changes:
>
>  spin_lock_bh(&bhead->lock);
>  spin_lock_bh(&bhead2->lock);
>
> However, since spin_lock_bh() on the first lock already disables bottom
> halves, the second lock only needs to be a plain spin_lock().
>
> I would like to ask for your thoughts on this. Is my understanding correc=
t,
> and would a patch to change this locking pattern be welcome?
>
> It's possible the PREEMPT_RT implications were not a primary concern at
> the time.
>
> Thanks for your time and guidance.
>
> Best regards,
> Yunseong Kim

