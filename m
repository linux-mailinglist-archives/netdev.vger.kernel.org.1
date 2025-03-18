Return-Path: <netdev+bounces-175865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF20DA67CCD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C314E424F85
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F1213E69;
	Tue, 18 Mar 2025 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="AhIQgRii"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6022144DF;
	Tue, 18 Mar 2025 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324828; cv=pass; b=AcosPCj5Grb1aF6pTr7wGU43vgUsO/5Xozrn7LxP3XXXPPWyD42fvVq5d+1QU52OQRUa+GxOrqGeAM5rUGlxj3dR9SPuEs+uyBYx6b+wfc3ZFj38nc+5JkvnvbV+wmnl16SOCW+vlx4DQO8x2T+471YLQY0nffqpZxED06S3MZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324828; c=relaxed/simple;
	bh=TvDB6EXU7o1u12Z9JVpm7mZZjlrw3Fy+FTe8NXlOmzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbGBdHqZC94rNpClaQ/fYHUG2wc5au20SpqVV4VeN40W0S46zuZUz7sMX/BKhcigcOk4TPrLPAuHYZPfgGvA2gv0AX9WWquivQ9D5ADt+5/swgw+EB6n0At6IjKwLR7IVfPQyJDECg4IqtO29CqGzXnQ2cMzAi7DmfgNAYVDT0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=AhIQgRii; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZHLtV1j1zz49Q81;
	Tue, 18 Mar 2025 21:06:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742324819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJuFfKWLxPL6ckB16fWO9KWsB09aL+0UHkivUASF860=;
	b=AhIQgRiig8CiObfXiMkwkhAowsYsxdqmf9L5gU69Cm7DF/Yvj0naAaQJrNzgBw7hY6TjOH
	XQEBt3pYGj6C8weJxptt80eoU7v3EQhS92oq/keu62LC2xMAfBhj7PRWHUhGSvDJNAvLCC
	URUrdugnnl/YueDwFtaqKFD+/gVm7tpMGvA2e7UQM+cmvVdeFwvAazXGNRWn0e37PZ6+Pl
	2dhNmXUXac9pQmbPCDuHK2MphsRA1Do7XVhCV0zZwqMis9+EYiVXD5WCQI4cY/CL+Xcv1E
	X4LToJdPcY9yUX5GmYHpsMiKdQvVBQNLySzDoi0k4+WajOzWMqRSFRYFwRTc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742324819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJuFfKWLxPL6ckB16fWO9KWsB09aL+0UHkivUASF860=;
	b=PmRNP9EW1nibTU/J7YnEMuTZUg9gOsigTGT/TM8v/Vp6VspntXiuTKA2bKX8G2ZZjnvEUW
	3r9Vbc8GYGXjQzkszcAWDAZXH+6ALGh/G6ig5RdJH4x2O1XU/wKxCygTsJExzQuZj6XU69
	KxinLKjiKn3UkNbL0m12m8K8sho501cDLizpXpngCMOdhgLQ87z9eJz1s1c+EgRLU5myX8
	pMx8r0rKR8LsJVEqIGQhMR729JrZCJt1g6o5SzPjyDvIQHYNDgW0M7PTS36/kIfDS8fiyF
	nPou4sczAoC1gmcddsFoSIEbTWrspBOhM5+jLl3vSH/SkKjKXlBetktewfTnzQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742324819; a=rsa-sha256;
	cv=none;
	b=FxbUIKJ0ejkU2hh8EvpRHV0L0SDvqQ1zp5Yytv3uEnGOSbjll7yszX+3bW3gn8R9gzSlt9
	cR4f+IQydwKUXkm2/xsE7qbwnFx/WrfJiTD5DnejUsKSl/ZijdOVXM3cmWTVIRtJCEX/At
	eLizq+dn7FUg/AFq3XQ9trAM4Nd/0PBZZCiLZk2RmBe0e99Vaz7TsSfaax34FhDUpSihi1
	y2PKmtVqbklP/kWNEoRWoUnginaUtok5o3dcwnlo/s06bV/j5IbMXeQdAJCyrBMH7vjM1N
	/QJFoLc3S0qxjP4JYFsg4yQTg0MXB7AgHaNZ/icDnXf/7is3hzFfuFk0ph8tzw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v5 5/5] Bluetooth: SCO: add TX timestamping
Date: Tue, 18 Mar 2025 21:06:46 +0200
Message-ID: <3877abc6767cad28725421c954ccdb3266d42be2.1742324341.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742324341.git.pav@iki.fi>
References: <cover.1742324341.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support TX timestamping in SCO sockets.
Not available for hdevs without SCO_FLOWCTL.

Support MSG_ERRQUEUE in SCO recvmsg.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v5:
    - use sockcm_init -> hci_sockcm_init

 net/bluetooth/sco.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 5d1bc0d6aee0..2945d27e75dc 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -378,7 +378,8 @@ static int sco_connect(struct sock *sk)
 	return err;
 }
 
-static int sco_send_frame(struct sock *sk, struct sk_buff *skb)
+static int sco_send_frame(struct sock *sk, struct sk_buff *skb,
+			  const struct sockcm_cookie *sockc)
 {
 	struct sco_conn *conn = sco_pi(sk)->conn;
 	int len = skb->len;
@@ -389,6 +390,7 @@ static int sco_send_frame(struct sock *sk, struct sk_buff *skb)
 
 	BT_DBG("sk %p len %d", sk, len);
 
+	hci_setup_tx_timestamp(skb, 1, sockc);
 	hci_send_sco(conn->hcon, skb);
 
 	return len;
@@ -784,6 +786,7 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
+	struct sockcm_cookie sockc;
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -795,6 +798,14 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	hci_sockcm_init(&sockc, sk);
+
+	if (msg->msg_controllen) {
+		err = sock_cmsg_send(sk, msg, &sockc);
+		if (err)
+			return err;
+	}
+
 	skb = bt_skb_sendmsg(sk, msg, len, len, 0, 0);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -802,7 +813,7 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECTED)
-		err = sco_send_frame(sk, skb);
+		err = sco_send_frame(sk, skb, &sockc);
 	else
 		err = -ENOTCONN;
 
@@ -868,6 +879,10 @@ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct sock *sk = sock->sk;
 	struct sco_pinfo *pi = sco_pi(sk);
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
+					  BT_SCM_ERROR);
+
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECT2 &&
-- 
2.48.1


