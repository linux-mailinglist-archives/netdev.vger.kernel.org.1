Return-Path: <netdev+bounces-234355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E7BC1FA22
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2792D189263B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B11B2F6912;
	Thu, 30 Oct 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+iA9jcF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA41EF39E
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821326; cv=none; b=p8x8docglG5Iu1OtuEfI/65FSSTJidJXtXUgvBY97kmpOiF0CU6vypppAKq1CHekuRF2RaMP7lJpw1yrqfohSlTZOhNMk0odij8UIuamc+b1kp5TkQvU3OAxrnquwDx+ClDy2VEK6EVENK10qfGJK7wYATah9LsiSSnGBrjmDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821326; c=relaxed/simple;
	bh=YHcuPDlm+qkQ5QgfKKJQYA5ddh8XM07lgZKov2I3JT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1PhN12wNYEjoQCY9lRuFK4HFwoLuy/bu2vI8ZlY3hTBnrV1qyE6oteC42I7pX+PcIB/QBnOBHPwp5P59uLMApSDxWwLZVhA4gYr2eM8MvSH5HDHN4YwOX2ofm0sI1J03OU8FGM/8fq33Hd+QsqMR6BAxcXFNfRta+uFhAIG6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+iA9jcF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761821323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8TkuSmqxcerff7GAdgQsfxTUqjLkeyccfdkjHp82P3g=;
	b=R+iA9jcFqvBYj0rR6USjIf5V7ZSowD4rjEM4pcUwi52RJQNoV7VUm2pJdeboqCVI07SIAU
	FElCEiYgDNJ1kwNYWy5AwUvuQlHVx6eqB3mHrn2blp3CwvGZqqgGF9vQGurRzvyW8kEgy3
	MHaRO47zOlvWS+VF6eJcrNT3cK06TGg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-3wqD_S4DMX-J6D2b15eN1g-1; Thu,
 30 Oct 2025 06:48:35 -0400
X-MC-Unique: 3wqD_S4DMX-J6D2b15eN1g-1
X-Mimecast-MFC-AGG-ID: 3wqD_S4DMX-J6D2b15eN1g_1761821314
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EE59195606D;
	Thu, 30 Oct 2025 10:48:34 +0000 (UTC)
Received: from queeg (unknown [10.43.135.229])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7BC419560B7;
	Thu, 30 Oct 2025 10:48:32 +0000 (UTC)
From: Miroslav Lichvar <mlichvar@redhat.com>
To: netdev@vger.kernel.org
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next] wireguard: queuing: preserve napi_id on decapsulation
Date: Thu, 30 Oct 2025 11:48:20 +0100
Message-ID: <20251030104828.4192906-1-mlichvar@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The socket timestamping option SOF_TIMESTAMPING_OPT_PKTINFO needs the
skb napi_id in order to provide the index of the device that captured
the receive hardware timestamp. However, wireguard resets most of the
skb headers, including the napi_id, which prevents the timestamping
option from working as expected and applications that rely on it (e.g.
chrony) from using the captured timestamps.

Preserve the napi_id in wg_reset_packet() on decapsulation in order to
make the timestamping option useful with wireguard tunnels and enable
highly-accurate synchronization.

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---

Notes:
    This is a minimal change that fixes the described problem for me, but
    I don't really understand the code well enough to see if there are any
    major side effects. If there is a better way to fix the option for wg or
    tunnels in general, please let me know.

 drivers/net/wireguard/queueing.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 79b6d70de236..bcf03bc01992 100644
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
+#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
+		skb->napi_id = napi_id;
+#endif
 	}
 	skb->queue_mapping = 0;
 	skb->nohdr = 0;
-- 
2.51.0


