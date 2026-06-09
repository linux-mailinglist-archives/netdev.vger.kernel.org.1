Return-Path: <netdev+bounces-297187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hqIOBjVMKGo3BwMAu9opvQ
	(envelope-from <netdev+bounces-297187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:24:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 780AA662E86
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:24:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gh2FqYWo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297187-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297187-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 321673077618
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6D24C0437;
	Tue,  9 Jun 2026 17:21:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F1B495525
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:21:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025665; cv=none; b=EEbOzv1nrrKVsPHsqB/A6nDLQVOWOLQVKVZul8izdkJUBRvZN0QAHlJZYRYMj9RkfF5YX0aE7Ht0qXBFMzw7CgG7VwTdLNbipKtOT2xAXxuoJsHrYtNoKbdg9GUI7I5zoa5VTaPzb3YncZt3Kjfeskx0E1cz3pW83bgmCxY/yNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025665; c=relaxed/simple;
	bh=XI+haEC2quli2Sq4sQ1q6XgpT3Tfp0QBhoSuBsxUEY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=icKcjJ+oOtn4RSviZi8baRwcrgg+FAkTn82xqCi9Dv126jH8VEAkpV12xsdF8eU1IJMl/V3Kv45eOJUpPkay497LrwTgUWYUvU6H7XgNWM2MBAF7SbGI7EmqefMvmbIssajz1P+GamBaDXxNwCeqYvoGtsD9D228KHsv062NnSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh2FqYWo; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf18c30bb2so42050075ad.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781025663; x=1781630463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jyluqLv68wQjEUlv0jIOE7AOWLZPwx75nmuUuadG8AQ=;
        b=gh2FqYWonFl9nkdGAup99zRkfaEL+RVCVebxRUL6QI22YNCcivm7j3H94Zx8bHKZc5
         pNK6k2ddqNVwSwHaryeLs8hoXDErRV7n0ZUr2p/H9iW9/IBzdXQhBLtw1DzWOAZOfpfS
         g8BCLtrEfAE9OOnI03Vdkf58pWUNDc0OGl5ThZTON3bRapw6Hkf3BL0WLqL/NefEvx4z
         cb+/y4i4AeaFL3Uj286rfffwMidBf8GA6NcitTkV4dCVtXRSxAXS8nDfHW6Y+ha5uhbf
         lpMaxmo8CNvM0NDYJ8uwDBIrPe2WxZX07dVAhqAC0/PmeZZIpyOT7mVZy4iPNOi9mkAz
         hYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025663; x=1781630463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyluqLv68wQjEUlv0jIOE7AOWLZPwx75nmuUuadG8AQ=;
        b=exvGkk1hDZvxwuaEu9I9qVKLIDJNMOtNr82cagq/P95HmV+n2tqyr2wgaHxLag2rVR
         Q2y7H8HIEaCrAjmL2cmOQdSuxxi02vp5Vhz16FAphyOf9Q2ENOnXBxMI6qi4ijyIaXHe
         GwRcr2ABWMrNWDaQlI/7+3LCCEM9dNrjAvtUzTH7H5JS8ChHMnK6ekDAp7D5Y/7D6mSL
         lwuWwZZU6bpUFQraEctXA62bzg3nlCNOy6jmW00ELJ4nlZ7+4uoGL8cDv1+fuIhdoXKI
         RAyZNi5coJT8RxjOH2lG2fSb+DMf2aMDxa/RFodm0cCJ4Bo8w9wDcNDGPK8/xCeS1W/Z
         bZTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mkSXOaxBIUM20dGKG5JHL4OHQcKjw2BAoNXl8o3nFxKyxGwNvTD8xlWJYWb61Nkc/2uYSXLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUCYyABKB7IC+DD/MR1ezajZzXuudCL5KfDdRGFa7meBXtv51
	czReFDi4Aztfv5SlZy/hJxlwEWDbtfb6b3oP8XPbZGDTG1LNnTciNeIO
X-Gm-Gg: Acq92OE2cgUHV95JxHFzwAfUzb/qY860zRfRIcEd8YeWbMUFHknZlv8AZtpwulBOey+
	H85ZX1VYQw7VAe9HpHel6J8IVa4TtFob2WMiK6AtJmvJM6WsjDbjKC8fpkMngzhpz1V7pJI2qM+
	8cL6vxEQHjld+ylnYpa20jnYM+XDo+A9hhMBOaywfWMYZWHGGm2izNM3PXg7QqFAbbz+C62BZeg
	FxVMyYDHBqFzCc07yEgZxMcxvgtHsE0pBSAEvNU0Srwm9SVsguKkq7PEWzgr0MEqpI8InTZDNSb
	wHDdxbT3uzjd1FDABogVAUja0WJNsCrjJ8gIqHX7cYDjrcwNj0l396MWGYZ7ssnFXbG3MRKIZcn
	aph6KiqMASp6lVoNwLCMmgNpI7VajTDBlgY/qHSjzVqptGRzT8nXGlfr5mwFKMSOAQXdjKuhN9A
	EBoO8zOmm0aW+HnuW1EeEvAAo8tuM2hp1Bk0vkg8vl1ZzHePNGPw5BFc67K1+lWO6jE3ht6XLwG
	7SgbcF09w==
X-Received: by 2002:a17:903:1b08:b0:2c0:f807:56b2 with SMTP id d9443c01a7336-2c1e8955cd3mr214711275ad.34.1781025662838;
        Tue, 09 Jun 2026 10:21:02 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649fab9sm220736435ad.79.2026.06.09.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:21:01 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Tue,  9 Jun 2026 22:50:52 +0530
Message-ID: <20260609172052.81613-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297187-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:hawk@kernel.org,m:kpsingh@kernel.org,m:toke@redhat.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 780AA662E86

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
result is a VLAN device, populate the existing output fields
params->h_vlan_proto and params->h_vlan_TCI from the VLAN device,
and replace params->ifindex with the underlying real device's
ifindex. params->h_vlan_TCI carries the VID only, with PCP and DEI
bits zero; a consumer wanting to set egress priority writes PCP
itself. Only the immediate parent is resolved; stacked VLANs (QinQ)
are not walked. When the flag is not set, behaviour is unchanged:
h_vlan_proto and h_vlan_TCI are zeroed and ifindex is left at the
FIB result.

This lets an XDP redirect target the physical device and learn the
tag to push in a single lookup, which xdp-forward's optional VLAN
mode (xdp-project/xdp-tools#504) wants from the kernel side.

The change extends bpf_fib_set_fwd_params() to take the egress dev
and the lookup flags so the VLAN swap happens in the same place the
vlan output fields are zeroed by default. Both IPv4 and IPv6
callers pass through. The helper's input semantics are unchanged.
Under !CONFIG_VLAN_8021Q, is_vlan_dev() returns false and the new
block is a no-op.

Suggested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 include/uapi/linux/bpf.h       | 21 ++++++++++++++++++++-
 net/core/filter.c              | 27 +++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h | 21 ++++++++++++++++++++-
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 11dd610fa5fa..aa7fe378a35d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3527,6 +3527,19 @@ union bpf_attr {
  *			Use the mark present in *params*->mark for the fib lookup.
  *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
  *			as it only has meaning for full lookups.
+ *		**BPF_FIB_LOOKUP_VLAN**
+ *			If the fib lookup resolves to a VLAN device, set
+ *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
+ *			the VLAN device and replace *params*->ifindex with the
+ *			underlying real device's ifindex. This lets XDP
+ *			programs that target the underlying physical device
+ *			(VLAN devices have no XDP xmit) discover both the
+ *			real egress ifindex and the VLAN tag to push in one
+ *			call. *params*->h_vlan_TCI carries the VID only,
+ *			with PCP and DEI bits zero; a consumer wanting to
+ *			set egress priority writes PCP itself. Only the
+ *			immediate parent is resolved; stacked VLANs (QinQ)
+ *			are not walked.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7322,6 +7335,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7388,7 +7402,12 @@ struct bpf_fib_lookup {
 
 	union {
 		struct {
-			/* output */
+			/* output: only populated with BPF_FIB_LOOKUP_VLAN
+			 * when the resolved egress is a VLAN device, in
+			 * which case *ifindex* is replaced with the
+			 * underlying real device's ifindex. Otherwise
+			 * both fields are zeroed.
+			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
 		};
diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..782fa86df95a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6119,10 +6119,28 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
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
+	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {
+		struct net_device *real_dev = vlan_dev_real_dev(dev);
+
+		/* Only the immediate parent is resolved; stacked VLANs
+		 * (QinQ) are not walked, and a NULL real_dev (which
+		 * is_vlan_dev() rules out in practice) keeps the
+		 * original ifindex.
+		 */
+		if (real_dev) {
+			params->h_vlan_proto = vlan_dev_vlan_proto(dev);
+			params->h_vlan_TCI = htons(vlan_dev_vlan_id(dev));
+			params->ifindex = real_dev->ifindex;
+		}
+	}
+
 	if (mtu)
 		params->mtu_result = mtu; /* union with tot_len */
 
@@ -6265,7 +6283,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	return bpf_fib_set_fwd_params(dev, params, flags, mtu);
 }
 #endif
 
@@ -6404,13 +6422,14 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
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
index 11dd610fa5fa..aa7fe378a35d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3527,6 +3527,19 @@ union bpf_attr {
  *			Use the mark present in *params*->mark for the fib lookup.
  *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
  *			as it only has meaning for full lookups.
+ *		**BPF_FIB_LOOKUP_VLAN**
+ *			If the fib lookup resolves to a VLAN device, set
+ *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
+ *			the VLAN device and replace *params*->ifindex with the
+ *			underlying real device's ifindex. This lets XDP
+ *			programs that target the underlying physical device
+ *			(VLAN devices have no XDP xmit) discover both the
+ *			real egress ifindex and the VLAN tag to push in one
+ *			call. *params*->h_vlan_TCI carries the VID only,
+ *			with PCP and DEI bits zero; a consumer wanting to
+ *			set egress priority writes PCP itself. Only the
+ *			immediate parent is resolved; stacked VLANs (QinQ)
+ *			are not walked.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7322,6 +7335,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7388,7 +7402,12 @@ struct bpf_fib_lookup {
 
 	union {
 		struct {
-			/* output */
+			/* output: only populated with BPF_FIB_LOOKUP_VLAN
+			 * when the resolved egress is a VLAN device, in
+			 * which case *ifindex* is replaced with the
+			 * underlying real device's ifindex. Otherwise
+			 * both fields are zeroed.
+			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
 		};

base-commit: f1a660bbd12dd855fce6cf13f144008c4e45e7c7
-- 
2.54.0


