Return-Path: <netdev+bounces-116771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2BA94BA2E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543A71F22812
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A99E189F3C;
	Thu,  8 Aug 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Spm4v1ZT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BC4189BBA
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111003; cv=none; b=Wqihd4u+8bLGbyldwY40pg+ZF5SuRKrZ5JNSK6fbIhso/ThKxVBXDhvtPYl0bUbtGaLEWiymVkc/iWZiO0Rf/chTMAqVBmpuYmqL8WjquoIkwV8dMosKzUqYplhGmCXTMjl5iSNMle5XN8hoB44Nm+yvz/nt+3TJ8mUxwCPf4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111003; c=relaxed/simple;
	bh=ofYrxRiFhAJ70TVaiyriyzdb+syk1ls6MOJtx+2Po5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AU8QZLvHyZDsHoJMNmPM9Rn8XRASHt8DjuAFSSUI5CtpBmWYMCEFOAhISx+R89AYtiQT2pNctmFwuPTPx5seO9rHA8jRllwvCaAi0nWndB0dD9Ex8hJQsmrCHkuseolA1OFYMk4QgKwm7xfROZ4uZSdADZCVlq2oNuFZwZyP0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Spm4v1ZT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a9e25008aso93887066b.0
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 02:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1723111000; x=1723715800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/p599qWvyrM2c1Jt+DzFLji+41+NVKxZDoSr/2/IUk=;
        b=Spm4v1ZTb+MZ1iud5PEOilsqg7hKUUpWsib4l5j5tuv26hljJdBO7MbmGJovg9XAMK
         y6s8L/fFdRqdXx8A5Ii08RX8dur25P6ql0FNbZmB44VXVnGGHTLC+sp40Q3bieVD47pD
         bFX3Y5450RvhKyv2yLg0xJ3vN7qU4JnOK/JfY2vgyBQ2fPzIeAWGSamt8ZhXJSgXUCWK
         i1NPXb3sCl8CQu0OssvXSlx3122iLhX6roeobcQyfCLC7YUKtbKeYFFjBreqctQnoC7u
         htDCI0rtsSfBTojRSzZKVXPfAOCUw1MEX38LRqpYyjKFMZOOm/7AuyxZyrAh731Jhbyv
         568A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723111000; x=1723715800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/p599qWvyrM2c1Jt+DzFLji+41+NVKxZDoSr/2/IUk=;
        b=bKpxWnk0mpvl/JdNGH2Y7r1cQxbnKswpXO3I0AapLMEFMyz3FNUkLvqTVG43E7dJcu
         NEKC2efC2FLSJV1SdJE3urQ8HRew+IgcF0vsSWvCV2kRGhpA1cAYg0nwhDdgRQsZnVBu
         kGHXTYswpgqdq/cPMCeZrnnHBitdq4q8Jg2gM9tKWcgcgxXMOT7ljp/oIiesWEi0F+CV
         Vx65pNVuFi+5FxhpXmknl8C1Io9Rn4rGO21Hhl//3Ki8x53+RWqRY9QQyfd1D4a9soFp
         CubdsZMEOt+u24l5xQSpzwwBq6D2EPMcQI7qzSFZb4GybnvHD6wFU6w6v0+7Z6DjD/Az
         +pqw==
X-Gm-Message-State: AOJu0YyeT9ArutC2bOHjRkIzOtZLlnVazzc5pWFLY1AlC7DPagfbGQuK
	H0UnAYEGBQVInwHxIYAZCzZW0PeFL3XWCLKwjaxhd6YZ4LFmHjjPYlRDEISKXiUGr6EKX6UThu5
	m
X-Google-Smtp-Source: AGHT+IHuSQ+h3WttOIeZug8k0eSMiyMkYw4Yre4VeI/PSqUtXaOITRLh4J2SUa3/5JG9zR9Hj20vSQ==
X-Received: by 2002:a17:907:f764:b0:a7a:1d35:4106 with SMTP id a640c23a62f3a-a8090beb83cmr97479266b.5.1723110999734;
        Thu, 08 Aug 2024 02:56:39 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e8c732sm723103166b.187.2024.08.08.02.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:56:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 08 Aug 2024 11:56:22 +0200
Subject: [PATCH net v4 2/3] udp: Fall back to software USO if IPv6
 extension headers are present
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-udp-gso-egress-from-tunnel-v4-2-f5c5b4149ab9@cloudflare.com>
References: <20240808-udp-gso-egress-from-tunnel-v4-0-f5c5b4149ab9@cloudflare.com>
In-Reply-To: <20240808-udp-gso-egress-from-tunnel-v4-0-f5c5b4149ab9@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kernel-team@cloudflare.com, 
 syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com, 
 Willem de Bruijn <willemb@google.com>
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
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


