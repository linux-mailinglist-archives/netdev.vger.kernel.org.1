Return-Path: <netdev+bounces-235003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B8C2B146
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62E4A345A77
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB5C2FDC38;
	Mon,  3 Nov 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDlkzVJx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9FD2F2905
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166098; cv=none; b=nCYne3UOidNQafnltxSICKlm1QduKxTliyLF60AmIgvpkg+zrfcWuNiDZY/eXhOWqNXnHYCZwcMh3m0rHpXv6JQnb1nY4QXT6ES91xdCu0L0s4VJk0yGwlH4xOk+wSW2v7yzJf1xhnhGHMYQDbuV7FPsGqlr4nBrx891DHGtz9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166098; c=relaxed/simple;
	bh=Ft8He4N+FO47uHlyI7n7Nr8s7lJ6HHZ5zfSS7GFl5Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3mYIXx+Xyrm4XBoMk3C4WL+3/zlVkkgBoE73UVWKP0TFjxMajgsKG9fFsPR9MEMyWeAJZX06VftUCwWjD3zJl9xTk6ZIgGNw5U+W1+y6oRCTTToA30V75u0UCGCWipBhtTrKw7oAAVTo5FnyOohofrAki/xhkJlPO510eXrSRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDlkzVJx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762166096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SbZaztXA1hO9Yp9LrYlCGn/jaYNdHm/v2jNTTeEiFjM=;
	b=IDlkzVJxdWIGM5W75Wn/B/qRVKNYa8lZv17y7irQKmSPmCgoTQVZu7y9T3rKPyOp4cDtTd
	g+CKlAEoZKNo44ZzTbfsL0wLIcvqm6pAkx/4HGVB2iFvB7T04/I6wW3Z5t5CTnI7bNOqnJ
	U+7B6Q0cbdHUkOeEiaiRGa5xXCOaRHw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-ZUjYJ4Y_MxqO2zxBp17heg-1; Mon,
 03 Nov 2025 05:34:54 -0500
X-MC-Unique: ZUjYJ4Y_MxqO2zxBp17heg-1
X-Mimecast-MFC-AGG-ID: ZUjYJ4Y_MxqO2zxBp17heg_1762166093
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45CE81955F79;
	Mon,  3 Nov 2025 10:34:53 +0000 (UTC)
Received: from queeg (unknown [10.43.135.229])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9418D1955BE3;
	Mon,  3 Nov 2025 10:34:51 +0000 (UTC)
From: Miroslav Lichvar <mlichvar@redhat.com>
To: netdev@vger.kernel.org
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2] wireguard: queuing: preserve napi_id on decapsulation
Date: Mon,  3 Nov 2025 11:34:36 +0100
Message-ID: <20251103103442.180270-1-mlichvar@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The socket timestamping option SOF_TIMESTAMPING_OPT_PKTINFO needs the
skb napi_id in order to provide the index of the device that captured
the hardware receive timestamp. However, wireguard resets most of the
skb headers, including the napi_id, which prevents the timestamping
option from working as expected. The missing index prevents applications
that rely on it (e.g. chrony) from processing hardware receive
timestamps (unlike with transmit timestamps looped back to the error
queue, where the IP_PKTINFO index identifies the device that captured
the timestamp).

Preserve the napi_id in wg_reset_packet() of received packets in order
to make the timestamping option useful with wireguard tunnels and enable
highly accurate synchronization.

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---

Notes:
    v2:
    - don't copy napi_id if only CONFIG_XPS is defined
    - improve commit message

 drivers/net/wireguard/queueing.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 79b6d70de236..a5b76cecf429 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -75,6 +75,7 @@ static inline bool wg_check_packet_protocol(struct sk_buff *skb)
 
 static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
 {
+	unsigned int napi_id = skb_napi_id(skb);
 	u8 l4_hash = skb->l4_hash;
 	u8 sw_hash = skb->sw_hash;
 	u32 hash = skb->hash;
@@ -84,6 +85,10 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
 		skb->l4_hash = l4_hash;
 		skb->sw_hash = sw_hash;
 		skb->hash = hash;
+	} else {
+#ifdef CONFIG_NET_RX_BUSY_POLL
+		skb->napi_id = napi_id;
+#endif
 	}
 	skb->queue_mapping = 0;
 	skb->nohdr = 0;
-- 
2.51.0


