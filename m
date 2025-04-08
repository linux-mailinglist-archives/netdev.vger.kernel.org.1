Return-Path: <netdev+bounces-180105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35238A7F976
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D53189EBA7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C33265CD5;
	Tue,  8 Apr 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPUJPrmn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8B26561D
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104422; cv=none; b=aqLDy0RGIV9RIs8zU6eKPlf8De7EzODrkw3t4GJcdn3Y+sm0kCLQC1ClD7XBtC+ghLONo5376yW45pvv39mBG3umeRgbmeXt/jyyy2Y/vZtB3esu9mLtYLbWzhQ639vIKMRG9uvboCVTMlNoVQH/5AoFQ9rCO5wPI0A+fvpH3FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104422; c=relaxed/simple;
	bh=dsXVE/P3ksamdr9lbNLawroyXEXQ82KK9ihSJD9xwBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kKscWDatTIoqAK7QtdrnOPZnNZyGdmyNoO4w8q+HZC6OqokDxfOsYXCh3GtS2juSfmXAcz0u0Nh0IG4y/Hd/HhwyLX/CjdDr655UeYeGfOSGNXwjwdTk468dqvYrF4C/MJ/feWVYoYHwrM2gWKeCL5MKCBuqOSv+yOFXTWIh2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IPUJPrmn; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-548409cd2a8so6323944e87.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 02:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744104419; x=1744709219; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qo02R4WgRsXISq9TxS5rUrIYyAJDxJLE4WNWVwbz01s=;
        b=IPUJPrmn/b0sRsLfmVfRvD0bi1lb2sNaLRhl4Vf9OdzWI4MeYxtrwGKdy5d6w3vn2e
         yJyeievz6Sq5GUFwRSs57DnmjRaLZtjFjEIjfRcVN3YfFRSH8PIIftnNY9ctCvqMQnm3
         ueheSHDjyv0EgABATUahtwW4fuXwGGPCwst4hSE6flMVC49uLzex9/x11U8vOL+UNRMX
         vLy40wxq+sSwjM237/2OmRQkTXn+B+gUnznqVWtIDMdN61ARobs9RcbnoaQ9NnM59Tii
         Fh5ID8lB8YwxHV3BsQ/9VqTnCho1kRzHpd7k15alrSGtnMKbctss1aPwBg8mUT7yo3Y6
         me9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744104419; x=1744709219;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qo02R4WgRsXISq9TxS5rUrIYyAJDxJLE4WNWVwbz01s=;
        b=ff7Dld/s0qYzQ1Kwg4zXDDSSvnXSUvfaYac+/2BGuGh2sRzYBB4YXSztgtB8LLXiL7
         OgGEvGyKx26pdZX6kdQa/64U/dML/uEyJ9EgsYyFx1hp+TylvWdOfWmH7XrfaGKJJewL
         2kh6aHf0fdvMHe5n3Ws/PdC/c6AdCJxtMtsAfuTZfxaePuPqp7dJfra9sURviDa/KMqI
         0xIZ23elccg3ScWBrc/Y9rGlc8Uc+8Q/ucFJ4aMXSipbGKWMquWW8L40G7EzbMJDCGcQ
         QqqSxYM7EexcEic1o0VXdgcAw9jGaVXUPh76v7+mHBIDpqC9mE9nob0aMNNgdoTMNNrz
         DE2g==
X-Gm-Message-State: AOJu0YwuGUc9M0d1ToALbhM7AYNcJ8O7w1QAXLpvzDSt8gHwk68l5tcl
	EaAVL5zaQ4LpNqCoUCtV6Qvg2RB+9+4IzECx+hI2OIR8yYKjNIghIB+9HmwLTsQ=
X-Gm-Gg: ASbGnctKza31Dggn3ZJa7iRdsSUTZK7IVIyHQQyL6RHsJWt87VKUnCMHoO3ytgzXBDC
	dh5iP3ab34JvFRYfG/j9XGNUoR8Pxc/8kCGhWmHEQUxSo5K/zZ5hyQdaPApbFgj6gzTxNGOQXx6
	2GkybKGwQn2jbbdqFDAfBRITfIJbreM+7SnZUSqZSzFhrR9Vwn2dtOUGZGJRWOixHvKd3XhrJcu
	GEgyCdk6iQ9AMbIkYZ3ye8AYP6jfwtpzMhUMxNjC5pR0yq4EdyO2cV0SQMlkxg3IG8zA6wIZoTl
	/9G+Hx2LQytVfo4ARiHbkKSuK/HtmT7G7Zdhv2kkTcljbCm9XdIWERY=
X-Google-Smtp-Source: AGHT+IHmEQ8w1c6W5W4fDQsU0nArOA4MbcNJLSwg7SGZjHM0afgA1GwW0LHyT1Xr8qLQzPF4q1qE6Q==
X-Received: by 2002:a05:6512:1189:b0:545:e2e:8425 with SMTP id 2adb3069b0e04-54c227dc7ecmr3981606e87.39.1744104418533;
        Tue, 08 Apr 2025 02:26:58 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e672e7csm1469926e87.256.2025.04.08.02.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:26:58 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 08 Apr 2025 11:26:58 +0200
Subject: [PATCH] net: ethernet: cortina: Use TOE/TSO on all TCP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-gemini-ethernet-tso-always-v1-1-e669f932359c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOHr9GcC/x3MTQqDMBAG0KvIrDsQY1rbXkVcBPuZDGgsmdAfx
 Ls3dPk2bydFFijdm50yXqKypYr21NAUfQpgeVSTNdaZi3EcsEoSRonICYWLbuyXt/8q33p7bq+
 +n6fOUQ2eGbN8/vkwHscPkHo9bGwAAAA=
X-Change-ID: 20240604-gemini-ethernet-tso-always-972518a7fc34
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

It is desireable to push the hardware accelerator to also
process non-segmented TCP frames: we pass the skb->len
to the "TOE/TSO" offloader and it will handle them.

Without this quirk the driver becomes unstable and lock
up and and crash.

I do not know exactly why, but it is probably due to the
TOE (TCP offload engine) feature that is coupled with the
segmentation feature - it is not possible to turn one
part off and not the other, either both TOE and TSO are
active, or neither of them.

Not having the TOE part active seems detrimental, as if
that hardware feature is not really supposed to be turned
off.

The datasheet says:

  "Based on packet parsing and TCP connection/NAT table
   lookup results, the NetEngine puts the packets
   belonging to the same TCP connection to the same queue
   for the software to process. The NetEngine puts
   incoming packets to the buffer or series of buffers
   for a jumbo packet. With this hardware acceleration,
   IP/TCP header parsing, checksum validation and
   connection lookup are offloaded from the software
   processing."

After numerous tests with the hardware locking up after
something between minutes and hours depending on load
using iperf3 I have concluded this is necessary to stabilize
the hardware.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 37 +++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 517a15904fb08536251616fc2ba9b4fca3da3592..6a2004bbe87f9362645845ea09aaf3f7b82d1f13 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1144,6 +1144,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	struct gmac_txdesc *txd;
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
+	bool tcp = false;
 	void *buffer;
 	u16 mss;
 	int ret;
@@ -1151,6 +1152,13 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	word1 = skb->len;
 	word3 = SOF_BIT;
 
+	/* Determine if we are doing TCP */
+	if (skb->protocol == htons(ETH_P_IP))
+		tcp = (ip_hdr(skb)->protocol == IPPROTO_TCP);
+	else
+		/* IPv6 */
+		tcp = (ipv6_hdr(skb)->nexthdr == IPPROTO_TCP);
+
 	mss = skb_shinfo(skb)->gso_size;
 	if (mss) {
 		/* This means we are dealing with TCP and skb->len is the
@@ -1163,8 +1171,26 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 			   mss, skb->len);
 		word1 |= TSS_MTU_ENABLE_BIT;
 		word3 |= mss;
+	} else if (tcp) {
+		/* Even if we are not using TSO, use the hardware offloader
+		 * for transferring the TCP frame: this hardware has partial
+		 * TCP awareness (called TOE - TCP Offload Engine) and will
+		 * according to the datasheet put packets belonging to the
+		 * same TCP connection in the same queue for the TOE/TSO
+		 * engine to process. The engine will deal with chopping
+		 * up frames that exceed ETH_DATA_LEN which the
+		 * checksumming engine cannot handle (see below) into
+		 * manageable chunks. It flawlessly deals with quite big
+		 * frames and frames containing custom DSA EtherTypes.
+		 */
+		mss = netdev->mtu + skb_tcp_all_headers(skb);
+		mss = min(mss, skb->len);
+		netdev_dbg(netdev, "TOE/TSO len %04x mtu %04x mss %04x\n",
+			   skb->len, netdev->mtu, mss);
+		word1 |= TSS_MTU_ENABLE_BIT;
+		word3 |= mss;
 	} else if (skb->len >= ETH_FRAME_LEN) {
-		/* Hardware offloaded checksumming isn't working on frames
+		/* Hardware offloaded checksumming isn't working on non-TCP frames
 		 * bigger than 1514 bytes. A hypothesis about this is that the
 		 * checksum buffer is only 1518 bytes, so when the frames get
 		 * bigger they get truncated, or the last few bytes get
@@ -1181,21 +1207,16 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	}
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		int tcp = 0;
-
 		/* We do not switch off the checksumming on non TCP/UDP
 		 * frames: as is shown from tests, the checksumming engine
 		 * is smart enough to see that a frame is not actually TCP
 		 * or UDP and then just pass it through without any changes
 		 * to the frame.
 		 */
-		if (skb->protocol == htons(ETH_P_IP)) {
+		if (skb->protocol == htons(ETH_P_IP))
 			word1 |= TSS_IP_CHKSUM_BIT;
-			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
-		} else { /* IPv6 */
+		else
 			word1 |= TSS_IPV6_ENABLE_BIT;
-			tcp = ipv6_hdr(skb)->nexthdr == IPPROTO_TCP;
-		}
 
 		word1 |= tcp ? TSS_TCP_CHKSUM_BIT : TSS_UDP_CHKSUM_BIT;
 	}

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20240604-gemini-ethernet-tso-always-972518a7fc34

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


