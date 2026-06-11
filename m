Return-Path: <netdev+bounces-297938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SWmfF/NAKmoElQMAu9opvQ
	(envelope-from <netdev+bounces-297938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:00:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC6D66E57F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:00:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gn+mUm3+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297938-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297938-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE2673032394
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AD814BF92;
	Thu, 11 Jun 2026 04:59:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B525A2DD
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:58:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153945; cv=none; b=nShOAmHMFgf2TjvTfzK6gs4g1WMQN63yoEze8tYGSck70TllRkXw/EpFdoooKVNU2lH7o4fkAAc/3cImiP0vbEQnRckoJDB6fvTFpqaLlXVgTBr954seX9AgYhl4Q/TpT/5Whefc5vnasXvaaGR/xqwY4KZZSfXlZvW/wX8s+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153945; c=relaxed/simple;
	bh=yo1afvVmJXhwRtCKt4rp/Tj+A4HZuR63jFlYCx8nLaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AP3TfOGdKonqlMkKeOtWSRkSk+x29Uw/i/ch6qzyrjQgCCqtTS4LeDf2+tu4I2wphRS9Tv1jiOJMYEXBAW65O96TJ6FaBUsJeBNs97ZU3oBfuor3XRVMNnKYgFb+nc35vIvrVK/ERU3cZQ1W2xbm38FWjRgcSfrPfSo5QbBJp14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gn+mUm3+; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781153932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLlLNyDRv/MVvWl2UYXQzgKhX1qIbcE52tpVygoA9K4=;
	b=gn+mUm3+wPhwL6DVTywiyW5NVpgjXD2wTxIdIOFTDE/d/Cs8Vf7kYNSkjP/vGFX4JdXoll
	q2hK68Prkjn53q111d/fxAEQ+WMOAt6/upO6FuTkyhmbnQNr2fS4mwPFFf2yJho0//nvaH
	DaLzmiQUn/9rrCr8C73mulQVXEX0bQc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-nZunKb_hOJa8w_4c7qMmSg-1; Thu,
 11 Jun 2026 00:58:47 -0400
X-MC-Unique: nZunKb_hOJa8w_4c7qMmSg-1
X-Mimecast-MFC-AGG-ID: nZunKb_hOJa8w_4c7qMmSg_1781153926
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B2821800586;
	Thu, 11 Jun 2026 04:58:46 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.44.48.149])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FED419541B0;
	Thu, 11 Jun 2026 04:58:41 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	pabeni@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org (open list:OPENVSWITCH),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 4/4] net: openvswitch: avoid double-rcu wait period
Date: Thu, 11 Jun 2026 06:58:11 +0200
Message-ID: <20260611045817.1302665-5-amorenoz@redhat.com>
In-Reply-To: <20260611045817.1302665-1-amorenoz@redhat.com>
References: <20260611045817.1302665-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297938-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:aconole@redhat.com,m:pabeni@redhat.com,m:amorenoz@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:dev@openvswitch.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEC6D66E57F

Avoid waiting for two rcu periods by scheduling the deletion of the
flow_table and all of its referenced structs at the same time.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/flow_table.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 3934873a44c3..35232e1af8aa 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -527,30 +527,33 @@ static void table_instance_destroy(struct table_instance *ti,
 	call_rcu(&ufid_ti->rcu, flow_tbl_destroy_rcu_cb);
 }
 
-/* No need for locking this function is called from RCU callback. */
 static void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
 {
 	struct flow_table *table = container_of(rcu, struct flow_table, rcu);
 
-	struct table_instance *ti = rcu_dereference_raw(table->ti);
-	struct table_instance *ufid_ti = rcu_dereference_raw(table->ufid_ti);
-	struct mask_cache *mc = rcu_dereference_raw(table->mask_cache);
-	struct mask_array *ma = rcu_dereference_raw(table->mask_array);
-
-	call_rcu(&mc->rcu, mask_cache_rcu_cb);
-	call_rcu(&ma->rcu, mask_array_rcu_cb);
-	table_instance_destroy(ti, ufid_ti);
 	mutex_destroy(&table->lock);
 	kfree(table);
 }
 
 void ovs_flow_tbl_put(struct flow_table *table)
 {
+	struct table_instance *ufid_ti;
+	struct table_instance *ti;
+	struct mask_cache *mc;
+	struct mask_array *ma;
+
 	if (refcount_dec_and_test(&table->refcnt)) {
 		mutex_lock(&table->lock);
-		table_instance_flow_flush(table,
-					  ovs_tbl_dereference(table->ti, table),
-					  ovs_tbl_dereference(table->ufid_ti, table));
+		ufid_ti = ovs_tbl_dereference(table->ufid_ti, table);
+		ti = ovs_tbl_dereference(table->ti, table);
+		table_instance_flow_flush(table, ti, ufid_ti);
+		table_instance_destroy(ti, ufid_ti);
+
+		mc = ovs_tbl_dereference(table->mask_cache, table);
+		ma = ovs_tbl_dereference(table->mask_array, table);
+		call_rcu(&mc->rcu, mask_cache_rcu_cb);
+		call_rcu(&ma->rcu, mask_array_rcu_cb);
+
 		mutex_unlock(&table->lock);
 		call_rcu(&table->rcu, ovs_flow_tbl_destroy_rcu);
 	}
-- 
2.54.0


