Return-Path: <netdev+bounces-294102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHEsIqqkHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:38:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A9162BB06
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FDE13010160
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AD13A6F00;
	Tue,  2 Jun 2026 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwaT2Zak"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D12248A8
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392087; cv=none; b=N2Iw8w7QCcrytfcvYrus6yG4a7RAYWtOCJ9kb9PrDWSePZ5DSTvr6rzdUnOXMQPcLP93gqxHYcVJa/gMGCjaFaNdQGHFdtLcUwVQLFS5PdQm5aM/lX3T3owiSFMm6Rp4o0zWKvjXpQHysCBkjbkt5Bx1yoD5I4y5iE+YBCJnR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392087; c=relaxed/simple;
	bh=YkRhPX1T77GGnpNp5auC+ynU716H4B1GTk1n4UcEyog=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Iyy66hot5wcMB0LwbomA4/C6u0xRwSiTXm4SHUEjUwyU2iThHdJQ6QpD6zUqijPriBWYMEN6Xu1J6q6k9b/MRz7ih6y13vxA9sCCdzOxSzlHTInDsivWFaTEAsTCYKpArqjCLgTvQLp/aZwPOAwKinlXY8B9RdvFV82+MKa+vhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwaT2Zak; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54841F00893;
	Tue,  2 Jun 2026 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780392086;
	bh=nLejDTCOcMkRPsxQm6RvL7N4wsY+oJtksd9yx89mHIE=;
	h=From:Subject:Date:To:Cc;
	b=HwaT2Zak7T3OM56w8Fb8w6vuygKxoxQx7JNJLQW7hL7BB5NO7CG4Y3FRotDKIs+/P
	 zf6VJXCeTBmsvK9wmocDCBWVxo1s2o/yV0CxlfCpUgjcn9kbbl4KDnvZ1LU9LIkMD+
	 hGll6FmHgtBuD4feOT2jGxbE5S5VwwAcIb73bOA5GnFybbX29ondIUi7aHXhOaJ5VZ
	 P7Gnv0RSYoJKMxblpXeieNLCJnlLxiH/9yB9xMI3+nxm5QGN0DoaSHNoctEznsZVG7
	 1l0tu40HghTv5Ze60bYpicQI3SX3rDhtF13lsHIYfu9dQJem93w7HAKl7yTYERO5bO
	 c/zeri8lSTU3Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net 0/2] Fix use-after-free in metadata dst teardown in
 airoha_eth and mtk_eth_soc drivers
Date: Tue, 02 Jun 2026 11:21:03 +0200
Message-Id: <20260602-airoha-mtk-metadata-uaf-fix-v1-0-3aaa99d83351@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MywqDMBBG4VcJs+5AkorQvop08ceMdSheSKII4
 rs3uPzO4pyUJalkepuTkuyadZkr3MNQP2L+CmusJm99a1vrGZqWETyVH09SEFHAGwYe9GAJ9hk
 Qg8OroXpYk9R837vPdf0Bfu9zJ20AAAA=
X-Change-ID: 20260602-airoha-mtk-metadata-uaf-fix-eb03badb1a94
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Florian Westphal <fw@strlen.de>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: D5A9162BB06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294102-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nbd.name,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

airoha_metadata_dst_free() and mtk_free_dev() call metadata_dst_free()
which frees the metadata_dst with kfree() immediately, bypassing the RCU
grace period.
Replace metadata_dst_free() with dst_release() which properly goes
through the refcount path and runs call_rcu_hurry() if refcount goes to
zero.

---
Lorenzo Bianconi (2):
      net: airoha: Fix use-after-free in metadata dst teardown
      net: ethernet: mtk_eth_soc: Fix use-after-free in metadata dst teardown

 drivers/net/ethernet/airoha/airoha_eth.c    | 2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 3522b21fd7e1863d0734537737bd59f1b90d0190
change-id: 20260602-airoha-mtk-metadata-uaf-fix-eb03badb1a94

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


