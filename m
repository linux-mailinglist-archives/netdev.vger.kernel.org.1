Return-Path: <netdev+bounces-296967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eRMwFYTOJ2po2gIAu9opvQ
	(envelope-from <netdev+bounces-296967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:27:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B03E065DC4E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:27:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Edla6q1t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296967-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296967-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC2C930C55C5
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15493EB7FB;
	Tue,  9 Jun 2026 08:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7E3ECBE3
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:11:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992684; cv=none; b=sKANK9ynxmriYKCEKDyjjhjSEQRpaT31Z+tBFsgnHF4ibqLQdNUE+Lgyi3eKKMaFU1EcCCPv35S4su7Euj5aISANIrUYa1WBcXzZdR8pyphcxd2aa2ZLcGrvUC0vbLTEFKK7GhS7Bzbo9LjnvzqFziLpPshj0BvoXr2KDL/N6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992684; c=relaxed/simple;
	bh=r1iZ8a8iXyFQ7e9Yk84WkiexC6WpGev9TRhdGflQeHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqMLoc4XUOv/KyxKb+8FeGBVhm+Cgn+NwlIee3Qycw7rSbsEnyFvlEkhbsROqTNqo+CBXI6nF7UVSDN+fuFZ2Y9Xgqd34RTGoKaMDQKLHC6FzvQAxjXix0ka3nuWxWIbfdbgASlbFcih+t1iM/1jEAf+4De3g6zhY1pgQ5PJ54w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Edla6q1t; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf2247e38eso54100035ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780992683; x=1781597483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBALkfms9XINseZbRMjuo3U/MLkG0sUOcIH6JBjP30w=;
        b=Edla6q1tkmpw+jJ3Kj6bknNJWb4Uv6MG+ExQJLv2gSN2lckF3CZjkIv0tRvl1D6Mk1
         h16ZY4AB3cXmpjOcEy3bDGeHJjqm7T1tegDB3/VNZ1VV74yyPLiJ8xxi2sFQEAGJi9k1
         A5aHcqhCVao0Ggrm2iyUR9yvlU5qP+BnB0KMFv8NNuDGV/tVb/7RFgd60xeCHWpfwJ8o
         FZ8KN99pbqfj+FXdOUbxGSOzkz+vCnYDBqZtZN/v7IdPK0MpaC8inDcodCe31YNNlWwf
         RhvdtVEPtVlsgiSXOROSCpaYyhTTXa118IQumwnr+IS+yIU+jMaXFjgKJ5pFWJ47ivXw
         pA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992683; x=1781597483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBALkfms9XINseZbRMjuo3U/MLkG0sUOcIH6JBjP30w=;
        b=OKCAzjIfByzcA123xY7e6A5bCL0fSpTKd1ZVgCt6Dlj7AHIUZWhpLol/mT386c0LT0
         zDZnua3AmEwztx/HwpdySv1j/Tsf86tX7QlUyjnp5/XDuIAnWbFiuFgMx72OObINCDG0
         ZsEI4h8oRoG4KUvdOC7viY6AHSk2i+vVujIM2iVtUktwKsga78xlmx7FzoHfjJMoGBf5
         BPmH2OAv/AQRqYs7kSLQWEc3xoEJjIQxAlnGJvZLQHZTtCKLt3DRda3BvRZ0N8CMettA
         E2b4Kshl21I0xSCzd7bGg4LZSi453iH20gdljQFDRqd0UGtvTarrqZ5kag1DpCjcVuGY
         /4Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/qaDNTL/lDz6lvg3tcbZpDPGK6YBq5IUxJtbTUQTXGhTBpqfkIOMo8lGkY9iE4o1VLzNqrasQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdm4uwIQ5PVoX3kvmJINdZ+7uCGF3FYf+StFanRSWpM8T7I2zl
	tsJ5bp3ZZ0ujVGBV6N0jPGELTFzoCUpZ/hx/W94y9f4407MCT1mbAPdd
X-Gm-Gg: Acq92OHPANsE6GZwOf6Bf/SWE/aWZYJT4BzkKeaHrV6EzBwy5hwcwNPzJJRw9d3yC/T
	pQE9OIxQnDJeSY3gGOVPAS9Lb43vf/xTjtYwk0FJpf6JQ9xWvGtWewraupb6FGcoDs2YwTJjpeh
	XmvRMeWAeKKOjbYB/opgJ2k8LX1VxnVvYpa6A7Dz4B+re8Qw70zA08MAHMSlw38NmfRBiDgQcfS
	eIFjVRp9n2jXMaO4Qb7xj8C5GhZqfN4nzuRuuFpasNqxzhmI6UxrkwLeaKaFvHzK9taonwnHDGG
	R6XA3v4FAKMi12zP2tsj4gdCDdc6KLph1HLOm+FuPWrCNl1pE4mfwEo5Z41JLIc5/bosIeImd1z
	OsUGTV2iVWATVeaZJwmb4WgeNjYQa1wcnk/kMmUgO9f2MIzHUSzVv03p9xTvUHT99hWpv2IMeCE
	RXfbkRnzUVTx3uCQWm9PTy/n0GywNtemFrxhUUVK/0k6AyUiABww4=
X-Received: by 2002:a17:902:ccc3:b0:2c0:c38d:9d37 with SMTP id d9443c01a7336-2c1e849534amr204019695ad.25.1780992682952;
        Tue, 09 Jun 2026 01:11:22 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:2853:d025:c3b5:3342])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c166391d53sm263000845ad.65.2026.06.09.01.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:11:22 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] ipv6: mcast: annotate data-races around mca_flags
Date: Tue,  9 Jun 2026 17:11:12 +0900
Message-ID: <20260609081113.7613-2-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609081113.7613-1-sigefriedhyy@gmail.com>
References: <20260609081113.7613-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-296967-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B03E065DC4E

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


