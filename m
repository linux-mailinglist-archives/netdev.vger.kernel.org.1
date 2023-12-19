Return-Path: <netdev+bounces-58890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A960F818809
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4772328C6D4
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DB81862A;
	Tue, 19 Dec 2023 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pf7LjMa1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FDB1BDC3
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbcf1b27794so3726303276.2
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 04:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702990412; x=1703595212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6iLkD/kmm3rl/27nC8mmpi3BqCULi3lDXMsQJIHD3Io=;
        b=pf7LjMa1F3Kg9xn0CBujrVFj0+S3ALyuUUrFh/TpXWsaW1a4SWVjbfY15D4Je80Cex
         kfe+Wr2S195CMusE4d0SfwU/tzjdFtfyJsd1WSbartx4Uy3MS96sk4faJUV8Sjuj+bS0
         FacR69vJVncwijHIOHxvpcW87ID3QZL2g1Hv7vHe5DFoJotUDSkemiDdc26D2JYC1NrF
         ReQfEVNFirK2eeENLxJnfW7fBTgTU0J/RIbi5pqECNXCZuz3B3u30O/tGYByk7/bjinb
         KhnU7v/XRdqvypnwAKcJq83h2UO7Vg8RftJWJ41habquVkef5VZkDsqP5HVGevCvutcl
         CjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702990412; x=1703595212;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iLkD/kmm3rl/27nC8mmpi3BqCULi3lDXMsQJIHD3Io=;
        b=h4zPnF4C48uvqs/m+YjDu7L2TK3pOuBcanBubEnuOdv3WYVxc3kcTGflSwZeOUdjRx
         3k8dLlQvq+UrV2TnKsVtY8j23eLF0DvMxZ3OQPlaHaIAY/I2ibkUOdxaZnGrpFyv2eos
         pG18e+jQKdt56Z3tGESu+qpfWwbsCqPlbeD+oLpzfS4hCaWMJeGa6ldvuxBsT9OvdjaS
         pbHhPAlHbslBn59YiqsKxOtzCKy53vU9SgSeinWcG+hP1CI/mf2ygleO/SjrSxpUl3ZL
         BMHFN4gNAHUARMR9rD4JcCegEXONgsycLmFYp6g46zLE2EYkXZ7FcuttbFAmgIGGVZws
         93Vg==
X-Gm-Message-State: AOJu0YzAm3o/Oc4o6J0ZHeTWqwiq1xuYjSplyGMUFhQpY5J4m1Nb+CW+
	jYkHijADrhpzCm2QGL6qONjsU1MFnHqAsA==
X-Google-Smtp-Source: AGHT+IGoSJ9yNhNxC8R4jYgetFABSShYFxwXkGrekmzjMkt3TKWs7hDLzdZfDLxaxmSiM2np68ekfDF9leZYdA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:513:0:b0:dbc:c59e:fa7b with SMTP id
 19-20020a250513000000b00dbcc59efa7bmr247895ybf.7.1702990412558; Tue, 19 Dec
 2023 04:53:32 -0800 (PST)
Date: Tue, 19 Dec 2023 12:53:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231219125331.4127498-1-edumazet@google.com>
Subject: [PATCH net] net: check dev->gso_max_size in gso_features_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some drivers might misbehave if TSO packets get too big.

GVE for instance uses a 16bit field in its TX descriptor,
and will do bad things if a packet is bigger than 2^16 bytes.

Linux TCP stack honors dev->gso_max_size, but there are
other ways for too big packets to reach an ndo_start_xmit()
handler : virtio_net, af_packet, GRO...

Add a generic check in gso_features_check() and fallback
to GSO when needed.

gso_max_size was added in the blamed commit.

Fixes: 82cc1a7a5687 ("[NET]: Add per-connection option to set max TSO frame size")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0432b04cf9b000628497345d9ec0e8a141a617a3..b55d539dca153f921260346a4f23bcce0e888227 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3471,6 +3471,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	if (gso_segs > READ_ONCE(dev->gso_max_segs))
 		return features & ~NETIF_F_GSO_MASK;
 
+	if (unlikely(skb->len >= READ_ONCE(dev->gso_max_size)))
+		return features & ~NETIF_F_GSO_MASK;
+
 	if (!skb_shinfo(skb)->gso_type) {
 		skb_warn_bad_offload(skb);
 		return features & ~NETIF_F_GSO_MASK;
-- 
2.43.0.472.g3155946c3a-goog


