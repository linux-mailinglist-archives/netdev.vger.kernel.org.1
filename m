Return-Path: <netdev+bounces-108361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F51C92384D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DE11C22311
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0054A14F121;
	Tue,  2 Jul 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WD44Tsny"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7078714F9FA
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909905; cv=none; b=oVFKrvasgtJmlqNBfWDcLeSzoh71Mbq1KMOJijAYWfjkpQLxG87Z8mgnhSLeIk4ZXQz9wz6L9rhDAM6nnDx67dzLr+jGOldLtmnMI0qNJyJ+ZrteyVrxLx9ekFCKFtZ0ze5MfNll+ct+OdILVrRJHnpXCcxiwwYDTYIUeD0IgD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909905; c=relaxed/simple;
	bh=6wcAfIzA083j9udKzDviD3/sDaqZOKbaCwhCVSZxdts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M1qJt8xfvXkig9KCaCJ1yuSZhnjRZ0rKNLoawG8YrJavd3PRNvmdhGry9+HCEFFIuc6znEyiEAspeh2UUK4PSoYDhhkT911uuTygA86J3/xza1XJfxT3i5muhhAHre2YxlGswEuFeWhMolvwb5CKBa5HokxP2jrydGyBQDctgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WD44Tsny; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6479d38bdfaso78790167b3.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719909903; x=1720514703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+oYe1ueaUtt6r/NxRQwLFx8cwsPSNkw5jKdeiGr0tE=;
        b=WD44TsnyLhCyFK/aKK1Go4I3UAurMqq/QQlZ+YqUs/ufyf9/mcdgAuNlw46eHdQ2yN
         FEeXqZ3hdwAqjC5DMb03IDcz0mKxTxpYFDNkYk1ZeStwMxRiMTZvRnDGMjLgDAhNcTYw
         C7+a3pOFYJ1Io3Uhn4OyVqNA44tF3ASeJgO33eJk76DGRj2tkGvI5uIaiUMOPDiFnjDb
         4ojxg877Si8V3orfYfhe6WpkWMoxcU8b8CDDOCXX9+xpNefI6JvsR4NJN+a6YlGjlkDm
         BZdDwX0uQyTFRbZ2oHRbSJr7fY/mYJJtAYWobeX3UsdYa3hKTFTKIzg7uW6bR/Y4DC5e
         vS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719909903; x=1720514703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+oYe1ueaUtt6r/NxRQwLFx8cwsPSNkw5jKdeiGr0tE=;
        b=RexI3zknTAdU/boTwmaFsR8f+UQsTVNwLre0SSVuYLSwGQNxp1vrToPw+H6syyVp9i
         oWxW1s5Ehfw0ii2Y8R/k7jqYdtEu0z825Ik1TmN3lvfFO+zAbWMSuU+BFy1QRguWjLfd
         bhCGHGTUfQ4qbseuxF9ZLXKujDq6dt86mNox1wjeP6uL5zGAQMRFqE2z9/qtNNRKV+WC
         9d2cvp0+i9oLpKmfZOkbqT7LlB0sej2e3Qb2YEI/l9Ge9PkasfxpbM6Nj729/no68Dhs
         LC16YlQfoHvaCJgj6CubMCPgmwjXUkXZIF15zbrZZxrgjgcfk6w9Tdks0azFpY2def5p
         4+cQ==
X-Gm-Message-State: AOJu0YzgAj/R8rlFpmWczdhos5LofnfZiR+vNQAMgGMP3Hj8KvvD8KGU
	D6TQSbvSS0eUKJUWrkeaFjVWaOvQGLrR1zoqgThGmagfJrZa80ouk52kgKtGqJLsQ0zaR6KJD7n
	IJ+7idOpv5WzALrsx/d9nYHxKF4Ci8NP+yz+LvrMlT0GZL00Cr5j+MZReE7Mc+2ssi6Qd0lh7m2
	23biZXu0LFNYFNO9rKqQN+c3dvK1cyROHc
X-Google-Smtp-Source: AGHT+IHE7D4/y2QIUmTcXcemwuZL8FxTYTIR5Pxp/x4xEA0WiuFElZcszOzpFT8JoFWSTnnxFZPiIrBWE4o=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a25:dc90:0:b0:df7:9ac4:f1b2 with SMTP id
 3f1490d57ef6-e036eb485eemr223764276.5.1719909903221; Tue, 02 Jul 2024
 01:45:03 -0700 (PDT)
Date: Tue,  2 Jul 2024 16:44:48 +0800
In-Reply-To: <20240702084452.2259237-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702084452.2259237-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702084452.2259237-2-yumike@google.com>
Subject: [PATCH ipsec 1/4] xfrm: Support crypto offload for inbound IPv6 ESP
 packets not in GRO path
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
2.45.2.803.g4e1b14247a-goog


