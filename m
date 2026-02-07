Return-Path: <netdev+bounces-257684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBouNh2Thmm6OwQAu9opvQ
	(envelope-from <netdev+bounces-257684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:19:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AA2104719
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 064733069D75
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 01:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6825C6F9;
	Sat,  7 Feb 2026 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="meE/v4m/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BC225390
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427071; cv=none; b=GUUXbtb102ELQHWbHMvi51+JmH8Jz8suVtaTNr0E7LxLx4eLKP1YrNZaElmdatwmjGVKaRZ2TbdgcFVlct1QP241wiX4m1J6ovfkoXEucwQq+DBOUbfR6K8xFInS5H02pKlRvcztBQipgFPznc1Y4Qz+E0Dt5DE27vf/Ezumxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427071; c=relaxed/simple;
	bh=n1FpuRLPegsOCgW5Ep3001MoHdtE0ua5INU+vaHadF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m2/bd/nNNOcIqDdGq247TRCdJYpECcyStp6fftzaD1sYRI1AtZLg2DUwy4QAgm/0sTjPJiqiz7cYPPe3/ZjIDycsCSj8zZu0ujlhTQFfrxWqKOv4x6h5Yb4kCZcbWBFk8/K14UL5ltPgS57f6fQt4kqF3ya2Lp+3qi+LMHpUk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=meE/v4m/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-81f53036ac9so2070411b3a.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 17:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770427068; x=1771031868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gk4dBgGZGggyHis2Av7BN/ugN1ReCsTcFsztI1UNdI=;
        b=meE/v4m/cSEFhZlgF8nKK7Y2OG6lQKUblSLGwn59MoUDXzUTmp+XREWuNmisSbo9Nr
         Bm853gCUc3xlcNX4s47CLBx01RIkT3fuyH4rhZY2PTchQjW0VdFz20FwyfgEK+7aZaA2
         d/PjPXmZbiNQxnw6acUUVjSOen7Ca5pxj3Xafa3T2xIteoJPx/Pit00gNqc1sSpQbkvx
         M/MlGXx3hLu28e7PZT/y6zfp7gwtNGRX7hAO/j7EVtUSTlYkxX+/JKO/TK23CsIzdezl
         eing0cJyy+yv6TZ/Q8lrg2c/ah11kgbmaoOWK5DZYrBgOcrQZlyeZ9AO5E+6z8HEyBne
         xi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770427068; x=1771031868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gk4dBgGZGggyHis2Av7BN/ugN1ReCsTcFsztI1UNdI=;
        b=R5dOjs7txVaYVGb8Cj8HbyBbU4vYRDKkAjGtvO6U42SBZe8KJMIcCGoP/CdxzkVQep
         0udcQODlYs8IynAfC3RYUy2wYymfGOY7MLlI7yXc6ZYTdXUF8vxgixr506ZKyGlPTdmC
         oOFUZ+peWBfz/iifbmATzLGva/CsKKyRSKfLKN9FP8aFYfqdTzqMKNCfgjeidI8Ot8qk
         YLam6sn7jdpXczDdZSYMZj5S9MotKlaX3EwEeHuPB2wqnjtlnYFGjX8fY1hz4zRJNyqh
         l9IZylZW4GaDa6Uq8fSN2KE0ptx0OlCvlrfG9ppgCWxF72bEOCgIACG6b+HmxTR036MX
         l8vg==
X-Gm-Message-State: AOJu0YzLIUpRHFtKSXbYaoPDiS75+cBJdpyo5uEN6/meSRHV9zn+R8BV
	FTP+8RiXrvcLM6h6429AwNeqCo3Gay38PiJnhXbX3z6ZPh1KG/CoMWQgAzEhrPMSTIiRIgtW4OQ
	wzaolrnHj3IkNCg42tvhydiCY2xXzVbubACuRGceuWk42XTa8fAgySAGcrSy8bC9/1Ws8MncPCj
	y1GY9f9evXkQblAXNtsgZhp7gQj/prrNIzmOllzNeDwII1f4s=
X-Received: from pfkk18.prod.google.com ([2002:aa7:90d2:0:b0:823:1090:870e])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:12d7:b0:823:1094:243c with SMTP id d2e1a72fcca58-824417b3888mr4180465b3a.68.1770427068160;
 Fri, 06 Feb 2026 17:17:48 -0800 (PST)
Date: Fri,  6 Feb 2026 17:17:33 -0800
In-Reply-To: <20260207011734.437205-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207011734.437205-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207011734.437205-3-joshwash@google.com>
Subject: [PATCH net-next 2/2] gve: Enable reading max ring size from the
 device in DQO-QPL mode
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, John Fraker <jfraker@google.com>, 
	Matt Olson <maolson@google.com>, Bailey Forrest <bcf@google.com>, Tim Hostetler <thostet@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, linux-kernel@vger.kernel.org, 
	Max Yuan <maxyuan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257684-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41AA2104719
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
2.53.0.239.g8d8fc8a987-goog


