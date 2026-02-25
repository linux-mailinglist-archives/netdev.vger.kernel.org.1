Return-Path: <netdev+bounces-261058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIltJ28+n2lPZgQAu9opvQ
	(envelope-from <netdev+bounces-261058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:24:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0AF19C39D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31B95303DF50
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A583D1CD8;
	Wed, 25 Feb 2026 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxvMjtP2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F12EE617
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043835; cv=none; b=dm8geW1mkm5cJ9ceca/MAIYdkExeyTU3XJMeay7rIkt+mguEALEH9L+2PHQpuwbAcPo/1J2XzjEPVsmqnV00n8MfCuV1BZpfZbrV1lSmBdOqeCi+bnBcfFK3SODsFyruly9Ge3/eWk8Tw+0B5m+DrASQUjZw3UdHIcviE6sipls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043835; c=relaxed/simple;
	bh=LLwOPS1L8RnAB7NK+B/I+dxxQWLv04xJfccMGdGZtME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mufkoMoJ0bW4hsgtglN3baQZ+HFKvbKZeYpyDDoII37Q5dd4TqOc2C2pFcaKpSzTfHKgT8Dt8c0PVciQYAtLtzE8XiKvP/Mk0en2Aw+Wn6XKU9v3JKkoXWusygOr4BsNe9hFuhmP1vrE0vL08Vhi9K7tzW75wD7bPSaDJSh5lBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxvMjtP2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c6e1dab2235so4239217a12.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772043834; x=1772648634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3tIPlETo+nW7/9bKJG0AVKHGPCMoVCLC4Z+gTp5I97A=;
        b=UxvMjtP2TZkMDzVtX9nGv+9GM2cynt8F8VUxqsVcO4TS93xJc4O08BXOdx4Ji/pLDx
         BdHGMytvVKabFCGq1/rOImAyfYMC4c31ytokufBnb3N5hHjWvOrhMfxblk0y7aEK990K
         xdTgqe82BiWzVo68e+4TOdw+b4QsOzHGKmblg9IeqTAb0lVBv1c+ZocNDdg3D6c1e12G
         ecnGDyh8CJEfprAfA7tsA113oNxnIgRQG5eXoLgf55cYjI4FnxG/R/t/caE9HttbQM3Z
         z53SaQu58Rm/OfqrWUXL1FQovd+9HNtfK1h7P5z9YfkI2Nff4y8idwUXtkgL1HX//i1o
         Z/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772043834; x=1772648634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tIPlETo+nW7/9bKJG0AVKHGPCMoVCLC4Z+gTp5I97A=;
        b=aKlJHMMeGpcXg4CLYKj5/oqJimITy0R8HPBe+W2OTG5l+QVocmYYjhRScLb/Qpthhk
         s4ee4fqjQn249n2zCTwES/LWJ0KuIr0c+PWyuMwdT/zGjCo3VAi1WYnWJ1NVJvFQrxuF
         dPaTNa8pn+TZzqJOzQie7j1n9ejmQ440aUEhOyRbBTd0/ok/kohfT06Zdfv3fJWJRsYR
         9xUQosQRo+63Rr4lkSrujKc6XHgYX4zQm6Gj65ukrwkta6mfPTxszgX7M1zPbHhoK5bR
         XgdauCxoSdHYJmGW59ZusuorFfclIGouSsQWp/yyuAHyGrHHHfilQl7lWVEJyTMWXkcH
         c6Bw==
X-Gm-Message-State: AOJu0YxwHsRdcCSKCYOupPomgIAniF5YGESkyArytojKfCVnBY+9nFUU
	EuW9Wp/SCX9V6APvens0YlhsIElakPPRIUWLxL/zSwJGOs1tfv9yM4P2NUa0uzgpElC5vGw/Hh5
	Cka7HkvkCsJPInhjpgWXots2Vzx9quIE6M73O9CpHsr+VeN4LTIFj0a6aAwgWo0YAJP72v4Sfnm
	+IyzZnr4R+6RDdjFLmVQOQ1hk8bk+83KFc90KCJQPOadp4B5M=
X-Received: from pghp21.prod.google.com ([2002:a63:fe15:0:b0:c65:c5fc:1707])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:958e:b0:34e:be9b:b67f with SMTP id adf61e73a8af0-39545f8794bmr13973218637.49.1772043833725;
 Wed, 25 Feb 2026 10:23:53 -0800 (PST)
Date: Wed, 25 Feb 2026 10:23:42 -0800
In-Reply-To: <20260225182342.1049816-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225182342.1049816-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225182342.1049816-3-joshwash@google.com>
Subject: [PATCH net-next v2 2/2] gve: Enable reading max ring size from the
 device in DQO-QPL mode
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	John Fraker <jfraker@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Matt Olson <maolson@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bailey Forrest <bcf@google.com>, Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org, 
	Max Yuan <maxyuan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261058-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AE0AF19C39D
X-Rspamd-Action: no action

From: Matt Olson <maolson@google.com>

The gVNIC device indicates a device option (MODIFY_RING) to the driver,
which presents a range of ring sizes from which the user is allowed to
select. But in DQO-QPL queue format, the driver ignores the "max" of
this range and instead allows the user to configure the ring size in the
range [min, default]. This was done because increasing the ring size
could result in the number of registered pages being higher than the max
allowed by the device.

In order to support large ring sizes, stop ignoring the "max" of the
range presented in the MODIFY_RING option.

Signed-off-by: Matt Olson <maolson@google.com>
Signed-off-by: Max Yuan <maxyuan@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index b1983f97..08587bf4 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -989,12 +989,10 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 	if (dev_op_modify_ring &&
 	    (supported_features_mask & GVE_SUP_MODIFY_RING_MASK)) {
 		priv->modify_ring_size_enabled = true;
-
-		/* max ring size for DQO QPL should not be overwritten because of device limit */
-		if (priv->queue_format != GVE_DQO_QPL_FORMAT) {
-			priv->max_rx_desc_cnt = be16_to_cpu(dev_op_modify_ring->max_rx_ring_size);
-			priv->max_tx_desc_cnt = be16_to_cpu(dev_op_modify_ring->max_tx_ring_size);
-		}
+		priv->max_rx_desc_cnt =
+			be16_to_cpu(dev_op_modify_ring->max_rx_ring_size);
+		priv->max_tx_desc_cnt =
+			be16_to_cpu(dev_op_modify_ring->max_tx_ring_size);
 		if (priv->default_min_ring_size) {
 			/* If device hasn't provided minimums, use default minimums */
 			priv->min_tx_desc_cnt = GVE_DEFAULT_MIN_TX_RING_SIZE;
--
2.53.0.273.g2a3d683680-goog


