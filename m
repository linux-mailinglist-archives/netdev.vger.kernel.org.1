Return-Path: <netdev+bounces-282288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIviBce/8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:22:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B19F949121D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F182A302FA26
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ECB3B19C9;
	Wed, 29 Apr 2026 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mDvsOJx4"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C533A8730
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450942; cv=none; b=GcBWtTczCxCNNlc2XjirJ5kFQwrEuASdHHwvzq7meJ9zxhBXgfFNGSt4UWilwNKEcfHWoPuJVqUCKi/GS0sri7M4t1D0IWjTEIx415mKWWveiFBjYdxtPsWAdRVUtjSpx7yrO8K1Be0Yk6Ui2v1PvhQ+NeePIE04+aQJgrdJhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450942; c=relaxed/simple;
	bh=lN3xppOIzKBtHzIbSQpJBLnW5rsBuOpCUFOM6xxjK7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYeF1dJ6gMEE+jBCxp6g9ZqNR2tyktdQcgooXt/WLZMy4/VOfJywedGGnS92k06qTwPxfzkOLiDaveZat1JflmM7dKk//spEaOJbpPI0x3eujpwAbJi5Ma3IPD80pT4cnyE8f4nmKMvcf8Q2Gc1Naqzuj/0rsaRu2e3yRKM7xxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mDvsOJx4; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1777450939;
	bh=3aB+ayvPJBk4tp2t4E9ZpbfPNI5byZJpdzWObelhBUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mDvsOJx4yBbK0wY7Ee6Nvgcbxqm/od/eBh+6vq71M0BrMbYaGil7K7LUkaEWRDyJb
	 njjW2oJXtPg+TfiKElFMN+ORNkRJ2vthGh1Ov7YqABB8XiA1yPm4fWid8dhc9i3vZa
	 mlfAPoUA29k0XHQgjXwCKYq8UFybKuKhWlf72FP0S8/hDuimuSp1oF0ODxKUDyCjaw
	 1OlH9QKtApnLV6wJuQQ+m/RDCPrmDfXAiW38kYZCrnX7tX7TuzuXJaJNJOpZr2IzNI
	 4tk/j4rt4P4Ce7JrtGCjAqZywj4VhfGGUM1/R224KFRmAEnbIjoqNDPussRwj7AfRt
	 pV8Wicv/3soWQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 6DB0860280; Wed, 29 Apr 2026 16:22:19 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 29 Apr 2026 16:21:42 +0800
Subject: [PATCH net 2/2] net: mctp: test: Use dev_direct_xmit for TX to our
 test device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-dev-mctp-test-fixes-v1-2-1127b7425809@codeconstruct.com.au>
References: <20260429-dev-mctp-test-fixes-v1-0-1127b7425809@codeconstruct.com.au>
In-Reply-To: <20260429-dev-mctp-test-fixes-v1-0-1127b7425809@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailer: b4 0.16-dev
X-Rspamd-Queue-Id: B19F949121D
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
	TAGGED_FROM(0.00)[bounces-282288-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,codeconstruct.com.au:email,codeconstruct.com.au:dkim,codeconstruct.com.au:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

In our test cases, we typically feed a packet sequence into the routing
code, then inspect the device's TXed skbs to assert specific behaviours.

Using dev_queue_xmit() for our TX path introduces a fair bit of
complexity between the test packet sequence and the test device's
ndo_start_xmit callback; which may mean that the skbs have not hit the
device at the point we're inspecting the TXed skb list.

Use dev_direct_xmit instead, as we want a direct a path as possible
here, and the test dev does not need any queueing, scheduling or flow
control.

Fixes: 6ab578739a4c ("net: mctp: test: move TX packetqueue from dst to dev")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202604281320.525eee17-lkp@intel.com
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
index c3987d5ade7a..6eef8d485c25 100644
--- a/net/mctp/test/utils.c
+++ b/net/mctp/test/utils.c
@@ -116,7 +116,7 @@ void mctp_test_destroy_dev(struct mctp_test_dev *dev)
 static int mctp_test_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
 {
 	skb->dev = dst->dev->dev;
-	dev_queue_xmit(skb);
+	dev_direct_xmit(skb, 0);
 
 	return 0;
 }

-- 
2.39.5


