Return-Path: <netdev+bounces-212789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5433B21FCD
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361D71893284
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7432D375B;
	Tue, 12 Aug 2025 07:46:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411391EF38C
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754984806; cv=none; b=U2uwoI/SOHPoLfvvbMyz8mEZQ/iUmSQVXONHPCV5xTFGeLyMTAyZdQbsNVRd9sKy7jguf6AXuRzWe53gdYRbbP+VgVqj0cQhjNzsgA8HVF2PxJ0wUjIFFF8MUveu0s/+2iN+owsYLOK40KO6sy8+mUNDkL6a8EKj54x50tu+rPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754984806; c=relaxed/simple;
	bh=7veAhauFbzmeZ6VPaXhAIl+1EidQymqZFBkfOM5A+nY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=i5TJBN7kChs+T/kgEMeOpj+HJ0QKvHc/EhFKCiDjYarWvgvr+XZpIzCHAObeoyY8EcwdkTkMUkFt1Fsvs9V1B2wzfhYEpFHEhr2TnvwO47JWSsiXRkB+Puk0jXN6PW5aBHvckLoAjT6n39Ir/dR7PuDEf0uohsaOuHUWTjqD1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8841c18a4bfso147323939f.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754984803; x=1755589603;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Umk1YoadKdpa6fyzaimwqq35auuAfEV1rwGDtpJveWA=;
        b=afi9oS/Zz7acjzQX0adwy+R7LfYSqkC+nJMwckxt3wEyRrrUkM4CLMUAgABpnm9DBY
         SwctQrzKjfPKI9eYigCq2P6HRsGLkIxnokC1qXn00PrgefmvdKxmNneBLtQ6/IvaMuwq
         QlukcScOsETDhkrZhamEmB7w8kagySEfzVgm+mHnEEW2uw1cjjkfDAGmsgKoTQaOqV40
         wwIPcqX1Ft65IgpL9b1sd5Bpw7jCrOTL33XNFFyJGD8fpXGuRYklSjZaMcvZj/lSixbD
         GP46R+f+GSOPpqYEHMZgIv0Iy/npp3xwLuHbYtO7GgoZigo/kLJKshz1SVV3BE2ZYo9u
         Iuxw==
X-Forwarded-Encrypted: i=1; AJvYcCWD+Z05M8++bgrDB+jNBAsjHmceGADh3vrY5MYzdgqn3zF8QiRohYJmeZj3x9Fch/AxdQ7YJGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2upa8oWoRLXHhnYy4TzelPo7SUqSbQGL6+1at/ZhO433cZZwM
	chLzGrBzdDK8zgopK1rpaUyMY20JP2wWCSYFC9Gz/oKJVJuFZjWOuTurTnVA1/3dB21YdwXklJn
	1WI3EAV0kuTm4X2HQZ2tgojjbW/LPVM1XOFVLKlV3FnK50N3cEnweOKejqFY=
X-Google-Smtp-Source: AGHT+IGMO5NHQ7t/8SdMDmkMxxHOO+f+f98qggqnhfBOuHrFo4tBxoy7lI5+nUzI68F7dY4bFrEZVQmeL1OqGTmyoq+dADo+nkMr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7187:b0:881:9412:c917 with SMTP id
 ca18e2360f4ac-8841bcc009bmr501638939f.0.1754984803514; Tue, 12 Aug 2025
 00:46:43 -0700 (PDT)
Date: Tue, 12 Aug 2025 00:46:43 -0700
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689af163.050a0220.7f033.0112.GAE@google.com>
Subject: [syzbot ci] Re: net-memcg: Decouple controlled memcg from sk->sk_prot->memory_allocated.
From: syzbot ci <syzbot+cic0c8bc3087cfc855@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almasrymina@google.com, cgroups@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	hannes@cmpxchg.org, horms@kernel.org, kuba@kernel.org, kuni1840@gmail.com, 
	kuniyu@google.com, linux-mm@kvack.org, martineau@kernel.org, 
	matttbe@kernel.org, mhocko@kernel.org, mkoutny@suse.com, 
	mptcp@lists.linux.dev, muchun.song@linux.dev, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, tj@kernel.org, willemb@google.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] net-memcg: Decouple controlled memcg from sk->sk_prot->memory_allocated.
https://lore.kernel.org/all/20250811173116.2829786-1-kuniyu@google.com
* [PATCH v2 net-next 01/12] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
* [PATCH v2 net-next 02/12] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
* [PATCH v2 net-next 03/12] tcp: Simplify error path in inet_csk_accept().
* [PATCH v2 net-next 04/12] net: Call trace_sock_exceed_buf_limit() for memcg failure with SK_MEM_RECV.
* [PATCH v2 net-next 05/12] net: Clean up __sk_mem_raise_allocated().
* [PATCH v2 net-next 06/12] net-memcg: Introduce mem_cgroup_from_sk().
* [PATCH v2 net-next 07/12] net-memcg: Introduce mem_cgroup_sk_enabled().
* [PATCH v2 net-next 08/12] net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
* [PATCH v2 net-next 09/12] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
* [PATCH v2 net-next 10/12] net: Define sk_memcg under CONFIG_MEMCG.
* [PATCH v2 net-next 11/12] net-memcg: Store MEMCG_SOCK_ISOLATED in sk->sk_memcg.
* [PATCH v2 net-next 12/12] net-memcg: Decouple controlled memcg from global protocol memory accounting.

and found the following issue:
kernel build error

Full report is available here:
https://ci.syzbot.org/series/6fc666d9-cfec-413c-a98c-75c91ad6c07d

***

kernel build error

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      37816488247ddddbc3de113c78c83572274b1e2e
arch:      amd64
compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
config:    https://ci.syzbot.org/builds/a5d5d856-2809-4eee-87ca-2cd1630214ae/config

net/tls/tls_device.c:374:8: error: call to undeclared function 'sk_should_enter_memory_pressure'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

