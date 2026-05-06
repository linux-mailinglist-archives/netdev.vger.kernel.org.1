Return-Path: <netdev+bounces-284617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMQaHzKG+mlKPgMAu9opvQ
	(envelope-from <netdev+bounces-284617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:07:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C57C4D4E65
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 196C23029831
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE6820CCDC;
	Wed,  6 May 2026 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moAB/Yd/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB82E17C211;
	Wed,  6 May 2026 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025996; cv=none; b=RZWHBMaUEPJXTUAQI8DEZXwLpP2QPu7IVBo8ht903XatconFf5SKll3dr2uJCn7j/4Z62jJSyI3557B28hyh1FEXnX7KnFaoqpruK4ZfAw4dMWB7HFm6vhMf1QBIkB6I/0pmTvcMZ1mvz62igenVd9sI9iJ3/uJdxRfq8uYBwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025996; c=relaxed/simple;
	bh=HW4j8RIwQMHjlgP70X73zITBMns5lhV/KAwLvg2KN5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKGSIdduwNgh9V3LN0N8XVYAs00ykPIWvmvRt923ro2SjQs+9aT1v1I4tnWkmxv/Euns7i3qjC+XMFVOMUH5OJgh3pIcZw5nNmRh4fgRzD07HLeA8uOY9EJhBh36rD9kPvDepa8dlKAeqOgim9nOjjsO6cYZdThD2sCEj1IPhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moAB/Yd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BC4C2BCF6;
	Wed,  6 May 2026 00:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778025996;
	bh=HW4j8RIwQMHjlgP70X73zITBMns5lhV/KAwLvg2KN5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=moAB/Yd/NZGuZehjg8hPpyzcl8RMpUpXK4N9hy5a8d6h1vGAMQA+LU8/0AoHvYh+k
	 9O1y9rSCyMT2n3I7RgnkjFQ9xOcLF/bmaLayGhvd8BYDSt0ngUBJ/+sVtKkean5dj7
	 zpP4LlLjxTp8dv/aPPYKdDbRA0uDdKgSDI8fXC+ATVER4NDbLuKUbwky52prPzr3ds
	 kJreUaIlU7A1pIZkroxqlQ21w2GeFLAkG4ZkkJ7qIFvudR4WGC+Sp7dpnS3bq8EWhv
	 ARF2RI2SNdrEyF0mefw8/S61lMRqgrA+SFP/hAVKacSGlkOlW8aW9pfAvSX2suZ3Le
	 TYHD9+QbkIQQw==
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
Subject: [PATCH net 07/12] net: shaper: set ret to -ENOMEM when genlmsg_new() fails in group_doit
Date: Tue,  5 May 2026 17:06:23 -0700
Message-ID: <20260506000628.1501691-8-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 5C57C4D4E65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284617-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

genlmsg_new() alloc failure path in net_shaper_nl_group_doit() forgets
to set ret before jumping to error handling.

Fixes: 5d5d4700e75d ("net-shapers: implement NL group operation")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index a27673e5919f..2ba397fa3bfd 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1274,8 +1274,10 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	 * rollback on allocation failure.
 	 */
 	msg = genlmsg_new(net_shaper_handle_size(), GFP_KERNEL);
-	if (!msg)
+	if (!msg) {
+		ret = -ENOMEM;
 		goto free_leaves;
+	}
 
 	hierarchy = net_shaper_hierarchy_setup(binding);
 	if (!hierarchy) {
-- 
2.54.0


