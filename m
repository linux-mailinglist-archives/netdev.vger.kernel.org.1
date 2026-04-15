Return-Path: <netdev+bounces-278641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IHcDYQK32n3NwAAu9opvQ
	(envelope-from <netdev+bounces-278641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:48:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9EF4001EB
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99042303AB65
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 03:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382C330B0B;
	Wed, 15 Apr 2026 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC0tC2I3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21ED31F988
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 03:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224645; cv=none; b=eS8m2GL4LPDiruygU+n+Hptooic2gBQffuw8vltykhg8bxORblCU06vfysiWXxbIEYB81vafHMwjPKYaRJivXc2IVxh6QqZX/hhBTZii8Ru8cPMcqmosHwo4E/4uC8WEWEAo52q9hBKSo2oQtBkN7W4Y0b/aIzwJKl0bXbk8hNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224645; c=relaxed/simple;
	bh=uGI8GPnr9VXAA69kZ/s2eB6gRTG6FQSN6oJeK6M8pWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgB4/OJGPi9FbvqiEdkwTBP+KXBIz1NuDAJRyjUzswiz0IXhhYZDai0a21sSTklgtbFPPMwy02mxMBujvEsNvpCPNY8t1rb1LK6g9XRqDds1uxGfuXw66Qk5SXpBrUwckUXDPAqYJbTVgo0M2moW1h1uFqLOuBFnSxuzqy2ORSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC0tC2I3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35fb7f51171so2506568a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 20:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776224636; x=1776829436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNhZ4rollUkSxm2n10gtXaqIbxDOKMY7jgWaxNLfqIc=;
        b=AC0tC2I3MGoA0QxRj+i7bNb0yRLDqJxdePAAo7BiHLPTQBhEMNs9L1riDtVSUa7yLS
         gI78K4ux83nGd4BQuumcDYPaHhrPA21XVOcwfocqJUB2HQa4EhQJPArg2tucCiaNKPSw
         +fdsaSBFWfWpGodfQF7LbiTGmX/A+zVF+i71/wLPWT//Nc50hHr51KgPVMvxwE6mNq5X
         vYmbjR7TBTIDMVbhs9O4wcbLVCpuCMd9Y8laqeBVXmqyFX0TbYvUMKrJq8OR44HzMhNC
         vG1X3v1jRwXL+2kOaNiljmb8sTInUe1lCxVJuIkt4FwyrSrRUzhkazJSiH9PpMSW/kU9
         pguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776224636; x=1776829436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNhZ4rollUkSxm2n10gtXaqIbxDOKMY7jgWaxNLfqIc=;
        b=eRV/ex4ir6M9FHbnMDN+shTxFao70scziXN3pN3YA50CTH1bvxCpJDzMteKzd9HDze
         dEeUvauuk5xIav8y2eVROAjwTQ/ZWLoI2p4wXyAGOsR60CNYnjjxas/NPpduoTa7R7Ku
         4bYlrWtIM5AY+LjmXycBFqk/LU+y+6JQrTUwRc57dyZM60BSnYrPQvngTR+yC3WBmHzb
         nTNJVOdsqFaXHrR6FIfF/Lq171/TBk12VqHhQmGISioDdedIxew4Ia9F6n5MxO202/3t
         CfvH7S58rbPP8B+H0P0cFuDD28Cl4tPINt+nkZJwlhslCYGLmjthOyUw7kH2oTpXXdbN
         zEpg==
X-Forwarded-Encrypted: i=1; AFNElJ9ULla+ozqT8N0kC6iu9V4p2X8zIEfMJI2RwDVEeutwRz9rckAWNabFbHFgUL5sYEyu+aEqnk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc/j1dwWTXGI5kHWfwXRTxXA5QcQeUwRBC74DNhV3KVWYfIw8P
	JPxK3aJVyJ5C6cT/SpE03bvMVAAa7Niqyv/ZX1qKbD+wGMk7EgTytt36
X-Gm-Gg: AeBDievATI2nn4XE0WxpMdLwi/RMMsi5OFjg/bhdhEd9QhEyQPB3gRBdcdUWRMuugVp
	J9gIfLeSxCq2rJh52pvOORgL0sd7dQXmc8AXpqPN9qRiNoYIkkhwQTvWpJ/uOhn650wxuyhuAC6
	033+PKzKVkpS4jq+SDzqyZmiUJbwsa93oNTrCbkp/PrUi0nQvKrLJKSd9TiTjRjaSbFI9cGALCB
	RxBrJlLJo0vbd7P/H3bqwYaGy8xGbg233F6qEptZmcHG3B+C1L86djJ03uyvm+D0zRMUkmy7KgR
	oBzul/7IcRdn0FCLn9/OvUoTiC/HYFdYeSEFmjo2GmZuQAI/LUYSBkqGMn851iDnLhak3ch0a9X
	viznZjnuO58ACRbZV6IyG7ARyesUOD8jsyL3W3bcGbr8T+18vTpY+BlBpuKZSQ+yp755vAeqsfR
	hu81SUbVHUPO22pXpr5aEOWZSA/8UXYvyoJkNuuIOnDmI3rVA=
X-Received: by 2002:a17:903:3c30:b0:2b4:5f69:715d with SMTP id d9443c01a7336-2b45f697b4bmr107939525ad.25.1776224636000;
        Tue, 14 Apr 2026 20:43:56 -0700 (PDT)
Received: from home-hyperv.mshome.net ([103.136.124.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782cb32csm4742175ad.79.2026.04.14.20.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 20:43:55 -0700 (PDT)
From: "Kito Xu (veritas501)" <hxzene@gmail.com>
To: pablo@netfilter.org
Cc: fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jengelh@medozas.de,
	kaber@trash.net,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Kito Xu (veritas501)" <hxzene@gmail.com>
Subject: [PATCH] netfilter: xt_realm: fix null-ptr-deref in realm_mt()
Date: Wed, 15 Apr 2026 11:43:43 +0800
Message-Id: <20260415034343.107920-1-hxzene@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,medozas.de,trash.net,vger.kernel.org,netfilter.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-278641-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hxzene@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F9EF4001EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

realm_mt() unconditionally dereferences skb_dst(skb) without a NULL
check. The xt_realm match registers with .family = NFPROTO_UNSPEC,
making it available to all netfilter protocol families. Through the
nftables compat layer (nft_compat), an unprivileged user inside a
user/net namespace can load this match into a bridge-family chain.

nft_match_validate() explicitly permits NFPROTO_BRIDGE, and the hook
bitmask check cannot distinguish bridge hooks from inet hooks because
NF_BR_FORWARD and NF_INET_FORWARD share the same numeric value (2).
The match also has no .checkentry callback to reject non-IP families.

When a pure L2 bridged packet traverses the chain, it has never gone
through IP routing, so skb_dst() returns NULL. realm_mt() then
dereferences this NULL pointer at dst->tclassid, causing a kernel oops.

Add a NULL check for the dst_entry pointer. When dst is NULL, return
false (no match), which is the correct semantic since a packet without
a routing realm cannot match any realm-based rule.

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 1 UID: 0 PID: 169 Comm: poc Not tainted 7.0.0-rc7-next-20260410+ #15 PREEMPTLAZY
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:realm_mt+0xa0/0x180
Call Trace:
 <IRQ>
 nft_match_eval+0x1b7/0x310
 nft_do_chain+0x261/0x1740
 nft_do_chain_bridge+0x20c/0xe10
 nf_hook_slow+0xac/0x1e0
 __br_forward+0x33a/0x480
 br_handle_frame_finish+0xab8/0x1d10
 br_handle_frame+0x80f/0x12c0
 __netif_receive_skb_core.constprop.0+0xbd4/0x2c10
 __netif_receive_skb_one_core+0xae/0x1b0
 process_backlog+0x197/0x590
 __napi_poll+0xa1/0x540
 net_rx_action+0x401/0xd80
 handle_softirqs+0x19f/0x610
 do_softirq.part.0+0x3b/0x60
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x64/0x70
 __dev_queue_xmit+0x9f3/0x30e0
 packet_sendmsg+0x2126/0x5470
 __sys_sendto+0x34e/0x3a0
 __x64_sys_sendto+0xe0/0x1c0
 do_syscall_64+0x64/0x680
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>
Kernel panic - not syncing: Fatal exception in interrupt

Fixes: ab4f21e6fb1c ("netfilter: xtables: use NFPROTO_UNSPEC in more extensions")
Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
---
 net/netfilter/xt_realm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/xt_realm.c b/net/netfilter/xt_realm.c
index 6df485f4403d..6d3a86647cae 100644
--- a/net/netfilter/xt_realm.c
+++ b/net/netfilter/xt_realm.c
@@ -24,6 +24,9 @@ realm_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	const struct xt_realm_info *info = par->matchinfo;
 	const struct dst_entry *dst = skb_dst(skb);
 
+	if (!dst)
+		return false;
+
 	return (info->id == (dst->tclassid & info->mask)) ^ info->invert;
 }
 
-- 
2.43.0


