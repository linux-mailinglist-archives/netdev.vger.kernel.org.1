Return-Path: <netdev+bounces-263396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HeQEzA9p2kNgAAAu9opvQ
	(envelope-from <netdev+bounces-263396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:57:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E56431F67CD
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5033531096BE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE143890F0;
	Tue,  3 Mar 2026 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4bqAqaSW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF939659C
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567765; cv=none; b=tRCJEeih0wcc8EdVIXAhXqtZmRMemJKGdbeJ59DChKL+crLSHxXA6JTq2tENnsZI64ZVVVqmZmLWlxxOSO01vbIK5Gj5dtZDrDa557erc9C0Fb+ws+Tp5eP0bwrMrJXTvP3A8c/SJ6youjFY1jVEQQapLCV3ZdpA1Z2T5f/rW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567765; c=relaxed/simple;
	bh=bcPmWJbA+HwFh5Sp4FvAT6eGPD1jFzH7Tlh7wmLVZFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nc8QFephCaJk63Po8umsUz/VmO17yVVA9l9O4NIciOhBgatU+2mvCYP+W3ykLeUHHVRseNTg1r61An6Md7zIkRTKWVkGDPb73NM3n7c6Kl3dR75YivJICVuKuKD0QpOjxYgG6QyekO/wA+CMJ4lCldpwnix5vnG3TGudcFtN7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4bqAqaSW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso4810944a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567761; x=1773172561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7O+VqmWleakm25HNUCSndfnjpDlMGeEkeH0AG/54zw=;
        b=4bqAqaSWfGMG3ODjwionQIf98JgMtykwKCws9aOBc/R/0TMDWyhvKVMSl8t7m/OrEH
         hAnAJiFoXPGE6b+vCvEqZ8ArTzXM02uUgAS/9rLwQvfsxAav0QifZSzLM+gnraqQC7e7
         MAwO5HfSmh+3Jb8++u7fzA66Qo1R6nUJS+IUyg1yoqskycYCYmJ8oiGrz5QEApKHAlVV
         0tTt0sp/IBKIDwhs8Pr4dvTDj6kr3ZF8LiqN0KRKWEPk0dnSk+kX6WcD1Cv6M5MD5H+y
         SMY50DiqkA53sHj5v+MdaViqDzDWum0vIIjU8otQPEOadTsDEC/E10g/4VsYtD8BBx/Y
         Z1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567761; x=1773172561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7O+VqmWleakm25HNUCSndfnjpDlMGeEkeH0AG/54zw=;
        b=G1KG2tRkGaI0HC1lLPVGNpWt5m/4fCOAIknnubAgrBMkwAt47pU/ap1zumdG7yC2DB
         AIarjjYe4gQkwbaSztX/Ve4mfOtoU7ZJXQY2sTJym0snWjj5AI5FuoE4Vvw3MLZ6M8hv
         wzNcWjoF349VjmqIHsFK42sMLZvL5qr9B1jjiinmc45NGgzIMcQLN2RB2wFClJY0JaKY
         hw8rvsz1cJanXvcSJXg51hgkOAhwLKuKwAKllJJdpN5S2Cj//KFvreJzfQe0z6Un3SGb
         KRwbwxH5FZHmgl3/qd/tHeibt2M6h23cV/+MwDdxl68vEatao6IhNIRrykhWeJpcqaAK
         6PRw==
X-Gm-Message-State: AOJu0YyKsb6XdiFzpS4cujKpFoHAeYQQ1Pk40cEmqZvcU6Jo43AcGhvt
	vbZp3L8SLHRlTUmlzlP8vGfdUWYuiq+0HW4iuA3whPS1B9A44mqcaInDCvACTm8XuFh3AHBz/zm
	lxuB3J8H3FuwxShIJ49RNhJW4Gc24e59IfI7IXszSc8FArDVYjw9bBMjKkC/sDe/C4AjH++dklZ
	oR8sijjJF/DrRxEi1zWNQ7E0l3i5MpPk5GjDSn3MdNK9ZqbBA=
X-Received: from pgag24.prod.google.com ([2002:a05:6a02:2f18:b0:c70:e479:52d3])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:610e:b0:38d:eeb9:8f49 with SMTP id adf61e73a8af0-395c39de44amr13785530637.2.1772567760815;
 Tue, 03 Mar 2026 11:56:00 -0800 (PST)
Date: Tue,  3 Mar 2026 11:55:49 -0800
In-Reply-To: <20260303195549.2679070-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303195549.2679070-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303195549.2679070-5-joshwash@google.com>
Subject: [PATCH net-next 4/4] gve: Enable hw-gro by default if device supported
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, Ankit Garg <nktgrg@google.com>, 
	John Fraker <jfraker@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Matt Olson <maolson@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E56431F67CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263396-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ankit Garg <nktgrg@google.com>

Change the driver's default behavior to enable hw-gro whenever supported
for device.

Performance observations:
- We observed ~10% improvement in RX single stream throughput across
  various MTU sizes.
- No change in TCP_RR/TCP_CRR latencies

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 873672f6..6ce8345e 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1128,8 +1128,10 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	gve_set_default_rss_sizes(priv);
 
 	/* DQO supports HW-GRO. */
-	if (!gve_is_gqi(priv))
+	if (gve_is_dqo(priv)) {
 		priv->dev->hw_features |= NETIF_F_GRO_HW;
+		priv->dev->features |= NETIF_F_GRO_HW;
+	}
 
 	priv->max_registered_pages =
 				be64_to_cpu(descriptor->max_registered_pages);
-- 
2.53.0.473.g4a7958ca14-goog


