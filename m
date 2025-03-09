Return-Path: <netdev+bounces-173374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF87A58898
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 22:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AEE188B644
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 21:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C69221D581;
	Sun,  9 Mar 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0naedeY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EEE1EF368
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741556670; cv=none; b=NYhgKs+yUQZ5Jqi9YiWcPhiyU/vEic5zOabN4MnxwYcXeA57T62YwxnZssB6IPoHJoWEga6FmMDfG/nk8ZGAhimFCI44kPNkX6MpY+N6qMtUkVaUHUEW6z+5E0KH+7Vl/s/2q97seb+i+Sd9uBJZFm4DTaVb0leFvHQ+5f6PG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741556670; c=relaxed/simple;
	bh=re5SIF8o/liecdbQbjWVOmQgZf3QNZmXXhjapyiOQtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNEbrFdQ5bSzuNgjNRqVjLF31N5chV+aVHUZqG219k2s7/ZVV+limPrbqBps6UR+oB4kEYy7KrtCaQEFJIUczON3Sai2ILMLoAfCd1I/qNKwbtTXClJgVlsLQKesHrGz9U3tLe3O2wZdNP1vehndjJOcrYDkeeyoM+p6zk61Vzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0naedeY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2242aca53efso152305ad.1
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741556668; x=1742161468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZlqzP24qEl6xIfEXq4SqzjorznxDfEvjlawVrPL3Bw=;
        b=N0naedeYHUcoj9jntF0OCs1wUzZ36uKysfOxZZw/ZPm2nupmYsp2/fIcUalqRUFPwz
         9VGzHfLcf5pZiGm+KsxbX3/Z5rZ5GCpbqY+X4D0KxldXysWngkb9HT4ye7fPfJxxXc5x
         fzSgUF0lUJSVojLaDfKqRsbUaWykhsBiF5DTXgHm6rjnl8UgmY/zpOgAMUQjmf1DBqvV
         1oiDak3+NmAU4oBMIWwosMyzAI5EWHfXGiBuupj4bsmYcU/bLgBwfQmqiTdUBtavPCOo
         PP9y3PELGXml1P9Ss0ZuZ7sbLxnNu+xonoaRrpbV1Mf4PcYvUlZ8tpY5TkUM++33Rc6U
         5Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741556668; x=1742161468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZlqzP24qEl6xIfEXq4SqzjorznxDfEvjlawVrPL3Bw=;
        b=aBb06lp556SonCpZnSjJF+KxmBhiane09uhKt0D5GouRe63djMV3A7MPBTP0LXlSdA
         Dsv5laNjRks9IV98dcEDI00XE2CYDW/mLUYMKB1l41Dh6pUsaDvOeyVWhMv+ZT6qV2gp
         Kh5QmxGqlAr5tl9LBTsNNbFPNjv+ohhgXjwX28W6NbLabirYWPiHaIR7Gv/E1sY9PYqS
         QpaWaDN4pbPWgzU7GZEiFmQsH13muV/JEsM5+3nrcQkvdlpC/TQALyAOp31wLgmQIq7g
         rdkIaowreXEN3oZ6tiF9Jxf4g2Nj1Qclu3LGa+JidUZ74mN05qkvCSAUn3iDB9E2YAOD
         0O2A==
X-Forwarded-Encrypted: i=1; AJvYcCW0iU3F8EO5kc6IptuJOWNCK64kCi4hKZWFt9h/XRFTXzZC6UTUBZZ3nDujdDHnYZKxRwBouOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZxpPz9E2TSUuTZZGDOJ41P0xhhbHJ1dqm1QZZHEWSs26fd93D
	rNiljUATEjEGcw3nTUuvA5Uh/1k3abktWrzRtc5y8o1FDa3/UdXwzNKZomKjwNF+S5gJEo9s+6P
	8TJF4zve4pe2b2u9CiChbiMR181ZwpfW9u7N3
X-Gm-Gg: ASbGncsfEFwwxj2NErZrsptP9md7V3M78AGB2yE2ghbe8BICd2uS4gl6rGPuH4IE9Jc
	86VMhwoR12j+HaBYMXEtWZAH/kCXOZW6u09/mdNKRk1assqGWSoYz+b/RKE+G9Nfu9vsHOc10BZ
	Wx5UCB6Xu0HfnLwY6ggq/o4uU6wao=
X-Google-Smtp-Source: AGHT+IEO2gDSm7oEz2MNFswCuZHf33fjse0v3ZMt6ZoKpNv1WpIvyRphT6QBkX4I+SgVpLMzmH+fyL0Js20iB0vvvVg=
X-Received: by 2002:a17:902:f683:b0:216:5e53:d055 with SMTP id
 d9443c01a7336-225477ec5ddmr2092435ad.9.1741556667498; Sun, 09 Mar 2025
 14:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309134219.91670-1-ap420073@gmail.com> <20250309134219.91670-3-ap420073@gmail.com>
In-Reply-To: <20250309134219.91670-3-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 9 Mar 2025 14:44:10 -0700
X-Gm-Features: AQ5f1JoeZNsCgObQxDdx8TQxUbqJZVmdOd7zq3HINk6eCiw6SwUQ9h_AM14jBUk
Message-ID: <CAHS8izPH=FkfGjq_+CzGJhZ3Wt06njM2c6HcBK7W1Xv6C8d5xw@mail.gmail.com>
Subject: Re: [PATCH v3 net 2/8] eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, horms@kernel.org, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, willemb@google.com, kaiyuanz@google.com, 
	skhawaja@google.com, sdf@fomichev.me, gospo@broadcom.com, 
	somnath.kotur@broadcom.com, dw@davidwei.uk, amritha.nambiar@intel.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 6:43=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> The bnxt_queue_mem_alloc() is called to allocate new queue memory when
> a queue is restarted.
> It internally accesses rx buffer descriptor corresponding to the index.
> The rx buffer descriptor is allocated and set when the interface is up
> and it's freed when the interface is down.
> So, if queue is restarted if interface is down, kernel panic occurs.
>
> Splat looks like:
>  BUG: unable to handle page fault for address: 000000000000b240
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 3 UID: 0 PID: 1563 Comm: ncdevmem2 Not tainted 6.14.0-rc2+ #9 844dd=
ba6e7c459cafd0bf4db9a3198e
>  Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01=
/2021
>  RIP: 0010:bnxt_queue_mem_alloc+0x3f/0x4e0 [bnxt_en]
>  Code: 41 54 4d 89 c4 4d 69 c0 c0 05 00 00 55 48 89 f5 53 48 89 fb 4c 8d =
b5 40 05 00 00 48 83 ec 15
>  RSP: 0018:ffff9dcc83fef9e8 EFLAGS: 00010202
>  RAX: ffffffffc0457720 RBX: ffff934ed8d40000 RCX: 0000000000000000
>  RDX: 000000000000001f RSI: ffff934ea508f800 RDI: ffff934ea508f808
>  RBP: ffff934ea508f800 R08: 000000000000b240 R09: ffff934e84f4b000
>  R10: ffff9dcc83fefa30 R11: ffff934e84f4b000 R12: 000000000000001f
>  R13: ffff934ed8d40ac0 R14: ffff934ea508fd40 R15: ffff934e84f4b000
>  FS:  00007fa73888c740(0000) GS:ffff93559f780000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000000000b240 CR3: 0000000145a2e000 CR4: 00000000007506f0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? __die+0x20/0x70
>   ? page_fault_oops+0x15a/0x460
>   ? exc_page_fault+0x6e/0x180
>   ? asm_exc_page_fault+0x22/0x30
>   ? __pfx_bnxt_queue_mem_alloc+0x10/0x10 [bnxt_en 7f85e76f4d724ba07471d7e=
39d9e773aea6597b7]
>   ? bnxt_queue_mem_alloc+0x3f/0x4e0 [bnxt_en 7f85e76f4d724ba07471d7e39d9e=
773aea6597b7]
>   netdev_rx_queue_restart+0xc5/0x240
>   net_devmem_bind_dmabuf_to_queue+0xf8/0x200
>   netdev_nl_bind_rx_doit+0x3a7/0x450
>   genl_family_rcv_msg_doit+0xd9/0x130
>   genl_rcv_msg+0x184/0x2b0
>   ? __pfx_netdev_nl_bind_rx_doit+0x10/0x10
>   ? __pfx_genl_rcv_msg+0x10/0x10
>   netlink_rcv_skb+0x54/0x100
>   genl_rcv+0x24/0x40
> ...
>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

Although I wonder if you wanna return -ENETDOWN from other queue API
ops, if your driver doesn't handle them.

