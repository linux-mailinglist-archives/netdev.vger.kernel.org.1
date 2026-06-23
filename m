Return-Path: <netdev+bounces-301248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jDNPF1r1OWqozQcAu9opvQ
	(envelope-from <netdev+bounces-301248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 04:54:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A09296B3A1D
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 04:54:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SXJYR9Pn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301248-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301248-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10F42302F272
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 02:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9667F386C3B;
	Tue, 23 Jun 2026 02:52:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9434AB01
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 02:52:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183140; cv=none; b=QO6O2vQaYSXk9cgF5h8wNHuugzQUrxPIFer9PflPnR68INmwN351o0WF++tbJKnFDMjTw5XsPCPMYGRoPBQX2J5xo3zDEp3iIKAh3Wus4KS5jmWHYQZxe6Y2rvlmqtP82cBTvBVJ9fKhoxlqnftjPv5vnetxlTFax4+zbHsejfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183140; c=relaxed/simple;
	bh=f3glByHm07cnjQ+4bttPB+IrOQ+nmH6ASvuIW+jHlgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWxLkWImDCUt6kfwu8iuEPLzzugbN1HQou3Tb/QjSLM3xFaVTtk9SLNAlERNPl+oJSRYvjkyfomSjKTnChVW6NraAHoMisNTG261sJjxx2dXDAhLIEMN4DMMgHJM60eigUEP56SPZI2ljh7yFru7Wpe2p26hMEbtWMZCXeo0ZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXJYR9Pn; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c40397e3caso48830125ad.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 19:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782183138; x=1782787938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw5hFTdxntHea0NFQ2qVKZmLTnPbzDIESjvIhkmV/NE=;
        b=SXJYR9PnUdRRQQa1AHWsjK5foc5SwpokWsYbuIXx/eSPiYlUrZUmSlLf1soN+NwfJS
         ir5BDBdMxoIIdEjJiny9uD2kJA24BVA69f3N/XPwGOiwuqQTr487rLhNjrPNpaewpfON
         3vwYjCYtKoZltH5RWInerLQadFLNhHyGFh0rjeXMOzg9Nkj55yGMO1FZr/rWwIfqMuf3
         eyJUJxfKqabzAYIxpfAi/nlskVaHU3KRDLKWKjKxuP/Nr57hj7hRGpxLc6bHR/8prvoz
         bB5dVGZoN1SwM4uoA92rl3p0eZ+tNt0FgredKw69a4papLcqpo4XzZcVohYOw/ORYJr9
         N2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782183138; x=1782787938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sw5hFTdxntHea0NFQ2qVKZmLTnPbzDIESjvIhkmV/NE=;
        b=pgApU+b/Dlmf4Pqy8OgmQVvrGItPwKndDGlzoswzOalf9akJ9VF7vlHiXxyNR+1Loh
         RYNOOQh4K/3b0F30vLdG7huxMqcnMQfejovvUOjlD9aP/ugxNHZ5eqHN73T5d26xFM+4
         nNaF+1pm9VpTE/luT6M8hZ3K8zu1LzjdMM3Uj3UuGbbdS9REzluzc+bVlgMG45nZJbvU
         Q+KjJoW9FP+E1sPldLxFdCI65DTx55PPKj4crcq9zehCivVkpV9t5ZtpNUQRFjuMfQdi
         pASc0pMbChFUzKDe4lHUCa1CGrMEdjpZprv4bMiLckhr+ULrelNNvtUHWm8mBTb6ZfQJ
         9DuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDfXepztwauE3y4ZcHnmUAOz20p4lNj9ozzLk+UfKNusA5w/Ksm93Z5Gnu89eBxvm06k7flxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr1jq12X6xh7WK5QRhJXuvJ4B5N5PmWUXYfhs7Z9xjBRXM7ZzI
	T2qw11l/1d4Q5Pyj0rukkxWS+iv6Nfow/thc36R1ocUw6gwzbPE+reNV
X-Gm-Gg: AfdE7cnmxga/VhAmRZkRwCFUBzCx1tGSxumFDaCzg1epcpkF7prWKchW9TseX0uOkCb
	y+ZpWo/G0UZY3R6HtK3kFG4S49OAITD48xeqPO1utPr3CybdX3x1G3hlaXkFJlt4zsb89aZVNQ9
	e0IHUXd9j2EGh6q3zt1LK4vdvU7vA2jejPBWMd9FXunnTCfJPJ4cVWgapTcjhhE67Aspg86x7wZ
	8nutEhch9UcXBJDoOasQ8Id+C3nehRG1pMPszkNoFuCtW+jnTdQuTraZakF67mbIUNEi81uEQd9
	ujbxlpX5/oHbAI/X/9EU3GLYQSdu0nE1V32hA6yeB8ovYPt1LgXKUoFyVNg7pVEPEFMl1/SA+Ue
	KX2HdUE0CpDkjNUvCTWh4go3vYuXBXQ2P/LyYeon8BQZn6B7avWz7ky99+tqH6kkPO/fgKyy6Le
	r21IK90lbkVJB545AmqbxvPnA8aIx5N0V22Xlua5H8yeLYgFxfMVqFjF7wFUGk
X-Received: by 2002:a17:902:c94c:b0:2c0:dd75:e834 with SMTP id d9443c01a7336-2c7c758bd87mr12314455ad.5.1782183138133;
        Mon, 22 Jun 2026 19:52:18 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8e51sm102704625ad.39.2026.06.22.19.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 19:52:17 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	yatsenko@meta.com,
	leon.hwang@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	eyal.birger@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	toke@redhat.com,
	dsahern@kernel.org
Subject: [PATCH bpf-next v4 2/3] bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
Date: Tue, 23 Jun 2026 08:21:46 +0530
Message-ID: <20260623025147.1001664-3-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623025147.1001664-1-avinash.duduskar@gmail.com>
References: <20260623025147.1001664-1-avinash.duduskar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301248-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:toke@redhat.com,m:dsahern@kernel.org,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A09296B3A1D

BPF_FIB_LOOKUP_VLAN resolves a VLAN egress. The reverse is also
useful: an XDP program receiving a VLAN-tagged frame on a physical
device wants the lookup to behave as if the packet had arrived on the
corresponding VLAN subinterface, so iif-based policy routing and VRF
table selection use the right ingress.

Add BPF_FIB_LOOKUP_VLAN_INPUT. When set, params->h_vlan_proto and
params->h_vlan_TCI are read as an input VLAN tag and the matching VLAN
device of params->ifindex is resolved with __vlan_find_dev_deep_rcu().
The device must be up and in the same network namespace as
params->ifindex (a VLAN device can be moved to another netns while
registered on its parent; receive would deliver into that other
namespace, which a lookup here cannot represent). If params->ifindex
is itself a VLAN device, its inner (QinQ) subinterface is matched.
For a bond or team, a tag on a port matches no device and returns
NOT_FWDED; pass the master's ifindex.
The lookup then runs with the resolved device as the ingress;
params->ifindex itself is not modified on the input side. When the
resolved device is enslaved to a VRF, both the full lookup (via the
l3mdev rule) and BPF_FIB_LOOKUP_DIRECT (via l3mdev_fib_table_rcu())
select the VRF's table from the resolved ingress. That follows from
feeding the resolved device to the flow as the ingress
(fl4.flowi4_iif = dev->ifindex), which is what makes l3mdev resolve
the VRF master from the subinterface rather than from
params->ifindex.

The two failure classes get different treatment on purpose. A
h_vlan_proto other than 802.1Q/802.1ad is API misuse and returns
-EINVAL, since it would otherwise reach the WARN in vlan_proto_idx()
with a program-controlled value. An unmatched VID, a device that is
down, or one in another namespace is a data outcome and returns
BPF_FIB_LKUP_RET_NOT_FWDED, matching the DIRECT path when
fib_get_table() finds no table and mirroring real ingress, where the
receive path drops such frames. A VID of 0 (a priority tag) is looked
up literally and normally fails the same way; receive instead
processes such frames untagged, so callers should not set the flag for
priority tags. Proceeding on the physical device for any of these
would be fail-open for the policy-routing cases above.

The h_vlan fields share a union with tbid, so the flag cannot be
combined with BPF_FIB_LOOKUP_TBID. It describes ingress, so it also
cannot be combined with BPF_FIB_LOOKUP_OUTPUT. Both combinations
return -EINVAL; restricting now keeps a later relaxation backward
compatible. Combining with BPF_FIB_LOOKUP_VLAN is allowed: the tag is
consumed on the ingress side and the egress tag is written on
success.

Under !CONFIG_VLAN_8021Q the __vlan_find_dev_deep_rcu() stub returns
NULL, so every lookup with the flag returns NOT_FWDED, which is
correct since no VLAN device can exist.

Suggested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 include/uapi/linux/bpf.h       | 21 ++++++++++-
 net/core/filter.c              | 66 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h | 21 ++++++++++-
 3 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8d0058d88eb2..46a1443534bd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3552,6 +3552,22 @@ union bpf_attr {
  *			are written only on success; other output fields keep
  *			the helper's existing behaviour, so a frag-needed result
  *			still reports the route mtu in *params*->mtu_result.
+ *		**BPF_FIB_LOOKUP_VLAN_INPUT**
+ *			Treat *params*->h_vlan_proto and *params*->h_vlan_TCI
+ *			as an input VLAN tag and run the lookup as if ingress
+ *			had happened on the VLAN subinterface carrying that tag
+ *			on *params*->ifindex. The VID is the low 12 bits of
+ *			*params*->h_vlan_TCI; *params*->h_vlan_proto must be
+ *			ETH_P_8021Q or ETH_P_8021AD in network byte order, else
+ *			**-EINVAL**. If *params*->ifindex is itself a VLAN
+ *			device, its inner (QinQ) subinterface is matched; for a
+ *			bond or team, pass the master's ifindex. An unmatched
+ *			tag, a down device, or one in another namespace returns
+ *			**BPF_FIB_LKUP_RET_NOT_FWDED**, mirroring real ingress.
+ *			A VID of 0 is looked up literally, so do not set this
+ *			flag for priority-tagged frames. Cannot be combined with
+ *			**BPF_FIB_LOOKUP_TBID** or **BPF_FIB_LOOKUP_OUTPUT**
+ *			(returns **-EINVAL**).
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7348,6 +7364,7 @@ enum {
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
 	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
+	BPF_FIB_LOOKUP_VLAN_INPUT = (1U << 7),
 };
 
 enum {
@@ -7418,7 +7435,9 @@ struct bpf_fib_lookup {
 			/*
 			 * output with BPF_FIB_LOOKUP_VLAN: set from the
 			 * resolved egress VLAN device (see the flag); zeroed
-			 * on other successful lookups.
+			 * on other successful lookups. input with
+			 * BPF_FIB_LOOKUP_VLAN_INPUT: the VLAN tag to scope
+			 * the lookup by.
 			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
diff --git a/net/core/filter.c b/net/core/filter.c
index 8345295d84de..fc603cc36ce9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6228,6 +6228,25 @@ static int bpf_fib_set_fwd_params(struct net_device *dev,
 
 	return 0;
 }
+
+static struct net_device *bpf_fib_vlan_input_dev(struct net_device *dev,
+						 const struct bpf_fib_lookup *params)
+{
+	__be16 proto = params->h_vlan_proto;
+	struct net_device *vlan_dev;
+	u16 vid;
+
+	if (proto != htons(ETH_P_8021Q) && proto != htons(ETH_P_8021AD))
+		return ERR_PTR(-EINVAL);
+
+	vid = ntohs(params->h_vlan_TCI) & VLAN_VID_MASK;
+	vlan_dev = __vlan_find_dev_deep_rcu(dev, proto, vid);
+	if (!vlan_dev || !(vlan_dev->flags & IFF_UP) ||
+	    !net_eq(dev_net(vlan_dev), dev_net(dev)))
+		return NULL;
+
+	return vlan_dev;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_INET)
@@ -6249,6 +6268,14 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	if (unlikely(!dev))
 		return -ENODEV;
 
+	if (flags & BPF_FIB_LOOKUP_VLAN_INPUT) {
+		dev = bpf_fib_vlan_input_dev(dev, params);
+		if (IS_ERR(dev))
+			return PTR_ERR(dev);
+		if (!dev)
+			return BPF_FIB_LKUP_RET_NOT_FWDED;
+	}
+
 	/* verify forwarding is enabled on this interface */
 	in_dev = __in_dev_get_rcu(dev);
 	if (unlikely(!in_dev || !IN_DEV_FORWARD(in_dev)))
@@ -6258,7 +6285,11 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		fl4.flowi4_iif = 1;
 		fl4.flowi4_oif = params->ifindex;
 	} else {
-		fl4.flowi4_iif = params->ifindex;
+		/*
+		 * dev->ifindex, not params->ifindex: VLAN_INPUT may have
+		 * resolved dev to a subinterface above.
+		 */
+		fl4.flowi4_iif = dev->ifindex;
 		fl4.flowi4_oif = 0;
 	}
 	fl4.flowi4_dscp = inet_dsfield_to_dscp(params->tos);
@@ -6401,6 +6432,14 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	if (unlikely(!dev))
 		return -ENODEV;
 
+	if (flags & BPF_FIB_LOOKUP_VLAN_INPUT) {
+		dev = bpf_fib_vlan_input_dev(dev, params);
+		if (IS_ERR(dev))
+			return PTR_ERR(dev);
+		if (!dev)
+			return BPF_FIB_LKUP_RET_NOT_FWDED;
+	}
+
 	idev = __in6_dev_get_safely(dev);
 	if (unlikely(!idev || !READ_ONCE(idev->cnf.forwarding)))
 		return BPF_FIB_LKUP_RET_FWD_DISABLED;
@@ -6409,7 +6448,12 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		fl6.flowi6_iif = 1;
 		oif = fl6.flowi6_oif = params->ifindex;
 	} else {
-		oif = fl6.flowi6_iif = params->ifindex;
+		/*
+		 * dev->ifindex, not params->ifindex: VLAN_INPUT may have
+		 * resolved dev to a subinterface above.
+		 */
+		oif = dev->ifindex;
+		fl6.flowi6_iif = oif;
 		fl6.flowi6_oif = 0;
 		strict = RT6_LOOKUP_F_HAS_SADDR;
 	}
@@ -6525,7 +6569,19 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
 			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
 			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK | \
-			     BPF_FIB_LOOKUP_VLAN)
+			     BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_VLAN_INPUT)
+
+static bool bpf_fib_lookup_flags_ok(u32 flags)
+{
+	if (flags & ~BPF_FIB_LOOKUP_MASK)
+		return false;
+
+	if ((flags & BPF_FIB_LOOKUP_VLAN_INPUT) &&
+	    (flags & (BPF_FIB_LOOKUP_TBID | BPF_FIB_LOOKUP_OUTPUT)))
+		return false;
+
+	return true;
+}
 
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
@@ -6533,7 +6589,7 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
-	if (flags & ~BPF_FIB_LOOKUP_MASK)
+	if (!bpf_fib_lookup_flags_ok(flags))
 		return -EINVAL;
 
 	switch (params->family) {
@@ -6572,7 +6628,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
-	if (flags & ~BPF_FIB_LOOKUP_MASK)
+	if (!bpf_fib_lookup_flags_ok(flags))
 		return -EINVAL;
 
 	if (params->tot_len)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8d0058d88eb2..46a1443534bd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3552,6 +3552,22 @@ union bpf_attr {
  *			are written only on success; other output fields keep
  *			the helper's existing behaviour, so a frag-needed result
  *			still reports the route mtu in *params*->mtu_result.
+ *		**BPF_FIB_LOOKUP_VLAN_INPUT**
+ *			Treat *params*->h_vlan_proto and *params*->h_vlan_TCI
+ *			as an input VLAN tag and run the lookup as if ingress
+ *			had happened on the VLAN subinterface carrying that tag
+ *			on *params*->ifindex. The VID is the low 12 bits of
+ *			*params*->h_vlan_TCI; *params*->h_vlan_proto must be
+ *			ETH_P_8021Q or ETH_P_8021AD in network byte order, else
+ *			**-EINVAL**. If *params*->ifindex is itself a VLAN
+ *			device, its inner (QinQ) subinterface is matched; for a
+ *			bond or team, pass the master's ifindex. An unmatched
+ *			tag, a down device, or one in another namespace returns
+ *			**BPF_FIB_LKUP_RET_NOT_FWDED**, mirroring real ingress.
+ *			A VID of 0 is looked up literally, so do not set this
+ *			flag for priority-tagged frames. Cannot be combined with
+ *			**BPF_FIB_LOOKUP_TBID** or **BPF_FIB_LOOKUP_OUTPUT**
+ *			(returns **-EINVAL**).
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7348,6 +7364,7 @@ enum {
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
 	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
+	BPF_FIB_LOOKUP_VLAN_INPUT = (1U << 7),
 };
 
 enum {
@@ -7418,7 +7435,9 @@ struct bpf_fib_lookup {
 			/*
 			 * output with BPF_FIB_LOOKUP_VLAN: set from the
 			 * resolved egress VLAN device (see the flag); zeroed
-			 * on other successful lookups.
+			 * on other successful lookups. input with
+			 * BPF_FIB_LOOKUP_VLAN_INPUT: the VLAN tag to scope
+			 * the lookup by.
 			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
-- 
2.54.0


