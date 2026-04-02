Return-Path: <netdev+bounces-274566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LuWLC55zmmMnwYAu9opvQ
	(envelope-from <netdev+bounces-274566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:11:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30E38A4B6
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E90C83046D9B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1313A3E122C;
	Thu,  2 Apr 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwjJTO40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A93E1CE7
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138570; cv=none; b=V8Ibdss7Yzg38TvphzVjdToS1YdlGrd5CucUws//yhVx23SHXrhzgdAFFsAN33AuJiy4LkD/Ce0liuNiWAM/X6Z9mrCjcyk1BJkIpPL3z+oYj51eC6eVDsLT5UyeJqLafA7WrSVIWwV/iHBrWRs709c6JcmQmbj/RW+QODWPd+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138570; c=relaxed/simple;
	bh=QuDJlFmHBgvStEeocMY+izf+6lwz4dximZB3hxaYZr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uw2Z6XlZWvFj8DK2GMHlxFqsm4bpTx0IQS3p12GakZSiVeG4XBwS45EO2CpLNNzjPRKWUUUJeKStgKL7189WqiKZ/3tn/6Wj02Vq+7WbVjjOu5T6fqBxhb/79dyN6LZCPcrepvG6FHzsXRGNOyNtStqt7elbdUZLMZ/3Ym1P3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwjJTO40; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4836cd6e0d4so1093525e9.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775138566; x=1775743366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjebN745cPTznKlBAtXhIYhg+ckfnG5/mIokgKeD9ZM=;
        b=DwjJTO40oMQ1s5uPBjD7/eYHiiYqyfyfVSAVPMvAlJJkHy3YOYWDr1YNPLf72aoIcC
         MCcGVupMCzLXXfhoLaegWlqy7nTaR4yiI3Ha8F3HhC2Gh1oAmXzrCSnsRO/yJq67XBLs
         NgBMFGs00PCft7Bd699PSVsCsdIt/TMd+nOKS4bqewhzoNUZutnx6ZMJ07/59tBAbqiB
         DNvO8U9F2mF6JbIY0LXDPhDCOqieP4SIt+DUTOuJF+mUNXwM8Wj68HF63aCK+DURTMRS
         /N2g0RJUW6kwax1dhq3X3xKk3Wx5ReuplW655mWfjVKybbBJh5hcpL0tovojxZIaISn1
         noQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775138566; x=1775743366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjebN745cPTznKlBAtXhIYhg+ckfnG5/mIokgKeD9ZM=;
        b=SP7bCG1jQ3V73iWgvqnVsnL2O9LjAuDbCKDNodmH0iyEJJ1RK7d9aG5i+VMseQPfGV
         mVSCjIZNZ4srsWYnaTT7yYFaFExg3w6Fn4SRsFd6+bjaFKgCjXuA8NOQG6TI8iyZhpaY
         GgsebJrzJxuJNy1H489Yew1ce3VB94BQfSQzv7jxK58E+TYcstGWtRmmyHTwTE0g9/qc
         f6qK78Tg5+OKYE+JKrYbvexmfnbKs2+6t6lB5ACplAt55q5ToH5+HYyRX840OM4B/55g
         cUgFiIGxdVnWeq/TySKVtcZ7Up51tvbgPWfZn4b5swFxRTQVx91TIFwmFFlwC5M+auKD
         ehYg==
X-Gm-Message-State: AOJu0YxMcvLCvPeavR1xk20/NZsSYh0+t1+rPGh+NG47SmsPHAjsnEbZ
	P6NwGkx8hT5ySnr8QHWa8zaGO7+Py4k8822UBoY9gE8Y/ELypm2RN95PYNGiHgRs
X-Gm-Gg: ATEYQzxRP4OaFZr9705dHiLC+OiQ4CoHXJQ8yw0TA7Cz7g64O4+DkUX2QMdD523eRT+
	rHUgQqA212/ICN2DWX/ZM2j0USYBtmsXIU59MHD4VuGAVySEO5oeEMBCmem8SOBShg0diSZOPJG
	PxmYe1EzsczSbX+4gAD6FUIfi6EBn8b+pHOD6xGwpb21dvWN6onHkcRnjDZwiN6gkJCJpcdqG3t
	sXXRU1lIY0+j3OV7OZIjq3CXQ3IGUF4HkUb0/l/P+VXw8ks2UM9sSpU3tD9a+hB0L//0cRLJ8rd
	Zdz9WoiBy5Oo/hxZjLlFXCm4V5q5JldW2ONNkn6fHup0XyQ0Mypx9sVi91RXLJW+Kwaid3ORiyf
	/XIIBLMDuEs1DfSbdnZlsvDUScd430xxh4G/p/Bvzgb4AnDiXbmDso/Ua9xqET9B3xpUDgyz15F
	RvvSu3DVb5O/D/vDjZqrYYArkmoDZ339NQv+BG/5TgyeXCFlVGLyBScNFrFPXdvy72dcV9USpVr
	r7c1Os=
X-Received: by 2002:a05:600c:474f:b0:485:3fc3:e8e9 with SMTP id 5b1f17b1804b1-48883592bf9mr79660525e9.3.1775138566110;
        Thu, 02 Apr 2026 07:02:46 -0700 (PDT)
Received: from ast-epyc4.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e1fe0b0sm7683269f8f.0.2026.04.02.07.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:02:45 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Zijing Yin <yzjaurora@gmail.com>
Subject: [PATCH net] bridge: guard local VLAN-0 FDB helpers against NULL vlan group
Date: Thu,  2 Apr 2026 07:01:53 -0700
Message-ID: <20260402140153.3925663-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-274566-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yzjaurora@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,lkml];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D30E38A4B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When CONFIG_BRIDGE_VLAN_FILTERING is not set, br_vlan_group() and
nbp_vlan_group() return NULL (br_private.h stub definitions). The
BR_BOOLOPT_FDB_LOCAL_VLAN_0 toggle code is compiled unconditionally and
reaches br_fdb_delete_locals_per_vlan_port() and
br_fdb_insert_locals_per_vlan_port(), where the NULL vlan group pointer
is dereferenced via list_for_each_entry(v, &vg->vlan_list, vlist).

The observed crash is in the delete path, triggered when creating a
bridge with IFLA_BR_MULTI_BOOLOPT containing BR_BOOLOPT_FDB_LOCAL_VLAN_0
via RTM_NEWLINK. The insert helper has the same bug pattern.

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000056: 0000 [#1] KASAN NOPTI
  KASAN: null-ptr-deref in range [0x00000000000002b0-0x00000000000002b7]
  RIP: 0010:br_fdb_delete_locals_per_vlan+0x2b9/0x310
  Call Trace:
   br_fdb_toggle_local_vlan_0+0x452/0x4c0
   br_toggle_fdb_local_vlan_0+0x31/0x80 net/bridge/br.c:276
   br_boolopt_toggle net/bridge/br.c:313
   br_boolopt_multi_toggle net/bridge/br.c:364
   br_changelink net/bridge/br_netlink.c:1542
   br_dev_newlink net/bridge/br_netlink.c:1575

Add NULL checks for the vlan group pointer in both helpers, returning
early when there are no VLANs to iterate. This matches the existing
pattern used by other bridge FDB functions such as br_fdb_add() and
br_fdb_delete().

Fixes: 21446c06b441 ("net: bridge: Introduce UAPI for BR_BOOLOPT_FDB_LOCAL_VLAN_0")
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
Tested on Linux v7.0-rc5 (upstream tag) with clang 20.1.0, KASAN
enabled, CONFIG_BRIDGE_VLAN_FILTERING=n.

Bug independently reproduced with the attached C reproducer
(repro_br_fdb.c). The crash triggers deterministically on the first
run with CONFIG_BRIDGE_VLAN_FILTERING=n on a clang-built kernel.

Exact crash signature from reproduction:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000056: 0000 [#1] KASAN NOPTI
  KASAN: null-ptr-deref in range [0x00000000000002b0-0x00000000000002b7]
  RIP: 0010:br_fdb_delete_locals_per_vlan+0x72/0x3f0
  Call Trace:
   br_fdb_toggle_local_vlan_0+0x3d/0x1d0
   br_boolopt_toggle+0xba/0x1a0
   br_boolopt_multi_toggle+0x129/0x250
   br_changelink+0x1100/0x1490
   br_dev_newlink+0x115/0x190
   rtnl_newlink+0xe15/0x25c0

Note: gcc 13.3 with the same config optimizes away the NULL dereference
path (UB elimination), so the crash does not trigger on gcc-built
kernels. The code is still incorrect regardless of compiler behavior.

Reproducer (C source): [PASTE_URL_HERE]
Kernel .config:        [PASTE_URL_HERE]

To reproduce: compile the C reproducer with `gcc -static -o repro repro.c`,
run as root on a clang-built kernel. The crash triggers during
br_dev_newlink() -> br_changelink() when the boolopt toggle reaches
br_fdb_delete_locals_per_vlan_port() with a NULL vlan group. Note:
RTM_SETLINK on an existing bridge may not trigger it due to different
code ordering.

 net/bridge/br_fdb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 0501ffcb8..e2c17f620 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -597,6 +597,9 @@ static void br_fdb_delete_locals_per_vlan_port(struct net_bridge *br,
 		dev = br->dev;
 	}
 
+	if (!vg)
+		return;
+
 	list_for_each_entry(v, &vg->vlan_list, vlist)
 		br_fdb_find_delete_local(br, p, dev->dev_addr, v->vid);
 }
@@ -630,6 +633,9 @@ static int br_fdb_insert_locals_per_vlan_port(struct net_bridge *br,
 		dev = br->dev;
 	}
 
+	if (!vg)
+		return 0;
+
 	list_for_each_entry(v, &vg->vlan_list, vlist) {
 		if (!br_vlan_should_use(v))
 			continue;
-- 
2.43.0


