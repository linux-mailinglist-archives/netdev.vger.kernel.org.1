Return-Path: <netdev+bounces-94918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11BD8C1032
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271D51F23C95
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A3A152515;
	Thu,  9 May 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYx1uF8t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DDE15250D
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260410; cv=none; b=mYVpsfC+ASj+JcN2ZCE3xQGtjsoJRX5w0WNHlc8iZlq8H7fz2N2jUQZOij+R99fgfy+3v9WmW555baiBAEmebRXo3GyMCTUDJC4wn8SMEozKnJB+moX5dkB+nR2kMFzNFOB3r6gW64Zvw2zoL0r45hisNXXknul5e2NvFRCDEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260410; c=relaxed/simple;
	bh=SLFZJ3lLmiYwe2AItyvfBVa6JDmROE9yr2ZOeMperEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQGjmt+FyOPkykC9dgykrkFnBxA0pAJVt+eAMr5IyUnRA4brHWaGHPJyRScb2EDDCjgYVcdFwPeycUX7i2LdA5OAR6C9MMAmkyrbY1MeVkFZCWD35k78d66eIQ/aHD22JoKm+7xe2sxs8m3IZKH8kQ0f5L1OEYc1XWW/6l27bFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYx1uF8t; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f460e05101so635912b3a.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715260408; x=1715865208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwUa7uvnucrEZQF/v2D/40AfjpobsUJHNZ1U22Qj0zc=;
        b=SYx1uF8t9d87FrBLuCs6J+4hWA+tgfvOCTnWg6clUbTJ6rZXbMKnHdKPTu0NDuw7lw
         PYXS/M+IVxVo9FgG6lEzhqsY1FWWPTBvuUBRIAEN07DIMc5ZNA6ioXk1Y1rWbVFo3LF6
         OBiXvVliamXmS+r3ADCXCRuNOc76eVEdTHSBB1oHyFqvdpzh/bMxTXWdtv7LKGkY5Rbr
         RrtC2TlVsSFAMofgXgmiMjF2Z0F4UbvUUdPPwbRihnQQHn91eLEMObGOw7IAgKJs9BbI
         62NuOjxHV1ldDVq8vqh8NwvttZ+ITtdSmE11uVAiDYXw+npVpEbs3zZI1krzlwj7RPe4
         KqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260408; x=1715865208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwUa7uvnucrEZQF/v2D/40AfjpobsUJHNZ1U22Qj0zc=;
        b=DClc7SoHQxy18UojTggDG3M14RVg/pl1rZASeDkUo2xVgRu9CWZaGNlJePikXUPBki
         k+18YmKnD9yySKWI5OCMHSJSlv16OwAQFCoMPSOQbiWCr3S1N6r3HzDSPnWKXYszqpcv
         wh2tIZ+BIS1ncyGTKVLEiSBJtQq7p1D+m/jK0e28laQUY5lws2cDtcxPVeLydi8cbJ0p
         mv0vODk7J+YzFuUceFG0R4qt+kbLFX0uDtT3PEkuBeCHq4BqV6gIgE408Y7sEGCYyqRW
         Y4cHolmq1N7yUSQU0Wi3EAA6ae8FHkE31+CUoe/V81eQaNOtn/8m4vuMi3fyZso2jI70
         q34A==
X-Gm-Message-State: AOJu0Yxg0JHpl8sAV65DeA+ehYe+ncsILB4ZpECtolv036l2/TF/A2L3
	LLQM0lZND1UuZAoDlmEjdHV6ltmPP0Jny0Opd45ErCMk7u7EOWrS
X-Google-Smtp-Source: AGHT+IFPivDf1gorK+yiL8o40bp6ds0WHD8e3yxqe4LCEG562L21koPNkNXJiWv+1+pZIgaEDNIj8Q==
X-Received: by 2002:a05:6a20:9783:b0:1ae:4266:b39c with SMTP id adf61e73a8af0-1afd1444f67mr3457143637.17.1715260408183;
        Thu, 09 May 2024 06:13:28 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411346eebsm1133887a12.84.2024.05.09.06.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:13:27 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 3/5] tcp: fully support sk reset reason in tcp_rcv_state_process()
Date: Thu,  9 May 2024 21:13:04 +0800
Message-Id: <20240509131306.92931-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240509131306.92931-1-kerneljasonxing@gmail.com>
References: <20240509131306.92931-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like the previous patch does in this series, finish the conversion map is
enough to let rstreason mechanism work in this function.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index a32b0fa17de2..61855d4b27e2 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -12,6 +12,9 @@
 	FN(TCP_RFC7323_PAWS)		\
 	FN(TCP_TOO_OLD_ACK)		\
 	FN(TCP_ACK_UNSENT_DATA)		\
+	FN(TCP_FLAGS)			\
+	FN(TCP_OLD_ACK)			\
+	FN(TCP_ABORT_ON_DATA)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -56,6 +59,15 @@ enum sk_rst_reason {
 	SK_RST_REASON_TCP_TOO_OLD_ACK,
 	/** @SK_RST_REASON_TCP_ACK_UNSENT_DATA */
 	SK_RST_REASON_TCP_ACK_UNSENT_DATA,
+	/** @SK_RST_REASON_TCP_FLAGS: TCP flags invalid */
+	SK_RST_REASON_TCP_FLAGS,
+	/** @SK_RST_REASON_TCP_OLD_ACK: TCP ACK is old, but in window */
+	SK_RST_REASON_TCP_OLD_ACK,
+	/**
+	 * @SK_RST_REASON_TCP_ABORT_ON_DATA: abort on data
+	 * corresponding to LINUX_MIB_TCPABORTONDATA
+	 */
+	SK_RST_REASON_TCP_ABORT_ON_DATA,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
@@ -140,6 +152,12 @@ sk_rst_convert_drop_reason(enum skb_drop_reason reason)
 		return SK_RST_REASON_TCP_TOO_OLD_ACK;
 	case SKB_DROP_REASON_TCP_ACK_UNSENT_DATA:
 		return SK_RST_REASON_TCP_ACK_UNSENT_DATA;
+	case SKB_DROP_REASON_TCP_FLAGS:
+		return SK_RST_REASON_TCP_FLAGS;
+	case SKB_DROP_REASON_TCP_OLD_ACK:
+		return SK_RST_REASON_TCP_OLD_ACK;
+	case SKB_DROP_REASON_TCP_ABORT_ON_DATA:
+		return SK_RST_REASON_TCP_ABORT_ON_DATA;
 	default:
 		/* If we don't have our own corresponding reason */
 		return SK_RST_REASON_NOT_SPECIFIED;
-- 
2.37.3


