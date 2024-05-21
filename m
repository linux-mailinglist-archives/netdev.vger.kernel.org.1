Return-Path: <netdev+bounces-97354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D338CAF8E
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F391C214EC
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03B07CF39;
	Tue, 21 May 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIrtqfG8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506EF71B48
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298953; cv=none; b=QOIyBzgMMgDcaUsxDf8rjHeZ764dBOg39uY3wr8DrwSC+A8R4XMJwO+6NPHGHa29bKyyoICo8NjwYZhqoAc3Qq8T1GndlFNHnKtFa+fKriQtnsUyuS+WTBZztoxcwebf4OUCh3mLQcqSN2CgpS2mV6CSmyZjSbfZqQwBvcw9QMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298953; c=relaxed/simple;
	bh=+JR1omy9SObZJ2zGVJmFzzwtbk5Zk7FZoFxFgZop9lM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d7CtxGinFS9x4b/NosidX6Kq11WIcuwtbC1azPex3YMo6i06pRULCtfYoESFGCGl8hVnu4ArqjpIYQGmxE+Gb8QWYlyib08e6ts32JemlY49LW+GNfB2jJHk15Kap7T8vfXPdeoGLMiU9hNyrgOuWHPJ/Hl5PvrqecI4RYuWzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIrtqfG8; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b53350921fso862150eaf.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716298950; x=1716903750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YNMKmRwVQjKjZ8sjAy/G/XrKhwj5L0pb23pBrhzGkI8=;
        b=CIrtqfG8cV4N4qoQyoiku2m+3vxvYjlNhgcuxUDM0kArNvfb4eKvsskrU28hnzRdwY
         RrLQeJJwTTxXB5TT5uxMIibL/rDK6oC1f1x2txT3RRPEPkF4WzKTQ23E9hSm3Dk7GnZb
         G2Aw6rr0PZzoVZOqfRqMUemUvIcdfomd6eeaCRdkqhxTmwIL1tpw5xF5/iQjw4DcOeac
         GqRs88j7G/JrxXSubJVR/nodwnp0B4iA8znqeIdpAO82l8ILLNOa5/2VfhfiCuCv5G/W
         QlipLNjxrgDegnxFcFI70zDfnlK1Umbz09+4tA7bLzNNYmF/H3q4cThFWzmY2Kg6jDIc
         cuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716298950; x=1716903750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNMKmRwVQjKjZ8sjAy/G/XrKhwj5L0pb23pBrhzGkI8=;
        b=VjmeOw3QiCnYTqy1tJa391PioJtvg9JRzYaEKRYgfoQlGFeBRzDx2YEGBEuURWg44B
         d34VjgX/KBpeTUMtVzsgemPeebUPwnXI7WT2FeXFDrc3Cs+yb1PBxhQT8r6X07l6Fd9B
         ivF3AVnA0+Jo3w7VeMuCVv8U+7gfDEN5DdpXxSSWCIbhoR6gsTi719c8kxp2dRs98gSW
         j8sY/rZ80AcINHapqBH0KociDvVTfZc8G+b2djWYzCzBldnqrc+iHiH/nzGdnnfd7p7z
         bzRTovdulQEQecMkr10oDi+QJ5Z24fkf08cuhBEObOpedLli4T98QguO/WnRjvA03ewV
         Yc1w==
X-Gm-Message-State: AOJu0YzERppVvMrYHHDo01YY5p34n85KnY6yCERAvq+DJzX/5bfSsTHF
	wpuQQRAxvOAWi1axf5dcunImH6SeFDjQM0SeL0mYnXnV55uft/EFGnfTOm4d
X-Google-Smtp-Source: AGHT+IFnWkLg7qOdsbC2nas25H0tywQgMPJPNHvMzujImx+9g4nI8pTvWv380VKvGDn6QyIuKWHBCg==
X-Received: by 2002:a05:6359:4588:b0:186:1d2a:a457 with SMTP id e5c5f4694b2df-193bb656353mr3536872755d.15.1716298950152;
        Tue, 21 May 2024 06:42:30 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66686sm20758977b3a.29.2024.05.21.06.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 06:42:29 -0700 (PDT)
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
Subject: [PATCH net] tcp: remove 64 KByte limit for initial tp->rcv_wnd value
Date: Tue, 21 May 2024 21:42:20 +0800
Message-Id: <20240521134220.12510-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Recently, we had some servers upgraded to the latest kernel and noticed
the indicator from the user side showed worse results than before. It is
caused by the limitation of tp->rcv_wnd.

In 2018 commit a337531b942b ("tcp: up initial rmem to 128KB and SYN rwin
to around 64KB") limited the initial value of tp->rcv_wnd to 65535, most
CDN teams would not benefit from this change because they cannot have a
large window to receive a big packet, which will be slowed down especially
in long RTT. Small rcv_wnd means slow transfer speed, to some extent. It's
the side effect for the latency/time-sensitive users.

To avoid future confusion, current change doesn't affect the initial
receive window on the wire in a SYN or SYN+ACK packet which are set within
65535 bytes according to RFC 7323 also due to the limit in
__tcp_transmit_skb():

    th->window      = htons(min(tp->rcv_wnd, 65535U));

In one word, __tcp_transmit_skb() already ensures that constraint is
respected, no matter how large tp->rcv_wnd is. The change doesn't violate
RFC.

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

When we apply such a patch, having a large rcv_wnd if the user tweak this
knob can help transfer data more rapidly and save some rtts.

Fixes: a337531b942b ("tcp: up initial rmem to 128KB and SYN rwin to around 64KB")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v1
Link: https://lore.kernel.org/all/20240518025008.70689-1-kerneljasonxing@gmail.com/
1. refine the changelog (Eric)
2. add fixes tag to make sure the fix is backported (Eric)

RFC v2
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


