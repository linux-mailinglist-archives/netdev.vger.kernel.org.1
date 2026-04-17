Return-Path: <netdev+bounces-279231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIHPF7PL4WkhyQAAu9opvQ
	(envelope-from <netdev+bounces-279231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 07:57:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D406A41733F
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 07:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6AD3302768F
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 05:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49A136606C;
	Fri, 17 Apr 2026 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU5p9g4y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AAC3502A9
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776405255; cv=none; b=mKpXzwOn4KoRAxAf3ZMcoYj7Rftfg/ksY3USykXBMs4ngulY7RNkgmvMqiJeXK/lWAb8miSBJEPvy439tK7JJ1ju+UGtvPuc1GpQe83OvbQTrDL6HVwJSon29WvyNmxO2HlNDN4sjEoTIJ5GC/aw6lF4IoR29f+5bDrWXFZwt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776405255; c=relaxed/simple;
	bh=ZPVoDRVg5qdPPlFaadv6E/ZkAG3Lq7FAW7jz2H11nco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K7G9kmzTGPfaKRpaOIV4QlRPyxNHDhsVF+WIJEujLVAc4AfvmRHDg+YTpEHRiVMHRruNj9NUoaUCG24FS/knFEzEqPcnF7/q00VcSaz6r5L+/f3e5BqAg9WFxNNMdVYXy8XTclUEQZT3lKo+Z/twzz8RN/rq3nzlunqbEbqOswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU5p9g4y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so2078285e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 22:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776405252; x=1777010052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FI4aNMoH9LEGA5ZaunJU6TNqTpv8Ar0cTiNa6gwkLx0=;
        b=dU5p9g4yTLVz7u2/Exy32txOaWb7TyvQ8EPL3f3AyzSarc4YAcr/Q7M7JXKByXOglW
         cH3ZCi+PkwHJT/f0+gPqoZBWC6C+zez/XgSyKqHNP++hyXLIyvQjHWPatbfeBzgfUnOq
         14l5EBde5cFGnkieja5PxNXxjfaFIyw0Pr7tCOU4/q74YC37xYei1pwqJ8P2/uzFpxdY
         k8r3D/vuN2ydQbzJnfJgkzTc56e9hp79qJ5Q5oxefQA73isBmMHDv5FXyyQoN6LUBFi1
         DWoDtaHlVJfgEI2fdT5ujhJnwKlsphRWTENiX1wSH/iDgsqFpZiZJLCt84cWKVVGa0lw
         GYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776405252; x=1777010052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI4aNMoH9LEGA5ZaunJU6TNqTpv8Ar0cTiNa6gwkLx0=;
        b=sy/88aJh6quAO0Psp6T2VvOOs2mE7sKmPY1DsWOdfuz0AFMbFgvjS0KS/nQCkz4wfz
         QFdfn18l4tX2cc56zZYGoJK5RoNqW3sAa7OAxqPsvCCBbW3aerXZvc/8S9g08c9vZx6s
         sqMJplOrxihnmhd7ihPho+9bYdnPubp3wUNzhw1740CRVFEg4elTQz/zJVNFX6cLihil
         BpI/Qi7fS66muB9JSZJvO0OCqvEY2IK6z0C7x77E/Hf7FoJMzb9nIXNdCUxL8uhpNA6a
         X/xlPnS6rSWui3LpM9JQdq7wpAf9iu5LwavLue1M4TgeGAN3Bk+Ct+CnxjMTcIhiQZfA
         axdA==
X-Forwarded-Encrypted: i=1; AFNElJ8rkUNIID3qI25vR3xuBC7E00GryiLtLxnYrcO/YUabbSB0w/3qAgUCT25b+FFAnMsxQ0cp2vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT7driiioqs4OsGa4J5gtuVKWYCVbSZ3lFKRWWoPfsbgbtSmg+
	5uCfygFQgzAlH9Tu1/B7rSX+Rt5hzd1SqmrxSSHqsFA2q+g23FNVPL82
X-Gm-Gg: AeBDieuQfhSoTVibWb5Il1vf875D0vfCoD9EH+cGZvbaA0v6x4Gmh+AKPf+nHY58+Yt
	rrv1cH8FJ1NyFyddlID0kmErA1VNGk9XOyNn17uvP6fh4T1sMqAb/+gZoC2LT88+uQqwxb2RtX5
	psukwXcXmMiod8qgm4RAUnWcR5lqz3Z72LuDX29At4VPdYjJekrWfDW5/hob/S8tAmhPi6kxIqv
	PL0j8GgsoN4MreYYHdQPwyS2qGha4qhA0HUrYpaqVWdha5cKX22vIzfa7n1Ua5MPbV68Ej/bsJR
	U1AasGV+aorsuEDi7ZljhzN2xIm2mEOHyfCfTHWB+D2bqgmc3/OnSnOZuPPu0rLe/v+M1Z8r9vk
	QUrBHSPNiPpNZsY6MAsu1W+UJQ05NCZa9oWuKMVdwpFFssxLXbkZendmLLcKHnQGPHhjIobQ+lI
	JMMkRbgKCexZo+T1ONylFOIeiUDAUb3BaHO9VSCqJQk/iBVzHLj5o+6LT08MwT4HqwyOvrggiwB
	R80K9JK3MQ6TTxuO+izDg==
X-Received: by 2002:a05:600c:8115:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-488fb77e27cmr16466985e9.22.1776405251618;
        Thu, 16 Apr 2026 22:54:11 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c96b4sm27246775e9.13.2026.04.16.22.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 22:54:11 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Weiming Shi <bestswngs@gmail.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()
Date: Fri, 17 Apr 2026 06:54:08 +0100
Message-ID: <20260417055408.4667-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.osmocom.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-279231-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D406A41733F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

gtp_genl_send_echo_req() runs as a generic netlink doit handler in
process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
which eventually invokes iptunnel_xmit() — that uses __this_cpu_inc/dec
on softnet_data.xmit.recursion to track the tunnel xmit recursion level.

Without local_bh_disable(), the task may migrate between
dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
per-CPU counter pairing. The result is stale or negative recursion
levels that can later produce false-positive
SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.

The other udp_tunnel_xmit_skb() call sites in gtp.c are unaffected:
the data path runs under ndo_start_xmit and the echo response handlers
run from the UDP encap rx softirq, both with BH already disabled.

Fix it by disabling BH around the udp_tunnel_xmit_skb() call, mirroring
commit 2cd7e6971fc2 ("sctp: disable BH before calling
udp_tunnel_xmit_skb()").

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/gtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 70b9e58b9b78..5150f2e4f66b 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2400,6 +2400,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		return -ENODEV;
 	}
 
+	local_bh_disable();
 	udp_tunnel_xmit_skb(rt, sk, skb_to_send,
 			    fl4.saddr, fl4.daddr,
 			    inet_dscp_to_dsfield(fl4.flowi4_dscp),
@@ -2409,6 +2410,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			    !net_eq(sock_net(sk),
 				    dev_net(gtp->dev)),
 			    false, 0);
+	local_bh_enable();
 	return 0;
 }
 
-- 
2.53.0


