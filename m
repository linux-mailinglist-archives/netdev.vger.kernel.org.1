Return-Path: <netdev+bounces-301247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z9ieJen0OWqKzQcAu9opvQ
	(envelope-from <netdev+bounces-301247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 04:52:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F13A6B39F9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 04:52:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cKuX8nbL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301247-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301247-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5EEC303E6F5
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 02:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F323138736C;
	Tue, 23 Jun 2026 02:52:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04036A342
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 02:52:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183131; cv=none; b=WRZ4qAV3BB8BKz27j/NDHAX0JE6ZYWYL7D0Y34BU94VLzzFDd8HeF9c8aWvkLqc1XQeTg6peRLcQVSJNl6vBM02LgWXh+pMtRPvCQQXJNnKJKJXHhG7SQemAf9fs6zwSVmH3LnFAL6l6Rupxb/93fEHRag76a445GCrNT/xSO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183131; c=relaxed/simple;
	bh=TjVpOmfrNXF3e4LsIjxNPPcAWdCGIF3siBzPliAi5pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=md6fvF/+ovp13jwya4Y/lir6FmylLG0MfUzuLn2psSwu4ISPDqUq+b9pG0t529ZUNTK9542TLH1C9QGVNmm9bdSfpii1yGzfw8SAaOmzR8Uc4+FZUQnYjotGIvh/w0jYfNTdPBzKel4HgVQuAm3Bve0GesRVbUmt5hWivgzmB/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKuX8nbL; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c69921bd15so21073485ad.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 19:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782183129; x=1782787929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7udfFwoM44z6Z7DmzG7wbfy56mg2vcFrBln5eXE8ZQ4=;
        b=cKuX8nbLZ1VADyhF9T7ny3fJVkBo1rD1h/4yh2JxVBNJfrYV0LfOOTyGPiJh/A/9ty
         9vhBtdN4ltRfThKzKlGtJ1t/vNav8errRvTKmv25SDua07qN5jG4NADuE02vUDgU8h5u
         8ZQE3d8HntBSDkjQOL9c3Cd2nhajgDWHSC98HCghw27Ey5zlEuEQKqkYOJCNihLND35z
         3qcIJcauem55+nUvFPiDVDTiMVAqOQxvQA8nqwcXjI3r7an3NHStioF35p+Dzk/EGF/J
         UVoO3NboTgQJBCZ/xtj7pyGC57B0xWlttaqdlkIDh3EJoCAX158NtkEd4Z7CXMm/olbC
         E1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782183129; x=1782787929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7udfFwoM44z6Z7DmzG7wbfy56mg2vcFrBln5eXE8ZQ4=;
        b=mzb1iScrT8ZxMjZpeYIHbz+VEvqPgaFGkjxLmCf4j8PPMaV0F27nt2melfokVjqkCG
         nlLWb5HUTBjxYwM6Ee2/7velvy149HSn4L2C68JugYXf9qDrXpIV2mSNwkBRzemEhlRS
         JC89qOfWTF/bAzj94SC6ad7m+Y10RkYKzZm6lRrlI2OkY3sk4YIpC1vZq7hagHbZOZZy
         TXBl7rwz/4uxfcgxBRKu0Sy4RBr1eBw3fCLtvyYeVJya+8hIBE5YoORNd9X+OQ++28kg
         MU5Mo/QACiZnDIrAnbwXyNqiz0Gk9JtWlCVYycqUqva1UQgk9fTZVAoHwTnVihhxxKXy
         F4Yg==
X-Forwarded-Encrypted: i=1; AHgh+RrU2bQjA03h/eX0Y6ZwPPQnaXW2iTzFmDTgae23CSIdHwDUmBPcFtBu/qhZ29GVEx98h3zYH4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7Hc7VPKooA2ufwNeXe+IPf+asmA2SOd63RYAYeSNrkQwdhaM
	6pOOlpxCTkophI41SDCHGOgSYJDoLlVZcyaFCcLzMdpVVMjDxQj91A5v
X-Gm-Gg: AfdE7cnfaFYObHSq0UJc/VThtkRz0icsea1REg9udksklIkpBQyFZL76DLM0YU4kBDD
	HWuc26ssXruDPbaHtFA1HuVf9vP9daG2qG+HJm0HXe9xw0n51yHz/a9CIcKDKM9H/zHdNxhYm9e
	7HjV5+q00l/694hek/HnXPSCkFwlMwkcnjbc8uoDnhshClOMF/cfUIG+ZYBQ+3YunnnTEwXHOHe
	beV4B6sPnA/ZphBCFJBGJsn7xAoI5y2kJphRG9HTuNC612VYWLWnhr3FGnZdjP+vouG7QoRoOIn
	dbp80880tDG8DCAPkmGM+b/Cw2HzNoWoT1/BSSMTiBm644P7wI7w/30jRxH7OSoGpHlbFAshMXA
	SYDWLAb1dlaRHrVT4jLZq2niEI072r7GRq86kbbDnbScs+oVDf4dS+rYHIB0W7W8O8oDQ5eyF/H
	NjzN/bTeyGa2S4QD9kUYKrmh8TICW5y5QsGRtdD1YjNPQTX0ZXc+0G3nB6o6JyVLoVqfWHlsE=
X-Received: by 2002:a17:903:1b65:b0:2c0:b081:849a with SMTP id d9443c01a7336-2c7c9acb9admr4464705ad.30.1782183128767;
        Mon, 22 Jun 2026 19:52:08 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8e51sm102704625ad.39.2026.06.22.19.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 19:52:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Tue, 23 Jun 2026 08:21:45 +0530
Message-ID: <20260623025147.1001664-2-avinash.duduskar@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301247-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:toke@redhat.com,m:dsahern@kernel.org,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F13A6B39F9

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
and not vlan_dev_real_dev(), which walks to the bottom of a stack. When
the immediate parent is not a real device in the same namespace, the
lookup returns BPF_FIB_LKUP_RET_VLAN_FAILURE and leaves params->ifindex
at the input. This covers a stacked VLAN (QinQ), where the immediate
parent is itself a VLAN device and one h_vlan_proto/h_vlan_TCI pair
cannot describe two tags, and a parent in another network namespace (a
VLAN device can be moved while its parent stays), whose ifindex would
be meaningless in the caller's namespace. A program that wants the VLAN
device's own ifindex re-issues the lookup without BPF_FIB_LOOKUP_VLAN,
so the unreducible case stays distinct from a physical egress. That
distinction matters for XDP: a program cannot xmit on a VLAN device, so
a success carrying the VLAN ifindex would make it redirect to a device
with no ndo_xdp_xmit and drop the frame at xdp_do_flush(). The swap and
the vlan fields are written only on the reduce path; other output
fields keep their existing behaviour, so a frag-needed result still
reports the route mtu in params->mtu_result.

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
acts. That is safe because no VLAN device can exist there, so every
egress is already physical.

This lets an XDP redirect target the physical device and learn the
tag to push in a single lookup, which xdp-forward's optional VLAN
mode (xdp-project/xdp-tools#504) wants from the kernel side.

The helper's input semantics are unchanged; the reverse direction
(supplying a tag as lookup input) is added in the following patch.

Suggested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 include/uapi/linux/bpf.h       | 28 +++++++++++++-
 net/core/filter.c              | 69 ++++++++++++++++++++++++----------
 tools/include/uapi/linux/bpf.h | 28 +++++++++++++-
 3 files changed, 104 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 89b36de5fdbb..8d0058d88eb2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3532,6 +3532,26 @@ union bpf_attr {
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
+ *			parent's. Only the immediate parent is resolved; if it
+ *			is itself a VLAN device (QinQ) or in another namespace,
+ *			the egress cannot be reduced to a physical device plus
+ *			one tag and the lookup returns
+ *			**BPF_FIB_LKUP_RET_VLAN_FAILURE** with *params*->ifindex
+ *			left at the input. Re-issue without
+ *			**BPF_FIB_LOOKUP_VLAN** to obtain the VLAN device's own
+ *			ifindex. The swap and the vlan fields
+ *			are written only on success; other output fields keep
+ *			the helper's existing behaviour, so a frag-needed result
+ *			still reports the route mtu in *params*->mtu_result.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7327,6 +7347,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7340,6 +7361,7 @@ enum {
 	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
 	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
 	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
+	BPF_FIB_LKUP_RET_VLAN_FAILURE, /* VLAN egress, parent unresolvable */
 };
 
 struct bpf_fib_lookup {
@@ -7393,7 +7415,11 @@ struct bpf_fib_lookup {
 
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
index 2e96b4b847ce..8345295d84de 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6201,10 +6201,28 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
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
+		} else {
+			return BPF_FIB_LKUP_RET_VLAN_FAILURE;
+		}
+	}
+#endif
+
 	if (mtu)
 		params->mtu_result = mtu; /* union with tot_len */
 
@@ -6214,8 +6232,10 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
 
 #if IS_ENABLED(CONFIG_INET)
 static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
-			       u32 flags, bool check_mtu)
+			       u32 flags, bool check_mtu,
+			       struct net_device **fwd_dev)
 {
+	u32 in_ifindex = params->ifindex;
 	struct neighbour *neigh = NULL;
 	struct fib_nh_common *nhc;
 	struct in_device *in_dev;
@@ -6347,16 +6367,23 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	if (fwd_dev)
+		*fwd_dev = dev;
+	err = bpf_fib_set_fwd_params(dev, params, flags, mtu);
+	if (err == BPF_FIB_LKUP_RET_VLAN_FAILURE)
+		params->ifindex = in_ifindex;
+	return err;
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
+	u32 in_ifindex = params->ifindex;
 	struct fib6_result res = {};
 	struct neighbour *neigh;
 	struct net_device *dev;
@@ -6486,13 +6513,19 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	if (fwd_dev)
+		*fwd_dev = dev;
+	err = bpf_fib_set_fwd_params(dev, params, flags, mtu);
+	if (err == BPF_FIB_LKUP_RET_VLAN_FAILURE)
+		params->ifindex = in_ifindex;
+	return err;
 }
 #endif
 
 #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
 			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
-			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK)
+			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK | \
+			     BPF_FIB_LOOKUP_VLAN)
 
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
@@ -6507,12 +6540,12 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
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
@@ -6532,6 +6565,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
 {
 	struct net *net = dev_net(skb->dev);
+	struct net_device *fwd_dev = NULL;
 	int rc = -EAFNOSUPPORT;
 	bool check_mtu = false;
 
@@ -6547,29 +6581,26 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
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
+		/* without tot_len, check the skb against the FIB-result
+		 * device's MTU
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
index 89b36de5fdbb..8d0058d88eb2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3532,6 +3532,26 @@ union bpf_attr {
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
+ *			parent's. Only the immediate parent is resolved; if it
+ *			is itself a VLAN device (QinQ) or in another namespace,
+ *			the egress cannot be reduced to a physical device plus
+ *			one tag and the lookup returns
+ *			**BPF_FIB_LKUP_RET_VLAN_FAILURE** with *params*->ifindex
+ *			left at the input. Re-issue without
+ *			**BPF_FIB_LOOKUP_VLAN** to obtain the VLAN device's own
+ *			ifindex. The swap and the vlan fields
+ *			are written only on success; other output fields keep
+ *			the helper's existing behaviour, so a frag-needed result
+ *			still reports the route mtu in *params*->mtu_result.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7327,6 +7347,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7340,6 +7361,7 @@ enum {
 	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
 	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
 	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
+	BPF_FIB_LKUP_RET_VLAN_FAILURE, /* VLAN egress, parent unresolvable */
 };
 
 struct bpf_fib_lookup {
@@ -7393,7 +7415,11 @@ struct bpf_fib_lookup {
 
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


