Return-Path: <netdev+bounces-281176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ0XHl5F7ml2rwAAu9opvQ
	(envelope-from <netdev+bounces-281176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 19:03:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EAA46AA4D
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E8730078E7
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD5125A2B5;
	Sun, 26 Apr 2026 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjnOFllF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE814EEC0
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777222451; cv=none; b=COk1xX2qZwS67n/9mgWCPgMNJZhNNPEnn6n2igVM+nT5ObsGv2V+PIu7iK+G0OTnmVgW7+kQk7IGwis5C7kzzTkuNKr2iBcpQ/4z0UcaI2jaOUA5hwjzhfvk/p2uFtPc5jJ/Y01VmUEIJdAYvOi5l9pv7RXgh0ZkhuzxDPhHfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777222451; c=relaxed/simple;
	bh=Nz8RE9jBowKZinbU00agnMEyKGXH2n0e/WSlA5lzJUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qp6Z7tEHc6qf8LPJchmKCrAx2ZKkr7ZLpxFCy7v17l1darRw+BrBXVZ0da3l8xAmgYDrONT2lasgpMd0FrlRRXo4ST1xuT/Wvvc4Lm33knQR+0yod3c89crH93Hlyi2Hss/M1bQbAdKlcLq/CP6RsIi56ziwJDywNZcpel6z8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjnOFllF; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6b0500e06so14576223eec.1
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777222449; x=1777827249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fek+ClrEARBNMfK0Lmi3AOoFP46bSz44bXEprXCKlnU=;
        b=PjnOFllFRmnAungmxXWtuZlFK1QFr5AJ/Hjn7pWtyi/KeCehG6PH+bcrxSJ5cpbAiB
         2KCEbrLsBILHYB2HNq6Zb2bMLTlgpo3gtb2PBkeYq8OTZM0K+ra4yGVQIojHt/G4rZ/s
         TO5Fw9CJjkxRLXa6pHgriWx6WumEonDt1MYGQK83QIrmisNQCnJmlndGHKZ07uqqpRNx
         y90xDlC41SSzUL1HJZRLDHo3ReclMN5BP7FCjJm56zktek7fNFoGSEOsPIcvrf4R3wmA
         LXcda4/89ZZiztzAzoDEJKIZIrRXnTp3Xz2oOwHGniy1iUPdxWELLbT+g/TBR8bvfS4h
         6Ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777222449; x=1777827249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fek+ClrEARBNMfK0Lmi3AOoFP46bSz44bXEprXCKlnU=;
        b=ahUOFAHC4uoNWag9M+vVkzpLQlT/kWaj5+LNdcx699AT+qqEDKx+oUQ+thdLfD9Va4
         fgQxe0GsGiw6NTUNpp1HYmTaaNaaMpj9bViP2jKZc3mhVQR8Il651ZKFCwLZkgnPUC7k
         AliAXM5tSB85P5woXloAiFPpNsTI3GfOyAsa4ApaVyd59zWJexMQpuN69oLc8mL33YyK
         2Gifv+M7TgpQcgWhwsp0AKgz6ytnPudZ1+JIrsbMoieeGvxnLgoCkAPZNX/+3nFnk2PY
         vMf42KFE2lkludfIYaCDrBtePIrPnXjwlW/6R9tckG9rukMTrrdLErSn4S5kmYFsx3oa
         B+jg==
X-Forwarded-Encrypted: i=1; AFNElJ+AGU/5xfUdrLmThRYO3lqgoW+UNvVwC7Asv+bVWhxan5sifmQWX/FIKh5tYdHgon66JIHzHE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFKuMEEGUTB9TElfB1yTKKfRTvVSyFACEG3GIS0WHu6GkyCrW
	OMc0b77g95hn9vvCppbS15kIQutvL8IB1BAn5fWfxETLqLw4ZU5n7vB+
X-Gm-Gg: AeBDieuNa5+mDtVBTofIiYiP79iaDmnqBSqkQQXH+ui9Ut6BT4HGP/2sUArnwLjPb96
	eUvGbxgZvEH5KnCdsth2zzYvpmtxGDW+0K0azBeUq+Ypfhvr09lT2s5Sihjv4NSe/yBDQOUB6HN
	BgKL9yM+Gzxokn/f/IeUGkP95eYoDsWlU3Yk7HnSZFn4u/fZSpx1Ee3hihDb8F86Q/3S/8MgMv7
	TXF15jIi7ubAjKEpavclE69qCpnw+lMC5pQzj6cbS3oxOSuDmex9UgRMfvfFfCV57ZvkH3qJcjR
	z1hr44/D8GIzpm3PPALbiZxh6iQUh1XE79tzvOx2Xx6Y+sDVTiutbrsmG15hPP3Omv6rIO/ejJV
	I4LIMQDH63D6CuxTO/aRXCjs59qYO2LutgqpYiPIuacoxIyJT9Hivf1ynTqCTMYV7CW4t2lpB2R
	enWvqS524TbiMz8o/g5NzoJ6jbNyDLcME9SEa/mmpOepLMYrs6lFfdp9kl5hR50cP/dqZXRkcxe
	zXk/6LeuEn8KjuhuKHW
X-Received: by 2002:a05:693c:310b:b0:2dd:649d:751d with SMTP id 5a478bee46e88-2e46538dc17mr18627051eec.8.1777222448989;
        Sun, 26 Apr 2026 09:54:08 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a80c7sm50404803eec.10.2026.04.26.09.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 09:54:08 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Martin Varghese <martin.varghese@nokia.com>,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()
Date: Sun, 26 Apr 2026 09:53:51 -0700
Message-ID: <20260426165350.1663137-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B5EAA46AA4D
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281176-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,nokia.com,vger.kernel.org,asu.edu,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.554];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Spam: Yes

bareudp_fill_metadata_dst() passes bareudp->sock to
udp_tunnel6_dst_lookup() in the IPv6 path without a NULL check.
The socket is only created in bareudp_open() and NULLed in
bareudp_stop(), so calling this function while the device is down
triggers a NULL dereference via sock->sk.

 BUG: kernel NULL pointer dereference, address: 0000000000000018
 RIP: 0010:udp_tunnel6_dst_lookup (net/ipv6/ip6_udp_tunnel.c:160)
 Call Trace:
  <TASK>
  bareudp_fill_metadata_dst (drivers/net/bareudp.c:532)
  do_execute_actions (net/openvswitch/actions.c:901)
  ovs_execute_actions (net/openvswitch/actions.c:1589)
  ovs_packet_cmd_execute (net/openvswitch/datapath.c:700)
  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
  genl_rcv_msg (net/netlink/genetlink.c:1209)
  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
  </TASK>

Add a NULL check returning -ESHUTDOWN, consistent with the xmit paths
in the same driver.

Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/bareudp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 0df3208783ad..da5866ba0699 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -529,6 +529,9 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		struct in6_addr saddr;
 		struct socket *sock = rcu_dereference(bareudp->sock);
 
+		if (!sock)
+			return -ESHUTDOWN;
+
 		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock,
 					     0, &saddr, &info->key,
 					     sport, bareudp->port, info->key.tos,
-- 
2.43.0


