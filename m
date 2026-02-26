Return-Path: <netdev+bounces-261127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOipLh6yn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:38:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD31A027A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C70D03039ECB
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57FE378825;
	Thu, 26 Feb 2026 02:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zDFiL3Zi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4EB3783CB
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073408; cv=none; b=I2O47V6anroQQcJnN2bn05wuUxUWikFrgXm62JOmOz6CN48yVIYtYU06z6JxnumJ3UPrZ9z1LbWYM71OMRDAT0+5Zh5Cuz8dsOkC5IBVHT+xkEyYWQQkjvtRRwaMTb7T/STtg+Ks/ZN24zBMEUSapNolkVwJ+LBllF4sFtwTQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073408; c=relaxed/simple;
	bh=TxElnz8etyRrDjzxoYnLqPFI/gxChg0wDj+b+eqHF6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pPv33KmbUyIUNKSyS8XhWEn/uyfkdtiOjMagsmko0qXdGAqqw9Cup1pjjrgm5jQUH94kLh13R/9b9d/0bIRJntjJRoiGOlZ+71Oqrxbc7IphZqbeN2bPaGWEt8POgdVeVK23C0ukEpuUfKip6Jvj1Xbtsz+JtYzHOkmfPJQvpZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zDFiL3Zi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c6e1dab2328so1334544a12.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073407; x=1772678207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mM0QVhyFIOOIwqpYioW7bXwyl8Sva+0Ve/5FcAcHPsQ=;
        b=zDFiL3Zi/Je1n98dZA1VFBgzGBaGmFiKQ0pJW9aI35UbILpWgIB4O4F7pBOuYmntLD
         gVn+sx+ZVPqkAqQR7r1Y/K7zHbd0JZwoLcQJcgTwd1ISG3Rd4dOZM+iPiB59fg/gtFCM
         R7U/LGTbck6kcWLvkXmHjnp5s515IsliRob5xLM8wFAhz8FVwZQd178NOLeivB+0ud2E
         /iKERzCsXby1D3dHAMzgKaMRaGetUlew+grchU+26YiZyqi4iTvsw6+nsIz5gc1X59Eg
         ANjA2uMauIDU5nCnd+V4uTC6nnChMIQpL29n2DzMX0jG9kGptb5IPDpFIjjaWnfSO8xr
         5Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073407; x=1772678207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mM0QVhyFIOOIwqpYioW7bXwyl8Sva+0Ve/5FcAcHPsQ=;
        b=HF2UlKw6gveJyBwh/BtCpAp4CvD0FEyuw7TnuqRKg0yBBrd+xCpcWyCw1Wg/+Uq5Uh
         f9WjisKrlNLS2m/oMcMjLYbobK+hw5W8AYPCjqFe+Fv6VMa31dUKdQRDCa9LYCZA/9Fp
         kKSm2qzIbheBHbYBXDXmCMaYUBDIYO5Gss/xmuByI4WVaAsQUrxFZAbBvwPbVJpd+IsY
         ukc4EzVoUYB4Y1J8GaIupEFiqdomvq/byLSTaIW+8mD3iN6K4achb0mb4ivwK61lXqkH
         oCiL6p78y2+S5g/swCvAOKHTby93HUIB+Cc+i2fiCOzcEMuAxsClZyRs2ZqDEGxJJ0zB
         yATg==
X-Forwarded-Encrypted: i=1; AJvYcCU9iE4quSSoqbp4aBiOEbIY8WP6Svc5j7jEzvmooK8D+N4uhg0ouIOkm/yujsKJOJMFNa6216w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKh3hUNr8tUHtERfNKlciGuPXB2HeeJpSUOB+E79Pv8yXmQERc
	YbtwPpDbipkJ1ktEF3zog8z1qG1leOVkB14gpLS2wUjCXmorn7jrFmyXlaAR0BbAep9gWpRYKE0
	bsU+n2w==
X-Received: from pgbgc9.prod.google.com ([2002:a05:6a02:4b89:b0:c70:e8d8:1404])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9186:b0:38b:ec0d:51ed
 with SMTP id adf61e73a8af0-395b49a390emr817093637.69.1772073406655; Wed, 25
 Feb 2026 18:36:46 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:16 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 04/15] ipmr: Use MAXVIFS in mroute_msgsize().
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
	TAGGED_FROM(0.00)[bounces-261127-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 4EBD31A027A
X-Rspamd-Action: no action

mroute_msgsize() calculates skb size needed for ipmr_fill_mroute().

The size differs based on mrt->maxvif.

We will drop RTNL for ipmr_rtm_getroute() and mrt->maxvif may
change under RCU.

To avoid -EMSGSIZE, let's calculate the size with the maximum
value of mrt->maxvif, MAXVIFS.

struct rtnexthop is 8 bytes and MAXVIFS is 32, so the maximum delta
is 256 bytes, which is small enough.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index a4bc653e04ed..7b5177b673d3 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2510,7 +2510,7 @@ static int _ipmr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 				cmd, flags);
 }
 
-static size_t mroute_msgsize(bool unresolved, int maxvif)
+static size_t mroute_msgsize(bool unresolved)
 {
 	size_t len =
 		NLMSG_ALIGN(sizeof(struct rtmsg))
@@ -2523,7 +2523,7 @@ static size_t mroute_msgsize(bool unresolved, int maxvif)
 		len = len
 		      + nla_total_size(4)	/* RTA_IIF */
 		      + nla_total_size(0)	/* RTA_MULTIPATH */
-		      + maxvif * NLA_ALIGN(sizeof(struct rtnexthop))
+		      + MAXVIFS * NLA_ALIGN(sizeof(struct rtnexthop))
 						/* RTA_MFC_STATS */
 		      + nla_total_size_64bit(sizeof(struct rta_mfc_stats))
 		;
@@ -2538,8 +2538,7 @@ static void mroute_netlink_event(struct mr_table *mrt, struct mfc_cache *mfc,
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(mroute_msgsize(mfc->_c.mfc_parent >= MAXVIFS,
-				       mrt->maxvif),
+	skb = nlmsg_new(mroute_msgsize(mfc->_c.mfc_parent >= MAXVIFS),
 			GFP_ATOMIC);
 	if (!skb)
 		goto errout;
@@ -2711,7 +2710,7 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		goto errout_free;
 	}
 
-	skb = nlmsg_new(mroute_msgsize(false, mrt->maxvif), GFP_KERNEL);
+	skb = nlmsg_new(mroute_msgsize(false), GFP_KERNEL);
 	if (!skb) {
 		err = -ENOBUFS;
 		goto errout_free;
-- 
2.53.0.414.gf7e9f6c205-goog


