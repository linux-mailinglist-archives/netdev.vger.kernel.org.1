Return-Path: <netdev+bounces-293269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OCOFGH+GWr80QgAu9opvQ
	(envelope-from <netdev+bounces-293269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:00:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C6A608C0B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A29F301F18B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831A4218A3;
	Fri, 29 May 2026 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDsLiu0v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2F42188B
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780088157; cv=none; b=PjNAdZcQjZa+5UyQ6PVrj/xUVA/AOJNj4Lkg0TuaUDReUGKnzjhSbFVIpptd+SSB3cpP4NN/Y+I54RwXAHNq3bS+hhX21WdmmI7ORr3vbrKaCPMtp5fhmgoB7YptiEd/cqJI1KnKKfYXDYWnwrNym9O85P/uQrbPKruHnuU5l4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780088157; c=relaxed/simple;
	bh=tDu+JlZtWks3zbmKmpbPEJTbU4WU3lKE8/R3mrKg+cY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thZbkHHucNOzyf7+3Egp/5QJCjEAjdURE8Zwb+daxLcmGnuwsEovB8MUKhsdu4TooXqpSQpjEWhWu4hAIZP/QJt0S0pKOMTWlc6m7gUFTYwLpU9YAx0EaNz9jeaBGCSdOcAmIjP7Oz3ikQu7uLMpXcBUxMsZk3KCUeao6Hmk/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDsLiu0v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FCF1F00893;
	Fri, 29 May 2026 20:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780088156;
	bh=y5TxmfosNSve2lvK7qv9fqMXYuparmcRTluqTvdcjng=;
	h=From:To:Cc:Subject:Date;
	b=KDsLiu0v5DNOS2U6ApigMe6uivxzA30adOa6PlW5ZINDo6WnNzVcJS1Bq5u8hHkb2
	 FVQXZLUFW3M/RLePFAtauPjfRHR0BsJ5anS60inyAXY3uFYU3EXyWncCu0g/TLzhAh
	 sNq2Qq5/KDltwDCy7HUDE4Capqz9xwnDxQhgPHLk9ep9T1RRfMSAMR8VOpfqCsgNO3
	 O66rSl1kBYm6WkZCuZ096KUam4xvxY7ncirRH87Zr4GNr2gJyQ+wwY2GSkMKeSDtXi
	 VE90o2SKkrZ6F+qYKMl3fr6nNlUty9sGRypIeFQqGfYa4Uy7IKl3CqszGSvN4jxwAl
	 kJvO993oxq+ng==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] eth: bnxt: disable rx-copybreak by default
Date: Fri, 29 May 2026 13:55:53 -0700
Message-ID: <20260529205553.999672-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293269-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A6C6A608C0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rx-copybreak requires an extra slab allocation. Since bnxt uses
page pool frags and HDS by default, the rx-copybreak doesn't
buy us anything. The extra pressure on slab causes overload
on pre-sheaves kernels on modern AMD platforms.

In synthetic testing on net-next this patch shows little difference
but I think copybreak is "obvious waste" at this point.

Default rx-copybreak threshold to 0 / disabled.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 61c847b36b9f..044084af2254 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -36,7 +36,7 @@
 #include <linux/firmware/broadcom/tee_bnxt_fw.h>
 #endif
 
-#define BNXT_DEFAULT_RX_COPYBREAK 256
+#define BNXT_DEFAULT_RX_COPYBREAK 0
 #define BNXT_MAX_RX_COPYBREAK 1024
 
 extern struct list_head bnxt_block_cb_list;
-- 
2.54.0


