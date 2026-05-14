Return-Path: <netdev+bounces-288061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BbBEVoGBmrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:28:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A198354551B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A865830D1BB1
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B663A7F59;
	Thu, 14 May 2026 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGtVw3d6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EAF3A254C
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779381; cv=none; b=h8m18C7qVogmz1xTxph+AeP2M8WiwB7JvMOY3DY0wzKMmu9EGk4+mTdpAg5P39jAKR5j67ppkwJvs7RCM8bL2XP4koEYAF1yRf9HlQQYUxuXiLWh4+UJ9ucBAXIwjvdo0JQ7CWO/b7ujQJwbLWanwrq1+YFsUpJYe/X21JA/+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779381; c=relaxed/simple;
	bh=1B5WmvIXKayyC0J1kIEzwUa1npVuZacKTjKHONiDIzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZX3UDvi/OKyJo9/oEtpsDYlNJ2r2BKeLb3pswbhsnsnawxLenFBIkAYz2eZxesBdrPHhl5rsKaCH2OOr3azo7ZMc2bzeFntEaqcl8MLOqk7H/+b5mBE4Ksa5g3F+u4tkc3cwQE1XOTWr79RLZgu8HIoiWYBNn4T3JuxhlP6WP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGtVw3d6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-83ef8b48f94so2406188b3a.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779378; x=1779384178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruCmrFi4ZZAtIJvShmwp8WknmatgfQD4UVTCxiwhorw=;
        b=UGtVw3d6oT2+cXGA+1nLce3MUwWXzKvbci6CTKRXULPcqyGpIovU/GX/URXaqHpDAP
         n6cW214LX7B8X8XOoxRW8VJrNXf2LnMC+eburguuCutgHy/bNJ41nhGjN3hUoet2gL6U
         NPAEZ+27X1zOhV97IXKVd/5ymd73IodS1UJQdO1r/ZwMRDuYHoyV/3yV4WHv2ozqExSy
         YrE/gmKsVb8Xrm2N9jZIGQ3dPwJf7AxiWPQBISbIob52rw8GhOtF0a6m8HT5Vhk82lYz
         N8HJ4X8yFfST/obqZpIGyadRRxzqVI1vSlnTx4+R+o+jUgwtfzIALdA/rZF9U75/mCsx
         DU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779378; x=1779384178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ruCmrFi4ZZAtIJvShmwp8WknmatgfQD4UVTCxiwhorw=;
        b=VnfFfobkaiL8DQxsmmBm1L8mhQwQaZPctkJzNBICmhd5npdCv1x1rmg+LDEn9P4XeM
         igDqFuv2NbOHJZrkF+4MW/nE6zcx/bHRTo3GFq5mXsAyej6hRjst6GbTmII/JDSLtbwZ
         I8LyWRhPIWhihfISq4P+qNZocWtpQj6iHuooS4OH2E/5mgEv/NFs0qi7PXyli6CV5Wph
         RA+ZnoC+8eF0seRkL+BH14COj5ILilYD3yP4gX7TgWWEfDeV4xQLQ2PE7FmrMK4LCw+g
         0Ou8gLeLBBOYK+unmucuNL/tZogdfqfInCd06rU1Wfx8CRmq7OmZPbQnNhzBZ0jy3dDA
         xq7g==
X-Forwarded-Encrypted: i=1; AFNElJ8QwBOTTcvVCTfS+jcZJMUUS0Cu8sG/3rLcARqqYhEtH7aPCu+Sg5WibV4/GgvKV+xnKLNsr9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqqFzPfD9kayfwqMvTh5yW5XrmNJ+gloLSk8zKiyvi78WEc895
	wq+be1nWTLcP8KtgondnHcmcQrYaLeqdjmssfl2eTYKYhbnBvfmUt6Nc
X-Gm-Gg: Acq92OG5+Xu4o7tMY3qArQelzbdrkG5LYk6+dbM13q8x71rWOpDBjXMGJpe1q4nDgYJ
	Fqe5dlU8300og/tYPJMrQ9gDzF9TKRhb5OTtdD+mqfHsFWBjZWbUWFppsZ+6C1yTnmiO3QBubqm
	7/f9chWNQKgJWJYyJwYyPoLgiS4BO2gVA+yrIMlL6dHNmTcy3hDWtulmSAuqnd3ovmG29yksH0l
	cka4AEnCDSctVFPe3ZG7s3fqcJHja6zCPXf6mBT1Fvi/Wezx5FloV+GBrqa37Xig9vPi5rQvJXK
	Um+Ast5k1oVbTjMIjuIOZ34P2Si3XYg1UV83KYLzpwrZA71xww/ESV4dKDDyVtuUb/WOdYcIeuB
	bmW++djl+gfO0NTOeUd4fS8+Eg1CGBQZ+IOi5tdzFeBYCcZ97SjbYnydjmTp0GkWc9Oz24miuzx
	CKHg/8wEgU/NVpr+Djj5nuCJDoB8hVEjHi
X-Received: by 2002:a05:6a00:8c5:b0:82c:9223:cc95 with SMTP id d2e1a72fcca58-83f33c4d6d7mr528527b3a.1.1778779377603;
        Thu, 14 May 2026 10:22:57 -0700 (PDT)
Received: from localhost ([2a03:2880:f80c:23::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c77162sm3685568b3a.40.2026.05.14.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:22:57 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 14 May 2026 10:22:34 -0700
Subject: [PATCH net-next v5 7/8] selftests: drv-net: add
 primary_rx_redirect support to NetDrvContEnv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-tcp-dm-netkit-v5-7-408c59b91e66@meta.com>
References: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
In-Reply-To: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: A198354551B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-288061-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_GT_50(0.00)[70];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,meta.com:email,meta.com:mid]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

When sending from a namespace that has access to a netkit device with a
leased queue, the nk primary in the host namespace needs to redirect its
RX to the physical device. This patch adds that redirection bpf program
and teaches the harness to install it.

Add primary_rx_redirect=False parameter to NetDrvContEnv.__init__().
When enabled, _attach_primary_rx_redirect_bpf() attaches a new BPF TC
program (nk_primary_rx_redirect.bpf.c) to the primary (host-side) netkit
interface. The program redirects non-ICMPv6 IPv6 packets to the physical
NIC via bpf_redirect_neigh(), with the physical ifindex configured via
the .bss map. ICMPv6 is left on the host's netkit primary so IPv6
neighbor discovery still work locally.

Extract _find_bss_map_id() from _attach_bpf() into a reusable helper so
other BPF attachment methods can use it.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v5:
- Use sys.byteorder when packing phys_ifindex into the BPF .bss map
  (Sashiko).

Changes in v3:
- nk_primary_rx_redirect.bpf.c: add header includes to avoid hardcoding
  values
- update commit message explaining why ICMP is passed through
- env.py: re-use _tc_ensure_clsact() (had to add ifname paramater)
- env.py: gate the remote IPv6 host route install on primary_rx_redirect
  by moving it from _setup_ns() into _attach_primary_rx_redirect_bpf()
---
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    | 39 +++++++++
 tools/testing/selftests/drivers/net/lib/py/env.py  | 94 +++++++++++++++++-----
 2 files changed, 115 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c
new file mode 100644
index 000000000000..46ff494b23de
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ipv6.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define ctx_ptr(field)		((void *)(long)(field))
+
+volatile __u32 phys_ifindex;
+
+SEC("tc/ingress")
+int nk_primary_rx_redirect(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct ethhdr *eth;
+	struct ipv6hdr *ip6h;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (eth->h_proto != bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	ip6h = data + sizeof(struct ethhdr);
+	if ((void *)(ip6h + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (ip6h->nexthdr == IPPROTO_ICMPV6)
+		return TC_ACT_OK;
+
+	return bpf_redirect_neigh(phys_ifindex, NULL, 0, 0);
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 409b41922245..ef317aef3a0a 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -2,6 +2,7 @@
 
 import ipaddress
 import os
+import sys
 import time
 import json
 from pathlib import Path
@@ -336,15 +337,18 @@ class NetDrvContEnv(NetDrvEpEnv):
               +---------------+
     """
 
-    def __init__(self, src_path, rxqueues=1, **kwargs):
+    def __init__(self, src_path, rxqueues=1, primary_rx_redirect=False, **kwargs):
         self.netns = None
         self._nk_host_ifname = None
         self.nk_guest_ifname = None
         self._tc_clsact_added = False
         self._tc_attached = False
+        self._primary_rx_redirect_attached = False
+        self._primary_rx_redirect_clsact_added = False
         self._bpf_prog_pref = None
         self._bpf_prog_id = None
         self._init_ns_attached = False
+        self._remote_route_added = False
         self._old_fwd = None
         self._old_accept_ra = None
 
@@ -396,8 +400,18 @@ class NetDrvContEnv(NetDrvEpEnv):
 
         self._setup_ns()
         self._attach_bpf()
+        if primary_rx_redirect:
+            self._attach_primary_rx_redirect_bpf()
 
     def __del__(self):
+        if self._primary_rx_redirect_attached:
+            cmd(f"tc filter del dev {self._nk_host_ifname} ingress", fail=False)
+            self._primary_rx_redirect_attached = False
+
+        if self._primary_rx_redirect_clsact_added:
+            cmd(f"tc qdisc del dev {self._nk_host_ifname} clsact", fail=False)
+            self._primary_rx_redirect_clsact_added = False
+
         if self._tc_attached:
             cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}")
             self._tc_attached = False
@@ -406,6 +420,11 @@ class NetDrvContEnv(NetDrvEpEnv):
             cmd(f"tc qdisc del dev {self.ifname} clsact")
             self._tc_clsact_added = False
 
+        if self._remote_route_added:
+            cmd(f"ip -6 route del {self.nk_guest_ipv6}/128",
+                host=self.remote, fail=False)
+            self._remote_route_added = False
+
         if self._nk_host_ifname:
             cmd(f"ip link del dev {self._nk_host_ifname}")
             self._nk_host_ifname = None
@@ -459,13 +478,19 @@ class NetDrvContEnv(NetDrvEpEnv):
         ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self.nk_guest_ifname} nodad", ns=self.netns)
         ip(f"-6 route add default via fe80::1 dev {self.nk_guest_ifname}", ns=self.netns)
 
-    def _tc_ensure_clsact(self):
-        qdisc = json.loads(cmd(f"tc -j qdisc show dev {self.ifname}").stdout)
+    def _tc_ensure_clsact(self, ifname=None):
+        """Ensure a clsact qdisc exists on @ifname.
+
+        Returns True if this call added the qdisc, otherwise returns False.
+        """
+        if ifname is None:
+            ifname = self.ifname
+        qdisc = json.loads(cmd(f"tc -j qdisc show dev {ifname}").stdout)
         for q in qdisc:
             if q['kind'] == 'clsact':
-                return
-        cmd(f"tc qdisc add dev {self.ifname} clsact")
-        self._tc_clsact_added = True
+                return False
+        cmd(f"tc qdisc add dev {ifname} clsact")
+        return True
 
     def _get_bpf_prog_ids(self):
         filters = json.loads(cmd(f"tc -j filter show dev {self.ifname} ingress").stdout)
@@ -476,28 +501,28 @@ class NetDrvContEnv(NetDrvEpEnv):
                 return (bpf['pref'], bpf['options']['prog']['id'])
         raise Exception("Failed to get BPF prog ID")
 
+    def _find_bss_map_id(self, prog_id):
+        """Find the .bss map ID for a loaded BPF program."""
+        prog_info = bpftool(f"prog show id {prog_id}", json=True)
+        for map_id in prog_info.get("map_ids", []):
+            map_info = bpftool(f"map show id {map_id}", json=True)
+            if map_info.get("name", "").endswith("bss"):
+                return map_id
+        raise Exception(f"Failed to find .bss map for prog {prog_id}")
+
     def _attach_bpf(self):
         bpf_obj = self.test_dir / "nk_forward.bpf.o"
         if not bpf_obj.exists():
             raise KsftSkipEx("BPF prog not found")
 
-        self._tc_ensure_clsact()
+        if self._tc_ensure_clsact():
+            self._tc_clsact_added = True
         cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj}"
             " sec tc/ingress direct-action")
         self._tc_attached = True
 
         (self._bpf_prog_pref, self._bpf_prog_id) = self._get_bpf_prog_ids()
-        prog_info = bpftool(f"prog show id {self._bpf_prog_id}", json=True)
-        map_ids = prog_info.get("map_ids", [])
-
-        bss_map_id = None
-        for map_id in map_ids:
-            map_info = bpftool(f"map show id {map_id}", json=True)
-            if map_info.get("name").endswith("bss"):
-                bss_map_id = map_id
-
-        if bss_map_id is None:
-            raise Exception("Failed to find .bss map")
+        bss_map_id = self._find_bss_map_id(self._bpf_prog_id)
 
         ipv6_addr = ipaddress.IPv6Address(self.ipv6_prefix)
         ipv6_bytes = ipv6_addr.packed
@@ -505,3 +530,36 @@ class NetDrvContEnv(NetDrvEpEnv):
         value = ipv6_bytes + ifindex_bytes
         value_hex = ' '.join(f'{b:02x}' for b in value)
         bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")
+
+    def _attach_primary_rx_redirect_bpf(self):
+        """Attach BPF redirect program on the primary netkit ingress."""
+        bpf_obj = self.test_dir / "nk_primary_rx_redirect.bpf.o"
+        if not bpf_obj.exists():
+            raise KsftSkipEx("Primary RX redirect BPF prog not found")
+
+        if self._tc_ensure_clsact(self._nk_host_ifname):
+            self._primary_rx_redirect_clsact_added = True
+        cmd(f"tc filter add dev {self._nk_host_ifname} ingress"
+            f" bpf obj {bpf_obj} sec tc/ingress direct-action")
+        self._primary_rx_redirect_attached = True
+
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via {self.addr_v['6']}",
+           host=self.remote)
+        self._remote_route_added = True
+
+        filters = json.loads(
+            cmd(f"tc -j filter show dev {self._nk_host_ifname} ingress").stdout)
+        redirect_prog_id = None
+        for bpf in filters:
+            if 'options' not in bpf:
+                continue
+            if bpf['options']['bpf_name'].startswith('nk_primary_rx_redirect'):
+                redirect_prog_id = bpf['options']['prog']['id']
+                break
+        if redirect_prog_id is None:
+            raise Exception("Failed to get primary RX redirect BPF prog ID")
+
+        bss_map_id = self._find_bss_map_id(redirect_prog_id)
+        phys_ifindex_bytes = self.ifindex.to_bytes(4, byteorder=sys.byteorder)
+        value_hex = ' '.join(f'{b:02x}' for b in phys_ifindex_bytes)
+        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")

-- 
2.53.0-Meta


