Return-Path: <netdev+bounces-225617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F7EB96135
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4B52E60C1
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C731F4CA9;
	Tue, 23 Sep 2025 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzWTM1XG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32021FF49
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635308; cv=none; b=TBkwlsTH+ZihcFov2tC/d+Jb2xnO0ldVTuWgDB5KDRZ3Lo0YaBQKQJMcl8cY5STYy9RQ4jUUMg0c0UlJA+m+Tiq1bIFDX5quxDCEHcK/H3dDcsHOXmbRGFms5VudwWh8SqfCAndjN3v3QV+vTrLiKzpkBKTFUghLmwWE2IeS62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635308; c=relaxed/simple;
	bh=FSqoWvljkN4T1bYgbZ9j9xN1ec1+5KSfl39HurSjM1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vArBQy88rTtCg1r3WpjRKHLTBjEzp67HDlet6YFIvpY+BiCKYMa/4aIJucGRM5BvxLNPVy+gv0bsskCuSAzd/HVZZunsuz/Q/J619imI7u8dL86UOsfI4miZ1opZv15J6tsC32v40Ral/2Yx2/n4UIqcc6MqpZCyGnQZAhoJd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzWTM1XG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee12807d97so4886166f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635305; x=1759240105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXjqN7cmrwVKRNa2A6lB1GJSdVXXqCKz0INEUXmns1o=;
        b=PzWTM1XG01l3ONUYRWmqusI8TLBUABTJxnwx84aTxb5YRkuR5YjMbGNHl3NmhkNhLR
         0+j2pxBuC2A/PSG76iOS+tGQfzMp6jewroeTjXEnNPjAosWUbhyrOdvjTtUvARAMhovf
         aNziPrW8CuQM8c/elvGyhi/lT/8kC5DZ5pNzEf5VCAZWqL9A1Jk7rc5ohKvF5nMgjnMr
         JJlFxsS7dqykiNj12lzqsap5NEHIp3WM5ykk0rJgq6WHoKXdZGeu5Fr54Z5vWqBZlM2l
         SyiKee4TdUIeoopqKGHABKcnZOLzOFKBUU5tGku/YSVkaxVA9HUn49zWPMAfk//tx/Kw
         JL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635305; x=1759240105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXjqN7cmrwVKRNa2A6lB1GJSdVXXqCKz0INEUXmns1o=;
        b=SUWO2Y236zgCWGwzAwvwLoKR8Cr/QsjEt9wrfSVf+RAJ5Tp6cCOqKJWfBbFtgmeit1
         nz4IB5jAfieqffYtMJnrpQ1h190tmvbWNb7ZZRWowgU/PYKPbMRpLYn7sY63fHfsLaZ/
         uEfcIH3uyqyi3Ev+2YdqfrsOsIBSzgvy1yCKw5qiWEImRxan1rT7DkxI7/DXEg1cGZlH
         Oinz/wknUrFdoZAw5x37torLBay8x5Rop4wlZoSJbCQ7zwzgNAjDoWak6MlHF8svlfam
         xuGxvBs18INml3m5XMrEbvqYSTB0DUIpQzOOpKukyKVI/HtsElERDIqG0uJPBUFesXZe
         SQWw==
X-Gm-Message-State: AOJu0YxlTPayGlWTeHwhIhUeeUJctR+bRltwtBrzHPO7btp856Bt0s12
	EP6c9iQmr0PO61WrP3xarKLLFJ15arrrCm3CfeOYmEaF1VmZjAL+L8fi
X-Gm-Gg: ASbGncsFMvrfe+lm4XTTj9p293SxIySPXOM3i4yfMr8uruPjgDJ52cgcX219tdRxDGf
	TzB9U0vlPs8WUF8iYSqeCnCKf5DbofyZJKjdn20NiuRBru81y1QeVkF+K5vw6XMCPq640pKuhl1
	zHhrFEOSdo/QKBBwKILDVNN9JqlqMxlM2RvxbstJ6iLTLgnil1HD0qUx68OGCs6XCrNmg1fWyv+
	BdXHh4zOUPnGrTngKvB27Iie9NL/JEEoVwD+XA5wuG4lOQBeDBUbV6QIcm8KKofS0KZYZDmugzE
	/WRJAgAT/tfJr6DAoBVGixFFfxyJ5le7kLDtV/nnv8q0LtOSAEfSny1gA+oHddKOLY40MYvQosL
	wVKQ+n506npiV+EoUErquG9bsXGw87/mYmKPZjHrz0sma/QdNZmmaJViFmLg=
X-Google-Smtp-Source: AGHT+IH5Rlerk6VPq2tFpItYvkdsqS6iXifb0UDk9/42srwLla2PvoM1F8FZ66QUxqu9pxxTYlQH7g==
X-Received: by 2002:a05:6000:4024:b0:3d5:d5ea:38d5 with SMTP id ffacd0b85a97d-405c5eb6416mr2465527f8f.25.1758635305148;
        Tue, 23 Sep 2025 06:48:25 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbd63a2sm23878875f8f.48.2025.09.23.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:48:24 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 14/17] udp: Validate UDP length in udp_gro_receive
Date: Tue, 23 Sep 2025 16:47:39 +0300
Message-ID: <20250923134742.1399800-15-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

From: Maxim Mikityanskiy <maxim@isovalent.com>

In the previous commit we started using uh->len = 0 as a marker of a GRO
packet bigger than 65536 bytes. To prevent abuse by maliciously crafted
packets, check the length in the UDP header in udp_gro_receive. Note
that a similar check is present in udp_gro_receive_segment, but not in
the UDP socket gro_receive flow.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 net/ipv4/udp_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 1e7ed7718d7b..fd86f76fda2c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -788,6 +788,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	struct sk_buff *p;
 	struct udphdr *uh2;
 	unsigned int off = skb_gro_offset(skb);
+	unsigned int ulen;
 	int flush = 1;
 
 	/* We can do L4 aggregation only if the packet can't land in a tunnel
@@ -820,6 +821,10 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	     !NAPI_GRO_CB(skb)->csum_valid))
 		goto out;
 
+	ulen = ntohs(uh->len);
+	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb))
+		goto out;
+
 	/* mark that this skb passed once through the tunnel gro layer */
 	NAPI_GRO_CB(skb)->encap_mark = 1;
 
-- 
2.50.1


