Return-Path: <netdev+bounces-161599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07353A22953
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 08:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8831885A96
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEE61A8F7A;
	Thu, 30 Jan 2025 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QxjwJ781"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A201990C3
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738223762; cv=none; b=k7g5Jvx/sKrprRUdpCDBl/WztAqZf80J7xhfS81vrfyu6LZwhkWF9wnjsFwSSeJZxaGOxCOn/prb6mCl/rSH2Qeh9fGnfNyBKh+WTSm24l0rYsNLuPg8CyMXUmKmBEgc+WxFx0NZE+PdlMAD2BFF/7tEH2/XOz+TE333EI8rceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738223762; c=relaxed/simple;
	bh=SahFX2KFPBl9owsYWpi3lFqwrzYFVVWPeBWDKwYl7dY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=joUfjcPOyv22cxjz6LuuH5K1D6L535v1b8F+JiULDZSN3tyXeDndmh2/jI3HORuwQzivVdR/UI83eV7NBBH9h084sRzFv+aDRcfitjYrJ7brJOzSnxbj6S1HX6UQ9srLF4vLmAXqJt8s1NM0k9WNxNkc3xaXsFRLsrdm6OtAqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QxjwJ781; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dd049b5428so3820666d6.2
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 23:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738223759; x=1738828559; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1G1O7K0l1YuMoDNXIHAxVpiayqI4GueBHWvDpZUuxvg=;
        b=QxjwJ781O7A3L4H5brsS5E19B6LR+OGFPU1AjkleyJxCxO0nTRr3ztnssO5/76IHfU
         RFy9Sn6BiCU2AP6zSELLLtL7WSCqmqX9T72PxUu89kv7AoipTPkBBs99kLfD36AsvVPV
         LiFboZlrooUhS/hrCcO9ocK88ZSHCMkwm1w+eXGQ8gveHRaHgsZ/Z3OuecFLurcWLGeC
         lOGfRV4AfEmjGhr4wB08HxsWzN0LTtdl5xgB9oj/NJpeEc02xYgeKp/9eevazld5PjKd
         26C+eFfpMbZX44e6vwBl6w0rccqdsPvVaDrFT3gKy63+xjLc02lxbtQJ+h/aCQZLBJkc
         Vc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738223759; x=1738828559;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G1O7K0l1YuMoDNXIHAxVpiayqI4GueBHWvDpZUuxvg=;
        b=bz1sPPlQND/lCq6oJbapRcxJD5Z55gUOvleM2kZ4BeikVLGTn+LEze2RS4q6iAc+4i
         X71J8qZFQnLYxZ7OEyRcyVNfxhtllK65mOuPQnn3JM5K+IAMU0ause3hERjCJh1z9pM+
         uGtlmhZ1EZbuUE1Q07VJL6dhvMvnucfBoyckp7hcMvhO1KALQwNtrc+GtdfWfAvNvdPU
         oEO4++0hB5JtFuKmnECXoHKKwMbNCtihH9cEv3Q83ZcP1DYadQKKqdufv7GNkwrsL08k
         z9na3VK/OIXSjuTEI9Hn4bJ0VX48XDvzWVSkk0oaFeq1BN/Cu2gD0a0TxaeWn+h21YTX
         7H+g==
X-Gm-Message-State: AOJu0Yz9NUHJo9pV/WBIV6pQL+JDJ0C3JjX+jg5w0aUFM5HYOMFTKXqP
	Hcbm/CUGJk7QeNHNxXT2078gz49BjFslTC0xzM7aeLb6s6FrYSfGc1gagP5KZModQpV6P4Ff3zF
	3
X-Gm-Gg: ASbGncv2/rryCocvj1gR8+304wkj2Gn7npzF2cV7QoJQBLa1LxmH6btbdBp5aDez0C9
	Z7UQI3fhuEq5/1TsFyqogxi58AZXFaMsb/1w9d1YkNHoT2yKPjXnAlULXhair1sqOW1KSzWcV2/
	0Q1lOaQ2EPRbMfbmqDaD29iYIyL8AHU08Oxsh3epxXu/hz0BQdO8c2kvMXrsxgo7LZgqnAgFMKk
	2Xau/x0kraXCwJhZhOvayH40IYhqUavYlyFkbZs/bQain1cKLm3hWbN9NlunD6LD3Vc6SiRoH3W
	bPg=
X-Google-Smtp-Source: AGHT+IH3PTHfqvB2vqnMrZMRHGh6PBHBVrM91TtJJ09yAJbOCgQlAe8MytjqcZnxZHDIm0iRGYObCg==
X-Received: by 2002:a05:6214:19eb:b0:6d4:1e43:f3a5 with SMTP id 6a1803df08f44-6e243c15524mr94797886d6.13.1738223758452;
        Wed, 29 Jan 2025 23:55:58 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:25a5::3c0:2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254819f92sm3656896d6.48.2025.01.29.23.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 23:55:57 -0800 (PST)
Date: Wed, 29 Jan 2025 23:55:54 -0800
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Josh Hunt <johunt@akamai.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH v2 net] udp: gso: do not drop small packets when PMTU reduces
Message-ID: <Z5swit7ykNRbJFMS@debian.debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoided GSO
for small packets. But the kernel currently dismisses GSO requests only
after checking MTU/PMTU on gso_size. This means any packets, regardless
of their payload sizes, could be dropped when PMTU becomes smaller than
requested gso_size. We encountered this issue in production and it
caused a reliability problem that new QUIC connection cannot be
established before PMTU cache expired, while non GSO sockets still
worked fine at the same time.

Ideally, do not check any GSO related constraints when payload size is
smaller than requested gso_size, and return EMSGSIZE instead of EINVAL
on MTU/PMTU check failure to be more specific on the error cause.

Fixes: 4094871db1d6 ("udp: only do GSO if # of segs > 1")
Signed-off-by: Yan Zhai <yan@cloudflare.com>
--
v1->v2: add a missing MTU check when fall back to no GSO mode suggested
by Willem de Bruijn <willemdebruijn.kernel@gmail.com>; Fixed up commit
message to be more precise.

v1: https://lore.kernel.org/all/Z5cgWh%2F6bRQm9vVU@debian.debian/
---
 net/ipv4/udp.c                       | 28 +++++++++++++++++++---------
 net/ipv6/udp.c                       | 28 +++++++++++++++++++---------
 tools/testing/selftests/net/udpgso.c | 14 ++++++++++++++
 3 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c472c9a57cf6..0b5010238d05 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1141,9 +1141,20 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
+		if (datalen <= cork->gso_size) {
+			/*
+			 * check MTU again: it's skipped previously when
+			 * gso_size != 0
+			 */
+			if (hlen + datalen > cork->fragsize) {
+				kfree_skb(skb);
+				return -EMSGSIZE;
+			}
+			goto no_gso;
+		}
 		if (hlen + cork->gso_size > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
@@ -1158,17 +1169,16 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 			return -EIO;
 		}
 
-		if (datalen > cork->gso_size) {
-			skb_shinfo(skb)->gso_size = cork->gso_size;
-			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
-			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
-								 cork->gso_size);
+		skb_shinfo(skb)->gso_size = cork->gso_size;
+		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
+		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
+							 cork->gso_size);
 
-			/* Don't checksum the payload, skb will get segmented */
-			goto csum_partial;
-		}
+		/* Don't checksum the payload, skb will get segmented */
+		goto csum_partial;
 	}
 
+no_gso:
 	if (is_udplite)  				 /*     UDP-Lite      */
 		csum = udplite_csum(skb);
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 6671daa67f4f..d97befa7f80d 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1389,9 +1389,20 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
+		if (datalen <= cork->gso_size) {
+			/*
+			 * check MTU again: it's skipped previously when
+			 * gso_size != 0
+			 */
+			if (hlen + datalen > cork->fragsize) {
+				kfree_skb(skb);
+				return -EMSGSIZE;
+			}
+			goto no_gso;
+		}
 		if (hlen + cork->gso_size > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
@@ -1406,17 +1417,16 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 			return -EIO;
 		}
 
-		if (datalen > cork->gso_size) {
-			skb_shinfo(skb)->gso_size = cork->gso_size;
-			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
-			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
-								 cork->gso_size);
+		skb_shinfo(skb)->gso_size = cork->gso_size;
+		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
+		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
+							 cork->gso_size);
 
-			/* Don't checksum the payload, skb will get segmented */
-			goto csum_partial;
-		}
+		/* Don't checksum the payload, skb will get segmented */
+		goto csum_partial;
 	}
 
+no_gso:
 	if (is_udplite)
 		csum = udplite_csum(skb);
 	else if (udp_get_no_check6_tx(sk)) {   /* UDP csum disabled */
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 3f2fca02fec5..fb73f1c331fb 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -102,6 +102,13 @@ struct testcase testcases_v4[] = {
 		.gso_len = CONST_MSS_V4,
 		.r_num_mss = 1,
 	},
+	{
+		/* datalen <= MSS < gso_len: will fall back to no GSO */
+		.tlen = CONST_MSS_V4,
+		.gso_len = CONST_MSS_V4 + 1,
+		.r_num_mss = 0,
+		.r_len_last = CONST_MSS_V4,
+	},
 	{
 		/* send a single MSS + 1B */
 		.tlen = CONST_MSS_V4 + 1,
@@ -205,6 +212,13 @@ struct testcase testcases_v6[] = {
 		.gso_len = CONST_MSS_V6,
 		.r_num_mss = 1,
 	},
+	{
+		/* datalen <= MSS < gso_len: will fall back to no GSO */
+		.tlen = CONST_MSS_V6,
+		.gso_len = CONST_MSS_V6 + 1,
+		.r_num_mss = 0,
+		.r_len_last = CONST_MSS_V6,
+	},
 	{
 		/* send a single MSS + 1B */
 		.tlen = CONST_MSS_V6 + 1,
-- 
2.30.2



