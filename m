Return-Path: <netdev+bounces-97810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892A98CD573
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E9A284078
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAFD14AD02;
	Thu, 23 May 2024 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJIlhh11"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F08C13B790
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473681; cv=none; b=OyRpxH24J+wFZIKP3dGTFZG4ZBgaasW8ITIXTxk9b9cj/4s7m4PA9eq82psCIWopL48p774pa3YEIrClyzK556IsMKve0mxhzttsP/d2kYwqcD8vuze36FcfDKQTh56y5QkOg9RxGT5djwZKuuu/vW2+iIwBpkG837hCO+NDbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473681; c=relaxed/simple;
	bh=JV9uoM5FQvJqnjAV3sjLAhLXHdVnTRuwd8ibXXOKsfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYt2V7qbkJb7SXKJ+0SK/18cYxKL/Euc53vAuKyBQSKLsxR9Ocqirzk8xZC46n4nz4Ha7PCG0wBau/RWmoO28IF9kuDp0wGRdLFt8UenATm3tYJv6o0RHUwq4ZfTnXHlHIrXMwtZvZFqxb8EZbXxqvdsOwXcgKNliSxtFKj6gsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJIlhh11; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-792b8bca915so510218885a.2
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716473679; x=1717078479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruoIRsxxq78XBJFRYWM8va4yMNJ1UjHoBCVatwOWJHM=;
        b=eJIlhh11GVJq5PhJF6nZJv15CZNnPERKDRJOF4dEodBq7qxfQDmq1IVNwBFq7Xgdn2
         j1wmD9GUPikHUGOZIZ1DDcuDLYz392o/mJIy5uZxkaRTB76vcPBxJURp1n/6YM6kRPrS
         4JNRezofhWQ/FFsKeDboiGuge6IP2u/ZwRUCqFv4IoCTr4/FhCeBm9Z86SRuPzbimF4w
         Z0+Le0IfeNRpSFqIgYT7rueeMTpiqTmNiAvWBMmCK48SqHDijL6gAl1KgPx/YdGGb7tx
         7sqfxjEWI+9m5wcYCtf3E7Nrq9ilMWZ6zK34f/3PqzxEnX+tWmYlgLLKZttkKLxLPx3F
         LCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716473679; x=1717078479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruoIRsxxq78XBJFRYWM8va4yMNJ1UjHoBCVatwOWJHM=;
        b=hv/xj4JbEpCylS2/yjnK/+6NRvoEmc7q7PUOUhxz6CTcwR/WA82sxJkTO8/dP925o1
         TNXvEq8eJcnY4kN2besIDZcKPpWjGtFmN00N9bNk3A6nvllExwXPmNaev7Ku/b75YWDF
         H2SDKG2B0VAabALUUXfjAmr4ET75CHdlDPOfuTYAZkOZ1azocXiBXIBNP2jxPLszZmyS
         EIzlRMAwzrnYBUOY+OqEnjLBTFJct+dUev5EaMoNzk/KBbz6e+dEyoENnh4+18GyayGR
         GsI2/Ah3skk0oI+tfOWysk1PO1m6gSvxqhk9abBo4lND4dV50Ly/6I4hkLTdnop0tp66
         5eCg==
X-Gm-Message-State: AOJu0YwdnGKxXi5NqmDlH8R2Z5M99W51jlSSt9Xjdih3hO6fY+HHFLHw
	hdr5sGV01CEALfJ7kLXXlboTCrQnG3K2xpNYkeNOycLqkK/8KuNPjArjSA==
X-Google-Smtp-Source: AGHT+IFcvQlZlvi2CawruXrXeaZmMR9HX69MkBhC2EwpbEcrAv8qGUsbTUsH7tB+sVBnK50pTvrtEQ==
X-Received: by 2002:a05:620a:5d8f:b0:794:a72f:b6f4 with SMTP id af79cd13be357-794a72fb6f7mr104500685a.18.1716473678746;
        Thu, 23 May 2024 07:14:38 -0700 (PDT)
Received: from willemb.c.googlers.com.com (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7931777fdf2sm636351185a.78.2024.05.23.07.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:14:38 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	richardbgobert@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH net] net: gro: initialize network_offset in network layer
Date: Thu, 23 May 2024 10:13:45 -0400
Message-ID: <20240523141434.1752483-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Syzkaller was able to trigger

    kernel BUG at net/core/gro.c:424 !
    RIP: 0010:gro_pull_from_frag0 net/core/gro.c:424 [inline]
    RIP: 0010:gro_try_pull_from_frag0 net/core/gro.c:446 [inline]
    RIP: 0010:dev_gro_receive+0x242f/0x24b0 net/core/gro.c:571

Due to using an incorrect NAPI_GRO_CB(skb)->network_offset.

The referenced commit sets this offset to 0 in skb_gro_reset_offset.
That matches the expected case in dev_gro_receive:

        pp = INDIRECT_CALL_INET(ptype->callbacks.gro_receive,
                                ipv6_gro_receive, inet_gro_receive,
                                &gro_list->list, skb);

But syzkaller injected an skb with protocol ETH_P_TEB into an ip6gre
device (by writing the IP6GRE encapsulated version to a TAP device).
The result was a first call to eth_gro_receive, and thus an extra
ETH_HLEN in network_offset that should not be there. First issue hit
is when computing offset from network header in ipv6_gro_pull_exthdrs.

Initialize both offsets in the network layer gro_receive.

This pairs with all reads in gro_receive, which use
skb_gro_receive_network_offset().

Fixes: 186b1ea73ad8 ("net: gro: use cb instead of skb->network_header")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
CC: Richard Gobert <richardbgobert@gmail.com>
---
 net/ipv4/af_inet.c     | 2 +-
 net/ipv6/ip6_offload.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 86cce7e9c2d1..add3e291a301 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1532,7 +1532,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 	}
 
 	NAPI_GRO_CB(skb)->flush |= flush;
-	NAPI_GRO_CB(skb)->inner_network_offset = off;
+	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = off;
 
 	/* Note : No need to call skb_gro_postpull_rcsum() here,
 	 * as we already checked checksum over ipv4 header was 0
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index bd5aff97d8b1..9822163428b0 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -236,7 +236,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	if (unlikely(!iph))
 		goto out;
 
-	NAPI_GRO_CB(skb)->inner_network_offset = off;
+	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = off;
 
 	flush += ntohs(iph->payload_len) != skb->len - hlen;
 
-- 
2.45.1.288.g0e0cd299f1-goog


