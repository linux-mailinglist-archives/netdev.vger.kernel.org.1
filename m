Return-Path: <netdev+bounces-251056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0243D3A76B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 402BD300533E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD595318BB6;
	Mon, 19 Jan 2026 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V1j/l9jC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F531987B
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823562; cv=none; b=PZoEGHpkzKdYohah1Fv50Ub41odRhgtT1AC5/4zcQ5Pw2XNT8xvgSAgXRuGpVmD5igHaLLeBbk3roWlvwd05t338gqIF98xn1VcXU9Q/Qs0BZY9ahm1K9X+jk7j8pFQshGky8imHMyJdzEIAm97wgqFmVD/KxYNxVni3FGCLN7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823562; c=relaxed/simple;
	bh=7s21PiKqoDI2UWcnusRjQAy1HY+xab4PIu+TPyMO0+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGHoFmEAEiH3EHESwwLKd0fq85hyrmKAhrU4g+JvaK3/gzpXOUP6KOCjoNbu9LsHO7p1RVeMeAs0oxI3Nt20fqPMsXMSx1JaNkEyLRtUw0TyyCuBWOmLfHE2THcY2ZbfRq2cxdOVbcL5N7WvqhOHvVytTNgcXY0RFavyb97LTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V1j/l9jC; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-34c27ea32a3so231618a91.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 03:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823558; x=1769428358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7MKZiatBshCjLhK/wnOMzSh/LSYhDXgYWq/2BVz61M=;
        b=L0d3mUuGrQA5yxCYYl8NU4kbeSL3BJ3ahlQpIxqEF9xUQBchPdtMYPXg8inVihPagK
         SRP3zp8sN3A7vnlmLVsdke2GqNFGsIHQeVw5bdjttxe2QdFX8HSdsJBHnBNroQWt/CbR
         5/ZHDZkJKyYflwo//zemjedegPzsVGayAc7Z7ND4JYPW6p9KnxpX9f1JbTDaw9j7utWZ
         1bfWzfAAc+uIvc1299CPrpdmzhvWjfZlTUSGpigjcS0S06rdUUx9XqQYPfw+cVxMSJPn
         b1aSMwy89C/OsFvrEkQC+OZOX9T1Vdr7RSxUmQuaAujLU11WxCQPjzmVk7kZ0/Z0IIXv
         ku8w==
X-Forwarded-Encrypted: i=1; AJvYcCVNd5L4wZkvBEsyiqVozj2Yyen2YyHjc6ZnrbvjKN/L2SpfE7ko1x/byHzffLNTY+Xd48JQiWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5x2m88/S3n/fxthvXbpC7u4Xy0dlVX5BKYyYcDyoeH7T7E6M
	42wNZe4WsNAMZagiQOOuOsbJ9ZQ0S4hQIRP18Di1K1flK30rj66ekh6QpU/+qZPgzQOc8jvA1dM
	SY0Cs/ied5qEM0yUZRaXmhYJQxAr2N7y26rBO6tfYB0qqLH0BzEqX3vfDMjMVLbR3fB1BEHgaNg
	slnERXYx1qxFC/7+jyUQb6V+ST4JMEWrguRfVbYCNY1GS6CacK2JNo0D375L45gNKq6PtxJm3MY
	MQ8zffZY5RJIoCyGWq+nXpb1tIKTHw=
X-Gm-Gg: AZuq6aLjaj+URU2zX16KYQl0XrJezNI1Zz5biH5VndsbbJBtpOKvdYl89nT9dscyDWs
	VY1zOLUi7pug3pogzJeKnYjHnInpW6TpNvnOhIkbuRM7Avyvd+gygyb3dnD5rnOmsLzXZ88Zmrf
	pEst4owGmfYhon8D7aMwZ5HwrUz/zwTut5qaj0CUBUQVe4/1uIZKjHDX13RP5Kq/NFWylKrED8h
	KT+ijofFcRbrjfe+nWWapMNlNv3n3m4y6KL6CiltxZtRxJR2QbgYL9B/7G7lpmAEhmX3Ubl8AFf
	kc2IfAKZD4/k1wh0IYIh1i4jf3mx0LgmtdAsnWqn19Rj97XLlUQavoe6ypWRKfRbJKdGWWDwE+Z
	vvFkB797DFK37Y0mfTb6XzfgaYiWlK7CHNuspVLcfEioqZczpIfqPjyziQdUcO2PlwEGbvPZpud
	Xc/GhIJ9icIWfaVCGalNInlnkWRQsMLS/ePSO8JaC5n6YhRDV71Xl+2lrFKBE=
X-Received: by 2002:a17:90b:58e4:b0:340:b8f2:250c with SMTP id 98e67ed59e1d1-35272ec84efmr7306096a91.1.1768823558177;
        Mon, 19 Jan 2026 03:52:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35273124917sm1478022a91.6.2026.01.19.03.52.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:52:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c52d47dfceso81402285a.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 03:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768823557; x=1769428357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7MKZiatBshCjLhK/wnOMzSh/LSYhDXgYWq/2BVz61M=;
        b=V1j/l9jC5hw3TTW/oKI/nSloeHMC2DVcjv1xKb+ipq3aDZJqfPQHOlcZfNbiPa5+iM
         Q+wMHaKo/xq/gbfYOQNa49PY72PBiqsYRuYk+FyaNmiup83i85QpwxcXFmpZq+Ybhxsf
         jX6aOjo54Qh6DP1QLDGgmS4e0+pfWB0R/38Es=
X-Forwarded-Encrypted: i=1; AJvYcCUS1ShzorWO+mNvpsAPtVJ3ytTzQMYGl3I9IZIMORgPeMbt4+M3LAxiUWjZuYbm5rDJre+VeSY=@vger.kernel.org
X-Received: by 2002:a05:620a:cd0:b0:8c6:a707:dae7 with SMTP id af79cd13be357-8c6a707dafdmr885239585a.1.1768823556955;
        Mon, 19 Jan 2026 03:52:36 -0800 (PST)
X-Received: by 2002:a05:620a:cd0:b0:8c6:a707:dae7 with SMTP id af79cd13be357-8c6a707dafdmr885236885a.1.1768823556365;
        Mon, 19 Jan 2026 03:52:36 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71bf2b0sm772878885a.12.2026.01.19.03.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:52:35 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 1/2] net: Add locking to protect skb->dev access in ip_output
Date: Mon, 19 Jan 2026 11:49:09 +0000
Message-ID: <20260119114910.1414976-2-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>

[ Upstream commit 1dbf1d590d10a6d1978e8184f8dfe20af22d680a]

In ip_output() skb->dev is updated from the skb_dst(skb)->dev
this can become invalid when the interface is unregistered and freed,

Introduced new skb_dst_dev_rcu() function to be used instead of
skb_dst_dev() within rcu_locks in ip_output.This will ensure that
all the skb's associated with the dev being deregistered will
be transnmitted out first, before freeing the dev.

Given that ip_output() is called within an rcu_read_lock()
critical section or from a bottom-half context, it is safe to introduce
an RCU read-side critical section within it.

Multiple panic call stacks were observed when UL traffic was run
in concurrency with device deregistration from different functions,
pasting one sample for reference.

[496733.627565][T13385] Call trace:
[496733.627570][T13385] bpf_prog_ce7c9180c3b128ea_cgroupskb_egres+0x24c/0x7f0
[496733.627581][T13385] __cgroup_bpf_run_filter_skb+0x128/0x498
[496733.627595][T13385] ip_finish_output+0xa4/0xf4
[496733.627605][T13385] ip_output+0x100/0x1a0
[496733.627613][T13385] ip_send_skb+0x68/0x100
[496733.627618][T13385] udp_send_skb+0x1c4/0x384
[496733.627625][T13385] udp_sendmsg+0x7b0/0x898
[496733.627631][T13385] inet_sendmsg+0x5c/0x7c
[496733.627639][T13385] __sys_sendto+0x174/0x1e4
[496733.627647][T13385] __arm64_sys_sendto+0x28/0x3c
[496733.627653][T13385] invoke_syscall+0x58/0x11c
[496733.627662][T13385] el0_svc_common+0x88/0xf4
[496733.627669][T13385] do_el0_svc+0x2c/0xb0
[496733.627676][T13385] el0_svc+0x2c/0xa4
[496733.627683][T13385] el0t_64_sync_handler+0x68/0xb4
[496733.627689][T13385] el0t_64_sync+0x1a4/0x1a8

Changes in v3:
- Replaced WARN_ON() with  WARN_ON_ONCE(), as suggested by Willem de Bruijn.
- Dropped legacy lines mistakenly pulled in from an outdated branch.

Changes in v2:
- Addressed review comments from Eric Dumazet
- Used READ_ONCE() to prevent potential load/store tearing
- Added skb_dst_dev_rcu() and used along with rcu_read_lock() in ip_output

Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250730105118.GA26100@hu-sharathv-hyd.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Keerthana: Backported the patch to v5.15-v6.1 ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 16 +++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 3a1a6f94a..20a76e532 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -555,6 +555,18 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 		dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
 }
 
+static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
+{
+	/* In the future, use rcu_dereference(dst->dev) */
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	return READ_ONCE(dst->dev);
+}
+
+static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
+{
+	return dst_dev_rcu(skb_dst(skb));
+}
+
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
 void dst_blackhole_update_pmtu(struct dst_entry *dst, struct sock *sk,
 			       struct sk_buff *skb, u32 mtu, bool confirm_neigh);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 543d02910..79cf1385e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -420,17 +420,23 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev, *indev = skb->dev;
+	struct net_device *dev, *indev = skb->dev;
+	int ret_val;
+
+	rcu_read_lock();
+	dev = skb_dst_dev_rcu(skb);
 
 	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
 
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_IP);
 
-	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, indev, dev,
-			    ip_finish_output,
-			    !(IPCB(skb)->flags & IPSKB_REROUTED));
+	ret_val = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
+				net, sk, skb, indev, dev,
+				ip_finish_output,
+				!(IPCB(skb)->flags & IPSKB_REROUTED));
+	rcu_read_unlock();
+	return ret_val;
 }
 EXPORT_SYMBOL(ip_output);
 
-- 
2.43.7


