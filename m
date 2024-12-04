Return-Path: <netdev+bounces-148965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 983BC9E3A1E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC1CB3AF53
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104E11B414A;
	Wed,  4 Dec 2024 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1xGxQGi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464071B4156
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314346; cv=none; b=B1CZt9/8yYj8yMLPFRwE6IEyBl2uY5bEMtHtWZ+gl59hoPbcw6NnuZDYjnXO6cFXSGdL/C/LN5FJh5piQUdKb4QAwWldPr6Ne6/ZOp9qbZjIk8WWR06dmcph7gLU7UvwvvkICWAzC9ESB9oDVLJ1NDN0J7nfA4RvwYG/r80wvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314346; c=relaxed/simple;
	bh=yfW5CZ3Ae1lKb3KUb9+qjYO4HzhkocoamiIm35IKoxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXUinwQTQ40UeuJqQLt2hKqt1zJBihxKzQZ2gyhs0IcFTd1EqYWMBed3skY3JpTw+atYqE15pHw6YY5ZGR8ORSg1qL5oaF6U2r8ZorB8IMXMYTQSkqcIWaLdkM2YWoUOzupXgek5pkaDWKoA8wPin9iKI0EvJr6MxPOru7FfuQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1xGxQGi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733314343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPcYD/aJMpToswHBYZzrI2LxLzh/itgNPaRFtcK1BxA=;
	b=I1xGxQGigUGas1mepxOwkbw92Vygi7JRv2fUZYyXjueDMcPRWwnmCAFjHg2nNZGvbvaRip
	lAr3HoqMaUQOUdJljymDAT/y//z7HdwdJOw3KYZBr9MZVUBWjrZLw2jSpQ04DGuZ4kGzB9
	eEVu22H7oVPCtLfIFpY5HQ8gRI7Ak/c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-bsvBRnvnNj-IjgEHzJsh0w-1; Wed, 04 Dec 2024 07:12:21 -0500
X-MC-Unique: bsvBRnvnNj-IjgEHzJsh0w-1
X-Mimecast-MFC-AGG-ID: bsvBRnvnNj-IjgEHzJsh0w
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434941aa9c2so38275935e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 04:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314340; x=1733919140;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NPcYD/aJMpToswHBYZzrI2LxLzh/itgNPaRFtcK1BxA=;
        b=aYwxgt9XtAF/G6gWc0LkHffZNv/5VTT/ra7Cg6GWu+x5FORGlGr7RmytXaaUHQmObZ
         exjPGRHpEs6K8mDYFEXRAjcrKHS9SuPTlbcxHWkbGEtz88DlIiw+SoMdUtdxC90EvQez
         p6LurIrD+XbEs8gjmK7wlfQQW2qv0lP4Tx60rqTx/pizvxxBxwbrHRX95GPk5YLQox1C
         yjdl7C3WrgUZuzzeQ+hiy2R+UuB5YHGy1Wt0tBjptPnt9hKLx9wk++kduJxwxkOYvDkt
         xNOih9lyGLOa/g095cWt0zOtyqaBvB7HSFa6sHzc0zBvniSvIjgUXZWQ3oXzlqfo0qgy
         DzSg==
X-Forwarded-Encrypted: i=1; AJvYcCV5JXJdHY85cnlHSxTok6B73oj2OAFQY0D23vpyRwdZRP09hTdZC+BFNXIWr0NS1d497NUZeUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRe1xHDpN253mjClMJNpmK0iIUaYnBPvvsrqo8DaJWhR9tyC1M
	eKRh6IoGJrplud9Kd+CvDh/AV2RUZAmEIHntabJSprY3h6ylstRDpXUxg6+ffnWg2A9kJot6EMk
	HiKaoSFrToXZAqNnoB9TPkNQd1fJsQ6wTYuP13bMMtyaDm5VZOni9T1/oqUp1Xw==
X-Gm-Gg: ASbGnctTUTw/IGOFupEwJf+Yf1LDZddJPrtFW8pthZ3bhmD4zmC21YaN4ekcCek/tcv
	kB8WPeO6tfrA4ogITHkeprmPFRWrfwvaBdl8IbilzJfwb7ayBQo+LfN9dfOm/VnZa8pQ5CqWJta
	I+/BouRxxSDIyVTmEWLIAn+Xjv1BN+hAHnB2HOzO3B4okq0c0YenG4gFoQAD+NLk4Ke15LVJfei
	0ECbsixpmYrKHVI29ytMIZ4zBi9V9bgWGi1/JAIhqYxbhoAVQuipaG9DWDt3w==
X-Received: by 2002:a05:600c:a06:b0:431:2b66:44f7 with SMTP id 5b1f17b1804b1-434d3fe3419mr37696845e9.31.1733314339627;
        Wed, 04 Dec 2024 04:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQIriXO1qeiwwb0228Q3s9PYIzIJZhCGwDsmIeysEgkes+aVGEj7/ctclCqD/EhtwFClWdlQ==
X-Received: by 2002:a05:600c:a06:b0:431:2b66:44f7 with SMTP id 5b1f17b1804b1-434d3fe3419mr37696615e9.31.1733314339226;
        Wed, 04 Dec 2024 04:12:19 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ecc3db32sm10364158f8f.59.2024.12.04.04.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:12:17 -0800 (PST)
Date: Wed, 4 Dec 2024 13:12:15 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+3ec5271486d7cb2d242a@syzkaller.appspotmail.com
Subject: Re: [PATCH net] geneve: do not assume mac header is set in
 geneve_xmit_skb()
Message-ID: <20241204131215.7bf19507@elisabeth>
In-Reply-To: <20241204004228.0a18cfe6@elisabeth>
References: <20241203182122.2725517-1-edumazet@google.com>
	<20241204004228.0a18cfe6@elisabeth>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Dec 2024 00:42:28 +0100
Stefano Brivio <sbrivio@redhat.com> wrote:

> Hi,
> 
> On Tue,  3 Dec 2024 18:21:21 +0000
> Eric Dumazet <edumazet@google.com> wrote:
> 
> > We should not assume mac header is set in output path.
> > 
> > Use skb_eth_hdr() instead of eth_hdr() to fix the issue.
> > 
> > sysbot reported the following :
> > 
> >  WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 skb_mac_header include/linux/skbuff.h:3052 [inline]
> >  WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 eth_hdr include/linux/if_ether.h:24 [inline]
> >  WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 geneve_xmit_skb drivers/net/geneve.c:898 [inline]
> >  WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 geneve_xmit+0x4c38/0x5730 drivers/net/geneve.c:1039
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 11635 Comm: syz.4.1423 Not tainted 6.12.0-syzkaller-10296-gaaf20f870da0 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> >  RIP: 0010:skb_mac_header include/linux/skbuff.h:3052 [inline]
> >  RIP: 0010:eth_hdr include/linux/if_ether.h:24 [inline]
> >  RIP: 0010:geneve_xmit_skb drivers/net/geneve.c:898 [inline]
> >  RIP: 0010:geneve_xmit+0x4c38/0x5730 drivers/net/geneve.c:1039
> > Code: 21 c6 02 e9 35 d4 ff ff e8 a5 48 4c fb 90 0f 0b 90 e9 fd f5 ff ff e8 97 48 4c fb 90 0f 0b 90 e9 d8 f5 ff ff e8 89 48 4c fb 90 <0f> 0b 90 e9 41 e4 ff ff e8 7b 48 4c fb 90 0f 0b 90 e9 cd e7 ff ff
> > RSP: 0018:ffffc90003b2f870 EFLAGS: 00010283
> > RAX: 000000000000037a RBX: 000000000000ffff RCX: ffffc9000dc3d000
> > RDX: 0000000000080000 RSI: ffffffff86428417 RDI: 0000000000000003
> > RBP: ffffc90003b2f9f0 R08: 0000000000000003 R09: 000000000000ffff
> > R10: 000000000000ffff R11: 0000000000000002 R12: ffff88806603c000
> > R13: 0000000000000000 R14: ffff8880685b2780 R15: 0000000000000e23
> > FS:  00007fdc2deed6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b30a1dff8 CR3: 0000000056b8c000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >   __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
> >   netdev_start_xmit include/linux/netdevice.h:5011 [inline]
> >   __dev_direct_xmit+0x58a/0x720 net/core/dev.c:4490
> >   dev_direct_xmit include/linux/netdevice.h:3181 [inline]
> >   packet_xmit+0x1e4/0x360 net/packet/af_packet.c:285
> >   packet_snd net/packet/af_packet.c:3146 [inline]
> >   packet_sendmsg+0x2700/0x5660 net/packet/af_packet.c:3178
> >   sock_sendmsg_nosec net/socket.c:711 [inline]
> >   __sock_sendmsg net/socket.c:726 [inline]
> >   __sys_sendto+0x488/0x4f0 net/socket.c:2197
> >   __do_sys_sendto net/socket.c:2204 [inline]
> >   __se_sys_sendto net/socket.c:2200 [inline]
> >   __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f  
> 
> Oops. Thanks for looking into this.
> 
> > Fixes: a025fb5f49ad ("geneve: Allow configuration of DF behaviour")
> > Reported-by: syzbot+3ec5271486d7cb2d242a@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/674f4b72.050a0220.17bd51.004a.GAE@google.com/T/#u
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Stefano Brivio <sbrivio@redhat.com>
> > ---
> >  drivers/net/geneve.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> > index 2f29b1386b1c81640562e6ce91d6e8d88f0ffe1c..bc658bc6088546d5d1f116988b93d4dda915a799 100644
> > --- a/drivers/net/geneve.c
> > +++ b/drivers/net/geneve.c
> > @@ -895,7 +895,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
> >  		if (geneve->cfg.df == GENEVE_DF_SET) {
> >  			df = htons(IP_DF);
> >  		} else if (geneve->cfg.df == GENEVE_DF_INHERIT) {
> > -			struct ethhdr *eth = eth_hdr(skb);
> > +			struct ethhdr *eth = skb_eth_hdr(skb);  
> 
> Now, while your patch clearly looks better than the alternative, I
> wonder: if skb->mac_header is not set...
> 
> >  			if (ntohs(eth->h_proto) == ETH_P_IPV6) {
> >  				df = htons(IP_DF);  
> 
> does eth->h_proto contain anything meaningful at this point?

At a second look: yes, it should always have the Ethertype, because you
can't encapsulate anything that doesn't over GENEVE. At this point, if
it's IPv4 or IPv6, we'll set DF, and otherwise we leave it unaffected.

Thanks for fixing this.

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano


