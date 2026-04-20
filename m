Return-Path: <netdev+bounces-279674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHarDu3e5Wl8owEAu9opvQ
	(envelope-from <netdev+bounces-279674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:08:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D816542801A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC698300C0D9
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9C3859E3;
	Mon, 20 Apr 2026 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlMNJzI7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4ED3859F9
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672486; cv=none; b=EIODYSoED3TiKC4J9Or7zw531ULXNqO9d2L0ChYcBmUPX2B3kRThRB0UKgc+eGt60RsyNqOuMk2l6vzGnKrd+gwYQY2vt4tFOf2GzXg6FKXf/Wur2EvFUOspWeGwiLnxt7dWS4DuT1WClcg/mog6eTwUnc43BpQLnQrcrwxOn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672486; c=relaxed/simple;
	bh=0MlFO6P0m8/NK/SYcNlmOcWF1m2ZQhsuX9z7XL/3XC0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e8Pedi4hbeUMA/ka4Un4lg9ICN5NUHqNLNj+zNndR04G4DZy700JXjaM4+QZuryR17QJiG9xaNiGK2U4I6utMRMe6XEeASLdrN/pfp3uKJ4PmVsRpHFRdI/c84xgNegHBZHf3degwnQnUJoH1bYSBAru8riy9+Bg2m5v8ma9BSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlMNJzI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC22C19425;
	Mon, 20 Apr 2026 08:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776672485;
	bh=0MlFO6P0m8/NK/SYcNlmOcWF1m2ZQhsuX9z7XL/3XC0=;
	h=From:Subject:Date:To:Cc:From;
	b=ZlMNJzI7t0Y0qGiYo1CDXuQmn4Z9R5ZnKzV1cF3a8WLcnF6jN9IUeymCJEf26bo9f
	 54Zl2NwTEWKJhqVq2ZITZPoTi2M8Ji84oEjt3MXZjPKtUH0FYA1ANzz4dNa7JDYsBC
	 hpPCbiaTotKQH82YNRxEn+6kc3gtXfqkpsAb+v1ssf2GihHIHAlDmTftjwRVpLVvMB
	 Mr35MGZV39COFzv57XODIZkzVeWj+EIaMQEVCoonpkGJueu7ORqjbguxmyFIAM0WW4
	 xZEk/U1A3gznpIApYsWDaZ6Ew0gduJBWnyJUer+dG8tnLbNuL728dCGaVu+zvT6oa3
	 t8ZXtjaSBDLUw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net v2 0/2] net: airoha: Fix NULL pointer derefrences in
 airoha_qdma_cleanup()
Date: Mon, 20 Apr 2026 10:07:46 +0200
Message-Id: <20260420-airoha_qdma_init_rx_queue-fix-v2-0-d99347e5c18d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NWw6CMBBFt0Lm2xpKeIhf7sOQZrADTNRWpkAwh
 L3bsAI/z7nJuRsEEqYA12QDoYUDexchOyXwGND1pNhGhizNyjTXlUIWP6AZ7RsNO56MrGacaSb
 V8arauu3QYqHLSkNsfISiPvp3cDRBE+XAYfLyPT4XfUx/5hetUmXbusOC8vJCxe1J4uh19tJDs
 +/7D/h0LCLQAAAA
X-Change-ID: 20260417-airoha_qdma_init_rx_queue-fix-b9bfada51671
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279674-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D816542801A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix two possible NULL pointer derefrences in airoha_qdma_cleanup routine
if airoha_qdma_init() fails.

---
Changes in v2:
- Move page_pool allocation after desc list allocation in
  airoha_qdma_init_rx_queue()
- Move netif_napi_add_tx() after irq desc queue allocation in
  airoha_qdma_tx_irq_init()
- Link to v1: https://lore.kernel.org/r/20260417-airoha_qdma_init_rx_queue-fix-v1-0-db9fa5e468e5@kernel.org

---
Lorenzo Bianconi (2):
      net: airoha: Move ndesc initialization at end of airoha_qdma_init_rx_queue()
      net: airoha: Add size check for TX NAPIs in airoha_qdma_cleanup()

 drivers/net/ethernet/airoha/airoha_eth.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)
---
base-commit: 0cf004ffb61cd32d140531c3a84afe975f9fc7ea
change-id: 20260417-airoha_qdma_init_rx_queue-fix-b9bfada51671

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


