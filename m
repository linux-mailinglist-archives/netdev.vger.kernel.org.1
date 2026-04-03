Return-Path: <netdev+bounces-274876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJslGStDz2k3ugYAu9opvQ
	(envelope-from <netdev+bounces-274876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:33:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF3390EAA
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2191A306DCF5
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 04:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED2A34FF7D;
	Fri,  3 Apr 2026 04:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wluyy41+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA7A34750E
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 04:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190771; cv=none; b=cJwiOXTULKdPg3uW/Gas+n7XOK+/hFfh85fZh97zthF2Pf/bUmc4QLIjli0drzLhFexGIjCZ3kcevURNkZphjBhwJ66LYcjBTd01MnkcEFm0eT1/eMyeuiBT3u/oX2ApgOqZo9dtNe48Z2jpZaY+xX3a3nNXyCIs5F2UcxuMhKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190771; c=relaxed/simple;
	bh=40wLHY8kCi8+mK8MG/JBbyKMd73Avi8ucAzNsbD66rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QADjkmFNu2cUKw5+S96n0rN/BiyZJ1A78Nb2MOQdRVxgH45Mc7aQSImwc/Ch0OQu9U4QRtjoVSwOSEwDHQQY5bcTaO5cKHWT+XFyum80Kk+lBa4tFhk9rfGsBbBFWt1l9UHsLsRx6itfNoAr8vkNUbTe1tkT1hOMiq2ISEDB5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wluyy41+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7900fc7033bso22107717b3.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 21:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775190769; x=1775795569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqUu9fe81iAGMv3/RSbZ1CkNeYpfL6sUH7YUkpgXI6A=;
        b=wluyy41+HWCMTZcbgJVqFmBnLDzESxU9EcXuzePT3cIOMM3RaIN47q91StvrP1Opvv
         gDwt1izlc2/W/nYLBEcZ6/pundpYovLBI4Ncd0AvHgBOlHQzwk1BXUOqYZRBZgl1lgwp
         sDtBANsWkUavHUvTVPWtPRKZB3jccUOKrbAuAwSrnkdQ6zKBoGX7DLAjHjJGCnO3c8Kt
         x5eEw4Zr21RsFaiep2l8Nr+dNDNdwajwybvNheUS6bJYuqub4vsEGc8GGH29eYM5Jhtt
         rorih3GEkWPuxVDkDDPwF+GeHERwmOMXaI2VvYuYG7z5fYWCKx9gCiAWazD/ksC+vEwb
         CtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190769; x=1775795569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqUu9fe81iAGMv3/RSbZ1CkNeYpfL6sUH7YUkpgXI6A=;
        b=r3regHEurkkhODIwTQF7xaOTiFqAUQB/EhBeG+xYb8cFCPDmliYGAHADuFzOFC2GQm
         0S1zAMksg35XHDCLbaBp2gnPJOajsY92t75UnXw/CrxdfJ6t8MAxT6Ncw1uA44g3J2sA
         Cu+M44TWTehoFCiii4xZX6A+hsf0hj3zUyt9r0Vc0n258A8pHTTyREPjYJ0UwyxbudDX
         1XF9Id/rdTCLlMpknIoOz3UhYoEp0SAtjPnqwLWrIISU1/Rxu90fLDDq6N/5g1osz6df
         bfT8iIg0KrivEFT2HOVuRVuqTcOaxemBNMTmnIoQjUwsk/dK4hez6PspWJeBpWeui4C3
         GKIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsB2Aih3ALpO8C1CiofM2sksock6ISaYsG1K+QKjAwG4Ri3us8Dcrvbbt6GQUEJLFzEz7Ys4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+oJ/np/J/ImX6Q1fpjlgBH839Pb1F9QOGMav9I90K23DmPKbJ
	/9HzyTn2FtJcTgyKLUcRudE+6NJBydKskNMqvs/6HWvBORNkgLjlS26lRQz4GxJIOTQJGviWs5a
	FrlSu56x8Ap08/g==
X-Received: from ywbmq8.prod.google.com ([2002:a05:690c:5888:b0:79a:8d97:7f6a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:3509:b0:798:711f:a0df with SMTP id 00721157ae682-7a4e0e71ad9mr13801457b3.13.1775190769233;
 Thu, 02 Apr 2026 21:32:49 -0700 (PDT)
Date: Fri,  3 Apr 2026 04:32:34 +0000
In-Reply-To: <20260403043237.3909226-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403043237.3909226-7-edumazet@google.com>
Subject: [PATCH net-next 6/9] net: fec: use tso_features_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Nimrod Andy <B38611@freescale.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274876-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com,freescale.com,nxp.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,freescale.com:email]
X-Rspamd-Queue-Id: DBCF3390EAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We must fallback to GSO if a TSO packet has too big headers,
or risk corruptions.

Fixes: 79f339125ea3 ("net: fec: Add software TSO support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Nimrod Andy <B38611@freescale.com>
Cc: Wei Fang <wei.fang@nxp.com>
Cc: Frank Li <frank.li@nxp.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f89aa94ce0202d5f28f37362ce70e0943aa14025..846fdd51cf8b6c5ef9fffcd5688ad54cb8def919 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -860,6 +860,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 
 	/* Initialize the TSO handler, and prepare the first payload */
 	hdr_len = tso_start(skb, &tso);
+	DEBUG_NET_WARN_ON_ONCE(hdr_len > TSO_HEADER_SIZE);
 
 	total_len = skb->len - hdr_len;
 	while (total_len > 0) {
@@ -4887,6 +4888,7 @@ static int fec_change_mtu(struct net_device *ndev, int new_mtu)
 static const struct net_device_ops fec_netdev_ops = {
 	.ndo_open		= fec_enet_open,
 	.ndo_stop		= fec_enet_close,
+	.ndo_features_check	= tso_features_check,
 	.ndo_start_xmit		= fec_enet_start_xmit,
 	.ndo_select_queue       = fec_enet_select_queue,
 	.ndo_set_rx_mode	= set_multicast_list,
-- 
2.53.0.1213.gd9a14994de-goog


