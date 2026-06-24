Return-Path: <netdev+bounces-301562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bysWHROIO2pJZQgAu9opvQ
	(envelope-from <netdev+bounces-301562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:32:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD946BC308
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:32:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=XU7i0jba;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301562-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301562-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA62E3006136
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 07:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7173F2D5A01;
	Wed, 24 Jun 2026 07:32:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABFF2BEFEB
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 07:32:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286340; cv=none; b=qqRYBNtq/ivyOy8GRaYTmxWSRNps+RkKhug4L4mo3/YJclA+4DitT6BwuhSxX5Q0dBb/qjfGkqBFlvfhgOYhgJLnjAc4vFYmiICGzvEDbjuxTb3mL6aGlY4SW2xRw7iX8bnikmBwuz1AHY7S6Qxm51z6FmDyMvYEPTaPwpWfMM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286340; c=relaxed/simple;
	bh=Fz7tpw/PCpXHzYVNr4svpADvpkr73uMi+rRtG8GQFKY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ope05dCv37LFKJnA2FCav2jEeVyERKYy5i0MIzpwLzvelCNBl2Jc07Tvk344wGW1gAzvscFsUnkJ3Ixy+KDSucoPkKSvWJMAMbZGlC9Yq+KtE7tMq9BH/Uj1IXNM1nwBp/XBzfHEWbzhKxdRF/rbWlUniy+qzrCp9GP0wzJHApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XU7i0jba; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-517c65c019bso16219321cf.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782286331; x=1782891131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g+P6fiMb18NiS7zNL44bMJM2e8G83sIu0Jf6yiPCpJY=;
        b=XU7i0jbaN127nl/Ao+eyIHjKJlQMA3UwYQQCE11O9niP8ldP3bDy7Agpu4XGxvNj/u
         A+dCJLcb/ebQ7doi8JQnCQ/LdcG1PXVZuljW3AND/rInYWzTRefCusU63UfY+X1dT1Ap
         NOnqNBpfJnRXtdgJpNb/zKRa6+Eoby+NiHhIi+HcGMG88U/iyKhM/0j91/fTPgA8mvhm
         5xxdER1cWUGVFz8DSsikNsUX2pXge/qFyBWi3411Lu74TUrG4xmy3gvkVRJfbrwx9CEw
         DlBAfTZeg8wUoMxw8oA4o1m6dvcNXQQtHiZJYR2oTEzA4mqm7jcC77aZY+F4ezeMbTVl
         7+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782286331; x=1782891131;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+P6fiMb18NiS7zNL44bMJM2e8G83sIu0Jf6yiPCpJY=;
        b=OdXMy8Oqw+MuH9U/n5nuzt+hCIH/TJRcNdbmQ7gyP7QMZI/3pF4O4Y0fRFSasqSlg9
         LuYjZPNGiYEFwiHw0LZwDtM0ejuikOnXee4szuYoLERhRFMXaAT8ynAgbl0Uc9SFNzdH
         U7o8eny2MolEZRi6DCgcE7bDEe1VHNorzJgSBEznvb7G8XI6HNjyYhj/kPs7ktZLBV84
         4azxLZJYwvkd645291SbG8utKFNuOx65s3ZH2GJbykffj79476ajIR/bO6Nm6Wbcqu+I
         3sPSQ2zBFNGu49zREar8z5mqbVAcxlSUNm8hDwwbpnxu+HOixKWdr6BA4iAHu8zCVzaP
         m9YQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4+oRkp7ExWmVuPjlYdKQBbvc5PpK30xu0eWrEQgGxI0HGpzeKv+sDviuroUtngfG8XNBVKvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCT5BBpfbfWuhIYXLk/jUwAX1fWzcVYrYxaAJUHzZALwz+NwAJ
	PeC8aAAW5Z0c8k4+++lJ8LrDspblcE3ZVZr7a2sx5LO5EXUAonvUmIvF22jtmQN5CV1TnaD523K
	J6SOikIZQkBo+Vg==
X-Received: from qvbcu9.prod.google.com ([2002:a05:6214:17c9:b0:8dc:1405:9efe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5d01:0:b0:517:9296:b35b with SMTP id d75a77b69052e-51a61af36b7mr34553821cf.1.1782286330344;
 Wed, 24 Jun 2026 00:32:10 -0700 (PDT)
Date: Wed, 24 Jun 2026 07:32:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624073209.3703492-1-edumazet@google.com>
Subject: [PATCH net] net: clear transport header during tunnel decapsulation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+d5d0d598a4cfdfafdc3b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301562-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:syzbot+d5d0d598a4cfdfafdc3b@syzkaller.appspotmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,d5d0d598a4cfdfafdc3b];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AD946BC308

Syzbot triggered a DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) assertion in
pskb_may_pull_reason() called from qdisc_pkt_len_segs_init().

The root cause is a stale, negative transport header offset carried over
during tunnel decapsulation. When a tunnel receiver (e.g., VXLAN or Geneve)
decapsulates a packet, it pulls the outer headers but leaves the transport
header pointing to the outer UDP header. This offset becomes negative
relative to the new skb->data (inner IP header).

If the packet bypasses GRO (e.g., an untrusted GSO packet flagged as
"unexpected GSO" by udp_unexpected_gso() due to missing tunnel GSO bits),
it is flushed directly to the stack as GRO_NORMAL. On ingress, Layer 2 Qdisc
processing (sch_handle_ingress) happens before Layer 3 IP reception
(ip_rcv_core) can run and reset the transport header. Consequently,
qdisc_pkt_len_segs_init() attempts to validate the transport header using
pskb_may_pull(skb, hdr_len + sizeof(tcphdr)). The negative hdr_len overflows
the unsigned cast in pskb_may_pull(), triggering the assertion.

Fix this by clearing the transport header to the ~0U sentinel value during
decapsulation. This ensures that:
1) The ingress Qdisc safely skips validation via !skb_transport_header_was_set()
   and returns early without warning.
2) The IP layer (ip_rcv_core) later correctly resets the transport header
   to the inner L4 header offset.

Introduce skb_unset_transport_header() helper and apply it in the main
decapsulation paths:
1) __iptunnel_pull_header() (covering Geneve, GRE, IPIP, SIT, etc.)
2) vxlan_rcv() (covering VXLAN)

This restores skb invariants at the decapsulation boundary without adding
overhead to the Qdisc fast path.

Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
Reported-by: syzbot+d5d0d598a4cfdfafdc3b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a3b853b.52ae72c2.136ac7.000c.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Assisted-by: Gemini:gemini-3.1-pro
---
 drivers/net/vxlan/vxlan_core.c | 1 +
 include/linux/skbuff.h         | 5 +++++
 net/ipv4/ip_tunnel_core.c      | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 67c367cc566233e809b0f70e0d939dd1c1ac0d9f..49318ad8164a2f2572fc58c0ed449b68922ae71e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1799,6 +1799,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 
 	dev_dstats_rx_add(vxlan->dev, skb->len);
 	vxlan_vnifilter_count(vxlan, vni, vninode, VXLAN_VNI_STATS_RX, skb->len);
+	skb_unset_transport_header(skb);
 	gro_cells_receive(&vxlan->gro_cells, skb);
 
 	rcu_read_unlock();
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 115db8c44db21383632dd150a17c9ddcc03508e4..e8305a0fd3857ab85da4c2e8322989ed93e88d87 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3084,6 +3084,11 @@ static inline bool skb_transport_header_was_set(const struct sk_buff *skb)
 	return skb->transport_header != (typeof(skb->transport_header))~0U;
 }
 
+static inline void skb_unset_transport_header(struct sk_buff *skb)
+{
+	skb->transport_header = (typeof(skb->transport_header))~0U;
+}
+
 static inline unsigned char *skb_transport_header(const struct sk_buff *skb)
 {
 	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index d3c677e9bff2080e4760347a3d873da4e83ac3ca..59192f58da2e3aae19d00505cc3bb04b083b77c5 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -134,6 +134,7 @@ int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
 	__vlan_hwaccel_clear_tag(skb);
 	skb_set_queue_mapping(skb, 0);
 	skb_scrub_packet(skb, xnet);
+	skb_unset_transport_header(skb);
 
 	return iptunnel_pull_offloads(skb);
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog


