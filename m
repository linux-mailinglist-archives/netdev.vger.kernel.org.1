Return-Path: <netdev+bounces-284621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC0JB4mG+mlKPgMAu9opvQ
	(envelope-from <netdev+bounces-284621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:08:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C55FB4D4EC9
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2678B307CD92
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4D823D2AB;
	Wed,  6 May 2026 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLtRusa8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC98723536B;
	Wed,  6 May 2026 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025999; cv=none; b=EJTQuAeLb+NolDWEyP644edTn+T7kF2ZKnmdh7Gn2wZoo9KW1T21HMOhvLLawmtT1YafjZSRpgIPEUK9+P5drFlLqBIInwWRvNN4D4z5iJHcMAmAPQigvWfWYWvOrH8OjdKH3G6IBG91J2rZmfXxukRh3K0ME5icQC3a8AcRzEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025999; c=relaxed/simple;
	bh=LOaSS2AvCnnU2yYaQPvEYtzS4qDc5yKU9TVBMhjpPhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXZ/PeuKbHk+KuF4F51KEoG9GfzdmtvYmlPwjYnmLP0Y1LFI1TS/81UJOP8xsdMm47REq6++6rOIgd4bVHk1ubrxvqBQn24+xQ2vXs7VhMCiGop6+NN5hmW9OtnCAgshK7S21Xbe+CsdAmOqd5rB/TyETvHgDUJcccVhIqqX+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLtRusa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCC5C2BCF4;
	Wed,  6 May 2026 00:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778025998;
	bh=LOaSS2AvCnnU2yYaQPvEYtzS4qDc5yKU9TVBMhjpPhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLtRusa83qNa9G3T0WLOBjMirg4hFuj4hFPSzQ2PEz+Recz8n2G/sBIY4UWjG60yx
	 bFRsVrE9rIx8rwmncBfxrbFKtZHcLWbAyEdFOaomRS2nuL1yu25E9rLrJBvS7paEqJ
	 HPuqkELqSpMwcIm5JWsmg2tla2PsivNLn5Yx7DkF/Z73HQe2jj3oKTv0VDqUK2YQuW
	 scnxexeL4uZc4Bdbgs2/H8TmluqMCvHwdVQUT7iSHUJREZaeto+eyGe7JmHg+87ZcG
	 dwR/F8/Wg56Cb8p10i6idPDm5+mJjwney5/FfmAKgiCukHfMbj2Tme6Dc+sQofTy8n
	 c93J6B3ecjgWw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 11/12] net: shaper: enforce singleton NETDEV scope with id 0
Date: Tue,  5 May 2026 17:06:27 -0700
Message-ID: <20260506000628.1501691-12-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506000628.1501691-1-kuba@kernel.org>
References: <20260506000628.1501691-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C55FB4D4EC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284621-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The NETDEV scope represents a singleton root shaper in the per-device
hierarchy.  All code assumes NETDEV shapers have id 0:
net_shaper_default_parent() hardcodes parent->id = 0 when returning
the NETDEV parent for QUEUE/NODE children, and the UAPI documentation
describes NETDEV scope as "the main shaper" (singular, not plural).

Make sure we reject non-0 IDs like we reject out of range queues.

Fixes: 4b623f9f0f59 ("net-shapers: implement NL get operation")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 16bf24d9e3ca..2adf8b0e1105 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -535,6 +535,13 @@ static int net_shaper_validate_caps(struct net_shaper_binding *binding,
 		return -EOPNOTSUPP;
 	}
 
+	if (shaper->handle.scope == NET_SHAPER_SCOPE_NETDEV &&
+	    shaper->handle.id != 0) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Netdev scope is a singleton, must use ID 0");
+		return -EINVAL;
+	}
+
 	if (shaper->handle.scope == NET_SHAPER_SCOPE_QUEUE &&
 	    binding->type == NET_SHAPER_BINDING_TYPE_NETDEV &&
 	    shaper->handle.id >= binding->netdev->real_num_tx_queues) {
-- 
2.54.0


