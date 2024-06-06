Return-Path: <netdev+bounces-101540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E149A8FF537
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 21:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CFF283EEB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 19:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AE24D13F;
	Thu,  6 Jun 2024 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1yiDF4Wv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AB446DB
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717701726; cv=none; b=R3qzdqghMPSKWvHb3yIpb1WOffwa7pd4qPCqbpcn3BUHh8PebT7AsVoMR5kcVtHCYfV9ueTyLVgsHKV8NLiGJ9y+9btwKt4I8g0P+M4PmzFeiQn9tvhGRrSglSk9zes3WLKk70n4uzmyIoesrpBm8GnfbJbRfRPRMYGxHgO6J54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717701726; c=relaxed/simple;
	bh=gfQl4iN5p0vTLqnzXDdwviLUj4ZcpSShuq2uZnXjqpo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YiKLdCq+86EqBNYVhlsulV/V9dfkuL5mnh2qSr7eq/f5/gutvznMLetrx45numsD6YmYILHswzTC6+inigyo8QUKUsJEIlBUFzJ0lke9p311cB72Ks1TM6L5QYsgU/sXWdm5nxwHdFachaldH2XZ0si1IcKux3qgTB3HLvTw9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1yiDF4Wv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-702568e8086so994946b3a.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 12:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717701725; x=1718306525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2zlF4vUNG0tjOvsh4f17nUjCy+nmWVHulyjswEmhwgg=;
        b=1yiDF4WvRlIOb6fulJgBMMGr61hBKd5hyC9ShvEQQa6uQHXFactT7i8me5TOTidD5o
         ygNvoSjO53rHnrTpVH1fW6nTb0NsNd1V62DVe0PiLzMHW48OirOy4+4Yh1zktWGqCKq0
         0r10Zxvyeh4RbYaHZdnDtMSztYFYUIN2Ju+znoQ7qoMbFwbdo5jRwv34pccbirsOF7f3
         CPOI7d3cIBAWsIFPpalb6CBWO+Q9G6r1dMmuEhurrjgP1MxKSPa3bA++/LgcBU6LUZaz
         Y4raJalLXtess6OmqSs4ClbEaqcWv94v4LTivbmkf6mv02sJtzwMoVE2bVUwg9M0xE7m
         dY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717701725; x=1718306525;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zlF4vUNG0tjOvsh4f17nUjCy+nmWVHulyjswEmhwgg=;
        b=fUV5sFnNsBe913v21WAIQcEdEg4a2JX6QN5Mxqb/yf29i4aLeZZQaoDXG7BEfH5rdm
         PwlFbB2l4BkIq6LUekh4MiwjMNfS46b+121GGVxeHV4Usq+jJ7RAdLRFweVUdC2k8dhM
         33bRtpITvLngLIbieXp8fDnyJBiKGBEgMndWpnpMBl+dyBb10+WgQCN2AQYujBEpSxZe
         XThqlL/p0O0mQERJe5d9N7xWB5HSjkJSZTinSsqGt6PFDg0RKaqmDlcxyR6qePqVEhdX
         FxZNNNfpx81b3wGRVgRAfikyxqvA0cZoqg6vZFksAKiYvErmHO08lT/cEWY/3XjZQUk0
         BAPw==
X-Gm-Message-State: AOJu0Yy2a42J7TXc0X89iLn64dDvL6zpH/KmnnYBBWFEloCXEky0Yoja
	Ht/ewnuC51RMG8Y5/l2jXWUQWPBTJdEQ1s1ZH4URCMbKxiVI2xcKR2gd2tfLyuDUk3TDvte5iZS
	CQ1RxuXYeaALy4sPdLHOtQQS9sbbC/mu8wEM2U4Fus13xFZ2b1K/a4Mc1mm5lkDBzHCxLa8MKx7
	nnOmGNQDkVpTiJXHi2aTXs2rT7olyWtUbJCIotihqY1PU=
X-Google-Smtp-Source: AGHT+IGefI9HK2+XI32+s+pf/HmQ/QeEgQPPMDQL1Z77AQq1mpTS4/DnqJ3S4W35NTL3YDeTT7APZhqb7mO45g==
X-Received: from joshwash.sea.corp.google.com ([2620:15c:11c:202:a3cf:7d53:6a60:be07])
 (user=joshwash job=sendgmr) by 2002:aa7:8881:0:b0:702:1a16:bc59 with SMTP id
 d2e1a72fcca58-7040c677855mr1070b3a.2.1717701724347; Thu, 06 Jun 2024 12:22:04
 -0700 (PDT)
Date: Thu,  6 Jun 2024 12:21:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240606192139.1872461-1-joshwash@google.com>
Subject: [PATCH net] gve: ignore nonrelevant GSO type bits when processing TSO headers
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, stable@kernel.org, 
	Joshua Washington <joshwash@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Eric Dumazet <edumazet@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Rushil Gupta <rushilg@google.com>, Catherine Sullivan <csully@google.com>, Bailey Forrest <bcf@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

TSO currently fails when the skb's gso_type field has more than one bit
set.

TSO packets can be passed from userspace using PF_PACKET, TUNTAP and a
few others, using virtio_net_hdr (e.g., PACKET_VNET_HDR). This includes
virtualization, such as QEMU, a real use-case.

The gso_type and gso_size fields as passed from userspace in
virtio_net_hdr are not trusted blindly by the kernel. It adds gso_type
|= SKB_GSO_DODGY to force the packet to enter the software GSO stack
for verification.

This issue might similarly come up when the CWR bit is set in the TCP
header for congestion control, causing the SKB_GSO_TCP_ECN gso_type bit
to be set.

Fixes: a57e5de476be ("gve: DQO: Add TX path")

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index fe1b26a4d736..04cb43a97c96 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -555,6 +555,10 @@ static int gve_prep_tso(struct sk_buff *skb)
 	if (unlikely(skb_shinfo(skb)->gso_size < GVE_TX_MIN_TSO_MSS_DQO))
 		return -1;
 
+	/* We only deal with TCP at this point. */
+	if (!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)))
+		return -EINVAL;
+
 	/* Needed because we will modify header. */
 	err = skb_cow_head(skb, 0);
 	if (err < 0)
@@ -565,18 +569,10 @@ static int gve_prep_tso(struct sk_buff *skb)
 	/* Remove payload length from checksum. */
 	paylen = skb->len - skb_transport_offset(skb);
 
-	switch (skb_shinfo(skb)->gso_type) {
-	case SKB_GSO_TCPV4:
-	case SKB_GSO_TCPV6:
-		csum_replace_by_diff(&tcp->check,
-				     (__force __wsum)htonl(paylen));
+	csum_replace_by_diff(&tcp->check, (__force __wsum)htonl(paylen));
 
-		/* Compute length of segmentation header. */
-		header_len = skb_tcp_all_headers(skb);
-		break;
-	default:
-		return -EINVAL;
-	}
+	/* Compute length of segmentation header. */
+	header_len = skb_tcp_all_headers(skb);
 
 	if (unlikely(header_len > GVE_TX_MAX_HDR_SIZE_DQO))
 		return -EINVAL;
-- 
2.45.1.288.g0e0cd299f1-goog


