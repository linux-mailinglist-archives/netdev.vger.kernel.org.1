Return-Path: <netdev+bounces-108363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E31923853
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18990B2419A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C9D1474D3;
	Tue,  2 Jul 2024 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uChNMWvj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCD714E2E9
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909914; cv=none; b=I8tRNEjcmkiCMHuI/rBTriq/6zPxmKeGB7Sh8351NbofjZg7kAbnbt/kNVeT9xBYOACgoCXylswu4cVQQFrRWjTvcOBMoGloTWydwelmiUKIJdQm/ZpPu0lKhKLqs8YJr6ft4CF+uFZzUJKFaGDrPHIn2TjQ0AtEqnrFCgGWk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909914; c=relaxed/simple;
	bh=t+fd8Ua0W5SAGhCz1imNDwt9NMPjurfkPT2IJFivpaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gq0GN9wKUwPnyM7ODa5RPwl8rQhfMWrlaiOhIghHgbu3HiNhKDSMzKZ9rcZq36Oif6qu1IwphibGZUJrrHl4X8ZzNDtKQy2610rS8T0jAV7KbYMA6Z372o0PiRkK4Hl3JcB8OIx22AMt2ztJqbVQWZkVDb+KveKfPMFLToYa35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uChNMWvj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64399573fd3so67265697b3.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719909911; x=1720514711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMWw3T7z9YrPkDclPYswq8+OgJBIlNt5StLoSoxGAIs=;
        b=uChNMWvjXwtCWX/UulhvhuybsG3eW3eQlcY5+wG4KC+8KGYWGUlG4RRI1D1hDhUZkR
         S3lAzTqrJSzYyVj3ULoxF7b9SjPHKQAIGIp8JTFwXdhnwFgdaOlFkTELtFkpF6NM2vCj
         pNDi4sAgWAJJyU7p96h+jlgY/uRE96AuSptyr9Mie0sorlVXP7ABE/mKIWn2OCwqKa5W
         gsjqne+ShKgMipgJxRJbEsUs+BDFTFACmBExSXvxK2sQKYcuKyw7GYqSI3yVBGHPaVdK
         HMAgrXqJTSdrHkuWXmYvYxQ1qFig3f5ezgWG1BvmczaLoybHm7qJeBBUdKL2eAC3Zo4Z
         8TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719909911; x=1720514711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMWw3T7z9YrPkDclPYswq8+OgJBIlNt5StLoSoxGAIs=;
        b=hsvukmtTpzKq+mLGGPUX8/pPMoj+K7ZYTubBvi8sbblngjcY/8MAhYhI/fQfeoTgru
         +LBLJ83tQ79FBLkNwvoPINoDJMGndq7iDsAZjIMRPrNz2iTAQpPg3CVugZf+rKaCRTT+
         6zmG2KD5JuXmte+QOJKWiauB8aXvm11yO+nm041C00UgVYons2EdeKS6gY3PrVmKrcW5
         KiI4nqXPeki2EB51gB5HehKv8GxwMGFItStH5T809TqC0GeOWt/Knann277nHmhj++uo
         lIpMbHtPuP3Cg9HlWTBOf/Jwvo1v+sdLiB6lzyrHFR6+Xay6lgAD2sEENA6tAd5RSYF4
         t0dQ==
X-Gm-Message-State: AOJu0YwrqX8zqsxGuvREdELd+KyJ3UksOx/yoTThpYfe1IWzyGKMzuy0
	yOopSD/1Tl9odh2iJogdteXn72901ddZQXxUxGDKEKdL8kwBmpJzQ9xAzTLIb1MYOlONkL6FK/o
	0Jqc4F92KDXiFi8xJ9mHtBeOYtd5XycLl01n6n/SBUnhbjtp17NEULv7p1B8oFWbnJn1djkEZHX
	GLFKM6e7kcxg1g/rkA0AcpueEB9Iu1YxCv
X-Google-Smtp-Source: AGHT+IEZC4N4N2m3Ys0gxyZ9eL2VC71+0jaGbZw3UQEuaDkka7M+y9VSasEhJW+wcxsdEJvpATVaKsKD+tg=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:690c:46c1:b0:650:a16c:91ac with SMTP id
 00721157ae682-650a17bd8ffmr3727b3.8.1719909911088; Tue, 02 Jul 2024 01:45:11
 -0700 (PDT)
Date: Tue,  2 Jul 2024 16:44:50 +0800
In-Reply-To: <20240702084452.2259237-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702084452.2259237-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702084452.2259237-4-yumike@google.com>
Subject: [PATCH ipsec 3/4] xfrm: Support crypto offload for inbound IPv4
 UDP-encapsulated ESP packet
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: stanleyjhu@google.com, martinwu@google.com, chiachangwang@google.com, 
	yumike@google.com
Content-Type: text/plain; charset="UTF-8"

If xfrm_input() is called with UDP_ENCAP_ESPINUDP, the packet is
already processed in UDP layer that removes the UDP header.
Therefore, there should be no much difference to treat it as an
ESP packet in the XFRM stack.

Test: Enabled dir=in IPsec crypto offload, and verified IPv4
      UDP-encapsulated ESP packets on both wifi/cellular network
Signed-off-by: Mike Yu <yumike@google.com>
---
 net/xfrm/xfrm_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index ba8deb0235ba..7cee9c0a2cdc 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -471,7 +471,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	struct xfrm_offload *xo = xfrm_offload(skb);
 	struct sec_path *sp;
 
-	if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type == 0))) {
+	if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type == 0 ||
+				      encap_type == UDP_ENCAP_ESPINUDP))) {
 		x = xfrm_input_state(skb);
 
 		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
-- 
2.45.2.803.g4e1b14247a-goog


