Return-Path: <netdev+bounces-278950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOyEJEiQ4GmsjwAAu9opvQ
	(envelope-from <netdev+bounces-278950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:31:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC76F40B0EE
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABC34300EF7B
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC69381B1B;
	Thu, 16 Apr 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/hLLrjx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58214324B23
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324472; cv=none; b=j61mDPJMoNDNu1eziFzvNk/Y9fW8Lte2gx5XyVFiAirORgjqX0SJVXADM2fwfY3GnjwlUFQrSiUs2TBmbCaQxfjDsg/bbADhkJZK0W+VFEpiiGQ4j9eUnoXFyaYKNZeLCZqI2U6kn36GBudCqIWfIv98lvkG7SUEzp5RiFuce/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324472; c=relaxed/simple;
	bh=mJpU45QimDn5hC6G2LUQKcDSNMK6k2YS8eyW01woreA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hDaFdRqmdnzLAdVmRcfdMiGGZtEDYVBnShT3oHFe9P8vwPokTnzFaxDcJ67iYgL6P8Bw8BbLuEp+3EPh6ZjWtMrK3hx4CCcYTmtgsIPrasmWCo68jEfbb6IES7Sr3n8GgR7XEzVqg4WxilgjqnWQGYfxeoWAS73Paf9i/eeB3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/hLLrjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A282CC2BCB5;
	Thu, 16 Apr 2026 07:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776324472;
	bh=mJpU45QimDn5hC6G2LUQKcDSNMK6k2YS8eyW01woreA=;
	h=From:Subject:Date:To:Cc:From;
	b=i/hLLrjxuanYYYEH1jbzdlaUiozopn8AI/z7i7q0nN8ttc5fZWadm2FHnw4R7MTFT
	 Xb+lJMDfGOscV1EbDc3mL6v67cyF/kbxDN57lAhnqhTiXEnCBOHKFFyLuAzbYj8Yft
	 0jx27iGrcj7rLVmERMKHtHlB9KapGQczj8EnLRHBV6rd/t747ML1/cmHBtQoWvOfF9
	 kwMv/N6q42gJJlsJGj43lxj6v2mUKW303OIs4ZQlsQin1iSLj4KszxYgw+1geFWngM
	 XYQljeAQrbwIQVcz0E1iR2pP/orKnX0xwaGcnF53Vx5O2E/F8UFCqTTQW+b7WLK+bl
	 Q2yTFXyddHb9Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net v3 0/3] net: airoha: Fix airoha_qdma_cleanup_tx_queue()
 processing
Date: Thu, 16 Apr 2026 09:27:38 +0200
Message-Id: <20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-0-2b69f5788580@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WN3Q6CIBiGb6VxHA1QgjrqPlpjhB/KMlRQZ3Pee
 4yjOqvD92fPs6IIwUFE592KAswuus6nUOx3yDTa14BdlTJihB1JSQnWLnSNVkP11Mq0oP3Uq3F
 RwwQTYOsW7GHEp6IQ3HIASSxKqD5AmrLmitIB3VLZuDh24ZXVM83Tf5aZYorvggpqpKUg5OUBw
 UN76EKdDTP7pJY/UlmiSsEr4MIYwtgXddu2NyEPrIQ0AQAA
X-Change-ID: 20260410-airoha_qdma_cleanup_tx_queue-fix-net-93375f5ee80f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278950-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC76F40B0EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing bits in airoha_qdma_cleanup_tx_queue routine.
Fix airoha_qdma_cleanup_tx_queue processing errors intorduced in commit
'3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order
DMA tx descriptors")'.

---
Changes in v3:
- Move ndesc initialization fix in a dedicated patch.
- Add patch 2/3 to move entries to queue head in case of DMA mapping
  failure in airoha_dev_xmit().
- Cosmetics.
- Link to v2: https://lore.kernel.org/r/20260414-airoha_qdma_cleanup_tx_queue-fix-net-v2-1-875de57cc022@kernel.org

Changes in v2:
- Move q->ndesc initialization at end of airoha_qdma_init_tx routine in
  order to avoid any possible NULL pointer dereference in
  airoha_qdma_cleanup_tx_queue()
- Check if q->tx_list is empty in airoha_qdma_cleanup_tx_queue()
- Link to v1: https://lore.kernel.org/r/20260410-airoha_qdma_cleanup_tx_queue-fix-net-v1-1-b7171c8f1e78@kernel.org

---
Lorenzo Bianconi (3):
      net: airoha: Move ndesc initialization at end of airoha_qdma_init_tx()
      net: airoha: Move entries to queue head in case of DMA mapping failure in airoha_dev_xmit()
      net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()

 drivers/net/ethernet/airoha/airoha_eth.c | 42 ++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 7 deletions(-)
---
base-commit: 3f20012a3964f487ae1e9ff942e2f35d4e9595bf
change-id: 20260410-airoha_qdma_cleanup_tx_queue-fix-net-93375f5ee80f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


