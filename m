Return-Path: <netdev+bounces-295674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GHd5G1p5ImowYAEAu9opvQ
	(envelope-from <netdev+bounces-295674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:23:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB87645EAB
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:23:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=LcIl2QsH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295674-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295674-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8FFF3041C4B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9CA47885F;
	Fri,  5 Jun 2026 07:20:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB51477E55
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:20:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644019; cv=none; b=Awuu/mSmz7qB+5e4VRGfyZAdz1SrNz5BQud3x/46Sm1aI1BNsdSReNyc33tB9gHIG/WK0GFBsKmhIE6WEqASdZHIf1dGVxaqdKksAss6F6vyzpn7vG1yGGU9ur28Hv0NHj6uVTYtm8fIwFyBKKR9EFrx+GedvaxP4WzafWTpuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644019; c=relaxed/simple;
	bh=qOy5vyj/Q7mif6y9Lx7vVzDyg4xSyuSntkGXCGN/zPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osVqNeVldwwU2ttxGNTPI96rmmxCx9TYa9Wt/4Xc72VB8LcwffC4ZXuuHI2Ksj9ey14PmOBndK3yYloNxRq9mdsVgDmITHo83nWmqlFAWn0DrDcsq+gKo93dH0WlFYzh3isJCdr4kpU/B77b0v2sdOYgwVSSIawlxlWHgMFTyLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=LcIl2QsH; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Z3e0PI28LeGcMYG8odw5Z/Z//UT2Tl+ozm0Mg/7nqE=;
	b=LcIl2QsHTdsLYxV/GZ5xPeL2W2u0vR4HHxqSzoAsROkZZqSU+qzUFsBeT/NfSvYIwNWt7m
	qbIbDlBVGdipyNX0d689qoitud/P1z9XGQgqGSIWvoGebFEoF/y8BXQ7TY2Qy62Gs/Iuy3
	oOqEkxjcUKh2U3dQoAPy7WX9sOoSYvyFQ05QEAFRAH5/uifRNwdopc/007UHK/y/geS4aT
	KPgHu+HFNJlYxQA9SGQtKoDnbuU3/MxDZHEbwCEPPvHkCo/I9f6m18bq1UqNY4b8XldSG8
	XnBqNgIsr13vWUDaozQ0mGjd+DMpoytRB9fVFzmCfWOa36AgJkfnSN38HF0uOA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 05/11] batman-adv: document cleanup of batadv_wifi_net_devices entries
Date: Fri,  5 Jun 2026 09:19:59 +0200
Message-ID: <20260605072005.490368-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295674-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,simonwunderlich.de:mid,simonwunderlich.de:dkim,simonwunderlich.de:from_mime,simonwunderlich.de:email,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CB87645EAB

From: Sven Eckelmann <sven@narfation.org>

It doesn't seem to be obvious how the entries from the
batadv_wifi_net_devices rhashtable are getting removed before the actual
rhashtable is destroyed. Document the idea behind the process and which
steps are involved.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 04b227ec80525..e2c85bd8dbb53 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -1185,5 +1185,9 @@ int __init batadv_wifi_net_devices_init(void)
  */
 void batadv_wifi_net_devices_deinit(void)
 {
+	/* just destroy table. entries should have been removed by
+	 * unregister_netdevice_notifier() and the corresponding
+	 * NETDEV_UNREGISTER events
+	 */
 	rhashtable_destroy(&batadv_wifi_net_devices);
 }
-- 
2.47.3


