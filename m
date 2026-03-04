Return-Path: <netdev+bounces-263645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJVsEgvsp2mWlwAAu9opvQ
	(envelope-from <netdev+bounces-263645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:23:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3BD1FC86F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D3BA302573B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39A1351C36;
	Wed,  4 Mar 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5VC+SeO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C093033E9;
	Wed,  4 Mar 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612424; cv=none; b=rEAFYo/lN4HC8YWax4wd8t2aEIp5GGagadjCogQpqPhDhd1uBvmUoqcyhcpheyCK3ay5Etbes/ZSxzD3sprQXQYF5DLjbAs48KUHzUUiI9cYWzNrm6nob7SZ4VieZYen1rksm6mhNUmCXGoLX2LKqOLCqtn7rGwx55OLb9iCIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612424; c=relaxed/simple;
	bh=LgsT2ZLIn1tM6EIVIbCNe9NLt6lkZlMPPb9/TSVpbPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jeKHu1QD7CWurP22Poji4p2f6c8Fju8AKpuJRdpSS1EL9eHq7iF//rGfZTfpbNK89Ar3wUGkVxmoQJ3KOIyxRJYpT+SzAMM13BbQppQEk19AbFrWwKUWQcyVbzHLGSdq1OMV6j5J9Zcq7iIz6JcWggvMPgX4NVGwEae7WiKPujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5VC+SeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10378C19425;
	Wed,  4 Mar 2026 08:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772612424;
	bh=LgsT2ZLIn1tM6EIVIbCNe9NLt6lkZlMPPb9/TSVpbPY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=n5VC+SeOLL+FOp9tniAIyKI9vsveNDh5ND0y7WUsMQWPMDNsaKY+EuSQFmrRlF2mr
	 DXHe/d8XYzzI17jixvJy0YPlSgJginzKT55X0bRwH8JPYKNmxo3Np7nKv7Op28qyRe
	 RkHned9OW2S48hYrafWsDQ+Avj/zZSH+zUidBmkaXf1Ja3zFHo1u1MyO5yqATmLi4U
	 XxcRBrEXXzWou1EA1CF2CYW/uJI1txHpL3AwaVyDmDqCVvu0746DVeWacrHX0iKS3r
	 ZtgJLm321Bki3uIYRx9OSisbyHTmC4WKYGSrke96KZyR7x9bLq/j/lN6kioAL4Q65U
	 VtVXRJ806sa7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0117EB7EA4;
	Wed,  4 Mar 2026 08:20:23 +0000 (UTC)
From: Maximilian Pezzullo via B4 Relay <devnull+maximilianpezzullo.gmail.com@kernel.org>
Date: Wed, 04 Mar 2026 09:20:23 +0100
Subject: [PATCH] net: bridge: fix NULL dereference in br_do_suppress_nd
 when ipv6.disable=1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-br-nd-suppress-ipv6-null-fix-v1-1-084356ba8257@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqDMBAAvyJ77kISNQW/Ij1E3bQLIQ1ZFEHyd
 xePMwxzgVBlEpi6CyodLPzPCvbVwfoL+UvImzI447zpzYBLxbyh7KVUEkEuh8e8p4SRTzRhtD6
 u7h1tAF1oo/rZz5/Wbl62a91uAAAA
X-Change-ID: 20260304-br-nd-suppress-ipv6-null-fix-0a516fc27f1a
To: Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Guruprasad C P <gurucp2005@bugzilla.kernel.org>, 
 Maximilian Pezzullo <maximilianpezzullo@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772612423; l=1381;
 i=maximilianpezzullo@gmail.com; s=20260303; h=from:subject:message-id;
 bh=HvIRU/i10xnVMJH/+ZNsf/sb22J8jejklG20d/MkhlI=;
 b=H1UIZ23bHg2tUhPT/B36gsRLVgF6dOQrgedgYPa2gB8N3k2aMndRbMNRp4MyC68a1YB916q2k
 IM7hHazRSNcBZO/shE3Z1glFxiwlDELetWeaLorRqMzb6U+TS9nqXKb
X-Developer-Key: i=maximilianpezzullo@gmail.com; a=ed25519;
 pk=TRTR4c2Vb1IfluQvv5OUDPg7EE+pIzdPBND85UU559w=
X-Endpoint-Received: by B4 Relay for maximilianpezzullo@gmail.com/20260303
 with auth_id=658
X-Original-From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reply-To: maximilianpezzullo@gmail.com
X-Rspamd-Queue-Id: CD3BD1FC86F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263645-lists,netdev=lfdr.de,maximilianpezzullo.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,bugzilla.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[maximilianpezzullo@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

When the kernel is booted with ipv6.disable=1, the IPv6 module loads
but skips full initialization, leaving ipv6_stub as NULL. If the bridge
neigh_suppress feature is enabled on a port and an ICMPv6 Neighbor
Solicitation arrives, br_do_suppress_nd() calls neigh_lookup() via
ipv6_stub->nd_tbl without first checking whether ipv6_stub is valid,
causing a kernel panic.

Fix this by returning early if ipv6_stub or its nd_tbl pointer is NULL.

Reported-by: Guruprasad C P <gurucp2005@bugzilla.kernel.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221143
Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
---
 net/bridge/br_arp_nd_proxy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 1e2b51769eec..0b1b9ba29b7d 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -455,6 +455,9 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		return;
 	}
 
+	if (!ipv6_stub || !ipv6_stub->nd_tbl)
+		return;
+
 	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, vlandev);
 	if (n) {
 		struct net_bridge_fdb_entry *f;

---
base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
change-id: 20260304-br-nd-suppress-ipv6-null-fix-0a516fc27f1a

Best regards,
-- 
Maximilian Pezzullo <maximilianpezzullo@gmail.com>



