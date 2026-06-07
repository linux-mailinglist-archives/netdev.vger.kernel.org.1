Return-Path: <netdev+bounces-296173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NWl+DpHXJGqJAgIAu9opvQ
	(envelope-from <netdev+bounces-296173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 04:29:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FABB64EB17
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 04:29:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openai.com header.s=google header.b=OshPRVmk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296173-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296173-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=openai.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 348583017026
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 02:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB0223ED6F;
	Sun,  7 Jun 2026 02:29:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907C1DFF0
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 02:29:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780799374; cv=none; b=czw5xpoB/Hdf41rjcKw9Hp5b8D/LvRlWZa4+UJf+a21lK7E5LU39U24mGyzGwABH2+9HRxmGdV+oJKRgo6MVk5Q5y4ELzVGNR7LYIYyO0NYQsew10VF9u18fJ/5EtMYYgbxnei9WVcbusBM6SpxH4MZXF5bcsVYtv2KwilPGVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780799374; c=relaxed/simple;
	bh=KFttDkOliwmcP5f1eeHeMTTOB1TRDM1UIzNlFvpHUPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DdhT+xgk7uX7xQRkFkB04AuOzJudolFDy3gc9HidM8k9zYJW/fcEbXg6oIlN1q1fSV/9csdBTuhTaCm4DAMO9txu8zPPl9/BMbAmihMcD9bcfZB/ZH2hSb8ROynwJ+mrT9jes1V0PzdpBgDKTsoav3gw2RAU483fuo0kI++JOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=OshPRVmk; arc=none smtp.client-ip=74.125.82.169
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3045c195251so2841797eec.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 19:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1780799372; x=1781404172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PoxGSzb5xtE4/aEsKv2bqeRMWeH9RXRvVT6vJPuOv3Q=;
        b=OshPRVmkH4wfGT3as5ZEX7a4n9UEi2gYmUzoL7xJ9EauDFvAtG1Iqfz40+g4hqjOgQ
         tV7jAPiUxsYwPmdG+AAt2CQF3Qa3mq+dh//ImVLZ/kQhqXZjtM3kfQOHy36BQEmmhVR0
         7ymR+afFQUbsChc8kQk5iIRV31UO+xfck4YQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780799372; x=1781404172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoxGSzb5xtE4/aEsKv2bqeRMWeH9RXRvVT6vJPuOv3Q=;
        b=c5GmMn9OUI2go8E5E9kS8qnq4PrmXxJlTz/KILGCcc8FihYZplqZWxXXH4XYdABnPl
         L1pcbXK+BRVwQ9oSt1ixr61nBy4NCa+XSrApFIJm29INRqm1vCqUTitmi4XXnMb0YMda
         +46az8wS+rXWkbT2MV34MUUs5dREdUpu4iOvGPvbS9O1fNFjTjlJXd/oG+gs46BBbaRi
         KJpualYGxNgMxZrI2UvV+W8TM/i/d4X1HgGdsSc10GwaOuscElStdAS5bCLJFkvlEXDk
         fkJI+dlCp5LWMChnvjgs29OPj2Lf6KokGZ6ohHfCEbAJGSrtzQ6aHtNGVj7cmSB2bgfD
         IbGw==
X-Gm-Message-State: AOJu0YzFQV0OIABsBU8ImOGI8zkj32ks2xHYgQi6shmj//+PpgGfD1tv
	eLrA483wDq3xaJ7gX419OahE8n6KCV+fQytKzEqTxxHQdz+vbPxt7yr3CXI6c0TT/WxE5zIv4B1
	bjm5FMm8=
X-Gm-Gg: Acq92OHqmwh8o8i79VUs4knFdsYWU5C2UfGzOwUJZBJqe+xv8UnqI2Ba4zYCP0Xn+jo
	UnvLuZpbXuiEgQQhnl3MRIB0JjmZK+YGhxQzMMUYV9cPSytNCIJDwFJRrgSHp/i6CN43H/ZLhJv
	9pKgVjaz4CUeDq2lX4ur5iUwwpE9iyb9ZrpF7hHq1rfiTC85Ti9dovl+NjPCUz+I5VzJabxI0+8
	JnLjFbAKNx6J4fz8keut0li9UuG5N3a+cr0iyIj1fppd4tbzZlI4rZz/2qIPRc5Cmf0gCWedvDR
	t6MuHg0FrQpBpmYGvVRrzZ1QzOU0fG1npKtoqhB30U+/409031pdvHCEO/829Nb77FhzI7En7/9
	dtl8sraV4r6j4oIRYVxv4d5d5GqpoOLQZ6osceymVRWYdntAwXysusCbXz4bQZI7n1MPhexFhdq
	U8DO2ScaquQ2RoFwJqLn5LQZFobbPt9jFHPgZZzgS1hZGtbySEqDAsXfCy4ijUiMzg5tkGiRBon
	MKYIyCwnqESV54q3MFLAxNoGOeIlExe41xNDWAV19Ga
X-Received: by 2002:a05:693c:2288:b0:304:df8b:71ee with SMTP id 5a478bee46e88-3077af31664mr5621039eec.7.1780799372257;
        Sat, 06 Jun 2026 19:29:32 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([104.241.0.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm17690506eec.5.2026.06.06.19.29.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Jun 2026 19:29:32 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: uniyuki Iwashima <kuniyu@google.com>,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net] net: guard timestamp cmsgs to real error queue skbs
Date: Sat,  6 Jun 2026 19:18:19 -0700
Message-ID: <20260607021819.49698-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296173-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuniyu@google.com,m:kylebot@openai.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kylebot@openai.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[openai.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kylebot@openai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,openai.com:mid,openai.com:dkim,openai.com:from_mime,openai.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FABB64EB17

skb_is_err_queue() treats PACKET_OUTGOING as the sole marker for an skb
from sk_error_queue. That assumption is not true for AF_PACKET sockets:
outgoing packet taps are also delivered to packet sockets with
skb->pkt_type == PACKET_OUTGOING, but their skb->cb is owned by AF_PACKET
instead of struct sock_exterr_skb.

If such an skb is received with timestamping enabled, the generic
timestamp cmsg path can read AF_PACKET control-buffer state as
sock_exterr_skb::opt_stats. With SO_RXQ_OVFL enabled, the packet drop
counter overlaps opt_stats. An odd drop count makes the path emit
SCM_TIMESTAMPING_OPT_STATS with skb->len and skb->data. For non-linear
skbs this copies past the linear head and can trigger hardened usercopy or
disclose adjacent heap contents.

Keep skb_is_err_queue() local to net/socket.c, but make it verify that
the PACKET_OUTGOING marker is paired with the sock_rmem_free destructor
installed by sock_queue_err_skb(). AF_PACKET receive skbs use normal
receive ownership and no longer pass as error-queue skbs, while legitimate
sk_error_queue entries keep the PACKET_OUTGOING marker and sock_rmem_free
ownership.

Fixes: 8605330aac5a ("tcp: fix SCM_TIMESTAMPING_OPT_STATS for normal skbs")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 include/net/sock.h   |  1 +
 net/core/skbuff.c    |  6 +++---
 net/socket.c         | 11 ++++++-----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index dccd3738c368..95e157eee8d9 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1856,6 +1856,7 @@ struct sk_buff *sock_omalloc(struct sock *sk, unsigned long size,
 			     gfp_t priority);
 void skb_orphan_partial(struct sk_buff *skb);
 void sock_rfree(struct sk_buff *skb);
+void sock_rmem_free(struct sk_buff *skb);
 void sock_efree(struct sk_buff *skb);
 #ifdef CONFIG_INET
 void sock_edemux(struct sk_buff *skb);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c02f0a507ba8..8eab8eb5006a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5450,7 +5450,7 @@ int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trailer)
 }
 EXPORT_SYMBOL_GPL(skb_cow_data);
 
-static void sock_rmem_free(struct sk_buff *skb)
+void sock_rmem_free(struct sk_buff *skb)
 {
 	struct sock *sk = skb->sk;
 
@@ -5459,8 +5459,8 @@ static void sock_rmem_free(struct sk_buff *skb)
 
 static void skb_set_err_queue(struct sk_buff *skb)
 {
-	/* pkt_type of skbs received on local sockets is never PACKET_OUTGOING.
-	 * So, it is safe to (mis)use it to mark skbs on the error queue.
+	/* The error-queue test in skb_is_err_queue() matches this marker
+	 * with the sock_rmem_free destructor installed by sock_queue_err_skb().
 	 */
 	skb->pkt_type = PACKET_OUTGOING;
 	BUILD_BUG_ON(PACKET_OUTGOING == 0);
diff --git a/net/socket.c b/net/socket.c
index 22a412fdec07..c2698a1441a7 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -852,12 +852,13 @@ EXPORT_SYMBOL(kernel_sendmsg);
 
 static bool skb_is_err_queue(const struct sk_buff *skb)
 {
-	/* pkt_type of skbs enqueued on the error queue are set to
-	 * PACKET_OUTGOING in skb_set_err_queue(). This is only safe to do
-	 * in recvmsg, since skbs received on a local socket will never
-	 * have a pkt_type of PACKET_OUTGOING.
+	/* Error-queue skbs are marked as PACKET_OUTGOING in
+	 * skb_set_err_queue() and use the destructor installed by
+	 * sock_queue_err_skb(). PACKET_OUTGOING alone is not unique:
+	 * AF_PACKET outgoing taps use the same pkt_type.
 	 */
-	return skb->pkt_type == PACKET_OUTGOING;
+	return skb->pkt_type == PACKET_OUTGOING &&
+	       skb->destructor == sock_rmem_free;
 }
 
 /* On transmit, software and hardware timestamps are returned independently.
-- 
2.43.0

