Return-Path: <netdev+bounces-286772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPakBfEWAmoVnwEAu9opvQ
	(envelope-from <netdev+bounces-286772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:50:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C6E513CB1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A31B30300DA
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5763447798E;
	Mon, 11 May 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cwn9ggLD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335034779BC;
	Mon, 11 May 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521769; cv=none; b=iOK7jD/FSQ7NwuIf0VzKSvIIQc9oUN+uebicWyOxedea1MzziTcfMh6Km3tlKkUaqwlJNnsVmDaU5bTGZmmRulr/5oQvU4KuR2yoKsAB8ofhjdKSDsXfkV/pV2uW4tGTyZVcFd3IBCftsDSkvHEtBLx9mRZqq7ywoFLpQhScQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521769; c=relaxed/simple;
	bh=LuGtlqw5vVLxLbc3qqnf2CeNPUGQ4Oq65Lm0HHnXG2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYGlIr0s4Pm8k6ANUrzJkpatM50gU5oJvU6VIHgqz1lcNEpNS5BSTL/wRxb29H9SSvKMK9s3JMNGnJh7L4jkEXJRUpLBR9ucOksurSIcYrWOPE82NRIWKegyQnDdVao6QJKJYx5t8Xmtv86579yBRn3tqvlhXQScEtuysafGaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cwn9ggLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C062C2BCC9;
	Mon, 11 May 2026 17:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521768;
	bh=LuGtlqw5vVLxLbc3qqnf2CeNPUGQ4Oq65Lm0HHnXG2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cwn9ggLDA4O+HNJpkjZJPoNQTOJNOnKr8tIUzy9hD6yJMJxImZznKQyrguSpG8oaL
	 W95YkyfkdtJcHjAT+CToVvUzWo01SknaZwBHnYvhc48wQEEqKgtnQfhu00JO5hovFh
	 IOZ5qjmktCVLagt/y5DVErYAQtjpFsCn0ouxviGS/wxK0Pmwx/DcdmDoo1z3IDCW8D
	 3r8DomcSqUAC2/+C+aV4lD++stUdc0LStx674gzW1pmwTaQ1KjS9A0JtkLj/k2gwvG
	 OCqH7rq68dOt7lRY0kpYkpaA19NVQG9mK367z0BId/+pGVehFogSZSnI4yVu0OjB8H
	 aSHrRqrYr7pOw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sd@queasysnail.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 4/4] net: tls: remove bad rollback and UAF on ENOSPC
Date: Mon, 11 May 2026 10:49:20 -0700
Message-ID: <20260511174920.433155-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511174920.433155-1-kuba@kernel.org>
References: <20260511174920.433155-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 99C6E513CB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,queasysnail.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286772-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

As explained in commit 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")
once we call BPF there's no way for us to rollback the iter
and copy data, since BPF may have modified the message.
This is regardless of whether BPF set up cork or not.

Remove the attempt to roll back iter completely. This removes a UAF
since BPF may have modified msg_pl and rec, so these pointers were
stale.

Note that I'm entirely unsure what the expected behavior is here
for BPF. Feels like this path must not be exercised by normal
applications / existing deployments in the first place.

Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tls/tls_sw.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 360f71fd7884..22b77840e35a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1164,11 +1164,8 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
 				else if (ctx->open_rec && ret == -ENOSPC) {
-					if (msg_pl->cork_bytes) {
-						ret = 0;
-						goto send_end;
-					}
-					goto rollback_iter;
+					ret = 0;
+					goto send_end;
 				} else if (ret != -EAGAIN)
 					goto send_end;
 			}
@@ -1180,11 +1177,6 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 			}
 
 			continue;
-rollback_iter:
-			copied -= try_to_copy;
-			sk_msg_sg_copy_clear(msg_pl, first);
-			iov_iter_revert(&msg->msg_iter,
-					msg_pl->sg.size - orig_size);
 fallback_to_reg_send:
 			sk_msg_trim(sk, msg_pl, orig_size);
 		}
-- 
2.54.0


