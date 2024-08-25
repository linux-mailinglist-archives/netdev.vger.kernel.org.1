Return-Path: <netdev+bounces-121730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E71595E427
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 17:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368201C2067B
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E482D158DD1;
	Sun, 25 Aug 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu0rqJJH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C8015DBBA
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724599492; cv=none; b=daIykbEQ7y9v2tw28uAqNL1WZJGtoAGHL02OauEHS248eutZYkGjiYYlS5aqUDbdjftZxSErtY6YF+ULqmhOIrGKT5cZe2Qre8xKzPUaGkAfR2bBOgPkqxiH2u8JwGgFAk5MhJ2CkPgzrZ4ksx4oS5qx+63f40Nu8D8O5628+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724599492; c=relaxed/simple;
	bh=RVo2Uc+DgVkcjgziHuUoKe8XPKfGzAqAVu0WAmXYPHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRxtfbxL+LzYRbizLwqUdATjS9BRb0AkKvdr99EZaAsSqtnKHMeEIDlz7AQvu7H1x6EexWUkF6ScioDEEBYxbllmYSz19HGHsYwej2+Bhe4nMAA5UKndCnrGO/YFc2uAE8kQ3jkyJ++dXaYWHp3wFklwpDAKGgxFIMAQQ+fXBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu0rqJJH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-714261089c1so2455590b3a.0
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724599490; x=1725204290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ivrmb6qkd6p+bPHZIawZjuHu9xDVkuABkC8FM/2/fPE=;
        b=Qu0rqJJHjoaiIFoExIoAVmYwUGNvqFhc6f7oD9ixCiwTorUw9CNL+ej+2Tj7sCnp1U
         cAloo8UGgL/3byWCeRfJdbkH415sH+u2YSLuR1Kt8PRr4A7wLdBLWoNFDkcbBn4NwGow
         knBKt9E9GY73Pu4gJNRuHjVT1UrdfQC3gWRsRa7bcdZjdGKeWe+JxQ07QhiOnYc0iM7I
         qACEdvVtagbbesG1MIbPE6XjcttEUgSHkBY50PFIwWz9as5KIhzuR68uJetlKZd9aTPU
         2foUhwJBYvm3+spIsjUPURCmdJNaDeRT4U1zr2HJUbLoi6bpjztq+xOGgUim75FGhVKy
         ytiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724599490; x=1725204290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ivrmb6qkd6p+bPHZIawZjuHu9xDVkuABkC8FM/2/fPE=;
        b=OqpflIFaRNv+NuXraiIGbxPpwBnTJdq4wf8aI/LiEiuX0J4awbqozYQP/Im9QrXpKl
         BAsJSeLTvxqqqomQKGWYuBh5NIKHHEYbqsefCM8lnXwua78dcizkOLy1/NOf/kATG/7T
         LfqRNTDyirJXpj6L1cVpFemiILPoQqyQ2xKG/oqK25dD/2boQTHLaRFXIvd+PnAQ32Hn
         SaC2RfJAl6zFRkuWQTT2U9G/cOtXZxLw2GJEf2qEOMlpbfmMcFZabq4FShN+ZQdD5ahE
         uJgBA6iKCqgyToC+3vMdFFZ+nxWVPr5uEC17yhV1Ot6TDXuAwjlKMzxfMR6XhqaiY2RF
         npeA==
X-Gm-Message-State: AOJu0YxnIYagSURDoAMvmkTDzmFX4KB2rbd/R7jrZvkybj2bi0fxYgr7
	ozvxKpYQ11+04hUrcU/OhKjXr2ccL1OzAsKzsggNxsG3IZxOs9Dg
X-Google-Smtp-Source: AGHT+IFha+OoEd7ehHqW6z4ivCg7m/J9eZetfTMIPdTe/jfbMTAQ2Yx0BLXl2NwqBz8uco9jYcAw2Q==
X-Received: by 2002:aa7:8ec2:0:b0:714:2371:7a02 with SMTP id d2e1a72fcca58-7143173d6b0mr19573863b3a.5.1724599490164;
        Sun, 25 Aug 2024 08:24:50 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430941bsm5775166b3a.168.2024.08.25.08.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 08:24:49 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/2] net: make SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
Date: Sun, 25 Aug 2024 23:24:40 +0800
Message-Id: <20240825152440.93054-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240825152440.93054-1-kerneljasonxing@gmail.com>
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like the previous patch in this series, we need to make sure that
we both set SOF_TIMESTAMPING_SOFTWARE and SOF_TIMESTAMPING_RX_SOFTWARE
flags together so that we can let the user parse the rx timestamp.

One more important and special thing is that we should take care of
errqueue recv path because we rely on errqueue to get our timestamps
for sendmsg(). Or else, If the user wants to read when setting
SOF_TIMESTAMPING_TX_ACK, something like this, we cannot get timestamps,
for example, in TCP case. So we should consider those
SOF_TIMESTAMPING_TX_* flags.

After this patch, we are able to pass the testcase 6 for IP and UDP
cases when running ./rxtimestamp binary.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h       | 11 ++++++-----
 net/bluetooth/hci_sock.c |  4 ++--
 net/core/sock.c          |  2 +-
 net/ipv4/ip_sockglue.c   |  2 +-
 net/ipv4/ping.c          |  2 +-
 net/ipv6/datagram.c      |  4 ++--
 net/l2tp/l2tp_ip.c       |  2 +-
 net/l2tp/l2tp_ip6.c      |  2 +-
 net/nfc/llcp_sock.c      |  2 +-
 net/rxrpc/recvmsg.c      |  2 +-
 net/socket.c             |  7 ++++---
 net/unix/af_unix.c       |  2 +-
 12 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index cce23ac4d514..b1825b54ca9d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2600,12 +2600,13 @@ static inline void sock_write_timestamp(struct sock *sk, ktime_t kt)
 }
 
 void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
-			   struct sk_buff *skb);
+			   struct sk_buff *skb, bool errqueue);
 void __sock_recv_wifi_status(struct msghdr *msg, struct sock *sk,
 			     struct sk_buff *skb);
 
 static inline void
-sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff *skb)
+sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff *skb,
+		    bool errqueue)
 {
 	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
 	u32 tsflags = READ_ONCE(sk->sk_tsflags);
@@ -2617,11 +2618,11 @@ sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff *skb)
 	 * - hardware time stamps available and wanted
 	 */
 	if (sock_flag(sk, SOCK_RCVTSTAMP) ||
-	    (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
-	    (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
+	    ((tsflags & SOF_TIMESTAMPING_RX_SOFTWARE || errqueue) &&
+	    (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE)) ||
 	    (hwtstamps->hwtstamp &&
 	     (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
-		__sock_recv_timestamp(msg, sk, skb);
+		__sock_recv_timestamp(msg, sk, skb, errqueue);
 	else
 		sock_write_timestamp(sk, kt);
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 69c2ba1e843e..c1b73c5a370b 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1586,11 +1586,11 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		break;
 	case HCI_CHANNEL_USER:
 	case HCI_CHANNEL_MONITOR:
-		sock_recv_timestamp(msg, sk, skb);
+		sock_recv_timestamp(msg, sk, skb, false);
 		break;
 	default:
 		if (hci_mgmt_chan_find(hci_pi(sk)->channel))
-			sock_recv_timestamp(msg, sk, skb);
+			sock_recv_timestamp(msg, sk, skb, false);
 		break;
 	}
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 9abc4fe25953..d969a4901300 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3677,7 +3677,7 @@ int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len,
 	if (err)
 		goto out_free_skb;
 
-	sock_recv_timestamp(msg, sk, skb);
+	sock_recv_timestamp(msg, sk, skb, true);
 
 	serr = SKB_EXT_ERR(skb);
 	put_cmsg(msg, level, type, sizeof(serr->ee), &serr->ee);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..b79f859c34bf 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -547,7 +547,7 @@ int ip_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 		kfree_skb(skb);
 		return err;
 	}
-	sock_recv_timestamp(msg, sk, skb);
+	sock_recv_timestamp(msg, sk, skb, true);
 
 	serr = SKB_EXT_ERR(skb);
 
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 619ddc087957..1cf7b0eecd63 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -880,7 +880,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 	if (err)
 		goto done;
 
-	sock_recv_timestamp(msg, sk, skb);
+	sock_recv_timestamp(msg, sk, skb, false);
 
 	/* Copy the address and add cmsg data. */
 	if (family == AF_INET) {
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index fff78496803d..1e4c11b2d0ce 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -479,7 +479,7 @@ int ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 		kfree_skb(skb);
 		return err;
 	}
-	sock_recv_timestamp(msg, sk, skb);
+	sock_recv_timestamp(msg, sk, skb, true);
 
 	serr = SKB_EXT_ERR(skb);
 
@@ -568,7 +568,7 @@ int ipv6_recv_rxpmtu(struct sock *sk, struct msghdr *msg, int len,
 	if (err)
 		goto out_free_skb;
 
-	sock_recv_timestamp(msg, sk, skb);
+	sock_recv_timestamp(msg, sk, skb, false);
 
 	memcpy(&mtu_info, IP6CBMTU(skb), sizeof(mtu_info));
 
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 4bc24fddfd52..164c8ed7124e 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -567,7 +567,7 @@ static int l2tp_ip_recvmsg(struct sock *sk, struct msghdr *msg,
 	if (err)
 		goto done;
 
-	sock_recv_timestamp(msg, sk, skb);
+	sock_recv_timestamp(msg, sk, skb, false);
 
 	/* Copy the address. */
 	if (sin) {
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index f4c1da070826..b0bb0a1f772e 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -712,7 +712,7 @@ static int l2tp_ip6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (err)
 		goto done;
 
-	sock_recv_timestamp(msg, sk, skb);
+	sock_recv_timestamp(msg, sk, skb, false);
 
 	/* Copy the address. */
 	if (lsa) {
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 57a2f97004e1..5c6e671643f6 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -869,7 +869,7 @@ static int llcp_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		return -EFAULT;
 	}
 
-	sock_recv_timestamp(msg, sk, skb);
+	sock_recv_timestamp(msg, sk, skb, false);
 
 	if (sk->sk_type == SOCK_DGRAM && msg->msg_name) {
 		struct nfc_llcp_ui_cb *ui_cb = nfc_llcp_ui_skb_cb(skb);
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index a482f88c5fc5..18fa392011fb 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -200,7 +200,7 @@ static int rxrpc_recvmsg_data(struct socket *sock, struct rxrpc_call *call,
 					    sp->hdr.serial, seq);
 
 		if (msg)
-			sock_recv_timestamp(msg, sock->sk, skb);
+			sock_recv_timestamp(msg, sock->sk, skb, false);
 
 		if (rx_pkt_offset == 0) {
 			ret2 = rxrpc_verify_data(call, skb);
diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..51118fc6c7c9 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -893,7 +893,7 @@ static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb,
  * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
  */
 void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
-	struct sk_buff *skb)
+			   struct sk_buff *skb, bool errqueue)
 {
 	int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP);
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
@@ -946,7 +946,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
 	memset(&tss, 0, sizeof(tss));
 	tsflags = READ_ONCE(sk->sk_tsflags);
-	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+	    (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE || errqueue)) &&
 	    ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
 		empty = 0;
 	if (shhwtstamps &&
@@ -1024,7 +1025,7 @@ static void sock_recv_mark(struct msghdr *msg, struct sock *sk,
 void __sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 		       struct sk_buff *skb)
 {
-	sock_recv_timestamp(msg, sk, skb);
+	sock_recv_timestamp(msg, sk, skb, false);
 	sock_recv_drops(msg, sk, skb);
 	sock_recv_mark(msg, sk, skb);
 }
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a1894019ebd5..bb33f2994618 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2481,7 +2481,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 		goto out_free;
 
 	if (sock_flag(sk, SOCK_RCVTSTAMP))
-		__sock_recv_timestamp(msg, sk, skb);
+		__sock_recv_timestamp(msg, sk, skb, false);
 
 	memset(&scm, 0, sizeof(scm));
 
-- 
2.37.3


