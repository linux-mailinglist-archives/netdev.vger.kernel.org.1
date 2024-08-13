Return-Path: <netdev+bounces-117902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3796C94FBF4
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 04:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3931283056
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 02:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF2B18C3B;
	Tue, 13 Aug 2024 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnv1yj5w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80471BC40
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 02:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723517347; cv=none; b=tUL8GUMhqVZWIE46dmA+KTLvaZ9T4/p5mDsDIbt/SYotRhLIkJMZvXIr2p2QDzGXyxovsax3iktZmy1HEXpO+j4GVhzpXMhzU2zBPhGXD6Y/3Tm/BIndE3wE9Ombv4UowXjaWq1/qrDQVQuSRGEqc7RUiQNWy+4nBdWuLx/6SyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723517347; c=relaxed/simple;
	bh=k3YQOj6iGIDSW+XrHdVhB9psx0AaBSG5fThCZ+lVZI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sl1cRU3bPEXPv62qcxhQRYjl0h6+Ub+FlCywgy/ySedNoDLrbwPzkl5eNzQCyiMDYF1/NlS2dbGL18q8btA39PS8HVJivK7RWtaCjkiKgchaLrFg/WaLvnqF9oSn5NRNuFqElN/cpgqWg1xEbVDYxPSkRLSBId8zM3XA0LpAR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnv1yj5w; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39b2da8537dso18171895ab.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 19:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723517345; x=1724122145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlXRQ/CnXDU4pR7gAkShxSf4a+6ZpNtrOTTkwx/Rbk8=;
        b=Vnv1yj5wEoUfrx4KDqbLmAnJAz81v8D/J6SOy2IUf9rmOR892ChI4CZ7Ya2z2BKhEJ
         jcXJRwyGlGCBnHZ/O4OCANgzqTKcigDfDFSxXxKlI6bNAAUV5VNixnc3U1f5H5LXNEJv
         3RNHj2cFMn5nTE1s6KE4JFzL9WzMEvXrlzwpecUVmEPN7RgBmfpem1N5KymaxsLpMPSF
         ONTiKdx+1cGQe618GmKdevZ4h6n4tzX7YPeim/rc+Mm2KVogIwJkXge86Bk0jSPcwa85
         6BEN7UkgxPTgubF/fPu5lyZIQqxfpQ0I+wZwuO63sXNx5qJPTHiYn0igBUmZpQePDWve
         ItVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723517345; x=1724122145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlXRQ/CnXDU4pR7gAkShxSf4a+6ZpNtrOTTkwx/Rbk8=;
        b=lKk3IyOpABcmpa4J1fNDEz43FfK0f3xcGoisVHzSzI0ckHG1gemUGi7+KuOf+23ghM
         kC6bW1cwZvhgJLl4sZeRgXiR1Kqu6EJ/Pilc5LiSUeI29YlLPeuFuvoejSsiGugmeMl2
         s82+GIrwFOm2O08sAeFlcukcgaK4DijO2Xx8K/PQK+DJY2/udR/0Gxcr6DJI1mfs35QX
         UYZ1366P8FZfU6fIgrSRM+vWVMpAqmvB1+nwJ179m3I/xLBGJ6EUeOJ4uwD2sfooaxVP
         VOMgHW4xfFym4pAe2vqXOt2Vp73D86FupYOZm8k6yAwUuQZWePkBg3OWPBIh0XKKlOYt
         ra9w==
X-Gm-Message-State: AOJu0Yz9K5J9vJwGK8pgOX+C+iWu2nKGxmIi88QwyQm9GeLxQcYGd6HK
	oJ9zFzrAObmlmLqV5YppM4nEKASmLMhu0CFkjDz6c2aQt4DNQEhg5SLfeEE3WW9XQwgJWHiBzZ/
	kDk9TLHgMCyev2WXlYA3x0jugYPI=
X-Google-Smtp-Source: AGHT+IGhdQ+rFWGK3oZ9Kzck/Uwb88nedoQ/vXo4KMdGLrVgJBVGMpZJkEF0WfYjy7Bbn7ycOJ1Za/Kqwq4l0QzQhtw=
X-Received: by 2002:a05:6e02:b28:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-39c48c7d888mr14047935ab.1.1723517344843; Mon, 12 Aug 2024
 19:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812200039.69366-1-kuniyu@amazon.com> <20240812222857.29837-1-fw@strlen.de>
In-Reply-To: <20240812222857.29837-1-fw@strlen.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Aug 2024 10:48:28 +0800
Message-ID: <CAL+tcoCnReBfomkL-RX9_p2zSLvOTUy8EMBAoz_vO8bWLMAvCA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: prevent concurrent execution of tcp_sk_exit_batch
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:04=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Its possible that two threads call tcp_sk_exit_batch() concurrently,
> once from the cleanup_net workqueue, once from a task that failed to clon=
e
> a new netns.  In the latter case, error unwinding calls the exit handlers
> in reverse order for the 'failed' netns.
>
> tcp_sk_exit_batch() calls tcp_twsk_purge().
> Problem is that since commit b099ce2602d8 ("net: Batch inet_twsk_purge"),
> this function picks up twsk in any dying netns, not just the one passed
> in via exit_batch list.
>
> This means that the error unwind of setup_net() can "steal" and destroy
> timewait sockets belonging to the exiting netns.
>
> This allows the netns exit worker to proceed to call
>
> WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount)=
);
>
> without the expected 1 -> 0 transition, which then splats.
>
> At same time, error unwind path that is also running inet_twsk_purge()
> will splat as well:
>
> WARNING: .. at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210
> ...
>  refcount_dec include/linux/refcount.h:351 [inline]
>  inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
>  inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221
>  inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
>  tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
>  ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
>  setup_net+0x714/0xb40 net/core/net_namespace.c:375
>  copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
>  create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
>
> ... because refcount_dec() of tw_refcount unexpectedly dropped to 0.
>
> This doesn't seem like an actual bug (no tw sockets got lost and I don't
> see a use-after-free) but as erroneous trigger of debug check.
>
> Add a mutex to force strict ordering: the task that calls tcp_twsk_purge(=
)
> blocks other task from doing final _dec_and_test before mutex-owner has
> removed all tw sockets of dying netns.
>
> Fixes: e9bd0cca09d1 ("tcp: Don't allocate tcp_death_row outside of struct=
 netns_ipv4.")
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Reported-by: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/0000000000003a5292061f5e4e19@googl=
e.com/
> Link: https://lore.kernel.org/netdev/20240812140104.GA21559@breakpoint.cc=
/
> Signed-off-by: Florian Westphal <fw@strlen.de>

Really thanks for your great effort :) It's not easy to analyze at all.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

