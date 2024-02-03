Return-Path: <netdev+bounces-68799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 468EA8484C7
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 10:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDA21C28D16
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2355F5CDE4;
	Sat,  3 Feb 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wNClei8f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECE608F1
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706950883; cv=none; b=jcBvMx7HrxummVJ4XnPXjHD8PLLltdgu60cNwxR0GvfB3+Ov5Cz5ODH8gcrfTFMA1DrJKj62pngQqmNRC7cWAv7NUvAG7uF5tLgPp4Hqlg11m2o6M+zEEUTMUWFRY6r0tQ/4c4n+Gfk7w0GI48+P3yrdeX9+OHC625w1G/b4yiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706950883; c=relaxed/simple;
	bh=oNL4GxQWTj4dilca9PFYMgngKx+CBnCZYOKnhj8FF+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fU9SkyUHSBYRn9Uh6qqqP2UYkycFwvPvcQ9g/Zg8+Plr80Hmo8yK2k/HQv05LS12hvqy8CF+1tAvjqdtKqMW+OO92NdtH3oK2LFs9YH85BmPbzlaw9r8tTj8IAL85M+BoQypvovPRC6BmUKrGyQPPRmEkuaMQPyiM+eGj5S7DXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wNClei8f; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56012eeb755so7357a12.0
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 01:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706950878; x=1707555678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdNOjPmnUHmZoaZTxhs1tBJ4MiDFY+m2JR6BiQFO9dE=;
        b=wNClei8fRfTki675z2KXLdWWsT/q9lcBqKMOqS/J7y8E2+j6Izjrg8GbMvRhzVRzxd
         CV/gkuqy4ze8y4asVkRV9xMa+acRkxYSoYOQirAdcsy+fsTc5ae1yxqAkg5e0pFcY8rD
         KUpUVvfiH93k2kPv1idRXOipqE6wR2yUcDuJ59s3CJtQ+aQftsU27SL02Suj+CVb07Mq
         sdEXoa6E+voitd7OeguimZYD0k6DvuhbmC0oHrGQIkcBz7Xw+wo7fZ9QKW1KPTj6W3B2
         gYvulzqKUlvLfpVLsYbMGX6EDFpJ7Wpe5lfEv0faxXrGjv5Dxz39kVldG3jpFar9cTGs
         Ti1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706950878; x=1707555678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdNOjPmnUHmZoaZTxhs1tBJ4MiDFY+m2JR6BiQFO9dE=;
        b=CmGCutqXnHN7xDWWgOrXf1+z7K+KSVUGwdrzAc2cofr1weoacD624RNns5I6/uLMpr
         8ie9Valy5Fp9xxbutcjygDI9CTLvDw3P8bOJlzQWtjY4a01rH/5eoO05tDS8T6Fjxo5L
         riNdtQrDdBCqL4iINfzhWNPTRUMMOKXmrX9uX44ahDmqWa08DdgxcNOfjQeHpmxExQU/
         nTfuCxZtjVRtwuSPm5dQfBnmWo/S1zF8gVxlXpSg3Lyb9WRGMKAoFcA9d7edB5qtx7Vw
         YT7QEq6dcV+EEeo53SLAA5CyvBTUNbN9ed5N0TtuKjskRQejGYokH3fJjt/zqylCDvt7
         zlEw==
X-Gm-Message-State: AOJu0Yx7ocURfIQPKvW1GJgmpmnH/gtEs0KiLGsokWcpkck/O4DRm+B1
	VWd6QDHjYvbDuae2qcgIhe55e2ATNabyUfXbK0iRb8q5H4viUbGt5CBLOXim25ELhzId2QJ1KEl
	ympGygLw3miBWJBjoW5nv45qjEFOOrcEO+79s
X-Google-Smtp-Source: AGHT+IHafGXJ0v67fV8vF605E4vNtuGR4zSnkwzshrfk5ZZ5UaU6HNTSNQ1cjwR5aiZEeCL+dQ8VCpWqquqjXzYdKQE=
X-Received: by 2002:a50:bb07:0:b0:560:2a1:44fc with SMTP id
 y7-20020a50bb07000000b0056002a144fcmr69551ede.1.1706950878302; Sat, 03 Feb
 2024 01:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203083259.99822-1-kuniyu@amazon.com>
In-Reply-To: <20240203083259.99822-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 3 Feb 2024 10:01:04 +0100
Message-ID: <CANn89iL+BHiqZko-X0YWTdv9BCYXNY5w8rJsHf=X3NS9W+jkiA@mail.gmail.com>
Subject: Re: [PATCH v1 net] af_unix: Call kfree_skb() for dead
 unix_(sk)->oob_skb in GC.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 9:33=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> syzbot reported a warning [0] in __unix_gc() with a repro, which
> creates a socketpair and sends one socket's fd to itself using the
> peer.
>
>   socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) =3D 0
>   sendmsg(4, {msg_name=3DNULL, msg_namelen=3D0, msg_iov=3D[{iov_base=3D"\=
360", iov_len=3D1}],
>           msg_iovlen=3D1, msg_control=3D[{cmsg_len=3D20, cmsg_level=3DSOL=
_SOCKET,
>                                       cmsg_type=3DSCM_RIGHTS, cmsg_data=
=3D[3]}],
>           msg_controllen=3D24, msg_flags=3D0}, MSG_OOB|MSG_PROBE|MSG_DONT=
WAIT|MSG_ZEROCOPY) =3D 1
>
> This forms a self-cyclic reference that GC should finally untangle
> but does not due to lack of MSG_OOB handling, resulting in memory
> leak.
>
> Recently, commit 11498715f266 ("af_unix: Remove io_uring code for
> GC.") removed io_uring's dead code in GC and revealed the problem.
>
> The code was executed at the final stage of GC and unconditionally
> moved all GC candidates from gc_candidates to gc_inflight_list.
> That papered over the reported problem by always making the following
> WARN_ON_ONCE(!list_empty(&gc_candidates)) false.
>
> The problem has been there since commit 2aab4b969002 ("af_unix: fix
> struct pid leaks in OOB support") added full scm support for MSG_OOB
> while fixing another bug.
>
> To fix this problem, we must call kfree_skb() for unix_sk(sk)->oob_skb
> if the socket still exists in gc_candidates after purging collected skb.
>
> Note that the leaked socket remained being linked to a global list, so
> kmemleak also could not detect it.  We need to check /proc/net/protocol
> to notice the unfreed socket.
>
> [
> Reported-by: syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dfa3ef895554bdbfd1183
> Fixes: 2aab4b969002 ("af_unix: fix struct pid leaks in OOB support")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Given the commit disabling SCM_RIGHTS w/ io_uring was backporeted to
> stable trees, we can backport this patch without commit 11498715f266,
> so targeting net tree.
> ---
>  net/unix/garbage.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 2405f0f9af31..61f313d4a5dd 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -314,6 +314,15 @@ void unix_gc(void)
>         /* Here we are. Hitlist is filled. Die. */
>         __skb_queue_purge(&hitlist);
>
> +       list_for_each_entry_safe(u, next, &gc_candidates, link) {
> +               struct sk_buff *skb =3D u->oob_skb;
> +
> +               if (skb) {
> +                       u->oob_skb =3D NULL;
> +                       kfree_skb(skb);
> +               }
> +       }
> +

Reviewed-by: Eric Dumazet <edumazet@google.com>

Note there is already a 'struct sk_buff *skb;" variable in scope.

This could be rewritten

list_for_each_entry_safe(u, next, &gc_candidates, link) {
        kfree_skb(u->oob_skb);
        u->oob_skb =3D NULL;
}

Also we probably can send this later:

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 2405f0f9af31c0ccefe2aa404002cfab8583c090..02466224445c9ec9b1259468d30=
c89fc5e905a6b
100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -283,7 +283,7 @@ void unix_gc(void)
         * inflight counters for these as well, and remove the skbuffs
         * which are creating the cycle(s).
         */
-       skb_queue_head_init(&hitlist);
+       __skb_queue_head_init(&hitlist);
        list_for_each_entry(u, &gc_candidates, link)
                scan_children(&u->sk, inc_inflight, &hitlist);

