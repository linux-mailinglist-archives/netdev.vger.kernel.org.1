Return-Path: <netdev+bounces-88250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E288A676F
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992101C21451
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749AB86244;
	Tue, 16 Apr 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDRAFDxS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF49F8613E
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261058; cv=none; b=UY1R7iuik2iU/wpuTdpurtf8xeJt/qYtCMREQ//nwG9e9l7CfHYE+9rUL4JAJR42KB0Abx0cS6EcfE/yGdc5VnKjwBYlYuNgKmnDkUnEFRzlHrJw8z4K79OMnon2kRqB2EjmFPfEpZVe70CSR0jfDDP4aC2JkZ4aXPUkor43C1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261058; c=relaxed/simple;
	bh=mOxZqIdDVBPuKxshPRPiawT/H4/WeoeGwT9gQ8kJjy0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QEntArEP1w2qFv6s3slI2XzBfh3v4sOAApjDd5rvieKVVzm/y0hmfQ6FGq0SXaB1M/a1ReP7ctr2xHu+dUbf6g+dsul6p7lFnC0I+Aq1ck2l9dNzUSCygKEY1zAVpy7GShUqRlvdFOQ8ZI8L0O+crFtHn0qwVYa+crGdT+ps3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FDRAFDxS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so5610596276.2
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713261056; x=1713865856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UIMpOuLTlnaZ1Dr1cu/jZgiVKqa7OV92G9GRzV8jxzg=;
        b=FDRAFDxSqR66UJt7Rc/OA4FKnlK3iOTeJsTC8d9ws8ReALCMWoR1Gq5//jsyX6GZNi
         638NBjUnPFE9mOEYWE3nRGtkU3ZZHblrJBLZ9zyj8qE1xKJSiBpH6mENOswxflLDiByY
         qNY6zISuNaJu6ya2QDNwHtrjGBdX9vLkeb+MaIMZPgy//Oril/gu+QA6mi18rGBly1Wa
         2uOKZ0xcRl81VTCnHwwaBWznFvCVBv5/tGkyz11oUYTLH0sVa1TnLr+iBncHHAgp98WZ
         +b5DP92e6FgOO8+RqxbPmUjWQCoaGaoBkix3KAzXzARU4jI9eRlnb263XBFWvGvksV4y
         C/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261056; x=1713865856;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIMpOuLTlnaZ1Dr1cu/jZgiVKqa7OV92G9GRzV8jxzg=;
        b=bwHJi0a7tF+l+X0RGlEUMNXMHasgfh8Wjah0EFUijGUdFkYBt7Jwx8qdKhgevGTzWP
         d7OZb/++dHfNmR0ECv6IYjxJo3XmWKhs8BKWjg9uPhLI+kaSLvV2sWSnCPcTrjuogVzC
         U6VETtDrxcziQtRHxAnUr9/sywxmt4//92kf2PZFdz/63kUKn4s4V9DCyzPZbwtRS2TF
         ebhDXigLyakTnyPiK8MUw01t21QxHooMoB7yA/Y6HWLZRC6ZSkuCjT7brF85SPE5ni3Y
         jw6yRiDOY8P/CCwcDcV9sFthvFwlQDoQtdCWiJkrIYGTaTJoHzLkkJx7CUp3rnMS0ror
         F4hg==
X-Gm-Message-State: AOJu0YzqQm25gScWcoKXwSJCvj/0zDtDG7DV3ALyrV8Zz7rR4M65s05R
	/J+Z4ujquj+NNuHtNC8Mui45pmCm5CQI2Bci7XS8Y7jQNH7I+pDHj8+t4Z9a515swsQ82v0phGQ
	qwJEhxlUDYg==
X-Google-Smtp-Source: AGHT+IGyY/ZdHYPVkOhImOjWBCfNiGEBdkbRGcDCKeksRsrCJOo3q5ivFnN+wLtiuvTU5P0CbNlZuEDcQRgj3g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1885:b0:dd9:2789:17fb with SMTP
 id cj5-20020a056902188500b00dd9278917fbmr1382851ybb.3.1713261055823; Tue, 16
 Apr 2024 02:50:55 -0700 (PDT)
Date: Tue, 16 Apr 2024 09:50:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240416095054.703956-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: accept bare FIN packets under memory pressure
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Andrew Oates <aoates@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Christoph Paasch <cpaasch@apple.com>, 
	Vidhi Goel <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"

Andrew Oates reported that some macOS hosts could repeatedly
send FIN packets even if the remote peer drops them and
send back DUP ACK RWIN 0 packets.

<quoting Andrew>

 20:27:16.968254 gif0  In  IP macos > victim: Flags [SEW], seq 1950399762, win 65535, options [mss 1460,nop,wscale 6,nop,nop,TS val 501897188 ecr 0,sackOK,eol], length 0
 20:27:16.968339 gif0  Out IP victim > macos: Flags [S.E], seq 2995489058, ack 1950399763, win 1448, options [mss 1460,sackOK,TS val 3829877593 ecr 501897188,nop,wscale 0], length 0
 20:27:16.968833 gif0  In  IP macos > victim: Flags [.], ack 1, win 2058, options [nop,nop,TS val 501897188 ecr 3829877593], length 0
 20:27:16.968885 gif0  In  IP macos > victim: Flags [P.], seq 1:1449, ack 1, win 2058, options [nop,nop,TS val 501897188 ecr 3829877593], length 1448
 20:27:16.968896 gif0  Out IP victim > macos: Flags [.], ack 1449, win 0, options [nop,nop,TS val 3829877593 ecr 501897188], length 0
 20:27:19.454593 gif0  In  IP macos > victim: Flags [F.], seq 1449, ack 1, win 2058, options [nop,nop,TS val 501899674 ecr 3829877593], length 0
 20:27:19.454675 gif0  Out IP victim > macos: Flags [.], ack 1449, win 0, options [nop,nop,TS val 3829880079 ecr 501899674], length 0
 20:27:19.455116 gif0  In  IP macos > victim: Flags [F.], seq 1449, ack 1, win 2058, options [nop,nop,TS val 501899674 ecr 3829880079], length 0

 The retransmits/dup-ACKs then repeat in a tight loop.

</quoting Andrew>

RFC 9293 3.4. Sequence Numbers states :

  Note that when the receive window is zero no segments should be
  acceptable except ACK segments.  Thus, it is be possible for a TCP to
  maintain a zero receive window while transmitting data and receiving
  ACKs.  However, even when the receive window is zero, a TCP must
  process the RST and URG fields of all incoming segments.

Even if we could consider a bare FIN.ACK packet to be an ACK in RFC terms,
the retransmits should use exponential backoff.

Accepting the FIN in linux does not add extra memory costs,
because the FIN flag will simply be merged to the tail skb in
the receive queue, and incoming packet is freed.

Reported-by: Andrew Oates <aoates@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Christoph Paasch <cpaasch@apple.com>
Cc: Vidhi Goel <vidhi_goel@apple.com>
---
 net/ipv4/tcp_input.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5a45a0923a1f058cdc80255be0f76a71fd102d4d..384fa5e2f0655389ac678b5d13553949598a9c74 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5174,6 +5174,16 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (TCP_SKB_CB(skb)->seq == tp->rcv_nxt) {
 		if (tcp_receive_window(tp) == 0) {
+			/* Some stacks are known to send bare FIN packets
+			 * in a loop even if we send RWIN 0 in our ACK.
+			 * Accepting this FIN does not hurt memory pressure
+			 * because the FIN flag will simply be merged to the
+			 * receive queue tail skb in most cases.
+			 */
+			if (!skb->len &&
+			    (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
+				goto queue_and_out;
+
 			reason = SKB_DROP_REASON_TCP_ZEROWINDOW;
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
 			goto out_of_window;
@@ -5188,7 +5198,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 			inet_csk_schedule_ack(sk);
 			sk->sk_data_ready(sk);
 
-			if (skb_queue_len(&sk->sk_receive_queue)) {
+			if (skb_queue_len(&sk->sk_receive_queue) && skb->len) {
 				reason = SKB_DROP_REASON_PROTO_MEM;
 				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
 				goto drop;
-- 
2.44.0.683.g7961c838ac-goog


