Return-Path: <netdev+bounces-264706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PNkF2CMqml0TQEAu9opvQ
	(envelope-from <netdev+bounces-264706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 09:12:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E574721CE62
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 09:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D988130C3658
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA53793A8;
	Fri,  6 Mar 2026 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC65MniC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D496378D99
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784465; cv=none; b=FELRdNOXu+ObgB5SH9yhzxLlyxPzEF6NK2CMyIiOLXvCJZ8cWn00ofcM/HIsYHjmSX6nNg0kTBGajKVdPmSlO7Bhfoz3vYK35gDX5lP8WCHKTvzMU/ha4TaMSTZGvmDDN0HvhbknAdUyW7B/2UhlxTjjhqjNUGenlhDs444TIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784465; c=relaxed/simple;
	bh=w4YyGty+4MjVaZXa4YhrFXoqiPmZ1FzsE7rE0bfYb40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nrKOWsrh1EK7R/uOWmPEu2UPDN17g9y6VzUBOlzJl00FHeRFOwLpqqtb6s1pSvI5hCyY9MmW3URAM5++2aDb+QfXANlS0Cddngg5zHZGBsbEPqGaR9ZNb+bvlgBNRy9mk0hCZGw6vPVNtqfFQVWr67Jn3skpcaVtJ1RylFyzGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC65MniC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCF8C19422;
	Fri,  6 Mar 2026 08:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772784464;
	bh=w4YyGty+4MjVaZXa4YhrFXoqiPmZ1FzsE7rE0bfYb40=;
	h=From:Date:Subject:To:Cc:From;
	b=gC65MniC1ninb+IVM7axLnpe5Hvxmusxe9kGd3ixC/VE0V6PAST6MKogy+led8Lth
	 v128XxXNNEuaycyr5RLq5SzeJLR38Hw4HcHmgiV9VxTxcmaJM4e0gWYGxKLYWVtpdu
	 DO1HzkuDNMJD7rcKYwvcjnUH36E13EqYbfCgAKFyVucAQ9oXVesEuABd35ZnctzIOS
	 tdj7z3mAak55b6zSiI6fCy0mnpXpu2ctq6epVNAASQB3xAT1nUuUNN5kHfwgL5esWA
	 5i8fsfpjRdkSiLVN5CrNZ8R55WctRHWgRp/J+OPocC5qOLsr3vlNOoOygpjvPwXOZG
	 RGAfONVR7sIJA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 06 Mar 2026 09:07:27 +0100
Subject: [PATCH net-next v2] net: airoha: Make flow control source port
 mapping dependent on nbq parameter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-airoha-fix-loopback-for-usb-serdes-v2-1-319de9c96826@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNSw6DMAwFr4K8rqskony64h4VCwMGIhBGTotaI
 e7elBt0OU9PMzsEVs8B7skOypsPXpYI7pJAO9IyMPouMjjjMuNcgeRVRsLev3EWWRtqJ+xF8RU
 ajK6OA7osN2RsmtnyBlG0Ksf7GXnUkUcfnqKfs7nZ3/qXfrNokcq0YdMXZd5RNbEuPF9FB6iP4
 /gC4GyyZtUAAAA=
X-Change-ID: 20260228-airoha-fix-loopback-for-usb-serdes-2670a0146195
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: E574721CE62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264706-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Flow control source port mapping for USB serdes needs to be configured
according to the GDM port nbq parameter. This is a preliminary patch
since nbq parameter is specific for the given port serdes and needs to
be read from the DTS (in the current codebase is assigned statically).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Rely __field_prep for non-constant mask
- Update commit log
- Link to v1: https://lore.kernel.org/r/20260228-airoha-fix-loopback-for-usb-serdes-v1-1-a94be0f897da@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 10 ++++++----
 drivers/net/ethernet/airoha/airoha_regs.h |  5 +----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 09acbe6695368132ddd92c3501f8711476db73f6..7b47d9e066cee75609501f87b0e97d936325517c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1729,10 +1729,12 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 		      SP_CPORT_MASK(val),
 		      __field_prep(SP_CPORT_MASK(val), FE_PSE_PORT_CDM2));
 
-	if (port->id != AIROHA_GDM3_IDX && airoha_is_7581(eth))
-		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6,
-			      FC_ID_OF_SRC_PORT24_MASK,
-			      FIELD_PREP(FC_ID_OF_SRC_PORT24_MASK, 2));
+	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
+		u32 mask = FC_ID_OF_SRC_PORT_MASK(nbq);
+
+		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6, mask,
+			      __field_prep(mask, AIROHA_GDM2_IDX));
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index ed4e3407f4a0e8b6a630ea1213ef155604479b66..29878b954c77c79ae45e63357840a10c23c517f2 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -376,10 +376,7 @@
 #define SP_CPORT_MASK(_n)		GENMASK(3 + ((_n) << 2), ((_n) << 2))
 
 #define REG_SRC_PORT_FC_MAP6		0x2298
-#define FC_ID_OF_SRC_PORT27_MASK	GENMASK(28, 24)
-#define FC_ID_OF_SRC_PORT26_MASK	GENMASK(20, 16)
-#define FC_ID_OF_SRC_PORT25_MASK	GENMASK(12, 8)
-#define FC_ID_OF_SRC_PORT24_MASK	GENMASK(4, 0)
+#define FC_ID_OF_SRC_PORT_MASK(_n)	GENMASK(4 + ((_n) << 3), ((_n) << 3))
 
 #define REG_CDM5_RX_OQ1_DROP_CNT	0x29d4
 

---
base-commit: e5e09233e8a9179b260460fdb28df5c24bcfbed6
change-id: 20260228-airoha-fix-loopback-for-usb-serdes-2670a0146195

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


