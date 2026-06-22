Return-Path: <netdev+bounces-301014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qenqM2X+OGpxlAcAu9opvQ
	(envelope-from <netdev+bounces-301014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:20:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CEA6AE25F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:20:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301014-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301014-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 359553001CEC
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F6939D6F2;
	Mon, 22 Jun 2026 09:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9639A04D;
	Mon, 22 Jun 2026 09:20:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120018; cv=none; b=EJPsverNUUAqJzGqq9Eu96mejkUPsgaOqHVMIpDdCp5/YT+ZLEVY0yiqkF8FldlJZKqYG4GLII2W2Mg/m5CnY3OdmmSEwDpabtIsewSmrjSdL3Jc7YXFNIzFnXcWIcYiPcdht1WIvLv1QQzKxrA0NEi04xgF1o/6A0zMHbQVcRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120018; c=relaxed/simple;
	bh=jJ4dPiOt0VnW+1/y5QpkX2tVW+trXodIRZaAJVuBLUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nXns+sWWvihgmC0bGDoAxwqiYD+ukqr7RWBczLpQpQNXGP3NSlC2Sf2w8jUiAUuadwSgcVvsXhdGxtqTwypOXeDM4ZSZnNSOPjXVoPiDoyxXRE8LrY3ugKzz9ZkXp5fzhMZbwUki5C53Q/MkQetyUKqe5ajeIdt4DiuU8rqwQyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9FE741A02E0;
	Mon, 22 Jun 2026 11:20:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 723511A02F4;
	Mon, 22 Jun 2026 11:20:06 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2FB201800086;
	Mon, 22 Jun 2026 17:20:04 +0800 (+08)
From: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	shuah@kernel.org,
	vladimir.oltean@nxp.com,
	vinicius.gomes@intel.com,
	fejes@inf.elte.hu,
	xiaoliang.yang_1@nxp.com
Subject: [PATCH net-next 2/6] uapi: pkt_cls: add TCA_ID_FRER action identifier
Date: Mon, 22 Jun 2026 17:21:14 +0800
Message-Id: <20260622092118.6846-3-xiaoliang.yang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260622092118.6846-1-xiaoliang.yang_1@nxp.com>
References: <20260622092118.6846-1-xiaoliang.yang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301014-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:horms@kernel.org,m:shuah@kernel.org,m:vladimir.oltean@nxp.com,m:vinicius.gomes@intel.com,m:fejes@inf.elte.hu,m:xiaoliang.yang_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiaoliang.yang_1@nxp.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[xiaoliang.yang_1@nxp.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25CEA6AE25F

Register TCA_ID_FRER in the global tc action ID enum so that the FRER
tc action can be identified uniquely among all tc actions.

Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
---
 include/uapi/linux/pkt_cls.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 28d94b11d1aa..9b87f0455110 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -139,6 +139,7 @@ enum tca_id {
 	TCA_ID_MPLS,
 	TCA_ID_CT,
 	TCA_ID_GATE,
+	TCA_ID_FRER,
 	/* other actions go here */
 	__TCA_ID_MAX = 255
 };
-- 
2.17.1


