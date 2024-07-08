Return-Path: <netdev+bounces-109987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFC392A955
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC361C217A7
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0135714A614;
	Mon,  8 Jul 2024 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZmnlWSSG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA3143C47
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464956; cv=none; b=KmrCKr8mTkWa2Kf95dfE4FSXHmV+3uwHc/I0hjLPaBwxFwT5YLADDF2QCuu9TpYSIB3PegXSEyY7u2e2MdnSFe8rZUk5O1wnDmcT7Bq/3UJqKOvrJINjl7baxAeG/s2zeohbxYDN+XGCczJqRbNtAh1LuzpCpjgZF+TZ6bv6dKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464956; c=relaxed/simple;
	bh=XvknYx9eRUonFE818OXF/Mw/HYsRBwEDBfiRqarurBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5h3WALEJSSOsv4VqCTt7z1Vy+cI8iOAZrpNYoseioEhlnWJfw5++A1L3t4rpM0jdjEzn3V2mkje3aQrS1OtO+uIPGjTMsMudwo9V6FfOFJk+hREmUryxTrt4jYS0t4wcPiXnPEbAcpOhX9a5wBth9Q/Rbt2QWpUh1Y5WGuKY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZmnlWSSG; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720464955; x=1752000955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W0CLbqqSQAHzjDPxWZjWGHtI8BI8xt6uLzg2MFzDAL8=;
  b=ZmnlWSSGBLNUByZrGTVK1ND/1HSQcw+B3mhCayriX9ul533XkvCdXds0
   /N3HmE+F9WKWQ8/x2fp/aPPCatoDP/lskMg7flig1Z5chQrS84TgcQBi7
   nuFJI3KP72VNicvC0ZSoVdRujoPXUuqE1BhA3ontui1RWvLOxE/ziAs1N
   Y=;
X-IronPort-AV: E=Sophos;i="6.09,192,1716249600"; 
   d="scan'208";a="739708819"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:55:48 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:25635]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.144:2525] with esmtp (Farcaster)
 id cd038a3f-51d8-464d-8726-a44286611b80; Mon, 8 Jul 2024 18:55:47 +0000 (UTC)
X-Farcaster-Flow-ID: cd038a3f-51d8-464d-8726-a44286611b80
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 18:55:47 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 18:55:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller@googlegroups.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 net] udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
Date: Mon, 8 Jul 2024 11:55:35 -0700
Message-ID: <20240708185535.96845-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iJF4X+zFFFfhHdDWcYxTO0J_TZ-oN=X_8_FuQqxsCWJCQ@mail.gmail.com>
References: <CANn89iJF4X+zFFFfhHdDWcYxTO0J_TZ-oN=X_8_FuQqxsCWJCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jul 2024 11:38:41 -0700
> On Mon, Jul 8, 2024 at 11:20 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > syzkaller triggered the warning [0] in udp_v4_early_demux().
> >
> > In udp_v4_early_demux(), we do not touch the refcount of the looked-up
> > sk and use sock_pfree() as skb->destructor, so we check SOCK_RCU_FREE
> > to ensure that the sk is safe to access during the RCU grace period.
> >
> > Currently, SOCK_RCU_FREE is flagged for a bound socket after being put
> > into the hash table.  Moreover, the SOCK_RCU_FREE check is done too
> > early in udp_v4_early_demux(), so there could be a small race window:
> >
> >   CPU1                                 CPU2
> >   ----                                 ----
> >   udp_v4_early_demux()                 udp_lib_get_port()
> >   |                                    |- hlist_add_head_rcu()
> >   |- sk = __udp4_lib_demux_lookup()    |
> >   |- DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
> >                                        `- sock_set_flag(sk, SOCK_RCU_FREE)
> >
> > In practice, sock_pfree() is called much later, when SOCK_RCU_FREE
> > is most likely propagated for other CPUs; otherwise, we will see
> > another warning of sk refcount underflow, but at least I didn't.
> >
> > Technically, moving sock_set_flag(sk, SOCK_RCU_FREE) before
> > hlist_add_{head,tail}_rcu() does not guarantee the order, and we
> > must put smp_mb() between them, or smp_wmb() there and smp_rmb()
> > in udp_v4_early_demux().
> >
> > But it's overkill in the real scenario, so I just put smp_mb() only under
> > CONFIG_DEBUG_NET to silence the splat.  When we see the refcount underflow
> > warning, we can remove the config guard.
> >
> > Another option would be to remove DEBUG_NET_WARN_ON_ONCE(), but this could
> > make future debugging harder without the hints in udp_v4_early_demux() and
> > udp_lib_get_port().
> >
> > [0]:
> >
> > Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early demux")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/ipv4/udp.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 189c9113fe9a..1a05cc3d2b4f 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -326,6 +326,12 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
> >                         goto fail_unlock;
> >                 }
> >
> > +               sock_set_flag(sk, SOCK_RCU_FREE);
> 
> Nice catch.
> 
> > +
> > +               if (IS_ENABLED(CONFIG_DEBUG_NET))
> > +                       /* for DEBUG_NET_WARN_ON_ONCE() in udp_v4_early_demux(). */
> > +                       smp_mb();
> > +
> 
> I do not think this smp_mb() is needed. If this was, many other RCU
> operations would need it,
> 
> RCU rules mandate that all memory writes must be committed before the
> object can be seen
> by other cpus in the hash table.
> 
> This includes the setting of the SOCK_RCU_FREE flag.
> 
> For instance, hlist_add_head_rcu() does a
> rcu_assign_pointer(hlist_first_rcu(h), n);

Ah, I was thinking spinlock will not prevent reordering, but
now I see, rcu_assign_pointer() had necessary barrier. :)

  /**
   * rcu_assign_pointer() - assign to RCU-protected pointer
   ...
   * Assigns the specified value to the specified RCU-protected
   * pointer, ensuring that any concurrent RCU readers will see
   * any prior initialization.

will remove smp_mb() and update the changelog in v2.

Thanks !

