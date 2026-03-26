Return-Path: <netdev+bounces-272179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP4sIhNyxWkU+QQAu9opvQ
	(envelope-from <netdev+bounces-272179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:51:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D586E3397E5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 480F830E43B0
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647153A4F3D;
	Thu, 26 Mar 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XxvibRvn"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43BD39D6E6
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547193; cv=none; b=egr6ZjJbODULr5TgiKqvIhckdTtX1klA0uepgug5bPtMq/Xc7uQsCqhuGjfPjZZwuNlySIDgSSvAl+3CUMOOJ+pnHA5EvzW8hWJdWb9jroXZPxDZ28ZP7bOq/PdF9jCqz1+4dE6IEDom4oQkpuWIX2LFy4hicrghu0OWiK2eY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547193; c=relaxed/simple;
	bh=+vw2JkvCXKRoQRcER3jPQEIB++vTT0CoMaEKfyNHHnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWDYywfvcS5b3FgORTa+wKV+rRuz5dqx7+wCKXz1MOcR4CzKEOqdZJSmvzhB92psoQf0vUNh/afTis4LILzmID/b/cxlSMY/BCS/UGST1lirI7qAz1cgbxdse2nVerm639ozgXtDOfoevghbH9MJB6122NIIn1Y3UzZrSyij5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XxvibRvn; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774547187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCZCqssiuCqpmDoMVvWj4+RE/eoOZ2EbUqziqvm6HAE=;
	b=XxvibRvnJcKmbi0t2gTV4FaZBAa4E5sb/AllqGZBIqLWHaIqhll5jGnGEdoeWS7RdofD6o
	v7hmI8c616gGvMP/WZybPyCG8HmixmAzRV8N784ua9WpCfmH/xbh3/rapXeRCImbRKnW4T
	Ct1qGcEkAmlIzG04r5XG1d6Nik1BFcA=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v2 1/2] net: hsr: constify hsr_ops and prp_ops protocol operation structures
Date: Thu, 26 Mar 2026 18:45:59 +0100
Message-ID: <20260326174600.136232-2-luka.gejak@linux.dev>
In-Reply-To: <20260326174600.136232-1-luka.gejak@linux.dev>
References: <20260326174600.136232-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-272179-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D586E3397E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

The hsr_ops and prp_ops structures are assigned to hsr->proto_ops during
device initialization and are never modified at runtime. Declaring them
as const allows the compiler to place these structures in read-only
memory, which improves security by preventing accidental or malicious
modification of the function pointers they contain.

The proto_ops field in struct hsr_priv is also updated to a const
pointer to maintain type consistency.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_device.c | 4 ++--
 net/hsr/hsr_main.h   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5c3eca2235ce..90236028817d 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -616,7 +616,7 @@ static const struct device_type hsr_type = {
 	.name = "hsr",
 };
 
-static struct hsr_proto_ops hsr_ops = {
+static const struct hsr_proto_ops hsr_ops = {
 	.send_sv_frame = send_hsr_supervision_frame,
 	.create_tagged_frame = hsr_create_tagged_frame,
 	.get_untagged_frame = hsr_get_untagged_frame,
@@ -626,7 +626,7 @@ static struct hsr_proto_ops hsr_ops = {
 	.register_frame_out = hsr_register_frame_out,
 };
 
-static struct hsr_proto_ops prp_ops = {
+static const struct hsr_proto_ops prp_ops = {
 	.send_sv_frame = send_prp_supervision_frame,
 	.create_tagged_frame = prp_create_tagged_frame,
 	.get_untagged_frame = prp_get_untagged_frame,
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 33b0d2460c9b..134e4f3fff60 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -202,7 +202,7 @@ struct hsr_priv {
 	enum hsr_version prot_version;	/* Indicate if HSRv0, HSRv1 or PRPv1 */
 	spinlock_t seqnr_lock;	/* locking for sequence_nr */
 	spinlock_t list_lock;	/* locking for node list */
-	struct hsr_proto_ops	*proto_ops;
+	const struct hsr_proto_ops	*proto_ops;
 #define PRP_LAN_ID	0x5     /* 0x1010 for A and 0x1011 for B. Bit 0 is set
 				 * based on SLAVE_A or SLAVE_B
 				 */
-- 
2.53.0


