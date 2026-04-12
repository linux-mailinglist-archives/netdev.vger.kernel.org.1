Return-Path: <netdev+bounces-277865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PWeC0fh22ngIAkAu9opvQ
	(envelope-from <netdev+bounces-277865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:15:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A943E55B9
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C82093002330
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD6730BF52;
	Sun, 12 Apr 2026 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk7sm6X4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADB2236F0
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017731; cv=none; b=t42qorlYE6fNZe2E8MISbfD3JE4sPPmnRqKZ/KeQQYKlSa1QfG0rI64c4RbIW3kCHCbDXe57uyJpba1VvMITgKYvLLRxGSfPaJHc5Jy1Bt4qDJWUThf7X4duatRUPv1PdiGM2u6FftaxDNUoagxNNysa5gZEAG2we/qQtGE50Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017731; c=relaxed/simple;
	bh=Byj/sqX+2JSsT8hmzhfEaSvDM99QoUAiN1oxmcwdnig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAOvI68mv0DNv7f/7Xe+qyPBNkVWxZL2MH/Y+t3N4OT7AO+vD5u0LoJriF3vZgneX2frm48DH2y3cmwol11Wg6aDk89Y+Mk2Wy4fx3lAgA2Va/+kN+dL8yMQ7qZe8PRsKgoa3uVTpkaD87IG7ox5K3sZKnfBAhaCZdvhCxV4dks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk7sm6X4; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb5c9ba82bso562337285a.2
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776017728; x=1776622528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gQyGEfo3+mfnnv1YXniq0e4ov23sKEA7WrqzMWQ1rgs=;
        b=jk7sm6X40OBOazy6RU6XLXFhC2LGNlMqOGb5LbMVnIQF1nyXXA0v4zix092zPAwM28
         3WWHA3infe5ZzdZBlOSZVHLB7jy4cptd8ypMr+cfNuwZn5q5ecNuceb0IFl+OnpyFRYS
         xcuYaMz2EuboD2ZD+C3pxO6Dr2SWC2L/p7nhi+NIcJGUBRed32EhSjW4n/dmrr5vogUd
         k/ix0Oh5TP41Amp2UqPee3WWz+RAfT8fOjD07NGDMxbSXV1gw5m7DaLQVKheO0yOEy3c
         G121U+GFuC+IjsobgIo5mxlz40du9unjLn6Sov0yOOI9hnZDzIZ5ZVkZatAdHTKxlSyo
         g2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776017728; x=1776622528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQyGEfo3+mfnnv1YXniq0e4ov23sKEA7WrqzMWQ1rgs=;
        b=fHdTdCg1w47la4LZh4BrXSWD/XAqwr+2clvMLFyay/RuSYIYgUc0EqRRbOhatBTnCj
         TFq//PGStEG9XPnu3TB04wNvcLzbwmyjhn+14mfoX5nZ899uZrxAudVUK5uQBJ2uAS8L
         HwrszNxa5K9b3CD64PfVcMarOnrFemdy+MV6sZC5Lop8cXgf0DIXoI0O1FbTllJMMeRF
         qf160G+bqnc9nk2rqnYL/HSCYRKoF8fdToiIrLvKUZ7ndR7EWy9S23K/rB5LXEkX//7K
         /J1Ths/ZD0W7aNo3oNGi0LzcF/CG6LwqJBC1bPvimStM5cpJTlLLG1qHuP3xzEafkhfx
         vMUQ==
X-Gm-Message-State: AOJu0YxFQipJZexLmR1wZyIr+zIBPU6lun8lrrJG70m52/dCFtLe8182
	fPdDGZ0ibj2zMWYL398Y8Oa3+EDx60/xfSlxLa0mXk2857venhcMmq8blHxr75/O
X-Gm-Gg: AeBDieuT1Le/Ug/BHL6G0IiT6mR+33sdQA42vHPnpFzELepMLRVjHah9/VO7jFuiFVK
	VhuSgPPR/syms/eSgbBCea+AzugPi3HMbtzd8blQLgoPyRxV7gtP/y8ZWvAgd/cXtk9DwcMWJ7e
	t42Ei2pqixv04kFrBosMgljYiGylsudrI9xu1fvBA8XQG8K5VRmUTpkf9gVuyXASsoJnzv/WNg1
	WPvyRCQEYPAM6uk+LjPjCf+50lH83LDaN9k6zs7VViRi0YBNct9Mw/kO/GxReFxrJIvMjybkh+A
	Teirl83ymXjLlpqjK1Ums1h+Ns/0+0NT4V0Ma1qAh+zC78/3Mo92akVbs07rumSH5hwDrwKHstx
	cS9LRTnh6p1wjoldSx9ybqn5uJe21xR2GeRZ3aDL7rfMWc910LumhPVPg8ZOzvHS/78cIxtRpMk
	rimV9vVC+a3hU8i07cCNH+qtdGAmGbZz1G+IKN4hhDa/fTEMJbsa421K6evL97g02xznz3CSC4T
	iFohjoXxsPeCrCekYnpoPd1glk+h9iqG7sMT7v5zm4XdD1RzImGpwkjxX/1Am4K
X-Received: by 2002:a05:620a:4625:b0:8d0:a4b:e427 with SMTP id af79cd13be357-8ddcfcab061mr1587842785a.57.1776017728508;
        Sun, 12 Apr 2026 11:15:28 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8de94216e90sm530888685a.1.2026.04.12.11.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 11:15:27 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] sctp: disable BH before calling udp_tunnel_xmit_skb()
Date: Sun, 12 Apr 2026 14:15:27 -0400
Message-ID: <c874a8548221dcd56ff03c65ba75a74e6cf99119.1776017727.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277865-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C2A943E55B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

udp_tunnel_xmit_skb() / udp_tunnel6_xmit_skb() are expected to run with
BH disabled.  After commit 6f1a9140ecda ("add xmit recursion limit to
tunnel xmit functions"), on the path:

  udp(6)_tunnel_xmit_skb() -> ip(6)tunnel_xmit()

dev_xmit_recursion_inc()/dec() must stay balanced on the same CPU.

Without local_bh_disable(), the context may move between CPUs, which can
break the inc/dec pairing. This may lead to incorrect recursion level
detection and cause packets to be dropped in ip(6)_tunnel_xmit() or
__dev_queue_xmit().

Fix it by disabling BH around both IPv4 and IPv6 SCTP UDP xmit paths.

In my testing, after enabling the SCTP over UDP:

  # ip net exec ha sysctl -w net.sctp.udp_port=9899
  # ip net exec ha sysctl -w net.sctp.encap_port=9899
  # ip net exec hb sysctl -w net.sctp.udp_port=9899
  # ip net exec hb sysctl -w net.sctp.encap_port=9899

  # ip net exec ha iperf3 -s

- without this patch:

  # ip net exec hb iperf3 -c 192.168.0.1 --sctp
  [  5]   0.00-10.00  sec  37.2 MBytes  31.2 Mbits/sec  sender
  [  5]   0.00-10.00  sec  37.1 MBytes  31.1 Mbits/sec  receiver

- with this patch:

  # ip net exec hb iperf3 -c 192.168.0.1 --sctp
  [  5]   0.00-10.00  sec  3.14 GBytes  2.69 Gbits/sec  sender
  [  5]   0.00-10.00  sec  3.14 GBytes  2.69 Gbits/sec  receiver

Fixes: 6f1a9140ecda ("add xmit recursion limit to tunnel xmit functions")
Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/ipv6.c     | 2 ++
 net/sctp/protocol.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 53a5c027f8e3..cd15b695607e 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -261,9 +261,11 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
+	local_bh_disable();
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
+	local_bh_enable();
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 828a59b8e7bf..5800e7ee7ea0 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1070,10 +1070,12 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
+	local_bh_disable();
 	udp_tunnel_xmit_skb(dst_rtable(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
+	local_bh_enable();
 	return 0;
 }
 
-- 
2.47.1


