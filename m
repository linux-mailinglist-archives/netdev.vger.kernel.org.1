Return-Path: <netdev+bounces-300264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5hy1N34kM2qm9wUAu9opvQ
	(envelope-from <netdev+bounces-300264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:49:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDF569CBC1
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:49:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jgGRtpFu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300264-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300264-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC5063096441
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B826B3B14B2;
	Wed, 17 Jun 2026 22:47:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627AE3A4538
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 22:47:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781736473; cv=none; b=dveYnKZ1XXbiEFJq12lKRvzdAjRqSNwKkxQvoOBR6SEkp/35L33OWvLBMSUOP65H27jyKfTKQzltBehRD1r6AfXODjTwohINQuf4XEj/f9yB4Ie8moLETxWpk7l8xJDegZ3/6q5gbpmNbRMJp5wi7f6e/owReFys5A2/84FjErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781736473; c=relaxed/simple;
	bh=vLiNZqRyXQyJ7JmQ+K5SRwDiqvM3D2fcqR+SHxprbkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUtqU9AxSwT29QILc7imWUbcROnKnaNV8FA2vttU8G9EE3CVLKkYCEp+7KdC9rP+DAALFwD4Hp8TYL3QwRTIsKHzR51oYuIRSvZIrr675FWG5fRzv4atmWuE9fsycL6A/+POXq4m/uoNhj3gEahnMBeDfe0gX0oHzU+Iko9TFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgGRtpFu; arc=none smtp.client-ip=209.85.215.171
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c88973b6965so403916a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 15:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781736471; x=1782341271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8xesxQpAxdv66UTyIr8XNFGyaWsfxsftrAiKh8HnZU=;
        b=jgGRtpFuC/bBrg3ZqmnHl8dUcK303KO5FJVvrxYVh3gEI1i6/FF+tPYoMa3ZNQlcNk
         W7PFY1j4/H5YxkeUM2FT3/06K8oRm9faTVRi6cyqLBYA3Pen1xhGLGg+vVOsC6oGD85t
         ctp+vKb1k+ldEuzCUlGfAdlfzXw5D9mQKKEFmD/Jp0nnlGcS9AMTPzRTC+7idLvIK0iV
         etL7VwsS+aI3C2rxkinf+dDtDvS4ir/K4/rwUDFxF0twBxgkLfeDpxcLn+NP2iUyhrQr
         EHAO7Ex9yol+/M5JlzU/Zt//rE9m5Uba+uNtvuJFkwiKOfsqGk0IlS1q3567gnmEJhxj
         I2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781736471; x=1782341271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v8xesxQpAxdv66UTyIr8XNFGyaWsfxsftrAiKh8HnZU=;
        b=bULpRHnsYtThlGKHshDvZyQSXci4mljZNquNyfreJfjHZXeOnDmYf8ZhSUutgdfnAm
         v08rEcRBLokXP5U/7KGqlfJ8TGySk3p9Unia5IgN4V/S97p1U6Ap8s6iqNKR3L/t6+MC
         MpYnslRkmnHMZvSkRFqaYkqyMsjCoDdtqpjbPLbJm+0yA+6AAKSY8K9YoKQp11M47KxS
         1MMsXJ5zY9vBWFiqJ9GtE9gK0izCgOtxcoq9YbKCykAoGu0ivGd/HQxF7T35gIzOdzm2
         2EQFtKnSueWr/s09qQG8tM8OLEeswr2D3mou3TGiXCwj2g5BBNdo2wX4uhWUNJ5zxrmX
         ZhSA==
X-Forwarded-Encrypted: i=1; AFNElJ/Sbm4nOxj8Sml4r9w/Wxd0KseZF4/s46sBpxQgQX8vYAPXn77ojwVX/aJHi5WVDjWwXnRFYgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKqMI/pJJ17qhRikAiR5YVSsnO+jrsyTObiAgs6o/D3cm5Hp6J
	rAqlrBHwKdvN4nBNEnqCRQlzPGKSD5thkk5gLvEUznNHS1Y+wjn+5QOM
X-Gm-Gg: AfdE7cm8Jx/WZRrYyw4jYRs1xtPflWE8s2FwufLLI3iYLGR9eBgX8kT++asqpTOmN3P
	wWgct3g4CYKzcoO8ZgLT2byR7Nar8rY9CKYp6Is9SAKgMOvassDVoEPFS9cVePcB42PdfSixvPw
	r+tRz0RAMxV06Ho1aiG/+zfjCzdHJVyfIFV8in5hrOazThd+kHQx3YWPSjyWmQJf3kz4fRANFSr
	4XLsopqCvQBM7shtQADLeYLLPsk8vPTU2WZsMCbuHxvtc183/BUOaIKqwVz2TUSQnsmGfrb0VOD
	8YtO/2v8DwdL2CPZRNgGDIpUOaFVFEKg95/tn/Neoasoor+0rAxr+3LuzdHmGt0ydJFi3Q36RaJ
	sIecKsKfp6lpxlSGHjJnix2ZzHoflrHjl2eC0G1lr7sE6tVbyEDX/R07e0E2VFnlJ5Ia04quFLg
	HMl4GWkShao1xDw1mp7onbRSq56inx4CpoBUdJimdtm/ZEo2Rai/YqKrDf+W3l
X-Received: by 2002:a17:903:19ee:b0:2c6:c9e0:2c17 with SMTP id d9443c01a7336-2c6de3f353emr10279325ad.8.1781736470712;
        Wed, 17 Jun 2026 15:47:50 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433844a70sm170772265ad.84.2026.06.17.15.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 15:47:50 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: ameryhung@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	eddyz87@gmail.com,
	edumazet@google.com,
	emil@etsalapatis.com,
	eyal.birger@gmail.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rongtao@cestc.cn,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	toke@redhat.com,
	yatsenko@meta.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next v3 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Thu, 18 Jun 2026 04:17:27 +0530
Message-ID: <20260617224729.1428662-2-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617224729.1428662-1-avinash.duduskar@gmail.com>
References: <20260617224729.1428662-1-avinash.duduskar@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com,etsalapatis.com,linux.dev,redhat.com,cestc.cn,fomichev.me,meta.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300264-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:ameryhung@gmail.com,m:a.s.protopopov@gmail.com,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:dsahern@kernel.org,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:eyal.birger@gmail.com,m:hawk@kernel.org,m:horms@kernel.org,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kpsingh@kernel.org,m:kuba@kernel.org,m:leon.hwang@linux.dev,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:rongtao@cestc.cn,m:sdf@fomichev.me,m:shuah@kernel.org,m:song@kernel.org,m:toke@redhat.com,m:yatsenko@meta.com,m:yonghong.song@linux.dev,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 3DDF569CBC1

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
result still reports the route mtu in params->mtu_result.

On the skb path without tot_len the deferred mtu check is done against
the resolved egress device. To keep that the VLAN device rather than
the parent after the swap, bpf_ipv4_fib_lookup()/bpf_ipv6_fib_lookup()
hand the FIB-result device back to the caller; the XDP path always
runs the route-mtu check and passes NULL. When the flag is not set,
behaviour is unchanged: h_vlan_proto and h_vlan_TCI are zeroed and
ifindex is left at the FIB result.

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
 include/uapi/linux/bpf.h       | 22 +++++++++++-
 net/core/filter.c              | 61 +++++++++++++++++++++++-----------
 tools/include/uapi/linux/bpf.h | 22 +++++++++++-
 3 files changed, 84 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 89b36de5fdbb..f1ac9266a2ab 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3532,6 +3532,21 @@ union bpf_attr {
  *			Use the mark present in *params*->mark for the fib lookup.
  *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
  *			as it only has meaning for full lookups.
+ *		**BPF_FIB_LOOKUP_VLAN**
+ *			If the fib lookup resolves to a VLAN device whose
+ *			parent is a real (non-VLAN) device, set
+ *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
+ *			the VLAN device and replace *params*->ifindex with the
+ *			parent's ifindex. *params*->h_vlan_TCI carries the VID
+ *			only, with PCP and DEI bits zero; a consumer wanting to
+ *			set egress priority writes PCP itself. *params*->smac is
+ *			the VLAN device's own address, which can differ from the
+ *			parent's. Only the immediate parent is resolved (QinQ is
+ *			not supported), and the swap is skipped if the parent is
+ *			in a different namespace. The swap and the vlan fields
+ *			are written only on success; other output fields keep
+ *			the helper's existing behaviour, so a frag-needed result
+ *			still reports the route mtu in *params*->mtu_result.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7327,6 +7342,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7393,7 +7409,11 @@ struct bpf_fib_lookup {
 
 	union {
 		struct {
-			/* output */
+			/*
+			 * output with BPF_FIB_LOOKUP_VLAN: set from the
+			 * resolved egress VLAN device (see the flag); zeroed
+			 * on other successful lookups.
+			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
 		};
diff --git a/net/core/filter.c b/net/core/filter.c
index 2e96b4b847ce..27e4792f11e9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6201,10 +6201,26 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
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
+	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {
+		struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
+
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
 
@@ -6214,7 +6230,8 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
 
 #if IS_ENABLED(CONFIG_INET)
 static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
-			       u32 flags, bool check_mtu)
+			       u32 flags, bool check_mtu,
+			       struct net_device **fwd_dev)
 {
 	struct neighbour *neigh = NULL;
 	struct fib_nh_common *nhc;
@@ -6347,13 +6364,16 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	if (fwd_dev)
+		*fwd_dev = dev;
+	return bpf_fib_set_fwd_params(dev, params, flags, mtu);
 }
 #endif
 
 #if IS_ENABLED(CONFIG_IPV6)
 static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
-			       u32 flags, bool check_mtu)
+			       u32 flags, bool check_mtu,
+			       struct net_device **fwd_dev)
 {
 	struct in6_addr *src = (struct in6_addr *) params->ipv6_src;
 	struct in6_addr *dst = (struct in6_addr *) params->ipv6_dst;
@@ -6486,13 +6506,16 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	if (fwd_dev)
+		*fwd_dev = dev;
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
@@ -6507,12 +6530,12 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 #if IS_ENABLED(CONFIG_INET)
 	case AF_INET:
 		return bpf_ipv4_fib_lookup(dev_net(ctx->rxq->dev), params,
-					   flags, true);
+					   flags, true, NULL);
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
 		return bpf_ipv6_fib_lookup(dev_net(ctx->rxq->dev), params,
-					   flags, true);
+					   flags, true, NULL);
 #endif
 	}
 	return -EAFNOSUPPORT;
@@ -6532,6 +6555,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
 {
 	struct net *net = dev_net(skb->dev);
+	struct net_device *fwd_dev = NULL;
 	int rc = -EAFNOSUPPORT;
 	bool check_mtu = false;
 
@@ -6547,29 +6571,28 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	switch (params->family) {
 #if IS_ENABLED(CONFIG_INET)
 	case AF_INET:
-		rc = bpf_ipv4_fib_lookup(net, params, flags, check_mtu);
+		rc = bpf_ipv4_fib_lookup(net, params, flags, check_mtu,
+					 &fwd_dev);
 		break;
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		rc = bpf_ipv6_fib_lookup(net, params, flags, check_mtu);
+		rc = bpf_ipv6_fib_lookup(net, params, flags, check_mtu,
+					 &fwd_dev);
 		break;
 #endif
 	}
 
 	if (rc == BPF_FIB_LKUP_RET_SUCCESS && !check_mtu) {
-		struct net_device *dev;
-
-		/* When tot_len isn't provided by user, check skb
-		 * against MTU of FIB lookup resulting net_device
+		/*
+		 * Without tot_len, check the skb against the FIB result
+		 * device's MTU, which BPF_FIB_LOOKUP_VLAN keeps as the VLAN
+		 * device even though params->ifindex was swapped to the parent.
 		 */
-		dev = dev_get_by_index_rcu(net, params->ifindex);
-		if (unlikely(!dev))
-			return -ENODEV;
-		if (!is_skb_forwardable(dev, skb))
+		if (!is_skb_forwardable(fwd_dev, skb))
 			rc = BPF_FIB_LKUP_RET_FRAG_NEEDED;
 
-		params->mtu_result = dev->mtu; /* union with tot_len */
+		params->mtu_result = fwd_dev->mtu; /* union with tot_len */
 	}
 
 	return rc;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 89b36de5fdbb..f1ac9266a2ab 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3532,6 +3532,21 @@ union bpf_attr {
  *			Use the mark present in *params*->mark for the fib lookup.
  *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
  *			as it only has meaning for full lookups.
+ *		**BPF_FIB_LOOKUP_VLAN**
+ *			If the fib lookup resolves to a VLAN device whose
+ *			parent is a real (non-VLAN) device, set
+ *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
+ *			the VLAN device and replace *params*->ifindex with the
+ *			parent's ifindex. *params*->h_vlan_TCI carries the VID
+ *			only, with PCP and DEI bits zero; a consumer wanting to
+ *			set egress priority writes PCP itself. *params*->smac is
+ *			the VLAN device's own address, which can differ from the
+ *			parent's. Only the immediate parent is resolved (QinQ is
+ *			not supported), and the swap is skipped if the parent is
+ *			in a different namespace. The swap and the vlan fields
+ *			are written only on success; other output fields keep
+ *			the helper's existing behaviour, so a frag-needed result
+ *			still reports the route mtu in *params*->mtu_result.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7327,6 +7342,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7393,7 +7409,11 @@ struct bpf_fib_lookup {
 
 	union {
 		struct {
-			/* output */
+			/*
+			 * output with BPF_FIB_LOOKUP_VLAN: set from the
+			 * resolved egress VLAN device (see the flag); zeroed
+			 * on other successful lookups.
+			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
 		};
-- 
2.54.0


