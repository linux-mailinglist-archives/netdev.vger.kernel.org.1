Return-Path: <netdev+bounces-189279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8160AB1759
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150F552647E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FCD21B184;
	Fri,  9 May 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="a017gpXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D8214213
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800863; cv=none; b=j6dZs9wEyVj6h+Ygd2rZJwSkfWMGOef3zGFN5r5hro9pph3TvZkHQsU6HXpuR+lZXhDF5JjmuK4jnrlgYa7qP5ll1sZbrJ/WXybjN0OqSeg23aVOwO1M+2BvyEbMVi1bnG2Pr62ODSggmLLXP1EwITkV7XdsQCHmSDlj349lN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800863; c=relaxed/simple;
	bh=KEaguMuUey5s4Bl11JElntmppu+Ttja7J5l3mlz1/Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxUft6fCDa1vjwjDEyTVLftKbJoiRwnt4y6IARxoPrOJoishNeqXtHjKtQDK4plt1EFFoi32YWckpNW6JEkde3upqxhQlYvSDPL9LwORBkY1bRVUkk+6FZ27IvNgHnnrWICF3U8K7mRpTXkE3EY/FVKn4rOhGN5utZKhgNn6lfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=a017gpXJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso14290455e9.3
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1746800859; x=1747405659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRFHsicFwyoNEdZOjdZFDsX8beYwn0Nw+TkhpOoc1EE=;
        b=a017gpXJapediEwybO6CNwjcAZ4ZjC58BJcIRgTPH1An2afuxLThCGib9ZouXDG3T7
         tMHkjEbFm/vO9oHMuP2+bri8shLHiQ2k8dyyOJmG7Mf8dblfC/7i5tK3ggejV1fvPF7S
         8itlRK+0ahPei473zHQz/y81bhFSpEeoTYcqvEhxyovgS3UxYIVPEATCjMIXfldVLNuU
         iL/90x81spuPy+cVFfa2Bw+ZcpTcUBOsO4l1FEmzuoMIOwn6AjzaXuUGPiDnKukH0u36
         y9Y/zYbiVyXd3tKlYzBLJ+tV7g2ZjXg+oguV7ses2aqLewU9F0YGVtlKAXHWcjIfZ2fG
         OtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800859; x=1747405659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRFHsicFwyoNEdZOjdZFDsX8beYwn0Nw+TkhpOoc1EE=;
        b=VaJxFv0/GBdszUtOn/qJntEY6Hs7oxVRHmaGkwAOC77ScaciR9IRhmFs9sKtVfDYjg
         c+sU/LnY4JfzD4TltUgQInU8+rxRYnXOEMjzxWaPiYdn33AttEILEtMXzjYgajjzyesJ
         JPXzQ0b2F4dr/hOVbKE+7jjfE9CzDXU633ZUfYTCbvXHa+hv/ew7LrywuYGQmsqfJNkJ
         FmKdiNiORlkuTGP9kV1s0o1l3PmBOtsJbgBbtaci0acf2+OnZOjVZSbLxuL9wfbvEXA6
         O7N3+VH0TAZBu4Ue5kHyMdTqYclURGRIfC3awewnOKWemnsFCJ7Wu8I0Omw1fYfW2kJK
         Of5A==
X-Gm-Message-State: AOJu0YzUvqWPFMqploSW548LaZyxvblOM8Oaf6Z7yv0z0rURewaQdCIS
	Y0UcYpP+HhlpQnhcftsOgOTM+tG0XpZ2tyH00aZeZF2YHMhJ96CWcRQW2jW1kdTZ+gpvFrcpsyo
	fMP8DY5UNLdBc3JJkgO1I7eUPJucaD0PJl9Aum3aE5a/O+xlnQKRrwrcAifgl
X-Gm-Gg: ASbGncuv7482x8QehHawmBWb0DVKN1ZLezVA93QG7GZKojvT8HWYzYF9zw7djVLbarG
	1jtpuYTue4txzm0knjnWhKt2aX1V1fF05a622rdKVmhFDbtZ0scoSCDRHvtB387XJfWpOppVmDd
	7mYkNC2kBbN97h0s0eTN1WFS/48dlO3KwGF++kWmYIP7Av9ttJ9M9tdHbRQYvfpwBeapnLg6y7r
	hMeoaPh8sf/gBxX9Rnpg5KSPhjjzKAhbpyhVr5ZW31W6P2NAmZ0G20Pptyzls2O732SNVx/CZC+
	Kg+nBhubE8JnVFSkax4m+tZfD/D3iqJaELEUuvsWIo6sPxKtvCg1sc8baqSiggo=
X-Google-Smtp-Source: AGHT+IGs6YNEMIXuKCRIhdvDmc0ExmZkLkgGypnGsXJBb4lIRqoOjSRCqMHmYSlXt/85G7+DQOuG0g==
X-Received: by 2002:a05:600c:609a:b0:442:c98e:79ab with SMTP id 5b1f17b1804b1-442d6d37991mr33405625e9.9.1746800859230;
        Fri, 09 May 2025 07:27:39 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4ed9:2b6:f314:5109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdd6sm30905025e9.38.2025.05.09.07.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:27:38 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>,
	Gert Doering <gert@greenie.muc.de>
Subject: [PATCH net-next 03/10] ovpn: set skb->ignore_df = 1 before sending IPv6 packets out
Date: Fri,  9 May 2025 16:26:13 +0200
Message-ID: <20250509142630.6947-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509142630.6947-1-antonio@openvpn.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv6 user packets (sent over the tunnel) may be larger than
the outgoing interface MTU after encapsulation.
When this happens ovpn should allow the kernel to fragment
them because they are "locally generated".

To achieve the above, we must set skb->ignore_df = 1
so that ip6_fragment() can be made aware of this decision.

Failing to do so will result in ip6_fragment() dropping
the packet thinking it was "routed".

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Reported-by: Gert Doering <gert@greenie.muc.de>
Tested-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Gert Doering <gert@greenie.muc.de> # as primary user
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index c9e189056f33..aef8c0406ec9 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -262,6 +262,16 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	dst_cache_set_ip6(cache, dst, &fl.saddr);
 
 transmit:
+	/* user IPv6 packets may be larger than the transport interface
+	 * MTU (after encapsulation), however, since they are locally
+	 * generated we should ensure they get fragmented.
+	 * Setting the ignore_df flag to 1 will instruct ip6_fragment() to
+	 * fragment packets if needed.
+	 *
+	 * NOTE: this is not needed for IPv4 because we pass df=0 to
+	 * udp_tunnel_xmit_skb()
+	 */
+	skb->ignore_df = 1;
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, udp_get_no_check6_tx(sk));
-- 
2.49.0


