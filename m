Return-Path: <netdev+bounces-110104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6060392B006
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3943B1C2182C
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5863D139CEC;
	Tue,  9 Jul 2024 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FU3pqZCv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53212C475
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506217; cv=none; b=sBDVPu1n1l2CGbk7rjtsq4I8OiKhh0EzTxpOMkvnZptxbMvAHMszJ1DP22/O2kInoapKrtWOfQJZBWVxi4mahFehMgakr0W+dFW7PUZNgcd5XceNasJsB6462v7UaujaOdc1UQgoaHjwCHFbndH2+WpTk3TKH6nrIvus4fMvSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506217; c=relaxed/simple;
	bh=6wcAfIzA083j9udKzDviD3/sDaqZOKbaCwhCVSZxdts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mPaQrIzF2WJRoZRsmLT7iDJF9y4xOelwiOJ3n9kgil4l3jhtUdfkOhDe4c3lzdSgy60uMZ/WwAJijzNXiEP2VsMTqErVPIpvvKHbe34gOSJnBRFioXU27B3gVIqgpdR4NHAqd2sqb84pDtHaMuQfdDwHOafPPMwp74dybG/7VjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FU3pqZCv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6522c6e5ed9so91475547b3.0
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 23:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720506215; x=1721111015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+oYe1ueaUtt6r/NxRQwLFx8cwsPSNkw5jKdeiGr0tE=;
        b=FU3pqZCvl1QVFcUoNqKm92BseDzpZHLKDC+G2h08dgLMMd7QCZxAHe0TJHO/qST/39
         dJP3fcufA2Sy+H35fKfUBoj4aWAcdRqEXC8aoc0df93ZdufTS2r91Dzm4MK4NkKYSqVK
         w5hncET+GbqxxE8r8Hp+lO6eId/dUiLZIWet/tm2PANFnRdNfKGGj01ZQEXOkCVJz5Kl
         3qGLk+gHXn/B86BR8eT2p70tU2WAmfcajjCTWFCWBNNBU+2HuqlQNJja68IFX9IJVJ9I
         0DSHvs/WvLDelTpgxSp+btjdA3TUzXaOrr4lUp/z2zRrV84K3Tq2M982F4JvvQMSsm2m
         Q81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720506215; x=1721111015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+oYe1ueaUtt6r/NxRQwLFx8cwsPSNkw5jKdeiGr0tE=;
        b=p4GQ/uTNPpozQ1ovhqX9VsrAYCPWPW5Y5/KT4VCa+zEWNGrRTIgy7BtYOtdEPmzeTk
         xtLQjoQUKuG3x2P739Hg4VYTgNhRmTO3zbwheZOK6m6zcvhz4IGx7m2ckvOiczflwR8I
         ylQSX4EGImZijGaIS5DmkXgOPN2XKdlfayEmPSW/dPTu324tAGJ5RnNBQEs9o1Ho8Q4r
         UAtuL3C+LPdb64Kh9MRwxexNiv6r7E861ZUXR0+A/hx2hYqJpZjBiJizz60BOEdtFPHX
         55ImPhG9usM9gxEAUXS5V8OJaGR/zWRqnhwnvaK2efcdDb9ljVaViAdHTrMyAqAiH8LQ
         aqnQ==
X-Gm-Message-State: AOJu0Yz5ZGURyj/kTF2W9K65JqZMYyhvpenV5c0alsfevSwLypckA/0K
	1bwu/Rs0VAQP1iMRNkJ1C4rQ4x116PdGaGjRpcMN0iBxDWORsMy5MlHYhkqXoSsR/djvDlUfNYF
	nqXOK+yS05n5L3x68DX0qG3ZwH/2Udr+Nz4lNcf+wkIwko7PI4lnrXr+ozWyTaD3u/noupzsU1v
	/ohwQAkfVts0MtEXiUlDSYOQIjJgRKlFtX
X-Google-Smtp-Source: AGHT+IHgFIgnXjbgIb4+JyYTzNZokd4+mmwdSL8ID42M2/8DLS9lDyxC3xfYhUwHmsFD8y7QOJlJ/8bUBYo=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:690c:6ac2:b0:64a:5132:c909 with SMTP id
 00721157ae682-658f167fd91mr527017b3.10.1720506214637; Mon, 08 Jul 2024
 23:23:34 -0700 (PDT)
Date: Tue,  9 Jul 2024 14:23:23 +0800
In-Reply-To: <20240709062326.939083-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709062326.939083-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709062326.939083-2-yumike@google.com>
Subject: [PATCH ipsec v2 1/4] xfrm: Support crypto offload for inbound IPv6
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


