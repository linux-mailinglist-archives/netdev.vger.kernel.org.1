Return-Path: <netdev+bounces-282606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHvuMsTA8mnktwEAu9opvQ
	(envelope-from <netdev+bounces-282606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:39:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E0249C691
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B3EF3063113
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCF62C326C;
	Thu, 30 Apr 2026 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gc6kr76k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBAC2C11D5
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516595; cv=none; b=DgQyzdCXBiFcfAljzIhxuE6zOGWlznLajz8KdrdexUb9uyTAUXMiAviG+3nT/s6heYUSIkvAYMtP2T8UfDI76nodUxTvuWp/h22muU6tpNDO96w2F7uIxIx02N8XPEN9Tb8vLzOgpQRdwzDFqJaVOFdCbn5jr+DRJtgA7Z6m+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516595; c=relaxed/simple;
	bh=7A2RTAO1vCMQzh9X6fi6pwsBr0zbFETbvkfBJKkLZlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pM0Yhke5qI0zEsvmMknEDEtSjjrXnTdaZCkQBBsupmlDleOBLKArvHtitBwXRmBlPNphtxE5P422bYiki8znppF7uuMWSQhXt3POH4SdRi/PytZ5zmzJQW7VH+NB9KC76ZB6Nb8vOjQgUGAYMa2BNOjvXiPI/LKm9uJ4hIpd714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gc6kr76k; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8eaee67d1bcso89661085a.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 19:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777516593; x=1778121393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZWwt6zOBMPtP6sQuMfSc4hvexqrhZskEJYlUMoZdIQ=;
        b=gc6kr76kavOd0L//+zCNT1s+BNRK+4IWZDL5OkghwW4GFDw7x/d8wX+5jRKNUAYZM/
         IkWd7zvP12SkCuThpPV3kp1GzqyYV276gHZqzaCSuUWO0IZXbnvHswzG76vzKUvcCnM5
         V3FnWL2QLAVMfeuWPoLx1m24cwdJ3boe5R1Lnl25R8kD5AivIXaMsSzkeiDzyFGvT3Gl
         4eGsJkFBunRKP4R97kNFqizOrU5qXb8OKZsyvUMPWfftqmMGMTwNBiSEks86k4KWmQcw
         IsITmN08I4MTFzC3AB4l7guUD/W7AQjzYqtrs9UxPRpi8rCQrgC9cG1T7twsk8+Aquek
         RxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777516593; x=1778121393;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZWwt6zOBMPtP6sQuMfSc4hvexqrhZskEJYlUMoZdIQ=;
        b=FPSsZf6UpuoMHXQO3HkEgjiKFmq57CbzClsg13diBGQjTSyrNxPmjDCa5jF6WeTVX7
         6augOlVdPb2NxDOkmsW+q5HZqJmlpVN49VolXHPrcYrFIpL75IZw3ZUhVX2uAZoy3PMR
         /DxXKKUqCxKH35jyz6NYseE6m4bNx5mJb1HGx+2rcyd+HKQ7+QqO73Fwkt6425GFkt90
         TASoHKL5OaWkhyrGEC1HcSkXzLDDeJj/8Z6trJkmtgdvVifpsfZnpyaThQeOxSh6y/Dq
         uonvftkoisGRiCHu3Qlpu0JpD4AtZbMo+dcLejqyCteJxbwPvVguonjdEH10UApNLNb5
         oRBA==
X-Forwarded-Encrypted: i=1; AFNElJ+HcGts/jqgoi4ZYQrNLH8R/FdooBc28xURc7yMx1C/ml6aG8UWp8/3yZLQOi7kGITz7w7Mzms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOMu0REANfcQxAVIMdd31qLfamNdT2LQlgryM+t6ouel/AuRMI
	Qe6TJfWoSfmaUaUVrG1eUnp/AY9oJGXXakSY2bcJJYN3Fe7a59CzffyfE2omWT0FONe1htCiCBf
	vsgN+dgNsDqcV4w==
X-Received: from qknrd9.prod.google.com ([2002:a05:620a:8dc9:b0:8eb:aa4:31b7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4512:b0:8e3:5bd3:c8ac with SMTP id af79cd13be357-8fa89902788mr182696385a.34.1777516593277;
 Wed, 29 Apr 2026 19:36:33 -0700 (PDT)
Date: Thu, 30 Apr 2026 02:36:26 +0000
In-Reply-To: <20260430023628.3216283-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430023628.3216283-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430023628.3216283-3-edumazet@google.com>
Subject: [PATCH v3 net-next 2/4] net/sched: tc_dump_qdisc_root() refactor
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 48E0249C691
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282606-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Change tc_fill_qdisc() to return -EMSGSIZE when skb is too small.

Change tc_dump_qdisc_root() to propagate tc_fill_qdisc() error to its callers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_api.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 32ccd4672083aa19340520155aeba6d8b6ff546c..029e0f87ea9c61cc757432a07a6af92c90c551ef 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -976,7 +976,7 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 out_nlmsg_trim:
 nla_put_failure:
 	nlmsg_trim(skb, b);
-	return -1;
+	return -EMSGSIZE;
 }
 
 static bool tc_qdisc_dump_ignore(struct Qdisc *q, bool dump_invisible)
@@ -1836,11 +1836,13 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 	if (q_idx < s_q_idx) {
 		q_idx++;
 	} else {
-		if (!tc_qdisc_dump_ignore(q, dump_invisible) &&
-		    tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				  RTM_NEWQDISC, NULL) <= 0)
-			goto done;
+		if (!tc_qdisc_dump_ignore(q, dump_invisible))
+		    ret = tc_fill_qdisc(skb, q, q->parent,
+					NETLINK_CB(cb->skb).portid,
+					cb->nlh->nlmsg_seq, NLM_F_MULTI,
+					RTM_NEWQDISC, NULL);
+		if (ret < 0)
+			goto out;
 		q_idx++;
 	}
 
@@ -1858,20 +1860,19 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 			q_idx++;
 			continue;
 		}
-		if (!tc_qdisc_dump_ignore(q, dump_invisible) &&
-		    tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				  RTM_NEWQDISC, NULL) <= 0)
-			goto done;
+		if (!tc_qdisc_dump_ignore(q, dump_invisible))
+			ret = tc_fill_qdisc(skb, q, q->parent,
+					    NETLINK_CB(cb->skb).portid,
+					    cb->nlh->nlmsg_seq, NLM_F_MULTI,
+					    RTM_NEWQDISC, NULL);
+		if (ret < 0)
+			goto out;
 		q_idx++;
 	}
 
 out:
 	*q_idx_p = q_idx;
 	return ret;
-done:
-	ret = -1;
-	goto out;
 }
 
 static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
-- 
2.54.0.545.g6539524ca2-goog


