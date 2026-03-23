Return-Path: <netdev+bounces-270384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMaPNo3owGl6OQQAu9opvQ
	(envelope-from <netdev+bounces-270384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:15:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE82ED60A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C83B830058C6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA8B35DA68;
	Mon, 23 Mar 2026 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoFfIx3q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC7BA45
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774250102; cv=none; b=JKsvcEDfW5JDBqSj9YxE8kvIv4RtRR39OxDuN+zYaToT/tYb3cby3HnmFJ9126WRw4VlvyHPeJluyW6CfUb7b7jpF/LXRf7GSnK0rVTNh4d76hr82YW+HqDjxT1htG/TFO2zFEYroQ0Aqo/yptfjEwVttIoizHF13FnHpmDWktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774250102; c=relaxed/simple;
	bh=nS5YSmsfOD7aEX4hK7Fh5ZRAlwlLPFOOPgx0dMNsJRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JJAHKLHr/6gQUcaKtD516okDjmRXl/9S4T1mULZdcxThYbEQiadynE7pqCYQtxIUCBHzmuaaY7nTXgEUf5vO9vLlCkshMLIW4GCK4KSNqzlUUpaIrP8prYqZ0GRXxPOVRD+OjMCHis5v/NGi5B1TO5ATQN6QEBwU684a3PC4i6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoFfIx3q; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a8720818aeso5073755ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 00:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774250100; x=1774854900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hfa1gkQSswNZUNLl/QA1bWJwEj7rdftvilP6P+Ic8oA=;
        b=KoFfIx3qlck5IzDIK0TCTM4Nfv88dlimvlOGgjFyHwILwFMjZ112Qem1AYb3NrWrbJ
         eMSL4NbZMWIxxheDtvrWQBIHch4vAdnC/GvNy8BHDB8w0W1Vhx6VU9Aq6c158zCcKCnW
         EAQuj+dn1I24Hbwwn3TZUog41KNNvOBVIHxxcmRFdjlrumCsUCTm+oLKqkvY4B0wFjPD
         zb6Il7HpF9sT089GW81XuSxJRGA5VuQHUvugSiz5XED5a4uyB4SOlUlbT1A4qsmetJFc
         CSrxCl4uIv/jzeUX2vb8iS2HfsviniODaULjHk033x+Lue2b48a+df2IrltP+XgR/zVy
         NTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774250100; x=1774854900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hfa1gkQSswNZUNLl/QA1bWJwEj7rdftvilP6P+Ic8oA=;
        b=hqDC+Id7ZjYhWOPZvlVF5LBEd6uG58+xKAoEDs+pycjTN8L357PXrqWkwCY/inagBT
         TRtv0t6sWnt+5QMaK16JZ1Fnp6Esh1HP6j4GqgBwnnctOylfJrXzgSmed+Rw1dornd6o
         9p1UuFsndO6YgfQrSYgBuEwicD48hN5KL2nixNhZbmTG0j5vR04XVJekh9hhoEMeE1yL
         qjCe63VtEhdY++j37OHZiybwt0r4lzwtTvM+fB9UQypLJWtYpuS6YNDQdtgo94w9+i5V
         2kMBhV4YPrXqDomKkPWIqbw/rtb8WlilEzstyW5L2WFAVqZdsxm2z1nceyW1G29zR5v/
         LcZg==
X-Forwarded-Encrypted: i=1; AJvYcCWIZi4J1zxPAubRKxO3EZ2pt5Tqc/VXY7G7NKGnjG9dB3Ean+V3zN2jg15Bz6x+pz3g39MsvTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0ci5qowSjBT5ORXUM6+L72sfbX9rexqfJO2eoQueCJ6y7Rk+
	+OCSZuwY4oqGZWNanbYAcPKi9Dv24fVKV5zkqBSq5XvZbLIny9YWFeIp
X-Gm-Gg: ATEYQzzmBBBbAe8MZ1dUCWItNUgPuCLItuWQc1w6EouXOAXBB/PYkgeCKWatG21Om0L
	CjCCYR4vYh99kTUSYO7Q79ua4jK2DnOSB5VO343LfAAGJCI19afHOp8gcpo9xOe3KQI3ftluwVH
	Y+p5uc7BaZld71UVG7Q/CTyTcO/m92Y7ODy7FNhixkar0ZIVdzqsiG9GdP6Tcs+1vO0jNjbojfB
	cNcrmMTxJ4ottt3GQ0vAvkjjxTMVvCKkMLKWnIkirVqc85qR/APTVk3XKCXadC7nIiIZQY2NbDV
	2Hx/we7oPJuteNqU3OExO9obe6cm30ND9r1q//zZyD+TqyH6ufg5bQabryFuJuvOPd0wMZfZC8Y
	QkeZKCNLOMW+Kl0bltKVZGbIO836cC8UUor3fJzJLfit3r/gZ95gi3gvcgEzSLAmhyHN3gUUvrW
	lg8dHHXdekKi5KW0TY5vJq2AievuFItokL
X-Received: by 2002:a17:903:46c4:b0:2b0:8025:efbe with SMTP id d9443c01a7336-2b0827c70b9mr63145255ad.8.1774250099832;
        Mon, 23 Mar 2026 00:14:59 -0700 (PDT)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836747dcsm94690125ad.64.2026.03.23.00.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 00:14:59 -0700 (PDT)
From: sunichi <sunyiqixm@gmail.com>
To: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	sunichi <sunyiqixm@gmail.com>
Subject: [PATCH] net/openvswitch: fix trigger-able BUG_ON after ovs_vport_cmd_fill_info
Date: Mon, 23 Mar 2026 15:14:35 +0800
Message-Id: <20260323071435.1945543-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,openvswitch.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-270384-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunyiqixm@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CCE82ED60A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ovs_vport_set_upcall_portids() does not validate the length of the
user-supplied OVS_VPORT_ATTR_UPCALL_PID netlink attribute. A
sufficiently large portid list can overflow the reply skb allocated
with NLMSG_DEFAULT_SIZE in causing ovs_vport_cmd_fill_info()
to return -EMSGSIZE and triggering the unconditional BUG_ON(),
which panics the kernel on most distributions.

Any local user with CAP_NET_ADMIN (or an equivalent unprivileged
namespace capability where applicable) can exploit this to perform a
denial-of-service against the host.

Replace BUG_ON with WARN_ON_ONCE to prevent kernel panic.

Signed-off-by: sunichi <sunyiqixm@gmail.com>
---
 net/openvswitch/datapath.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e209099218b4..50c2945081a1 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2202,7 +2202,8 @@ struct sk_buff *ovs_vport_cmd_build_info(struct vport *vport, struct net *net,
 
 	retval = ovs_vport_cmd_fill_info(vport, skb, net, portid, seq, 0, cmd,
 					 GFP_KERNEL);
-	BUG_ON(retval < 0);
+	if (WARN_ON_ONCE(retval < 0))
+		return ERR_PTR(-EMSGSIZE);
 
 	return skb;
 }
@@ -2358,7 +2359,9 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	else
 		netdev_set_rx_headroom(vport->dev, dp->max_headroom);
 
-	BUG_ON(err < 0);
+	if (WARN_ON_ONCE(err < 0))
+		goto exit_unlock_free;
+
 	ovs_unlock();
 
 	ovs_notify(&dp_vport_genl_family, reply, info);
@@ -2411,7 +2414,8 @@ static int ovs_vport_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
 				      info->snd_portid, info->snd_seq, 0,
 				      OVS_VPORT_CMD_SET, GFP_KERNEL);
-	BUG_ON(err < 0);
+	if (WARN_ON_ONCE(err < 0))
+		goto exit_unlock_free;
 
 	ovs_unlock();
 	ovs_notify(&dp_vport_genl_family, reply, info);
@@ -2451,7 +2455,8 @@ static int ovs_vport_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
 				      info->snd_portid, info->snd_seq, 0,
 				      OVS_VPORT_CMD_DEL, GFP_KERNEL);
-	BUG_ON(err < 0);
+	if (WARN_ON_ONCE(err < 0))
+		goto exit_unlock_free;
 
 	/* the vport deletion may trigger dp headroom update */
 	dp = vport->dp;
@@ -2498,7 +2503,9 @@ static int ovs_vport_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
 				      info->snd_portid, info->snd_seq, 0,
 				      OVS_VPORT_CMD_GET, GFP_ATOMIC);
-	BUG_ON(err < 0);
+	if (WARN_ON_ONCE(err < 0))
+		goto exit_unlock_free;
+
 	rcu_read_unlock();
 
 	return genlmsg_reply(reply, info);
-- 
2.34.1


