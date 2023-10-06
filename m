Return-Path: <netdev+bounces-38455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A817BB007
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 03:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2730828218D
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648C17C5;
	Fri,  6 Oct 2023 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIIwqS06"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1BD1855
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 01:18:54 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C463D6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 18:18:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2773b10bd05so362589a91.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 18:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696555132; x=1697159932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ87OJ/zCK9OfeYFqItCJOqrJzgZJL6Y0bDTtQKJWnc=;
        b=lIIwqS06mTg7NxhgjawC6LJaRabAmhVLHc4ZL6IsslCBc2+299nsHTZjXDHHa1CK23
         GTJB127oUwyL98A9uQXyysBg8mfuaY+q2N5MSliveZVLNOM+KXe8SAe4mk/HekK3iXtB
         OFY9sdfm/fOleEew7uXKMaqSvlmzJcO/6Ku7mruQaYcHJtcpqZeDMqujUf3qDKCku/vU
         Rr8aWqOGeGa54KNgtwJSfWVu5mexeNSsl3ODq9zWs7T3ddhIIskIUFoKx4Kn7mKHaYFr
         Bhi2FSNi488l2Lp0lZby2uamEaQEbiPSGXdGp+JIrYoHRWa2w6qZmhj3hoEORuGvsyOt
         ZrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696555132; x=1697159932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJ87OJ/zCK9OfeYFqItCJOqrJzgZJL6Y0bDTtQKJWnc=;
        b=N1QpS+GKU+TsGB4xI/ox0+YYUSzuBg9uh8ZvKtQtjOvLjCiTtXvalzTwaFzLTqVcVM
         jK4dQKhWCNbGui94ZnkblqVEuff98goXu+uVBnhJyKbuKM3yI+JYwFRl81yO9sZTHIn8
         qjDXMROOUKEonmAtKZOu7ZbECT6ih0MysjPqEGNqWmgY7C4vTF3jqQBmLRMW6U9ZY4RA
         3F7ALXCVWovShI2ZyVrWSpssl9ZBHESpg2SUDFnLWI0pHxgyERXr7H0hPVG23AfgTYkH
         9EBBt7K/vOOgPYpVMgLoEGpuYtc+h9wG/zYYzJigx46L2chMbgShkGucKaUwgYk+/+AU
         SSBA==
X-Gm-Message-State: AOJu0Yxer23L8lKq85rTEZrBNGLX5BwpLGAW0x9eLyhXPJY9IIYwhmSj
	0q91aUJ4w3P+ezkWPpWOfAXxIORe27/25w==
X-Google-Smtp-Source: AGHT+IHT9hLIDtKWUL7+iyviGEeFPlJ76ByGG4B89DPAPnzTOys7Lz1CfgxOE1NClC+YCP33KOvSsA==
X-Received: by 2002:a17:902:ea0e:b0:1c1:ee23:bb75 with SMTP id s14-20020a170902ea0e00b001c1ee23bb75mr7367467plg.1.1696555131672;
        Thu, 05 Oct 2023 18:18:51 -0700 (PDT)
Received: from dmoe.c.googlers.com.com (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001c20c608373sm2413776plf.296.2023.10.05.18.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 18:18:51 -0700 (PDT)
From: David Morley <morleyd.kernel@gmail.com>
To: David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	David Morley <morleyd@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net-next v3 2/2] tcp: change data receiver flowlabel after one dup
Date: Fri,  6 Oct 2023 01:18:41 +0000
Message-ID: <20231006011841.3558307-3-morleyd.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231006011841.3558307-1-morleyd.kernel@gmail.com>
References: <20231006011841.3558307-1-morleyd.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Morley <morleyd@google.com>

This commit changes the data receiver repath behavior to occur after
receiving a single duplicate. This can help recover ACK connectivity
quicker if a TLP was sent along a nonworking path.

For instance, consider the case where we have an initially nonworking
forward path and reverse path and subsequently switch to only working
forward paths. Before this patch we would have the following behavior.

+---------+--------+--------+----------+----------+----------+
| Event   | For FL | Rev FL | FP Works | RP Works | Data Del |
+---------+--------+--------+----------+----------+----------+
| Initial | A      | 1      | N        | N        | 0        |
+---------+--------+--------+----------+----------+----------+
| TLP     | A      | 1      | N        | N        | 0        |
+---------+--------+--------+----------+----------+----------+
| RTO 1   | B      | 1      | Y        | N        | 1        |
+---------+--------+--------+----------+----------+----------+
| RTO 2   | C      | 1      | Y        | N        | 2        |
+---------+--------+--------+----------+----------+----------+
| RTO 3   | D      | 2      | Y        | Y        | 3        |
+---------+--------+--------+----------+----------+----------+

This patch gets rid of at least RTO 3, avoiding additional unnecessary
repaths of a working forward path to a (potentially) nonworking one.

In addition, this commit changes the behavior to avoid repathing upon
rx of duplicate data if the local endpoint is in CA_Loss (in which
case the RTOs will already be changing the outgoing flowlabel).

Signed-off-by: David Morley <morleyd@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Tested-by: David Morley <morleyd@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c7c15d4b95e5..747ae84796e4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4511,15 +4511,23 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 {
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
-	 * The receiver remembers and reflects via DSACKs. Leverage the
-	 * DSACK state and change the txhash to re-route speculatively.
+	 * If it seems our ACKs are not reaching the other side,
+	 * based on receiving a duplicate data segment with new flowlabel
+	 * (suggesting the sender suffered an RTO), and we are not already
+	 * repathing due to our own RTO, then rehash the socket to repath our
+	 * packets.
 	 */
-	if (TCP_SKB_CB(skb)->seq == tcp_sk(sk)->duplicate_sack[0].start_seq &&
+#if IS_ENABLED(CONFIG_IPV6)
+	if (inet_csk(sk)->icsk_ca_state != TCP_CA_Loss &&
+	    skb->protocol == htons(ETH_P_IPV6) &&
+	    (tcp_sk(sk)->inet_conn.icsk_ack.lrcv_flowlabel !=
+	     ntohl(ip6_flowlabel(ipv6_hdr(skb)))) &&
 	    sk_rethink_txhash(sk))
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREHASH);
 
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
+#endif
 }
 
 static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
-- 
2.42.0.609.gbb76f46606-goog


