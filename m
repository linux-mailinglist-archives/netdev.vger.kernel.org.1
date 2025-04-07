Return-Path: <netdev+bounces-179668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CF7A7E0BA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C942B3BF6F8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10A91C3029;
	Mon,  7 Apr 2025 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQOWLmqE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F916FB0
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034809; cv=none; b=rSkGEzFuw6wxIvGsS6orhaiGGAQfdl/0Az40DgIVhHoqI6pvHnBVsHzI0pdi4E1nfAfPWSqBltGm2CbKSCwWJfi0+JhtaW9sPvzUhklPkBquNCYWKjKa21MkX+CoIz/FpvaaSAmn821yJzQcFMXKH8ru+EiKVPqhQXHF1P29YLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034809; c=relaxed/simple;
	bh=NkS7s3yJ1zMTJXrzbAJnNhwoqmWJErhakJi2tczDrwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CULvVbA0z3auh68rvcD8ZL9ePmEsXfY8QkwifkXG3jIHRMTvZlW62GGx+LkvC8PwE/dauu31mO5ySzviEh2tjYb1btlUUDqOANuasKQlu/HIzl1vs0DWtxONL60geiu0Yl8vfk2D1cqrX9VHsPjwXKL9i82Mujcrl52xlCbWH+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQOWLmqE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22403cbb47fso45736195ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744034807; x=1744639607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRcrKarkTRjwbyAUBkhXLoUw/LhCEU8jfyCNCGwcX8I=;
        b=BQOWLmqEXQmEuk2+PzfR4rd6to5b9fb0YsICgG1EJ3V83xTw3MQk0Tb1T+IeqBu1By
         w8UEhBvqgNbvF27C0PyvgMlfkqBB2HMj8YBfbeVFuaTFr/1jNYGOdkWhpIZ3giUQqvnF
         udbPL4zBXxGzRsVG3reVzHm22Rd9XrgwwAgjXDSYTjru/BP1XhRbHUDzb02sjDrl5OrC
         xSZrkisjOoQg1jbrZgU1tjpZfVmjq4TOmoFvwpdnTOiq9NXhcEJ5bFiGdCyfyVjXttym
         MuJ1/NonJ7ve9Cy14QBe4xWj+i6XLGx9bNTgKxx5aUm2hMFvdzWcxhoE6Q8cHyv1xeE+
         t7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744034807; x=1744639607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRcrKarkTRjwbyAUBkhXLoUw/LhCEU8jfyCNCGwcX8I=;
        b=EBbs8a7uha95NV/jUz2Fjbeww5gvngti0MHmoW6cPUS/KBhBqcRJvsqJLEELR+axC0
         6r9eCfusYtJXl5ZRMHmYNBw2tfXqeHcpDrPbZ0GItgwvR/EAVb2jvJvpasjzIBbKU/bd
         +Lj67gAhPDkYGaCChe36HEIRdY7JWjINRnRljxwB3hR74Qon56lESWOyr79hnNKL0taL
         TxQ5K8BH4g20gD4QdAQePxxnpGqHpju3eTKR0F8v2A6PzCuqSMbCxeq9Xt3LdMKDcm2I
         Ccl2zIY7urAfN87QwTotVS5MDeAFMMgubzcgupddfymgyO+ZCqNpM6n5ZQ82Rbj9pZmg
         XUAg==
X-Forwarded-Encrypted: i=1; AJvYcCUTweWONQcQdV4GOw9RuEkJ0gSqwwnP6ZS3beLMsloO0/DwzNK0+a8qqUNUDDELzNeLuo2xjlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFfcj7KkaEtJq8wx0JESecH9yDyooCOYZDr8GbcxB/e5bFxMC+
	9wUynQvcgwDhto0dUoj3A6rk3Z9l4HPyWVDaSECVSJUmb95Pu9I=
X-Gm-Gg: ASbGncudRThYWbXFoVEZ3hDegmeeRMQZFnixZY6pIU8oiOitIyIPSm4/Nwk6ALy2Jkj
	ClbyDihVzkY2dihhuweOeAWZG12ggN2Fd5FxTxlG54eqD0V/rQrU1L2lizqS1giPcMYHpdjmsoC
	w3q+CR4/paWFJaWltYi3iEI4dSUgVnLtVQ9T5Xs0j4/7rQUDx78M1r+4Tqx6cE2z5l6ODQnnQZe
	czzMhGWGohHTMkv8Z02qtjTAifAK/XpBUH357ZJz6HBeKS69kBCNUb5CRg742KKPSrfg75mXHeI
	TKCGDzfqwMGKL9CWYgubWPxEVPOyMKuTx66uFD98UKUg
X-Google-Smtp-Source: AGHT+IGrdoGO8ghsGAOhwjHFh4bu6J2Bl07zAZtYmY7OVTGCKx18lWmobKWy8Qb5f29360QSiVUzBA==
X-Received: by 2002:a17:902:ce07:b0:21f:bd66:cafa with SMTP id d9443c01a7336-22a8a867283mr182302415ad.17.1744034807163;
        Mon, 07 Apr 2025 07:06:47 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739d9ea07e0sm8837047b3a.92.2025.04.07.07.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:06:46 -0700 (PDT)
Date: Mon, 7 Apr 2025 07:06:45 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Hui Guo <guohui.study@gmail.com>
Subject: Re: [PATCH v1 net] ipv6: Fix null-ptr-deref in addrconf_add_ifaddr().
Message-ID: <Z_Pb9dku3R1wdTEp@mini-arch>
References: <20250406035755.69238-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250406035755.69238-1-kuniyu@amazon.com>

On 04/05, Kuniyuki Iwashima wrote:
> The cited commit placed netdev_lock_ops() just after __dev_get_by_index()
> in addrconf_add_ifaddr(), where dev could be NULL as reported. [0]
> 
> Let's call netdev_lock_ops() only when dev is not NULL.
> 
> [0]:
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000198: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000cc0-0x0000000000000cc7]
> CPU: 3 UID: 0 PID: 12032 Comm: syz.0.15 Not tainted 6.14.0-13408-g9f867ba24d36 #1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:addrconf_add_ifaddr (./include/net/netdev_lock.h:30 ./include/net/netdev_lock.h:41 net/ipv6/addrconf.c:3157)
> Code: 8b b4 24 94 00 00 00 4c 89 ef e8 7e 4c 2f ff 4c 8d b0 c5 0c 00 00 48 89 c3 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <0f> b6 04 02 4c 89 f2 83 e2 07 38 d0 7f 08 80
> RSP: 0018:ffffc90015b0faa0 EFLAGS: 00010213
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000198 RSI: ffffffff893162f2 RDI: ffff888078cb0338
> RBP: ffffc90015b0fbb0 R08: 0000000000000000 R09: fffffbfff20cbbe2
> R10: ffffc90015b0faa0 R11: 0000000000000000 R12: 1ffff92002b61f54
> R13: ffff888078cb0000 R14: 0000000000000cc5 R15: ffff888078cb0000
> FS: 00007f92559ed640(0000) GS:ffff8882a8659000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f92559ecfc8 CR3: 000000001c39e000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  inet6_ioctl (net/ipv6/af_inet6.c:580)
>  sock_do_ioctl (net/socket.c:1196)
>  sock_ioctl (net/socket.c:1314)
>  __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:906 fs/ioctl.c:892 fs/ioctl.c:892)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130
> RIP: 0033:0x7f9254b9c62d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff f8
> RSP: 002b:00007f92559ecf98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f9254d65f80 RCX: 00007f9254b9c62d
> RDX: 0000000020000040 RSI: 0000000000008916 RDI: 0000000000000003
> RBP: 00007f9254c264d3 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f9254d65f80 R15: 00007f92559cd000
>  </TASK>
> Modules linked in:
> 
> Fixes: 8965c160b8f7 ("net: use netif_disable_lro in ipv6_add_dev")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Reported-by: Hui Guo <guohui.study@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAHOo4gK+tdU1B14Kh6tg-tNPqnQ1qGLfinONFVC43vmgEPnXXw@mail.gmail.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

