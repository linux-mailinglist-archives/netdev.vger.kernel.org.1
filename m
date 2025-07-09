Return-Path: <netdev+bounces-205333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EDFAFE370
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987701895818
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A09B283FFD;
	Wed,  9 Jul 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JggS91Kk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C8C2820BA
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051736; cv=none; b=nqmGpfbPsFoGZ94O+EZWOdgvzdxIIF7dzg2AhRl+9jgBo30d4CsfNoytnZL0KHPFtnDusK6ls1lMNIa5gbtBCXmUaoBfGR5kMLjDbmJh0KkvhskefuHDRkuF52ZQE2SuWRX0XYY37MkI2tLzvz7Uy4xeV7evUphl5tUoAnhSzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051736; c=relaxed/simple;
	bh=arWgZaEfKbFcoGCkKFMyvqETdMlVAV9+nnDyQa4AQWE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LQ8YAvDv+ffPpcSfgUgMjvUyiIW5EjCiqC3HpgBM/O7ipo31p0YUx5CzVM9pFSbU0gZp41PKxqq7svjKxSujKz0xBueatoiKsqX10TIDNjl0SQBl+npGQmU5DJfW06m2GM6zmKzX0QSzXulxsNS6mXevnapgN+1f5cHEbKXrqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JggS91Kk; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e73290d75a8so6680029276.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 02:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752051734; x=1752656534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsEdde7gMFaWYqBWhr/9egnzYmnccqlwsELa0pu4i68=;
        b=JggS91Kkg8dAJDQe5TLvqfoImr/sQbyfbCyapK2mNILkqZYkpWWy9eLcIS8z2UfG0u
         nfTiBUqjmeXS7EQ7VhSkB8wHjqdMO5o8BTX0DoWfYH8T1VPhz+wVr9vdoenv51L7HSjr
         nlqwKmdLR0hUv2X899nOylsg1H4yi8ZeiWNOiNSwL44KOJKI3jFyMKfqL/vJGCP+0Rs1
         Iwx9uyzes4UUpa7TO2RThsO8DKUxUBIj03/t/5pHUFAMPj1mDXlMCqNQhQEB3QIGHPf1
         mW16GacIBiJpg5HpYeq2z8eQWSBW6zcxDB4BDdNpzU2g4NX7fyXGKlXRCRos01Ztq1CQ
         ORBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051734; x=1752656534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsEdde7gMFaWYqBWhr/9egnzYmnccqlwsELa0pu4i68=;
        b=M9iOBt4vNwAWFQGj+syEqmgUyGL0F6eB9brN4OdqPUGgeRM4I61SdEoAGoQLiEasdz
         mZNgqylB+8RF9yC0bjnv7qXMuhztCMaXcC4ii7ev/EC7lZQEtLyUONX42IlLe8r3mkyv
         dWUdfRHHKv+YAmIVBE4aL0Teoa6q0EE+ljJ4TgsS7ZfMQ67CGJN+GB5uQMuFZlL+Fp2k
         9rHfA1djDa0mholrWTJ9VZ7SXSSImXosztvNys3t+jq+4FEkr7G1rsTs2G90wjPmuO8P
         +nETkIepTBpZ2dKnYBOvLbYYycbgtR2WttB9pYB7Eu126BYoBeod/n+Xy3aEPUuA5+AQ
         ornw==
X-Forwarded-Encrypted: i=1; AJvYcCV1yeuwdZIUjFPReVVkSGIkIQgc24ly3XBluroksPLEr0+4WnjabDAxXx+mgRHTkXkiLOgSyQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE4Qp2zP/V+houROMvKX8XY9zqHDYAYS6Iqn2iv1eQk6RT9yLQ
	vaJSZ4HX5m/0WifxX65Yjy9XcYXA9luQH54NVcO85/9haLLCUi1Fa9quG1Xi0/3BrsBthMU5iLy
	1oF41MS4Cy1gngw==
X-Google-Smtp-Source: AGHT+IEWUjHyTVgex+kouabc/uwCxYm11LfP/AAWKqzOoESCgqeIDXx/YorXSdcOLqEpKubmWjs0p1RGL6Wksg==
X-Received: from ybbew6.prod.google.com ([2002:a05:6902:2986:b0:e7f:698c:6317])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:4512:b0:e84:32a7:89ad with SMTP id 3f1490d57ef6-e8b6e3bb17bmr1529539276.48.1752051733885;
 Wed, 09 Jul 2025 02:02:13 -0700 (PDT)
Date: Wed,  9 Jul 2025 09:01:57 +0000
In-Reply-To: <20250709090204.797558-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709090204.797558-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709090204.797558-6-edumazet@google.com>
Subject: [PATCH v2 net-next 05/11] net_sched: act_ctinfo: use atomic64_t for
 three counters
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"

Commit 21c167aa0ba9 ("net/sched: act_ctinfo: use percpu stats")
missed that stats_dscp_set, stats_dscp_error and stats_cpmark_set
might be written (and read) locklessly.

Use atomic64_t for these three fields, I doubt act_ctinfo is used
heavily on big SMP hosts anyway.

Fixes: 24ec483cec98 ("net: sched: Introduce act_ctinfo action")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>
---
 include/net/tc_act/tc_ctinfo.h |  6 +++---
 net/sched/act_ctinfo.c         | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/net/tc_act/tc_ctinfo.h b/include/net/tc_act/tc_ctinfo.h
index f071c1d70a25e14a7a68c6294563a08851fbc738..a04bcac7adf4b61b73181d5dbd2ff9eee3cf5e97 100644
--- a/include/net/tc_act/tc_ctinfo.h
+++ b/include/net/tc_act/tc_ctinfo.h
@@ -18,9 +18,9 @@ struct tcf_ctinfo_params {
 struct tcf_ctinfo {
 	struct tc_action common;
 	struct tcf_ctinfo_params __rcu *params;
-	u64 stats_dscp_set;
-	u64 stats_dscp_error;
-	u64 stats_cpmark_set;
+	atomic64_t stats_dscp_set;
+	atomic64_t stats_dscp_error;
+	atomic64_t stats_cpmark_set;
 };
 
 enum {
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 5b1241ddc75851998d93cd533acd74d7688410ac..93ab3bcd6d3106a1561f043e078d0be5997ea277 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -44,9 +44,9 @@ static void tcf_ctinfo_dscp_set(struct nf_conn *ct, struct tcf_ctinfo *ca,
 				ipv4_change_dsfield(ip_hdr(skb),
 						    INET_ECN_MASK,
 						    newdscp);
-				ca->stats_dscp_set++;
+				atomic64_inc(&ca->stats_dscp_set);
 			} else {
-				ca->stats_dscp_error++;
+				atomic64_inc(&ca->stats_dscp_error);
 			}
 		}
 		break;
@@ -57,9 +57,9 @@ static void tcf_ctinfo_dscp_set(struct nf_conn *ct, struct tcf_ctinfo *ca,
 				ipv6_change_dsfield(ipv6_hdr(skb),
 						    INET_ECN_MASK,
 						    newdscp);
-				ca->stats_dscp_set++;
+				atomic64_inc(&ca->stats_dscp_set);
 			} else {
-				ca->stats_dscp_error++;
+				atomic64_inc(&ca->stats_dscp_error);
 			}
 		}
 		break;
@@ -72,7 +72,7 @@ static void tcf_ctinfo_cpmark_set(struct nf_conn *ct, struct tcf_ctinfo *ca,
 				  struct tcf_ctinfo_params *cp,
 				  struct sk_buff *skb)
 {
-	ca->stats_cpmark_set++;
+	atomic64_inc(&ca->stats_cpmark_set);
 	skb->mark = READ_ONCE(ct->mark) & cp->cpmarkmask;
 }
 
@@ -323,15 +323,18 @@ static int tcf_ctinfo_dump(struct sk_buff *skb, struct tc_action *a,
 	}
 
 	if (nla_put_u64_64bit(skb, TCA_CTINFO_STATS_DSCP_SET,
-			      ci->stats_dscp_set, TCA_CTINFO_PAD))
+			      atomic64_read(&ci->stats_dscp_set),
+			      TCA_CTINFO_PAD))
 		goto nla_put_failure;
 
 	if (nla_put_u64_64bit(skb, TCA_CTINFO_STATS_DSCP_ERROR,
-			      ci->stats_dscp_error, TCA_CTINFO_PAD))
+			      atomic64_read(&ci->stats_dscp_error),
+			      TCA_CTINFO_PAD))
 		goto nla_put_failure;
 
 	if (nla_put_u64_64bit(skb, TCA_CTINFO_STATS_CPMARK_SET,
-			      ci->stats_cpmark_set, TCA_CTINFO_PAD))
+			      atomic64_read(&ci->stats_cpmark_set),
+			      TCA_CTINFO_PAD))
 		goto nla_put_failure;
 
 	spin_unlock_bh(&ci->tcf_lock);
-- 
2.50.0.727.gbf7dc18ff4-goog


