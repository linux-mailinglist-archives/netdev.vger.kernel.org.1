Return-Path: <netdev+bounces-102383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52511902C26
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AAAB21D89
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F760152176;
	Mon, 10 Jun 2024 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3E7w0o0a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B290F1527A2
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060261; cv=none; b=OVvBn51vN+huIHHPnDWtrgJfFKKbb9/7Bpv1jOIcPjZ3T0VgbYY9D388Kr9AhW28dGSARybI9NXXTLeFY4/erMgr+mkqdKkBE4i+JKwaNdWmgJ98UalK8s/YTR8r3Km1I9i64hzFWv4Nd/xKIn5diLXxetua3P4Eei+THWTyJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060261; c=relaxed/simple;
	bh=qT2UzxMxj27QF/RZZE1Vit0ZbGo8Ka2+OgpxCUL/9GY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sU3x4n07tL8CdO3q2ODz3aXu9HrWGUIw3p6s6dKtgqb34oPw41TydtKZtAerSWaHDFtKvQqhC0cpPQjXHz+UpGrC+K/pPCX8Oi20buMxWqBYUjKgoY9ul5hz4Bv+Zl2jovv5uSgmkRp8V9yv99PUhCBwaI1vwli0UccXefDDK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3E7w0o0a; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7041c30c0b4so2711837b3a.2
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718060259; x=1718665059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZbfKxx3z/c0BgKgu/7amabvTQUwHCZ/pP82fEJMD0M=;
        b=3E7w0o0arfzLr1szJTMkzdbCUPQRI7WAzm4JXUT7OFrD80fl8su0hSpsnosE/gR+1B
         1/K7qii91ca2uArDLZNLsytPB1Y1tGwl5hnk0UCm+N1Ni3RFWF1O8MTtIXkxJTRVUfAH
         jUSuNuB2+AiyHso46H/Ba4fJoh4lnUZ7a0cJF7tNshBKB3ecl5jDHx+MurW1P8BNlCVt
         eGsL2I2Mk+Os6MbfqHrlrHl9OVD/EGb7Kzs2vnrEq9KRACeS38LYpJugHAcLzB7MHHcL
         x8fqUvC6ydxdEUBm0FdGLAuSKeeqBlafj1P5lGM1k1d54QUdSQBTwi7NzI6z92y2Oq7+
         9BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060259; x=1718665059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZbfKxx3z/c0BgKgu/7amabvTQUwHCZ/pP82fEJMD0M=;
        b=BSsAs6b4Afh93TZp7fxzgmIreeSfWkEdMJnzu0wRoci6zD46N250RHBp6hrk+Xzj3l
         14/mGRL6GRsI2uFMwu/4NFSHa9Q/yvLU7L3iqrGlydI1/CuFNW8WWTirSSz745Hh5HQI
         F4hKw34aCg8Ug+aeiSeLFbK+a75WQl44bXuMPKrZISyOVBwuzQgZ84zhoZ8fHBMc+jzY
         yJy5rGJOiHj6Fl1dbYZUSWf2K6ODl/h16Z9PIo9LRSncRhbEZeuy5EubwCcyt/tIl/1o
         1KjLmNs1pdKJjD/2pXMBE7fzcnk7jJm2ColtCpwLo9UiXALxqESI8jGq4nk6/4GJj4KK
         E7Mg==
X-Gm-Message-State: AOJu0YwMVaskPn0Xupj+BmmOUr5vbudEM1hsFb9GORkSFC0xwscJ9dUE
	4fLNoLViVZYGK5toWQjpy7qTEMbuMEq1E+vR75ZaHhvUHg+EEIcopqTO1SmkVISh8PoQiDYQtOE
	l7RxMUDrhxbsWUrY1e6OwP23o3DGtBWGvSyKDXaHWE5j5EZyxnUZE97OGSdipcmAhjSAeP1EL1B
	eMBbKqywmXbx+RlLAy+HHzqsGItA4byAZmWmieW0CWqUg=
X-Google-Smtp-Source: AGHT+IHxXPGcBQ8hDEwrw30irOlMrDH6SW5biFLz1h0dUC+fvkh9hNUsBuSSX4W/y8WlbY9mIjgZG5a5DpjHVw==
X-Received: from joshwash.sea.corp.google.com ([2620:15c:11c:202:b54a:8bd9:9bf9:ca9f])
 (user=joshwash job=sendgmr) by 2002:a05:6a00:1a86:b0:6ec:f5b8:58cc with SMTP
 id d2e1a72fcca58-7040c885704mr108018b3a.6.1718060256242; Mon, 10 Jun 2024
 15:57:36 -0700 (PDT)
Date: Mon, 10 Jun 2024 15:57:18 -0700
In-Reply-To: <20240607060958.2789886-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240607060958.2789886-1-joshwash@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240610225729.2985343-1-joshwash@google.com>
Subject: [PATCH net v3] gve: ignore nonrelevant GSO type bits when processing
 TSO headers
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, stable@kernel.org, 
	Joshua Washington <joshwash@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@google.com>, Andrei Vagin <avagin@gmail.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rushil Gupta <rushilg@google.com>, 
	Catherine Sullivan <csully@google.com>, Bailey Forrest <bcf@google.com>, 
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Acked-by: Andrei Vagin <avagin@gmail.com>

v2 - Remove unnecessary comments, remove line break between fixes tag
and signoffs.

v3 - Add back unrelated empty line removal.
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index fe1b26a4d736..0b3cca3fc792 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -555,28 +555,18 @@ static int gve_prep_tso(struct sk_buff *skb)
 	if (unlikely(skb_shinfo(skb)->gso_size < GVE_TX_MIN_TSO_MSS_DQO))
 		return -1;
 
+	if (!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)))
+		return -EINVAL;
+
 	/* Needed because we will modify header. */
 	err = skb_cow_head(skb, 0);
 	if (err < 0)
 		return err;
 
 	tcp = tcp_hdr(skb);
-
-	/* Remove payload length from checksum. */
 	paylen = skb->len - skb_transport_offset(skb);
-
-	switch (skb_shinfo(skb)->gso_type) {
-	case SKB_GSO_TCPV4:
-	case SKB_GSO_TCPV6:
-		csum_replace_by_diff(&tcp->check,
-				     (__force __wsum)htonl(paylen));
-
-		/* Compute length of segmentation header. */
-		header_len = skb_tcp_all_headers(skb);
-		break;
-	default:
-		return -EINVAL;
-	}
+	csum_replace_by_diff(&tcp->check, (__force __wsum)htonl(paylen));
+	header_len = skb_tcp_all_headers(skb);
 
 	if (unlikely(header_len > GVE_TX_MAX_HDR_SIZE_DQO))
 		return -EINVAL;
-- 
2.45.2.505.gda0bf45e8d-goog


