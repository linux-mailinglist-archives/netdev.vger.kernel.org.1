Return-Path: <netdev+bounces-293739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePOZNrx/HWotbQkAu9opvQ
	(envelope-from <netdev+bounces-293739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:49:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 494F361F882
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29673300951C
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74BB37C11E;
	Mon,  1 Jun 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="Z1ZFqRCf"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369043793AC
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317413; cv=none; b=njlI4ScSRO3qlUO8/ndATuXrfm+5YUAYk0S13kpSWExB7Dks0D+EvyYz8YrE/WLVdptJ5UhGBorFHNozrrNlaqskVJZkVKPbuh4jCCThuPhtXcGLoeXjKzgo5uqWdwqp7nB9Xln26qGdB+X+bxYwRFOE4yj2HXYUVy0rlTinB5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317413; c=relaxed/simple;
	bh=qYhPMsjys/cS8XDt1EyRHcNqtI+pMRzAdBxQ+KRqYas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFk5f+FQCDVM1RndTmUDyCcF5xMEeQ6FM+s0tgg/ugOquSPbRJSCNs/VvWBfcwaWjuKQuUf3ouz7/ePnY8l6V2RN3bUtOkLRBe/77wg3iyyKkpIM+C4zwCDjtqrQi27UgVXO3Gy+Gcw4RJD/4fBoOz8U4vI2Y17e5ED8fl5QK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=Z1ZFqRCf; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/EL+qJ6WKHkjBQeLQM+rO68NQsJGkz6Soatl6PUjU/0=;
	b=Z1ZFqRCfm3iRNubQWgFchAw3a+Q4BDDbE6kxXMJRWgHDFmbuEnA0mEdLEEgqBDGQvd/aob
	gVVirkCIPaZ8c2gkIN6HbsxmvdQw1olmag2PIB8j+h9gmgAtzLANfpNgDOwH/N6wdtd4i4
	j1tcRpLqvojUQZaD//y2arZ6Yikk59pjRfGZwhqgs4BcIaF8bSFRiXI+db8pdmqDZKUSsl
	WTgcX8uWFQjhO/FvkPTHSeMgexx6kcYfIRzCLA+EIsMM8EVCBf6jeEyDJzVrogNhGpj9Nr
	lQWqLQyi+2M9IiOi4Th872bguTKMMjT2+Pl4XrSN+boT/witeFD4taAf3sZDKw==
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
Subject: [PATCH net-next 02/15] MAINTAINERS: Rename batman-adv T(ree)
Date: Mon,  1 Jun 2026 14:36:16 +0200
Message-ID: <20260601123629.707089-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293739-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[open-mesh.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,narfation.org:email,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:dkim]
X-Rspamd-Queue-Id: 494F361F882
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

Replace the batman-adv tree name "linux-merge" with "batadv" to match the
patch prefix convention used in subject lines (e.g. "[PATCH batadv 1/10]").
The previous name "linux-merge" was ambiguous and was not suitable as a
easy-to-recognize prefix. Routing of patches to net-next vs. net remains at
maintainer discretion.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1d2a924d53dc..741fb4166aa2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4440,7 +4440,7 @@ W:	https://www.open-mesh.org/
 Q:	https://patchwork.open-mesh.org/project/batman/list/
 B:	https://www.open-mesh.org/projects/batman-adv/issues
 C:	ircs://irc.hackint.org/batadv
-T:	git https://git.open-mesh.org/linux-merge.git
+T:	git https://git.open-mesh.org/batadv.git
 F:	Documentation/networking/batman-adv.rst
 F:	include/uapi/linux/batadv_packet.h
 F:	include/uapi/linux/batman_adv.h
-- 
2.47.3


