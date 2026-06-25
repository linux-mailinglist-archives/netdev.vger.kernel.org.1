Return-Path: <netdev+bounces-301884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z4rzKRTdPGoftggAu9opvQ
	(envelope-from <netdev+bounces-301884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:47:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0429E6C37A8
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:47:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g7j9ku+T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301884-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301884-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9CF830922A8
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CF381B15;
	Thu, 25 Jun 2026 07:44:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6B3812EB
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:44:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373444; cv=none; b=BDSgxjlQOnG+UWnhmp8R0wLvEatEEwSxzsc5bmBPeE+JDX+Hr+KVKY/CDhKoKnd4Uty7rozr4hYCQLdpKJPG5UeEMwcBxiLd3es/NJDwDAL44qpaKCRjBFE8ArxZ4A/5voMvf9nrSzF2McS1tOPtsZYSi55/TZltTBivbfdAUAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373444; c=relaxed/simple;
	bh=pbfrB0q1Kb3XDgOMuvXd30ml4zNgLLtygsbeeP5M8c8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOsSTxjPugJpfqAIm1xTb5yxE+qYcO1K0CZl8DzeoctV/yKAkw2NicM/ikCDFdoysJl503phE38pdvpZucbnkgWBIvd1nRTYDAMIRvQIy+LjIxONHj5zAGATolVgQaP6/FNDo6sFWZVt3ZTHsS/rtqufaNWc7ovYMyAQrzPIkI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7j9ku+T; arc=none smtp.client-ip=209.85.208.173
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-396771119c4so17954991fa.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782373440; x=1782978240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4refMHFUpBzje/uZRNbCENQcQd01tpQ4O+oo7qmguQQ=;
        b=g7j9ku+TUORKJsOJTAVd1inokKmhas/mZnP3fYLL2KKshC6GJUjJUnDYoM39sFkYAC
         kE1DdwlRM178SxNn7L4TsoPeshqM9GGpo5J95P3ty7tStklY3O0IEWcuYLfYt5Y5XyZv
         Dh677HxeNux+X02+yrikRJly8LXlGi/io0TFEsoCL953PvuNcbZ1ijtVxxw0dJiyvpsv
         57q23ZxWuZ+1rLbcsONRhhPqT6OkFNAYN1jCUtKNbDATnQ8bgLqCMDFUQyp/jZd5BJWy
         mpm4WmgZxvsjd42k5nxgbPJuXBv8e4Rj4H9arQYGzzSf0KjlL/CdrZQ4t+i1wscgdwIk
         MLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782373440; x=1782978240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4refMHFUpBzje/uZRNbCENQcQd01tpQ4O+oo7qmguQQ=;
        b=T/QlH+2WO08/ogkZ/3WwMW4fbKSbTBLtIWeTHXNL+WGKFz0QG2ewXgSJonUJQW0vlX
         dByoHcEctaNPC+1+Qa85nsJ0g6eWuZoOqbZLv08AhUtwwEzbrd8o+62OE5gJ7WOL14F6
         Ofky7F00sFwkVtNGtw21WyIxmL16/Ad5tymP5+eJP/J4TnW8yYsMKtQ7/XBoEqNCDyoK
         WhRcbM6Rxj29xnaoxu+yICE/g9uCF/rxDRUj1MymlCpFiT0zuLhOa2BXtVBRAsWTgD7c
         eMaz8uJZgH0/d8oC4QvGpwNzIA6mX9hhooMcWTdwgtGP++UDv+qpggxPaP6g5R+8p58P
         1BVg==
X-Forwarded-Encrypted: i=1; AHgh+RpJwSfntfvk2WE/dW91U2GBWrXIzcEUNgY5mkjdBLuGiyboomu3Z3/yNl2P79AaUEWaGU6E1n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXU/c8w1/I/SIz53t5JbZyvvKvlTp//IQDc8lHqt1siL3s4YVj
	xxt7JoCpX8ep0oxIW6s8PQxDUvzrGSCpmHeJZzKqCqWf6rEuOuId99AI
X-Gm-Gg: AfdE7clvZzK939piCHjxVVPvElx+d8NzkBXBqWZE7pWF3PXW/QsPF2nUKSFjb/Hi2Lf
	P6Zs5C96Umw12dgZo/r8WF1BLHMVAKODTc2aCeCtloCsVEUtDNTz8CshFpqoW+uX0sAJaLctM44
	3Ik0I5Rx/esU/oq96acqRBrlbxK+A8wcdyZJVag5XaNHix1aBaqU96DeS0I3aEDOiX3P0BbQeSZ
	GtW45RKkE2uMI4iG1xoaZ/me/OSWVSoE/LCJQveJeuHGMp/siqZlP7foQ1Prw2v5//5fYntLHrR
	6hEaPK48fUr3NyE2+p2ADDPLzBngZuXaFBtzlsyfoPlf/FNGCj+HoK2UZsbijSFZl+E3vcZcLSe
	OyY0JSvFS8TjkpDVN1jSPdmWwKpR5dcTp12qXxXznfdAX/XfZbhdLU7TOTQ8RI08CAHZwcZfbXj
	VmTOpj4ocY8uyjA9zcaCd0WGLd7Jzm
X-Received: by 2002:a05:6512:6407:b0:5ae:9c54:8037 with SMTP id 2adb3069b0e04-5aea1f48d55mr410087e87.17.1782373440062;
        Thu, 25 Jun 2026 00:44:00 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999b156a63sm39705531fa.25.2026.06.25.00.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 00:43:59 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bestswngs@gmail.com,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Martyniuk <alexevgmart@gmail.com>
Subject: [PATCH 6.18] sctp: disable BH before calling udp_tunnel_xmit_skb()
Date: Thu, 25 Jun 2026 10:43:46 +0300
Message-ID: <20260625074348.90149-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301884-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bestswngs@gmail.com,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alexevgmart@gmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0429E6C37A8

From: Xin Long <lucien.xin@gmail.com>

commit 2cd7e6971fc2787408ceef17906ea152791448cf upstream.

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

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Link: https://patch.msgid.link/c874a8548221dcd56ff03c65ba75a74e6cf99119.1776017727.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 net/sctp/ipv6.c     | 2 ++
 net/sctp/protocol.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index d725b2158758..7434309785cc 100644
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
index 9dbc24af749b..6ce58fc95ef5 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1102,10 +1102,12 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
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
2.43.0


