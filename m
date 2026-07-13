Return-Path: <netdev+bounces-307104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cRi2HguvVGqepQMAu9opvQ
	(envelope-from <netdev+bounces-307104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:25:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C526F749440
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:25:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="FapGF/n7";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307104-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307104-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58AC3022621
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F372F532F;
	Mon, 13 Jul 2026 09:21:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1072F363F
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:21:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934490; cv=none; b=MbxNbNfmP9iLklEhMSJ+s4E6JFYyHGF/g40DZ5RRVvvHIl6om+LHjYra306lQvja7iBvEIOwdJP59xlh2gzeiEdsWs0vnqqpuqGwfDKSo3O6MmZtutTa5hjvXsXIA1tEIsasA4PP3fqF/XTQtaGXeEEGpVYyxEnYGz8s+Zz2kOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934490; c=relaxed/simple;
	bh=FDdkI+0TwLs1WDyCmmW1+RSfKece1PCSOkFIXdgyJqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lzz8t8LvsvIpCcwTLJA86ltT6U/Sh1RaBKDct+dDJWS4uWVSoiX9UeK9anyX+DThPVXBBMBlIZLNJko8+WOBKJyazLRlS3Ix4+Cbq4KpTiw9MP1DfxifR1dVL3dhqEKdS7lUiNQuIaOz05DkUQTYbY+qfMdaEHKof1njtZ0A3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FapGF/n7; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783934487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RfMiJG4sSQI5dapo/fTxHG11a+NsK6QryBoFpds8mH4=;
	b=FapGF/n7jWlhE/ayhXdVz6JaIZysb9r6JbbinQ2hvuYc/jZa+oZ3Yf9ZWHkl5hMuHPawo7
	6rbH7/rHCt4U/HtR5rF18WJEQkwqiiZSgXWbaMEIbbWLaQaWWiiJmHqTYveE9eMLG7oJs/
	Nz8WuGWwpvSXSESyNFPK3E/PO0c2q8c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-LLQjRM_ZOOmFY3Q9VjPnQQ-1; Mon,
 13 Jul 2026 05:21:24 -0400
X-MC-Unique: LLQjRM_ZOOmFY3Q9VjPnQQ-1
X-Mimecast-MFC-AGG-ID: LLQjRM_ZOOmFY3Q9VjPnQQ_1783934483
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C48E71955DB8;
	Mon, 13 Jul 2026 09:21:22 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.34.53])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77CA13000B50;
	Mon, 13 Jul 2026 09:21:20 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] ip: display DPLL pin information in link details
Date: Mon, 13 Jul 2026 11:21:19 +0200
Message-ID: <20260713092119.1536385-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307104-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:poros@redhat.com,m:dsahern@kernel.org,m:stephen@networkplumber.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C526F749440

Parse the IFLA_DPLL_PIN nested attribute and display the associated
DPLL pin ID in 'ip link show' detail output. This allows users to see
which DPLL recovered clock pin is associated with a network interface
without having to cross-reference with 'dpll pin show'.

Example output:
  $ ip -d link show eth0
  ... parentbus pci parentdev 0000:51:00.0 dpll-pin 4

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 ip/ipaddress.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 6017bc8370cb..bf470961182e 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -25,6 +25,7 @@
 #include <linux/if_infiniband.h>
 #include <linux/sockios.h>
 #include <linux/net_namespace.h>
+#include <linux/dpll.h>
 
 #include "rt_names.h"
 #include "utils.h"
@@ -1294,6 +1295,18 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 				     "parentdev %s ",
 				     rta_getattr_str(tb[IFLA_PARENT_DEV_NAME]));
 		}
+
+		if (tb[IFLA_DPLL_PIN]) {
+			struct rtattr *dp[DPLL_A_PIN_MAX + 1];
+
+			parse_rtattr_nested(dp, DPLL_A_PIN_MAX,
+					    tb[IFLA_DPLL_PIN]);
+			if (dp[DPLL_A_PIN_ID])
+				print_uint(PRINT_ANY,
+					   "dpll_pin",
+					   "dpll-pin %u ",
+					   rta_getattr_u32(dp[DPLL_A_PIN_ID]));
+		}
 	}
 
 	if ((do_link || show_details) && tb[IFLA_IFALIAS]) {
-- 
2.53.0


