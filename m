Return-Path: <netdev+bounces-105862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC593913504
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 18:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EEC1C21805
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4879816D9A4;
	Sat, 22 Jun 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AT2Dr0v4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA11DDF6
	for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719072905; cv=none; b=Fbft1EYkuro186kwnDfoFaxw4j8Gnk6CNfxLfSMkXOhmdQq5gT2L9/oOjHaMH5Ls+QHgxOt9zvSTT/rLsfio/iJX7lZr3YN11atfm4amoBuL5xzi7hekwtD3U4I9oZYiR3GbNFTlVbRO6AI6mCP6dIkCBRsTveKJizZNFib68kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719072905; c=relaxed/simple;
	bh=0ek9sJhw/UU8IfH4dg6OHpcDaDCD/kzK8V1Isb2fs1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jz1VzaDzL6TipCo7OKIieESF1T63Etpyapt58cXsnA+/TIa3Rd5CzCoKCLCtUf2jNFljrGif3bZ3N00q/4XrwlrD00EH3uccKUJCp+5g9m6GCUzk304ltzyYyTLqQragbmJ3Sa0Ujtwpg6ANI8nNuH2/OytE6eI/8+2l5kM9VSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AT2Dr0v4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a72420e84feso34379766b.0
        for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719072901; x=1719677701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo5EcQwxfcPl8qYxY9uvDOYxJ5jxoLP4iqhWtHEy6O4=;
        b=AT2Dr0v4DGYEoZysfqR/vmBiSuh2QhO2Vn9sAYHAoyFdvN4rod3lnLe/3/VLiVW7Y3
         sZJbC7bsc0KVYfZ/zKsPVcEb1Lp6KrUUS8nzYbt0pNTCDOuf2YSCXb1GjPd7KU7BCYx1
         Hv4jJTUesbGNB6nEgzUP/pBIvxEns458PcxzHyBW05vKwWKHW5q9jI5fZUhvkgzCpz4V
         trMNBMx8hSzCUd3Kf52k95IXPHGbQi+my6MxQEiZLLWSNyRa9gWRykg+9keiaZF+83p3
         acYIUfO8VWqhjY/eG35RuD/aFNPlfid/nS/vN8GjqdW8fsF26FLKjm/SXIa8JT6XsuAh
         5i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719072901; x=1719677701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eo5EcQwxfcPl8qYxY9uvDOYxJ5jxoLP4iqhWtHEy6O4=;
        b=h93t8CHdwU3aSOqFx8VnFDdV9wj7gu6qBfdGv/Uu5JCk1oKeO5+IiZNJ16va87Q3fD
         +y/+vkuqHYZk6GlgOlETcvT1yRyO9E21K5kSH1hX9CQgLqUrtaaeco1Yq82ggjNoR/kO
         SXPhmpWwIQtxr7e0V5TfBO9wmCpiTGZi5wDLdCiztrLo2ORWhWkJe/UMziuRaDLnjp1+
         8wV7QOSGP7nHOL2Bty/g0t9evm+HLzBqyEQJtuA40TwN4h9Ca8kjM36dGBpbaIgIX6RC
         pESL7mK3Z0r9x9zmFIVQ56yM/6cp5OkUneRZwyq4btd0xN2F5YtXTEuvcpgVgFfOpnNH
         Qudw==
X-Gm-Message-State: AOJu0YwxokPigp4Wzcrf49NSKtE1wC6qCWdXiLGMtpm2TBGXcaFLxUsD
	gTPeOB2pFMACtMth5CYi7O/VTjNJvlQwUQeG7kLRz/HD/qZAQgt0S9y1gcXOirM=
X-Google-Smtp-Source: AGHT+IHVEvpG8E7HGrpoPt53//s4ckm3N7n//1MesOG+xW42w246UgDgDbFASIyJn55993M4qYUyyw==
X-Received: by 2002:a17:906:3509:b0:a6f:8042:de89 with SMTP id a640c23a62f3a-a7245cc0811mr12478766b.70.1719072901018;
        Sat, 22 Jun 2024 09:15:01 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf54937asm209180866b.128.2024.06.22.09.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 09:15:00 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 22 Jun 2024 18:14:43 +0200
Subject: [PATCH net 1/2] udp: Allow GSO transmit from devices with no
 checksum offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240622-linux-udpgso-v1-1-d2344157ab2a@cloudflare.com>
References: <20240622-linux-udpgso-v1-0-d2344157ab2a@cloudflare.com>
In-Reply-To: <20240622-linux-udpgso-v1-0-d2344157ab2a@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.13.0

Today sending a UDP GSO packet from a TUN device results in an EIO error:

  import fcntl, os, struct
  from socket import *

  TUNSETIFF = 0x400454CA
  IFF_TUN = 0x0001
  IFF_NO_PI = 0x1000
  UDP_SEGMENT = 103

  tun_fd = os.open("/dev/net/tun", os.O_RDWR)
  ifr = struct.pack("16sH", b"tun0", IFF_TUN | IFF_NO_PI)
  fcntl.ioctl(tun_fd, TUNSETIFF, ifr)

  os.system("ip addr add 192.0.2.1/24 dev tun0")
  os.system("ip link set dev tun0 up")

  s = socket(AF_INET, SOCK_DGRAM)
  s.setsockopt(SOL_UDP, UDP_SEGMENT, 1200)
  s.sendto(b"x" * 3000, ("192.0.2.2", 9)) # EIO

This is due to a check in the udp stack if the egress device offers
checksum offload. TUN/TAP devices, by default, don't advertise this
capability because it requires support from the TUN/TAP reader.

However, the GSO stack has a software fallback for checksum calculation,
which we can use. This way we don't force UDP_SEGMENT users to handle the
EIO error and implement a segmentation fallback. Even if it means a
potentially worse performance (see discussion in [1]).

Lift the restriction so that user-space can use UDP_SEGMENT with any egress
device. We also need to adjust the UDP GSO code to match the GSO stack
expectation about ip_summed field, as set in commit 8d63bee643f1 ("net:
avoid skb_warn_bad_offload false positives on UFO"). Otherwise we will hit
the bad offload check.

[1] https://lore.kernel.org/netdev/87jzqsld6q.fsf@cloudflare.com/

Fixes: bec1f6f69736 ("udp: generate gso with UDP_SEGMENT")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/udp.c         | 3 +--
 net/ipv4/udp_offload.c | 8 ++++++++
 net/ipv6/udp.c         | 3 +--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 189c9113fe9a..8d542e9f4a93 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -938,8 +938,7 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 			kfree_skb(skb);
 			return -EINVAL;
 		}
-		if (skb->ip_summed != CHECKSUM_PARTIAL || is_udplite ||
-		    dst_xfrm(skb_dst(skb))) {
+		if (is_udplite || dst_xfrm(skb_dst(skb))) {
 			kfree_skb(skb);
 			return -EIO;
 		}
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 59448a2dbf2c..aa2e0a28ca61 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -357,6 +357,14 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	else
 		uh->check = gso_make_checksum(seg, ~check) ? : CSUM_MANGLED_0;
 
+	/* On the TX path, CHECKSUM_NONE and CHECKSUM_UNNECESSARY have the same
+	 * meaning. However, check for bad offloads in the GSO stack expects the
+	 * latter, if the checksum was calculated in software. To vouch for the
+	 * segment skbs we actually need to set it on the gso_skb.
+	 */
+	if (gso_skb->ip_summed == CHECKSUM_NONE)
+		gso_skb->ip_summed = CHECKSUM_UNNECESSARY;
+
 	/* update refcount for the packet */
 	if (copy_dtor) {
 		int delta = sum_truesize - gso_skb->truesize;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c81a07ac0463..ab4d0332488e 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1257,8 +1257,7 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 			kfree_skb(skb);
 			return -EINVAL;
 		}
-		if (skb->ip_summed != CHECKSUM_PARTIAL || is_udplite ||
-		    dst_xfrm(skb_dst(skb))) {
+		if (is_udplite || dst_xfrm(skb_dst(skb))) {
 			kfree_skb(skb);
 			return -EIO;
 		}

-- 
2.40.1


