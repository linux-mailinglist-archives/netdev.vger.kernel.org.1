Return-Path: <netdev+bounces-287687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIGQCLetBGoSNAIAu9opvQ
	(envelope-from <netdev+bounces-287687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:58:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8728D5378CB
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E98930B2A0A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E24C77BF;
	Wed, 13 May 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCpJxy3Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB81481FCA
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691033; cv=none; b=Gy02Y+xfH7n5bZdXN20QQAuQJi4CAAaI2C0G580ZkPAUgLJHn+tFAMnxZiyxBXp3yqTB6DfndiiwGgdlyDqsVN2BNd/aKXIPj/l/s8qGOBf847DK4kzcmJtfbBlRGfbM6gGGnoLE+rg7r9fM1XZsGn88esf4DhxT0jq7UPt5Hiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691033; c=relaxed/simple;
	bh=sw1Ea6QD/tQqsM6g6dqnWXK/fQZ92k8rIM4OdgbSqAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJT11FHAbOWqHEmt6OU1JyznJ5F/rMVIVutEddKIj8jeMc55nQsKOP/rkc72I4+GvGZZXw9ZO+PtpJmE3DCFoLpuG+Fkil5X9w5dy0rh18irm/e5LCcCXHqju53/KQBbBiQsLVam6HJWOEC4ofh3ozf07aNwS5luEQeSxkG7aQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCpJxy3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A31C2BCB7;
	Wed, 13 May 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778691031;
	bh=sw1Ea6QD/tQqsM6g6dqnWXK/fQZ92k8rIM4OdgbSqAI=;
	h=From:To:Cc:Subject:Date:From;
	b=nCpJxy3YrIjRJxCjGeB9QOe2fxy6JButyMTTCqWxovdZuZMIUG3JapztVVDlYb+GT
	 lPaAyDKYLkgEiFtdy0H7TTtZgx3HnXO0WxyBuDuE3oXvie+Aeidvsx+pN2pWIKnOtN
	 GZurIDbWnkwrEzZas864al1iQ9ql5NRTzXw5s5wtnDUlo48CDeqlVxau0ggscyzYde
	 f6mm2dseDfd00ScBK9aimN4392y6URbp1UZitNfzGnxqeaW3a41g7VAGNG7ybZBBbf
	 UZ6h35dImI7Hdjy8wsPoGKoIfhlDaK4lQrEVTedgF0GV/yJuYBh0ELKhQVje8Hcjqk
	 IazkLRIRv1ARA==
From: David Ahern <dsahern@kernel.org>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	David Ahern <dahern@nvidia.com>
Subject: [PATCH net-next] xfrm: Reject excessive values for XFRMA_TFCPAD
Date: Wed, 13 May 2026 10:50:24 -0600
Message-ID: <20260513165028.33171-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8728D5378CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287687-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

From: David Ahern <dahern@nvidia.com>

tfcpad is a u32, but that full range is excessive for padding.
Limit it to max IP length (64k).

Signed-off-by: David Ahern <dahern@nvidia.com>
---
 net/xfrm/xfrm_user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 38a90e5ee3d9..e8c31633f4f1 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -937,8 +937,14 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 				   attrs[XFRMA_ALG_COMP], extack)))
 		goto error;
 
-	if (attrs[XFRMA_TFCPAD])
+	if (attrs[XFRMA_TFCPAD]) {
 		x->tfcpad = nla_get_u32(attrs[XFRMA_TFCPAD]);
+		if (x->tfcpad > IP_MAX_MTU) {
+			NL_SET_ERR_MSG(extack, "Excessive TFC padding");
+			err = -EINVAL;
+			goto error;
+		}
+	}
 
 	xfrm_mark_get(attrs, &x->mark);
 
-- 
2.43.0


