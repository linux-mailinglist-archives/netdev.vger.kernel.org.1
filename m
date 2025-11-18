Return-Path: <netdev+bounces-239284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF3FC66A1B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A2AA4E60E2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEF021ABA2;
	Tue, 18 Nov 2025 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="HA22x6VC"
X-Original-To: netdev@vger.kernel.org
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B2E2E645
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763424997; cv=none; b=CLRCx/TozquoQ1fwgx+U7RtqACU+yVlll13fmFhH9IVUfQ/6zXhoz4rfyqUSd15/eVMSmebyGRa57MhSnAhsg0woWAQhCN8IKz30NClnugvduY9lOoPbbMrhMoOGkiQFXGnujsplLTzhpBV6/6H+GK8Ihkfwq692n/4C4oJsCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763424997; c=relaxed/simple;
	bh=DDGuu2D8ExkKnAg4J88nsp/CSylvEn10dWjv/5AdhFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwAexse5On6vDJ0qcUf7uqckB6FFjhOo3e4WNrXGsH3oCTMEQAHWpcsfymjiRLs/ZqlcQpQKeT899t8JSNi3C/QP8Qxbt0ZwoAeP7TJ5z+KwbmIH4VZUVyJDeMtW7im6w8VsuEozGf+JucbIalYJFiuEgQQLOhnNZOKKtmKvCI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=HA22x6VC; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 8AF1860BB2
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 01:16:24 +0100 (CET)
Received: (qmail 29016 invoked by uid 988); 18 Nov 2025 00:16:24 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Tue, 18 Nov 2025 01:16:22 +0100
From: David Bauer <mail@david-bauer.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] l2tp: reset skb control buffer on xmit
Date: Tue, 18 Nov 2025 01:16:18 +0100
Message-ID: <20251118001619.242107-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-3) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=DDGuu2D8ExkKnAg4J88nsp/CSylvEn10dWjv/5AdhFU=;
	b=HA22x6VCTJezMbZQzJy4zNS+yUrN+WpC+/rtViSerliwv82YC8CZVAgyeGuTcEyziBdCY3B+5q
	jvuRpXj+jn0K7WlHOYfTyTfGIPBq+jj4zV+kTE4LeUoESzNIqo7i2cL/u1oemzvfsX/LbjebJxMT
	VLr6wuS7Al2Ml/oiff72TWG2CJqdr+gCVmtmObJwZk8rmyzQI8UUt1rDL3oGVB5tLp2+pD2JqTd+
	1dNXW2q2Lwwj+CzjCUVLcWelqhb+27kKBKb2s5luE7Hm0vGj52jIoD6qavbLfuxKT6ozxfeRexxI
	RiGp0mPJ2g83GElSyYVOI1TjbYcu1Hppv23EA3q/FhEwQSdS9Y1Qx1fIDA0/TKyo3KMBVKlvUumk
	v6JAwp4MdLnoE5Q4KUZ2CbUNThI4Q8E0RIR5LtwrCMKorHBOIUMUjgZH3XqXznCmPj1CrcS5S0e/
	n8IE7zaFL4wJWxRJ3nlEzBkrqNmg1MLugBnI7CUYB+H1ap5n0FwqfIhGP6Pcbwv35R60PDzVrZvc
	b0KQnVZrlBDzEFySaTSyfEtVWX8XgMPijHzeVIiOEXmugot+exAjA7j7YiCFpcOio0TFR1DFpgFL
	tFtoWf45CLv22cv+VN+dBlagw31x13EnM5uhkPIqqn2l4QwTwdDV0Epg0waDJMwnJ71lDDCnbVYx
	M=

The L2TP stack did not reset the skb control buffer before sending the
encapsulated package.

In a setup with an ath10k radio and batman-adv over an L2TP tunnel
massive fragmentations happen sporadically if the L2TP tunnel is
established over IPv4.

L2TP might reset some of the fields in the IP control buffer, but L2TP
assumes the type of the control buffer to be of an IPv4 packet.

In case the L2TP interface is used as a batadv hardif or the packet is
an IPv6 packet, this assumption breaks.

Clear the entire control buffer to avoid such mishaps altogether.

Fixes: f77ae9390438 ("[PPPOL2TP]: Reset meta-data in xmit function")
Signed-off-by: David Bauer <mail@david-bauer.net>
---
 net/l2tp/l2tp_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 369a2f2e459cd..0710281dd95aa 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1246,9 +1246,9 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 	else
 		l2tp_build_l2tpv3_header(session, __skb_push(skb, session->hdr_len));
 
-	/* Reset skb netfilter state */
-	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
-	IPCB(skb)->flags &= ~(IPSKB_XFRM_TUNNEL_SIZE | IPSKB_XFRM_TRANSFORMED | IPSKB_REROUTED);
+	/* Reset control buffer */
+	memset(skb->cb, 0, sizeof(skb->cb));
+
 	nf_reset_ct(skb);
 
 	/* L2TP uses its own lockdep subclass to avoid lockdep splats caused by
-- 
2.51.0


