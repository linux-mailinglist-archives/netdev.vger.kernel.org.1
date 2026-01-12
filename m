Return-Path: <netdev+bounces-249158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94630D1526D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D06D53043129
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A032D0CF;
	Mon, 12 Jan 2026 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTfUUzb0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4369328B6B
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768248463; cv=none; b=TLEOxx8dl/drM0Lc4Tw8h6LyCiIRFpH7NooBeUEcLDmdi3WsojE4JTfhHQANt1m2zpftV9LP4jJtIJIBuT1CHymiks3syOriG09f50EbVE+i6EG105jeapICrXsFY0sDBMA3fxj9XnjsEQVIfoKp1Zy9xz3jlkP9t/Td8du8jCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768248463; c=relaxed/simple;
	bh=bKGpksatJ7h95qxx5isa+XHlmwHBVYMyAWSFpOv/+2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VY2nU92EgAS7Mcb1naH12JPp+S7IMD+12dFqsQISanCBFhM8ZQyNZ7lfSbL69/tFk/3077Gl2zgKahVyduqjIEuFYidYaA7jlBPTXqgSWJBXh7fgLvwvr7NPbWe/vXs5b1gtj1KqglKEpC6i8c920rbyoEMfRA1bsvCttu9vPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTfUUzb0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-81f39ad0d82so4029584b3a.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768248461; x=1768853261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qP58P5BQmNvddqlCFJ4opUm2nkcQVF4H7227PvaY6u0=;
        b=CTfUUzb0ASFm9JqygIlTpUMrQrQLoa5TTOUmcMdkphxn0boiuNiJdtU7c9uy1XeeXu
         dyxTCAW8RaqYiH2akRmCQ6W7fVz3ZXEryKIS4MF7zZJFoGEAQcPFr9zolwqO2G9tRhHO
         P6d3gYxMvXEu+we1PALssLm9ZD10csAWGkJ+ywitEHA96VgUXYsV4/aBc6RxXWwq2xgc
         AFtT4ptR7KNgJcuoOaoT7jMyqR8MP0fO/M48Eso2SbHwP5Z7cfQUbt2AopHMHHfqE4Zv
         IZU207HE94m+LpOxbCTtf2tkU8VLJqbuFOgHeb2WDW8kRlh/rBP1Na/GgJ17YT5ZBXrZ
         jL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768248461; x=1768853261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qP58P5BQmNvddqlCFJ4opUm2nkcQVF4H7227PvaY6u0=;
        b=j3PipJhbWrqAAqXpkW8bX8m4f4fDeS01T82WOYj2rgSHdfpl4aOptDqI9wV/odDgO4
         4gOeAiqmOJ6UNkAkrf9M45CPofwfxgOcg65oEtWNJPAMLa+Xxokpjx+L1A01w5R1LHKG
         Bf1D6brl7wWgZsFwv7Cmda490RSdIdTSRSAsStsn2PpNFrypXosaflfo8jwYpka+iC9X
         C0Pc2aL8W+xHRTuaeaopYXQZbfB2Jwoj3gcKPwD6JksmZ3D7wBaqKmx3Xg9ZTFOAtqDC
         +1MPgnH3Lg1AG9S2E8iKjKMgA2lR9OG6uBMMJ5ZXOURMYUvdM+/fBWfU529aHVgDoasB
         pHMw==
X-Forwarded-Encrypted: i=1; AJvYcCUrIfw/6q/YRQfxzZSgAJVnz91B85t7kkVCrtFgnPZXDhKJzW/z/rd3OTp4nDEjD2Dnejr6TRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLn34BmnjZW/UijwqyWowYbSuzFjJt5IcCSS+0YsN92i6zrB6
	iRlGCkSDmwvfOkUAQm9tXOG2xzKtbVhFBs7YYMuCJVdL/oOOpjacvT6CiJE52UkXvmaQ5eyqgly
	588Gjng==
X-Google-Smtp-Source: AGHT+IHUnPfyFGN/mcoNGIggAHXF5G6+4iyOUbdjiW41nzcep0rzltP1a1ZWhRMF5+OppZoQa+NGYuJiXYw=
X-Received: from pfx53.prod.google.com ([2002:a05:6a00:a475:b0:7dd:8bba:63a6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3288:b0:81e:f623:b9fe
 with SMTP id d2e1a72fcca58-81ef623bbf2mr7776462b3a.4.1768248461198; Mon, 12
 Jan 2026 12:07:41 -0800 (PST)
Date: Mon, 12 Jan 2026 20:06:35 +0000
In-Reply-To: <20260112200736.1884171-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260112200736.1884171-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260112200736.1884171-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/2] gue: Fix skb memleak with inner IP protocol 0.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Tom Herbert <therbert@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+4d8c7d16b0e95c0d0f0d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported skb memleak below. [0]

The repro generated a GUE packet with its inner protocol 0.

gue_udp_recv() returns -guehdr->proto_ctype for "resubmit"
in ip_protocol_deliver_rcu(), but this only works with
non-zero protocol number.

Let's drop such packets.

Note that 0 is a valid number (IPv6 Hop-by-Hop Option).

I think it is not practical to encap HOPOPT in GUE, so once
someone starts to complain, we could pass down a resubmit
flag pointer to distinguish two zeros from the upper layer:

  * no error
  * resubmit HOPOPT

[0]
BUG: memory leak
unreferenced object 0xffff888109695a00 (size 240):
  comm "syz.0.17", pid 6088, jiffies 4294943096
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 40 c2 10 81 88 ff ff 00 00 00 00 00 00 00 00  .@..............
  backtrace (crc a84b336f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    __build_skb+0x23/0x60 net/core/skbuff.c:474
    build_skb+0x20/0x190 net/core/skbuff.c:490
    __tun_build_skb drivers/net/tun.c:1541 [inline]
    tun_build_skb+0x4a1/0xa40 drivers/net/tun.c:1636
    tun_get_user+0xc12/0x2030 drivers/net/tun.c:1770
    tun_chr_write_iter+0x71/0x120 drivers/net/tun.c:1999
    new_sync_write fs/read_write.c:593 [inline]
    vfs_write+0x45d/0x710 fs/read_write.c:686
    ksys_write+0xa7/0x170 fs/read_write.c:738
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 37dd0247797b1 ("gue: Receive side for Generic UDP Encapsulation")
Reported-by: syzbot+4d8c7d16b0e95c0d0f0d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6965534b.050a0220.38aacd.0001.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fou_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 3970b6b7ace53..ab8f309f8925d 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -215,6 +215,9 @@ static int gue_udp_recv(struct sock *sk, struct sk_buff *skb)
 		return gue_control_message(skb, guehdr);
 
 	proto_ctype = guehdr->proto_ctype;
+	if (unlikely(!proto_ctype))
+		goto drop;
+
 	__skb_pull(skb, sizeof(struct udphdr) + hdrlen);
 	skb_reset_transport_header(skb);
 
-- 
2.52.0.457.g6b5491de43-goog


