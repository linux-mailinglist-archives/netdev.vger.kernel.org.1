Return-Path: <netdev+bounces-262235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOlhCsFpo2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:18:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF0E1C9709
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70FE530607A2
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431A73D413E;
	Sat, 28 Feb 2026 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xJLWbnum"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0730B2EFDA1
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317088; cv=none; b=oJDmW5Kkr4zVxs+Hay1y4eF80MqT0nmjXq0MRI7Srno/5LNwXUVvsb/tPEfzrWaX3hmX4JERQ2PRCoeOTJ+T1Bjoat4hBmDwGBMD+z0cTxazwRM0xtY76p/Tpsa+b8CdAYB24kyM2Ox+t19+mOlr36tK2ejWw/N//oEhAg2thwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317088; c=relaxed/simple;
	bh=o/D8LhkHgxda7DTaDVDacd8sZ7w/MX3WeN/tyWbDFuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R6bRb1LwwtL7RyBoe+01/rWJ3p8aNNB9BvSqGdv0vTiMrF+LwId/c/d+f84Nh4AqM9/Ks7LzzbwOkMag1+wH5KsGjiyPbOm2DsbFH+oXS+xeEDBPa9Qa4w1qC9C57jrRFXmM6XtlJXjuJgFsJZ83NRuEqEkWaiVBGQR4ttpAO5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xJLWbnum; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2addefa321dso189254215ad.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317086; x=1772921886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrENbbwGTF9kqD99WTwTyYRww8UwmJ1+L436dBwgMhY=;
        b=xJLWbnumem75UTppNJuu4ucDHIwbjOIHECBEzIYx5FAo+IaJyzPfnuKBnPdibc2q/i
         PviJVq7DGnmAu/cAo88HS2BqCDNdUVB0nOYhxMZyBRiMZDKbQYlamrjARXiwGAS26arF
         G8aiGyw3w5WKjkdk4CZu0t1G24ub/Qpa27tKP4PwxyrcedEXCthqpT88z5ORvZ5ijyzJ
         L2vRH/doLNReqh+CNlUd/cCcHSQTS+DkXUVrz7ty9xCXZ7Hvs/RzpGFEOp5/pcZxxcKK
         pIwMcJkyhdU3og2KkGB53ISV24xw3XBVcdqGunqrBkQL5eapKFqPCEa4EtBjUfxy6fJT
         TYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317086; x=1772921886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrENbbwGTF9kqD99WTwTyYRww8UwmJ1+L436dBwgMhY=;
        b=kJolSvD2NEeTX7Ggcno/l0mpyZ4asmVFhzusxlEmSxYfJOu1fCcfhbIn8v9dY7efxT
         wyGj11NFJHhPQFeErz8zcr/PeeFTT++diFVBdyMM46LH+BkyIu4Ta6YSpnUuDbBmNz4B
         0vONnzmu+qQubTUi+YRgXziiaazDRWvYRUti9BWIGScOKGoh/6rU3YNBLbj1LWVefmB0
         Bt9Obk6uw3tr1PROX//8MGctTIFK39/V8m3Mh/2Q8cYvUzgt3jtvgSQu6RpnVwcMxpMu
         QDfcr6i8nzdlecKsZfc2ulKlVfnzJ4AYcYEPOjqsITtrhQJKLXPdrbWsdzDFKtDh7WHq
         HtNA==
X-Forwarded-Encrypted: i=1; AJvYcCVqh+tOFfsjpf4rG0DcwnW6ZhhWGyI6vVyW5FsPM68z784H4Jgkenuqh+mgSuYhs6SHL5fHLJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOLZ25OeUnA+EGMO3kpShke5nRxO44qQklNeoRHIzQ9YM77cOr
	7m8W2ByCI8zy3MGjW63o7vBiCUGwXZaWm2tzvPWoDtXHpcILVbf/Y6uZg0oG8MNzUdwgrnzCuCK
	Gfo6cyA==
X-Received: from plbku4.prod.google.com ([2002:a17:903:2884:b0:2a3:e79c:6cfb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48d:b0:2aa:d802:a010
 with SMTP id d9443c01a7336-2ae2e3e71fdmr67773455ad.10.1772317086201; Sat, 28
 Feb 2026 14:18:06 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:20 +0000
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228221800.1082070-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 02/15] ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262235-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BF0E1C9709
X-Rspamd-Action: no action

These fields in struct mr_table are updated in ip_mroute_setsockopt()
under RTNL:

  * mroute_do_pim
  * mroute_do_assert
  * mroute_do_wrvifwhole

However, ip_mroute_getsockopt() does not hold RTNL and read the first
two fields locklessly, and ip_mr_forward() reads all the three under
RCU.  pim_rcv_v1() also reads mroute_do_pim locklessly.

Let's use WRITE_ONCE() and READ_ONCE() for them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v3: Use READ_ONCE() for mrt->mroute_do_pim in ip_mr_forward()
     and pim_rcv_v1()
---
 net/ipv4/ipmr.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 131382c388e9..970f173654c7 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1506,7 +1506,7 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			ret = -EFAULT;
 			break;
 		}
-		mrt->mroute_do_assert = val;
+		WRITE_ONCE(mrt->mroute_do_assert, val);
 		break;
 	case MRT_PIM:
 		if (!ipmr_pimsm_enabled()) {
@@ -1525,9 +1525,9 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		do_wrvifwhole = (val == IGMPMSG_WRVIFWHOLE);
 		val = !!val;
 		if (val != mrt->mroute_do_pim) {
-			mrt->mroute_do_pim = val;
-			mrt->mroute_do_assert = val;
-			mrt->mroute_do_wrvifwhole = do_wrvifwhole;
+			WRITE_ONCE(mrt->mroute_do_pim, val);
+			WRITE_ONCE(mrt->mroute_do_assert, val);
+			WRITE_ONCE(mrt->mroute_do_wrvifwhole, do_wrvifwhole);
 		}
 		break;
 	case MRT_TABLE:
@@ -1610,10 +1610,10 @@ int ip_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 	case MRT_PIM:
 		if (!ipmr_pimsm_enabled())
 			return -ENOPROTOOPT;
-		val = mrt->mroute_do_pim;
+		val = READ_ONCE(mrt->mroute_do_pim);
 		break;
 	case MRT_ASSERT:
-		val = mrt->mroute_do_assert;
+		val = READ_ONCE(mrt->mroute_do_assert);
 		break;
 	default:
 		return -ENOPROTOOPT;
@@ -2037,20 +2037,20 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 
 		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
-		if (true_vifi >= 0 && mrt->mroute_do_assert &&
+		if (true_vifi >= 0 && READ_ONCE(mrt->mroute_do_assert) &&
 		    /* pimsm uses asserts, when switching from RPT to SPT,
 		     * so that we cannot check that packet arrived on an oif.
 		     * It is bad, but otherwise we would need to move pretty
 		     * large chunk of pimd to kernel. Ough... --ANK
 		     */
-		    (mrt->mroute_do_pim ||
+		    (READ_ONCE(mrt->mroute_do_pim) ||
 		     c->_c.mfc_un.res.ttls[true_vifi] < 255) &&
 		    time_after(jiffies,
 			       c->_c.mfc_un.res.last_assert +
 			       MFC_ASSERT_THRESH)) {
 			c->_c.mfc_un.res.last_assert = jiffies;
 			ipmr_cache_report(mrt, skb, true_vifi, IGMPMSG_WRONGVIF);
-			if (mrt->mroute_do_wrvifwhole)
+			if (READ_ONCE(mrt->mroute_do_wrvifwhole))
 				ipmr_cache_report(mrt, skb, true_vifi,
 						  IGMPMSG_WRVIFWHOLE);
 		}
@@ -2358,7 +2358,7 @@ int pim_rcv_v1(struct sk_buff *skb)
 	mrt = ipmr_rt_fib_lookup(net, skb);
 	if (IS_ERR(mrt))
 		goto drop;
-	if (!mrt->mroute_do_pim ||
+	if (!READ_ONCE(mrt->mroute_do_pim) ||
 	    pim->group != PIM_V1_VERSION || pim->code != PIM_V1_REGISTER)
 		goto drop;
 
-- 
2.53.0.473.g4a7958ca14-goog


