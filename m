Return-Path: <netdev+bounces-254430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AYuDI9kemmB5gEAu9opvQ
	(envelope-from <netdev+bounces-254430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:33:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82817A8306
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27C3E301693B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBEF36F41A;
	Wed, 28 Jan 2026 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWiv1gyH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C353374163
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769628781; cv=none; b=aUn1exHCsXVbd1Odldj2PT1XPnLzsiQddByZBZYx5e/RafHYBVN6cbQsyTzuWYdQafQMyEzByjU2eK6gxO0NouSkPsmhPh0dCbLSLiawCvfp8lWAaVK7Cyuhps0FZzM4Ddyno65NiZKwcn241DyUTuNEkgHVwHd/vlwRm1Qk8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769628781; c=relaxed/simple;
	bh=G8YHg97+CgT7u4jgOWI5eKvDBhJCbfNlbdJ/ZSDFF9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5GKE9eqBiUN9YVbjp9LSAyPQTPYrukpBaNw0Awd+HpTRcspjH47KssGb/Xk18UyjEdl2JAruutGT1NxnXHmn/QUaeE3suh6Z76v+GQii6/P4YUL0MZNpWs3Qmir3IbR7X+saRd4JhkCdFQEOYGqHLTU0jpgHQTkHKJztbGfxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWiv1gyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06DDC4CEF1;
	Wed, 28 Jan 2026 19:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769628781;
	bh=G8YHg97+CgT7u4jgOWI5eKvDBhJCbfNlbdJ/ZSDFF9E=;
	h=From:To:Cc:Subject:Date:From;
	b=dWiv1gyHDQry2lf+mc7gtDZJFGyt6Wwr1m4tXUHl2aTMpc5NGVLvhTPRtQducoPOT
	 tEHXuAu3MPa13EQFzLuki4NPK8mT6uMYrtUE8lKC1CXVXdaeZNYcBsNx+u5uoEiLwl
	 ewLmodiMXPsEAAIqLm/V63a0/LOk7r+xzlCaXatNTWTdaZr+ZDPxz50ebFx3z1dJ1I
	 MOSPAeD5E+ZpaY9+KUz+LFohX7VNm3i7HZk/g32Nc5zKLd0z2ZKISw5K0F5sOg+4RR
	 MG82cOk/lCqD6AEmhG3d6KT/54ivYmhPBHpvYmWc66UfozQmElbiT+HIuqxUnunl6F
	 SfYERH0fAw8QA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	asml.silence@gmail.com
Subject: [PATCH net-next] eth: bnxt: make sure we populate the qcfg defaults on old FW/HW
Date: Wed, 28 Jan 2026 11:32:58 -0800
Message-ID: <20260128193258.125274-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254430-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 82817A8306
X-Rspamd-Action: no action

The driver now depends on the core to tell it what the rx page size
should be for the agg ring. We must populate the ndo_default_qcfg
callback even if we don't support any queue ops.

This fixes:
  Oops: divide error: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
  RIP: 0010:bnxt_alloc_rx_page_pool (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3852)

with fw version 225.1.109.0.

Link: https://lore.kernel.org/20250421222827.283737-20-kuba@kernel.org
Fixes: f96e1b35779e ("eth: bnxt: support qcfg provided rx page size")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com
CC: asml.silence@gmail.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8fc0720c3057..466e0fc6141f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16316,6 +16316,7 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 };
 
 static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops_unsupp = {
+	.ndo_default_qcfg	= bnxt_queue_default_qcfg,
 };
 
 static void bnxt_remove_one(struct pci_dev *pdev)
-- 
2.52.0


