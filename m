Return-Path: <netdev+bounces-266631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IRfHJdgsWl/uQIAu9opvQ
	(envelope-from <netdev+bounces-266631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:31:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC056263A0F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CECCB3027DB3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE5B28000F;
	Wed, 11 Mar 2026 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sy/xWqPN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8385327EFFA
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232275; cv=none; b=izs9MUBrZL8eW1vz+nC+pGjJEc604nYPF+iM0iGyUZn/vbOJCEgIrDeWuzku9rzQ/8esUv0MLHOR9rovbDVwv629ZWvmgm0WAZbdYSd4z8BMt/w6OYGAeXwQPZUmhvYLNl0zYQ3LtxP0tnFD0/LFllTwJKpTiFWR2UAVZXQmXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232275; c=relaxed/simple;
	bh=nu+On+biHq9b9sOhgvdQmNCdFIKT1qMFwfCAYEZB0cY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=STWPhQnfGmbxlQxBys0ui2wSN7fDB6NSQOrdsySpQIhB1EBIac6iExzIh8WbMNxI/Qw/HOCbq+uw++l6cINwu+1D5bDuKgpcQUlloBiH0jD+/XyJKIviSoperyJcKutRw/l0Zia/RF7uHdgNn1+TIy2Hl4kwxYVtCKHJlJQ005A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sy/xWqPN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7982c466ee1so280812227b3.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773232272; x=1773837072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hLnMit74jMVeUaq1yBTwtTQvPzm07kKq9S606yVqzVo=;
        b=sy/xWqPNxUfJdtlyJc/jb8/qBI3fz52ZV6176d+do37sTUIgi96tjpehRjTEHrnXCn
         eMF8P+cBoFCjfDnFG/sqXlWkLz8G7/0pwVFgBMuTgujCHUsseINKWxCS9y6DLbOTh7nD
         H8NoVIP2g2Mkvpqx0ksksu3C1K4m94M1h9NHqSoXgqmt73oxa1AqRH0uLwbvLShGEhPN
         InA0l7xzHJzzeBgtBh+i44OuguV7ShuKyJkynd3lLQaSOGEgA68SOmVlzUOcizEuX2em
         sAG64UcabWSj/W6ZUxZNAPIKpIkxEgP9J1/fz6Ms8VkbjlN741V+rm3fUUQO9NQu9b4O
         2hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773232272; x=1773837072;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLnMit74jMVeUaq1yBTwtTQvPzm07kKq9S606yVqzVo=;
        b=PFVVwil4BsAFjAKBQNMIaixL7dJ142ntGMEMi5KZuBKZlZ3+lXKPQhUV9MqmuvjR78
         Jbu3e6xwQYQAlvRs/KSkR7YNpqitOO9/vQ97YWVAsjW3w8B9tHnb7SVWnRqIS8GRaEbM
         OD7s1YkYKMeyuqqnbvLimsDyZ9tKgfx4Qf7G5eFwHQ6KCAFtDqy5hcct7ZyiYeaY2GAq
         P0xoNB3/kyIA0zW2FlCpXq11zcVhWALR02FQVJr9sWPxHLrB+q85BN5G7KYrzPbS9HIE
         cXmm6x903IMXaSFGWd4bjTYRTPgNxKPYmiVMudVtrMkE7PyjQhvAJvXeRmI5PmB4IKbJ
         vdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2CToP+yXA+Dsz80XquhkYwxFiJC99w+3JrGumpukdwILuSWYAMzh/66fT5RFO1f0Q/EjqVEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDz8M4tarG69uod6FSzZYKQoTQsd8phm1spVpX5gCl4Vm1Libc
	652Fiq7rfg76enWxPvdNUz0rTrYB+PKSdh5+6mSvuxly0osrVlNa+OI0wcdMu7ArayLdUmVAkmc
	Uk54fiYlF0RRXhA==
X-Received: from qvbqp2.prod.google.com ([2002:a05:6214:5982:b0:894:7038:8d9d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:dc5:b0:799:266:83dc with SMTP id 00721157ae682-79917ea2ca2mr21026467b3.8.1773232272049;
 Wed, 11 Mar 2026 05:31:12 -0700 (PDT)
Date: Wed, 11 Mar 2026 12:31:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311123110.1471930-1-edumazet@google.com>
Subject: [PATCH net] ip_tunnel: adapt iptunnel_xmit_stats() to NETDEV_PCPU_STAT_DSTATS
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Guillaume Nault <gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DC056263A0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266631-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Blamed commits forgot that vxlan/geneve use udp_tunnel[6]_xmit_skb() which
call iptunnel_xmit_stats().

iptunnel_xmit_stats() was assuming tunnels were only using
NETDEV_PCPU_STAT_TSTATS.

@syncp offset in pcpu_sw_netstats and pcpu_dstats is different.

32bit kernels would either have corruptions or freezes if the syncp
sequence was overwritten.

This patch also moves pcpu_stat_type closer to dev->{t,d}stats to avoid
a potential cache line miss since iptunnel_xmit_stats() needs to read it.

Fixes: 6fa6de302246 ("geneve: Handle stats using NETDEV_PCPU_STAT_DSTATS.")
Fixes: be226352e8dc ("vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Guillaume Nault <gnault@redhat.com>
---
 include/linux/netdevice.h |  3 +--
 include/net/ip_tunnels.h  | 30 +++++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ae269a2e7f4dd22e4679db7f88b0f6dfedb36115..d7aac6f185bcab8a93a204c349272fc7c1b15ee7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2155,6 +2155,7 @@ struct net_device {
 	unsigned long		state;
 	unsigned int		flags;
 	unsigned short		hard_header_len;
+	enum netdev_stat_type	pcpu_stat_type:8;
 	netdev_features_t	features;
 	struct inet6_dev __rcu	*ip6_ptr;
 	__cacheline_group_end(net_device_read_txrx);
@@ -2404,8 +2405,6 @@ struct net_device {
 	void				*ml_priv;
 	enum netdev_ml_priv_type	ml_priv_type;
 
-	enum netdev_stat_type		pcpu_stat_type:8;
-
 #if IS_ENABLED(CONFIG_GARP)
 	struct garp_port __rcu	*garp_port;
 #endif
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 80662f81208039feb4fc1d3feae401633af2a5c2..1f577a4f8ce9b1ae4223d9cfd903bec8d7d78c04 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -665,13 +665,29 @@ static inline int iptunnel_pull_offloads(struct sk_buff *skb)
 static inline void iptunnel_xmit_stats(struct net_device *dev, int pkt_len)
 {
 	if (pkt_len > 0) {
-		struct pcpu_sw_netstats *tstats = get_cpu_ptr(dev->tstats);
-
-		u64_stats_update_begin(&tstats->syncp);
-		u64_stats_add(&tstats->tx_bytes, pkt_len);
-		u64_stats_inc(&tstats->tx_packets);
-		u64_stats_update_end(&tstats->syncp);
-		put_cpu_ptr(tstats);
+		if (dev->pcpu_stat_type == NETDEV_PCPU_STAT_DSTATS) {
+			struct pcpu_dstats *dstats = get_cpu_ptr(dev->dstats);
+
+			u64_stats_update_begin(&dstats->syncp);
+			u64_stats_add(&dstats->tx_bytes, pkt_len);
+			u64_stats_inc(&dstats->tx_packets);
+			u64_stats_update_end(&dstats->syncp);
+			put_cpu_ptr(dstats);
+			return;
+		}
+		if (dev->pcpu_stat_type == NETDEV_PCPU_STAT_TSTATS) {
+			struct pcpu_sw_netstats *tstats = get_cpu_ptr(dev->tstats);
+
+			u64_stats_update_begin(&tstats->syncp);
+			u64_stats_add(&tstats->tx_bytes, pkt_len);
+			u64_stats_inc(&tstats->tx_packets);
+			u64_stats_update_end(&tstats->syncp);
+			put_cpu_ptr(tstats);
+			return;
+		}
+		pr_err_once("iptunnel_xmit_stats pcpu_stat_type=%d\n",
+			    dev->pcpu_stat_type);
+		WARN_ON_ONCE(1);
 		return;
 	}
 
-- 
2.53.0.473.g4a7958ca14-goog


