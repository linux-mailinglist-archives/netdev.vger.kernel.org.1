Return-Path: <netdev+bounces-290495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLG8CBUdD2rbFwYAu9opvQ
	(envelope-from <netdev+bounces-290495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:56:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7675A7C10
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6545D331270B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ACF3E5578;
	Thu, 21 May 2026 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="a0dVKJ+m"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7423DA5BD;
	Thu, 21 May 2026 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374028; cv=none; b=DeIkU3Aiio/I5OB4uLpfwBLARGxdyGXHWshieGDUQ0JcEyGIzOoR3hv5LiCgSWt6hhMUmCMsyiqwdzlv/wA5xK3PmqSdFhkQAQYZvtzZVJstng80dGUT9pgwheEw1n1sDgcnAQhUMCNKb4Ah0zd193mOC9V246YuPqZZAfeNkYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374028; c=relaxed/simple;
	bh=vUVzwioy7eyITUTnDSAg54tCJT7WpcF3kD1sfAlb9Xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSES84gI3HzIm5L70/WYPp100UuV/gHZ2am2b82VrEviRQ6eqPn5DFgkZ2WJ2osWBV1MvXneNXyIbCAuFsEBL7Z8ddxeUy44C5x++Ly5O9hFQmB/CdYiaFz7GGupLXniI2xqgPbfZJqCvcJXxL95lDA17Jm9bMzU8xOFt/cL2zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=a0dVKJ+m; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=1CytHvX5Z9CQODF2r8Uldp/4soH5aVdVyJhj02K+WN4=; b=a0dVKJ+mpjGCdpOj1QsIJMvtlR
	xVM9K3vUwb5P3qDxarN0I7G1jum0faoZGGaOY3UiPAxwmYKQY0bh33eot2lKD0GVZQxZU5g9X48B2
	Z4aqiiLpwUlN8JcZ7w8fwL26VDi8VAyBtxovhpSm6p2JNVAXBW9QPh/gt9oHeIDm9piBuggky7N0R
	YycSBecv44DYTYFIh/Am1W4xHuMHi5yDKCWNXoIN1AlAXSDJ/khlpIzEKaidFi9hguHZwAb06OFc5
	oW8fXCVhhLUG7qh7P3JzQk5uu7It/zHLzso2gQwmlWrRvZqr4zt7FfhhdDi/r5eEUxcey21Yu2g/j
	NEGoNmvw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQ4St-003wxJ-0A;
	Thu, 21 May 2026 14:33:35 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 21 May 2026 07:32:10 -0700
Subject: [PATCH net v2 2/2] nfc: llcp: read llcp_sock->local under the
 socket lock in getsockopt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-fix_llc-v2-2-ab44cc09179c@debian.org>
References: <20260521-fix_llc-v2-0-ab44cc09179c@debian.org>
In-Reply-To: <20260521-fix_llc-v2-0-ab44cc09179c@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, David Heidelberg <david+nfc@ixit.cz>, 
 Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449; i=leitao@debian.org;
 h=from:subject:message-id; bh=vUVzwioy7eyITUTnDSAg54tCJT7WpcF3kD1sfAlb9Xg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqDxexoLN0vvPGMg5rRL9uOhEDGMg02w+1OAMR1
 fP9m9G+cn2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCag8XsQAKCRA1o5Of/Hh3
 bQq9D/99Rok2FqAlu/B4u7G+xFig/lgnWR56U7HkFxyB/MHLiES5loMrtFTAEnMjR4Fj+bp99Kf
 7DdRLBZGTc+4Ag1d/1dADQxkap0Vi1S/fO2/O7HFCNJp6TS/7BjGZ0LfzAiOYaEiCozseK31SKo
 weejKQabDWL9LNKVxlE6ADyFPeN3aV19Rb8kRqOcDFcspjTRq/hqgWB9JEhav7q12fjyQ4kRdF5
 wrPUtycEyPpgodrPHvLpPRNwYuemo+IUfiEqXxHpcl/g2V+NkHCVlKCHQiXPq3AJCXi1dnKYLrl
 +ZYxvscmKoxzvOLmntpdleQCPmGdfhcRdgu0uIBfxMtQ5g+CeKpa7HKu5UcmytqwfUqTBFj8m5C
 rIFY4x7kvt5s2Hdt7Jciw/kFDUqTF3GYAnoasuSyG3fK4IYBxn+lc1Yqe7lbfptnPMHjKhohubq
 XCM8jmX5Bb3tAPbeOxOOTtrnHiawEBY4emqiteF7qEWrUT6+lacR5P13wZtHy3ZSPk5EDmEqEvA
 vQuFM0CS8vmDDZo2UlehJg5kAEOoicsSVeR1DeB4H1wbvZ7vhOtzMlD/HnorYGC03Uc3UQOFnb+
 0cV9UrbR11QbjafVVMEJf7JxzeGf11pkw2gTpv5itKL/yyulcPsY4AVV4LrJqAZ0Czhp+CO4F29
 H5y9RgDpcRQ/V2A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290495-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,nfc];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BD7675A7C10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfc_llcp_getsockopt() read llcp_sock->local before lock_sock(sk) and
then dereferenced the cached pointer inside the locked region.
llcp_sock_bind() assigns and clears llcp_sock->local under the same
socket lock, dropping the last reference on its error path. A
getsockopt() racing an in-flight bind() can observe the pointer, block
on lock_sock(), and then dereference a freed nfc_llcp_local once bind()
has unwound.

Move the llcp_sock->local read and the NULL check inside the
lock_sock(sk) region so bind() cannot mutate or free the pointer between
the load and the use.

Fixes: 26fd76cab2e6 ("NFC: llcp: Implement socket options")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/nfc/llcp_sock.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index aa9a78a671521..266590d402664 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -325,14 +325,16 @@ static int nfc_llcp_getsockopt(struct socket *sock, int level, int optname,
 	if (len < sizeof(u32))
 		return -EINVAL;
 
-	local = llcp_sock->local;
-	if (!local)
-		return -ENODEV;
-
 	len = min_t(u32, len, sizeof(u32));
 
 	lock_sock(sk);
 
+	local = llcp_sock->local;
+	if (!local) {
+		release_sock(sk);
+		return -ENODEV;
+	}
+
 	switch (optname) {
 	case NFC_LLCP_RW:
 		rw = llcp_sock->rw > LLCP_MAX_RW ? local->rw : llcp_sock->rw;

-- 
2.53.0-Meta


