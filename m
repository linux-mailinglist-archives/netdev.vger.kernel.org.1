Return-Path: <netdev+bounces-109346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDCA9280E3
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 05:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FD21F230FC
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 03:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F3A1B963;
	Fri,  5 Jul 2024 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="0IKqpZJg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4109F9C9
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720149660; cv=none; b=U1SYdj7xZW1AbaLEN5RIIH+YTUd8QUJqKu2D1j0Akf9/o0V1tsik99QRtzP5xKDPqUht0Bl38jlEPgWyLGtTNtdsy2MpUUPp7ZiKSLAt8CeMN6EBLyDCwG4ROIMztV9R4XNd6fa9ccKC8bp39WcZNpj3+LhBc//UrylQfQVf/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720149660; c=relaxed/simple;
	bh=8w+l88N0ay0DP5baXPiAOfw5yIbPXiW0S1kxxDfJ4g4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fn51iYwwdaMeAYnCKwKfLhWATBU8tOnLJu+JAcflBenW2kVxRGFqnvLRulEJYSTO5AvyV4/xmS9NYEVMNEKzMSydI7R/3sCpeJ4CC3MjMoPv4rp3kCCIajtH9uSoId8Z/uM4gFWXuogJVn99cgQMUy0clrIxkNOlBGYudtZbM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=0IKqpZJg; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-701eea2095eso700901a34.2
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 20:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720149658; x=1720754458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4m+wLWb9gkModAj2RkagVThSSmZ6lzDQL2hRBJ4sn6M=;
        b=0IKqpZJgEb7zOeNHrzFg5EsrBTOwXBkYI3lFEDC7H5ErkPQCNXEVfbxNANom4bKzkz
         LwF33hkfzuyNTocdvzd+ipL9jtKJarKJym91341V/BNQAH2/4+iS1aMrEfFA4f9NelPM
         vzWU9zPBAIIGdfzjaScIgKZvB2BjUZMNev6yA8zQBsgiqsZULLZiNnhL5jguW+N9b2Hv
         m4D+8kWUWyjOfypQiT0rvBzb8jDW8FmNdc7iJUhp9Sms+AqR94AmpktwfqlB3gPLG0SC
         MTc1VQsPgAOdRYABuk3AO4OpviYbb8maZfCUAiSc75IOL5XnlLVg0IIE0UQpIeT6zDiv
         x0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720149658; x=1720754458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4m+wLWb9gkModAj2RkagVThSSmZ6lzDQL2hRBJ4sn6M=;
        b=QFTsFgW/9TOdqelrlk7hMQU8AuFOrUIBlbEQlD6jDcCDl5jdjy/ZeW2Lbdk5R7ozju
         Q9JZeEfLJ2PniofH1TJQJxPykHrtOvUKiEv0wxpG+1GsAkCMTlUWAbkmOGtRG+nrMgwo
         DJBrUTvmHZ/1PQ62qyTRoM7q67YA9Zl1nKcjVeniES2yrqUFhaCRbN/heMHqYG+iK/Od
         O8y+U/YCVg2IAAY3pp/jpty7x3ZcSPAfcMoOoJ0U+KdYKHiwmgpA9QmTAzs8tXgkQfuB
         tTBnT/6iIpCyO1qX0skUU/XfEEc9fT3yIwmUoBBFgYYPV0dnVjibD2v00SEunbtIcrLf
         1rxg==
X-Gm-Message-State: AOJu0YxaqMjrtr5lDWH0vnJ+K11m2lRQwpfrAfWIkDfSsCfkk4g+6u4U
	ujhwHxrswPVIG7chiAVrUmVJXV20YAhWqQ4Aa12TpWMQtYdSl+6yZ/kAHmaYnhE=
X-Google-Smtp-Source: AGHT+IFn2XdhgB88bdLcHkqaGNa+vFp/NLHEl4eeGjUKhR5UGYOLVChbMaJJftp5OFbUBLt+g2QsXg==
X-Received: by 2002:a9d:7382:0:b0:701:f4b0:bef9 with SMTP id 46e09a7af769-7034a74cdebmr3575073a34.14.1720149657296;
        Thu, 04 Jul 2024 20:20:57 -0700 (PDT)
Received: from echken.smartx.com ([103.172.41.204])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70afaa8126dsm2433163b3a.197.2024.07.04.20.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 20:20:56 -0700 (PDT)
From: echken <chengcheng.luo@smartx.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	echken <chengcheng.luo@smartx.com>
Subject: [PATCH] Support for segment offloading on software interfaces for packets from virtual machine guests without the SKB_GSO_UDP_L4 flag.
Date: Fri,  5 Jul 2024 03:20:48 +0000
Message-Id: <20240705032048.110896-1-chengcheng.luo@smartx.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running virtual machines on a host, and the guest uses a kernel
version below v6.2 (without commit https://
github.com/torvalds/linux/commit/860b7f27b8f78564ca5a2f607e0820b2d352a562),
 the UDP packets emitted from the guest do not include the SKB_GSO_UDP_L4
flag in their skb gso_type. Therefore, UDP packets from such guests always
bypass the __udp_gso_segment during the udp4_ufo_fragment process and go
directly to software segmentation prematurely. When the guest sends UDP
packets significantly larger than the MSS, and there are software
interfaces in the data path, such as Geneve, this can lead to substantial
additional performance overhead.

Signed-off-by: echken <chengcheng.luo@smartx.com>
---
 net/ipv4/udp_offload.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 59448a2dbf2c..6aa5a97d8bde 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -402,6 +402,13 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 	if (unlikely(skb->len <= mss))
 		goto out;
 
+	if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
+		/* Packet is from an untrusted source, reset gso_segs. */
+		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len - sizeof(*uh),
+							 mss);
+		return NULL;
+	}
+
 	/* Do software UFO. Complete and fill in the UDP checksum as
 	 * HW cannot do checksum of UDP packets sent as multiple
 	 * IP fragments.
-- 
2.34.1


