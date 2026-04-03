Return-Path: <netdev+bounces-274877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFEFFSNDz2k3ugYAu9opvQ
	(envelope-from <netdev+bounces-274877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:33:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0608390EA3
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7B1F3045195
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 04:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F3633EB17;
	Fri,  3 Apr 2026 04:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLaAgLep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495B34C990
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 04:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190773; cv=none; b=uTxtV6QSxX++GPnk37+IphfbdA+YkDfAfzRdkwrFCUEV5/EbReLHKP2dUjJsYrnRuGxtw2pksnNWmkCKuQV/+nW3UMEiG5k8dFoCljRMWnU2haH6e+ZdsQksafhaHMkoagDgNXDUcfFbPcJYUPY6sXvaZLkCMDkWMa4sWd2GWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190773; c=relaxed/simple;
	bh=CTVz4t2eUQZdZQzqBWJqNGl8E5TOLzNVET/5NQG3LuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NT45XRDwRktLawTlXWf1YlccvVtc/vNO1to7INn9rsbAoeb6Glsd7pVBnoDV07Q2vzbIb/p97OCFPTeo7ijt6MMEH/cRnGXcJQch9grN7xk+TbmT1ki515Jb6wN6mdVuks+0F2DZnj0HrLFKU7GIOlABap+8fSjPwRiGxMYlEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLaAgLep; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5093787e2fdso62837671cf.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 21:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775190771; x=1775795571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKeVsEDHNqlDKIi4CN0jdwBSoPxW/POp77m7hYdQDgY=;
        b=KLaAgLepTXOVX0jo5H7ghj25jXXwenNRfPwthdm8JTOGclqo4zZvjRrr+OwHejhNwJ
         kTP29Q9cwXIhapaQlR0SnR1ebNN5BUnBRFcoxr0vaVn1uGhpR00L9SIYD0ke4qUGuyIA
         0b6psJO4vAPHwxEvEDyAfVTX2ccmfTER+YOv4aRZ+dkxje7W3zRatZK3EIu6TLmGIWYU
         l+NPRPX7Upw+2mDXtH9Euty+swJc+mKIP/U5ROp1pHTXH7yFjgOa1y9x1HwqV4ql1Y7l
         lWeFFODk3VXIm3WFDMSssc9YIQSHhHvyc5BD4TX65g7d+xMixruGFa6HrH/1VMFJzHQh
         0Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190771; x=1775795571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKeVsEDHNqlDKIi4CN0jdwBSoPxW/POp77m7hYdQDgY=;
        b=Hf/TVToo/uejiKEDGZoIfYLgaBbTMcsdYo8PcB/GJR1qhLdhU11yzR7s7tz7EjKfxv
         7LvcCvEsi6/ahL2VKMNBNYLQI3k6h27090idXpdUG1YDHc1DpkUNvwL7oRSnU9c3XTKO
         Y9POl3NG6aegKTKY6QuaHvaeVo40MuxHCejzykFyAarcBh9nVXikP5ZzGcCjEuk/Xu5X
         VCQ5mv9e70/5ZEaQ72Ac5XnTibckMqepMXoDOrvMV30INIhrwTQs46uGIQ9cbmCM0bv8
         APZhOHh3rewdDsoItIbeINmQaN0qWNzI5Be8ugvNA9DCSI7e840TUR124NTpVJaglX6Z
         OpJg==
X-Forwarded-Encrypted: i=1; AJvYcCUgVxbCBOS9Ul9+sdsVDeKxle9N9Tbg9xVxCr5eS7YMNMza2V0zGFxP1gt7jUbjYACPduPw/Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8PAt4Q6L33GgbtCi1r2D2zUQTi2t37pv8cVNNsv+lg5zq8Mj
	xow2OII66S34w1E03k1WJUelvZmon2cY9ggimkvgpT7KBvy0dq2CZsMb0KCUhPhKvhEXXOeQRKH
	zdtQE1vOFv91V6A==
X-Received: from qtuu17-n1.prod.google.com ([2002:a05:622a:aa51:10b0:50b:c67c:e373])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:53:b0:50d:3a3d:425 with SMTP id d75a77b69052e-50d62a912c5mr29177141cf.50.1775190771115;
 Thu, 02 Apr 2026 21:32:51 -0700 (PDT)
Date: Fri,  3 Apr 2026 04:32:35 +0000
In-Reply-To: <20260403043237.3909226-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403043237.3909226-8-edumazet@google.com>
Subject: [PATCH net-next 7/9] net: mv643xx_eth: use tso_features_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com,free-electrons.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274877-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,free-electrons.com:email]
X-Rspamd-Queue-Id: F0608390EA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We must fallback to GSO if a TSO packet has too big headers,
or risk corruptions.

Fixes: 3ae8f4e0b98b ("net: mv643xx_eth: Implement software TSO")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index f9055b3d6fb102ebc695dce9c6c8321889a78dfa..95781e1f42dd69404ca60f0cb383bd783f7e5322 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -835,6 +835,7 @@ static int txq_submit_tso(struct tx_queue *txq, struct sk_buff *skb,
 
 	/* Initialize the TSO handler, and prepare the first payload */
 	hdr_len = tso_start(skb, &tso);
+	DEBUG_NET_WARN_ON_ONCE(hdr_len > TSO_HEADER_SIZE);
 
 	total_len = skb->len - hdr_len;
 	while (total_len > 0) {
@@ -3066,6 +3067,7 @@ static void init_pscr(struct mv643xx_eth_private *mp, int speed, int duplex)
 static const struct net_device_ops mv643xx_eth_netdev_ops = {
 	.ndo_open		= mv643xx_eth_open,
 	.ndo_stop		= mv643xx_eth_stop,
+	.ndo_features_check	= tso_features_check,
 	.ndo_start_xmit		= mv643xx_eth_xmit,
 	.ndo_set_rx_mode	= mv643xx_eth_set_rx_mode,
 	.ndo_set_mac_address	= mv643xx_eth_set_mac_address,
-- 
2.53.0.1213.gd9a14994de-goog


