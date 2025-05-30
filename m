Return-Path: <netdev+bounces-194337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D7CAC8BF3
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 12:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABB74A487B
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29AE2236F3;
	Fri, 30 May 2025 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KJwS8U8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4082222C8
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748599989; cv=none; b=X5xr+BWFCz7kaBWZYmBEUusGxNvNutOpDLF8tig1DY74Ob+z0t7jy8h8wSMdwGluCWegnV0du7eVV4O5nX6vfXtVie+g41jbdBVjtkKByLQj8q7DDXOCdYTQLqRJULzitJN9SlSJ56yrw6WxIntK1xCo+3qYaYTN/RD0pP7w7zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748599989; c=relaxed/simple;
	bh=gEXvMyimedckS/xLZ08JVbV+eXxxKz3pUaWiy/iNqM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zw/Vv1u2edonc4pkjlzfKPlCn3rUC958bUxemdFb0N8FVffACe4uZyUX1U8nI108KJrXHryFE59x0cnQ4BuRqTNONv9trDxjsYe+aHBHp3SjbrJgX381I35kO51u+tYlFcrMgxiK1Xu36RfyKuR2jZcSw6y3lXKtL2W2OOJaKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KJwS8U8Z; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a361b8a664so1841333f8f.3
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748599985; x=1749204785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbRKdb3Cspe6So2JV8OSPXJpIgXTzKzww+KGbs250NQ=;
        b=KJwS8U8Z5anGn/srWq1hCLleOa9b6vPFgcky6Qluf/Fw6Qrs2NKvLas146xD3wrKWm
         Z3QC57ue/e74jV/jQKtOIG4nUju3lcopA4RNj+jowKG/IiO/CkVaKoHfQVoFNUcQ835T
         vn/qIiU/dXwR7QAgMPxwXJq/5RZf26bIiVArEfQa0v8tuMrvdydwh1Idu8quAXGP6O7o
         QIwnH+cFT1KTkR+MIURG4ZQrvWRlDVqnlwQIX5jgE5/u/9yQCWpDY7M1roA0sM5kOZ9w
         9YC5xMmJkm2APkOqKNgllfIOs2r8XHL/2ncs9USSTZ9jTwY4oE1qp5A6sAhmdzo7TRiO
         dEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748599985; x=1749204785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbRKdb3Cspe6So2JV8OSPXJpIgXTzKzww+KGbs250NQ=;
        b=dRQHZVqUsxPSZ7ihY3+VbZ6oZfr7qqyH/dHvAsASfDjds4h1TXtVgcLe0hcmzhZ1u1
         gE2Gvz4dAVwU1Hdf0Nyhfa8ZzsCSq3S91dhB5LoSqFKZQRoJGWlGQcp/Hb1c2L1Wf6K4
         XdSq8KzAMFSeWvG2fcxCsXYIlmOS+bKHQnMYZf6CmACMXh6/HA1BmzRiOHm0j7SZP+ix
         Wt5zd2ppBljHYz79ZAMyU2dWgNeN3l/8X8LfO0T6hnEH3jEC3Z59mpKsq2CcMUNoRLmR
         LPRJQR9FuROIo6IA1Fy1qRPZQXfDckx+TryuleRQ7xmNiN2+gwO/3j7/BPN6iY37zVtF
         OtkQ==
X-Gm-Message-State: AOJu0YwSYpNYv6klasfoo9m12/b+FUSPeLd3XlQ8o2jw9xE7CGn8UJZ9
	Us2Z6Kbe3UFx8q1/QpiIzxybO7sDX5Eqyzd2CWZNcCsT540KKW4BJcphkm/d1qVKWJsdTz/1QMR
	KV0lsQqPhef8o+Eok/T8dsRASZnfqa9oapSNRaTHH1YoDG2ddeFKtdJZcw14JKmH7
X-Gm-Gg: ASbGncuPaPE7J89nWehprY+MqOSUb/E8mxmPM/jfB7/P/RWgxnL/LcytLJ94foRXb6z
	t7ZZl+CKOMrOfs49IyYVbHcA3YBSwUtLPSjzoHM70fLwokoCpPwnspMSQrNFBKKWlAfsne8OPCB
	o59FXfwA5CyArWT6o5N7JHl8UP4lsSzUf4AH1dgh3/RP1uXgDPr5vRvkw7UMBKm9Z2cEv1NpEcv
	9yUYzc5rLu24Y/RiNM4Ps3auRVGXY2X9O3aLKeSm4sJWX/WdY/zfTec74N80BQpuZ4AOYaQCF3R
	LYXAcb2qX/4lID18j6sodF86PXkRfF24xj1pmo7sky5Db4Z4kBOC8eE12usy17rxHyjTR5orrQ=
	=
X-Google-Smtp-Source: AGHT+IFezNfTr3XSWpYJ60d6FAUF28jmLCe+W6Fg3EWYaSwRE8bd0CTktpL8NFt1ulhCyeOZPlmY1w==
X-Received: by 2002:a05:6000:4310:b0:3a4:f439:e715 with SMTP id ffacd0b85a97d-3a4f7a3e590mr1995951f8f.9.1748599985280;
        Fri, 30 May 2025 03:13:05 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:cdbd:204e:842c:3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b892sm4480956f8f.17.2025.05.30.03.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 03:13:04 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>
Subject: [PATCH net 3/5] ovpn: avoid sleep in atomic context in TCP RX error path
Date: Fri, 30 May 2025 12:12:52 +0200
Message-ID: <20250530101254.24044-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530101254.24044-1-antonio@openvpn.net>
References: <20250530101254.24044-1-antonio@openvpn.net>
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


