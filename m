Return-Path: <netdev+bounces-286393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO7UHRrdAGoZNwEAu9opvQ
	(envelope-from <netdev+bounces-286393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:31:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C650600B
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CDFE3035B45
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA200336EC0;
	Sun, 10 May 2026 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6P+tnmM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF632B981;
	Sun, 10 May 2026 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778441353; cv=none; b=WHgeVakbnI412ycSE1gI0qHcIKuI8IYDbUTqxIFX5kkEwGDbgNx4m0QgbU54yOvJkglniR92PFAPvUaikd9YSGqKFfd6erWPGhqUnnxvdbK6iAEtEl5FD1+Y1X0/hi5Q79F7Ef2bjt1GO7JUjovoNn6rDaWI58LscaXU+vl6FlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778441353; c=relaxed/simple;
	bh=JvNyEbh41HYFaOv4iFYiw4mAj3tBYLXtwmQhcwABHqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N//0y8StAEtRSRI+LtkSPU/2y3TMQH0BrJB5rGTnIy1hYheymCgg5lJno+7BmUyCBRJCEj4rz19apHA6bWXzUAE85c5bo45LNCLJo3uTDIPbOcAguBrWYuhOtXPssCccsBr3wIn26D6U25v+KxQfWPIIH0Z08q/w2Ak/z2iCKxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6P+tnmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C74FC2BCFD;
	Sun, 10 May 2026 19:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778441353;
	bh=JvNyEbh41HYFaOv4iFYiw4mAj3tBYLXtwmQhcwABHqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6P+tnmMR8SQOOm+EhDyZ1ulF5b6FFYb+iC6pfA/TKeZPWXGLF7PkAXUFBLI5Iqhy
	 QRD86UmugBMEI+3rs+u+i0xHKEVDyp40BOckHlp3UVpfLgJ7RW2CgyhS0Xt7oUaQ52
	 KEUBdFIXtsvUZBAmB09P3iPxax2TYuaD29AXFoXKL2/L8+1HtqtZEvbNSwKSNpyezz
	 hWnXdkwZHzEt+can+sc5qGoG/BdXtRJXT6wotvlcN4HM4DNENZbE7f4xyZqbmOEwkq
	 hQiwwR2P5uDmqVpbeFgsU/7b3//1/uHmt2XNPTXQcMz4t+awgB9OMoGCbUnOkyZqkB
	 JE0YK+NszDFyg==
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
Subject: [PATCH net v2 09/10] net: shaper: enforce singleton NETDEV scope with id 0
Date: Sun, 10 May 2026 12:29:03 -0700
Message-ID: <20260510192904.3987113-10-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510192904.3987113-1-kuba@kernel.org>
References: <20260510192904.3987113-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0D6C650600B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286393-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The NETDEV scope represents a singleton root shaper in the per-device
hierarchy.  All code assumes NETDEV shapers have id 0:
net_shaper_default_parent() hardcodes parent->id = 0 when returning
the NETDEV parent for QUEUE/NODE children, and the UAPI documentation
describes NETDEV scope as "the main shaper" (singular, not plural).

Make sure we reject non-0 IDs.

Fixes: 4b623f9f0f59 ("net-shapers: implement NL get operation")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index eb049847fed6..4ae3ee6764a0 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -482,6 +482,12 @@ static int net_shaper_parse_handle(const struct nlattr *attr,
 	else if (handle->scope == NET_SHAPER_SCOPE_NODE)
 		id = NET_SHAPER_ID_UNSPEC;
 
+	if (id && handle->scope == NET_SHAPER_SCOPE_NETDEV) {
+		NL_SET_ERR_MSG_ATTR(info->extack, id_attr,
+				    "Netdev scope is a singleton, must use ID 0");
+		return -EINVAL;
+	}
+
 	handle->id = id;
 	return 0;
 }
-- 
2.54.0


