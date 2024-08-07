Return-Path: <netdev+bounces-116565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D417794AF37
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7932A1F226F2
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 17:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCE113E3F6;
	Wed,  7 Aug 2024 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d3AY6XQd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1D13E025
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053327; cv=none; b=sDqKJq1URLhpfWRPiEWf5v0yTh2ZaU2dFxM/LXpajIsy5nFZ6gHKkjw/icfu+IbUBTPHqNXe1Gve27BpBoOO4RX00hjZ+ag+rDBTbdP34v7W5/Hic7nC2fH64ZJ8qu6GumLbNWpu5aRDbh9hJVpOIndacpQnPHevhq6jxAvSo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053327; c=relaxed/simple;
	bh=rOt1O09oy9mrPry+P9E1ZWO2ddvquKRMzbBHhJzM0Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y86wI68tDekyCa67l3DQsd0k1PjqohXFzzKnCAE/+BH+92rJgBUaXcveF/7LSyWigmUZ0vf00egrBfJrCT0lwT/VqTiT0V24i3TMX9imQmf7WTBsLOZp/7aVbS7jifPylU0r9iE0sdF10221wHLVp9Y1aBPF+V/Ia4L2rWF8qzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=d3AY6XQd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so86107e87.2
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1723053324; x=1723658124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/3D5w+q6MISOydg6FT3J9TTsflbSnxeBAtnGlJu6tA=;
        b=d3AY6XQdRa8luCbWzN7Cyt95qoDAIAm4ZXWB6kgnC2yPp4rQiG/S2SYkibc0eTyM8S
         jTYHa3kyUbp/2z3nUZDtG7xfbAP8x1o2UeSDdwdblg8kmAyqqTw897aNvLDkdNRRJgCK
         3na7z03nsVic4P8tC9P45p5OS7WXDJWcPowpqoajIyBez8wWPFnJ7+mlhSVxeGdWCJlA
         ta0cStnChhmhURp/OelwJalEO6d5BrQCW5z39VxSg6yVO2UYL3cz7wpbrq2rFAn4mFPn
         qCNNjHhv+HozMoqi8uHySv++Y7axIeL9LtyFvmK01hmz6c7+9Z6cBITmPfwIivE38uSa
         kxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053324; x=1723658124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/3D5w+q6MISOydg6FT3J9TTsflbSnxeBAtnGlJu6tA=;
        b=Q7jZ9oNN4+HnxmacjcgKizbD/5vLVCbbfSIMa1rZHC+G0qt7pZpWdHDTeucfICsYta
         FkWwixyfsIxImy2RHrqzbMc27qr7wbp79UvWW/sz5lG1tvQuPG2Ic9zuUXsbL/JZVqx9
         kzoGQFnMJLN6nqs8s8SLVKA892YvrYwNj4UhmvfJC7jCOyALabrOTy3tOSmRWuqCV1t5
         xQ5m3MoRoY8vFRufw1/UHmHg2uUK71lMkiYvsPIx1PUZ8ErKZ+hHbdtawuMfKvxgZvmg
         GzAPfK6aK5LyPM8TBuxyCov+M+2spcTnTGxqyXTNCxq60H2Cyi0UzCWuDHObiiYG+d24
         MRqA==
X-Gm-Message-State: AOJu0YyuLgIIb9umS3+ja1Elu9dfyo8RD+JX23wFBm9TTVmChutNv3ER
	UPD62vvque16b2DijpZCu2rNk4y4wMwAuUvlWKn9/6NdrM1moFlMj/nO+qFlFG8=
X-Google-Smtp-Source: AGHT+IFKHK9Vdfwo3uD/Jo7ruamgE2JaOzaZNrf7jI6dLiZBko/hEtvPNK7rv/e4yST+LzwP2R4fmg==
X-Received: by 2002:a05:6512:3b8c:b0:52f:44b:7d42 with SMTP id 2adb3069b0e04-530bb3b4340mr13647060e87.58.1723053324021;
        Wed, 07 Aug 2024 10:55:24 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839b2b556sm7201521a12.25.2024.08.07.10.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:55:23 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Aug 2024 19:55:04 +0200
Subject: [PATCH net v3 2/3] udp: Fall back to software USO if IPv6
 extension headers are present
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-udp-gso-egress-from-tunnel-v3-2-8828d93c5b45@cloudflare.com>
References: <20240807-udp-gso-egress-from-tunnel-v3-0-8828d93c5b45@cloudflare.com>
In-Reply-To: <20240807-udp-gso-egress-from-tunnel-v3-0-8828d93c5b45@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kernel-team@cloudflare.com, Jakub Sitnicki <jakub@cloudflare.com>, 
 syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
X-Mailer: b4 0.14.1

In commit 10154dbded6d ("udp: Allow GSO transmit from devices with no
checksum offload") we have intentionally allowed UDP GSO packets marked
CHECKSUM_NONE to pass to the GSO stack, so that they can be segmented and
checksummed by a software fallback when the egress device lacks these
features.

What was not taken into consideration is that a CHECKSUM_NONE skb can be
handed over to the GSO stack also when the egress device advertises the
tx-udp-segmentation / NETIF_F_GSO_UDP_L4 feature.

This will happen when there are IPv6 extension headers present, which we
check for in __ip6_append_data(). Syzbot has discovered this scenario,
producing a warning as below:

  ip6tnl0: caps=(0x00000006401d7869, 0x00000006401d7869)
  WARNING: CPU: 0 PID: 5112 at net/core/dev.c:3293 skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
  Modules linked in:
  CPU: 0 PID: 5112 Comm: syz-executor391 Not tainted 6.10.0-rc7-syzkaller-01603-g80ab5445da62 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
  RIP: 0010:skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
  [...]
  Call Trace:
   <TASK>
   __skb_gso_segment+0x3be/0x4c0 net/core/gso.c:127
   skb_gso_segment include/net/gso.h:83 [inline]
   validate_xmit_skb+0x585/0x1120 net/core/dev.c:3661
   __dev_queue_xmit+0x17a4/0x3e90 net/core/dev.c:4415
   neigh_output include/net/neighbour.h:542 [inline]
   ip6_finish_output2+0xffa/0x1680 net/ipv6/ip6_output.c:137
   ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
   ip6_send_skb+0x112/0x230 net/ipv6/ip6_output.c:1958
   udp_v6_send_skb+0xbf5/0x1870 net/ipv6/udp.c:1292
   udpv6_sendmsg+0x23b3/0x3270 net/ipv6/udp.c:1588
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg+0xef/0x270 net/socket.c:745
   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
   ___sys_sendmsg net/socket.c:2639 [inline]
   __sys_sendmmsg+0x3b2/0x740 net/socket.c:2725
   __do_sys_sendmmsg net/socket.c:2754 [inline]
   __se_sys_sendmmsg net/socket.c:2751 [inline]
   __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2751
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   [...]
   </TASK>

We are hitting the bad offload warning because when an egress device is
capable of handling segmentation offload requested by
skb_shinfo(skb)->gso_type, the chain of gso_segment callbacks won't produce
any segment skbs and return NULL. See the skb_gso_ok() branch in
{__udp,tcp,sctp}_gso_segment helpers.

To fix it, force a fallback to software USO when processing a packet with
IPv6 extension headers, since we don't know if these can checksummed by
all devices which offer USO.

Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000e1609a061d5330ce@google.com/
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/udp_offload.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index bc8a9da750fe..b254a5dadfcf 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -282,6 +282,12 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		     skb_transport_header(gso_skb)))
 		return ERR_PTR(-EINVAL);
 
+	/* We don't know if egress device can segment and checksum the packet
+	 * when IPv6 extension headers are present. Fall back to software GSO.
+	 */
+	if (gso_skb->ip_summed != CHECKSUM_PARTIAL)
+		features &= ~(NETIF_F_GSO_UDP_L4 | NETIF_F_CSUM_MASK);
+
 	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
 		/* Packet is from an untrusted source, reset gso_segs. */
 		skb_shinfo(gso_skb)->gso_segs = DIV_ROUND_UP(gso_skb->len - sizeof(*uh),

-- 
2.40.1


