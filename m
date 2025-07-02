Return-Path: <netdev+bounces-203090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA404AF07D4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1E7424C8F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB58E39FCE;
	Wed,  2 Jul 2025 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvoeSzGM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7B3C30;
	Wed,  2 Jul 2025 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751419124; cv=none; b=PAJjm1cBr5hoa61/DeMzmmGy8rmOMV1PZuVUMjBNx9UiTpEHTB6BZ41JuRNAUNPvfxbF9/ekNFfxvT1dPD1jgninnLWFN2Eq8kJ8V7Z+fx4mZU5YFWRzF2SLve+38fld9NOprMMkrB9P4KbotoDpB4h4u7kiAM9cXWQzYRszEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751419124; c=relaxed/simple;
	bh=Q3ZlQcXLusGO7or5b6gbAN76N6KRrX9bFVhn/AXPoDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tQk+3EIcjh8guQEXY+i6QVOtF+HZfDM0MpADhhXc23fN1LLu+nIhhUXMgZTsuiHk1+PlkxwhYsJ+ZYQWvfoPDuzP27SjFpd0jy3zWE2jkkzVgmo2xGIlRKR2sg8C5hUhJg/219R0dpwWJxW/lerGw1zhaXIq5GGD8KwqvKYD/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvoeSzGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C881C4CEEB;
	Wed,  2 Jul 2025 01:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751419124;
	bh=Q3ZlQcXLusGO7or5b6gbAN76N6KRrX9bFVhn/AXPoDQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=IvoeSzGMjkbTzs0OeT9pXsMaTabkeloJwgX2wcUdGzxUBxcm35JbpaDV/P7Aev0Ko
	 clmqIktb3nuNauaNRqv4wjxWTyPiUGyH0UQ3a3NwFI5Z5323Xx3wwDjVjKmKvae+DU
	 ErraIGxYRnfNTaNjwApvEqdpODrO+2IEH0OD/zLCReh7RJmqOKo9MjX8++ByP7I1M8
	 oTCqT1L6O5DDK1U2z2vRfWts3nuXSTKZ1XnoxULF5pwSX+5agAXcJNST2hb37u/vs/
	 v1TiDnffzf23FO9VTF4eGb7x/vunKnnEAJI8Wz9vkJ6x661or9hAzGr7sJDmlyuh+v
	 T+C4KwqvBy3+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F31C7EE30;
	Wed,  2 Jul 2025 01:18:44 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 02 Jul 2025 09:18:42 +0800
Subject: [PATCH] Bluetooth: hci_core: lookup pa sync need check BIG sync
 state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-pa_sync-v1-1-7a96f5c2d012@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAPGIZGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwND3YLE+OLKvGRdo7Rk87RkyzRTS6NkJaDqgqLUtMwKsEnRsbW1AGv
 pFS1ZAAAA
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751419122; l=1160;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=GHF9U6GehkWVyzq0OzaU+JceT54aR44ovVM4Bx+2rpk=;
 b=eXovFOziL0YnMbRRQ5YVkV12C93VSCnu6TecapyGQ2OjfXYA8mgRc/OPiy0TVXdTOs0FztD/E
 qjG/4wvabekCKCj+qnJaf73QtkMQbVoB6oNjkiZn2XkfU256Ep1Eq37
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Ignore the big sync connections, we are looking for the PA
sync connection that was created as a result of the PA sync
established event.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 include/net/bluetooth/hci_core.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3ce1fb6f5822..646b0c5fd7a5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1400,6 +1400,13 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
 		if (c->type != BIS_LINK)
 			continue;
 
+		/* Ignore the big sync connections, we are looking
+		 * for the PA sync connection that was created as
+		 * a result of the PA sync established event.
+		 */
+		if (test_bit(HCI_CONN_BIG_SYNC, &c->flags))
+			continue;
+
 		/* Ignore the listen hcon, we are looking
 		 * for the child hcon that was created as
 		 * a result of the PA sync established event.

---
base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
change-id: 20250701-pa_sync-2fc7fc9f592c

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



