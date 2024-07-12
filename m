Return-Path: <netdev+bounces-111016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D1B92F431
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 04:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4A51F2307E
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB08BE65;
	Fri, 12 Jul 2024 02:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkcKlIId"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16F7BE40
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 02:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720752704; cv=none; b=Yuwe28QRZerXJsXXWSkQ/6/+kY9iydsDMDjIrvr734ePsqEIbsdN4vtwd4FdjASlliUq0yq7XtbLY7QDIu74eDRwFJbnMXtJ/k/bIFBjPgIQZq5mwE4uavOYBICufuGh9tfTzIeH+rWc4RfAcG4PQ9cg5vO87AYM2eByUVHtyes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720752704; c=relaxed/simple;
	bh=KzNQ/JAc7m3NmjSvt2TaE6f3Tu+ksYFmjFxXU0iWeNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HdBzdvM1TKQWf7ek/Q1zanaFk+oVGbXTaYrX2L1+DqwCHt7sWIQNp6GtIQnESu5mm04x8Nx2L5+m4OCU4xKu6zjMBJL3J7s6jMB033MnFGaP5dpnxSwziZdT9ZYE8Zr8yZE+JOFNQUOEKdSr1CzItNy+jW3lqxryaEZAwdsbRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkcKlIId; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e039b77a040so2688539276.2
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 19:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720752702; x=1721357502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUpyRGjVKLo3p04NVoy1/q9o2v0VKpGzpXTNtobgiho=;
        b=fkcKlIIdhdgzfssyodKrt93UzC9Xk/qDbd7ni4CDHmm80EAMrXqvJcqDRkaAz8jUfm
         d18px2+f0Qrr6aPOFOf4DF0bG8+oQVZGxtlXlNSQIy56HK4FTRM36r2pV2asByfhVUx3
         hWNUbe7fFYeWbvqNTfSubfRqCnoEiXWcsdFc0dpSKvalnzUvl69+AEiHIKSvwkeQzmsJ
         lSKIMt0mso0vq46IHlcpw/gaf6WYvGaW/QvTQTdSWKm2CDiSJeOI1IsEAuYDOZGSxD1S
         zFVnL7dHzBokDj+aROqMwWXVQBWe+K8Fw1C3Jh7AjAJBbfALoG/4k+E77phXjG5Tl7dN
         gWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720752702; x=1721357502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUpyRGjVKLo3p04NVoy1/q9o2v0VKpGzpXTNtobgiho=;
        b=khofcJxA/ycvM8miq30Drp7zJfkNtch48gUURyCdTaR40EhTnCNeQjF1DupVTUbPv2
         990Mn6COq2CMhJ9YVGX02tl/VQT0CiapqutcLl6KMhBrtKq/ouHD+sro7xogyzlD61TO
         hSNInk0ABJ3s4IQH6KbEodYfbQLX4WS2WtVcR/Nl+BWuXpiU6pMZ01zCce5eGTzO8oeK
         w+BeO0FBdYlgpgQZ55J07+EvA13QFN18tnPwH6ECSuvjl50y6w2FfNdyGNtZn7/rZ0cw
         Uwpw63zWa9H1lALqS9bLfx41DBPiAzSusqyzmXuhcrcHTfDaEvlVGdXqw4OoxJhzLA0B
         9B4Q==
X-Gm-Message-State: AOJu0YxyRGG3M3TWTLdFu6+5Gyx6kO1QgkAr3QRBfiH5lpdY+BFdGaAO
	2DtOdezelz/L2eAdmVrHrlwDVUcxiv5zy3zw08LfRmSbES2/kHX0HERyqxHDUk7/9vCIO+m5sZ7
	hrrfpHyXMj901eUbF2cWHBo3e9Bb6B+15Jv1y9ZabPJCtMSmag8QDAcvd7OHTHx+2Bpry7sJHJ1
	hP52knJnklgwsxDBSZMchfZeFsF86/vmcY
X-Google-Smtp-Source: AGHT+IH3i3e4oMr0q67oCSQhwwyCv4eYmVeXlBXng9lQp3VvaTZqsRklaU8og1BSMFRYzcdtuj2/KEzIZLU=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:6902:a07:b0:e03:5dfe:45bb with SMTP id
 3f1490d57ef6-e041b14c6a3mr691938276.12.1720752701858; Thu, 11 Jul 2024
 19:51:41 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:51:24 +0800
In-Reply-To: <20240712025125.1926249-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712025125.1926249-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712025125.1926249-4-yumike@google.com>
Subject: [PATCH ipsec-next v4 3/4] xfrm: Support crypto offload for inbound
 IPv4 UDP-encapsulated ESP packet
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
2.45.2.993.g49e7a77208-goog


