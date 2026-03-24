Return-Path: <netdev+bounces-271107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMMPIOykwmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:51:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D9C30A7C2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16DF0303B7BD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724BA3FF8B1;
	Tue, 24 Mar 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LzZiI3Ea"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02D7388385
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363619; cv=none; b=o6LO2/nT2YVy7neRiScl5mM67ULNo8xyHDUWdcWbYiq53VJO3oDEYXR803FWCzPyJsr2YFEnoGJ3fEO9bn5ibeLvQYO5nYjRLo/3ehUSi1v/5Ik5IM8vlMhrFNPhLnqtjLMnBuRsht+7UQXoU5nZprOUvgkiIXqdgXgi3Ax2hCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363619; c=relaxed/simple;
	bh=+vw2JkvCXKRoQRcER3jPQEIB++vTT0CoMaEKfyNHHnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/hhwh7uTzIn2A/uDQ2acxxl0ieGJ9NLODGnXky7vYAonUTNCpYV/duEtT64E7FmlH1z6HtGGybP+Qbye1VszEUTJoSnw88/7pFsayGUweYna7kSN/JVpYJ7L4z2aJtslK4oyg+k9R/M5MEqFkMinJuh94CmTfOGIoTQCiDsSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LzZiI3Ea; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774363614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCZCqssiuCqpmDoMVvWj4+RE/eoOZ2EbUqziqvm6HAE=;
	b=LzZiI3EaV3xqq8q2cS9KbpOrXyVJPdlw6PFnemCb943VNufnok1Vu1LyHe0hZxrfDepRON
	wSifnPrhgC8LuV17KcCqVSh3cQdN5C7Ua2Pp7KdEFgLSROMCscYZmOtT+ehb8gibbvhAL7
	/cSQR3R+mWvcYU5F8nL3wsO6b7BjfUY=
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
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 1/7] net: hsr: constify hsr_ops and prp_ops protocol operation structures
Date: Tue, 24 Mar 2026 15:46:24 +0100
Message-ID: <20260324144630.189094-2-luka.gejak@linux.dev>
In-Reply-To: <20260324144630.189094-1-luka.gejak@linux.dev>
References: <20260324144630.189094-1-luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271107-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22D9C30A7C2
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


