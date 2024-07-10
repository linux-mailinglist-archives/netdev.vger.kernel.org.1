Return-Path: <netdev+bounces-110546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4B792D083
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF974B27D37
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394DF190484;
	Wed, 10 Jul 2024 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oMzPbd4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D719047E
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610234; cv=none; b=hSxerRl3CE/jt79d7w9w8TO/E/LttnDVMsU7aAn7L8L2TTHgbyTATYiLFOuG4RaRAjfRt/Fs0YCxUYM/bALIAUVt6KOGLVTmvtdwcziN99HQUQq72n+5myHKJmi6kzDjgklLeSX1UajrrDes2avYI+CGWbiqb/KYKjL4e37xgdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610234; c=relaxed/simple;
	bh=6wcAfIzA083j9udKzDviD3/sDaqZOKbaCwhCVSZxdts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UE2n+EaeZUCjMI3nDVPrtcdqGis8vGXfSeCeLoU1qf+Nc6WurfgHbz4KixuGpokg4f8HbREV7cstmsZe1cvNfZeu/C3vF9nFPAoHcJR1NFzDELyu5KMoIFU1Ckyni5ZLhgUd2tGnBfuTE+MRQ9NAB7R7L91ccjW0m5ePOpjp+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oMzPbd4H; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e039fe0346eso11079245276.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720610231; x=1721215031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+oYe1ueaUtt6r/NxRQwLFx8cwsPSNkw5jKdeiGr0tE=;
        b=oMzPbd4HMmCJ8+0pJv5fi48PKit+I8HfR7z4IAO0ykFiP0B5/VO84k+KSBDHQkPaMn
         rHLkFM5gu5F+Dj8ERbtPiFw+bwURYVlxi5RVcrQGWYLWj043+t5ot9CkhEPIN0awpVjc
         /r5aVQLcFcgX+Kb3hFNfFPrKfzf154D6bvSTuVI/bwqJFdnBB9db24pfORLCN4DNUcbA
         tFnlT524iAMwvaoIOUUfw39H+hpBxuA5cxQ3tw3+7ZPtgCej4obsJRokyq75wBqGgu/i
         VzJg2gCs3CbNxk0OJG5IZqE6S9OBWFzuB+zAY4uqoqmykuhLsYU0j8fOxkzI69764cJv
         WQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720610231; x=1721215031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+oYe1ueaUtt6r/NxRQwLFx8cwsPSNkw5jKdeiGr0tE=;
        b=wGVVlyazXEx0qTyd55Hy6vKjHV7tT5KgwgdPXxHDrXh+H6tUfUx/rQShZBwRkkAr2h
         uVg/lHgoeE6NVcsv84r8LlsdogIzhTNLVPDBMQz8bQqJ5YB1B3llp9DXdXr/VaPUuYtk
         5szcGQ6KhR4AROY7npGG2zM5t7m08bwQo8TsJx6uDXJV7FKS6dbXcAqZKvzQDxStvNKQ
         L5vGhPuB4f+GemTdPZDMlnPPahW41wJ2JS8bEGp4+9xLQHt9b0HcMik7qSxaGL9gnZ9Z
         VjBLuYyOlA6ya5wYae/RwFPfkHyOss6GIGWZeAruOiqZN5JwLqZspdpaA/0mKenAalOw
         QT/A==
X-Gm-Message-State: AOJu0YwMrUzC8ESKdQrVfG21LKcSQgCcTIVkWZlU1SIrTmIvmj7DCWTS
	nETrRVYzx324VQayjPJprnerWLqP9KT64Oe4oshJQXD6+MMR9uZdZnwG5a7k4FlS+VrU8OOqZ2Z
	rxRNrgrsaJhu8J0j04+z+4kybYsGmPWg3y7MG5tpnEjOZIGtlSSC3wxMElrMxuhb3bbXJQktKy9
	KWR4/7lhtZlM1DkdFrJ+f1r75ETALeJvxX
X-Google-Smtp-Source: AGHT+IG3vKwcd5iyOmZNVcrbhxXuQFhOaT5ELZLgJ/OKN3TWMQvE94wfCSdLkkZlOWcpa1vwl+O63oX2i7k=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:6902:2b0d:b0:e03:3cfa:1aa9 with SMTP id
 3f1490d57ef6-e041b1134afmr11718276.8.1720610231327; Wed, 10 Jul 2024 04:17:11
 -0700 (PDT)
Date: Wed, 10 Jul 2024 19:16:51 +0800
In-Reply-To: <20240710111654.4085575-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710111654.4085575-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710111654.4085575-2-yumike@google.com>
Subject: [PATCH ipsec v3 1/4] xfrm: Support crypto offload for inbound IPv6
 ESP packets not in GRO path
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: yumike@google.com, stanleyjhu@google.com, martinwu@google.com, 
	chiachangwang@google.com
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
2.45.2.803.g4e1b14247a-goog


