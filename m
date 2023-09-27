Return-Path: <netdev+bounces-36564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057437B07EC
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 17:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 94E7E281CDE
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906293AC29;
	Wed, 27 Sep 2023 15:15:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541F38FB6
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 15:15:08 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40439F5
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:15:07 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77574c6cab0so94307485a.3
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695827706; x=1696432506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORIn1A7s/0tWSsc9QSeckLC4AflhU8YOvNqZo+tbNd0=;
        b=KvKy8dVq/fzvp+MImLwVnmPRR4S9mcnDotWa54pgLhl/CBF9ROSaO2zLMR9HIq6RIB
         mStBpzPBVX7De/nITI6bBTSU5YVEafZ2pUhrSTHPB6DpiwChTVkX44njzGgFUF3bwsUh
         v4heq2mMYyRo/mcbu4EuSLBMx/X3SCnunh9oIlVB+7am1vtJBTriTfPSIn4h+n54c04d
         izXNcwBC72hVwLRMRtyZbg1kmYwK3s+SWAOQVlFmq00os9je3rcd4hVxyXKL8bzaJhtG
         h661wa7zLsS3feA1Qaz2GyguUXvoPCswyHppqtS+XV0hkCcKZC54uqiL7WtHaAlIHsnw
         IwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695827706; x=1696432506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORIn1A7s/0tWSsc9QSeckLC4AflhU8YOvNqZo+tbNd0=;
        b=wSV+9yvZUgOxum+aX4VX5oyU9Mm0eu7SLs/SfQWe/Jhl8iw946DM/slF/KGn28Cj3Z
         aXGpYgp1V2EF/z8TCCfhevGJs+6AS3mwpohE64/af6jUITsKLuuqPBCx1M12TIdaw1RW
         e148yMLqDQchTrIuzf8HQBrTRofDFyuwUKdMPUCE7ZTnYIxNtaKX9KcFDe1q+1oT9nU1
         gQPYoOiMSeMUL3qBA2gfVJYUZFUrghiHvbwRrqqjjiIb7teUXKvYzg2J6t+zRVEBpgGn
         4H8JFn1CuD7MT7TQMB4cCneeV3jWJjZcUnorCxwi5b0k09eoqgg4yZODjxPxUnj8gn9B
         LEDg==
X-Gm-Message-State: AOJu0YweDQJ6t+fMB2TVgaf82ZzM+CEmyva8bdBUurJ0eETXetNe0ZFP
	MqRF4uywilRh4x4/zDYmWQo=
X-Google-Smtp-Source: AGHT+IFfW98Wrz1BIDURkn1XB/nO0ZKUTNCJ5e7ptWA4YnKtWYCZB7CXFPWK9648tBAd8xyVRnA2yw==
X-Received: by 2002:a05:620a:2456:b0:76f:19fd:5063 with SMTP id h22-20020a05620a245600b0076f19fd5063mr2208738qkn.34.1695827706230;
        Wed, 27 Sep 2023 08:15:06 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:416:3cb2:ba69:4389:2a97])
        by smtp.gmail.com with ESMTPSA id r25-20020a05620a03d900b00767e2668536sm5533069qkm.17.2023.09.27.08.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:15:05 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net 2/2] tcp: fix delayed ACKs for MSS boundary condition
Date: Wed, 27 Sep 2023 11:15:01 -0400
Message-ID: <20230927151501.1549078-2-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230927151501.1549078-1-ncardwell.sw@gmail.com>
References: <20230927151501.1549078-1-ncardwell.sw@gmail.com>
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

From: Neal Cardwell <ncardwell@google.com>

This commit fixes poor delayed ACK behavior that can cause poor TCP
latency in a particular boundary condition: when an application makes
a TCP socket write that is an exact multiple of the MSS size.

The problem is that there is painful boundary discontinuity in the
current delayed ACK behavior. With the current delayed ACK behavior,
we have:

(1) If an app reads > 1*MSS data, tcp_cleanup_rbuf() ACKs immediately
    because of:

     tp->rcv_nxt - tp->rcv_wup > icsk->icsk_ack.rcv_mss ||

(2) If an app reads < 1*MSS data and either (a) app is not ping-pong or
    (b) we received two packets <1*MSS, then tcp_cleanup_rbuf() ACKs
    immediately beecause of:

     ((icsk->icsk_ack.pending & ICSK_ACK_PUSHED2) ||
      ((icsk->icsk_ack.pending & ICSK_ACK_PUSHED) &&
       !inet_csk_in_pingpong_mode(sk))) &&

(3) *However*: if an app reads exactly 1*MSS of data,
    tcp_cleanup_rbuf() does not send an immediate ACK. This is true
    even if the app is not ping-pong and the 1*MSS of data had the PSH
    bit set, suggesting the sending application completed an
    application write.

Thus if the app is not ping-pong, we have this painful case where
>1*MSS gets an immediate ACK, and <1*MSS gets an immediate ACK, but a
write whose last skb is an exact multiple of 1*MSS can get a 40ms
delayed ACK. This means that any app that transfers data in one
direction and takes care to align write size or packet size with MSS
can suffer this problem. With receive zero copy making 4KB MSS values
more common, it is becoming more common to have application writes
naturally align with MSS, and more applications are likely to
encounter this delayed ACK problem.

The fix in this commit is to refine the delayed ACK heuristics with a
simple check: immediately ACK a received 1*MSS skb with PSH bit set if
the app reads all data. Why? If an skb has a len of exactly 1*MSS and
has the PSH bit set then it is likely the end of an application
write. So more data may not be arriving soon, and yet the data sender
may be waiting for an ACK if cwnd-bound or using TX zero copy. Thus we
set ICSK_ACK_PUSHED in this case so that tcp_cleanup_rbuf() will send
an ACK immediately if the app reads all of the data and is not
ping-pong. Note that this logic is also executed for the case where
len > MSS, but in that case this logic does not matter (and does not
hurt) because tcp_cleanup_rbuf() will always ACK immediately if the
app reads data and there is more than an MSS of unACKed data.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 06fe1cf645d5a..8afb0950a6979 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -253,6 +253,19 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 		if (unlikely(len > icsk->icsk_ack.rcv_mss +
 				   MAX_TCP_OPTION_SPACE))
 			tcp_gro_dev_warn(sk, skb, len);
+		/* If the skb has a len of exactly 1*MSS and has the PSH bit
+		 * set then it is likely the end of an application write. So
+		 * more data may not be arriving soon, and yet the data sender
+		 * may be waiting for an ACK if cwnd-bound or using TX zero
+		 * copy. So we set ICSK_ACK_PUSHED here so that
+		 * tcp_cleanup_rbuf() will send an ACK immediately if the app
+		 * reads all of the data and is not ping-pong. If len > MSS
+		 * then this logic does not matter (and does not hurt) because
+		 * tcp_cleanup_rbuf() will always ACK immediately if the app
+		 * reads data and there is more than an MSS of unACKed data.
+		 */
+		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_PSH)
+			icsk->icsk_ack.pending |= ICSK_ACK_PUSHED;
 	} else {
 		/* Otherwise, we make more careful check taking into account,
 		 * that SACKs block is variable.
-- 
2.42.0.515.g380fc7ccd1-goog


