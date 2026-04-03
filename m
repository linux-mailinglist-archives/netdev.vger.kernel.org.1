Return-Path: <netdev+bounces-274874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAFZBBNDz2k3ugYAu9opvQ
	(envelope-from <netdev+bounces-274874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:33:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B96390E93
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5813B3022C27
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 04:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88127874F;
	Fri,  3 Apr 2026 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rt9f8Lqd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD3352F95
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 04:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190767; cv=none; b=Z2Wdsf+P1/f4+MYs76hN7QAItl4RDyec8Z0ysNY4r9GMzTaXBvoMk1gXixoL/fUPyxrVM0RbY5Eitp4Xoz5lXZWx3onRjFP0J0mr5MogsD9wTpKSjZvcssdnrAluuo+OYYQJehBtaonvLeUi8/uucTGE/zrmcTNqTT8CJ8cWMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190767; c=relaxed/simple;
	bh=7t8YgnyR9W1x80fytJe5A4Qgb3Z4TK4BcNG/Qr0b/ug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nf7Bf3ZLamSLPMtu8PsmBFNCN4XrtmVucteMy4XtNwgM2hFikdR9DkVnAAWF4BYXSsiRTv8edsi3AD5BZzeMpwT9WWLOcwFfDabcVN1DMlZj8YHbjSXn0qBnDXkQG0iIbfcS7jKsyDoXxPyzIC2BDuWOSRrjdMqWsAGtuQ7znjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rt9f8Lqd; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-89fd9daa423so36976036d6.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 21:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775190766; x=1775795566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyChNLhHNzBWQzz+Nn5lOUZb4LqwwmvjPeUEbxpo934=;
        b=rt9f8LqdIW4+exzrSBt6SJYa9wiR3eyXX6tHHK9maHiCOOG7aUYnERYQiGaBvcHIci
         eDXvHxwAYtUpLe3AX/cIHWMiMlvD2T1SC7YmtrD/1SPGyslQbaiIhuxGsSAEFW/+qJHo
         9p+wwoST88760rspRG/l8Tru9lAn+GefAd3C2TPzLABSBj8iB+E/y38oRvyDq20M+K8b
         xRGZM7w3cVJ/zi8c/i68ZRmMS90gGMvqOIiA/faCCGrGfdGhcWa2Dw11qzbnWx/rwwX5
         meP4vnLAbkPscuSFMg57iHuGncZdPuov5QsiIpVQH2CH4yjdr5rvbeEabsfCSX/GarD7
         jtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190766; x=1775795566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyChNLhHNzBWQzz+Nn5lOUZb4LqwwmvjPeUEbxpo934=;
        b=OiH5+XFzpRjvBPD2Uvg6uZ+OfjXqTD77mg94s1cLPC1mOHN4z2Wh9nMuluQTcbJRR4
         r5IAUOhYkPKJ/GyZ90BqeSGpxV6URhCes+KvQZTjltlL5HyAY59JmP3FqxgvrZMQnRKd
         0kBbR6QfOUL8mZ4dLkyIIxxOjWaKxzhCeNTnvwUWONKqQyNZOlv4Fwav+5TjN7HEr1l/
         N+Mu6zldGk3HvIdXT2wszlfiNDV2YSluLOcHRlvpO7vgd9duGZ4jwmKt3KdQH8LOv7eW
         xkOSQ4ESlBTaSMkkMFkactCmYd64rjezYv6eA5qlLCxx4fTiBsXCWeTFh3jd3UeUD00s
         c4ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3NtwVayj71UKVsKik9nO14jdz3As5awkUXDIsONcRQmmNwbH19wbY9PqWWLxE8tHR2VlVMOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPVgqQsZogp1qCkhXxC7afx/v/2sKomD1xN6CHYLxYjj1KmoUb
	tZfNrtYfLt01lFlYw+nlR0EoTcLgr9qbXmlac3B0LLemlcCslRp9cimcdkMTLxv26/aAHjPhCxT
	TU3DG+O/dhqO1Jg==
X-Received: from qvag28.prod.google.com ([2002:a0c:f09c:0:b0:89c:eb10:3e83])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4a01:b0:89c:cfcc:2f31 with SMTP id 6a1803df08f44-8a703c28cfdmr28573896d6.32.1775190765634;
 Thu, 02 Apr 2026 21:32:45 -0700 (PDT)
Date: Fri,  3 Apr 2026 04:32:32 +0000
In-Reply-To: <20260403043237.3909226-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403043237.3909226-5-edumazet@google.com>
Subject: [PATCH net-next 4/9] dpaa2-eth: use tso_features_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Ioana Ciornei <ioana.ciornei@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com,nxp.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274874-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: A8B96390E93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We must fallback to GSO if a TSO packet has too big headers,
or risk corruptions.

Fixes: 3dc709e0cd47 ("dpaa2-eth: add support for software TSO")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 9335703768a9b66ca771c7f4a710cc6eb714bc61..47a25e0fa1d04d96bdffe27ce5beea0b3104a30a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1270,6 +1270,7 @@ static int dpaa2_eth_build_gso_fd(struct dpaa2_eth_priv *priv,
 
 	/* Initialize the TSO handler, and prepare the first payload */
 	hdr_len = tso_start(skb, &tso);
+	DEBUG_NET_WARN_ON_ONCE(hdr_len > TSO_HEADER_SIZE);
 	*total_fds_len = 0;
 
 	total_len = skb->len - hdr_len;
@@ -3029,6 +3030,7 @@ static int dpaa2_eth_setup_tc(struct net_device *net_dev,
 
 static const struct net_device_ops dpaa2_eth_ops = {
 	.ndo_open = dpaa2_eth_open,
+	.ndo_features_check = tso_features_check,
 	.ndo_start_xmit = dpaa2_eth_tx,
 	.ndo_stop = dpaa2_eth_stop,
 	.ndo_set_mac_address = dpaa2_eth_set_addr,
-- 
2.53.0.1213.gd9a14994de-goog


