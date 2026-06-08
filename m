Return-Path: <netdev+bounces-296384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QJ7OHHZrJmrnWAIAu9opvQ
	(envelope-from <netdev+bounces-296384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:12:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F286536B5
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:12:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296384-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296384-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 356DA3040FBD
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3BD352024;
	Mon,  8 Jun 2026 07:10:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E393101D4
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:10:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902608; cv=none; b=Ekdq5xvd37O3zkR+3/YRtJssc13a0g4Y3J2G/efMPa2ESPnkBp/1ZtkmSgr30yY3vpYHDcisLRf9dLbyrPfW5zxhkpzZU8yQd41yd7HEkvC10jXDfQWevQ2I/+c604NY/bH0Sz4q0UrurNXDpAu84hAdAt07DLONsaYcUwWpmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902608; c=relaxed/simple;
	bh=PdkVTA4F/ER9GzUAoSUZBzYX4sYHbjYEgTH5soza+vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rc2kpIAji9ST/xOLmMsyIRTJ+WrGHuZT7t9wXzy7gWdcjSXYWm3C4X6kWBu1a6OdIBjg1VQwZS+hh7cBvKR10LxFsFEwpFBRpR4XpZLJfcm+Ls0ecglzfG3y9OrStPuse9jDWRSQXX52RCsRghERi0LHVhbgd3e/tJzr4ZgVGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
X-QQ-mid: esmtpgz13t1780902541t95cae5f8
X-QQ-Originating-IP: RV4J7uDkvmjSzeawDdbAYuKoiYgFYgNbRLwyX+slZY8=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.184.84])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 15:08:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6857336265194045610
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
Subject: [PATCH net v3 2/3] net: txgbe: distinguish module types by checking identifier
Date: Mon,  8 Jun 2026 15:08:41 +0800
Message-Id: <20260608070842.36504-3-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NiWQQk7XjMbnLX6sZIb3uFuD4SN2+uLAiqAij/+zZ2DkRzq+Wjeu/TkV
	a834SRTyfAictrx4N1ovqgWp40BtJ7pHa3hHVL52iX2qCUX5/sg52aT3lAanDFEX3l3csSj
	d2Y+HmCYnjpR7+aU//mt6PTv0Xq5hGSIZWEMv1t2r/9IDM3DO7fSkQ3/t6t3PL/T9VsjYu8
	1eWUQVAx8VAehhEwaPrrrTCU02t7oVgQvmtiB7ER+apPmobp1DFfLhEDDI6UJ0eLg0ynzB4
	I1v7gnUxEkBYWJAcYj/0HYiJgymkkOPa/NPhcMCR4JTG4x7aaNgTv+L+ffo/45XKIi7eVAX
	VYoZa5EBnEQsSal3xOHBApMO2LqXvcbjethnJ3eLYXARc9owTG/DiPfbVgZLPyang0hhK47
	bUU46eklLyeSmaR3irKLFAwPsuxAPhxZcoKyaWm2YUh8LS6n8KiVlZsVtoaYo3JPVOnRHeS
	a/Wo5QxghQgiuYEoltKQbngG4lS/fC7tp6ZScl9sh4etNT/5RO2aX2bWfYlAU6POGqO4fZH
	s4SXbGYac/hAP3AlJorwCvF30Kzqe+BZ+lUyCqUBVjF1lfzXqmF7cOU2ycnUwQ375Ygy7zg
	uSNtCgeQDsmlg8ahHZ0XmcU28gxygT9/JPfww+5KvfXdJy/FdYU81OnlKVvkt1k/ydUaNDD
	QAyf73YPQRZ3H6aUHZLG5NMRj/dbtBvJOjhnzUXK+XeVmd1Xm9uDt0EEDOWbNHXJRtW+hFz
	Ox2YdvutnEeBzROxBs9P7gR8H92FrMtEs6winssv5KVAUM9IRMMb0WT546reGJBVTegByhX
	DVfnAbEcLaFfqcn7tqm3Zt4tCGl9eXhBpuadRObOqs0wrL2MHoy2LPFehPSM0Ipg2mJbSI0
	c+juGeb3bIjbdfpUobbQP3+gXAuJ2XcG1w6SyEnfccTvj/dgSKz4L7qD5XCm7WNxnXqhrH0
	3hA8qOV5iHLBeI4ry1Lfg9IVQ7DeeI6Huvbc9I03676n75y9hy5FiGA2i+9D7JCKDbcLzOx
	Jug9BgSqMuxNz50axw5pMjGUF1JeC5u3zH0r7AbGfXwmk6jzwVcqNooCeQ6Un/wLiEtmIDu
	HdXTtPXpFdBTEa+arWDZPnpiK8rXt1LoBT3fQA4jCuO
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296384-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,trustnetic.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:larysa.zaremba@intel.com,m:fabio.baltieri@gmail.com,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2F286536B5

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


