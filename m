Return-Path: <netdev+bounces-295849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k864MLjlImq/ewEAu9opvQ
	(envelope-from <netdev+bounces-295849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:05:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C816491BC
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:05:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HTNNqYmZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295849-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295849-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 228CB303689D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00123F4850;
	Fri,  5 Jun 2026 14:58:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14C03EFD1C
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 14:58:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671490; cv=none; b=l/hF6rjuaLJYgMeJU4H+OFiM1Dla/dACP81tIivxble6sOtFbFG9pUDGJSerGu1DipSd4UEvxHONxtu2XRXI1ftwLjLwyZGxYzQLYUrkm6d8F1XOQVSR98EL+/rvuCPoaAo0n3QiGUrfh1/wRLHTWk/1ZwkRfVgOE8nuhTLMt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671490; c=relaxed/simple;
	bh=r1iZ8a8iXyFQ7e9Yk84WkiexC6WpGev9TRhdGflQeHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNiKpmwOgV0RUkMQW/QDRg5Vf+AH+iGQLWueKq6pH8UVGeZDQThvUYUP1N0SROQL9q4YXBtviY7gv0D7tpuGc/vwFS9ejjD46INr23pPMz8STVEaVF1K5gpxrWAXjbnN61dIY/0Q3Vu4nWmKHzE/txuKzPQKtc8TtnEgJRHr6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTNNqYmZ; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so1359440a91.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780671489; x=1781276289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBALkfms9XINseZbRMjuo3U/MLkG0sUOcIH6JBjP30w=;
        b=HTNNqYmZLRAoLk4iXYiwjSK8k5m8Fs6u9WeisDtypgFcvCNmHFBNuKz9LHLgrwCSDd
         eSWj5N+TcSEIjmWVBHza98mFMus+nIG187pk+sqzFfwhMjzfwyhjgIw/h9wpH2Yv9bua
         FfV99zXXvuqWw9Gj3pA5XocaGKqGXYGSEt/a+QOYn8qbMMHmmFctiawaRFGj+DmpAvyT
         cMMeAN0sAg0xqMIhDSvLiXbGksmT1mJi/9yw7TvpO/HxY+MirMo2rF8kc03beKDBZZNZ
         +y9ETDTEvle1xbftVHduSvO9A5AFrl/Eq0tccqP1gCtcBbjKvVeXCyrGGAswO6Rn4kv2
         QK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780671489; x=1781276289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBALkfms9XINseZbRMjuo3U/MLkG0sUOcIH6JBjP30w=;
        b=pocZHxTVA2QtHVZKyeVDcEgQFdhoLlo9/FGwfOiGZeWmmotI/Fmug2O8oW6w9/4APB
         iC3rVNAelEANIluVvF0Ron1ggowCrLx7i6ftiPCX0XCVYu3UZApXMwkJSSied0RJQOTA
         zk+8Nl14xY9FBxegoC7jFzQIIxbAjH3rswsyCWNzB3X2uZhlcqC0BvKLTvMXyS2JEc2j
         bjs5nLpF+KDDrqOPGFbyJ+IE9eKoB9TA0C5zhEVsFQ41Y9YGk68woxBDgaBBKp0jPDz1
         MBdW+FoKY15jDpfrf5JZNYmxlvGHz86+keoejiadHlH/mG87MixqZ19hG/9gfeNSxgxM
         a6JQ==
X-Forwarded-Encrypted: i=1; AFNElJ/a6Jf/YitOE/tC9IEhClmFPdohhUf0tRHTVsiCoKYNMvyRx0uKUXQGAWrKaA/KAJqWVKePm7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfGjIsA8PtQDLEPCnMvOoFfA5lNaBq4Z5YWW9Aehoq8VsMrtJQ
	H9j1WcQtRsyaaGYUwXahR+leQR2FEtFiIyVCfysoP5ac3JmKFAKyS5Qa
X-Gm-Gg: Acq92OG7zjBPxO9GT5P4vMz0qVFnOVe8CXXqpdvAD/InVMfqauGyscEBYJ2XfxJccZo
	Iat7vb9WLBuccRbOBhGRHuCrTRHkmga2m4jH5vEtg1aoXq3h3Ag8/1dpJVTsEOa47z1/IdCVOW5
	C/awzghGaOzJ26qmTik6DIWzSGj+wfjejlPmcR7OTYKsYg4HVoTWKzjLR+Y3wEkQ08+a4MS9eYb
	ZWh0foCmfzkzPs7ZITQj6/Djsp+N2q7qZznChEOqw/4aUj9HLUSIpXGp1pWgRN9k4s85XTd6viu
	EOiPJuWsJYN3EaSVjZAoyyKD4Ldx/TahL5jgkPqfb/hs3FHigj8/OelUWcgLm8SaI5QiHf9iYJc
	F89aLyqFCpI8pUCC+xo+U4N31oH1krIY8WB2BClI5PNupTFxI4LBRdv9ES66W3iP0UH7uyOJ9Kq
	j41APYuY6rAwlMaULNrP2V43qmHoQeLvHgyNNDkn/N3eXasa3y2Jr9acR6P4z2aa/W
X-Received: by 2002:a17:90a:d643:b0:36b:b4a1:2939 with SMTP id 98e67ed59e1d1-370efda7ab1mr5078417a91.15.1780671488822;
        Fri, 05 Jun 2026 07:58:08 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:1cda:ba68:a654:c3cf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a28c0esm7058231a91.12.2026.06.05.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:58:08 -0700 (PDT)
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/2] ipv6: mcast: annotate data-races around mca_flags
Date: Fri,  5 Jun 2026 23:57:58 +0900
Message-ID: <20260605145759.59639-2-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605145759.59639-1-sigefriedhyy@gmail.com>
References: <20260605145759.59639-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-295849-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67C816491BC

/proc/net/igmp6 walks IPv6 multicast memberships under RCU and
prints mca_flags without holding idev->mc_lock. The multicast paths
update the field while holding idev->mc_lock.

Annotate this intentional lockless snapshot with READ_ONCE() and the
matching writers with WRITE_ONCE().

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 net/ipv6/mcast.c | 52 +++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index b8901c921c5e..bd3972730aa0 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -676,7 +676,7 @@ static void igmp6_group_added(struct ifmcaddr6 *mc)
 		return;
 
 	if (!(mc->mca_flags&MAF_LOADED)) {
-		mc->mca_flags |= MAF_LOADED;
+		WRITE_ONCE(mc->mca_flags, mc->mca_flags | MAF_LOADED);
 		if (ndisc_mc_map(&mc->mca_addr, buf, dev, 0) == 0)
 			dev_mc_add(dev, buf);
 	}
@@ -712,7 +712,7 @@ static void igmp6_group_dropped(struct ifmcaddr6 *mc)
 		return;
 
 	if (mc->mca_flags&MAF_LOADED) {
-		mc->mca_flags &= ~MAF_LOADED;
+		WRITE_ONCE(mc->mca_flags, mc->mca_flags & ~MAF_LOADED);
 		if (ndisc_mc_map(&mc->mca_addr, buf, dev, 0) == 0)
 			dev_mc_del(dev, buf);
 	}
@@ -886,7 +886,7 @@ static struct ifmcaddr6 *mca_alloc(struct inet6_dev *idev,
 
 	if (ipv6_addr_is_ll_all_nodes(&mc->mca_addr) ||
 	    IPV6_ADDR_MC_SCOPE(&mc->mca_addr) < IPV6_ADDR_SCOPE_LINKLOCAL)
-		mc->mca_flags |= MAF_NOREPORT;
+		WRITE_ONCE(mc->mca_flags, mc->mca_flags | MAF_NOREPORT);
 
 	return mc;
 }
@@ -1167,7 +1167,7 @@ static void igmp6_group_queried(struct ifmcaddr6 *ma, unsigned long resptime)
 
 	if (!mod_delayed_work(mld_wq, &ma->mca_work, delay))
 		refcount_inc(&ma->mca_refcnt);
-	ma->mca_flags |= MAF_TIMER_RUNNING;
+	WRITE_ONCE(ma->mca_flags, ma->mca_flags | MAF_TIMER_RUNNING);
 }
 
 /* mark EXCLUDE-mode sources */
@@ -1195,7 +1195,7 @@ static bool mld_xmarksources(struct ifmcaddr6 *pmc, int nsrcs,
 			}
 		}
 	}
-	pmc->mca_flags &= ~MAF_GSQUERY;
+	WRITE_ONCE(pmc->mca_flags, pmc->mca_flags & ~MAF_GSQUERY);
 	if (scount == nsrcs)	/* all sources excluded */
 		return false;
 	return true;
@@ -1227,10 +1227,10 @@ static bool mld_marksources(struct ifmcaddr6 *pmc, int nsrcs,
 		}
 	}
 	if (!scount) {
-		pmc->mca_flags &= ~MAF_GSQUERY;
+		WRITE_ONCE(pmc->mca_flags, pmc->mca_flags & ~MAF_GSQUERY);
 		return false;
 	}
-	pmc->mca_flags |= MAF_GSQUERY;
+	WRITE_ONCE(pmc->mca_flags, pmc->mca_flags | MAF_GSQUERY);
 	return true;
 }
 
@@ -1499,18 +1499,25 @@ static void __mld_query_work(struct sk_buff *skb)
 		}
 	} else {
 		for_each_mc_mclock(idev, ma) {
+			unsigned int flags;
+
 			if (!ipv6_addr_equal(&group, &ma->mca_addr))
 				continue;
-			if (ma->mca_flags & MAF_TIMER_RUNNING) {
+			flags = ma->mca_flags;
+
+			if (flags & MAF_TIMER_RUNNING) {
 				/* gsquery <- gsquery && mark */
 				if (!mark)
-					ma->mca_flags &= ~MAF_GSQUERY;
+					WRITE_ONCE(ma->mca_flags,
+						   flags & ~MAF_GSQUERY);
 			} else {
 				/* gsquery <- mark */
 				if (mark)
-					ma->mca_flags |= MAF_GSQUERY;
+					WRITE_ONCE(ma->mca_flags,
+						   flags | MAF_GSQUERY);
 				else
-					ma->mca_flags &= ~MAF_GSQUERY;
+					WRITE_ONCE(ma->mca_flags,
+						   flags & ~MAF_GSQUERY);
 			}
 			if (!(ma->mca_flags & MAF_GSQUERY) ||
 			    mld_marksources(ma, ntohs(mlh2->mld2q_nsrcs), mlh2->mld2q_srcs))
@@ -1618,8 +1625,9 @@ static void __mld_report_work(struct sk_buff *skb)
 		if (ipv6_addr_equal(&ma->mca_addr, &mld->mld_mca)) {
 			if (cancel_delayed_work(&ma->mca_work))
 				refcount_dec(&ma->mca_refcnt);
-			ma->mca_flags &= ~(MAF_LAST_REPORTER |
-					   MAF_TIMER_RUNNING);
+			WRITE_ONCE(ma->mca_flags,
+				   ma->mca_flags & ~(MAF_LAST_REPORTER |
+						     MAF_TIMER_RUNNING));
 			break;
 		}
 	}
@@ -2018,8 +2026,10 @@ static struct sk_buff *add_grec(struct sk_buff *skb, struct ifmcaddr6 *pmc,
 	if (pgr)
 		pgr->grec_nsrcs = htons(scount);
 
-	if (isquery)
-		pmc->mca_flags &= ~MAF_GSQUERY;	/* clear query state */
+	if (isquery) {
+		/* clear query state */
+		WRITE_ONCE(pmc->mca_flags, pmc->mca_flags & ~MAF_GSQUERY);
+	}
 	return skb;
 }
 
@@ -2612,7 +2622,8 @@ static void igmp6_join_group(struct ifmcaddr6 *ma)
 
 	if (!mod_delayed_work(mld_wq, &ma->mca_work, delay))
 		refcount_inc(&ma->mca_refcnt);
-	ma->mca_flags |= MAF_TIMER_RUNNING | MAF_LAST_REPORTER;
+	WRITE_ONCE(ma->mca_flags, ma->mca_flags |
+		   MAF_TIMER_RUNNING | MAF_LAST_REPORTER);
 }
 
 static int ip6_mc_leave_src(struct sock *sk, struct ipv6_mc_socklist *iml,
@@ -2713,8 +2724,8 @@ static void mld_mca_work(struct work_struct *work)
 		igmp6_send(&ma->mca_addr, ma->idev->dev, ICMPV6_MGM_REPORT);
 	else
 		mld_send_report(ma->idev, ma);
-	ma->mca_flags |=  MAF_LAST_REPORTER;
-	ma->mca_flags &= ~MAF_TIMER_RUNNING;
+	WRITE_ONCE(ma->mca_flags, (ma->mca_flags | MAF_LAST_REPORTER) &
+		   ~MAF_TIMER_RUNNING);
 	mutex_unlock(&ma->idev->mc_lock);
 
 	ma_put(ma);
@@ -2972,13 +2983,14 @@ static int igmp6_mc_seq_show(struct seq_file *seq, void *v)
 {
 	struct ifmcaddr6 *im = (struct ifmcaddr6 *)v;
 	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
+	unsigned int mca_flags = READ_ONCE(im->mca_flags);
 
 	seq_printf(seq,
 		   "%-4d %-15s %pi6 %5d %08X %ld\n",
 		   state->dev->ifindex, state->dev->name,
 		   &im->mca_addr,
-		   READ_ONCE(im->mca_users), im->mca_flags,
-		   (im->mca_flags & MAF_TIMER_RUNNING) ?
+		   READ_ONCE(im->mca_users), mca_flags,
+		   (mca_flags & MAF_TIMER_RUNNING) ?
 		   jiffies_to_clock_t(im->mca_work.timer.expires - jiffies) : 0);
 	return 0;
 }
-- 
2.43.0


