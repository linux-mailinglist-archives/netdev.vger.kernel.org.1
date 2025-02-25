Return-Path: <netdev+bounces-169282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3377AA4331A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA033A8432
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 02:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0F433D1;
	Tue, 25 Feb 2025 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB7i6LOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6231BC20
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450864; cv=none; b=upLznFdrhl0GuhXujezUY2Sps5eW9Ar1atxHXNx8qWAp3bqPUQvwiOYeeea/sG7sCMI1/ojLybAvGjI26oaVN1fOnYN3XwgulTPnZN5dp96lwQxn7XYcQ2lhVWfkoUcKTiZYA3jsWTdAAikXGa7q0zZ+PEQ4c6t6D9QUtNJNLfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450864; c=relaxed/simple;
	bh=DqJXFeBoLf4LPVH2d5ldqBWYbjWWar0pPyzgixhY3I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lFq7IxxLAM04BPFAxgzFyIuISb1qnqqr8B4jYwb4p0TZiy8pV3MnJu2yxL5/bSKChprT7pSlVDGcGuywa0zYIZbCrn+uNbP+KkIT0CHRSN9U50CMQ5FDPdnyIl8vHRV9HKWSf8aCJy3KRoJqD7kokJwc5IcCbFPm8c0zQkhogGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB7i6LOP; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7be8f28172dso399475385a.3
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 18:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740450861; x=1741055661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1lhvwzA1HspRde29mCO3Hvg54U9AilWQJ4oPv4i/xxs=;
        b=GB7i6LOPI5zTMvCdWyvHLtsYGehvezVRkyEnrjTxSAV4mQP+M5XmblSwZIQwv6z9aY
         hrusXb+llPo3qXtd6ldfaUELFZVYn+Xrm8Nb+QkZi1ZxGnxdDx8hYYGvmdn2Cn9u+00C
         Q4IM9IFMHgfWOiP/mI3yHyWaxvfRLYSbw6OkznsVQ2R31dcnIS0Kc75maAhYyqgLulaD
         EGq8cn0wItiRsisEhsrRWFBrtldT6KrDuBUB17FJR5XuEsvzsGGwO3IBFPHtr15niHd/
         zwudwhiiNW4k6LiB4gdfKBQA7+TiNab0bTp0uBGzsyzRQATNn2bneUDHc1uVRwtMz6l7
         1VHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740450861; x=1741055661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lhvwzA1HspRde29mCO3Hvg54U9AilWQJ4oPv4i/xxs=;
        b=Pg+KMNApjeP0KiKFyL6IEsPH56PhVn4iuIIqnMY8wqpRlMWPEdhZd+rXL81B8tO4R7
         unYJ58ljvv4NzQ1HwvlAA8uIf0E2+THlqtjPl09aNxXnSiGi7bJ0EKzbgqrxPewFeUHu
         Y46Q2YzsQGu5fSqKEeUOi06fAJ75/PSRbumPo5klM6zv0cztnrp3iMxO7DbR519D2hZ7
         qruQiqiomgiRQypHV1e5OPSyRM3T935LCrpSdDcEIenoPfFYkTEnKVtkvm+y1px4pc9D
         YU1OmHf/S7SdWrod9AC0tOqCBfw7MW+W4/y8YE8tpkcDNHm2YCckHoPzNZ+P5SsGE5Da
         2CVQ==
X-Gm-Message-State: AOJu0YwaWv3NHRQex8CiJVEu+cd1OaIJdiK2p6n7cz9wGauB4Rvy0IlM
	f4WuNMKYjbxzWeOFTssojt6imRKzxMfis0HZ/Mp6ygVbh+KolhzL0sfqCA==
X-Gm-Gg: ASbGnctufX0EYOmTQdXl/9n7keStsh3Z8N9/ds1Rn/TEw2U/mMpW14fH5qXFdhclJCN
	QQpiJ+hAtRmP2SrC6Lxn+9++/eMVoIyUmL9qPm/hGcKNFfjIAjeFGGBxczvK4Qs50HFUywg9Udc
	bDjxWqCfpMl6xc19UKQc+PHH+T94585IoS/bgvHQGR1pg2o6c1JdAqkqD7XtUSATmSQsLPI3wB2
	Xz+K3lFltEipczXiM1FkAHfXXLL6W4JHTLM4NGxF0E3urWTO/0kidk5MUHH+ULpn4sNVfeAMK7N
	y43kyWsvJglZ3SQs9kVptIFFh3ipkTgQqvTLQOXMIU84BsPIxH9kKnkTifU/6SZ0Eu9eBADx264
	z+knbto0GgOqzOO1zgP8HVfy5pQ==
X-Google-Smtp-Source: AGHT+IFgNLdHgGRPA9CbyIRqkkPAgsUzwvbs5AgDio+ECxfRplKFN+MEi/p7goULCTFXY/FscwtWqQ==
X-Received: by 2002:a05:620a:4594:b0:7c0:8950:e3ed with SMTP id af79cd13be357-7c0cef6fb3amr2503367285a.54.1740450861085;
        Mon, 24 Feb 2025 18:34:21 -0800 (PST)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c299294sm53043085a.17.2025.02.24.18.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:34:20 -0800 (PST)
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
Subject: [PATCH net-next v2] net: skb: free up one bit in tx_flags
Date: Mon, 24 Feb 2025 21:33:55 -0500
Message-ID: <20250225023416.2088705-1-willemdebruijn.kernel@gmail.com>
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
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

---

v1->v2
  - fix up conflict in net/socket.c with merge of BPF tx timestamping:
    SKBTX_HW_TSTAMP vs SKBTX_HW_TSTAMP_NOBPF
  - add Reviewed-by tags from v1
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
index 3044392e8ded..472f009630c9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1668,7 +1668,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
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
index f2bb8473d99a..171aa15f6541 100644
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
@@ -500,7 +500,6 @@ enum {
 				 SKBTX_SCHED_TSTAMP | \
 				 SKBTX_BPF)
 #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
-				 SKBTX_HW_TSTAMP_USE_CYCLES | \
 				 SKBTX_ANY_SW_TSTAMP)
 
 /* Definitions for flags in struct skb_shared_info */
diff --git a/net/socket.c b/net/socket.c
index 0545e9ea7058..b64ecf2722e7 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -680,18 +680,9 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
 {
 	u8 flags = *tx_flags;
 
-	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
+	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE)
 		flags |= SKBTX_HW_TSTAMP_NOBPF;
 
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


