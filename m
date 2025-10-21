Return-Path: <netdev+bounces-231151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16265BF5B5D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E4CC4FA0AA
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6C3148B5;
	Tue, 21 Oct 2025 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="SWyDFj8w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5134F32BF59
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041425; cv=none; b=VIDqAkrI7NuzOaHtQzvaO4WHtanUx0yQTDl/rMsldx8UB33uFSNZGkT+r6rkFGIpUpbAsvgwkLGjRwWsh0n8QgWXY42fjnSDiSdzhO1bPOD6oOKc8y8E9Fx1dmtKQ6e1WkVJ63IuyAugzXSbnE/fbdHewH3Qxyv4nYoBfD1sOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041425; c=relaxed/simple;
	bh=05vuYDpgaI97/4TmuyIi5UtKcOAT+L9DMzrePpRlL38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsd07i6PY0tAYZHomro6/VX856fOXcNcdAiN+vpAY12u2H9lI/pSjVxgPtLlzjy0h2x7JAI1NFTy3ZKmm3+OYtN54XT46V9tsZKMH1iS44Cm8c9xebpl1pWMO3El9KXGsgXRmD4LIxKisrXPvRXSPhh+0IDnlrizBSifACKipvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=SWyDFj8w; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so4019609f8f.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1761041420; x=1761646220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6AgNPmCiF7hj9leMA+80I5twNHeeiQTO5Me3TTGHA4=;
        b=SWyDFj8w+aew35vYGZRyD2ZQJItmwdK+494CS1LCm2iQqWroQZiANsrBx2IWYdUeMR
         7nK4/n2x3S+Mv4HlTPZZFX4Wx9DC1vboVL7Ly523eI57vlaBbpi1MbqqMrYB9DXra7IR
         MGEnRlK9AvL8iLhV8uFUOTF3dsDFImU4bcpEhRGo0fJgjsbTIK4FlRJ4uROxQV+Mm8M8
         lRlHbzmh/OKaZ30QXp9SUKaaSG5OrSsz1HFK0qFqImpToUDFsU/kuX5FHPbovCluYtnu
         fC619ZVTmmVn6tqSfovFnO/kUj5QOeDBdSK9Y5ef4upJQez3d8QGJRuBiKWktSF66DgS
         fshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041420; x=1761646220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6AgNPmCiF7hj9leMA+80I5twNHeeiQTO5Me3TTGHA4=;
        b=Ky5enaAFw1QDElIGp+BEVZPRF5w9E4pktarMJNrBh6c51M8T7dGqFTZWbM2JPSTkgQ
         HTik5PS+ffkyjWQXcsVVtcpmzoSqCJ/UdRp1PnnZ5Fvy+gEpqYQ24EMy/5/c8FlMFlb3
         OybNcmAGZYOJQdhELinApo2gnysEzKTlxKUnct2ky40KKa4qUiXyYcqM82Xvp15s+T6v
         IwVBK3TcbggJHOXAAZVwYI5c6lqDRpOXkzDFp2p5Z3p5dsTdp7L9/A1SJTyD/uk8ab8I
         zU+lw22OXL0wQGzLagZV9YlV7THvVVDofoo/Uovz5Ea9TRBkjk/BxzJJAkuqcZB6SDWU
         gfHw==
X-Gm-Message-State: AOJu0YwLrW48ju97SE61OhVikjRMeHRyPMPiD00eayTFBtjIAFM31VMy
	muofQ1CWn7gmG+jTExVZySaSwu/2O0MdVLN1YgWrsP9c7tRSQ6smOwvUhl8rqe1RSHNhili4oxC
	+bI5rCZg=
X-Gm-Gg: ASbGncvn4PJW3KQPzYuSC67X+Q5mn8c2223YDJmOtjMUmtbGjwR6iyZD0ODLcS/1AVK
	5TMP1YxDiaL0/l3mCGG4RBBgSqbBvl1nWzJcEQ5VlSY4S1lqZMEc5xDW7CccLERP5l7W07YczPt
	tDUITGMOjA2/fyHJ+a7CJsLfM1qQQWIheiUJ4CmSFi2/6xWDazSMtL8YsbJ50ETGhwjDtjRzslt
	zQwZs/DfZV490j/lt9aOGbjOA1NGAao69aLtZI0DV6RChNVk0Ug/pqv0DL+6dM8fu/G4tXCMVKr
	hAf0qKklWiF7u9ERMfG9XSoaYrJril9NnudV5+JwisthWVOPSKlMWhZBRvH+G3ytkIvk7INkIWo
	1t4hIYR6UP6QdGiaNaFU5sWu8a04ccmj16GTPrnQ17tLuP7gz/ryOJNHWwM4uBboIZM1oRPM=
X-Google-Smtp-Source: AGHT+IF2u6twQ5OYCxytxHSjwtag5EeVqUZDl0379Q0cTRDX/RdXaJAf5MqULZSbsTdTI4jf+bKxzQ==
X-Received: by 2002:a05:6000:2512:b0:3ee:15b4:174c with SMTP id ffacd0b85a97d-42704d497famr11869252f8f.3.1761041419824;
        Tue, 21 Oct 2025 03:10:19 -0700 (PDT)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm20172032f8f.28.2025.10.21.03.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:10:19 -0700 (PDT)
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v3 3/3] ovpn: use datagram_poll_queue for socket readiness in TCP
Date: Tue, 21 Oct 2025 12:09:42 +0200
Message-ID: <20251021100942.195010-4-ralf@mandelbit.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021100942.195010-1-ralf@mandelbit.com>
References: <20251021100942.195010-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

openvpn TCP encapsulation uses a custom queue to deliver packets to
userspace. Currently it relies on datagram_poll, which checks
sk_receive_queue, leading to false readiness signals when that queue
contains non-userspace packets.

Switch ovpn_tcp_poll to use datagram_poll_queue with the peer's
user_queue, ensuring poll only signals readiness when userspace data is
actually available. Also refactor ovpn_tcp_poll in order to enforce the
assumption we can make on the lifetime of ovpn_sock and peer.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/tcp.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 289f62c5d2c7..0d7f30360d87 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -560,16 +560,34 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
 static __poll_t ovpn_tcp_poll(struct file *file, struct socket *sock,
 			      poll_table *wait)
 {
-	__poll_t mask = datagram_poll(file, sock, wait);
+	struct sk_buff_head *queue = &sock->sk->sk_receive_queue;
 	struct ovpn_socket *ovpn_sock;
+	struct ovpn_peer *peer = NULL;
+	__poll_t mask;
 
 	rcu_read_lock();
 	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
-	if (ovpn_sock && ovpn_sock->peer &&
-	    !skb_queue_empty(&ovpn_sock->peer->tcp.user_queue))
-		mask |= EPOLLIN | EPOLLRDNORM;
+	/* if we landed in this callback, we expect to have a
+	 * meaningful state. The ovpn_socket lifecycle would
+	 * prevent it otherwise.
+	 */
+	if (WARN(!ovpn_sock || !ovpn_sock->peer,
+		 "ovpn: null state in ovpn_tcp_poll!")) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	if (ovpn_peer_hold(ovpn_sock->peer)) {
+		peer = ovpn_sock->peer;
+		queue = &peer->tcp.user_queue;
+	}
 	rcu_read_unlock();
 
+	mask = datagram_poll_queue(file, sock, wait, queue);
+
+	if (peer)
+		ovpn_peer_put(peer);
+
 	return mask;
 }
 
-- 
2.51.0


