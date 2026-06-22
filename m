Return-Path: <netdev+bounces-301020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SZc1ERcDOWqplQcAu9opvQ
	(envelope-from <netdev+bounces-301020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:40:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A29C26AE54F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:40:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ESGrJIF2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301020-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301020-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A467303CF24
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AE339DBC0;
	Mon, 22 Jun 2026 09:35:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917E339C006
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 09:35:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120927; cv=none; b=LTBlhQM/8hy8upTa2ovehvlhtf3qf8Kqhy8viaBZR7NTFU/XWnfhfBucg09HdwjvrtG0G2GxnxI7EX+f4jsJ658QFBKi7KLGOxSjalvryBeLH7mPSCifZvcssx2il62Av5yvhXW02Lxx42fm4vJ/WRePrCG9vdtUF3OQnF/iMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120927; c=relaxed/simple;
	bh=9ai7vpeQmT1bsxBHrCNnpzRgD0Lk3aIkJN01AVXOfns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OZs4aHggCXd6+K/TSPYSJHGiDBebOTz72X8o9zrGHSrc7lEqU6FeNZSiUNon5qdsHacr/CaI779mfwLyBVVqt0UwYy+ORH6rwJ+TEEX7XbI3QRLdEya745UzRquK5w2wGuEXoXdlb1ljvZq3W49yDLA9HYf8Y2p8c6KX7RxUy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESGrJIF2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10B31F00A3A;
	Mon, 22 Jun 2026 09:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782120926;
	bh=OBdMhJJ0Y7gIABwR1q/8w26Nesukt0v7qHvKC0K0k5c=;
	h=From:Date:Subject:To:Cc;
	b=ESGrJIF2eQfsXySEQ1mH/Yr5U6gKvtDjbJbUD1pfHwSPS1P/07NVe66c+WqLyfvZv
	 Y11VRoAQKqjPfbCifvtqeV4qxwVWfP3iIueZciWP3CylDRwoL7Xat7B8didP6AKBUL
	 mIPk18XkrYB9YbuhblaEft+uGJTFgJ3qJ8+KZn3b5MDwoCD/bsC9NaCLBH0iYVdC3l
	 mXkY5ifmOZK6nWqlBH6t2vUJTQRSBCqFeM9GogYthIMZUDE9nkxjpbMwvvLjfZy2ET
	 ivBnwCqITnAr+sBqig407umXp/J8YsYYQRi5nLjx3hq7/WRxhpVdYDBOpvTUTe05e3
	 7tYOA4g3dNNmg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 22 Jun 2026 11:35:07 +0200
Subject: [PATCH net v2] net: airoha: Add retry mechanism to
 airoha_qdma_set_trtcm_param()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-airoha_qdma_set_trtcm_param-retry-fix-v2-1-95a83ac99dbd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NWwqDMBBFtyLz3ZQY6qtf7qNIiGaioTWxkyAVc
 e8N0gX085wL9+wQkCwGuGc7EK42WO8SiEsGw6TciMzqxCC4KHnJC6Ys+UnJt56VDBhlpDjMclG
 kZkYYaWPGfphqtGiKsm96YSB9LYRJn50HOIzQJTnZED1tZ3vNz+mXqf/MrDnLmeFVxW+G63oo2
 ieSw9fV0wjdcRxfNIRUzuAAAAA=
X-Change-ID: 20260605-airoha_qdma_set_trtcm_param-retry-fix-a9d2956b9b2f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Leto Liu <leto.liu@airoha.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Brown Huang <brown.huang@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301020-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:leto.liu@airoha.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:brown.huang@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A29C26AE54F

From: Brown Huang <brown.huang@airoha.com>

CPU accesses QDMA via the bus. When multiple modules are using the bus
simultaneously, CPU access to QDMA may encounter bus timeouts and fails,
resulting in QDMA configuration failures and potentially causing packet
transmission issues. In order to mitigate the issue, introduce a retry
mechanism to airoha_qdma_set_trtcm_param routine in order to ensure the
configuration is correctly applied to the hardware.

Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
Signed-off-by: Brown Huang <brown.huang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Wait for write configuration to be completed before running
  airoha_qdma_get_trtcm_param() in airoha_qdma_set_trtcm_param().
- Link to v1: https://lore.kernel.org/r/20260608-airoha_qdma_set_trtcm_param-retry-fix-v1-1-f07704f0d8c5@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 3370c3df7c10..bb5c0599a4ee 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2673,14 +2673,30 @@ static int airoha_qdma_set_trtcm_param(struct airoha_qdma *qdma, int channel,
 		     FIELD_PREP(TRTCM_METER_GROUP_MASK, group) |
 		     FIELD_PREP(TRTCM_PARAM_INDEX_MASK, idx) |
 		     FIELD_PREP(TRTCM_PARAM_RATE_TYPE_MASK, mode);
+	int i;
 
-	airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
-	airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
+	for (i = 0; i < 100; i++) {
+		u32 data;
 
-	return read_poll_timeout(airoha_qdma_rr, val,
-				 val & TRTCM_PARAM_RW_DONE_MASK,
-				 USEC_PER_MSEC, 10 * USEC_PER_MSEC, true,
-				 qdma, REG_TRTCM_CFG_PARAM(addr));
+		airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
+		wmb();
+		airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
+
+		if (read_poll_timeout(airoha_qdma_rr, data,
+				      data & TRTCM_PARAM_RW_DONE_MASK,
+				      USEC_PER_MSEC, 10 * USEC_PER_MSEC,
+				      true, qdma, REG_TRTCM_CFG_PARAM(addr)))
+			return -ETIMEDOUT;
+
+		if (airoha_qdma_get_trtcm_param(qdma, channel, addr, param,
+						mode, &data, NULL))
+			continue;
+
+		if (data == val)
+			return 0;
+	}
+
+	return -EBUSY;
 }
 
 static int airoha_qdma_set_trtcm_config(struct airoha_qdma *qdma, int channel,

---
base-commit: d07d80b6a129a44538cda1549b7acf95154fb197
change-id: 20260605-airoha_qdma_set_trtcm_param-retry-fix-a9d2956b9b2f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


