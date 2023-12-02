Return-Path: <netdev+bounces-53268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A76801DAE
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 17:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0531F2108C
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6151C680;
	Sat,  2 Dec 2023 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyQXXHDj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8897CEB
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 08:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701533696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d20ZhiqnGqdkMktjpUNLxnQJIPIANFRSnbo7tB7yeNg=;
	b=CyQXXHDjMRle7eh02tO4/Tdo+UVXgGzySfvCDTDEJSCeN4LHtts65xvgI+7JaagGK70iOo
	vyn+XDIfYbfoe/aXVsRtyaPNhXcdkDH/T/vY+TSnGrXn6ycsFeN2J4KPfE/rJBiUkdYBnl
	DtDbQHrfQOdFC+Mr+N96ECaaY/Xp8cM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-FeBF66QRNfmMfQHSsKfW6g-1; Sat, 02 Dec 2023 11:14:54 -0500
X-MC-Unique: FeBF66QRNfmMfQHSsKfW6g-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ce1106393aso837211b3a.3
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 08:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701533693; x=1702138493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d20ZhiqnGqdkMktjpUNLxnQJIPIANFRSnbo7tB7yeNg=;
        b=Mj9GtflEXei+4uWz8KetGMC1hjW9PHqRXRJSJRC3NEPVy485evKbtTTpSge5B7DUUq
         7v8U/HQTviUBJoxmmsxtSvV20i2Of5tEV7KvnmpNawB++jj5jPZD79vIaueTUAdig+0y
         piTfwJqV5Tunt3/jR4tEsbAGmNdY2AYTd8+R1B5BpUbTvDrWdiCaXT7fMhK4xA2qG//k
         8NbwbtGN0R8zIxdcamn1JzW3rGQnXTP+aYwhVFFtqsHIJqw8HLjZdA5U9fDDBaeeCOnJ
         NZuX25ajDu/kbtomnyQgll176as21PzpeFDQzT9yIDQw/TI4x1/4BEFupc1xoxkBEr8L
         6kDg==
X-Gm-Message-State: AOJu0Yz6JBoYTyDuU+F5sp1yKkyPW7RXFMbnbh55zbDWFuoQdcbeU0WA
	3rPQOf23tusIcWQV2aAHol+DXvWBjCTTGSqBUCzij4ZZN3r5XuDGt5WojQYxPM88z62h9C0K4KL
	SjXvdj8UT2NjvRADD
X-Received: by 2002:a05:6a20:9191:b0:18f:97c:823e with SMTP id v17-20020a056a20919100b0018f097c823emr624398pzd.72.1701533693139;
        Sat, 02 Dec 2023 08:14:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfFdY/i/DZ0sRJ9+sag4VgIi2E/F4EvzI9yvvPSiinv1XbXACUpSJRunNxi+YJ9YEykL4mJw==
X-Received: by 2002:a05:6a20:9191:b0:18f:97c:823e with SMTP id v17-20020a056a20919100b0018f097c823emr624383pzd.72.1701533692823;
        Sat, 02 Dec 2023 08:14:52 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id g34-20020a635662000000b005c19c586cb7sm4871533pgm.33.2023.12.02.08.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 08:14:52 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net v2] ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()
Date: Sun,  3 Dec 2023 01:14:41 +0900
Message-ID: <20231202161441.221135-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() returns
true. For example, applications can use PF_PACKET to create a malformed
packet with no IP header. This type of packet causes a problem such as
uninit-value access.

This patch ensures that skb_pull() can pull the required size by checking
the skb with pskb_network_may_pull() before skb_pull().

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
v1 -> v2:
- Change the title
- Update the code with Eric's suggestion
  https://lore.kernel.org/all/20231126151652.372783-1-syoshida@redhat.com/
---
 net/ipv4/ip_gre.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 22a26d1d29a0..5169c3c72cff 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -635,15 +635,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 	}
 
 	if (dev->header_ops) {
+		int pull_len = tunnel->hlen + sizeof(struct iphdr);
+
 		if (skb_cow_head(skb, 0))
 			goto free_skb;
 
 		tnl_params = (const struct iphdr *)skb->data;
 
-		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
-		 * to gre header.
-		 */
-		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
+		if (!pskb_network_may_pull(skb, pull_len))
+			goto free_skb;
+
+		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
+		skb_pull(skb, pull_len);
 		skb_reset_mac_header(skb);
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
-- 
2.41.0


