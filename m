Return-Path: <netdev+bounces-299980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bb9WA5vPMWohqgUAu9opvQ
	(envelope-from <netdev+bounces-299980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:35:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEB169597C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:35:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FOC8TASP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299980-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299980-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0472B3049703
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D0C3ACA7A;
	Tue, 16 Jun 2026 22:34:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F7C3A8722
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:34:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649299; cv=none; b=rTeRVXR1EM4SvWTkLQ/12uSdM7p09WjrrAB+B4Yq9Q++kDbsGf/UoAHZlK6gkZ3NSzHrARVW5wSGIJrRNL0xZ4OW3Rsai8AvfjOgZAikvZ1IynJoc9aGQ2PEJDA+9RoQ0wdRKxk45l6N+ly5PjiUNDUW/XLV5qcqn4x9m6Pmh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649299; c=relaxed/simple;
	bh=7xyAmC8A/FetCZVCGs6N3DKsL4AXzTKThgU/dJfEWY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/6YUUUhgxatTgmbcn0n72FdVp60q27FZhI3yoHYVsEwQAach1qN8hKPsChU3+WYxQ7pfK18sr5NtjXrY3XyLYVQAODbVjUVIW2lfdeRXGaxHjOL358rGrq05afin78S36z3KAJIG8EQXrge/4abP5nd9gl0Q4eh6HzjcxQjwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOC8TASP; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b900f350fso4644977a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781649297; x=1782254097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAH7Q/vAklBT0L04kWqOUQpmhl4v8vjdk/FvGvrzeyk=;
        b=FOC8TASPhRxBfOSnj2mFduSe81MHLysCLViAY2yaDOKfzsJ5v4wiBxiN++5ubB4QO+
         SNFMiArgNh1nkw/JJWOshDg27zTi9e+ULQ17XAcgyNKJKbFV1cfbLN74HNJwE81lR7VL
         p+kwVLIVnwO98QyxmiCFRpEPcm5GoZ1a+rOYbYbt99241mnFkT/TfRJDdZnN2FtowPA7
         0CIGKVzsixkSUmJ/0t726NHR4WdgemFHdjkGZcZln/SeJF0f3ORL10QyenHFOkUMvTNC
         s2jkTA64fuwWpTQlXjDUe8cskJqyppqeC5x9tUeDbbXoLIVoH9sf6r8VFVZywYcwiTI+
         cRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781649297; x=1782254097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAH7Q/vAklBT0L04kWqOUQpmhl4v8vjdk/FvGvrzeyk=;
        b=myU+Eiporq0B8j8ylGcm6s4PmvVCsP29bYzdA2tm2mYDEURX8woiI/n+/32Q4u8N8q
         Pk1BUePgvG/HEovqXf6EJ5HuSPSyuisTonpniSnRlIaBhwZXcQRSKk02+SDYM7GgVnxh
         sI8fMhQfFHdBMChrpyT2nuVSmfBnE04cy2k+jq8WHhSdjltFzvDcW5HxE7Kq29cAE0JA
         oG93hXSU4j/l3GLRmu0KYX3nyARL0UFHLJU/g88Y3Pna7m3o5/VK/aS3CVqB1vNul75+
         lCbufJ9rQbpv7suJBoAaUvIxEfO5Zk3JiYuFiGu8gGjQmTLVhJW/qs+iWB+0T43YNutM
         PGKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RvfLxnMFIAG+o5Grxkkii8Rf8AIkt1KcjSeoD8RjVg9yDCbmxSzhaWT+VgfE5zPi/j2XtH1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQa3J6gB6FtD7XWPX/RmSCfxi+xn/hkjoHa6JFBDx0e2R9SDW
	9LuUzItOTWAzpXclCplJ5jPWTvcMPQOKeEY61ekrbqpND5Pc87bfoAUd
X-Gm-Gg: AfdE7cmJ1alEYrq3K39kln2Ob3lStzi5xP0qGNDlV7+DflxZUWL1cmBtvcaUJmtlzhP
	adFnhHvnQ3VP9ActyNNBOmS3PSi4GrERdPKRp2Z2o3wRRulL814WTJQT4kDDgyEy6WZK4JOrorj
	3UqvzIXB6674EAWL/aSIOim7p3cthYjgRQq2pOhh0LOOc/4qnMF1LyB9E9qpCvMH3a89CFb++uU
	OexzKvxS/+DY2vvr+/C4ZoRbE0qFqRjMkAWIB7cAMpO0AFnbaL98B2De07PwfyyxEoOLD41gxrX
	Yrwcder9QE+1inMm8cRhhT9+ByQT/CM+7frsGr4PTZSCaF5EYQhjQrl30rI3IoiHwohxqA6fDFh
	3cOyE2F6kdQ+lkaJt5RZZFqQaT8xLQpNSte5T1BftV7sUDzJyfRsRiO+lsZ/4U+UkZtiwfkMGx6
	UV19zvY7SDU2QlYhiSiXAHMhpQNAT3Zvwk+QzBrbaH2oKDGGypHsujlkxvuKcyVfHMvFuzwvQ=
X-Received: by 2002:a17:90b:4a8e:b0:36b:9512:871b with SMTP id 98e67ed59e1d1-37c9345e910mr1380886a91.11.1781649296796;
        Tue, 16 Jun 2026 15:34:56 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c52092ee3sm4216898a91.0.2026.06.16.15.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:34:56 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/4] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Wed, 17 Jun 2026 04:04:24 +0530
Message-ID: <20260616223426.3568080-3-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
References: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299980-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:eyal.birger@gmail.com,m:rongtao@cestc.cn,m:toke@redhat.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EEB169597C

bpf_fib_lookup() returns the FIB-resolved egress ifindex straight
from the fib result. When the egress is a VLAN device, the returned
ifindex is the VLAN netdev's, which has no XDP xmit handler; XDP
programs that want to forward the frame (e.g. xdp-forward) must
instead target the underlying physical device and push the VLAN tag
themselves. Today the program has no way to learn either the
underlying ifindex or the VLAN tag without maintaining its own
VLAN-to-ifindex map in userspace and refreshing it on netlink
events.

Add BPF_FIB_LOOKUP_VLAN. When the caller sets this flag and the fib
result is a VLAN device whose immediate parent is a real (non-VLAN)
device in the same network namespace, populate the existing output
fields params->h_vlan_proto and params->h_vlan_TCI from the VLAN
device and replace params->ifindex with the parent's ifindex.
params->h_vlan_TCI carries the VID only, with PCP and DEI bits zero; a
consumer wanting to set egress priority writes PCP itself.
params->smac is the VLAN device's own address, which can differ from
the parent's.

Only the immediate parent is resolved, via vlan_dev_priv(dev)->real_dev
and not vlan_dev_real_dev(), which walks to the bottom of a stack. For a
stacked VLAN (QinQ) the immediate parent is itself a VLAN device; since
one h_vlan_proto/h_vlan_TCI pair cannot describe two tags, ifindex is
left unchanged and the vlan fields remain zero in that case. The swap
is also skipped when the parent lives in another network namespace (a
VLAN device can be moved while its parent stays), since its ifindex
would be meaningless or match an unrelated device in the caller's
namespace. The swap and the vlan fields are written only on success;
other output fields keep their existing behaviour, so a frag-needed
result still reports the route mtu in params->mtu_result. When the
flag is not set, behaviour is unchanged: h_vlan_proto and h_vlan_TCI
are zeroed and ifindex is left at the FIB result.

The new block is compiled only under CONFIG_VLAN_8021Q since
vlan_dev_priv() is not defined otherwise; without that config
is_vlan_dev() is constant false and the flag is accepted but never
acts.

This lets an XDP redirect target the physical device and learn the
tag to push in a single lookup, which xdp-forward's optional VLAN
mode (xdp-project/xdp-tools#504) wants from the kernel side.

The helper's input semantics are unchanged; the reverse direction
(supplying a tag as lookup input) is added in the following patch.

Suggested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 include/uapi/linux/bpf.h       | 31 ++++++++++++++++++++++++++-
 net/core/filter.c              | 39 ++++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h | 31 ++++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 11dd610fa5fa..f77aa9472bf1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3527,6 +3527,31 @@ union bpf_attr {
  *			Use the mark present in *params*->mark for the fib lookup.
  *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
  *			as it only has meaning for full lookups.
+ *		**BPF_FIB_LOOKUP_VLAN**
+ *			If the fib lookup resolves to a VLAN device whose
+ *			parent is a real (non-VLAN) device, set
+ *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
+ *			the VLAN device and replace *params*->ifindex with the
+ *			parent's ifindex. This lets XDP programs that target
+ *			the underlying physical device (VLAN devices have no
+ *			XDP xmit) discover both the real egress ifindex and
+ *			the VLAN tag to push in one call. *params*->h_vlan_TCI
+ *			carries the VID only, with PCP and DEI bits zero; a
+ *			consumer wanting to set egress priority writes PCP
+ *			itself. *params*->smac is the VLAN device's own
+ *			address, which can differ from the parent's. Only the
+ *			immediate parent is resolved: for a stacked VLAN (QinQ)
+ *			the parent is itself a VLAN device, and since one tag
+ *			pair cannot describe two tags, *params*->ifindex is
+ *			left unchanged and the vlan fields remain zero. The
+ *			same applies when the parent is in another network
+ *			namespace, where its ifindex would be meaningless.
+ *			The swap and the vlan fields are written only on
+ *			success; other output fields keep the helper's
+ *			existing behaviour, so a frag-needed result still
+ *			reports the route mtu in *params*->mtu_result, and on
+ *			the tc path without tot_len the mtu check runs after
+ *			the swap, against the parent device.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7322,6 +7347,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7388,7 +7414,10 @@ struct bpf_fib_lookup {
 
 	union {
 		struct {
-			/* output */
+			/* output with BPF_FIB_LOOKUP_VLAN: set from the
+			 * resolved egress VLAN device (see the flag); zeroed
+			 * on other successful lookups.
+			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
 		};
diff --git a/net/core/filter.c b/net/core/filter.c
index 6fa172cb1348..b37a12321fba 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6119,10 +6119,40 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
 #endif
 
 #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
-static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
+static int bpf_fib_set_fwd_params(struct net_device *dev,
+				  struct bpf_fib_lookup *params,
+				  u32 flags, u32 mtu)
 {
 	params->h_vlan_TCI = 0;
 	params->h_vlan_proto = 0;
+
+#if IS_ENABLED(CONFIG_VLAN_8021Q)
+	/* vlan_dev_priv() is only defined when 8021q is built in or as a
+	 * module; under !CONFIG_VLAN_8021Q is_vlan_dev() is constant false
+	 * so this would be dead, but it still has to compile.
+	 */
+	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {
+		struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
+
+		/* Resolve the immediate parent only. For a stacked VLAN
+		 * (QinQ) the parent is itself a VLAN device, and a single
+		 * h_vlan_proto/h_vlan_TCI pair cannot describe both tags;
+		 * leave ifindex and the vlan fields untouched in that case
+		 * rather than report the lower device with only one tag.
+		 * The same applies when the parent lives in another netns
+		 * (a VLAN device can be moved while its parent stays):
+		 * its ifindex would be meaningless, or match an unrelated
+		 * device, in the caller's namespace.
+		 */
+		if (!is_vlan_dev(real_dev) &&
+		    net_eq(dev_net(real_dev), dev_net(dev))) {
+			params->h_vlan_proto = vlan_dev_vlan_proto(dev);
+			params->h_vlan_TCI = htons(vlan_dev_vlan_id(dev));
+			params->ifindex = real_dev->ifindex;
+		}
+	}
+#endif
+
 	if (mtu)
 		params->mtu_result = mtu; /* union with tot_len */
 
@@ -6266,7 +6296,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	return bpf_fib_set_fwd_params(dev, params, flags, mtu);
 }
 #endif
 
@@ -6406,13 +6436,14 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	return bpf_fib_set_fwd_params(dev, params, flags, mtu);
 }
 #endif
 
 #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
 			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
-			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK)
+			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK | \
+			     BPF_FIB_LOOKUP_VLAN)
 
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 11dd610fa5fa..f77aa9472bf1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3527,6 +3527,31 @@ union bpf_attr {
  *			Use the mark present in *params*->mark for the fib lookup.
  *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
  *			as it only has meaning for full lookups.
+ *		**BPF_FIB_LOOKUP_VLAN**
+ *			If the fib lookup resolves to a VLAN device whose
+ *			parent is a real (non-VLAN) device, set
+ *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
+ *			the VLAN device and replace *params*->ifindex with the
+ *			parent's ifindex. This lets XDP programs that target
+ *			the underlying physical device (VLAN devices have no
+ *			XDP xmit) discover both the real egress ifindex and
+ *			the VLAN tag to push in one call. *params*->h_vlan_TCI
+ *			carries the VID only, with PCP and DEI bits zero; a
+ *			consumer wanting to set egress priority writes PCP
+ *			itself. *params*->smac is the VLAN device's own
+ *			address, which can differ from the parent's. Only the
+ *			immediate parent is resolved: for a stacked VLAN (QinQ)
+ *			the parent is itself a VLAN device, and since one tag
+ *			pair cannot describe two tags, *params*->ifindex is
+ *			left unchanged and the vlan fields remain zero. The
+ *			same applies when the parent is in another network
+ *			namespace, where its ifindex would be meaningless.
+ *			The swap and the vlan fields are written only on
+ *			success; other output fields keep the helper's
+ *			existing behaviour, so a frag-needed result still
+ *			reports the route mtu in *params*->mtu_result, and on
+ *			the tc path without tot_len the mtu check runs after
+ *			the swap, against the parent device.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7322,6 +7347,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7388,7 +7414,10 @@ struct bpf_fib_lookup {
 
 	union {
 		struct {
-			/* output */
+			/* output with BPF_FIB_LOOKUP_VLAN: set from the
+			 * resolved egress VLAN device (see the flag); zeroed
+			 * on other successful lookups.
+			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
 		};
-- 
2.54.0


