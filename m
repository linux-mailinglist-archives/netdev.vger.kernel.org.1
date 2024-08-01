Return-Path: <netdev+bounces-115029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8F3944E92
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6F728381E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FBF1AAE1A;
	Thu,  1 Aug 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6U84JfE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6F1A99CA
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524110; cv=none; b=uEgl1BZMhIJLkIK738ECQ+tL+e/jkwQnKjZIgUxgWP89BvU9w121DYxF47FLU+xlQ+4jvEcV+eOjeuCPKKqNF+yABPMQjV/8+pKN0LZrPT90WSFDgbeYvSMWBwlLsSlVfKs1Zt+vlXS//y/C++RkVDwwT4yo3fm4XRjxjYN7WeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524110; c=relaxed/simple;
	bh=Dmj0V8OgWfrKhtt5PsVnzjpF+7ohbvzn4v0q56t8OwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JhHEshEiPYU5myDYnXeQL3OxyocUAEst52cckJYptH4poa4sqt1bmtPuMiMENnu3MPvf/lwJgCN0AdLzV62LhfuWteZe+ZEvshmIjrbo0MD0s8aFpi9bccNQjqcfjmJVhfbmf1fLjkCybjorGpaL4q96MBBW8YaOJoPGZaB6y08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6U84JfE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso5258540b3a.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722524108; x=1723128908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2rLibpd7acGhdAc2vkJkolLEgSRjykoNKK1O8+4F18=;
        b=l6U84JfEFkEdlRasTCumvSGgp7IH3H67yRMa0ORCO0BWtQjc9PJGRh+oAYYmoL4Dnz
         sOwtCmA29Hg00NgxnBtTQr3rvythON+Le76QPZ38s5wSEDcRDyk+7hIWtoiJIhX7DWEP
         T1OETtYS+LgNwR68V4HUWtB2CKqgHCZCRNjiMjPfVdRoO11pfm2BE3nhx2p/E3G6sAk8
         L1/9/8hYQADFw5q5AF5Pu+FL292+JUkhpDOPaYD/0+oI83spZCY3c7npdw+zokBGdozD
         FXRPWJX9Qg7MohUYUqu3m3HhiD9caML/woZhDohdw3PYOGJsYZhxQzVbN9JAZyUmiHSn
         lhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524108; x=1723128908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2rLibpd7acGhdAc2vkJkolLEgSRjykoNKK1O8+4F18=;
        b=J+Ufupn4IFQiqs1V61pE1EAOwZ4LlW76tK8IcS0rfMs6y9aI/3dhU7UVMFEc9qjfBG
         OVgQBZbG8PWU7FX3FU/tN78GOU7zMD3eXd9mf1z5fmL+Yr25E99hdE4zZj58u031xR6/
         y1Cg65n88fn0Wrg1zhamvuLw/MiVFT0SWeqvoiIfpkfAGo8MM/e4ZN3T0PIaAuywDP2p
         QPQGWNIANp1CDf0Kq6/hlSH76aN3ff19TLYAi0xU3LaHlQQGMVc19z6scbAaOxsR0TTc
         4ofp92u1TclH6PE5ZNWRWQKSWMZ16CzY3LFptFEZwaTwXJKstIRh7MwJKXsqr+4rZCyS
         8rlA==
X-Gm-Message-State: AOJu0YwZ9Tqdr1omZgjWaeYvLOnSmp05HAcRi+esqA8QZVzBigqS5baA
	wsVYh4wabS8UyLUeioOTcgLwQUXGL9zO7C0wSr9jyh59OjKMH8Ho
X-Google-Smtp-Source: AGHT+IGwS437Iu3RZC5sYlLHe8H882zxhiDATHA3LoBUAiz5+I4lczDU7tl6ckCVbzVoxUqIAZi07g==
X-Received: by 2002:a05:6a21:e8d:b0:1c4:17e1:14d0 with SMTP id adf61e73a8af0-1c69966a6dbmr498208637.47.1722524108006;
        Thu, 01 Aug 2024 07:55:08 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a35c7sm11611739b3a.200.2024.08.01.07.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:55:07 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 6/7] tcp: rstreason: introduce SK_RST_REASON_TCP_DISCONNECT_WITH_DATA for active reset
Date: Thu,  1 Aug 2024 22:54:43 +0800
Message-Id: <20240801145444.22988-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240801145444.22988-1-kerneljasonxing@gmail.com>
References: <20240801145444.22988-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When user tries to disconnect a socket and there are more data written
into tcp write queue, we have to send an RST.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v3
Link: Link: https://lore.kernel.org/all/20240731120955.23542-5-kerneljasonxing@gmail.com/
1. This case is different from previous patch, so we need to write
it into a new patch. (Eric)
---
 include/net/rstreason.h | 8 ++++++++
 net/ipv4/tcp.c          | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index 9c0c46df0e73..69cb2e52b7da 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -22,6 +22,7 @@
 	FN(TCP_ABORT_ON_MEMORY)		\
 	FN(TCP_STATE)			\
 	FN(TCP_KEEPALIVE_TIMEOUT)	\
+	FN(TCP_DISCONNECT_WITH_DATA)	\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -115,6 +116,13 @@ enum sk_rst_reason {
 	 * keepalive timeout, we have to reset the connection
 	 */
 	SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT,
+	/**
+	 * @SK_RST_REASON_TCP_DISCONNECT_WITH_DATA: disconnect when write
+	 * queue is not empty
+	 * It means user has written data into the write queue when doing
+	 * disconnecting, so we have to send an RST.
+	 */
+	SK_RST_REASON_TCP_DISCONNECT_WITH_DATA,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 24777e48bcc8..8514257f4ecd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3033,7 +3033,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 		/* The last check adjusts for discrepancy of Linux wrt. RFC
 		 * states
 		 */
-		tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_NOT_SPECIFIED);
+		tcp_send_active_reset(sk, gfp_any(),
+				      SK_RST_REASON_TCP_DISCONNECT_WITH_DATA);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (old_state == TCP_SYN_SENT)
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
-- 
2.37.3


