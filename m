Return-Path: <netdev+bounces-295605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SYyiNCE+ImrYUAEAu9opvQ
	(envelope-from <netdev+bounces-295605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:10:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEFB644CDC
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:10:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295605-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295605-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99AE8301831B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 03:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C061419A4;
	Fri,  5 Jun 2026 03:10:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58103E5A36
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 03:10:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780629009; cv=none; b=GipIVu5fF2lxMpSuBu0G58iHdyWqBha8cduqSJKgTE7LOtJNIWL5hWvx8TP0v/2HYR+b5HVaeqVpyAm0Ehm3Lt00ad1nzbwZkwHFgjyw9DkowNGCX79E38aMb1bhCUvbztQ5B6bAscKNVXcGDhYVu1zVlKXw1zOxEa95roLu80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780629009; c=relaxed/simple;
	bh=PdkVTA4F/ER9GzUAoSUZBzYX4sYHbjYEgTH5soza+vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WrYPxPgJyhzhZsvYoH4D+zudf1oUYT731n5bgp2310VRCbRUesZE7pf/kEGKuMjiKaQLZhi6pJUSRIeT4VSnf99fqfEfzuWaoAxOdWh9PqS7U0mCJoUhQXLK7YSPgPBTZeIvD9/U7eXqRLwldpY6HkTFZRSqrOuHLoBHtP77KLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
X-QQ-mid: zesmtpsz4t1780628946t82ca6aa1
X-QQ-Originating-IP: 1s5BoHG6NpYwLv7KuDGCxQqaCyhvX4nGpbCsZOYZfOg=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.207.111])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Jun 2026 11:09:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10359271061943661340
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 2/3] net: txgbe: distinguish module types by checking identifier
Date: Fri,  5 Jun 2026 11:08:49 +0800
Message-Id: <20260605030850.17796-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260605030850.17796-1-jiawenwu@trustnetic.com>
References: <20260605030850.17796-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OCKrnOOZqSGNgG5dljxLI1bKiYJJZPXG58Rt6IJHR0EPkaoo5faexDVG
	bP95Fs5Gs4a9uL6LJGLpk5XNFAzr+4IGsc1neJCHpnH68kOnRPSYgAoXvZB+1zEnRCSmVg4
	LyePIkUazR5/ik9eYfi9a/Yh0CQqLl3jU007QEbKR2PnLr7Qzp2O9KFGmVv4u+uABWspYRQ
	spSwvwDMKSnSOXG64WmI7cVUyscQxrVSe+xvwfYt+4JFQdQJ/ABzSYaB7TAqOGKuyPXvK2F
	aDbCfOHYy+CfWdl9v7XT2LW5wQe35AKBoLP5KIh3zyrGC/iVnzjw4YB6VxCK+f9rDU4YOrz
	WPc9xnzkyhHS30hbIhYbxQBlzJn9CXvFOVG/WJ3PiFPbP4CI6MEp6eXajUKem7YJnsCTkzl
	QxoluXyqZ5kCHUxIYkHZGlkpaeasHiQT9npSyfJUMZqflinJdvA0iq392ZG8Qe4n1w5aVrT
	MVHriTVlUezbUmC70wAVZa+o/winDy84m5LK45uwpXX3R712C2Q9HADiKLDt+x9nEQMoc7G
	LoAmzzv5q8mpNYFtJdTfI6VnHIwDsyVDGKlr622+edQf5xmmS0gDQ+W3hAhi4HKmJZ07pRB
	U1DO4Y8xnW9T0KI+xiJfwpbZdFk8dSjTTmuST+OXLOqP/XdPwcHnxoFnfMBeLaeG2OyRlPv
	DS+FursDgRyRuxvhkOekTO5q510YwHFw5CUkbu3/pP3EcNgHFwIJvZF+vxTWVnxB+b4vPz9
	c5Mh3e3MCE+b/NUi9O8d8cfcRUZ590+w0uTbyhwInMupAhxQETIs8hZO1TGpabaU3ZSys4j
	igsmrfvhm4UwO1q3QwM7yTYeeNy9aQqYxFVNdAbvhxXK5b8iaAiHPZfY8tBR1h7BoDRm7iZ
	xPgYoQLoW/jnhM9F1QrxnrldVNMxJVvYF3d9pGpMqJdE4/7o/qsH+WxoLBjahzczS7ND0t7
	yEauCOZdKZJGUxatZsBySSPBMlHmJX+67BlrV75CHUVj0jp1Fnuq3VffHDlop+QpX6Youc/
	F57Wge/j0SxXaRVzJKC+1uu6emgGn5eMs8cUuf52V4geaIj1u/0dMst8Mr6B1elS4Gm3san
	KsrofomMXI8OSgL4g0W6prjkdpHorfanwofbrQSu3AW
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295605-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:from_mime,trustnetic.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBEFB644CDC

Rework txgbe_identify_module() to validate module identifiers through
explicit type checks instead of relying on transceiver_type heuristics.
When using the SFP module, transceiver_type could be a random value,
because it was read from an invalid register.

Fixes: 57d39faed4c9 ("net: txgbe: improve functions of AML 40G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index a7e81f9e1be1..bdac654a2364 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -357,18 +357,16 @@ int txgbe_identify_module(struct wx *wx)
 	}
 
 	id = &buffer.id;
-	if (id->identifier != TXGBE_SFF_IDENTIFIER_SFP &&
-	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP &&
-	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP_PLUS &&
-	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP28) {
-		wx_err(wx, "Invalid module\n");
-		return -ENODEV;
-	}
-
-	if (id->transceiver_type == 0xFF)
+	if (id->identifier == TXGBE_SFF_IDENTIFIER_SFP)
 		return txgbe_sfp_to_linkmodes(wx, id);
 
-	return txgbe_qsfp_to_linkmodes(wx, id);
+	if (id->identifier == TXGBE_SFF_IDENTIFIER_QSFP ||
+	    id->identifier == TXGBE_SFF_IDENTIFIER_QSFP_PLUS ||
+	    id->identifier == TXGBE_SFF_IDENTIFIER_QSFP28)
+		return txgbe_qsfp_to_linkmodes(wx, id);
+
+	wx_err(wx, "Invalid module\n");
+	return -EINVAL;
 }
 
 void txgbe_setup_link(struct wx *wx)
-- 
2.51.0


