Return-Path: <netdev+bounces-261698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CiSBv8RoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:39:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B91B2512
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 068733100DC4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B189C33291A;
	Fri, 27 Feb 2026 03:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1G0IDhS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC53328E7
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163550; cv=none; b=ZcbUpgks2YLiwf/Gj1nlq+hPnZh0YL7jsyDDUXCSOMINz1nz7i7WzvUOz/dJ+iYeoriGMKqPmUNIsuNcnJO52KbvpJFyknSOl91NHFTIUd9mroI0KoiwP4wQtTtN5g6YPs/yHCvjyHb+fdFUT7WtsIHUkgQ5/W98SXqlavW2tLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163550; c=relaxed/simple;
	bh=9c6RTwDox+0dXucpiFh/KyU5cdhXbA23n/M8SikmA0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nLM6eR7OcGKF7BdaiulV57ojyilF+frgD17Lvsk0BSgakf5GG4ZI4wGX+GuiYg+yza/f+G4yy8rcYDauM9BLjeKk0NO+SHzPcOeKihpG411UaEF/vgEJIrQbMBQKeRQtlPNUusPM1rI1gxWIuNtQcc78TCgL48mYBMUepH+UvJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1G0IDhS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6e74e55d35so910038a12.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163549; x=1772768349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jM2jRE52GoildGbNHzk6XHpEWFB/sro6HR27gtYvH8Y=;
        b=G1G0IDhSTiCHCFrav3NQH0IYXFr+vR3pk3veFybm0lUiixS7tTyQXcsueN7cmo1tGi
         9LZQiIVocOvk720/8RDhkyXKoBnhM+ZIaDgwYEWXmMJ0QiMNhm59Rzapi8jGU12kNFWA
         LtjaJJKdCOGUIT8BMH1rN6N3hCAQ1l2J8BCaa+2CXVdc8p+nAms/txPtzYvf9pKU+u0F
         CURJ0CF8gYIFvuamGfJPugmXT5Kn8kUH4Blpl5P/AXGcQ+Ln/raYk6kQLYit4CVMdZAU
         XETsP3iieOy0F4VDY9v71xTiDLQzMnvVabzQySs33EauvjTKTdD7V8YT8LKBf96fZU9R
         9XKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163549; x=1772768349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jM2jRE52GoildGbNHzk6XHpEWFB/sro6HR27gtYvH8Y=;
        b=UhRWG15R1PitgC6lyV/eJBkIQRUcxRux/5AyehBr+OF58cBQItgVxDXwA+uENj3xRZ
         5AiLVEfvmXIeTeG8DmJ5UhtYax5JLAErfYjIsUVLCeQDgqW+MKEs6ia+mFukNiVXSVZc
         TGZ9H9xopyzzhiV7ad7MZiFfXoY9A70wHKcb7C6Tgtr9DC/z9xDNB72QvEKpveykGR14
         uU72pjyPKvlRmW80A7hMNdgRq5ok0D8xSiFuVav4S1LRcSCH/GeMGSwejgXzXfLerpo/
         mIDH5aKRhO97G2gMhAoDagAjfaCRsALF5pEUG3KITEZprE7BGuCsIkExiHcRizgwTHxN
         TUXw==
X-Forwarded-Encrypted: i=1; AJvYcCVg6SDKa1H22N/mWPiyG5H07WmTS0eoIZ0p4/ibZrRPyjxEmfwgqtctUOJg/t5k1gtt5PQkHTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVmktr+h6XGbvqVfkShqbNmRWD+OW3Vx5ZB/jJndycEdtIv1r
	aXuvU88AmOCgaT2o5bboBQ2R1v22aKkWXiPXXYXwD7xQzkOzJegqc5IyhWNkY2MX2X65PoTsfsB
	E5PeyJA==
X-Received: from pgbdk13.prod.google.com ([2002:a05:6a02:c8d:b0:c6e:7278:d9e1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:db09:b0:394:5cc8:6226
 with SMTP id adf61e73a8af0-395c3b403a6mr1618324637.69.1772163548559; Thu, 26
 Feb 2026 19:39:08 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:25 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 02/15] ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261698-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 728B91B2512
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
2.53.0.473.g4a7958ca14-goog


