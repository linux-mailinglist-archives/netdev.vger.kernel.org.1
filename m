Return-Path: <netdev+bounces-301153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BEu1I8hZOWraqwcAu9opvQ
	(envelope-from <netdev+bounces-301153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:50:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D22AD6B0DCF
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:50:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GeMjaTzn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301153-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301153-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 184F7300576F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B405C38331D;
	Mon, 22 Jun 2026 15:48:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9A1AE877
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 15:47:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143280; cv=none; b=acoW2DGjNKS7loox/QFh40nYagB2BlHXsVVVbEHsAtIHI186z5KViQU+XQDcMOZyGQ5o4VA7ogNlZyk5EhvHHDCB3N8oG8eRvI0EmVd0IhSEEHk8R3eKpSaT0sVewkO4QvUWXH4LU7aRcwTW8ob3+nixd+oMsmNiqFFAQCz30RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143280; c=relaxed/simple;
	bh=tjwHsQ3JuO5MW8OrHk8ZwcPo7zxRmAQtKL3Kqrxod14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNZE446IaYfmZfb0nYSgnNxHJ230Tt0SWgmRpTVaiQB7QWxZtMBHL3WxJi6QA/iCtRC90WgSttZq1JDQ9cYT9GQhsys0SGD2vDhsT44AV4uOi2SN/4A9pij0cv/a2JqcAYWR7UipZSYqsxrp0T9NqHv/AU1WCKH/yI4YrMsN02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeMjaTzn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074CA1F000E9;
	Mon, 22 Jun 2026 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782143279;
	bh=Wpy4lzE3RG5KUPtLc47QwbaKFfiCNp9hUF9TkEaHY3g=;
	h=From:To:Cc:Subject:Date;
	b=GeMjaTznLOVC0ADWr4fblahVTEsEkoeViupP+85UlY80gzCUo42egmdAe1JywQ9XV
	 4v6d+6P26JYXSHCFdiXdDupEDci289rFxYhaT2xO4SDqqTnEEU8MpdE1pct2HyoHRs
	 MdV4j7lxoLnMLXeBX1aWz7kMDHxr7OKq5j0Jj8FwiSz4/Kox9QaNUBTB98DtdhLFZy
	 Rj3aXPBEOiXvyRnKsVMdfCD4FGA9FuwKw61b9SmShupiDx/faSvftlw71rK11yaZ9P
	 99fTKk/juMlp5JS85fO9eeRlKLPJ2f8dKxJy8nzpCQTLIr0UiErRMIVr3cgGMiZTvx
	 U+qK0nAzs3BSA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: [PATCH net] eth: fbnic: fix ordering of heartbeat vs ownership
Date: Mon, 22 Jun 2026 08:47:53 -0700
Message-ID: <20260622154753.827506-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301153-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuba@kernel.org,m:alexanderduyck@fb.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,fb.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D22AD6B0DCF

When requesting ownership of the NIC (MAC/PHY control), we set up
the heartbeat to look stale:

  /* Initialize heartbeat, set last response to 1 second in the past
   * so that we will trigger a timeout if the firmware doesn't respond
   */
  fbd->last_heartbeat_response = req_time - HZ;
  fbd->last_heartbeat_request = req_time;

The response handler then sets:

  fbd->last_heartbeat_response = jiffies;

for which we wait via:

  fbnic_fw_init_heartbeat() -> fbnic_fw_heartbeat_current()

The scheme is a bit odd, but it should work in principle.

Fix the ordering of operations. We have to set up the stale heartbeat
before we send the message. Otherwise if the response is very fast
we will override it. This triggers on QEMU if we run on the core
that handles the IRQ, and results in ndo_open failing with ETIMEDOUT.

The change in ordering doesn't impact releasing the ownership.
Both ndo_stop and heartbeat check are under rtnl_lock.

Fixes: 20d2e88cc746 ("eth: fbnic: Add initial messaging to notify FW of our presence")
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 0c6812fcf185..283d25fae79e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -526,15 +526,10 @@ int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership)
 			goto free_message;
 	}
 
-	err = fbnic_mbx_map_tlv_msg(fbd, msg);
-	if (err)
-		goto free_message;
-
 	/* Initialize heartbeat, set last response to 1 second in the past
 	 * so that we will trigger a timeout if the firmware doesn't respond
 	 */
 	fbd->last_heartbeat_response = req_time - HZ;
-
 	fbd->last_heartbeat_request = req_time;
 
 	/* Set prev_firmware_time to 0 to avoid triggering firmware crash
@@ -542,6 +537,10 @@ int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership)
 	 */
 	fbd->prev_firmware_time = 0;
 
+	err = fbnic_mbx_map_tlv_msg(fbd, msg);
+	if (err)
+		goto free_message;
+
 	/* Set heartbeat detection based on if we are taking ownership */
 	fbd->fw_heartbeat_enabled = take_ownership;
 
-- 
2.54.0


