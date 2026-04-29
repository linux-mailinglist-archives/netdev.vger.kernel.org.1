Return-Path: <netdev+bounces-282289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKLRFNu/8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:22:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6249122D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 087E0302DF53
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BD93B27F9;
	Wed, 29 Apr 2026 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hWstlpS7"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891215539A
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450943; cv=none; b=lKCH/zc4hzHuVSaubnf/z3kkVy9wWJsqbe1XdtRXWc+dABhOW9TDFqw3x2D+k0EpA48GVZSv8QDlEvm0sREhxSCdw5IVHhv9SREx+AFbh14th9TkZJ1Htva1K5ZIGSCCrCuzuegT7e0MBdCJCp11l+2PEpSHJunOGGD0wPNdv4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450943; c=relaxed/simple;
	bh=sykAOu25LebsSEqhmQKN/R0kEJpPb9JEdfulvH5X4I8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVLL2MEOTnnkzePPMLHkQY2OPKaBxBv7iqqlizRJPDqF3fcXJTSTlx243zzkYGT4LQuG9+/dDKxQumU4Pw/DWL/lcD4HGXPyxSrM1eRQCxCEnGTv9R/cxCwx2CAeoZ0BQ2n6M5u3FXamxaD2A1jAteJoBFAmAAmq81EFOTvXph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hWstlpS7; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1777450938;
	bh=d5BABExyq/oCWKftul/yaqdLJ0NV496CU+VpXirjNb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hWstlpS7DqTn0rGsssf8feeC30Bs+kPEvbrkPZjvAz5qjnnmAZ7WMNWeQBTseeBa3
	 L/irv+j0mtj+K8xLuJ5J3VSbUym91FZKFqk58w25U5ii7TxkSE39Y8iwxmSaqjLeI/
	 FSvfKpWyoDzzLAiM2ncWuJXV+NB/R186y8O+Ku0xrxbqV/5CAf8Z/lgF5LqyMx/s9a
	 uWQe5QE6saC4R+8o5nd1QHPBCo9bx9DHGmBS8MxvpfcHOhvemv5SRVvjXZkVPkb1tg
	 GEFUM4UrQDpbKJnCBEByeSt6YgKBu/n5HKWeBUNoaZQZCV5pcGX2Uf51UkmC7D54iR
	 lKIhnVm+wn4Rg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id F0F7B6027F; Wed, 29 Apr 2026 16:22:18 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 29 Apr 2026 16:21:41 +0800
Subject: [PATCH net 1/2] net: mctp: test: use a zeroed struct sockaddr_mctp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-dev-mctp-test-fixes-v1-1-1127b7425809@codeconstruct.com.au>
References: <20260429-dev-mctp-test-fixes-v1-0-1127b7425809@codeconstruct.com.au>
In-Reply-To: <20260429-dev-mctp-test-fixes-v1-0-1127b7425809@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Queue-Id: EDE6249122D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282289-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:email,codeconstruct.com.au:dkim,codeconstruct.com.au:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Invalid sockaddr padding will cause bind() to fail; ensure we have a
zeroed address in the testcase.

Fixes: 0d8647bc74cb ("net: mctp: don't require a route for null-EID ingress")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index e1033643fab0..e4b230ef6099 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -920,9 +920,9 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 static void mctp_test_route_input_null_eid(struct kunit *test)
 {
 	struct mctp_hdr hdr = RX_HDR(1, 10, 0, FL_S | FL_E | FL_TO);
+	struct sockaddr_mctp addr = { 0 };
 	struct sk_buff *skb_pkt, *skb_sk;
 	struct mctp_test_dev *dev;
-	struct sockaddr_mctp addr;
 	struct socket *sock;
 	u8 type = 0;
 	int rc;

-- 
2.39.5


