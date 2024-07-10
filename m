Return-Path: <netdev+bounces-110548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C492D078
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE021F21883
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8665C19048F;
	Wed, 10 Jul 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSCkCJiJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A519049D
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610241; cv=none; b=Mz6Li6hAE6QX5UYazH/F2mnFaB7THNaDIMuB13/wqbzu/vaPY3exzIKXt8SrHF4jp1Dqci+Qr4qqm/TEYuvPnr/90SL2SVWBSvHnYZ4/UILJnjhQQ5c3emEa4PGvBoJu4JsvDghD0w8KkMabl2zCd/XMMBU3cpHtQ7gMLTy+ui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610241; c=relaxed/simple;
	bh=t+fd8Ua0W5SAGhCz1imNDwt9NMPjurfkPT2IJFivpaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i4xKYesfM+uNY0YR3F5Xno198WEo2h98oT1OVWI0O85f35KJHaxI/jm+mLsiU+QF6k0OpphBVTjlOO1fn9RKgQ9y9KvewFunQGBBt7StIx873thkXVexFVU0xlLiPtd/9SZNnm18s/2VFByt8aMET3r94A3Pln8zpATeuyUwZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DSCkCJiJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65026e6285eso102100167b3.3
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720610239; x=1721215039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMWw3T7z9YrPkDclPYswq8+OgJBIlNt5StLoSoxGAIs=;
        b=DSCkCJiJUXnGoEi2cN+YFMefYq82ioB/1C7iy5tSezQAq1tfx25pemJuIVB31lFIxD
         HsPMkJpzk3txlKY6f/zOXJWRtYoE56o0WPl4VGGJTuJJRewgmoln9MzK1R7U7zYaEM9s
         J8y7e4JS4f7UiZyNt4SLUUAZUN9Fvs4pAtBbDmxFrceTeVISCCltKUAZc7MSL0uxSCL+
         Hfsi8DmW8myN1vm8dXBifd3r/erw4rlnHt5jVHWQzKpPE8DFnqnVTKtphpcvn9E67TJx
         417bxMBo8TjR94q9A7U4hpu6dSVpxRNjcEq9H3b9xDJ0WdDIBngf2sGkYIah/tbwCEct
         cZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720610239; x=1721215039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMWw3T7z9YrPkDclPYswq8+OgJBIlNt5StLoSoxGAIs=;
        b=kfwmN8zrGUTIa3xZIZsbD1R3ijmsH4qb6R+O4S8n+gqCiX4+40B//aWoW98uzwB6/j
         b3UM0gvmyYdH9lq3OKd99d9MA3rnAj1WBoX8KXBA6nodHNPSmXcMz9JDOQlOIymZGZhi
         7lqfMCKtG1HscJbeNqAmRt7fKkiWenxQ4dLoyP6Qs97mmJhTmnj3I1f9bnipPGmylLu6
         OLLtFxhZJAmzJAKXusqrIebw36suhn1590n1htczAEDZFkEN+VMXL50OLCJcift5MeSR
         a9AzIsjRbGbjq3cS2iT3aYO4ismZYEV3mmg4qlQULPqFUzRSzG0En8U+mKsz6MAZXwBZ
         fA4Q==
X-Gm-Message-State: AOJu0Yy3CR9kHhZqqKO7+m5brf8lsBOJZXxjP5YmNdFPZoZRDwmttNCn
	9GtGXYm1WKBS9uC+uQJXP28T+8kOIqAjW9akNdjfK5Ps+TUiGUFzNynmLMGVFDjh79rkcMDFxy7
	0lny3sLahG5kGn/PyWPGIRl2LPibvmzaPRPprNdFF6wE6EEo8ulHEvefnh71IfIes/tw+ExW0qg
	FMf8flsF0nCI7ICbfDB0q/Kpu3BmNYRdHY
X-Google-Smtp-Source: AGHT+IEIt080N0N0T4Hwcm9FrbLChwO+5DiAQLR7dNzOk6ic5Zd5ZKGLlTty6IE0+j8y0ubFVbkONdozjzc=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:690c:4d82:b0:62c:f6fd:5401 with SMTP id
 00721157ae682-658f04e51a9mr1190927b3.6.1720610238871; Wed, 10 Jul 2024
 04:17:18 -0700 (PDT)
Date: Wed, 10 Jul 2024 19:16:53 +0800
In-Reply-To: <20240710111654.4085575-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710111654.4085575-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710111654.4085575-4-yumike@google.com>
Subject: [PATCH ipsec v3 3/4] xfrm: Support crypto offload for inbound IPv4
 UDP-encapsulated ESP packet
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: yumike@google.com, stanleyjhu@google.com, martinwu@google.com, 
	chiachangwang@google.com
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


