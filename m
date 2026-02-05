Return-Path: <netdev+bounces-257012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DqyLIJDhGm/2AMAu9opvQ
	(envelope-from <netdev+bounces-257012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:15:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A10EF5B8
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9D23300B76C
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEF335B64F;
	Thu,  5 Feb 2026 07:15:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CC1333752;
	Thu,  5 Feb 2026 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770275711; cv=none; b=l+4HiKrI1LS9q608u3MhghehSkOylaMazx2yo/A4dcO7DZtNDD0lLNhi7z8UwZzn4xVH6Lcq9MdSPZEfDNCP0BlJi2ii9XkooeiK2r4T7AU3WhqfK/lL7Cdl5kUBExsuOkbUjH3fljQl+V63VQVnkMkq5xfQPFUDCg3LSc4ebHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770275711; c=relaxed/simple;
	bh=lWAxz5O3ynxPKCSpb8VPogMQWR7T7rstem0Ei8fOo80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rX/wTIh4pnWPDLqC/drownIzEfuGKS8E1blxHhmsOJVJ33iVDiTe9JWePjZgEm9RnGOnth5z1c2ML3zf5L8aNDQPQb5m7wbZegBYZMlPt7m4Sa7DmjqlMdDYMEzY17jb3s2ytBV+0Rhj+T5d77udZsjoyaFz02hkIg/FLkPmPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: SN1+TWOQTNCOMssdawIgmw==
X-CSE-MsgGUID: FOxIt37FQiGjeAThSZqSMA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2026 16:15:09 +0900
Received: from [127.0.1.1] (unknown [10.226.78.135])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8EE914102B68;
	Thu,  5 Feb 2026 16:15:06 +0900 (JST)
From: Michael Dege <michael.dege@renesas.com>
Date: Thu, 05 Feb 2026 08:14:40 +0100
Subject: [PATCH net] net: renesas: rswitch: fix forwarding offload
 statemachine
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-fix-offloading-statemachine-v1-1-640224a531d0@renesas.com>
X-B4-Tracking: v=1; b=H4sIAF9DhGkC/x3MQQqAMAwAwa9IzgbSiiJ+RTwEm2pAW2lFBPHvF
 o8Dyz6QJalkGKoHklyaNYYCU1cwrxwWQXXFYMl2ZKlFrzdG77fITsOC+eRTdp5XDYLGNWS6hph
 6B+VwJCn5fx+n9/0AKi4ogW0AAAA=
X-Change-ID: 20260205-fix-offloading-statemachine-1d301630a08d
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michael Dege <michael.dege@renesas.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770275705; l=1621;
 i=michael.dege@renesas.com; s=20251023; h=from:subject:message-id;
 bh=lWAxz5O3ynxPKCSpb8VPogMQWR7T7rstem0Ei8fOo80=;
 b=XQc9j+LzBY3TbixnkUhueneNJLEtaz0rhpmYeFM0aB3pVRyiGvsXhvUDU1kTcwoC9uh1Vcvld
 QslYs/Oj1hECppImoPQkUKI7KckY9to5mJwakqLzNAu2+ZKxABWDMNJ
X-Developer-Key: i=michael.dege@renesas.com; a=ed25519;
 pk=gu1rwIcCrAxNMv2I8fIfiQvt51xzZwnQy4Ua/DscQt8=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257012-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.dege@renesas.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9A10EF5B8
X-Rspamd-Action: no action

A change of the port state of one port, caused the state of another
port to change. This behvior was unintended.

Signed-off-by: Michael Dege <michael.dege@renesas.com>
---
A change of the port state of one port, caused the state of another
port to change. This behvior was unintended.

Fixes: b7502b1043de86967ff341819d05e09a8dbe8b2b ("net: renesas: rswitch: add offloading for L2 switching")
---
 drivers/net/ethernet/renesas/rswitch_l2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch_l2.c b/drivers/net/ethernet/renesas/rswitch_l2.c
index 4a69ec77d69c..dcf726793bdc 100644
--- a/drivers/net/ethernet/renesas/rswitch_l2.c
+++ b/drivers/net/ethernet/renesas/rswitch_l2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Renesas Ethernet Switch device driver
  *
- * Copyright (C) 2025 Renesas Electronics Corporation
+ * Copyright (C) 2025 - 2026 Renesas Electronics Corporation
  */
 
 #include <linux/err.h>
@@ -88,7 +88,8 @@ static void rswitch_update_l2_hw_forwarding(struct rswitch_private *priv)
 		    rdev->forwarding_requested &&
 		    !rdev->forwarding_offloaded) {
 			rswitch_change_l2_hw_offloading(rdev, true, false);
-		} else if (rdev->forwarding_offloaded) {
+		} else if (rdev->forwarding_offloaded &&
+			   !rdev->forwarding_requested) {
 			rswitch_change_l2_hw_offloading(rdev, false, false);
 		}
 	}

---
base-commit: f14faaf3a1fb3b9e4cf2e56269711fb85fba9458
change-id: 20260205-fix-offloading-statemachine-1d301630a08d

Best regards,
-- 
Michael Dege <michael.dege@renesas.com>


