Return-Path: <netdev+bounces-71247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB0B852CF8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB1F1F26AB9
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6E91B273;
	Tue, 13 Feb 2024 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C15QiMa6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC9C2232A
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817547; cv=none; b=IapOS6W887b/myEiWNTiZ/o2dAB3FAtAGxZg9BWEPhS2RNs71QMDPk2LUTcqjAPKQa4pJiLLABWgaXMOuPndD44HKtyWe0FmISWSrWAxE14kftwMhQBD1CrKt5KdXCDIWND1iL6ITQE8iM3nn5inIL5Mu0gvCgZOQMpjwptrhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817547; c=relaxed/simple;
	bh=Xlq054tCokO/opx3Z394LrSDfKBSntfAi0T30g4BvE4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j3r9my+UVaAxiBU1s9N6wOfWSr0tiBbGBvTPPai/l0Xc6xYSibjdUryr1hHrEzWUfkWF3+WUrkyQ5Pd50CRvo+I5SgDB4wNq77ZAxJ9BBh7ZoR7L79ZKfyqHO70tye5I1QhBUx0yYRCmI+AgRcHXdbtWWqSORxdq5gZoi4W4OK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C15QiMa6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707817544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H3iAbenAQ5Ta3XtXA1KVXX3mdSSXoqIOmfX4euL18u0=;
	b=C15QiMa6EB2DOWlZptlzenihN2suSFFUOjx22EnhIBRIysz9CODj/cmW/GjmS3o0A2V5rC
	CINKWvirlHIroBplWUrRVQZlIgCWUX9uM30JBWA/IdMObgcjXAAD1RqI7rVS3QImyMJ64R
	fjuFxZMrPoGpSCkTcxyRn8Sk1KULUdc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-UtEOB6cjPIi-gByf_XKMxg-1; Tue, 13 Feb 2024 04:43:48 -0500
X-MC-Unique: UtEOB6cjPIi-gByf_XKMxg-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-dc25481a6b7so1076692276.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707817428; x=1708422228;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3iAbenAQ5Ta3XtXA1KVXX3mdSSXoqIOmfX4euL18u0=;
        b=IbVQ4G/1JDPkSFmjINDEUx+3UUu9S64KWLCqhugoBDh/AIHX2Aq7QT+nH8R9WkRnkg
         qESLIMRKUllSbYX7uSTC4pDnXFsHy2RGBY+WwcK6IZ+EAPnI9PHcjju/7wtC+JkDyTUc
         uN2py72JPQEeujv14/cMCEoUbz9BPVKy7eOeXvGbLV/Jh1Hl4n4IAxrtvGuIs81AB076
         /OrY3JhbysFVX0I+bmydyHgthyFuNsdzbi7oMsoznYgG2ZmU1s0sGSw6+6AdTqH4uqUk
         KHYrVO2+LLqBGrdktNYXjibyge5cP5w2svaa8GoaQR4l4FJaecwW1/gift8NDO+224Qw
         LO1A==
X-Forwarded-Encrypted: i=1; AJvYcCU08lfUiO1OU+8LVmX+TNq9XhyRM5zANZbVXBmNf0Y1hZWBOQghxUDezgUoZnukPWwbzzx/+2lXSvlJZeHb6pfFsElpAJok
X-Gm-Message-State: AOJu0YwaayXaXgxXBz7pF55ehIypu526DLPZUy6PZVvf75QHCsR/Zm8r
	JNbzeJwYBU5QZtVyk1KswkN0feCnddMzCwnZZnTYH/961wYWr2t82arqzQRgGhg2cn/vnm8FnjC
	BPSVIBLGoo5UCciq26r6tu4cNZBHZLNuGuAgIrzlF8JmsiKzcTaAjyA==
X-Received: by 2002:a81:7983:0:b0:607:7e2e:8613 with SMTP id u125-20020a817983000000b006077e2e8613mr1437654ywc.3.1707817428038;
        Tue, 13 Feb 2024 01:43:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5hW1lssUUBAyCTcxW9XXbVAS/AiI7NJG1uNCxaK9NxwnvGk9VNktdHxOW46pTvwbRfnDgZA==
X-Received: by 2002:a81:7983:0:b0:607:7e2e:8613 with SMTP id u125-20020a817983000000b006077e2e8613mr1437642ywc.3.1707817427642;
        Tue, 13 Feb 2024 01:43:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2VWKmKDz526jP5wkgGreJ4NsDwWjYA9LMqia9k4z4+Khaxa3NGa42UfDLduXMZdDbKybjwwkAcGKHIYioOH8GE5Bn5666248U6io4Vvl4zxgjF8x4i1puG/ThvDmrP9BlnswhqOYQ6AqxNPxCjDZMEZCCE9lEv5zhYHNQr2dfisiO+GcanuGeFTgiqp0HqaHjgKKemmpHnv/zWBj0+2TpXDrxcpEcgXC3NAmwGvaPZZiE6u2ZM3L5r+ezIRnBcxY2us0PyQ==
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id p65-20020a0de644000000b0060796eae826sm14271ywe.4.2024.02.13.01.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:43:47 -0800 (PST)
Message-ID: <3445847f9c25bc121e5050fbe58aa00c6859783f.camel@redhat.com>
Subject: Re: [PATCH v1 net] dccp/tcp: Unhash sk from ehash for tb2 alloc
 failure after check_estalblished().
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima
	 <kuni1840@gmail.com>, netdev@vger.kernel.org, syzkaller
	 <syzkaller@googlegroups.com>
Date: Tue, 13 Feb 2024 10:43:44 +0100
In-Reply-To: <20240209025409.27235-1-kuniyu@amazon.com>
References: <20240209025409.27235-1-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 18:54 -0800, Kuniyuki Iwashima wrote:
> syzkaller reported a warning [0] in inet_csk_destroy_sock() with
> no repro.
>=20
>   WARN_ON(inet_sk(sk)->inet_num && !inet_csk(sk)->icsk_bind_hash);
>=20
> However, the syzkaller's log hinted that every time the warning was
> triggered, connect() failed just before that due to FAULT_INJECTION. [1]
>=20
> When connect() is called for an unbound socket, we search for an
> available ephemeral port.  If a bhash bucket exists for the port,
> we call __inet_check_established() or __inet6_check_established()
> to check if the bucket is reusable.
>=20
> If so, we add the socket into ehash and set inet_sk(sk)->inet_num.
>=20
> Later, we look up the corresponding bhash2 bucket and try to allocate
> it if it does not exist.
>=20
> Although it rarely occurs in real use, if the allocation fails,
> we must revert the changes by check_established().  Otherwise, an
> unconnected socket could illegally occupy an ehash entry.
>=20
> [0]:
> WARNING: CPU: 0 PID: 350830 at net/ipv4/inet_connection_sock.c:1193 inet_=
csk_destroy_sock (net/ipv4/inet_connection_sock.c:1193)
> Modules linked in:
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-=
gd239552ce722-prebuilt.qemu.org 04/01/2014
> RIP: 0010:inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1193)
> Code: 41 5c 41 5d 41 5e e9 2d 4a 3d fd e8 28 4a 3d fd 48 89 ef e8 f0 cd 7=
d ff 5b 5d 41 5c 41 5d 41 5e e9 13 4a 3d fd e8 0e 4a 3d fd <0f> 0b e9 61 fe=
 ff ff e8 02 4a 3d fd 4c 89 e7 be 03 00 00 00 e8 05
> RSP: 0018:ffffc9000b21fd38 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000009e78 RCX: ffffffff840bae40
> RDX: ffff88806e46c600 RSI: ffffffff840bb012 RDI: ffff88811755cca8
> RBP: ffff88811755c880 R08: 0000000000000003 R09: 0000000000000000
> R10: 0000000000009e78 R11: 0000000000000000 R12: ffff88811755c8e0
> R13: ffff88811755c892 R14: ffff88811755c918 R15: 0000000000000000
> FS:  00007f03e5243800(0000) GS:ffff88811ae00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b32f21000 CR3: 0000000112ffe001 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1193)
>  dccp_close (net/dccp/proto.c:1078)
>  inet_release (net/ipv4/af_inet.c:434)
>  __sock_release (net/socket.c:660)
>  sock_close (net/socket.c:1423)
>  __fput (fs/file_table.c:377)
>  __fput_sync (fs/file_table.c:462)
>  __x64_sys_close (fs/open.c:1557 fs/open.c:1539 fs/open.c:1539)
>  do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> RIP: 0033:0x7f03e53852bb
> Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0=
c e8 43 c9 f5 ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 35 44 89 c7 89 44 24 0c e8 a1 c9 f5 ff 8b 44
> RSP: 002b:00000000005dfba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f03e53852bb
> RDX: 0000000000000002 RSI: 0000000000000002 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000167c
> R10: 0000000008a79680 R11: 0000000000000293 R12: 00007f03e4e43000
> R13: 00007f03e4e43170 R14: 00007f03e4e43178 R15: 00007f03e4e43170
>  </TASK>
>=20
> [1]:
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 350833 Comm: syz-executor.1 Not tainted 6.7.0-12272-g2121c43f=
88f5 #9
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-=
gd239552ce722-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
>  should_fail_ex (lib/fault-inject.c:52 lib/fault-inject.c:153)
>  should_failslab (mm/slub.c:3748)
>  kmem_cache_alloc (mm/slub.c:3763 mm/slub.c:3842 mm/slub.c:3867)
>  inet_bind2_bucket_create (net/ipv4/inet_hashtables.c:135)
>  __inet_hash_connect (net/ipv4/inet_hashtables.c:1100)
>  dccp_v4_connect (net/dccp/ipv4.c:116)
>  __inet_stream_connect (net/ipv4/af_inet.c:676)
>  inet_stream_connect (net/ipv4/af_inet.c:747)
>  __sys_connect_file (net/socket.c:2048 (discriminator 2))
>  __sys_connect (net/socket.c:2065)
>  __x64_sys_connect (net/socket.c:2072)
>  do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> RIP: 0033:0x7f03e5284e5d
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
> RSP: 002b:00007f03e4641cc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> RAX: ffffffffffffffda RBX: 00000000004bbf80 RCX: 00007f03e5284e5d
> RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000003
> RBP: 00000000004bbf80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 000000000000000b R14: 00007f03e52e5530 R15: 0000000000000000
>  </TASK>
>=20
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address"=
)
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/inet_hashtables.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 93e9193df544..abb9399d4f72 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -1130,6 +1130,20 @@ int __inet_hash_connect(struct inet_timewait_death=
_row *death_row,
>  	return 0;
> =20
>  error:
> +	if (sk_hashed(sk)) {
> +		spinlock_t *lock =3D inet_ehash_lockp(hinfo, sk->sk_hash);
> +
> +		sock_prot_inuse_add(net, sk->sk_prot, -1);
> +
> +		spin_lock(lock);
> +		sk_nulls_del_node_init_rcu(sk);
> +		spin_unlock(lock);
> +
> +		sk->sk_hash =3D 0;
> +		inet_sk(sk)->inet_sport =3D 0;
> +		inet_sk(sk)->inet_num =3D 0;

What about the tw socket? AFAICS it has been removed from the ehash
table but is still hashed in the bind table.

Should we drop it from the latter, too, for consistency?

Thanks,

Paolo


