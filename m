Return-Path: <netdev+bounces-141775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2111D9BC371
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE2D1F22AD5
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D89A51016;
	Tue,  5 Nov 2024 02:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLh+qQaz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B699487BF
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775324; cv=none; b=CifcKk6Bw5c/a0M+24uaLMHri5JeeE8/cyzJeyCjOqWDZ2OW5TYai0zMNwmd4LZIQY+oWdXz35+hgrA2OjCxSxKP+os5FCi+KrtulPy5Fi6LA760iwOqU1WoVjIuuweN5lVJFk8tla/Cg2aqIi6oEqvI25FadKH7qhts/alXCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775324; c=relaxed/simple;
	bh=fYESvmZ9wQxqKk7XYozOvG9cMDRrBn3xIMF+CDjQvYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qDyt2VcpE+ExNxbkznPO/jQ3oCVJXERhdRjZU030skwRru5acU560PE8Oio5D8Bko2Lg9sVsIfw39EKtWcbUPWAvaiLVGHN64fIODoxjLBEqj/edjP1tfhcD/pWckwoSkDpw3zIrcdSqEHNdqeIxdESF2ClC5X82iXFTwRvTBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLh+qQaz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso3672803b3a.3
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 18:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730775322; x=1731380122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vOmoD074tVmed3p+vLTP8dGXLEfHzdncz/1XSUnK3/Q=;
        b=BLh+qQazarhpPl1iDJ2bYe1jgh1P6QC485VR9sUd2VdEae0ox1AUjyWekalsbwMGZJ
         lyD0HMGTB0xCmU1clP76BdxZLmT71oD8Pu7ZOAJXU1zNWJH4lk+3QPauxwUBVwsTdQXL
         uRVvXmiL9wOO71dToAMdsOjofo1mE1SeMYVEKR/fSga0mHz+bnj8l52o243VC1l0rM6v
         n+eDZOl0Y/D9bgQCOVjXgKpCdVAyw+UGOm4Gb0OHRQ0jCKhblW9YxaSgn9kO6EDCgSsZ
         mkWM4JNTxWmAZYtkKazR98ivClnYlfJUVikKdn6kJvS1fCpe5AJjssww8BCM6LtVx8W1
         g1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775322; x=1731380122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOmoD074tVmed3p+vLTP8dGXLEfHzdncz/1XSUnK3/Q=;
        b=F1UCGQVtcFBSpJ1hGOk8JwJw+B4dpX/fFg4fV1UvSywf2rSCZiFyTdpwFiUdHCP+ak
         dUtg8iqrSuCE0odI4oxpOHLczEQG0ogswCLTwgD+inuqSg5AclQQCCYb1qvtYDlNhDG/
         ZtrtH5sTXMoYmRV1QSL96Nd3pLI97KUVR7sAhxFUUIk2VCJPTlYY36TN6m9/rJrg8SEq
         Fiu1yq2iafo6clgf3pjmBN3HFvGPuUjkOxgTFtuvKkmppJmDsGsNDgT5rG84LkZSQkVX
         veehqtYn8XGAGReKxKxm7N0YSvnlPq3fxtva1sDumfJbnV9Qo+n8X5HXWN8o9hCzfqkZ
         DmUw==
X-Gm-Message-State: AOJu0YxH6cYERMFfhvq5/39ha8pwmSnGYhruU6O0i4gTDedkzKsp30+E
	NDpV7xVcjah2Jz/+FpASUqvC/hE4/U6HD/v7nk2jAKXbozJSkg4o
X-Google-Smtp-Source: AGHT+IGBWrUHHTExOxmP8oGc+C6o+vRvF2whcqg+f1yAm8j6MaJbA/mKuJjLN18Ns5bYAy4bZB35ZA==
X-Received: by 2002:a05:6a20:db0a:b0:1d2:e81c:adc0 with SMTP id adf61e73a8af0-1d9a8506e15mr49599921637.46.1730775322199;
        Mon, 04 Nov 2024 18:55:22 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452a8b3fsm7980857a12.28.2024.11.04.18.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 18:55:21 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to failure in tcp_timewait_state_process
Date: Tue,  5 Nov 2024 10:55:11 +0800
Message-Id: <20241105025511.42652-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

We found there are rare chances that some RST packets appear during
the shakehands because the timewait socket cannot accept the SYN and
doesn't return TCP_TW_SYN in tcp_timewait_state_process().

Here is how things happen in production:
Time        Client(A)        Server(B)
0s          SYN-->
...
132s                         <-- FIN
...
169s        FIN-->
169s                         <-- ACK
169s        SYN-->
169s                         <-- ACK
169s        RST-->
As above picture shows, the two flows have a start time difference
of 169 seconds. B starts to send FIN so it will finally enter into
TIMEWAIT state. Nearly at the same time A launches a new connection
that soon is reset by itself due to receiving a ACK.

There are two key checks in tcp_timewait_state_process() when timewait
socket in B receives the SYN packet:
1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0)

Regarding the first rule, it fails as expected because in the first
connection the seq of SYN sent from A is 1892994276, then 169s have
passed, the second SYN has 239034613 (caused by overflow of s32).

Then how about the second rule?
It fails again!
Let's take a look at how the tsval comes out:
__tcp_transmit_skb()
    -> tcp_syn_options()
        -> opts->tsval = tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb) + tp->tsoffset;
The timestamp depends on two things, one is skb->skb_mstamp_ns, the
other is tp->tsoffset. The latter value is fixed, so we don't need
to care about it. If both operations (sending FIN and then starting
sending SYN) from A happen in 1ms, then the tsval would be the same.
It can be clearly seen in the tcpdump log. Notice that the tsval is
with millisecond precision.

Based on the above analysis, I decided to make a small change to
the check in tcp_timewait_state_process() so that the second flow
would not fail.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_minisocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bb1fe1ba867a..2b29d1bf5ca0 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -234,7 +234,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	if (th->syn && !th->rst && !th->ack && !paws_reject &&
 	    (after(TCP_SKB_CB(skb)->seq, rcv_nxt) ||
 	     (tmp_opt.saw_tstamp &&
-	      (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0))) {
+	      (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) <= 0))) {
 		u32 isn = tcptw->tw_snd_nxt + 65535 + 2;
 		if (isn == 0)
 			isn++;
-- 
2.37.3


