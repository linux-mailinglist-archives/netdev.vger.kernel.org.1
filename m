Return-Path: <netdev+bounces-154655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493E49FF4A1
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 17:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2614C3A2801
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1546B1E2007;
	Wed,  1 Jan 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhrWZ7B4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E532942A
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735750157; cv=none; b=I+S7+ZeChyWjTp9pbw4hbkJ8u5aurgMjmWCWcQb0gf5o7hA/TnyTRDY6VpqTGQ9K1i3ZdaXNFofoM0a4VZMHc+6zGdXN8TTuKxy9ooWw0IzPhp/f+e9TC61p6bwG6rdh6H1EBZhzt34jLUTz7AbsHPW0/aHKPR7Tq1QJtvT1/Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735750157; c=relaxed/simple;
	bh=tZyWw7xwEtiBL0b3CVSNCWhqefbflEF125wSjMHAzK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N2j8YIGzFhSICl8qz/YjPjhIhODhZeAjuIceTW4vVWaCRBTy2jQgXarRJezLmTDSVz4SGeqSNIa2DIUOkVI7Nf/66NKs1p1hAOqwwDcd3XcvUzDWlk0EcrHtEiY4taIqGmsHkOxW0YLC4+UX19Vh4AGrsGIfMhitVICbQ9P8d3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhrWZ7B4; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d92e457230so104490166d6.1
        for <netdev@vger.kernel.org>; Wed, 01 Jan 2025 08:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735750154; x=1736354954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jffnTO7DJJ2mWyK6ssB59qij5hj2LlXR59zVUQmfKJs=;
        b=dhrWZ7B4zfbC2ml5s2V60IRcfA+VugQpdXozIRczgSEDZ5PdKSyBlRkkcBq2A2wIGY
         s5bh1VtbUKiveJUbqsKWfO8S4Fx4cE/2t6kzxdEBxKRz5xNLTuPgGVsiMIm0jXZTxSsa
         XJz9Jao8nNNmusaTBetr5cwdvjurR/Sf7B+TieGMHWK2cYYkyg9eWptHc1MoFnW1aqEJ
         tJ/VyvK7BmldOHBCZb0UYX7qr7P/cl6Qr1F/e5Jy2v0PjhXsE5mC2fYjRFcGG/1c8NQu
         pzo5jdXbNYO4MtwBNGebA2kbGRNxAKyS09kpQqMc/iQjRQQubjU4LELmLiQaCJo4W85f
         BoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735750154; x=1736354954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jffnTO7DJJ2mWyK6ssB59qij5hj2LlXR59zVUQmfKJs=;
        b=OvjKQlsfnKcuMkf3ItCMb2f3oF4lBvo81/yLUbocr8/0zaeLd+Ss/ufh2KCuLDNS16
         kl4xTeDTHiuRBOR+3THi2ImCb3VkGM/Wj8/E+33G3TZfZ9Ju2m6iykrHQNApinbLEYyf
         GaP3fAVAjxhGjJG6qlASfYpfsdlOqHz2G4KWosjE0+1MAe60UETXpNOpLuP+QM03UNBP
         aAPvecBIFmKWic60JGRc03TwBHwA35zsYIrOVh6uQUaUje3B7xZxmf2RhtZjzdik3N6i
         okRFpKAA17eKSGad+sstiCm7ZwO8nwIezPQkY/AzaJK43RWrF1EWawkfGYUhhzpj1WYz
         lP4Q==
X-Gm-Message-State: AOJu0Yzpx0yvJYiHxwRWG2BquVi2ameyUNjZHEjnUmCxwM1KTf4VqHLD
	JDpp1O9ZNxDdPuis2QpU5Pst9lC+oStAKuZz1qbAvRJ8B3YPdhKNGV76TlJD
X-Gm-Gg: ASbGncsWaPJYPFH7biHj32RSQGBXnMySjspJ5dWcTchuyvuWWhwviok74MmYiYxdWJ4
	ARj1ncrRh4HOMS6kjZZPmJIoJeDw0QSm/cUCE/wEXrN5hvj57202NwJc7HD23lXucHbGUmWJlgG
	rI92rcDQW/KS5eJ8UnLn/+QCMVKp1YWq/dVw0laYZfCzPvlowo9eViftEOPswCxznQJHSocMk+E
	6hXy2KDhLQhMgVBSFNET6QtE5dl7XuR6uifajamo4dudJjXwJz2GdyytYG0jAbRPOHYw7uvEwYr
	9ahbvVfiSFopgJEhIULS4fjMQ9hhE1MnNpK4w3VoN9ZEx6R8fxBEOm/8
X-Google-Smtp-Source: AGHT+IEHVlv20jiVqdahbXYy8RGYlyzoqN9wDIS4xeoaRvaHTBG3V3/VaH3wJ/YL9yettWngGiUp7A==
X-Received: by 2002:a05:6214:c4b:b0:6d8:7d6b:cb78 with SMTP id 6a1803df08f44-6dd233af5dfmr751567376d6.47.1735750154237;
        Wed, 01 Jan 2025 08:49:14 -0800 (PST)
Received: from willemb.c.googlers.com.com (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18137285sm123119926d6.66.2025.01.01.08.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 08:49:13 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	benoit.monin@gmx.fr,
	Willem de Bruijn <willemb@google.com>,
	syzbot <syzkaller@googlegroups.com>
Subject: [PATCH net] net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets
Date: Wed,  1 Jan 2025 11:47:40 -0500
Message-ID: <20250101164909.1331680-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

The blamed commit disabled hardware offoad of IPv6 packets with
extension headers on devices that advertise NETIF_F_IPV6_CSUM,
based on the definition of that feature in skbuff.h:

 *   * - %NETIF_F_IPV6_CSUM
 *     - Driver (device) is only able to checksum plain
 *       TCP or UDP packets over IPv6. These are specifically
 *       unencapsulated packets of the form IPv6|TCP or
 *       IPv6|UDP where the Next Header field in the IPv6
 *       header is either TCP or UDP. IPv6 extension headers
 *       are not supported with this feature. This feature
 *       cannot be set in features for a device with
 *       NETIF_F_HW_CSUM also set. This feature is being
 *       DEPRECATED (see below).

The change causes skb_warn_bad_offload to fire for BIG TCP
packets.

[  496.310233] WARNING: CPU: 13 PID: 23472 at net/core/dev.c:3129 skb_warn_bad_offload+0xc4/0xe0

[  496.310297]  ? skb_warn_bad_offload+0xc4/0xe0
[  496.310300]  skb_checksum_help+0x129/0x1f0
[  496.310303]  skb_csum_hwoffload_help+0x150/0x1b0
[  496.310306]  validate_xmit_skb+0x159/0x270
[  496.310309]  validate_xmit_skb_list+0x41/0x70
[  496.310312]  sch_direct_xmit+0x5c/0x250
[  496.310317]  __qdisc_run+0x388/0x620

BIG TCP introduced an IPV6_TLV_JUMBO IPv6 extension header to
communicate packet length, as this is an IPv6 jumbogram. But, the
feature is only enabled on devices that support BIG TCP TSO. The
header is only present for PF_PACKET taps like tcpdump, and not
transmitted by physical devices.

For this specific case of extension headers that are not
transmitted, return to the situation before the blamed commit
and support hardware offload.

ipv6_has_hopopt_jumbo() tests not only whether this header is present,
but also that it is the only extension header before a terminal (L4)
header.

Fixes: 04c20a9356f2 ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
Reported-by: syzbot <syzkaller@googlegroups.com>
Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/netdev/CANn89iK1hdC3Nt8KPhOtTF8vCPc1AHDCtse_BTNki1pWxAByTQ@mail.gmail.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 45a8c3dd4a64..faa23042df38 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3642,8 +3642,10 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
 		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
+		    !ipv6_has_hopopt_jumbo(skb))
 			goto sw_checksum;
+
 		switch (skb->csum_offset) {
 		case offsetof(struct tcphdr, check):
 		case offsetof(struct udphdr, check):
-- 
2.47.1.613.gc27f4b7a9f-goog


