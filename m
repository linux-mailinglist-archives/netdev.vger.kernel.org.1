Return-Path: <netdev+bounces-201229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD79AE890B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E3C3A3BE7
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773BB1991B6;
	Wed, 25 Jun 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xij2iqMG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D5381C4;
	Wed, 25 Jun 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867307; cv=none; b=Jj8ImTdcfHmFB6emEz1vOhEIstpb7QicrPHaiesvj9Qz6Kuq3xQh5pPD6E6/CrDC8p+aXHu6wdK0gYA81hIOdjwuLZUyYF1DLtr3Soc0QI0/z1+0+VBF/HLMWwGgWJIw723S195xWkIdqjiDtmUtJL866BFmOl/2L4DugDh160Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867307; c=relaxed/simple;
	bh=poQN7rmBS+yUXsOsn4VAFtDKgpo5yI6MwxPt0bzi4IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YTvRWtEBSWICtkA77FwnYao9QErKd7DIM3mhChlZIPNzmCHx2EnbXF88NisxQAaoS4RjeXoPdI/ikPClKCpNyoxcX8TajK/uA2FI3LMDdkKmVQaUG2qfbNXxL0pjEdcFx0tu8iD51AYrBGw2AhvjiUgcaWYQyx8HA9H2NnPheEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xij2iqMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD6DFC4CEEA;
	Wed, 25 Jun 2025 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750867306;
	bh=poQN7rmBS+yUXsOsn4VAFtDKgpo5yI6MwxPt0bzi4IM=;
	h=From:Date:Subject:To:Cc:From;
	b=Xij2iqMGnmrVQiL4oAiMrNvzO8LftVmFCd0vg0mPrpkoOGJQ++Vb7OQkms6wkelYu
	 p0coQYb+UhkiPYG1HRiAdEfaCadIMtXbvHb2q0WxXnRa0nhpp+jQPR+PHl4QbkTKSI
	 k1DSunnbxvu7BHUHpz/BSD+WjhtEvUcJAXgGtWwQ/+ezzZam4rNxsn7Owd9lSX4uPx
	 F2Gawd5LHa7YKTqrqwRrSYCkyVHULleQ0IMdsEKcwlBbwGw9h0dlO9G/TQ0qRvYN/O
	 f4qVIWY11tVT0N8JGJW4bNmXX/Mw/8OrEkbv/N/PcQSzWzE03H9FcR1h+ZucEnOtbx
	 yGLJ5U646puYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB937C7115C;
	Wed, 25 Jun 2025 16:01:46 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 25 Jun 2025 11:01:24 -0500
Subject: [PATCH] bonding: don't force LACPDU tx to ~333 ms boundaries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-fix-lacpdu-jitter-v1-1-4d0ee627e1ba@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFMdXGgC/x2MQQqAIBAAvxJ7bsEkg/pKdDDdaiNK1CIQ/550H
 JiZBIE8U4ChSuDp4cDXWaCpKzCbPldCtoVBCqlEJxUu/OKhjbM37hwjeWyUam2/dELoGUrnPBX
 pf45Tzh8MiugxYwAAAA==
X-Change-ID: 20250625-fix-lacpdu-jitter-1554d9f600ab
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Carlos Bilbao <carlos.bilbao@kernel.org>, 
 Tonghao Zhang <tonghao@bamaicloud.com>, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2095;
 i=sforshee@kernel.org; s=work-laptop; h=from:subject:message-id;
 bh=poQN7rmBS+yUXsOsn4VAFtDKgpo5yI6MwxPt0bzi4IM=;
 b=owEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBoXB1lQp17Gf1LirhQlvBSdI2ZLqNEM7w/vsSg5
 cfVOtzlT9WJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxyQUCaFwdZQAKCRBTA5mu5fQx
 ySB5B/9LePzS7mIeDtBqSqKz7Z3zSCIM3/t/x0zlVjjRdmit0mL+1u22lcECAHnu4gZCp2gwMYf
 UJwZs8zTrr7o4hFA7ERNeyqDlKuDpvdC4ieyZxyBkrBVKJIc9WPw650p2uyfzqWpQMcvJM82gwU
 fqxAG0z6bRfoLeNkG5ORTwyi9D+v/oeNsGnLCID5YiD28tPaNoi8yTfbEF4MOsYo+xcoZx5imZd
 z/jsviebEn6H/JCdKbFmzvzLdmcSz6SNRDGhdlJRSrIp+uIdL/yjxAoKsOWCTp5t0N9FcHe8IYU
 5A44wy8c7LNzhBAKqS+Q46olGG0CnKJ63QpiphgBy4UrYcwi
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received: by B4 Relay for sforshee@kernel.org/work-laptop with
 auth_id=442

The timer which ensures that no more than 3 LACPDUs are transmitted in
a second rearms itself every 333ms regardless of whether an LACPDU is
transmitted when the timer expires. This causes LACPDU tx to be delayed
until the next expiration of the timer, which effectively aligns LACPDUs
to ~333ms boundaries. This results in a variable amount of jitter in the
timing of periodic LACPDUs.

Change this to only rearm the timer when an LACPDU is actually sent,
allowing tx at any point after the timer has expired.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 drivers/net/bonding/bond_3ad.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab706afed9560bcdb5e6eca1934f5b7..a8d8aaa169fc09d7d5c201ff298b37b3f11a7ded 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1378,7 +1378,7 @@ static void ad_tx_machine(struct port *port)
 	/* check if tx timer expired, to verify that we do not send more than
 	 * 3 packets per second
 	 */
-	if (port->sm_tx_timer_counter && !(--port->sm_tx_timer_counter)) {
+	if (!port->sm_tx_timer_counter || !(--port->sm_tx_timer_counter)) {
 		/* check if there is something to send */
 		if (port->ntt && (port->sm_vars & AD_PORT_LACP_ENABLED)) {
 			__update_lacpdu_from_port(port);
@@ -1393,12 +1393,13 @@ static void ad_tx_machine(struct port *port)
 				 * again until demanded
 				 */
 				port->ntt = false;
+
+				/* restart tx timer(to verify that we will not
+				 * exceed AD_MAX_TX_IN_SECOND
+				 */
+				port->sm_tx_timer_counter = ad_ticks_per_sec / AD_MAX_TX_IN_SECOND;
 			}
 		}
-		/* restart tx timer(to verify that we will not exceed
-		 * AD_MAX_TX_IN_SECOND
-		 */
-		port->sm_tx_timer_counter = ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
 	}
 }
 

---
base-commit: 86731a2a651e58953fc949573895f2fa6d456841
change-id: 20250625-fix-lacpdu-jitter-1554d9f600ab

Best regards,
-- 
Seth Forshee (DigitalOcean) <sforshee@kernel.org>



