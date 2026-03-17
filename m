Return-Path: <netdev+bounces-268652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELwAKfNxuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:23:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B20FC2ACF42
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B891A30F6D51
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB853EAC78;
	Tue, 17 Mar 2026 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxcsaIHC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF023EB7FA
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760249; cv=none; b=QZbEjoXibxPEoQ6+La7W0s9GRRWSY54snRFr621SDnCBv6dtkoSo6m7V9RhgsASEaob76Gv1gifDCX6fHk0yFqSPfjAy0QtVFAIS4R6Ik4vafKzPCb/J1SZLYZQX20XbGWpfFHCb2g6rgBgLGegvowJQws2UUv1AjsPiI2Ai4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760249; c=relaxed/simple;
	bh=jhb06zeiqqidHMvxMA568Iv0aU+6DcXqhqStBqiUwnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erYMWCUlMysfha4hLq3blWy+7K83J7jDOkWapKos+wOW/kjEO+rhWyX3Brm9EXSvan2WuMysEbajD6N/ZjWW6hoQcvs0EqSgxB5tawIK8LA+ZPs6zqJ6IfSTDGpYuL5aQZwcg3FqtxNyhHbYkNB5j+jjNUDbQ4WxnMukSJ06sOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxcsaIHC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773760247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXt9XVRGI8BxmSRvhbBduqGT/zd8u0VhjxlYSDKCIn8=;
	b=fxcsaIHC/1RhoieX3RnM9jfSEQ+USddk3Vm8jY3iRntA35nretOOnM+rQOm9+G+MG0K9q4
	kws47S7i28ICaVDhnGT5BHPW0tVQTACj1GdzPYEEvN3mRgOn1CnTCeVfeC56JhAB7lO2Br
	pA6Yd7LPHk43oLzGZ+J0qGIi5W7fDQQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-Q1UmWR0dPxiCWDcfVTAWFQ-1; Tue,
 17 Mar 2026 11:10:43 -0400
X-MC-Unique: Q1UmWR0dPxiCWDcfVTAWFQ-1
X-Mimecast-MFC-AGG-ID: Q1UmWR0dPxiCWDcfVTAWFQ_1773760242
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F222180049D;
	Tue, 17 Mar 2026 15:10:42 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.95])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBBCB1955F19;
	Tue, 17 Mar 2026 15:10:38 +0000 (UTC)
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
Subject: [PATCH net-next v3 2/3] netdevsim: support tc-ets offload
Date: Tue, 17 Mar 2026 16:06:09 +0100
Message-ID: <d04086cd0204d4aaf6524e972198faa1a4e5d657.1773759815.git.dcaratti@redhat.com>
In-Reply-To: <cover.1773759815.git.dcaratti@redhat.com>
References: <cover.1773759815.git.dcaratti@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268652-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B20FC2ACF42
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


