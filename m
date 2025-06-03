Return-Path: <netdev+bounces-194767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E08B2ACC515
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074FA7A90F5
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0D523182B;
	Tue,  3 Jun 2025 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TK3maZNV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76491230D1E
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949095; cv=none; b=StptwpvkwWa15zbb9305ru1VG1wJ669MzoWWSFujGeBkfAWdtGvprdt9ubpZ+pVrTuH5/VD0hQXPo0Ski0OX0CP7MT5JvwyKz/etsFFobahVkvNuxym3yCdLNv7yEvFiHZIA/STFwLk5FmPkXSVX18Q6Cxg46pDa3ocsPIsk0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949095; c=relaxed/simple;
	bh=rp47gqFtMNX06atgqPDQoUMuPk65JrEzw/84daT0TcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+V59r4+HcMjgF4vM7NBAbOI/xrukJ4b46LuwUqKlsIMU6Srn4xFgH9W3uAtg9368Q8pXJUMbUbL2hOcKWCo3BsnLK+ijTiU21V+pZlqzWUYbFGOSQEjvgSgAoo0hh7ZNtMnn6/9ZDQI6EFQH4bjl/0J4OJAVDX5Cq44FHBZW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TK3maZNV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d54214adso21172915e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748949091; x=1749553891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/tvhwjAjfTDn0zo7mR2bCc2064UI60Ebya484/pJJ8=;
        b=TK3maZNVLgXLFQzqA2JSYajDgvbUwxRgMIGvZ3NdvlcKNzcsXB3s921JlsH8O2za2j
         i/qWu/UtTLJn0qWHDRDO8AJPL3vXVHlBeeAX/DdCudA8p6NxIY5CSpBWbdjfVOGbpriD
         LHWsgx/7hlVNAFA5tqHHNTtY0UIhpcGG6kASR69IvzQJ0kfiH5VxcJffVDcxouEZv6TJ
         4h+10DFI4DamteLkcMz3zX3EnhkjDHWYfmZAX86Yl9iG3KqBMc/7aob26M7Nh4JAR3S+
         ZDVpeAI85EO5hbZzKHvAK7wwaNK44RQx72FrbkeFOQ1EQMHybXCR9NPb6S5g0Uk9ws0e
         v9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748949091; x=1749553891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/tvhwjAjfTDn0zo7mR2bCc2064UI60Ebya484/pJJ8=;
        b=NX7lI6ynjQTj2O7pI+Zr3buxhIfDdKlD3DCIBplDahgq/H2vD4SHApIYmWx8KhCd2F
         /XdKO7JVB1TT5mcMvpZWALUPYfQCrcygu7/s/tm72B1sAIiDA5aVa/wQsPdlYzWRgULH
         n+yUAcxwkmSgTEVXu/0xw125wetchgzPK6yumXQik5lYd5hKvQIFISUrDN5HT2IvSxKC
         xJEfmspVkHYxad50nQhv7KrhFkfxGSIo0D46HZVZU+aszAcCegLTOQhAud3eLGTB8Csj
         gFZ56oLhAMO5UOJocyUp/cFJfiEzLaLGhxDRtrgV459KRUjWsp9zNN7RxFAV8s/I9T/w
         Fe1g==
X-Gm-Message-State: AOJu0YwhXd2vOEDcuQSv1bYHXyd5an4FNID/xEDwmICIKx9JTks7LWyy
	H6oB0bNhNUA6WKtJ5ergPtRSnu7S2VskHWVcMyGn7JiTGqGg6YY2N4u8QCC7GaOTSDb+Rs72kmz
	0DqWJWA+qRt6emYBCSiKzUT2NF/XdFQIwgvXM8/bQkdss5YsndXn4pgtO0+7s5RUh
X-Gm-Gg: ASbGnct6tSj0J7whjrgD5HMHgVT75Zsi2P/lqqWUhLjhO2nkeUzc2hdq0YMsFVkk7RO
	/gfPfiMP22jE2XAPiaDQZgACvLdlZ46AID2JozLLZh3E1fslc7CHAXh8aTyQFetMKyo0oF85WgM
	1uaTbIdgl3xxBljwSQjzVavL+zOx6+bmxAzukR5NggYNcbHVmwGRoV+m3E3iz9daSuYLH2mInhL
	SZJVPUNMEA9VYhu7L8qKzNqw4DYdN/xehO1k3qUl6D1UIfPnWs3H59bIcO3uoqzkgXDcSzFG6Qw
	5+F4vQj4QBogzD+UnMpbkYXPnF0l0wnsryBr5XIfCrQEx/9HyVidccr0jbCVRrNIekc39Dk2+hO
	Itdh9/NvYbg==
X-Google-Smtp-Source: AGHT+IF+BFoHXt/6CNN+73F6q5r+/2Xqvuj9djJKrrb8521j8a/Y7FcDoTlafWwYLRbVVdUwfb5+lQ==
X-Received: by 2002:a05:600c:4688:b0:442:ccf9:e6f2 with SMTP id 5b1f17b1804b1-450d650089amr190073005e9.16.1748949091315;
        Tue, 03 Jun 2025 04:11:31 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cb:f052:3c80:d7a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa249esm163244525e9.13.2025.06.03.04.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 04:11:30 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>
Subject: [PATCH net 3/5] ovpn: avoid sleep in atomic context in TCP RX error path
Date: Tue,  3 Jun 2025 13:11:08 +0200
Message-ID: <20250603111110.4575-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603111110.4575-1-antonio@openvpn.net>
References: <20250603111110.4575-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon error along the TCP data_ready event path, we have
the following chain of calls:

strp_data_ready()
  ovpn_tcp_rcv()
    ovpn_peer_del()
      ovpn_socket_release()

Since strp_data_ready() may be invoked from softirq context, and
ovpn_socket_release() may sleep, the above sequence may cause a
sleep in atomic context like the following:

    BUG: sleeping function called from invalid context at ./ovpn-backports-ovpn-net-next-main-6.15.0-rc5-20250522/drivers/net/ovpn/socket.c:71
    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 25, name: ksoftirqd/3
    5 locks held by ksoftirqd/3/25:
     #0: ffffffe000cd0580 (rcu_read_lock){....}-{1:2}, at: netif_receive_skb+0xb8/0x5b0
     OpenVPN/ovpn-backports#1: ffffffe000cd0580 (rcu_read_lock){....}-{1:2}, at: netif_receive_skb+0xb8/0x5b0
     OpenVPN/ovpn-backports#2: ffffffe000cd0580 (rcu_read_lock){....}-{1:2}, at: ip_local_deliver_finish+0x66/0x1e0
     OpenVPN/ovpn-backports#3: ffffffe003ce9818 (slock-AF_INET/1){+.-.}-{2:2}, at: tcp_v4_rcv+0x156e/0x17a0
     OpenVPN/ovpn-backports#4: ffffffe000cd0580 (rcu_read_lock){....}-{1:2}, at: ovpn_tcp_data_ready+0x0/0x1b0 [ovpn]
    CPU: 3 PID: 25 Comm: ksoftirqd/3 Not tainted 5.10.104+ #0
    Call Trace:
    walk_stackframe+0x0/0x1d0
    show_stack+0x2e/0x44
    dump_stack+0xc2/0x102
    ___might_sleep+0x29c/0x2b0
    __might_sleep+0x62/0xa0
    ovpn_socket_release+0x24/0x2d0 [ovpn]
    unlock_ovpn+0x6e/0x190 [ovpn]
    ovpn_peer_del+0x13c/0x390 [ovpn]
    ovpn_tcp_rcv+0x280/0x560 [ovpn]
    __strp_recv+0x262/0x940
    strp_recv+0x66/0x80
    tcp_read_sock+0x122/0x410
    strp_data_ready+0x156/0x1f0
    ovpn_tcp_data_ready+0x92/0x1b0 [ovpn]
    tcp_data_ready+0x6c/0x150
    tcp_rcv_established+0xb36/0xc50
    tcp_v4_do_rcv+0x25e/0x380
    tcp_v4_rcv+0x166a/0x17a0
    ip_protocol_deliver_rcu+0x8c/0x250
    ip_local_deliver_finish+0xf8/0x1e0
    ip_local_deliver+0xc2/0x2d0
    ip_rcv+0x1f2/0x330
    __netif_receive_skb+0xfc/0x290
    netif_receive_skb+0x104/0x5b0
    br_pass_frame_up+0x190/0x3f0
    br_handle_frame_finish+0x3e2/0x7a0
    br_handle_frame+0x750/0xab0
    __netif_receive_skb_core.constprop.0+0x4c0/0x17f0
    __netif_receive_skb+0xc6/0x290
    netif_receive_skb+0x104/0x5b0
    xgmac_dma_rx+0x962/0xb40
    __napi_poll.constprop.0+0x5a/0x350
    net_rx_action+0x1fe/0x4b0
    __do_softirq+0x1f8/0x85c
    run_ksoftirqd+0x80/0xd0
    smpboot_thread_fn+0x1f0/0x3e0
    kthread+0x1e6/0x210
    ret_from_kernel_thread+0x8/0xc

Fix this issue by postponing the ovpn_peer_del() call to
a scheduled worker, as we already do in ovpn_tcp_send_sock()
for the very same reason.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Reported-by: Qingfang Deng <dqfext@gmail.com>
Closes: https://github.com/OpenVPN/ovpn-net-next/issues/13
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/tcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 7e79aad0b043..289f62c5d2c7 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -124,14 +124,18 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	 * this peer, therefore ovpn_peer_hold() is not expected to fail
 	 */
 	if (WARN_ON(!ovpn_peer_hold(peer)))
-		goto err;
+		goto err_nopeer;
 
 	ovpn_recv(peer, skb);
 	return;
 err:
+	/* take reference for deferred peer deletion. should never fail */
+	if (WARN_ON(!ovpn_peer_hold(peer)))
+		goto err_nopeer;
+	schedule_work(&peer->tcp.defer_del_work);
 	dev_dstats_rx_dropped(peer->ovpn->dev);
+err_nopeer:
 	kfree_skb(skb);
-	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
 }
 
 static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-- 
2.49.0


