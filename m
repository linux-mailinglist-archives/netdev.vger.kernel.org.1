Return-Path: <netdev+bounces-112941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F9493BF73
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598711F235BF
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECC0198A21;
	Thu, 25 Jul 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DfsAaJ5o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4C197A7E
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721901371; cv=none; b=GkfX1+XF8aT4OCMsAdKq8xxNkYtNdZgj7BqoYtTNbpGXDCW64SX/EncuJBDbuUvcfWVvbl3q4ic/Tcykj7PTQhDyzszy79p7J5e4AvZgJt6L+h9EEC5sIjTmT05aVBF+U76b+636Fl0gzwcmDdepKCw1pwaKMdOyGyWF9WCpk30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721901371; c=relaxed/simple;
	bh=AMepbPBuiAndoZNIqu6LMe+1SuPQ5NAw9ref/4KTv0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQvhEj2KZNEC06dq0ANeVf6NNbEAoODnrorxP7oNiaQlBhrAXw4S/nHNus55gHzms+hKQkW/pEp42y8wQNTgQSwf2sEOjeqdlnLsrnW/NPYc9AEnwg1Y/3DHQw5tkfOo1RQx7omb3TgvxBgBVIXHAM4rRRGSPfMTsV+A0r1xTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DfsAaJ5o; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f040733086so2574111fa.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721901368; x=1722506168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74Z6aFGKFjtexyskQPjkbYW3PBAHSrDII1Pddn3LbSw=;
        b=DfsAaJ5oMEq7fYp2CscKfAWRwKv9qOF1QCEExj1Hf4AGnvWdLP/Dr+R3VexxwnvUlg
         ccFf+g/jKwFuhdG2v2rhqvvE+gg26fvrZj7HnPJ7VOmp9ig8H2byAQ6ahw/IRe29zvqQ
         0dfyBfqr2eoSFt04RImTKGGZmSIG/ZO/2Gkg74r1meEfF5WrojW/hWEHhthYk4iwCkFf
         7XZqoOwvrw5QHEsTXtsYa1ejGS+uYS2Db8L2K8oXxSQgUsYzESWOt15UC0U89n+JBqWz
         Bko2JB97xd1xxRmtFXmGGKa60S01bfAjxyZr4Z7KlOwjkBs4CFZlPLGKy8yXaGqUq7Oy
         lhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721901368; x=1722506168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74Z6aFGKFjtexyskQPjkbYW3PBAHSrDII1Pddn3LbSw=;
        b=o8V+HeiVlgdxEBGtmAaS+QX0t6s/UkCaMZA5XJt+rzJJxJqAG2pOznFg0nua8Mobcr
         Smzei4x/LLd98X+3kNui7HgbgNbi6ExC1CW4ljPdkkGpdS+yv1Z594PkY8YDMa5y+MtJ
         HZZt+yQyDWKAt+QycttJvORZnYiEDubodTtPPOYh/504NCnR2exFC24RLiEgylLGBDGe
         oqrAwm8tTKnZgdKEFGk/sHsewIFryYkLc9SWptMMGR+IhfJfbuiWj8J9xlFHWwMUIjr6
         OJ+2nk5F10sdc4fnkDZ0/mafsjXQPyStJN6TkUlSWxPVI/g2LEiadQ0VvT6vr5xHqZsh
         v0wA==
X-Gm-Message-State: AOJu0YynSuhftJ6taNsT6X2idBZc8a+xolBeHYTdT/sGAwb9MGGiogiM
	hRlNcF2HpyZhuy6o+NSyiPshzRM3/2VoVLLD3/qxxHmJRL0uOlxcERSl7lSbOEc=
X-Google-Smtp-Source: AGHT+IHwqjbF1whk//BExo85ZkNTvC+vx72wj4mgpBoZQ8lkJlWkOxbaD197nPUBInkeNzZ22SqM/Q==
X-Received: by 2002:a2e:8089:0:b0:2ec:56d1:f28 with SMTP id 38308e7fff4ca-2f039ca783dmr15940851fa.26.1721901367744;
        Thu, 25 Jul 2024 02:56:07 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b0395sm641490a12.20.2024.07.25.02.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:56:07 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 25 Jul 2024 11:55:54 +0200
Subject: [PATCH net 1/2] udp: Mark GSO packets as CHECKSUM_UNNECESSARY
 early on on output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-udp-gso-egress-from-tunnel-v1-1-5e5530ead524@cloudflare.com>
References: <20240725-udp-gso-egress-from-tunnel-v1-0-5e5530ead524@cloudflare.com>
In-Reply-To: <20240725-udp-gso-egress-from-tunnel-v1-0-5e5530ead524@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com, 
 syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
X-Mailer: b4 0.14.1

In commit 10154dbded6d ("udp: Allow GSO transmit from devices with no
checksum offload") we have added a tweak in the UDP GSO code to mark GSO
packets being sent out as CHECKSUM_UNNECESSARY when the egress device
doesn't support checksum offload. This was done to satisfy the offload
checks in the gso stack.

However, when sending a UDP GSO packet from a tunnel device, we will go
through the TX path and the GSO offload twice. Once for the tunnel device,
which acts as a passthru for GSO packets, and once for the underlying
egress device.

Even though a tunnel device acts as a passthru for a UDP GSO packet, GSO
offload checks still happen on transmit from a tunnel device. So if the skb
is not marked as CHECKSUM_UNNECESSARY or CHECKSUM_PARTIAL, we will get a
warning from the gso stack.

Today this can occur in two situations, which we check for in
__ip_append_data() and __ip6_append_data():

1) when the tunnel device does not advertise checksum offload, or
2) when there are IPv6 extension headers present.

Syzbot has triggered the second case, producing a warning as below:

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

To fix it mark UDP_GSO packets as CHECKSUM_UNNECESSARY early on the TX
path, when still in the udp layer, since we need to have ip_summed set up
correctly for GSO processing by tunnel devices.

Note that even if GSO packet gets marked as CHECKSUM_PARTIAL due to tunnel
advertising HW csum offload, it will not prevent software csum offload in
UDP GSO from kicking in if the underlying device doesn't offer csum
offload (for example, a TUN/TAP device with default config). This is
because we recheck device features in gso stack instead relying on the
ip_summed hint.

Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000e1609a061d5330ce@google.com/
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/udp.c         | 7 +++++++
 net/ipv4/udp_offload.c | 8 --------
 net/ipv6/udp.c         | 7 +++++++
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 49c622e743e8..b7254b8a1e56 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -946,6 +946,13 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 		}
 
 		if (datalen > cork->gso_size) {
+			/* On the TX path CHECKSUM_NONE and CHECKSUM_UNNECESSARY
+			 * have the same meaning. However, check for bad
+			 * offloads in the GSO stack expects the latter, if the
+			 * checksum can be calculated in software.
+			 */
+			if (skb->ip_summed == CHECKSUM_NONE)
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
 			skb_shinfo(skb)->gso_size = cork->gso_size;
 			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
 			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index aa2e0a28ca61..59448a2dbf2c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -357,14 +357,6 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	else
 		uh->check = gso_make_checksum(seg, ~check) ? : CSUM_MANGLED_0;
 
-	/* On the TX path, CHECKSUM_NONE and CHECKSUM_UNNECESSARY have the same
-	 * meaning. However, check for bad offloads in the GSO stack expects the
-	 * latter, if the checksum was calculated in software. To vouch for the
-	 * segment skbs we actually need to set it on the gso_skb.
-	 */
-	if (gso_skb->ip_summed == CHECKSUM_NONE)
-		gso_skb->ip_summed = CHECKSUM_UNNECESSARY;
-
 	/* update refcount for the packet */
 	if (copy_dtor) {
 		int delta = sum_truesize - gso_skb->truesize;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 6602a2e9cdb5..360392fc2b68 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1262,6 +1262,13 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 		}
 
 		if (datalen > cork->gso_size) {
+			/* On the TX path CHECKSUM_NONE and CHECKSUM_UNNECESSARY
+			 * have the same meaning. However, check for bad
+			 * offloads in the GSO stack expects the latter, if the
+			 * checksum can be calculated in software.
+			 */
+			if (skb->ip_summed == CHECKSUM_NONE)
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
 			skb_shinfo(skb)->gso_size = cork->gso_size;
 			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
 			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,

-- 
2.40.1


