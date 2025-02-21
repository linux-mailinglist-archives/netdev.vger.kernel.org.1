Return-Path: <netdev+bounces-168380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E40A3EB90
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 04:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA477AABF9
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 03:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF91F35979;
	Fri, 21 Feb 2025 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JubySQse"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083A61D63F5
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740110386; cv=none; b=P9qdNGTNKbdtp7VTdFASacPhiPvY9EkOZVh2B74zVtO+pQadVi42fa9uGjfuqcJnyc+zZbmaH2G0/LGRWSmvmQ5q2LYky4ULYiUtKBPopc7sY39YAg+LTBFCz9yf5Fk3GuIfpliv97l8Cy6NAo1+zXry7k2iOIvVNhfcQk6HTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740110386; c=relaxed/simple;
	bh=h078lvkPf3yrYNkI4zNP0kyiGVio1sBcVi/oZ1+hFWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fk1t/8IeA5hPAISPnUEgLsOsdbKarQkwSVUyUxLkRWSrzCMIeNPkMDibVLnA41RfWR+NAvWZhAOGw5OFuuvSIlNsJcnxL6jxfzunrb23bxo7OGaAj8BvL2tPG0j/wtwDVmJbzy47H//i0JN8q67n9fWkvx0YYMXuzh+HvNPA4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JubySQse; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0848d475cso227536685a.2
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 19:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740110383; x=1740715183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=un5GChYqZwN7VAu7/Hs5R+68xnCxbZaFqj2VLrbWywg=;
        b=JubySQse3DflVHeSv2dKtCSXMotlFXw2neweTtZzEBZk4AnEAo6ZHQwxH6rc+U2fx4
         47EL9iSgdCYUmxxHb9GjZzccceVOyVJ5VZqFz3piwqyfZSvbZ1uqnbLMKJap9LY74MnF
         k3MTlExrl+uCV1iBlYlryYO8ZzJCHxZ642QCltHwWY/XvHddiOvN2S0Kl5Dhz9y0mg+b
         KkI0VIVmduwV2AqtRIhWuqub0qvCaiTAYERWPw+R5TaGdIN3ANdh0HWVz16GWE9hNuxD
         aKL5kORckdZCMAL817wWQqoJvFj2jqPPCRUrxuj6OiPSzElExYdVo7FH6KasoUP4HQQU
         PNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740110383; x=1740715183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=un5GChYqZwN7VAu7/Hs5R+68xnCxbZaFqj2VLrbWywg=;
        b=nOP8E1LcBNGol9Z1voamH2LWlGu2Ou33tdVXJKhLIkGiWrbinH/1VUgbvXd7MKc6Ch
         p3pOLnMlWCivUDdjA15dTxFrNhvEHQ9FVplVj2HfvagewN3ccr4l39zFGpWONE7lE3TM
         irQOOVQulT1rykzfZnxpT5ZZEQFjJ5qnqu8cYGb0BY+zuCfuPPPAJxACompgf7w+r7mz
         SFoPe3ikG2gsDdI3C6Q27Bd18Jtqb/0l8nk093fuM226VuIANBcpFWHz9DiyIoG/4WHd
         KQUo4XNqD/wYHR6OZKnJTa/Nr1dozoaQMbuVaVbZ/l4OjnFfaGrPFGUwXniMQMZr84Sj
         RF+Q==
X-Gm-Message-State: AOJu0YwMkGUe//gqWpTLG/nFQmvHbPrGgHfTwmti0OwPpc3CiG7rjGoU
	WDdzfypdW4Fxx32fw1YO5nIKyVDNHWVwqt6/Uej94jdbcN7Ca/pi3ZZndg==
X-Gm-Gg: ASbGncsA2ySK6wcVZQeOtiolCjJn35r3nQl3gAZplnQ7vH3qccLq6a5D9B1dZO5k/yV
	lNRk1T0Pc76P8ANIY5tPl6SP0FPqma+JSMrYA9L+s3VXKf/hL871BkegVwopSeKiuwTW0KMy4bM
	TmqYYzjW0aUuxUzmsxEJiZAP4v3Hc/CSmH52+5HaU9I5SCKWxyjhqfFkdMycz2FZROAeRCId41W
	AfcVH1OWI8iw+cjRDxeSehSAEYZadr15shQgBJ0i9e86PzCTv/Sk4bjZHFYtjpxPpoDIwwLuJ6X
	XPmft7wVqv/tuGvGiWEhxnh9uCRIAEdE+yEyGmmsU05rIpGYygtzqtukLnhJK81b1VKE3u6p3AP
	k+19yi+URqQrdsP/c+8vE
X-Google-Smtp-Source: AGHT+IG4NWBbIArs7R43wONcedTaPXCSB1X9bHJ/GrgoscmXNbmPWyfDwUIBONeUjj/Kj2kPlMN/0Q==
X-Received: by 2002:a05:620a:2987:b0:7c0:c201:1e0b with SMTP id af79cd13be357-7c0ceef793emr254165885a.17.1740110382817;
        Thu, 20 Feb 2025 19:59:42 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09f33bc60sm549891085a.108.2025.02.20.19.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 19:59:41 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	kerneljasonxing@gmail.com,
	pav@iki.fi,
	gerhard@engleder-embedded.com,
	vinicius.gomes@intel.com,
	anthony.l.nguyen@intel.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] net: skb: free up one bit in tx_flags
Date: Thu, 20 Feb 2025 22:58:20 -0500
Message-ID: <20250221035938.2891898-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

The linked series wants to add skb tx completion timestamps.
That needs a bit in skb_shared_info.tx_flags, but all are in use.

A per-skb bit is only needed for features that are configured on a
per packet basis. Per socket features can be read from sk->sk_tsflags.

Per packet tsflags can be set in sendmsg using cmsg, but only those in
SOF_TIMESTAMPING_TX_RECORD_MASK.

Per packet tsflags can also be set without cmsg by sandwiching a
send inbetween two setsockopts:

    val |= SOF_TIMESTAMPING_$FEATURE;
    setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &val, sizeof(val));
    write(fd, buf, sz);
    val &= ~SOF_TIMESTAMPING_$FEATURE;
    setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &val, sizeof(val));

Changing a datapath test from skb_shinfo(skb)->tx_flags to
skb->sk->sk_tsflags can change behavior in that case, as the tx_flags
is written before the second setsockopt updates sk_tsflags.

Therefore, only bits can be reclaimed that cannot be set by cmsg and
are also highly unlikely to be used to target individual packets
otherwise.

Free up the bit currently used for SKBTX_HW_TSTAMP_USE_CYCLES. This
selects between clock and free running counter source for HW TX
timestamps. It is probable that all packets of the same socket will
always use the same source.

Link: https://lore.kernel.org/netdev/cover.1739988644.git.pav@iki.fi/
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c |  4 ++--
 drivers/net/ethernet/intel/igc/igc_main.c  |  3 ++-
 include/linux/skbuff.h                     |  5 ++---
 net/socket.c                               | 11 +----------
 4 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 0d030cb0b21c..3de4cb06e266 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -852,8 +852,8 @@ static bool tsnep_tx_poll(struct tsnep_tx *tx, int napi_budget)
 			struct skb_shared_hwtstamps hwtstamps;
 			u64 timestamp;
 
-			if (skb_shinfo(entry->skb)->tx_flags &
-			    SKBTX_HW_TSTAMP_USE_CYCLES)
+			if (entry->skb->sk &&
+			    READ_ONCE(entry->skb->sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC)
 				timestamp =
 					__le64_to_cpu(entry->desc_wb->counter);
 			else
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 84307bb7313e..0c4216a4552b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1650,7 +1650,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		if (igc_request_tx_tstamp(adapter, skb, &tstamp_flags)) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			tx_flags |= IGC_TX_FLAGS_TSTAMP | tstamp_flags;
-			if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_USE_CYCLES)
+			if (skb->sk &&
+			    READ_ONCE(skb->sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC)
 				tx_flags |= IGC_TX_FLAGS_TSTAMP_TIMER_1;
 		} else {
 			adapter->tx_hwtstamp_skipped++;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..a65b2b08f994 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -478,8 +478,8 @@ enum {
 	/* device driver is going to provide hardware time stamp */
 	SKBTX_IN_PROGRESS = 1 << 2,
 
-	/* generate hardware time stamp based on cycles if supported */
-	SKBTX_HW_TSTAMP_USE_CYCLES = 1 << 3,
+	/* reserved */
+	SKBTX_RESERVED = 1 << 3,
 
 	/* generate wifi status information (where possible) */
 	SKBTX_WIFI_STATUS = 1 << 4,
@@ -494,7 +494,6 @@ enum {
 #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
 				 SKBTX_SCHED_TSTAMP)
 #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
-				 SKBTX_HW_TSTAMP_USE_CYCLES | \
 				 SKBTX_ANY_SW_TSTAMP)
 
 /* Definitions for flags in struct skb_shared_info */
diff --git a/net/socket.c b/net/socket.c
index 28bae5a94234..2e3e69710ea4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -680,18 +680,9 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
 {
 	u8 flags = *tx_flags;
 
-	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
+	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE)
 		flags |= SKBTX_HW_TSTAMP;
 
-		/* PTP hardware clocks can provide a free running cycle counter
-		 * as a time base for virtual clocks. Tell driver to use the
-		 * free running cycle counter for timestamp if socket is bound
-		 * to virtual clock.
-		 */
-		if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
-			flags |= SKBTX_HW_TSTAMP_USE_CYCLES;
-	}
-
 	if (tsflags & SOF_TIMESTAMPING_TX_SOFTWARE)
 		flags |= SKBTX_SW_TSTAMP;
 
-- 
2.48.1.658.g4767266eb4-goog


