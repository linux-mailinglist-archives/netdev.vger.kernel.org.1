Return-Path: <netdev+bounces-281081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFO3DDoK7GnDTwAAu9opvQ
	(envelope-from <netdev+bounces-281081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 02:26:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C254643D0
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 02:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A1763043AFC
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7803D1F03D9;
	Sat, 25 Apr 2026 00:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8833Mtn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CF31E9919
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777076702; cv=none; b=GfYz4Lb/ENQr4ADXjbZPO8+49MUkxFJoe9p9afc5CpP8YinXcv6P1l7RlRtMNEKwj+kXGMJjVjoxcRvWUEizGFjkpx5+qqN9p41XhPibSfLkwPya4ge2JJ27/iJFq9M9zy4TLw/KOXFnGhbp203GC5IfZo/m8GgWPS2jbu8FF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777076702; c=relaxed/simple;
	bh=LEicXDAPI28EFLbCEUUUbtCAmhQDAo7ran0ciTNYXjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gBEamseEWlO+kLO+/Hy4vfstY2KCxtaNxouoCd2ZJXiS1MvOvMCXxAzeMnl3lyLU7jKoddZYKm4yVRTIISc7+hs0LZTMKrb0AhqlbuDMJdvxmacaiqXWzvAi3wGdHxbLFqXtNJw7CBElQ7E6SYHdbaFxDwiYSRcWGPUQlogtdMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8833Mtn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35d9278587bso9780082a91.2
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 17:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777076701; x=1777681501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZylLCoEiHYdV/ejnG8Go+DBKtjN8GWujCPj9sYIWSRA=;
        b=P8833Mtnxj+iACN5b078BGxoHPQ+XEmATgo0Gyegpy2PlWtSvWExtcqsbFaQuds83J
         AdUpogPRONZ42hejnPWWlE6C6D7wVGd5NctRIdaFUZhuYEaiUzHk4wyOnYQOk16j0Oa0
         t4nVcqf81iL3cSjnky+gSOYGNzCELocRGjMUFwQrPkiKxSRAckTZY5ZPcA5L7ST3/Mdk
         IrB4ebiRuFEN309UGSZuUr6l0kUEVy6MzYFyMvM5885YeyCQB4fDbIkQQ/0l7iuNWV14
         fX9YhCxr51sa9MTLzY1MJLnoyWhyboUJGVutYmTjxA6/kGK3SVEnylfmIdVHEmK3M8Uu
         7EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777076701; x=1777681501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZylLCoEiHYdV/ejnG8Go+DBKtjN8GWujCPj9sYIWSRA=;
        b=rZTBgSWy+NbwNroyWZl23ApOirGv6Ze3N5X7U5t5mah19H4gyHAShZZHXj5N8qjaXA
         xDmLMkheXOyk/1lI84adEvZWMuQnutapErFZ4V3+C0xAQoJAZzjF56ZqdXpeylavGVu9
         MJIDSLQW1SLBZUg41QBKAfWBAtNyPX9znjD1zd8JfY5i4P/FRLVi8TkNrtSLs+av4nH1
         5XJOSaIK/52uaTxMadNvq0KSkDfQATn6OSRgGdeJ7ac8dt5eFYmxEw/RgO3C4crlDVfg
         NDoErYHsMdlbaN8lU5a5zYVnS6+THluAReepxaVkI+PcLLrLPCG67Odc3EkHD4rPkVrK
         gNdA==
X-Gm-Message-State: AOJu0Yxc43gr1LV6kmidVoQhoNSy08ChPkpzyoAw6y9oPjnokadCzkwS
	+U4/KQkJu6MqfjIFfzlIdkhZA1aboB1BDcA3Knv0+twagwLyzyZ3anVe5Bts5Kz3oQMAe243zEe
	/IZGdkGaMR4ECYWN1dcO5gm1wA3j8dw3yTHrIZNiY2P6QCOleW6NOmxkRqSqQx54dDR5l5J1YkK
	rB7OrVc/3AeC4BNAn33zFaGtPuPPm/ICpfywND5DnKO1cOyjeU3j2L1Ko0wP9/6vY=
X-Received: from pjbfr11.prod.google.com ([2002:a17:90a:e2cb:b0:35d:a03b:ab5e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e46:b0:359:8dfd:64c8 with SMTP id 98e67ed59e1d1-361404a81e0mr33622651a91.24.1777076700095;
 Fri, 24 Apr 2026 17:25:00 -0700 (PDT)
Date: Sat, 25 Apr 2026 00:24:49 +0000
In-Reply-To: <20260425002450.163421-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425002450.163421-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425002450.163421-4-hramamurthy@google.com>
Subject: [PATCH net v2 3/4] gve: Use default min ring size when device option
 values are 0
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 94C254643D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-281081-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Pin-yen Lin <treapking@google.com>

On gvnic devices that support reporting minimum ring sizes, the device
option always includes the min_(rx|tx)_ring_size fields, and the values
will be 0 if they are not configured to be exposed. This makes the
driver allow unexpected small ring size configurations from the
userspace.

Use the default ring size in the driver if the min ring sizes from the
device option are 0.

This was discovered by drivers/net/ring_reconfig.py selftest.

Cc: stable@vger.kernel.org
Fixes: ed4fb326947d ("gve: add support to read ring size ranges from the device")
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 08587bf40ed4..2cd0dd6ced94 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -189,7 +189,9 @@ void gve_parse_device_option(struct gve_priv *priv,
 		*dev_op_modify_ring = (void *)(option + 1);
 
 		/* device has not provided min ring size */
-		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
+		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) == 0 ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) == 0)
 			priv->default_min_ring_size = true;
 		break;
 	case GVE_DEV_OPT_ID_FLOW_STEERING:
-- 
2.54.0.545.g6539524ca2-goog


