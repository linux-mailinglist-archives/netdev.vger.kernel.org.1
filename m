Return-Path: <netdev+bounces-271058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOliCBSMwml9ewQAu9opvQ
	(envelope-from <netdev+bounces-271058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:05:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D9308E14
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC6AE30897FC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE343F9F4F;
	Tue, 24 Mar 2026 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx91Cyqn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71F3F99FD;
	Tue, 24 Mar 2026 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356842; cv=none; b=KUQo2Qizvuu/IVg5HHKlKLLKbDxiC0JVxSZPUAhJbEIuVh8FCF6X7rUhutedfG3o5WkzcPYQ2pvD0w08fuXbxOJ1jvEANajG0UpyJZfLi3AB1KC3sEGvqotWR3vyYOX2KQ/OFDp5xj9w1uRJWK/aqUSIazpBjRcm6neLfPT+7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356842; c=relaxed/simple;
	bh=ADsowbatqb/2SsLJ3HQ7L93bqVYsEjgbcxdwOPOvHEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q43xkh2pf50mhqzHDeNcOgYGH+JdtmOuq14OD4+L4fSxBY2DUofVG+3+eAi9OAxhspA/AtuJKnCSTb3Qv4eBAys5ds7nKna5PnuVx4zahkewvMIqbqjis5x4xxQ+D1PHa9rqmnNclQoz14QizLWVVlAYbfwBKpfJTPB7A6rUFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx91Cyqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105D7C2BC87;
	Tue, 24 Mar 2026 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774356842;
	bh=ADsowbatqb/2SsLJ3HQ7L93bqVYsEjgbcxdwOPOvHEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zx91Cyqnkt8uMg350UhoXhoGiTNI3QPQH4l0QYR2SHV5pT5yTmra3/UI0OIX21Y8J
	 p886rCg30HTA68wgkAT3Zw56fUgRt3uJeef9BybcAHROo9HlEDdo5dYjUm4KZTZHle
	 jr9EBfahZuIgRgstDHnVZ462MNVA/xsZk2URcaYPHoQQ7nGq6pNLnG/k4unpj6Vabg
	 +GjrnEvW56NoGHHen9EwE/mAYvpEXBdZNKT7hWVT0mvbekwcv9g1dq4LYIJKfbQEAC
	 fkaWgi1zn+aHL1ceTQceTbWSnDotv0mHRo31e8SpeUIGQxQx6xEnNF+db9j0uL8vl/
	 ojVi7mW7/TExw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 24 Mar 2026 08:53:25 -0400
Subject: [PATCH net-next v5 3/6] tls: Fix dangling skb pointer in
 tls_sw_read_sock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-tls-read-sock-v5-3-5408befe5774@oracle.com>
References: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
In-Reply-To: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=C6Eyt3fovBhxmJhtF8FQJ86E45z3fVSEaLjEsfKU3NA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpwolnsXDk0WH80WoYeU6k0cmu667v0B5zeroba
 8PFXjttiFeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacKJZwAKCRAzarMzb2Z/
 l3YTEAC6byauf931LeW5aUqpW0+Z6ie5PjpOvAMPq+XTHmIZ30jw2RI8oWR9386+Q0TV0Yn4IYI
 IzVKtengbhwjh5tI3VT+bkhCLC3+URoT2xL1zboKEzgSCCFkHTpWMWTGwoDgnXa6OAhn1kMEAVv
 kWNlJAPxZvwtYdXH0f+QjuamKTanF9m+5cE/1davveacric7/xKoWocKG+m16FK+lS6hybSPZ5z
 UPcwxsafe/Za3P28tr/jhmLV+wmbLga+jAJiX/fatqdIDRT3q6xGQS2AGVQAfPbQQGVfc5DdEm6
 2Id+QB9+e4ZxmT+TuAKOSRH5IuaX92CDOgS3K+8x/DWOiNCf5xgGWrXj3bXNK/e20/hkIcXPwpd
 XDQqtyLeMYx7pL/2+MyEzI3CWemxweZj1X3B5rAS81ECmPU87kNy91HDRPoELTo1yTc5f+r4DHy
 xHBHeyXxU774mEi2rZ1XuvfLyVVUiPA1qx+6z2lFVx03SRYH36gLvDiZO1jlV6s8dV1mwN4R49I
 acLsSVLt2/Yhv4/TbBqg28bAchfWaQOfzfSFmC3IYmyhY0VdWUQyHSZo2lilQM2/mniLKYmmuqy
 Dx/IOXqgE7GYJVUCY9Ea5V/u94+kRcZEF5TNjIyHRpSuxJChaAbcFYIE7qxTJxKFrRYRaNTMhEY
 YlRpPCPfMolsTiA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271058-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: B58D9308E14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Per ISO/IEC 9899:2011 section 6.2.4p2, a pointer value becomes
indeterminate when the object it points to reaches the end of its
lifetime; Annex J.2 classifies the use of such a value as undefined
behavior. In tls_sw_read_sock(), consume_skb(skb) in the
fully-consumed path frees the skb, but the "do { } while (skb)"
loop condition then evaluates that freed pointer. Although the
value is never dereferenced -- the loop either continues and
overwrites skb, or exits -- any future change that adds a
dereference between consume_skb() and the loop condition would
produce a silent use-after-free.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5626fdd4ea0a..5fdd43a55f1e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2356,7 +2356,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		goto read_sock_end;
 
 	decrypted = 0;
-	do {
+	for (;;) {
 		if (!skb_queue_empty(&ctx->rx_list)) {
 			skb = __skb_dequeue(&ctx->rx_list);
 			rxm = strp_msg(skb);
@@ -2405,10 +2405,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 				goto read_sock_requeue;
 		} else {
 			consume_skb(skb);
+			skb = NULL;
 			if (!desc->count)
-				skb = NULL;
+				break;
 		}
-	} while (skb);
+	}
 
 read_sock_end:
 	tls_rx_reader_release(sk, ctx);

-- 
2.53.0


