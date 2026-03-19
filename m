Return-Path: <netdev+bounces-269620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH72JHVDvGmAwAIAu9opvQ
	(envelope-from <netdev+bounces-269620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:41:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFC12D12D0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AFC93008CA8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996103112A5;
	Thu, 19 Mar 2026 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmHEJ70X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEBE34EF01
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945697; cv=none; b=GxeHd7Y/WHIBlDCAUTS4Djuu8K6s3jrNq49xr3RnDHLSmasC7+PvzVQVZhAge8lIndGaZOtSWs9WJEy2YSwUg130U/lYrKa7F3UP7xEwMQjO0nsMl+Al7BrE4eVWXhZu55+9ldWmfVlC8EcSIX70caTtROR96Xg6fNJ5YvtlqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945697; c=relaxed/simple;
	bh=jhb06zeiqqidHMvxMA568Iv0aU+6DcXqhqStBqiUwnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roYwZ3bRnp/uO9CsRjDK9dbw8lYAx9F95/5YFjbwEMKun/HoAjFZ8qAcOt1v3QmNJfKu0Lnc/6ElDK4jXSju8t+HyQkFIIyD7BiqSQCrUmT1x3/xhjjdoOz1zHb+n/WMeARPCAelsc1k06nqt4o2jMY7f/kdBNiZ0Oovi7WmvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmHEJ70X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773945695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXt9XVRGI8BxmSRvhbBduqGT/zd8u0VhjxlYSDKCIn8=;
	b=EmHEJ70X5RQ7SfvPUoP8YZGK5/RpiePRGCVgTD7URfzJX4PirKg4lGKtMc7NnEujLA9CNr
	AjzG+jqasVhScEa6BelRPtd2UO04jTtlabWLWxCt9zuDRHlkBU3U2jYEKA/zZ0Jlz734+b
	72dOlG05cdykQFAa96K/oSGcHNP8i4I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-q1sLYXH4PQG2g7FfXC5hCQ-1; Thu,
 19 Mar 2026 14:41:31 -0400
X-MC-Unique: q1sLYXH4PQG2g7FfXC5hCQ-1
X-Mimecast-MFC-AGG-ID: q1sLYXH4PQG2g7FfXC5hCQ_1773945690
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA28D19560AB;
	Thu, 19 Mar 2026 18:41:29 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.95])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D43281955D84;
	Thu, 19 Mar 2026 18:41:26 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v4 2/3] netdevsim: support tc-ets offload
Date: Thu, 19 Mar 2026 19:40:55 +0100
Message-ID: <d04086cd0204d4aaf6524e972198faa1a4e5d657.1773945414.git.dcaratti@redhat.com>
In-Reply-To: <cover.1773945414.git.dcaratti@redhat.com>
References: <cover.1773945414.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269620-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.906];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BFC12D12D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend netdevsim to accept ndo_setup_tc(TC_SETUP_QDISC_ETS) calls, so that
it's possible to run tdc on ETS offload code path.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 drivers/net/netdevsim/tc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/netdevsim/tc.c b/drivers/net/netdevsim/tc.c
index 8a1960f5f99e..8f013a5895a2 100644
--- a/drivers/net/netdevsim/tc.c
+++ b/drivers/net/netdevsim/tc.c
@@ -2,6 +2,7 @@
 
 #include <linux/netdevice.h>
 #include <net/pkt_sched.h>
+#include <net/pkt_cls.h>
 
 #include "netdevsim.h"
 
@@ -36,6 +37,25 @@ static int nsim_setup_tc_taprio(struct net_device *dev,
 	return err;
 }
 
+static int nsim_setup_tc_ets(struct net_device *dev,
+			     struct tc_ets_qopt_offload *offload)
+{
+	int err = 0;
+
+	switch (offload->command) {
+	case TC_ETS_REPLACE:
+	case TC_ETS_DESTROY:
+		break;
+	case TC_ETS_STATS:
+		_bstats_update(offload->stats.bstats, 0, 0);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
 static LIST_HEAD(nsim_block_cb_list);
 
 int
@@ -46,6 +66,8 @@ nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
 	switch (type) {
 	case TC_SETUP_QDISC_TAPRIO:
 		return nsim_setup_tc_taprio(dev, type_data);
+	case TC_SETUP_QDISC_ETS:
+		return nsim_setup_tc_ets(dev, type_data);
 	case TC_SETUP_BLOCK:
 		return flow_block_cb_setup_simple(type_data,
 						  &nsim_block_cb_list,
-- 
2.52.0


