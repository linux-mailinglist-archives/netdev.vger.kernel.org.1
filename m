Return-Path: <netdev+bounces-134200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DA79985AC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EC528300A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB41C462C;
	Thu, 10 Oct 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SNR2YilX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041A1C3F38
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562524; cv=none; b=sVVO0IQ74HsOhhbPfflabUi4tuN052cQIbN4x9sL9z8raByU9SwkE60uFzKkPSutjrDPEKcMLrWALd7C6scPig1xOY43K8qKCv6rQQ0iBUrrm1acC3LFY5rCZNqXz7MhuLRbMHYyvQ0VJXYKb8lrj2ZJFYAaNMeBkXCx3+i+dZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562524; c=relaxed/simple;
	bh=k6jsV6eAAVGv1vneV2uvgUaEC9QP+DZwtAFnnsCcVIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=niYwxyaVTfu4QW1l6DiCW2TCugsFGk+ddXREWzGOa9BoVeHzkMWNYuWvnhZ3nnX2q3pzQjqSkEVJ1R55u1QuOpr+eRmqznThM3+dh98V3lli88KzAEOzkJ1xs8np4zkpVBGFGQ8aGVweY38ZbxyYbl0V52D1YOoqktT3v9dNfNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SNR2YilX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a995ec65c35so144089366b.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728562521; x=1729167321; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTB4CA8vPwZAJs193fATKbyWYbE+AvklNbOy23zkFao=;
        b=SNR2YilX0kcskFfPT/WpiRWBoHFaZR9h0pQ5H2K+epnJ2KFAzDeG4KPYIYaEck2a9x
         bzHX/KEiEAqPIkvPmgirKgdXze57/5U/hQI6n35iqGZGx8mrvh1ZjiNgPUsqDZSWdIfH
         iNd2a6jGX5abss29uq7+3vXF30GZd0k3xYo+7IY/Kk6bKy2B0+knt8JXVz2eMkBAgSDV
         utpnLuFZw7ipyRITIn3JsLDpHAud70aZ59zzVeCyYOTkb/QhkvfEePtPRCxSsY65g/ik
         hYY3L8V9n0YL+9P9Lwsi/rR4EW7kVVfTy8ZZ7N5HHCnABdNHnt9sACkBCoirrCw2DWIe
         hQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728562521; x=1729167321;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTB4CA8vPwZAJs193fATKbyWYbE+AvklNbOy23zkFao=;
        b=LL1WWWMukiGh7UU6d+8izX+Zbs/2qbGdBU+HMogzGNKEqIEK7Rh/pc5MUqbRhuNgF3
         0tB2FUa0nXxTqm9olp7hzlknJrGj5D8vhEUGPN+V5lvmDsh/EeUh22e+LX56GyhBn3oA
         WtKpfAwVcmhXxAh9uPLGmVNGq+fFW7un7CANN0kr7ZX+2SKG+lZua/X6QE+ooVrOC7Rx
         IW0UXdmECvNEf6fVW70Iol56WOPq6tXif5rAycAWNo37RB1zdutjhDVAisgR4SSOTo13
         8ouurMP1MHXSrWZl3hmnNfcbdudQPIUPUYYuEz5VIWhbHr0OODYdv9kSMfHsW8U/cDY7
         yQrQ==
X-Gm-Message-State: AOJu0Yy1S5C+G8GtPtCQeWYS4rGQMWPTT7+JjEioHoDRRtKe5hB9+U9K
	BggKgIAYw8sCv18RsVJODHMHrCNVrYTnqZpv1iw+baUmrYfGMqbIX4bfHp+U1Yo=
X-Google-Smtp-Source: AGHT+IF57luNcC9P/84mWhp6q5rJF2Tq5Fu0EA3TARlpVPUCGQaKnGN/HFqjTdzJWhB9rZanKuPxCA==
X-Received: by 2002:a17:907:3f07:b0:a99:5587:2a1f with SMTP id a640c23a62f3a-a99a11087b9mr321198666b.15.1728562521056;
        Thu, 10 Oct 2024 05:15:21 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2dc::49:1d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dcd03sm81776466b.174.2024.10.10.05.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:15:20 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Oct 2024 14:14:53 +0200
Subject: [PATCH net] udp: Compute L4 checksum as usual when not segmenting
 the skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-uso-swcsum-fixup-v1-1-a63fbd0a414c@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIADzFB2cC/x2MQQ5AMBAAvyJ7tslWRcRXxIFa7EFJV5GIv2scJ
 5OZB5SDsEKTPRD4FJXNJzB5Bm7p/cwoY2IoqCgNGcKoG+rlNK44yR137LmubG0HsjRCyvbASfz
 LFjwf0L3vB1GTAVpnAAAA
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Ivan Babrou <ivan@cloudflare.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1

If:

  1) the user requested USO, but
  2) there is not enough payload for GSO to kick in, and
  3) the egress device doesn't offer checksum offload, then

we want to compute the L4 checksum in software early on.

In the case when we taking the GSO path, but it has been requested, the
software checksum fallback in skb_segment doesn't get a chance to compute
the full checksum, if the egress device can't do it. As a result we end up
sending UDP datagrams with only a partial checksum filled in, which the
peer will discard.

Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
Reported-by: Ivan Babrou <ivan@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Cc: stable@vger.kernel.org
---
This shouldn't have fallen through the cracks. I clearly need to extend the
net/udpgso selftests further to cover the whole TX path for software
USO+csum case. I will follow up with that but I wanted to get the fix out
in the meantime. Apologies for the oversight.
---
 net/ipv4/udp.c | 4 +++-
 net/ipv6/udp.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 8accbf4cb295..2849b273b131 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -951,8 +951,10 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
 			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
 								 cork->gso_size);
+
+			/* Don't checksum the payload, skb will get segmented */
+			goto csum_partial;
 		}
-		goto csum_partial;
 	}
 
 	if (is_udplite)  				 /*     UDP-Lite      */
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 52dfbb2ff1a8..0cef8ae5d1ea 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1266,8 +1266,10 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
 			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
 								 cork->gso_size);
+
+			/* Don't checksum the payload, skb will get segmented */
+			goto csum_partial;
 		}
-		goto csum_partial;
 	}
 
 	if (is_udplite)


