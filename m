Return-Path: <netdev+bounces-252773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO4zGoVJc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:12:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A727740B3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65995300623D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7798037AA78;
	Fri, 23 Jan 2026 10:08:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613A366547
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162914; cv=none; b=T+mGM+/iNnMXP/9HnhwcOnQ00yKL/VJLJpFM12wzy0OyYstPeZ8LO00XP+7+8XUBec8tBLaIpF7yYovZhwWZkNflq5ChbwpoeX2nmQ2EYPJ4y2rhBv9Dl+Zr8NmVaPxjZZ8tXzQqg2/iPnZ/3q6cbNswEIXQIUKO/4XAfqKqP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162914; c=relaxed/simple;
	bh=h8wOrwZGBr/rWMJrSgjZ5G80YkNzn771CHOv4mZnx1A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=am58tGe62bD5dNI3Na7kgNg6j4WI7eOTIrF8X4AQ2OkRrazIahMO+VFDE/V9dNxV++Tqk2d76csUFEuGWiUz/D/MyyAFsf29/BiDMz2z7dRazLO9rNre3dq30VZ3cEFsG9h+bEZr0E8yWsEcW3MvetEZbwz5gtNMGMxVe3Ze+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60NA8KYK076887;
	Fri, 23 Jan 2026 19:08:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60NA8KQ6076884
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 23 Jan 2026 19:08:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
Date: Fri, 23 Jan 2026 19:08:19 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-security-module <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-252773-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A727740B3
X-Rspamd-Action: no action

Since xfrm_dev_{state,policy}_flush() are called from only NETDEV_DOWN and
NETDEV_UNREGISTER events, making xfrm_dev_{state,policy}_flush() no-op by
returning an error value from xfrm_dev_{state,policy}_flush_secctx_check()
is pointless. Especially, if xfrm_dev_{state,policy}_flush_secctx_check()
returned an error value upon NETDEV_UNREGISTER event, the system will hung
up with

  unregister_netdevice: waiting for $dev to become free. Usage count = $count

message because the reference to $dev acquired by
xfrm_dev_{state,policy}_add() cannot be released.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/xfrm/xfrm_policy.c | 35 -----------------------------------
 net/xfrm/xfrm_state.c  | 33 ---------------------------------
 2 files changed, 68 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 62486f866975..f4df6491095f 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1778,41 +1778,12 @@ xfrm_policy_flush_secctx_check(struct net *net, u8 type, bool task_valid)
 	}
 	return err;
 }
-
-static inline int xfrm_dev_policy_flush_secctx_check(struct net *net,
-						     struct net_device *dev,
-						     bool task_valid)
-{
-	struct xfrm_policy *pol;
-	int err = 0;
-
-	list_for_each_entry(pol, &net->xfrm.policy_all, walk.all) {
-		if (pol->walk.dead ||
-		    xfrm_policy_id2dir(pol->index) >= XFRM_POLICY_MAX ||
-		    pol->xdo.dev != dev)
-			continue;
-
-		err = security_xfrm_policy_delete(pol->security);
-		if (err) {
-			xfrm_audit_policy_delete(pol, 0, task_valid);
-			return err;
-		}
-	}
-	return err;
-}
 #else
 static inline int
 xfrm_policy_flush_secctx_check(struct net *net, u8 type, bool task_valid)
 {
 	return 0;
 }
-
-static inline int xfrm_dev_policy_flush_secctx_check(struct net *net,
-						     struct net_device *dev,
-						     bool task_valid)
-{
-	return 0;
-}
 #endif
 
 int xfrm_policy_flush(struct net *net, u8 type, bool task_valid)
@@ -1861,11 +1832,6 @@ int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
 	struct xfrm_policy *pol;
 
 	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
-
-	err = xfrm_dev_policy_flush_secctx_check(net, dev, task_valid);
-	if (err)
-		goto out;
-
 again:
 	list_for_each_entry(pol, &net->xfrm.policy_all, walk.all) {
 		if (pol->walk.dead)
@@ -1888,7 +1854,6 @@ int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
 		__xfrm_policy_inexact_flush(net);
 	else
 		err = -ESRCH;
-out:
 	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
 	return err;
 }
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 98b362d51836..855778177558 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -881,41 +881,12 @@ xfrm_state_flush_secctx_check(struct net *net, u8 proto, bool task_valid)
 
 	return err;
 }
-
-static inline int
-xfrm_dev_state_flush_secctx_check(struct net *net, struct net_device *dev, bool task_valid)
-{
-	int i, err = 0;
-
-	for (i = 0; i <= net->xfrm.state_hmask; i++) {
-		struct xfrm_state *x;
-		struct xfrm_dev_offload *xso;
-
-		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
-			xso = &x->xso;
-
-			if (xso->dev == dev &&
-			   (err = security_xfrm_state_delete(x)) != 0) {
-				xfrm_audit_state_delete(x, 0, task_valid);
-				return err;
-			}
-		}
-	}
-
-	return err;
-}
 #else
 static inline int
 xfrm_state_flush_secctx_check(struct net *net, u8 proto, bool task_valid)
 {
 	return 0;
 }
-
-static inline int
-xfrm_dev_state_flush_secctx_check(struct net *net, struct net_device *dev, bool task_valid)
-{
-	return 0;
-}
 #endif
 
 int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
@@ -966,9 +937,6 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 	int i, err = 0, cnt = 0;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
-	err = xfrm_dev_state_flush_secctx_check(net, dev, task_valid);
-	if (err)
-		goto out;
 
 	err = -ESRCH;
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
@@ -997,7 +965,6 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 	if (cnt)
 		err = 0;
 
-out:
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
 	spin_lock_bh(&xfrm_state_dev_gc_lock);
-- 
2.47.3


