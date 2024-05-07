Return-Path: <netdev+bounces-94011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 648708BDECB
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E21BB25B7C
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D3B14EC60;
	Tue,  7 May 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="dH8pE8z8"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FFA14EC62;
	Tue,  7 May 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074893; cv=none; b=XrCAeRwP9ZDWoVtPxe0ZMAtGDjkayIOoKo05VEtK09lEel1VACe7Y04iPyz9HmW7nTughIwrl+asMwGoYaLU6EzIxQHGJhuHFQLTtw8zSOIw4k+bApdqinoyqT3hmHgSpWoSN3XMLz1jZO28Gn2k/se9mawl50jzYbp99tmwMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074893; c=relaxed/simple;
	bh=dODPQlY3EA6sbMqap8cxwX+oTqUUKDsbFS53aBcmjFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osVsB46qkOzJUDNOUyaZw9DRthpGvGo4wpip7v2L7BV8VUgVbNsr8Zeu3n1VmN/LCuLXHgoPiTWHUfiofG9LUtBswGpxun5o2z/g/IvhzBt1jRUP+GC3gHiSDbcj8V0MqEvB0ZQ7nUWdspfrRO8Kga4S5vu03YqGNppiyw9kRsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=dH8pE8z8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=B91Dda2e2qRFkRF6V/Ev2t/FHXit3LZPc3UTQDv0sDQ=; b=dH8pE8z81w5sybqqJ5v558du+6
	bsxUqQr9sFmzrPNaa1x5uoBZpiV8QaudCpW9yH0nwYeVACBbtuBRvYjk1yf5cUXFak96cSFFZzffb
	rdArh7PsUvWdogEBGCDjzqJDI0fHqCt5tVOvS3s/g9odKpO9dNwt6zM6+A/CuUcbMWn0=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s4HJy-00EIWj-2j;
	Tue, 07 May 2024 11:41:14 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: add missing check for TCP fraglist GRO
Date: Tue,  7 May 2024 11:41:13 +0200
Message-ID: <20240507094114.67716-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It turns out that the existing checks do not guarantee that the skb can be
pulled up to the GRO offset. When using the usb r8152 network driver with
GRO fraglist, the BUG() in __skb_pull is often triggered.
Fix the crash by adding the missing check.

Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/ipv4/tcp_offload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index c90704befd7b..a71d2e623f0c 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -353,6 +353,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		flush |= (__force int)(flags ^ tcp_flag_word(th2));
 		flush |= skb->ip_summed != p->ip_summed;
 		flush |= skb->csum_level != p->csum_level;
+		flush |= !pskb_may_pull(skb, skb_gro_offset(skb));
 		flush |= NAPI_GRO_CB(p)->count >= 64;
 
 		if (flush || skb_gro_receive_list(p, skb))
-- 
2.44.0


