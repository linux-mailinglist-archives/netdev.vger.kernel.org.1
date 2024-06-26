Return-Path: <netdev+bounces-107030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 170AB918B27
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D94FB23ECD
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207BB190468;
	Wed, 26 Jun 2024 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TVUeWRqE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45701190475
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424315; cv=none; b=lwLrXulg/xqyCT3UUQbW0OiRF+yLKqJfZG3OtcYe/zXzSpk8YXF3uCB18hyfD1iguqGLdSgsowq990Z31Gy22H6tjM402Czqj8DkQ8W6yCCzoWABvQi18JFRlCE/EBF3E8XjMMGwbL5XzFZ0RFZVilF7VhNdkiU25/zRB6VRUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424315; c=relaxed/simple;
	bh=3Da8c+zpUWviQRKqjPWrrW99HUsX5LqHzwm9bNbRPeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaULDnIKMh+c/eRHdQIDTN8uyfGzcsZ1jfsrzS0j2YQ2dLIoCIe8JZTfTZzV2hx3MYy8/a6p9jnd90CzpDnH0eXWaP3Qbyvvm+uqUv8LQ23coR/SCozQKP6qbBye9K63AKl7PqumV6/z+DM16rU5Gm3l7/widX4dzMckHssuA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TVUeWRqE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a72459d8d6aso501673866b.0
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719424311; x=1720029111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mb0cojTwBGMBnTfDfM28Ysc2awIvqJcISENi/CuLoGQ=;
        b=TVUeWRqEQP8mt6MVpcxAGr5ZTlqhoEf0N7WEPXip7qyPUiAKgH92pnhE/UZg2sUiGP
         qpNrv8IeIo4pzmDMHZ35ap8KmDXTLKLTF3K7TKMM2Q9WD0Ylh+44WP7nDs+5e6AGiFb/
         zVSrVwmJpGzJ7rpuJtdkHtTGi4NhWsh2mpecdi0ijDFl6Qg/R0Qz2xX4MOChSfmxlqQW
         IHvoUodbOPQmk3avn4uhQgRjt3VI7yfgXwxXokTL3cA474Tca/lAWZj/xyoDwgFxoItM
         PsZxvNAt7GTmy74ZhWzmotjAbd/+KZs9QA4kgsOpdZ6itJuxYPb3lOWvMDA7JaJhDO2a
         nNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719424311; x=1720029111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mb0cojTwBGMBnTfDfM28Ysc2awIvqJcISENi/CuLoGQ=;
        b=G/S37NPXzwuRzPK8ZcB52AcwSEF6lZKX08hDrB7cG9k4lJvGKKq4OBvuWJGOtVc01g
         ShbgS1ZiigqxgxN7FdGrwM+IOxbAGlRghoVGeIvrp19KYM0jwUQWuQhI+hMFAVQl+YoU
         5Z9P2SnRZrV0y/nMkJHERrucH1sVexcl2TX5iZM7pqX9IzBadUwHcD63TVFDo1lo8Lfa
         l0l7VdP/4KzSSLVphiBVGbkwtb4lIZMlIoPFtz+VEF3Fko8kom0r//MuiQlwWS+EOsPE
         DNs+Cfv8A+7LqaOFkLfJk0kTAH8VSqlqrlWNd8Wrcj8Ru808dAonyKhLLV2SuCa/JLcf
         eNbw==
X-Gm-Message-State: AOJu0Yy64XzVkjzHx3OR3UzjiwPtNFYnnhlVHLKjPqeSOSN0HXzt/+O4
	tENMmtK7XjBnTziKtnxMHwG7qImUAZAMoXt2TAHrKLlhwu9VH9QS5788D4Kk8IYJDwsXK5lVo/n
	h
X-Google-Smtp-Source: AGHT+IEq+3M1mrIZlQqeyxVnR+ElMKv5WyMOJZKAn6wAMcwAK2755BLz/iEkRy9bstkTYNto4nRDcA==
X-Received: by 2002:a17:907:160e:b0:a72:81f5:85b6 with SMTP id a640c23a62f3a-a7281f58b42mr329229666b.18.1719424311139;
        Wed, 26 Jun 2024 10:51:51 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7243cd3908sm448699266b.192.2024.06.26.10.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:51:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 26 Jun 2024 19:51:26 +0200
Subject: [PATCH net-next v2 1/2] udp: Allow GSO transmit from devices with
 no checksum offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-linux-udpgso-v2-1-422dfcbd6b48@cloudflare.com>
References: <20240626-linux-udpgso-v2-0-422dfcbd6b48@cloudflare.com>
In-Reply-To: <20240626-linux-udpgso-v2-0-422dfcbd6b48@cloudflare.com>
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
checksum offload. While TUN/TAP devices, by default, don't advertise this
capability because it requires support from the TUN/TAP reader.

However, the GSO stack has a software fallback for checksum calculation,
which we can use. This way we don't force UDP_SEGMENT users to handle the
EIO error and implement a segmentation fallback.

Lift the restriction so that UDP_SEGMENT can be used with any egress
device. We also need to adjust the UDP GSO code to match the GSO stack
expectation about ip_summed field, as set in commit 8d63bee643f1 ("net:
avoid skb_warn_bad_offload false positives on UFO"). Otherwise we will hit
the bad offload check.

Users should, however, expect a potential performance impact when
batch-sending packets with UDP_SEGMENT without checksum offload on the
egress device. In such case the packet payload is read twice: first during
the sendmsg syscall when copying data from user memory, and then in the GSO
stack for checksum computation. This double memory read can be less
efficient than a regular sendmsg where the checksum is calculated during
the initial data copy from user memory.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/udp.c         | 3 +--
 net/ipv4/udp_offload.c | 8 ++++++++
 net/ipv6/udp.c         | 3 +--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d08bf16d476d..ed97df6af14d 100644
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
index b56f0b9f4307..b5456394cc67 100644
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


