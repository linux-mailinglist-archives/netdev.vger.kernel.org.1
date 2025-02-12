Return-Path: <netdev+bounces-165613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B419A32C15
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14AD27A278B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4011D253332;
	Wed, 12 Feb 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFII7u2F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A603244E8F
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378609; cv=none; b=BQRh6FtBjjetfIIrnk/w4WvH6ONWg5iCXey9IE8s5yn9o7z/DuzCMOfxDzDUTqbPjPjUEmsEJbvnosfzPKEgXpG+ywl0XdhcIqv/QffKVzk1nwc1CE2YKMm7cfdM1JtKpLGOSAVf4aJLrGBYytepZ1QXtUwC+XiqFmvtrvyDse0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378609; c=relaxed/simple;
	bh=G/a8NyO5AHywpcFHLuNQpoO7JJ9ufPIHBMOF+2eAtV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oy8+JkVpnS69lrBRrz40B94I2tU/54vXn/EjHZ+WaPD7XF/eul0Fou3B3MHQrGHWvDdv0LRlO1x66l+CxkrWtdSimwhlXYD4aRKKqgqMZtmRAFekvL/7XOlTtg/mgUk3S1dqKZzRY/3mUReRapzHkT7FSVP73/4/384BQF8QKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFII7u2F; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e4565be110so44383896d6.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 08:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739378606; x=1739983406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynBPjyNEjOvJrhbUFXKOP9BPboykJwFZaKw/XSCCEQ8=;
        b=wFII7u2FPyWTweAcmvfHFR3MVtDB7aefJ7m4riQqZ9sf04kIbvG3HRuwKX0Irh+PKk
         zexZiBA0b6GNNR5yIeQkkq1MBDt4GhEfFV09KfxtL2wo/o7bDMCmDLmxI8EgMltyys1a
         X6Pc+tbJB/xBOxvqI4aov8BK+0gQvgND4DPPur7rgK4OS7cyIcXbGmAx9YVnP80p23lb
         TjboWKOLbZbU1hMB9WqHGlFS+0g6r+HotLB01vYQcXRLq3iCjcS+UOb3Ds3Xdj5Nb9K/
         i3XRwvBTrPgHcWLWnvg1GGjKsUCm7tz9AUgZHBkC+I6TuBo3yLQtNW0KaQMNCzVJyZ3f
         i0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378606; x=1739983406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynBPjyNEjOvJrhbUFXKOP9BPboykJwFZaKw/XSCCEQ8=;
        b=T2FpNTtbXMVt+ZCOGEjS89G5QP2ES52QZ1v5bbreBfJ5bYRIODCkp37JpimfI7d9r5
         gTIfZ2TzAtVBktZomQqBJ52m8RTWcHdhjzUG58cADgIiNr4YbnGEaY/PDDIKofHKGzdy
         /mgyCVU0hcmhDpMfRkDYnMl5XusM4GBg10j3h3qUsbDrWgyY2Xx9A1ceoVv30P5wZL9W
         XBqcO+Vr9CdZB5LVA5Ot78fO78dwmeuNwiTGSm0ojxjQUPwnrYuZG+F33Vo16we/GCAO
         guP+yzAvrB+VQzdfiUz+w5AZBHue7brEJ0wEHTh6IBCIT1N9AQmQd2FAmNp2doIOL/x3
         xFCg==
X-Gm-Message-State: AOJu0YzvhDnW8iYv95TAMgKSFdVD5CV9jgfF2X5BNN87K51IeyZlVEx+
	muyM/jthM63OBuYfrQUyH/GeYgTvApeEyGysuh8e3h+Y3qpU/+7hOcwtjeYn3eW8jqyYG0S3Lw5
	mdeUgmbGOpw==
X-Google-Smtp-Source: AGHT+IGORnI4rAKBoEnUFIzhtTB0Z4URJ6XWddodDhFw5R7oOnUsizOtkEzGjBSTD2pGcWW7KUp8N1GjqEGEDQ==
X-Received: from qvbpi8.prod.google.com ([2002:a05:6214:4a88:b0:6e4:2648:496e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2683:b0:6e4:2d22:a566 with SMTP id 6a1803df08f44-6e46ed82877mr56209456d6.12.1739378606433;
 Wed, 12 Feb 2025 08:43:26 -0800 (PST)
Date: Wed, 12 Feb 2025 16:43:22 +0000
In-Reply-To: <20250212164323.2183023-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212164323.2183023-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212164323.2183023-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] net: dropreason: add SKB_DROP_REASON_BLACKHOLE
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Paul Ripke <stix@google.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use this new drop reason from dst_discard_out().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dropreason-core.h | 5 +++++
 net/core/dst.c                | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 32a34dfe8cc58fb1afda8922a52249080f1183b5..de42577f16dd199790cea9ac07b326864f2103e3 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -117,6 +117,7 @@
 	FN(ARP_PVLAN_DISABLE)		\
 	FN(MAC_IEEE_MAC_CONTROL)	\
 	FN(BRIDGE_INGRESS_STP_STATE)	\
+	FN(BLACKHOLE)			\
 	FNe(MAX)
 
 /**
@@ -554,6 +555,10 @@ enum skb_drop_reason {
 	 * ingress bridge port does not allow frames to be forwarded.
 	 */
 	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
+	/**
+	 * @SKB_DROP_REASON_BLACKHOLE: blackhole route.
+	 */
+	SKB_DROP_REASON_BLACKHOLE,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/core/dst.c b/net/core/dst.c
index 9552a90d4772dce49b5fe94d2f1d8da6979d9908..0cbbad4d7c07fa397f66a2d252a636f90dafddee 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -29,7 +29,7 @@
 
 int dst_discard_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_BLACKHOLE);
 	return 0;
 }
 EXPORT_SYMBOL(dst_discard_out);
-- 
2.48.1.502.g6dc24dfdaf-goog


