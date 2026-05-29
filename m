Return-Path: <netdev+bounces-293033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO+JFDFEGWqNuAgAu9opvQ
	(envelope-from <netdev+bounces-293033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:45:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A75FEC04
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0020306936C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86223B38B7;
	Fri, 29 May 2026 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dkKfXBZC"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573843403F2;
	Fri, 29 May 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040732; cv=none; b=manwNZA0N8s+40U0PJFls0UGFZImdFYElWUhelgMzrLBi5QykxWQVE7bmpv9ntyvrWCaKOSdkZultkMJo4zszQnA4/M7W1OA83VMIQxxYEGljuy3T841aMoKuNzrIQSXDu6pJ/CMVJcPQaWKfkWhKVtcVABKQMvcCLoliZD3DDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040732; c=relaxed/simple;
	bh=UbOAfliXwjnfF8vmn8x8EREiXGcuVW7ymVZEtLwcXZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehK9rYfDmv/narqYY45xGL6Il+nVHlLvIeNJKDuL5TviJvMJExLuD3EdQMaRT7DkpHdHBsKbltc9Cs8w2u+2EfDlP4K2h1ftXirDfNyDDzr4HEHda1iF9NTFnXi9U/qdzV4SBaa6870ULFj5bmGCY8n51XRTCxoqEY4RIkiWiZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dkKfXBZC; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=WarqaN6exri5sK3N2I5R9aD/CatfUNqjEnaMVNpBBdg=; b=dkKfXBZCUfUO4XuWcDLnOTpb7q
	VQkZ5Wvh72UHbzqnonbFUAjt757z/TwtmP6LThgLiF434MhfHPtfnDdyRDf739bX8cZ0BvN/bSbCm
	A10YziBIJipkKa49epuYLh6iQ/1nU9oga0jkIF48L34t0xAaWmoU3BSiaETraUC4UPrWZlbpxe9Nf
	KGeCbpZr97RCcx4seev8/aTKBJkRtSoFKOR+sHPCiJIQingaB6LRHbh1JxJ9q7myiLFM+YreCcEg1
	7Ym5aYr2PBDW09bUzJp086q8Wqk2HAQFGRL7hz2oz8KdR0HrIHGEH3BrzE6Nl40bLj+k2FsAChwjB
	21woQ6Sw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wSruC-004kM3-13;
	Fri, 29 May 2026 07:45:20 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 29 May 2026 03:45:11 -0400
Subject: [PATCH net 1/3] netconsole: do not schedule skb pool refill from
 NMI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-netcons_fix_before_move-v1-1-cb2d1426dd75@debian.org>
References: <20260529-netcons_fix_before_move-v1-0-cb2d1426dd75@debian.org>
In-Reply-To: <20260529-netcons_fix_before_move-v1-0-cb2d1426dd75@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neil Horman <nhorman@tuxdriver.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485; i=leitao@debian.org;
 h=from:subject:message-id; bh=UbOAfliXwjnfF8vmn8x8EREiXGcuVW7ymVZEtLwcXZY=;
 b=owEBbQKS/ZANAwAKATWjk5/8eHdtAcsmYgBqGUQM10C7KfVV1x7B9PjVIqDqOzYgy6K+Hr1xQ
 UeX18Te+XqJAjMEAAEKAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahlEDAAKCRA1o5Of/Hh3
 bd7LEACJDmS7Hk7+rBdOm4DR3mwwcNwkJrzUXEdYOIOpMFpYgUY12M/A9v4xLrn39NlYAbWNVHF
 jrkpgtqBfwQlPdf6nCpxWzeUjH150JvMs98z6/Iq03MNIFqyFOl7MtbI2t7JmZocjjHOSL6vaTE
 NY319CU/chcO1RCXRoua9g6sOWsXpuJ/TES9gJm8zDgD/I1pAqfwcGhSWs53d5veBZA4cdWmLRP
 54+he8vElHUsIGWWt79vIz6EZYWDnuMmgn8suEJbEQZlt/gcstJFTtX3b97MTDCoWab1LzeRq8h
 vyzwJ0HeMDrjC8eKQFsW+S/PzsDtCJZLXypqcGCUw9V1qESbi83Ne5iWT6d9JbQGaTFuz1+teKY
 0F1+knHOBrbZOVpqEAVuDKxlMxUlU1PV4zHfHmRZQ/lTwsqNrBwGBrM8Zp2WB8AoV6AIdlTij1b
 9dGa5vP1arPDA7D60S8f/FmuSSbbNeMmPL7rDwKZpM8aanc+CJzDXwPp4SdDQiTb5NcO2hVAKw9
 8lPvck7PAZx9WG/9mX/dLeYdMN0oOiNb+w9anXH24tUCR6AhhKQ/Ug0UB+9gMuo2yxlwCQ5jssa
 2By++LtcGEUsGsJUmDzQaSddCVRRegeGgsKXCAwkgjwsJHpJ236MyHZk9DIBoHIxhabWGChiQf5
 vpn7nNMsynk8MpQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293033-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,tuxdriver.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CF1A75FEC04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When alloc_skb() fails in find_skb(), the fallback path dequeues an skb
from np->skb_pool and unconditionally calls schedule_work() to top the
pool back up. schedule_work() ends up taking the workqueue pool locks,
which are not NMI-safe.

netconsole_write() is registered as the nbcon write_atomic callback and
is explicitly marked CON_NBCON_ATOMIC_UNSAFE, meaning it is invoked from
emergency/panic contexts including NMIs. If the NMI interrupts a thread
already holding the workqueue pool lock, calling schedule_work()
self-deadlocks and the panic message that was being printed is lost.

Introduce netcons_skb_pop() to fold the pool dequeue and the refill
request into a single helper. The helper skips schedule_work() when
called from NMI context; the pool is best-effort, and the next non-NMI
invocation of find_skb() will refill it. This keeps the fast path
untouched, the panic path NMI-safe, and the locking rules around the
fallback pool documented in one place.

Fixes: 248f6571fd4c ("netpoll: Optimize skb refilling on critical path")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d804d44af87c..699bdfa1fb45 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1654,6 +1654,23 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+/* Pop a pre-allocated skb from the pool and request a refill.
+ *
+ * The refill is requested via schedule_work(), which takes the workqueue
+ * pool locks and is therefore not NMI-safe. Skip the refill when called
+ * from NMI context; the next non-NMI caller will top the pool back up.
+ */
+static struct sk_buff *netcons_skb_pop(struct netpoll *np)
+{
+	struct sk_buff *skb;
+
+	skb = skb_dequeue(&np->skb_pool);
+	if (!in_nmi())
+		schedule_work(&np->refill_wq);
+
+	return skb;
+}
+
 static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 {
 	int count = 0;
@@ -1663,10 +1680,8 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 repeat:
 
 	skb = alloc_skb(len, GFP_ATOMIC);
-	if (!skb) {
-		skb = skb_dequeue(&np->skb_pool);
-		schedule_work(&np->refill_wq);
-	}
+	if (!skb)
+		skb = netcons_skb_pop(np);
 
 	if (!skb) {
 		if (++count < 10) {

-- 
2.51.0


