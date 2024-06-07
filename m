Return-Path: <netdev+bounces-101658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141438FFBE2
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC3B1C243DF
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 06:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA7414F9C9;
	Fri,  7 Jun 2024 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9MzvXSY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85AD14F13C
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717740619; cv=none; b=RtVGAh/7Eu/NzpYh+usVlZE0wbXDn0Iou9ORWgMK8mHVQiVn8r7CfDl6ySqgPvtz8usu/3NcvJIBdDzGZRym5GeVRuRWBy0xNo0UmVmHIW3nqNV63Lf3FrVfvSnkmP5XIJIsGyEeuyHGme7CEEVgx84ay7NDKptG5sbkvPoqGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717740619; c=relaxed/simple;
	bh=+yNnUVafWEFHM6Vfhx3c/ikYL4GjYaVR1FLvegx+GN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iuXWj9fbnM0nlhk9Pw5BtbWs8C/JWRAgPA0AVHadckGUpHzdsZ0S5sOScTgL0i+ZbHz5J3S/8os7QYGnsQfarZJuEvL4CaPLUwUDTmuy4gX0DJqvq8y/F7c6lVZ+tD+50DRTWFbsZZ67cdYEfNBSN1KVQtsowbwflWI9fDfVPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9MzvXSY; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-667fd2bf4feso1596572a12.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 23:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717740617; x=1718345417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IaxqkxoUHKrRAhQLcm0mCsfS9ca+q5nOq+ZwxnZnJs=;
        b=R9MzvXSYGb3XeaVN1xdzz+MCDkgUmbY4+HIIo/RQfvh7ymY3hI+0Z/HXAR/2BppW+U
         5vI+yoeRoK8jDlaigB87oZHfX38N7xfAM3I94o9yymeRjXPWq+TVF+6q+JB7GRT/VdNw
         3XXrAZj6aAAJ1KpI3mRgk6PWeNQpA5jw21l9xPXY9cFhhC+0fZvEJYH5K1UYiQfxP193
         uZZYdQM86gCONXjwMBdSiDOm/HT8z8bcss86ECIulVjcTo40v5Y8ybZCYPc92hxtGZ1T
         WLE7y4aNRcVi3wasyo9VcGrgIXEGTLWtvrA9mps+tOMSeWAMJeemcgu3UlbI/fkRn221
         eJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717740617; x=1718345417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IaxqkxoUHKrRAhQLcm0mCsfS9ca+q5nOq+ZwxnZnJs=;
        b=nA158lfKxwKF2Md5SlFNGCu9S9UC4wQY4O5+fRGn5PZ7Nqk/0fojgZ8S8fLmB4OLA5
         VbtkCOSQPMg5SBpLefqJeZ8D9FkKsmxPXNIv5fqd9679gs/3NVyFzx2D6OryenGF9Xtn
         DSqqalxiJxvxRgdCeXHmomTNR7N8Oq+rceaCTSJPLqCpCRklWT5/aQKVNB5eyO+WfCSj
         TpTBVdzB9bnjcCCjren7Uwpy8kmNnCWabc0nlB2Xo9VJe+UKMtjaC0aFZnQ3enCsoSql
         Ut8a0v3gMfvqMRs4u0Ixlx8LztNiD8MHiyN7Moq0NLZz3OYZGXlUxd7Jdr7PZGFdcE/H
         BO8Q==
X-Gm-Message-State: AOJu0Yw9mrDWxFXSU2/BJ8uPeYezhtrGT3HcDVRmeWy6a3/1bMyNxBtm
	k1VBWa3XUrssRivYJXVz9C/xhuBWvisKv4DqpMYBD/aJz4w7MV6VP8zFd0q3m9OeSvjsPwS0AoD
	pssvC65CTbQRNKyVNzrgrIKls/uuvMGN2/iZbV3oUzsHjHCPSFAU56jzYAWLQcfcVyEw/ZOgv7x
	VuYxYV15BfLxTMTwJOHMjkTc7NYhu62B1l9BVvFr6Zi5Y=
X-Google-Smtp-Source: AGHT+IF0A60X0eGYChsWehMsLUt65JdkRv2Yk1dsUtkseIs2rFVb0B3papVQSfoUqB4VpiwZFIWs5WPQpoeOtg==
X-Received: from joshwash.sea.corp.google.com ([2620:15c:11c:202:a3cf:7d53:6a60:be07])
 (user=joshwash job=sendgmr) by 2002:a17:902:d488:b0:1f6:13fd:2473 with SMTP
 id d9443c01a7336-1f6d02fc466mr1480655ad.10.1717740616671; Thu, 06 Jun 2024
 23:10:16 -0700 (PDT)
Date: Thu,  6 Jun 2024 23:09:47 -0700
In-Reply-To: <20240606192139.1872461-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240606192139.1872461-1-joshwash@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607060958.2789886-1-joshwash@google.com>
Subject: [PATCH net v2] gve: ignore nonrelevant GSO type bits when processing
 TSO headers
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, stable@kernel.org, 
	Joshua Washington <joshwash@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@google.com>, Andrei Vagin <avagin@gmail.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rushil Gupta <rushilg@google.com>, Bailey Forrest <bcf@google.com>, 
	Catherine Sullivan <csully@google.com>, open list <linux-kernel@vger.kernel.org>
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
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 21 +++++---------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index fe1b26a4d736..a76b407a981b 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -551,32 +551,21 @@ static int gve_prep_tso(struct sk_buff *skb)
 	 * - Hypervisor enforces a limit of 9K MTU
 	 * - Kernel will not produce a TSO larger than 64k
 	 */
-
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


