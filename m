Return-Path: <netdev+bounces-296382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9AasMs9qJmrOWAIAu9opvQ
	(envelope-from <netdev+bounces-296382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:10:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE53B653686
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:10:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296382-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296382-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C23CF300106E
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A4B2FDC5E;
	Mon,  8 Jun 2026 07:10:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23702E6CB8
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:09:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902602; cv=none; b=iB0PgUcFDeyr+LV46ppVNZtI2teRWuBnjJjRvoWCclPcwWKUPPba179FRAfoQzIQTWI1fZydbEeDJ1fTgTqJEpIUFLYGcbx/ZFU/LzNzkP71gppovxJVRj7v+tOWreFCwbrf18vfXhXMGbJ+XGlZDdw6ip1nebpO9oIvIAaKMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902602; c=relaxed/simple;
	bh=7ZbhsAmErXfoZtkQrmTQ+rdUChNpfAHnnK8k380kei4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5Nci92B56SRLxmXH8+tCxKQCbbOt+GZwngU9zBfZwC04WYK9NWdCUztNehxDkKwKxHmHQaTX7lkGplNUQ7CBp5AyGeXi02/9601E88KTdD2y3M9V83gQZxDD8xrvXPTiuU6kMxt3qlr7WpRIDIvBnyle3LoAOGAnxgErOTw30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
X-QQ-mid: esmtpgz13t1780902538tb510d299
X-QQ-Originating-IP: B5zlRMJGtHYJBP98UMFl03GA2zrWFGEpho6sazW6J1w=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.184.84])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 15:08:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14238453599175585417
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 1/3] net: txgbe: initialize module info buffer
Date: Mon,  8 Jun 2026 15:08:40 +0800
Message-Id: <20260608070842.36504-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260608070842.36504-1-jiawenwu@trustnetic.com>
References: <20260608070842.36504-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MJHgWiC2fbPUOCZFNYHthfMR/M/0ihm5a4bLjHyqqRlfiPtKGJjazaXd
	Eq/rN1LRG8WssQ5iFi24CnADAtlev/ikaOR8jmzaYJONwDeXoliMkZcilI0ShUm0/DOFW1k
	ka5tO8lQC6DnQTr7OnPW5s+gJ7Ul/9qaZpiSY+YDXRgnjn0S8l3/rAbMpEo7FKWcXvSoGQd
	1K1UOcfSDbi/toL9WcdR4qxf92TMvDK1HF3Y52tWkhmvGJDZt9boh1zTEAI3ASVTqmTxUO+
	+TC3JL/Tbr1E83Qx3mF9Jun1WQ6IuO0xhufZPLTGCv2QaueOmMtFNMODrvCz7QxPxDVZZRy
	vuKvj1iZeLTEk66owbqSkSOlPGYVPR4lzR3/ZYqNL8DIFoFui3kuNkKS+dtbDOf36bruBq3
	4cynv/AIy7u6a3T0MfXuadvDkJXr9ouL9tH2SRxNcoqyuVSzXcTNGim64g+gF4OA6rlit18
	K6Ji4jYwx1s1cD/lxnzcQOkTDmDi9dpoao3hLHoAXZdUel0fYO47A1Ma12+yhkbOofOgH6d
	WuKWPEg6XWskhqbJnbVVdTeOUn1dS+f6YR8Vo+DsyIcCq0JCWjsX6ime7nQosy6PyFfR0X8
	/NOgP65EfQmyXyVkQ+/M+h123J47bg3J4zo0sBa9UfmIjNLFeTu+CtipNWCwK7WtKtpf9zs
	96bs+mwEvGmz8zD1h2kyvHcYPNCFFX31zWXhnv6cF047V9KJoqYLSSNHyH8ckkKcU78meav
	kwk21yy1ga4iVHY7vOZQ2UfvuDzBkantebwfK03cNbygtFqr4/4aczPZ2gIzsruNQ/sVN8K
	8jmqdWfTePNXG0GhoZ4tFr3+u+tMDHXH8lWD0dHpxOhYA6IhOa150m1bbvL2iq983se9zCG
	Pymp6deF/5AgsxGYElhUG1TehnoKKsLJt8OCuMPj/pioaDnLeUrGo39bx3oHGC7hS1HZWYn
	TLz02mp/RxD45+kK87Zsn4a8iqFnFRxIvth0sOr8Y5nrD4Fx8prfyLb+l4rCn5p6I93tMgc
	b3WD48vBX8Od/22ZZ2MJpTCIB/PUJ2Yy4C5wMCDQPmNL9oV8iQ/Xcw2HFoYAd9Z4CPzW7Ez
	w==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296382-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:larysa.zaremba@intel.com,m:fabio.baltieri@gmail.com,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE53B653686

The module info buffer should be initialized to 0 before the firmware
returns information. Otherwise, there is a risk that the buffer field
not filled by the firmware is random value.

Fixes: 343929799ace ("net: txgbe: Support to handle GPIO IRQs for AML devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index f0514251d4f3..a7e81f9e1be1 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -335,7 +335,7 @@ static int txgbe_qsfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 
 int txgbe_identify_module(struct wx *wx)
 {
-	struct txgbe_hic_get_module_info buffer;
+	struct txgbe_hic_get_module_info buffer = { 0 };
 	struct txgbe_sff_id *id;
 	int err = 0;
 	u32 mod_abs;
-- 
2.51.0


