Return-Path: <netdev+bounces-259696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NqWI5wsmGmzCAMAu9opvQ
	(envelope-from <netdev+bounces-259696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:42:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D97791665CB
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49BCC305377A
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E215E32471C;
	Fri, 20 Feb 2026 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VBxrf+1j"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E2932470D
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771580508; cv=none; b=nDlzTz6XwrV21DqDgaiJhfvPctORlvgmhbG0zzzo9OnggoqMR+y+tn2+OgslulPEXLguk5Rio4fBIasOhVnsD7GNS0b0i210cOF3xuazo7zsIFzI1/RncAf3TlHklnYuywAcIPiVXEoPGKTWYfPhNUwIiq98O3E6sJGDAS5Y76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771580508; c=relaxed/simple;
	bh=zHsdc08qlTOz3ekq2MAtX1SSobflabv45ilvnE7IHvw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+oC6FujpBUVliaeDvJWlckGVX0r9bBzynph084k+TIfvBcPZQcqt9iDTLeEGznWTAjbTdt+xEpTFdMeBhPm2+sW6upc9B2WnHIlzoFgyP1/iH4SE3O5bVDtQftkHkqQQIrSAJeIpEllsFK644mSJkbK4KopQnYiEXEva6JO+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VBxrf+1j; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 59A3A2083E;
	Fri, 20 Feb 2026 10:41:45 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SjERtMZovip1; Fri, 20 Feb 2026 10:41:44 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 22CB22082E;
	Fri, 20 Feb 2026 10:41:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 22CB22082E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1771580504;
	bh=/N0Nbtkhxm+Pn6ttKIXqVUF5Me7PCRm8co6Wqhuig4M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=VBxrf+1jEw86bjm7zwUm6it5K2ipMfi9tViiTeWv4tpUDgbXLileGbOTwIt2xnEUj
	 9SMV6H/fZN4sH45YW4jXvKjaT5/PAdL8x25yA5wcfRaGszN9qMqwc/GUe7ii4OscU2
	 XJOyBmzl6aXO7EKdAgHxsz7WALFEx1LCJRPJeS9GvaYiHk7BfItt+QNZaHDQMviPUe
	 Xq5A7GFaa5Nuxz6CX2DGDt7aEeZDgs+lMbVRAYdK2OddG6Mg63ZFbqkYholfXH8gl4
	 mF3S8+VaMeN9AFgyIsfvDYKT48MMSMpQdLVMh3wMUCn1u/ejE9sWQluLS7ZKu7Jylz
	 b5lPVh2DJ53Ew==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 10:41:43 +0100
Received: (nullmailer pid 16445 invoked by uid 1000);
	Fri, 20 Feb 2026 09:41:40 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/3] xfrm6: fix uninitialized saddr in xfrm6_get_saddr()
Date: Fri, 20 Feb 2026 10:41:15 +0100
Message-ID: <20260220094133.14219-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220094133.14219-1-steffen.klassert@secunet.com>
References: <20260220094133.14219-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-259696-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:mid,secunet.com:dkim,secunet.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D97791665CB
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

xfrm6_get_saddr() does not check the return value of
ipv6_dev_get_saddr(). When ipv6_dev_get_saddr() fails to find a suitable
source address (returns -EADDRNOTAVAIL), saddr->in6 is left
uninitialized, but xfrm6_get_saddr() still returns 0 (success).

This causes the caller xfrm_tmpl_resolve_one() to use the uninitialized
address in xfrm_state_find(), triggering KMSAN warning:

=====================================================
BUG: KMSAN: uninit-value in xfrm_state_find+0x2424/0xa940
 xfrm_state_find+0x2424/0xa940
 xfrm_resolve_and_create_bundle+0x906/0x5a20
 xfrm_lookup_with_ifid+0xcc0/0x3770
 xfrm_lookup_route+0x63/0x2b0
 ip_route_output_flow+0x1ce/0x270
 udp_sendmsg+0x2ce1/0x3400
 inet_sendmsg+0x1ef/0x2a0
 __sock_sendmsg+0x278/0x3d0
 __sys_sendto+0x593/0x720
 __x64_sys_sendto+0x130/0x200
 x64_sys_call+0x332b/0x3e70
 do_syscall_64+0xd3/0xf80
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable tmp.i.i created at:
 xfrm_resolve_and_create_bundle+0x3e3/0x5a20
 xfrm_lookup_with_ifid+0xcc0/0x3770
=====================================================

Fix by checking the return value of ipv6_dev_get_saddr() and propagating
the error.

Fixes: a1e59abf8249 ("[XFRM]: Fix wildcard as tunnel source")
Reported-by: syzbot+e136d86d34b42399a8b1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68bf1024.a70a0220.7a912.02c2.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv6/xfrm6_policy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 1f19b6f14484..125ea9a5b8a0 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -57,6 +57,7 @@ static int xfrm6_get_saddr(xfrm_address_t *saddr,
 	struct dst_entry *dst;
 	struct net_device *dev;
 	struct inet6_dev *idev;
+	int err;
 
 	dst = xfrm6_dst_lookup(params);
 	if (IS_ERR(dst))
@@ -68,9 +69,11 @@ static int xfrm6_get_saddr(xfrm_address_t *saddr,
 		return -EHOSTUNREACH;
 	}
 	dev = idev->dev;
-	ipv6_dev_get_saddr(dev_net(dev), dev, &params->daddr->in6, 0,
-			   &saddr->in6);
+	err = ipv6_dev_get_saddr(dev_net(dev), dev, &params->daddr->in6, 0,
+				 &saddr->in6);
 	dst_release(dst);
+	if (err)
+		return -EHOSTUNREACH;
 	return 0;
 }
 
-- 
2.43.0


