Return-Path: <netdev+bounces-279265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIAXKTHz4Wmv0AAAu9opvQ
	(envelope-from <netdev+bounces-279265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:45:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9497A418DF3
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76EF33001CDC
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABB23A9625;
	Fri, 17 Apr 2026 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uODRvIfn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693022D4E9
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415250; cv=none; b=XohczgAbGy29e8sm5YkaYiyQLO+kgYh/0sHpfqIHNFc93c5QdIaNRaQIxRNMfVBSQOC1y0JNeJBY+N5SR94Z2y3PFsE6mcOUP5XL7kmxAK3WIAHZnQc8m+3Ty9FeLc0TyMuF3PnffsxXWl7FM3h8uB8hNUcHFqRgsCWRuPZNtts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415250; c=relaxed/simple;
	bh=22JN6Dq3EwTB9lMjfnyhyBhVNs0t2Y592P69k7lFa3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lRztjREg3+7+40c5+1pp/2J/vdkujS9AG0lVwh6vaVIMMQqWmNmjUxmp2RR0fdmojhzBGMJMXynsu37Kog52nnHEtuK8w1EgHpMuaK0TQRwc1l+UQDEhVPtrEiFA9hIBYytaEO2jZ4MZOZjEMQYC/nAu1agjaS0cG3i+Lfgi0is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uODRvIfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D93C19425;
	Fri, 17 Apr 2026 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776415250;
	bh=22JN6Dq3EwTB9lMjfnyhyBhVNs0t2Y592P69k7lFa3U=;
	h=From:Subject:Date:To:Cc:From;
	b=uODRvIfnQZxYFgNOy6P2Hhm2jjODYwvVYwkkO5ZHMZvpdcV4xD1UFt415qS0wJOJi
	 1BZdY0jYtISVNzt5OaN/CgCW65VZi5trwUb92Oixt8elvzKU0QMjTcATvfEpZDyr+8
	 OlwghzWhLlRiNipuWcgdSiE0GuAVMdmlPWo+rBWPpdnteBmh3ntYz2AuOT6wKCENJ+
	 yGxuIlHh4T9xkg6wLC8zY/Vilyq/wnyzWxZ5YP0wiB3TQRXUUkaRKPArBpovDi9kTI
	 Xojp3sU89DMv3VwzxdGQzhSkVAbq7y4PRUUlNWoTxOrmvEebxT/DxN4cHGOnKKoUxh
	 4QiXHEUCkuZnA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net 0/2] net: airoha: Fix NULL pointer derefrences in
 airoha_qdma_cleanup()
Date: Fri, 17 Apr 2026 10:40:35 +0200
Message-Id: <20260417-airoha_qdma_init_rx_queue-fix-v1-0-db9fa5e468e5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQ5AMBBA4avIrDVR8ROuItIMHcxCMS2RiLtrL
 L+3eA94EiYPbfKA0MWeNxeh0wTGBd1Mim005FleZYWuFbJsC5rDrmjYcTBym+Okk9TEtxqaYUK
 Lpa5qDfGxC8X8/ztwFKB/3w/ZiJZ8dAAAAA==
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279265-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9497A418DF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix two possible NULL pointer derefrences in airoha_qdma_cleanup routine
if airoha_qdma_init() fails.

---
Lorenzo Bianconi (2):
      net: airoha: Move ndesc initialization at end of airoha_qdma_init_rx_queue()
      net: airoha: Add size check for TX NAPIs in airoha_qdma_cleanup()

 drivers/net/ethernet/airoha/airoha_eth.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
---
base-commit: 82c21069028c5db3463f851ae8ac9cc2e38a3827
change-id: 20260417-airoha_qdma_init_rx_queue-fix-b9bfada51671

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


