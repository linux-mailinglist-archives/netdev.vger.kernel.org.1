Return-Path: <netdev+bounces-114637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195BC9434EB
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73BAEB2145B
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168EA1BD4F9;
	Wed, 31 Jul 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="AMiAmgjc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551E61BD004
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446635; cv=none; b=h2y9B/HneX4LbWc/FwANy550gUx/1h8RVBEYOn0U8vrW9thjNr8/By5bjZqtKfUt19pD700xcVXj796cOJg3biTOTP5jruv7AM9XCgfjmLfR0DZmMxF/DyEk4QsXRC8UUbeuaYKBY6bqC4//eYil88zngaWEYVlDjHNWGRUf8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446635; c=relaxed/simple;
	bh=UjjMjEIjZ/P6a7VI25jpnfNez4v3VskRw73WlLvw1/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GlhPnbobwws3FXgWb4Yj1YCvrjr5rUHwGJ2aKVbUfibFuIZb463wtCCkArl3GOGei10UZsFKxxCRYyAX5PoQFTpodnyW74ywSygOeAAdK6GWS6eUrWKtFUdkDYla58O4tUFgnqLb8tnHcsjj4Q8llPbesrrNofZJSkHlkgBsMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=AMiAmgjc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so2074627b3a.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446633; x=1723051433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tN7sl7gkDooNZGfuikETnahqgb0UIgEa7LSKuUv2JSU=;
        b=AMiAmgjcY2Fr+n1cvV4Qv+VXlEepxBk65aImQc6+JcHlEJtQt016SGc0pF77Ok3YQi
         SI2AsJ6YJhsVNhLkZCOE40WulN/eifpQHHus6wLLiLyMxlI03icK5WOiDADx/Izeig2i
         cJfihaIzkj/MtEQuMN6cbDL+VrMS+HMc8ze4AyOkbFvadaw+pE47CgPr9Hj9WNc0ekPk
         Z1BEpVrX2bWEIIwb5jVSgbP124FAOkA973NjqCKzJ8PofEFMFebj8iVzdMokJngsOSSR
         xTTYjqiBwAAXOlwrifj0mXf3/Ua70PS9WDENBdCNMdT6w+iyM3ZWFfbsZZp1DJQ4s9X9
         JU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446633; x=1723051433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tN7sl7gkDooNZGfuikETnahqgb0UIgEa7LSKuUv2JSU=;
        b=OUjw7KhbdFHdeTif4U6mXzLCf8q8U5Q4OzqO7+/9tS1kFNuRHFgeWbeLbLHq6qisCL
         C/2jC3sfyJXP0qihf29MyfN3p37t3z+OtCbU6TPfFf89SXZlXIXZme7Dv7X2TJWdz+WI
         q1LunRlRJCoGnldokbcM3dIRGkVDF8aOPQxEkXMDq97SDqxZadEqzc4TQn0DgEpzUqMi
         ncTU7pmXi8FdvyPZ1dXTUJ2SbQlIySjaPvLWBhkioCrkFdJaxiYLcTfFU1fh2RpNaB9v
         0dwRGrIYt+WbPTyhoyl46QOj6dixEXlpJni74ZuP+O7bqCsXOjwjXfy9NybD83Yoh1Yj
         N0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUGn8Z1RsYYoAGqgRYwrv+fTu0NTNb+rIq1ggsDCQwxMHL2QuPIlOQFvS0RIjcC6qCK2scTZYwKARldvo/p/gH3ALHDN9VL
X-Gm-Message-State: AOJu0YyJo8VjKhPg0x5hcFhFJw7rPKqBTOmHLOC0APWuAaOtVxaUwQwP
	i7Tg68MH79kfAmSUeG36aB+Whn5uEbQUX75rZxbGgakRfEb/07BjqItA9D+x93o9MNNCJ3yu/GA
	E/g==
X-Google-Smtp-Source: AGHT+IG9CfRkfNVSAWk3X0bJWt6HSxadCd6xnLbz82/cOSwK//+l7whXEvmhGjwWO5dofUHTm9Zrxw==
X-Received: by 2002:a05:6a00:6f67:b0:70e:8dfd:412e with SMTP id d2e1a72fcca58-70ecea32edbmr17064609b3a.18.1722446632460;
        Wed, 31 Jul 2024 10:23:52 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:23:52 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 02/12] flow_dissector: Parse ETH_P_TEB
Date: Wed, 31 Jul 2024 10:23:22 -0700
Message-Id: <20240731172332.683815-3-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731172332.683815-1-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ETH_P_TEB (Trans Ether Bridging) is the EtherType to carry
a plain Etherent frame. Add case in skb_flow_dissect to parse
packets of this type

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index e034e502ab49..d9abb4ae021b 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1284,6 +1284,27 @@ bool __skb_flow_dissect(struct net *net,
 
 		break;
 	}
+	case htons(ETH_P_TEB): {
+		const struct ethhdr *eth;
+		struct ethhdr _eth;
+
+		eth = __skb_header_pointer(skb, nhoff, sizeof(_eth),
+					   data, hlen, &_eth);
+		if (!eth)
+			goto out_bad;
+
+		proto = eth->h_proto;
+		nhoff += sizeof(*eth);
+
+		/* Cap headers that we access via pointers at the
+		 * end of the Ethernet header as our maximum alignment
+		 * at that point is only 2 bytes.
+		 */
+		if (NET_IP_ALIGN)
+			hlen = nhoff;
+
+		goto proto_again;
+	}
 	case htons(ETH_P_8021AD):
 	case htons(ETH_P_8021Q): {
 		const struct vlan_hdr *vlan = NULL;
-- 
2.34.1


