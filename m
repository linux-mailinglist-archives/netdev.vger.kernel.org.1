Return-Path: <netdev+bounces-264965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE8VHq5lq2kfcwEAu9opvQ
	(envelope-from <netdev+bounces-264965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:39:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D10F6228C96
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42D7B3001C4F
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D683803F9;
	Fri,  6 Mar 2026 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luUTEPec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E25B35E95F
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840363; cv=none; b=eJIN4scSHIbK8CmLHEp5lC3/BpxlXSHCcSzbat6rF/I0gw2Z1AptjzgCLi+F96M34XsqnUMhilHarV6gB6UkcKLBjsxJnLXCCFCfMOj32yCMzchZr8m4yo7x6Yqfn8OpTD7rlLdNEdNAQB8c7Z1ul84hYJdCzzd7dj9qe+A4egg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840363; c=relaxed/simple;
	bh=apPiXEb0O6w+YA4l9CCmEorK71PzvfzP4YtEPO9dM5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IuU6IEvgQjcXu5gZbhjYXURad1F7edSAI7ll7NhV9LRp2TPIfP3sIjmsIT+TaZEXKyQWb3jQ0mJmMurhrPu12QT+ToG78wNj5XzCwVn0j0nw5MH94W75yerH9yxvedShNuZcf99ciB7VR2658VbM0WP6BK6LhVBkk+SVTMMmGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luUTEPec; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79800183233so136325827b3.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 15:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772840360; x=1773445160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9wovly74FgcJKa8Ed9Xsx768BrjeHrTIyaL2Oh1KxY=;
        b=luUTEPec30OcD9y0DJOHbho82GyFT/KTGcK04/QvwXiC7AdZa4b7AzqhvEeml/IAeO
         +Uck2i689+DOawsjOlQ2YHiUo5MeYHS8ecBmXVPYHLMQKp5PYnkNBNrNJFadvesM8q1d
         F8dcfscOzekJ6NBpGWhZlKQXzElhmU4mWULvvqed4XFp+zLnagV6naZzEfb3+nxaCXpy
         C6YGUMUtPcAgB6S7EYDWFVUOIKE3WEy5m9AAoOVgAVz+t/Xp6AeSEzBRBpKdvbGExPCV
         r5xfyM70YUJm4fXKfpsNI+8RximNXH2qGq38O1usY3eAccyWReUuUFZjfSPTW1P4Kpt2
         ck8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772840360; x=1773445160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9wovly74FgcJKa8Ed9Xsx768BrjeHrTIyaL2Oh1KxY=;
        b=QhVwr+Q4pNiYQIfWC7ZErfQPIUlncQ8iWdwV79FBOHGQCJkVAQepDaqTkG4X81dFXi
         q4J59cwtSj89XI2wiVSilejwkC49xbcb7Acjz8e8Xw/taOIA3E1TxPt1EqgCosRNP8Gh
         duLrgRVJ/44UAjYwLFHT20byZYtKhHMfT7eHet6Sp7LA95TsJPir6GWtUdROlgjNjDSH
         vGW2bVywtU5Nfpk3wIx88BfB/Li+DGCZr+Ry7cZUtqs4IWUBe/ig52HLGquYetGkQgD0
         tUXkO6o7i9smA/P6gFnISddArTUQ1mSLk1T1kX9HFz+hsjMRA0fo0hwJycjgeWcFI2sS
         aNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzTx8uq92ZZKvnkHMkWBsZccOwwzegD8o7auLyOENpo376/MgqGE0yZjBBwl9eHHzIQQEyBLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+EVeL5wotBCQ/Znsipa571Ft99vyDpLilFaAGsG+/afF24QJn
	+qOVX4LROkDmNPM0V7HNkSy5wAUsz9O70m7n5Z1BLritM/gnlWCS9LhD
X-Gm-Gg: ATEYQzxFqnaLkkbw/T7yjXkcQf4qPkKp5m7oFs/qAqDioMF/HQNUtlXQHsuVoTF46Zp
	Aw3TCJn1B4kKf9ndlsnCOrhnl/Mel6EyG0NpFNRw4B+dIHwlkoypmWimZm+IiM/cskn9JNrPJPq
	FHRgoKFVlXAIcd59f081uLQAzyeqLnHeqYKc/EKpCAsrkugZSdx7ipFUGSmt8asAOJKuafzzHjN
	/M2N/pRubt+ooFyEGTE8oyopbPTZLn7MW+TJYsfMGgfSFSay68C5yvk4eMfahs6TbuzrqzCaFjF
	zuXo14tq0otE1zaHo6v/7OyuQy3C/0A5OYkIm0G60O1Aqy+tuHb0o7KNZgVxph7817qYIFiWrbQ
	jAZ1h3xnjkdvCzPwJ9bC73zjr8U7i2Y2gK8TyKYccE2+S1SjbjJk3Iv8AAPKNBqhbQrODMflaRd
	WggNfRZcXdEIQvrj4XoE9tnM3UKMd6zXqArzI+kipBl7S1wPBQMg6i9aX2jQ4ujG2owTY=
X-Received: by 2002:a05:690c:660d:b0:798:63ab:757f with SMTP id 00721157ae682-798dd6d3d80mr35940637b3.9.1772840360031;
        Fri, 06 Mar 2026 15:39:20 -0800 (PST)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dee4883bsm14013957b3.31.2026.03.06.15.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:39:19 -0800 (PST)
From: Mehul Rao <mehulrao@gmail.com>
To: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	petrm@nvidia.com,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH net] net: nexthop: fix percpu use-after-free in remove_nh_grp_entry
Date: Fri,  6 Mar 2026 18:38:20 -0500
Message-ID: <20260306233821.196789-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D10F6228C96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264965-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mehulrao@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.929];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

When removing a nexthop from a group, remove_nh_grp_entry() publishes
the new group via rcu_assign_pointer() then immediately frees the
removed entry's percpu stats with free_percpu(). However, the
synchronize_net() grace period in the caller remove_nexthop_from_groups()
runs after the free. RCU readers that entered before the publish still
see the old group and can dereference the freed stats via
nh_grp_entry_stats_inc() -> get_cpu_ptr(nhge->stats), causing a
use-after-free on percpu memory.

Fix by deferring the free_percpu() until after synchronize_net() in the
caller. Removed entries are chained via nh_list onto a local deferred
free list. After the grace period completes and all RCU readers have
finished, the percpu stats are safely freed.

Fixes: f4676ea74b85 ("net: nexthop: Add nexthop group entry stats")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
---
 net/ipv4/nexthop.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 1aa2b05ee8de..c942f1282236 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2002,7 +2002,8 @@ static void nh_hthr_group_rebalance(struct nh_group *nhg)
 }
 
 static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
-				struct nl_info *nlinfo)
+				struct nl_info *nlinfo,
+				struct list_head *deferred_free)
 {
 	struct nh_grp_entry *nhges, *new_nhges;
 	struct nexthop *nhp = nhge->nh_parent;
@@ -2062,8 +2063,8 @@ static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 	rcu_assign_pointer(nhp->nh_grp, newg);
 
 	list_del(&nhge->nh_list);
-	free_percpu(nhge->stats);
 	nexthop_put(nhge->nh);
+	list_add(&nhge->nh_list, deferred_free);
 
 	/* Removal of a NH from a resilient group is notified through
 	 * bucket notifications.
@@ -2083,6 +2084,7 @@ static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
 				       struct nl_info *nlinfo)
 {
 	struct nh_grp_entry *nhge, *tmp;
+	LIST_HEAD(deferred_free);
 
 	/* If there is nothing to do, let's avoid the costly call to
 	 * synchronize_net()
@@ -2091,10 +2093,16 @@ static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
 		return;
 
 	list_for_each_entry_safe(nhge, tmp, &nh->grp_list, nh_list)
-		remove_nh_grp_entry(net, nhge, nlinfo);
+		remove_nh_grp_entry(net, nhge, nlinfo, &deferred_free);
 
 	/* make sure all see the newly published array before releasing rtnl */
 	synchronize_net();
+
+	/* Now safe to free percpu stats — all RCU readers have finished */
+	list_for_each_entry_safe(nhge, tmp, &deferred_free, nh_list) {
+		list_del(&nhge->nh_list);
+		free_percpu(nhge->stats);
+	}
 }
 
 static void remove_nexthop_group(struct nexthop *nh, struct nl_info *nlinfo)
-- 
2.53.0


