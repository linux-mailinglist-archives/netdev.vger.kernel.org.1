Return-Path: <netdev+bounces-122856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5859E962D2B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68341F20CC8
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A181A3BDA;
	Wed, 28 Aug 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo4jUNTN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342931A3BDB
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860919; cv=none; b=L0PyL5ShnnXLU+s3VaS0L5iDOKCPX0ktzc04pF4aZEZZtYEGxUlQOExl6ZhdddKZC5VZda0EmkobVDpfYazJ4z1Hd5aAO2eqmuQBQYb91XTDKe19YUA3c3Q32XUGwkRl5XRw8nRNVyzd/CJYnpNCGsyAAroi0Z8W8W8OTl3rO/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860919; c=relaxed/simple;
	bh=4FUm9+4aOF3eDSh/2a+UrkHUnymJdy7X6rrG93t+YPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nrRVSV1Y+Vzr/0mtRGXlnapMLWEcHkUlf1bomN9XsCf17d8cBmZAO9odnF3CuvZ5Uw2Hrq+JSBTmfjBJKnC1qPDLburyxebPmCDmr9gjS3uxipSwAFCfldiD3zyPPN3X6z/l70aPaIPEbXDI/CbkJ6vW/ExVBbB8vfPbRmsn4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo4jUNTN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-201fae21398so49147735ad.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724860916; x=1725465716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgsON45TWsJKFfRE5AO/707YWKkV02J+tcpFgxJwyQw=;
        b=jo4jUNTNj0OQkrP2mUESF4Y88hjdJP1GI0Ujq7uAvjufHVF5j2+i+PKlUYXpO7liX+
         T9z2VrzleapycViM8Z/lbnmKSM566Kk95wROYfbfn4WxH4CFqh41w+3B54IAsMpwzh0q
         AF3NKFVqoptTtU54OHPe4FZcDn/++g0T9g0a78Gl6nW/aFJve2VZvz1YjdMr7sUVcJKe
         r9H/IgbVMMW69yuPYxaXTAVdCrC91LLejH2h8nEC5+/AnM5FRsdtb13niyNY2yqRbbZd
         lHvYqPbCV5FU9QDsy0XE98JqlKHuNkl8YegnOWfNFvjr6U3rJ4szNkxwMhH1Hcq+ebnZ
         +Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724860916; x=1725465716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgsON45TWsJKFfRE5AO/707YWKkV02J+tcpFgxJwyQw=;
        b=VE8rI7iHHcA/wNLCm9xlMKyPZSosUC+z1kQHZ29d5KuqInqvG5r9Abil9NKqg5dV4l
         bsTNtAUOvVqOEC6RRsoMmrVYUU8sU1/gDukWb3YTGjh9P7K7HGaM3+yXRmUigPAAYIG7
         QB9UTPlk7fO8I6spUJn7X7Z+GxUI3xrBo+TDaq62ogbsp2rSX8ypmr2TelIIWhjoLDz+
         IgCV+p+Mwlt21aHOLS0Z5VXIfPW04K6+IfpitFwrznn+YK0lZbte6EVFXVCQcFRljA1g
         gkKI3ZPbyd5ggSxOsjBpuR9UjAcn5mCnbQkXKK89bhjq/TSXzCG0e6oadtuM+9ZN2NIz
         JoYA==
X-Gm-Message-State: AOJu0YyYFSvVB/jzDpOzuLppbWDtARH4MqLfF9iceGV6P09noHy7n3Su
	ntYh5y+l2gDkil4+a/SCILkzlaZv4D2/dynfGKelOgbaCHQFGDLi
X-Google-Smtp-Source: AGHT+IG3mV2MzBCtawipA4BxAvIYIWWzoij92oEEUqJotAdlyyhQJSK6GN5hC5UXKmdZsIC1oU1gWA==
X-Received: by 2002:a17:903:41cb:b0:1fb:90e1:c8c0 with SMTP id d9443c01a7336-204f9c50d18mr32805905ad.63.1724860916044;
        Wed, 28 Aug 2024 09:01:56 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385564dd9sm100061755ad.51.2024.08.28.09.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:01:55 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v2 2/2] net: make SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
Date: Thu, 29 Aug 2024 00:01:45 +0800
Message-Id: <20240828160145.68805-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240828160145.68805-1-kerneljasonxing@gmail.com>
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
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

Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 Documentation/networking/timestamping.rst |  7 +++++++
 include/net/sock.h                        |  7 ++++---
 net/bluetooth/hci_sock.c                  |  4 ++--
 net/core/sock.c                           |  2 +-
 net/ipv4/ip_sockglue.c                    |  2 +-
 net/ipv4/ping.c                           |  2 +-
 net/ipv6/datagram.c                       |  4 ++--
 net/l2tp/l2tp_ip.c                        |  2 +-
 net/l2tp/l2tp_ip6.c                       |  2 +-
 net/nfc/llcp_sock.c                       |  2 +-
 net/rxrpc/recvmsg.c                       |  2 +-
 net/socket.c                              | 11 ++++++++---
 net/unix/af_unix.c                        |  2 +-
 13 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 5e93cd71f99f..93378b78c6dd 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -160,6 +160,13 @@ SOF_TIMESTAMPING_RAW_HARDWARE:
   Report hardware timestamps as generated by
   SOF_TIMESTAMPING_TX_HARDWARE when available.
 
+Please note: previously, if an application starts first which turns on
+netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOFTWARE
+could also get rx timestamp. Now we handle this case and will not get
+rx timestamp under this circumstance. We encourage that for each socket
+we should use the SOF_TIMESTAMPING_RX_SOFTWARE generation flag to time
+stamp the skb and use SOF_TIMESTAMPING_SOFTWARE report flag to tell
+the application.
 
 1.3.3 Timestamp Options
 ^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/include/net/sock.h b/include/net/sock.h
index cce23ac4d514..b8535692f340 100644
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
@@ -2621,7 +2622,7 @@ sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff *skb)
 	    (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
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
index fcbdd5bc47ac..c02fb9b615b2 100644
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
@@ -946,7 +946,12 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
 	memset(&tss, 0, sizeof(tss));
 	tsflags = READ_ONCE(sk->sk_tsflags);
-	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+	/* We have to use the generation flag here to test if we allow the
+	 * corresponding application to receive the rx timestamp. Only
+	 * using report flag does not hold for receive timestamping case.
+	 */
+	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+	     (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE || errqueue)) &&
 	    ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
 		empty = 0;
 	if (shhwtstamps &&
@@ -1024,7 +1029,7 @@ static void sock_recv_mark(struct msghdr *msg, struct sock *sk,
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


