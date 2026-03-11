Return-Path: <netdev+bounces-266755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFVbFNW/sWkwFAAAu9opvQ
	(envelope-from <netdev+bounces-266755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:17:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C422692D2
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6F723126721
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFAA372B27;
	Wed, 11 Mar 2026 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ZY68XfW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF91E8320
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256425; cv=none; b=QQiLHm/y4L1qnH+1/SN0anZyf1K9NxivjkcHKrLcqD/s5Wa7xMA/8Rh8lBwPBAPpvBa7RZRnMSVCux6NlFiaoigO/57Bf+dFKXxLf4ukJKdiNkZv280I8m2DROYWN2FHFipdzq4MM5TzxgPgSkbKltAT3VBTPffjqD3545D1QWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256425; c=relaxed/simple;
	bh=S8QKUqpGzGzisTLh8aaFTAVkSUuuWisu142oQfvPALQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sQsl4hxROHM0ztPlN1FPKfYgGXj5vZBdAb+uf2h+LiuAGEds6Ay5KJcrlAKSX7qUA6GHnwo4x5LdXfBjySGQjHXpP+i7YF/+rEbIG86HRJG34gm8jBkYDHFc+s4DLuT0Rh9TTFrC6a7cgH7YY5VZeI+941LxClvv0XtkfFCWNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ZY68XfW; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cd7f6ac239so104123285a.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773256423; x=1773861223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zslP9GG38UrSlaERzGOdn87DTk40RRX2h4DYJhBDKnU=;
        b=1ZY68XfWM4RzL2aFJYVDXkckIfJOl1Hc7T3ppMROcczEDDgGaqGilHz8XlimJZawFN
         1l+6dAzoj5RcwQW09wmOyuIIZ3RUnQwLe0tZqHa2+6noQ2jAOfLz/92M+idfvWX+Wo86
         ROFvr5nWqqszyvtDFDVPiUU1SdX1A7uKEyiLuKhSoQ6ZcpTa/fjSxyYiC4vLaYTak2bR
         jQFyKAsXcCuKgt8RYX7Wu8PAzhkuzzcwQOpGfpJs4smehLMdXpz6AzR0wsjNO8yJ0Vyv
         2LWjaxwC7q/1z5Pkpn3YkgT2b7LduqZNOQLt+jHnhng+XClg1AsGmuzKNLzvybOry8Wh
         Z1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256423; x=1773861223;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zslP9GG38UrSlaERzGOdn87DTk40RRX2h4DYJhBDKnU=;
        b=jqNvTcp58z1W3916u281ZdSv1Jc8I+RIm7xPlV1teSy7zjy+Ab0i2GBTekUjf3caTp
         5L6m6Q8r6xwBEpLoT+7lLpVCpdnLPG7HGNodY+YZOX3x2i4vfThL52Z/excb5X03RveU
         9H7T53UH4k2lawbq46bg/s7CWSbhEnZnD5QSsVYcA0pfRXTGNm5bk+E2GV8nPlRSpkjp
         0xkjGSufQqAmgROytSs+t904udDZ24hffqEMFmRnTzWJ3nZcmd8t4VS9SvqQmV2Rnc+C
         f5/lvyPo1k2kThJsjdcdeTc4X+jiX422lYzmZz8OaTWToqf9O/m1nh+rXdujY8AbubT8
         2CPg==
X-Forwarded-Encrypted: i=1; AJvYcCUzTUF7Ij7hh85MUq4aNcJEHEDYvhlXfWjH8Bhtbzyp0A4T81v975+fxnZCbU9+yecuLJg3oK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZ0K4ec7zDLm3vAeizNG7Or+bBZaR0BQv6DZI77m46gKsJ5eY
	dqmn3R5H5LU9STiypyOODV0eHhVNWNsaPJvxqgRBvsxNAyIB68SIS24XFR606FHRzYd5eNak3+l
	81xqKqNR023hapQ==
X-Received: from qknwm10.prod.google.com ([2002:a05:620a:580a:b0:8cd:8ab2:545])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7006:b0:8cd:580d:6e82 with SMTP id af79cd13be357-8cda1a1962emr460425785a.46.1773256422626;
 Wed, 11 Mar 2026 12:13:42 -0700 (PDT)
Date: Wed, 11 Mar 2026 19:13:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311191340.1996888-1-edumazet@google.com>
Subject: [PATCH net-next] net: add skb_defer_disable_key static key
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266755-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5C422692D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a static key to bypass skb_attempt_defer_free() steps
if net.core.skb_defer_max is set to zero.

Main benefit is the atomic_long_inc_return() avoidance.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/net-sysfs.h       |  1 +
 net/core/skbuff.c          |  5 +++++
 net/core/sysctl_net_core.c | 25 ++++++++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.h b/net/core/net-sysfs.h
index e938f25e8e86f9dfd8f710a08922c4cabf662c2e..38e2e3ffd0bdc4ccea2f6c7636c1bbc7d0f46af5 100644
--- a/net/core/net-sysfs.h
+++ b/net/core/net-sysfs.h
@@ -13,4 +13,5 @@ int netdev_change_owner(struct net_device *, const struct net *net_old,
 
 extern struct mutex rps_default_mask_mutex;
 
+DECLARE_STATIC_KEY_FALSE(skb_defer_disable_key);
 #endif
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 513cbfed19bc34bbb6767cdd7a50dad68be430fb..3d6978dd0aa83f63984b994359d0c914c6427a00 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7256,6 +7256,8 @@ static void kfree_skb_napi_cache(struct sk_buff *skb)
 	local_bh_enable();
 }
 
+DEFINE_STATIC_KEY_FALSE(skb_defer_disable_key);
+
 /**
  * skb_attempt_defer_free - queue skb for remote freeing
  * @skb: buffer
@@ -7272,6 +7274,9 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 	bool kick;
 	int cpu;
 
+	if (static_branch_unlikely(&skb_defer_disable_key))
+		goto nodefer;
+
 	/* zero copy notifications should not be delayed. */
 	if (skb_zcopy(skb))
 		goto nodefer;
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 502705e0464981ecfc32233d22c747e14b3febf7..b508618bfc12393ba926ebf5a2dd4ea73ef03ee8 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -349,6 +349,29 @@ static int proc_do_rss_key(const struct ctl_table *table, int write,
 	return proc_dostring(&fake_table, write, buffer, lenp, ppos);
 }
 
+static int proc_do_skb_defer_max(const struct ctl_table *table, int write,
+		 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	static DEFINE_MUTEX(skb_defer_max_mutex);
+	int ret, oval, nval;
+
+	mutex_lock(&skb_defer_max_mutex);
+
+	oval = !net_hotdata.sysctl_skb_defer_max;
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	nval = !net_hotdata.sysctl_skb_defer_max;
+
+	if (nval != oval) {
+		if (nval)
+			static_branch_enable(&skb_defer_disable_key);
+		else
+			static_branch_disable(&skb_defer_disable_key);
+	}
+
+	mutex_unlock(&skb_defer_max_mutex);
+	return ret;
+}
+
 #ifdef CONFIG_BPF_JIT
 static int proc_dointvec_minmax_bpf_enable(const struct ctl_table *table, int write,
 					   void *buffer, size_t *lenp,
@@ -650,7 +673,7 @@ static struct ctl_table net_core_table[] = {
 		.data		= &net_hotdata.sysctl_skb_defer_max,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_do_skb_defer_max,
 		.extra1		= SYSCTL_ZERO,
 	},
 };
-- 
2.53.0.473.g4a7958ca14-goog


