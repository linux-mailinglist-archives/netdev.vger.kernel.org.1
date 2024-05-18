Return-Path: <netdev+bounces-97054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C682F8C8F62
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 04:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC3F1C210DE
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 02:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0D61A2C10;
	Sat, 18 May 2024 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTbMJ65t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09AA1A2C0B
	for <netdev@vger.kernel.org>; Sat, 18 May 2024 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716000623; cv=none; b=LxRfSuge0jPcP+UL0AE10r+iEgoewruICgnL0lO0e2WOi+ggsRl4yK/5aYVZUPA5w4jxRX2I2N+r6ocCMCgpeFzn4Xd0D99qoV8G8o4jmBHQgqjo1BVJ77/3QRK7ykxcJsRoILzOve8JqsiuMie7nFmYdBLCblZ1Da4yNnUIGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716000623; c=relaxed/simple;
	bh=XuT76T378PQs995zqV5Vdn45kTr1FrNS9uVF9dXhRm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pB2su4AAcFeR81wh6sL+4H30r0Ibd1z9ge440V5/ExAbIEyrsBDbWHH1oadyHeBBqNY3WniKSyO8Sm3MCPXtQkQhYR9e1s5Mm5CbQa+wAYZuk6PT8DfkB5s2wVSdpHi3m4qcw9zCmzOfeu9oZCZ1rPbNAgxWwySrwj+fPy0gEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTbMJ65t; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f0537e39b3so26541995ad.3
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 19:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716000621; x=1716605421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMJkwBzaqdnYaxVcfkeJzQO/ELTLT+sSzHLtJ1jKhdg=;
        b=HTbMJ65t1Mrs/JG+smHM/UfJBZZ/pv8t+rfgwAt2SKv4KQnVaGQPggCp3QDUdZUPuz
         2wFsy7I4f4V87sSvpp58jCwc1tXN8vjYLo9bupXO3MNiJrf151PZsNqdJthRpSH1i/GQ
         K6lazb2BInPo4KW1OrHSsz6RvdfBReC2IL4iDykpu0VTyxmszY6fMTJUKnM1kCIX2Nvk
         bSU8pPfrNhwidYtJXbO0+9JhRBh6mW0rlnx8lKD3MXkvBsPh9nU46PJf8neNgDEFZ58H
         H7Mte7fGjOHPR55QMQsJ51JZ8SViQF8CIBdOFOtdISRf5F7TFUqpmU8Zi/c2mtWeeLBf
         rjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716000621; x=1716605421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMJkwBzaqdnYaxVcfkeJzQO/ELTLT+sSzHLtJ1jKhdg=;
        b=Z0TjPC7fU/uthTQLnYv0CqcHGwr8+/tOktXr9r1EuCJtJOBfAAKQz0UEyq5TCE4rJi
         AbFUu7SNxu+EN5pa8WxQFEhkJkvVhD7cPDgeJwi1cF2Zjltyii2CDK6lXyZI5mLyqDNJ
         IFfNgWxUCdRxZxGT4pA88x8yO+8TpjkLcJgHqVRhTCkpYIroQ5NwrgpZ5M7SntSKJ9xi
         Q1646e2OxOYdWHs2rIdhcFsAbDHlXZ3OYyUt01uYuShphH3Un6PumkckpTEDb4cIP+Mu
         lRFJwaN0ugvhiBiryIr/FHyduGTM8S6JY37lMUVTV5BuVCTCxUAROZl8T/F+k3G/xkmW
         o83Q==
X-Gm-Message-State: AOJu0YyFwrh2wDisSnXUBDfv/19YGLPbS+WyuFnz5RI/jlYn8JkPSweg
	1YTWfu8qjgCTjgxHW8QrT7MYHbD1THqg0+AS0tE52kcxNdgnkD7E
X-Google-Smtp-Source: AGHT+IGJeqzc3yxxIG2PhzCs097SYsIqYTm6X6aISkDeiyDXX3FPidxWNL5pWfBmT8KQWDUQjCATkQ==
X-Received: by 2002:a05:6a00:23d3:b0:6f3:ef3d:60f4 with SMTP id d2e1a72fcca58-6f4e03a2c5amr28690463b3a.33.1716000620753;
        Fri, 17 May 2024 19:50:20 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f679f4b495sm4915398b3a.115.2024.05.17.19.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 19:50:20 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [RFC PATCH v2 net-next] tcp: remove 64 KByte limit for initial tp->rcv_wnd value
Date: Sat, 18 May 2024 10:50:08 +0800
Message-Id: <20240518025008.70689-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In 2018 commit a337531b942b ("tcp: up initial rmem to 128KB and SYN rwin
to around 64KB") limited the initial value of tp->rcv_wnd to 65535, most
CDN team would not benefit from this change because they cannot have a
large window to receive a big packet, which will be slowed down especially
in long RTT.

According to RFC 7323, it says:
  "The maximum receive window, and therefore the scale factor, is
   determined by the maximum receive buffer space."

So we can get rid of this 64k limitation and let the window be tunable if
the user wants to do it within the control of buffer space. Then many
companies, I believe, can have the same behaviour as old days. Besides,
there are many papers conducting various interesting experiments which
have something to do with this window and show good outputs in some cases,
say, paper [1] in Yahoo! CDN.

To avoid future confusion, current change doesn't affect the initial
receive window on the wire in a SYN or SYN+ACK packet which are set within
65535 bytes according to RFC 7323 also due to the limit in
__tcp_transmit_skb():

    th->window      = htons(min(tp->rcv_wnd, 65535U));

In one word, __tcp_transmit_skb() already ensures that constraint is
respected, no matter how large tp->rcv_wnd is.

Let me provide one example if with or without the patch:
Before:
client   --- SYN: rwindow=65535 ---> server
client   <--- SYN+ACK: rwindow=65535 ----  server
client   --- ACK: rwindow=65536 ---> server
Note: for the last ACK, the calculation is 512 << 7.

After:
client   --- SYN: rwindow=65535 ---> server
client   <--- SYN+ACK: rwindow=65535 ----  server
client   --- ACK: rwindow=175232 ---> server
Note: I use the following command to make it work:
ip route change default via [ip] dev eth0 metric 100 initrwnd 120
For the last ACK, the calculation is 1369 << 7.

We can pay attention to the last ACK in 3-way shakehand and notice that
with the patch applied the window can reach more than 64 KByte.

[1]: https://conferences.sigcomm.org/imc/2011/docs/p569.pdf

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20240517085031.18896-1-kerneljasonxing@gmail.com/
1. revise the title and body messages (Neal)
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 95caf8aaa8be..95618d0e78e4 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -232,7 +232,7 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_windows))
 		(*rcv_wnd) = min(space, MAX_TCP_WINDOW);
 	else
-		(*rcv_wnd) = min_t(u32, space, U16_MAX);
+		(*rcv_wnd) = space;
 
 	if (init_rcv_wnd)
 		*rcv_wnd = min(*rcv_wnd, init_rcv_wnd * mss);
-- 
2.37.3


