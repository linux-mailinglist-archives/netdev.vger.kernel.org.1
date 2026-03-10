Return-Path: <netdev+bounces-266281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHl8NapesGloigIAu9opvQ
	(envelope-from <netdev+bounces-266281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:10:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5124F2562FF
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 055CE308C0F7
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976413D9DA7;
	Tue, 10 Mar 2026 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jtn+gQ+G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698E3D812A
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166037; cv=none; b=mDid8fLujRgXl1UfayOUJcFOmOxvNMTNNxtPRyLG2kjbOh08L16WedGKw5gJHDb5vEVAEIG4Yc6VflY0XdV2F590apEh0r3RmHtm+OmQRjrYi5xdH/Yqk6XhsyTlLIk3O6KEmLChaENMsC1W/OHOcqoVHzb3zPt3IjHkAJCB5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166037; c=relaxed/simple;
	bh=DimZn8kYpq/S50h5bbNfR1Us61RIl6hOivpSGg0IMu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8PYZhdBNc8VC/nTht3gbXnJ/p7boiqF7yE2oydJgXoJXuSt87cFLiN+iz64DD0O2VFYtuRcLQL/sOy3ztrkZiS36u2SowJNGbgGBUtpV0u54zXtjXJ8NXVwOnYGGV/05X9tJvg46FZu8VDu1L0pGT7y8TN0JW89c96uxEZFf3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jtn+gQ+G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773166035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq0w5FChHatH/xQe95hLSx/OsUh0GkWPdmlsBA8Yx1E=;
	b=Jtn+gQ+G3/xOkYAQcMTnvTmLpOvXM7U8K5ZqISuCe9uflB0busR6SzN3WxbOCnB1tuZrts
	K4UZNXitfS6vS47X6O4kufWaFeogqZKDnCFourixRmyxNtci/8SfesYVJg4rFwQ4sHG8Sh
	ZmIfi0WeqQL4MJjvzQdDrtuzL0+igp8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-9XQ4eV49O-Okd2kSksBKJQ-1; Tue,
 10 Mar 2026 14:07:12 -0400
X-MC-Unique: 9XQ4eV49O-Okd2kSksBKJQ-1
X-Mimecast-MFC-AGG-ID: 9XQ4eV49O-Okd2kSksBKJQ_1773166031
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DBF4180034E;
	Tue, 10 Mar 2026 18:07:11 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.33.226])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EF261955D71;
	Tue, 10 Mar 2026 18:07:07 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 2/4] netdevsim: generalize taprio offload
Date: Tue, 10 Mar 2026 19:06:29 +0100
Message-ID: <52ae15a7e42d7754487bb744c1a1718246d032ef.1773165520.git.dcaratti@redhat.com>
In-Reply-To: <cover.1773165520.git.dcaratti@redhat.com>
References: <cover.1773165520.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 5124F2562FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266281-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Currently, netdevsim supports TC offloads only for filter blocks and the
'taprio' qdisc. This improves coverage for situations where

  .ndo_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, ...)

returns 0, but the code can be generalized for offloading most of the
Linux qdiscs we have at the moment. Generalize netdevsim qdisc offload,
by providing:
 - a function that returns 0 on 'setup'/'destroy'/'get_stats' commands
   read from qdisc-specific offload parameters, and returns -EOPNOTSUPP
   otherwise, namely "handle_<qdisc_name>()"
 - a case label handling TC_SETUP_QDISC_<qdisc_name> in nsim_setup_tc().

This commit has no functional change.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 drivers/net/netdevsim/tc.c | 57 ++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/net/netdevsim/tc.c b/drivers/net/netdevsim/tc.c
index 8a1960f5f99e..358fa5bb835f 100644
--- a/drivers/net/netdevsim/tc.c
+++ b/drivers/net/netdevsim/tc.c
@@ -11,32 +11,31 @@ nsim_setup_tc_block_cb(enum tc_setup_type type, void *type_data, void *cb_priv)
 	return nsim_bpf_setup_tc_block_cb(type, type_data, cb_priv);
 }
 
-static void nsim_taprio_stats(struct tc_taprio_qopt_stats *stats)
-{
-	stats->window_drops = 0;
-	stats->tx_overruns = 0;
-}
+static LIST_HEAD(nsim_block_cb_list);
 
-static int nsim_setup_tc_taprio(struct net_device *dev,
-				struct tc_taprio_qopt_offload *offload)
-{
-	int err = 0;
-
-	switch (offload->cmd) {
-	case TAPRIO_CMD_REPLACE:
-	case TAPRIO_CMD_DESTROY:
-		break;
-	case TAPRIO_CMD_STATS:
-		nsim_taprio_stats(&offload->stats);
-		break;
-	default:
-		err = -EOPNOTSUPP;
-	}
+#define QDISC_OFFLOAD_HANDLERS(X)					\
+	X(taprio, tc_taprio_qopt_offload, cmd, TAPRIO_CMD_REPLACE,	\
+	  TAPRIO_CMD_DESTROY, TAPRIO_CMD_STATS, stats)			\
 
-	return err;
+#define QH(NAME, OL_TYPE, CMD_FLD, O_REPLACE, O_DESTROY, O_STATS, STATS_FLD) \
+static int handle_##NAME(struct net_device *dev, struct OL_TYPE *offload) \
+{									\
+	switch (offload->CMD_FLD) {					\
+	case O_REPLACE:							\
+	case O_DESTROY:							\
+		/* Do nothing, accept offload */			\
+		return 0;						\
+	case O_STATS:							\
+		/* Zero out the requested stats block */		\
+		memset(&offload->STATS_FLD, 0, sizeof(offload->STATS_FLD)); \
+		return 0;						\
+	default:							\
+		return -EOPNOTSUPP;					\
+	}								\
 }
 
-static LIST_HEAD(nsim_block_cb_list);
+QDISC_OFFLOAD_HANDLERS(QH)
+#undef QH
 
 int
 nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
@@ -44,8 +43,18 @@ nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
 	struct netdevsim *ns = netdev_priv(dev);
 
 	switch (type) {
-	case TC_SETUP_QDISC_TAPRIO:
-		return nsim_setup_tc_taprio(dev, type_data);
+#define TC_QDISC_SETUP_CASES(X)						\
+	X(TC_SETUP_QDISC_TAPRIO, tc_taprio_qopt_offload, taprio)	\
+
+#define SC(SETUP_LABEL, OL_TYPE, NAME)					\
+	case SETUP_LABEL:						\
+	{								\
+		return handle_##NAME(dev, (struct OL_TYPE *)type_data); \
+	}
+
+	TC_QDISC_SETUP_CASES(SC)
+#undef SC
+
 	case TC_SETUP_BLOCK:
 		return flow_block_cb_setup_simple(type_data,
 						  &nsim_block_cb_list,
-- 
2.52.0


