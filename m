Return-Path: <netdev+bounces-114982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96B944D7F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334E6288795
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB321A3BCB;
	Thu,  1 Aug 2024 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WdHaLOW7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEECF194AE6
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520402; cv=none; b=nYCzHqYN3oS7Sguiqdpjibhy01csjB5uc3tSSDgh+v74iU8YKGta+gXS4XM8TOwp0YvvBE6Kgcvo4DF1gIrVlWaf1C6zDcPYIEw9TtLnh3CvmNbznp5Wvk3L+tEbo5/zSOth1kCwL1KZDZJJyXFZzpP4t1636oQ42yMUTdqTOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520402; c=relaxed/simple;
	bh=SzXUe9yAHmRgo7R6pFkuKRFs9oyR/775MYH5D1wNDRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G//DT6CgFM+GH8iCEUd3yP+YrPBqJKhBikl8ymk/dqM0mPTNRpTDk9K0x8+feIY6hOlmro9tcqcE+N1+8chkCwftQDr7OKMqEWaLh7nKMKQJHGIo4OcpRbJcQLqoEYIcb9s4jHxXjwJ/yzoFPqyn6U3NF/wJxa8oUZXwWg0YILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WdHaLOW7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so806763566b.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722520399; x=1723125199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRqZUS14/M2IUp/ORafbn7y9pJ1mE6Kn31Q6JnF0XB4=;
        b=WdHaLOW7gQ6Oq4wmrY8BX4zwUjnhBZr5PQpYE5YL5zCXp4B/V0kkjduacUmNqPPlUW
         QqgnYURRx35d3+0bfXi5HN6BSHKOA7UZmij3NexdOoqSijjKWRK8WG/7L2v1sF0uDy6f
         6qRWrk4LczREs8up7tmxb+qxcd0ZfKJ35muzrBpgNuGcqRr8K+DiBSnSDhoi+6I8FlOO
         99hKX4HYOo4bsFUist01eggSQxkIUBIUvRBBpvCTSEOWA0NDv+X6i2P2usWKI2NtsOLQ
         XC4zVk9Y/dEmN4bERDN6OVD0Q8SikgzC7Ksc0mSowSuR3irTAumdkJPLaPSAf97rpef9
         xHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520399; x=1723125199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRqZUS14/M2IUp/ORafbn7y9pJ1mE6Kn31Q6JnF0XB4=;
        b=A5SBW7N1AaZuLG3jptdMVT48bxGlm6QMVQOkbB7Gyhve25fY7exdHKvZL6qYKaXZd0
         LxeN2GV4dBIuNHf+7fqbMO/8NRxvaZ7pjG6xr1AJjrEZM7K7lAvlLQ0oUKYtgEoEIDAy
         EtS48AWQBnHLSjw/qOtedxCJKoU8r2Xfm8FI6Xf8GWEG6fuaOLG0z0hNJl4d51R3xcpb
         hDih/TDwLfqaU2tYsHlJ8rM9UD4t3CDqlcI0GPSSv2mk6OGCM5Z3unWITfY5cmAPVuxQ
         AzMgoUbbueWcOHJbsHdjIo/O9+J4GNHNXRqWF1ymqakA8KDpxxvKZ95qGn14Kj6dligv
         NtLQ==
X-Gm-Message-State: AOJu0YwjdZqCSf53y2fvQjyd+mQiqy539JDCTe230kme48a7iBFzTFDc
	sjPuMuoYkGZfUNnVmiHL74ii+vMmL2RiAz87kOkUH0jkAdCC5DahCTgaMUiBbG8=
X-Google-Smtp-Source: AGHT+IFC8Nt7IdS9cyoElbCQwGvfqOu+K9/Hg/CKYM+cshFxLEB7Ldcn08ebwoCELzG18lHcQbgaiw==
X-Received: by 2002:a17:907:1b10:b0:a7d:3ab9:6a5d with SMTP id a640c23a62f3a-a7dc5130c90mr14692966b.69.1722520399066;
        Thu, 01 Aug 2024 06:53:19 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23d56sm902897166b.38.2024.08.01.06.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:53:18 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 01 Aug 2024 15:52:53 +0200
Subject: [PATCH net v2 1/2] gso: Skip bad offload detection when device
 supports requested GSO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-udp-gso-egress-from-tunnel-v2-1-9a2af2f15d8d@cloudflare.com>
References: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
In-Reply-To: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com, 
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

This can happen in two situations, which we detect in __ip_append_data()
and __ip6_append_data():

1) when there are IPv6 extension headers present, or
2) when the tunnel device does not advertise checksum offload.

Note that in the latter case we have a nonsensical device configuration.
Device support for UDP segmentation offload requires checksum offload in
hardware as well.

Syzbot has discovered the first case, producing a warning as below:

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

To fix it, skip bad offload detection when gso_segment has returned
nothing. We know that in such case the egress device supports the desired
GSO offload, which implies that it can fill in L4 checksums. Hence we don't
need to check the skb->ip_summed value, which reflects the egress device
checksum capabilities.

Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000e1609a061d5330ce@google.com/
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/gso.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/gso.c b/net/core/gso.c
index bcd156372f4d..88d5ca7d4fe7 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -122,10 +122,12 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 	skb_reset_mac_len(skb);
 
 	segs = skb_mac_gso_segment(skb, features);
+	if (IS_ERR_OR_NULL(segs))
+		goto out;
 
-	if (segs != skb && unlikely(skb_needs_check(skb, tx_path) && !IS_ERR(segs)))
+	if (segs != skb && unlikely(skb_needs_check(skb, tx_path)))
 		skb_warn_bad_offload(skb);
-
+out:
 	return segs;
 }
 EXPORT_SYMBOL(__skb_gso_segment);

-- 
2.40.1


