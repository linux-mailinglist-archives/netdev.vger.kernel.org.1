Return-Path: <netdev+bounces-261125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBbjEf2xn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3521A025D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 173A630416DB
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908B137883A;
	Thu, 26 Feb 2026 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKsMbH+E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E433A9EB
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073405; cv=none; b=e/8ufkuFwX984UjKOkftCkR0dxbbZxYHIhKLqH7qBITEwWjuQ06401ouokd/r9UDYxL7hd1JvxoDge109Qp919sY9SoaFpm2zrOzjnnaXXjS7PcVI8DDn4/BGCKi/j3Xy5cl7t5CJ97zpOUID12S8QfaouxhDmlaPIYb04MH8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073405; c=relaxed/simple;
	bh=XIiO5S9g4lQd9KDtTAQhPw4KtYWNkaBVxqhB821Esx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DwTxj8CdvQ3keGkRHK0mU1F5nGhGM1HpwspZbpyQ8P1TJvJk9opEeBgbzB5riPHlgOxUgG9HC1FPAXNNxR7X53tb08+plOvIM78EDaI4ZGN3mquZSey3T1uiuCcyD/HbprspGjZDvsujcLM5c+zBvv/aFlx2/kYSf9Eq0mf5eEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKsMbH+E; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358f4ed4eceso243724a91.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073404; x=1772678204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wzg0fRwGPYDGRdH0zm1zNlYnB9zqTLHJhvWJPsOyjBw=;
        b=VKsMbH+Eu92Cn5f/OVVy66+Ro5KCWxlbhWsAhXaq/9APIhSyC5DEmyXiniY+UHej7u
         HDr1pksTSUBF9eB8kMme/Qh47BtyzyE1VserjEy4TJqyWotd0EoEVRNgPR0xDxPa38Jv
         j235DeHcp9GdAnfaJPbXo2UJQA+wMHKA0DvlcH76mJRKWXzfXfTUTdox5gwGSefOT41N
         g7vQXepqS9TBcp7ZJCIM7cFGsvVgH/Ba22TGepPJy5Sai7rg4LJi8FmspXjDAO+W43i8
         G8SVINQhFwwicjvgTYaFx8KDcAVpTCHbZQUy6i+Xuo5DEhThJqwU1kKbdKYdRuGJU4Z8
         euzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073404; x=1772678204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wzg0fRwGPYDGRdH0zm1zNlYnB9zqTLHJhvWJPsOyjBw=;
        b=aoP4zftzy+2IYukNpeQF8t/iQw11jcOOh0F2LFcFYNULQDYNCC6pR2410DmvITLaZ0
         aB7ZAzfwcuwYWRfi1zd0E6ZuSsCEFWwCDL/RCssrMVlurJHkZIifx0f7WGqK1SANZSjw
         yf+znmDpnDU1/+prldJ4iUIS0xx7B5Wb8QmA+jDtcaydFhHwO7I347VyPuUdUW8H2r0f
         ay+eVbbv3SDMVvnr9nejgI0x4Cxu/4lhPZDk1zSe+Wn90knhSDjRA6JBp2RwMFuI7S5i
         M8fz/YwpbyqNcOOxJHSQ1eVPGB6iYl58iOAguUnkgvd8mGBDGZgnIu02sFu2lBgbXn48
         Unxg==
X-Forwarded-Encrypted: i=1; AJvYcCXJXljQtmpXBDf/MFwO60qBl67qYcMXvW2RSf6KXoQaMbejZLAZYnITXjTCV2J28DIcYjsWg50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6/gUexOYPRAGi6/U/ymeEwTlBng7DGIYCmBAhYWJn5rdljVsC
	1uDmjSwPHStEn7GGaPaEC1lEJvlaOGGUd8SsQVNBRZ6+rY35YzAHJKsfUz9Vrc/IvQGn4cNqajh
	VtWwo0Q==
X-Received: from pjbev22.prod.google.com ([2002:a17:90a:ead6:b0:34c:cc12:1613])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c6:b0:354:bfb7:db13
 with SMTP id 98e67ed59e1d1-3593dc2be2bmr657363a91.35.1772073403505; Wed, 25
 Feb 2026 18:36:43 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:14 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 02/15] ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
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
	TAGGED_FROM(0.00)[bounces-261125-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA3521A025D
X-Rspamd-Action: no action

These fields in struct mr_table are updated in ip_mroute_setsockopt()
under RTNL:

  * mroute_do_pim
  * mroute_do_assert
  * mroute_do_wrvifwhole

However, ip_mroute_getsockopt() does not hold RTNL and read the first
two fields locklessly, and ip_mr_forward() reads the latter two under
RCU.

Let's use WRITE_ONCE() and READ_ONCE() for them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 131382c388e9..377b5848f99c 100644
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
@@ -2037,7 +2037,7 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 
 		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
-		if (true_vifi >= 0 && mrt->mroute_do_assert &&
+		if (true_vifi >= 0 && READ_ONCE(mrt->mroute_do_assert) &&
 		    /* pimsm uses asserts, when switching from RPT to SPT,
 		     * so that we cannot check that packet arrived on an oif.
 		     * It is bad, but otherwise we would need to move pretty
@@ -2050,7 +2050,7 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 			       MFC_ASSERT_THRESH)) {
 			c->_c.mfc_un.res.last_assert = jiffies;
 			ipmr_cache_report(mrt, skb, true_vifi, IGMPMSG_WRONGVIF);
-			if (mrt->mroute_do_wrvifwhole)
+			if (READ_ONCE(mrt->mroute_do_wrvifwhole))
 				ipmr_cache_report(mrt, skb, true_vifi,
 						  IGMPMSG_WRVIFWHOLE);
 		}
-- 
2.53.0.414.gf7e9f6c205-goog


