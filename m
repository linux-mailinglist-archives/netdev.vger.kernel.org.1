Return-Path: <netdev+bounces-164556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FF3A2E33F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 05:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E941E1662FC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 04:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131B014375D;
	Mon, 10 Feb 2025 04:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="ZbddG3N/"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04E2F2E;
	Mon, 10 Feb 2025 04:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739162870; cv=none; b=AJPQyiTwbZhlXtSEF/veerBZYfJ8I4bHKi8eBcrpvKMK8Iks24+QzpqIfBxcPlOLoryAQJVIDVqT1/2gtYdQiSDfk+eSqBra2kj8AiX1X8qxJ8iAU8e+W+fvk6G40dMIKnrCjuQogrFL9SeJTLyynzjv6buEXKTDzX6+1ybgo6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739162870; c=relaxed/simple;
	bh=1im/VCm5y7Sebw9X8ipwvqIuoQBYm0NNnURuN4wiqX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U0u0H7XH9plBJ+ScHU/sU4dqLeE//s0ZS58terA96ZX73XbJDlHAXJ52EtTA3Ht4nl4QTB+1FKU2GArbJhqfW8Sj8iCrcF08IiWG1dDpOjChX/TPYSJ63+fZeZhnj99TPbigsEPH8sT9T7jR3Eqf+Z7/unuL8eZ6hRWFHTw3JAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=ZbddG3N/; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YrsWb5T15z9sZZ;
	Mon, 10 Feb 2025 05:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1739162859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kca9LEECPrfswrWUPZvyaDxx4NwxuWzzj1p0ey+sgvY=;
	b=ZbddG3N/BTYKzAAA5ZktaEM8+SVH33OpkHm44p2UTTstODryRB9z96Ers+JBth2IIRR0nP
	7mpQbwYvLEkKwB5BMLRBNrYbvSMY3Dy1FUn4fxoz+h8BPcXQ47+B+Z9jXivqnLBHCH4CGm
	qjEhLeH/8GrNZJ/jgV02Z4feaIiHftjUH294MAD6s154vQdKmwGoauCS4E5dgTM7EXo7jp
	ktyoHEbmKxUQrTeNUAc1+ZvPsTXGb6sI0+CRRSONTtvIzRQp+xOMR4JUytPjKiGID+N1nZ
	mgCcR8wayDKWGb9q9BYM7/uL3VnmdWPe+TC40meQpj/EtLq6jufkSU5oGkJqhQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sun, 09 Feb 2025 23:47:24 -0500
Subject: [PATCH] ixgbe: remove self assignment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-e610-self-v1-1-34c6c46ffe11@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIANuEqWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNL3VQzQwPd4tScNF0L09TEZMM0g1RjYwsloPqCotS0zAqwWdGxtbU
 AdXCXNVsAAAA=
X-Change-ID: 20250209-e610-self-85eac1f0e338
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Simon Horman <horms@kernel.org>, Stefan Wegrzyn <stefan.wegrzyn@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=1im/VCm5y7Sebw9X8ipwvqIuoQBYm0NNnURuN4wiqX0=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBLOXNlV3JSZHR1eTEzalh4cE4raGJWYjk3ZjhQdWp4CjdQb3QvMW5iLzBzdU1XRlJt
 N0N2bzVTRlFZeUxRVlpNa2VWL2puTGFRODBaQ2p2L3VqVEJ6R0ZsQWhuQ3dNVXAKQUJOaDYyTDR
 wMm4yK1J6SEZENy9NN3JHZWd2VVdnMGlkckV3N3QvZXZYZlRiNDhveFhxeFRFYUcvL2ZPT1ZRRg
 pwZmJVdkxzMXUzek82NHVYVFk3ZHJ0Nlg5RzdxdExpdnQ0dzFPUUdpQjFESgo9dHpzWgotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4YrsWb5T15z9sZZ

Variable self assignment does not have any effect.

Addresses-Coverity-ID: 1641823 ("Self assignment")
Fixes: 46761fd52a886 ("ixgbe: Add support for E610 FW Admin Command Interface")
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 683c668672d65535fca3b2fe6f58a9deda1188fa..6b0bce92476c3c5ec3cf7ab79864b394b592c6d4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -145,7 +145,6 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	if ((hicr & IXGBE_PF_HICR_SV)) {
 		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
-			raw_desc[i] = raw_desc[i];
 		}
 	}
 

---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250209-e610-self-85eac1f0e338

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


