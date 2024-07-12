Return-Path: <netdev+bounces-111014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54AE92F42F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 04:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073FF1C223C0
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0A08F70;
	Fri, 12 Jul 2024 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMRAkTbp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7489FBE4A
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720752696; cv=none; b=pNU9eFghWLvpsP3G7EvDMk9QHcFD/G5U9tV4szCZUaoEPO6cbQPzsgn6t4sZQ+y0wA5vbmprGU+gH6XcWD41UObizB9B0CfyRE3GBC42t8Lvu8ZOebLw7ktr76062gyiZ/41j2NVQgew3JFDjP3kOKZagqVQL5tgFEzsxb+62l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720752696; c=relaxed/simple;
	bh=XDn2xQ6mSdf4vqwrpivn/Bk8DGfc3nDkUe4obUElGNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j0oMms7GOtvIwj9mqFI40biR3UoI75t2FTqXAqp5kI4bIQHkol1gsgN+PvVPAzm/DOI2/CFKDgnjZ8xHgtGdxi35SVdmVdAl/JgVVhjyXTl/dx3hmBnD9xxYtmaSdlBbEJlYb6izAWZJ0L5Pcg7psfQXp9WBLDxr5mBUjK+EwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMRAkTbp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64b70c4a269so25791177b3.1
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 19:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720752694; x=1721357494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xa2SKE1EBrP4tXqYTNA1j0gjaQqK1FrRbdlXtusiecc=;
        b=RMRAkTbpOn/S6H+Ty+IZpFLXP+8RV7P/tIWukKdq6qzX1eKR06RiP9IsXF4dzNu/E4
         SlIrAqbp3aDqXy+RA5eCWSPnTZBLoC12q2AAmvEDI4qIRjUq/d4q4G+fSAIAfv0xCq2K
         j7AgCBVmF+f9bOj9W7XAYunQUO5+3IV4dWcLrtUjN0JDPnc94Vhm1xzKHTRX526mz4Hf
         2HxJLuHTji7yZ9Jd7YCUQym2p3gzf6qb2Mr98/Wv0w0wlg8qbQYKj45HD3D21AZh52ZN
         tIOon5+KH9YngJKbqultcJPJCx+G4Is+7gIv38+FZ2S3PVBOEeuaww6aI4WqkDDvZZ6y
         mFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720752694; x=1721357494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xa2SKE1EBrP4tXqYTNA1j0gjaQqK1FrRbdlXtusiecc=;
        b=UKv8QXpsTCYRLeJRlR8FuapEbAaVJpThVox6FrfONmIutZjcDxYkqvVcX52LYEdUwp
         bpP13miR5wsLQpz+kFS99kruIOxYFexDzcJPBNV0Q8G/OZpGj5e/W8qGzZTKbyzIsgyc
         1YmgYm0jTU7q0JU3rgWpm2Ny/dnndGmLY5L+z+Q1yN2KQde3KEINePMeMQzMFzPkTr1a
         RNu8V7bDVJKsrkitYWxQyVhmrKOesS+WdtuqZ8Q/V6WDEzGwEwG0P8c2lndMccxjmkX9
         Rah+fwInN89SogJmfUdDqwMyenRL51UueagZYXf4PCNhCh3Sse1tUa8eIlsVzOqs6uaF
         I+/Q==
X-Gm-Message-State: AOJu0YxpuUKXMx4ROAPobzvIOWanJZMpLbmZb319I4azAg9RU/ldX9/D
	E6K2Jk+hhK96s7+P7WtM+70BasCIrm/KtnX6btWAhcG6K8x+Q4g1iIZh19h64T3Gg13Iy16c2xK
	G2PKL61sSAamo9OHvB8pjd2IolQxdSNiNH6ZRVCnKRVqUtiI9Mfef5ed/eSNGR2sMpTzmhs5I8d
	cJXVFtsjpX4Bx0laHN5W9XEQ4EvA8xLThY
X-Google-Smtp-Source: AGHT+IEP7AUtVMMSa+uF6p6qEwt8XaV85M23q4GMS6hVT/M8vT4Yox7CY6eP+meNWx8q6W0fIrpjXNPPg3c=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:690c:4d82:b0:62c:f6fd:5401 with SMTP id
 00721157ae682-658f04e51a9mr1352387b3.6.1720752694382; Thu, 11 Jul 2024
 19:51:34 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:51:22 +0800
In-Reply-To: <20240712025125.1926249-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712025125.1926249-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712025125.1926249-2-yumike@google.com>
Subject: [PATCH ipsec-next v4 1/4] xfrm: Support crypto offload for inbound
 IPv6 ESP packets not in GRO path
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: stanleyjhu@google.com, martinwu@google.com, chiachangwang@google.com, 
	yumike@google.com
Content-Type: text/plain; charset="UTF-8"

IPsec crypt offload supports outbound IPv6 ESP packets, but it doesn't
support inbound IPv6 ESP packets.

This change enables the crypto offload for inbound IPv6 ESP packets
that are not handled through GRO code path. If HW drivers add the
offload information to the skb, the packet will be handled in the
crypto offload rx code path.

Apart from the change in crypto offload rx code path, the change
in xfrm_policy_check is also needed.

Exampe of RX data path:

  +-----------+   +-------+
  | HW Driver |-->| wlan0 |--------+
  +-----------+   +-------+        |
                                   v
                             +---------------+   +------+
                     +------>| Network Stack |-->| Apps |
                     |       +---------------+   +------+
                     |             |
                     |             v
                 +--------+   +------------+
                 | ipsec1 |<--| XFRM Stack |
                 +--------+   +------------+

Test: Enabled both in/out IPsec crypto offload, and verified IPv6
      ESP packets on Android device on both wifi/cellular network
Signed-off-by: Mike Yu <yumike@google.com>
---
 net/xfrm/xfrm_input.c  | 2 +-
 net/xfrm/xfrm_policy.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index d2ea18dcb0cb..ba8deb0235ba 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -471,7 +471,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	struct xfrm_offload *xo = xfrm_offload(skb);
 	struct sec_path *sp;
 
-	if (encap_type < 0 || (xo && xo->flags & XFRM_GRO)) {
+	if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type == 0))) {
 		x = xfrm_input_state(skb);
 
 		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6603d3bd171f..2a9a31f2a9c1 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3718,12 +3718,15 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		pol = xfrm_in_fwd_icmp(skb, &fl, family, if_id);
 
 	if (!pol) {
+		const bool is_crypto_offload = sp &&
+			(xfrm_input_state(skb)->xso.type == XFRM_DEV_OFFLOAD_CRYPTO);
+
 		if (net->xfrm.policy_default[dir] == XFRM_USERPOLICY_BLOCK) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOPOLS);
 			return 0;
 		}
 
-		if (sp && secpath_has_nontransport(sp, 0, &xerr_idx)) {
+		if (sp && secpath_has_nontransport(sp, 0, &xerr_idx) && !is_crypto_offload) {
 			xfrm_secpath_reject(xerr_idx, skb, &fl);
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOPOLS);
 			return 0;
-- 
2.45.2.993.g49e7a77208-goog


