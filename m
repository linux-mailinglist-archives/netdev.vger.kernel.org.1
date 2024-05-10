Return-Path: <netdev+bounces-95449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530968C24C2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429F71C21EBA
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9283E12B177;
	Fri, 10 May 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwvZMhfL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9374F1E5
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343914; cv=none; b=pkBffG4ziP9nbZ+wl8Cbrdqs8E3zmAQ5/6L8WV2Q+jEzsXHOOzmJm1dvaNQtsNpyZJkkuFyWOUfYzWSBVcv8aKDWhOVxw0Rg6Xb7nmLfGw6y/dK1amTYwwydpxW3gL5dDb389ZElwQ6s0eINPFAId4YWSF5jEEXt3RIdslxR/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343914; c=relaxed/simple;
	bh=OrfoT4YOwRlve6mV0AW69N1v9S7JlhMBl+7xYefdoZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=riKNffi4xUdk5+xgYaQrDkB6GRzKCczjYgKTCzfX0iawuvl0Ahu/18Irne4FP5F8PcvNQrXPLZ4wP9sx7IhvXzSGLVfOscFY8HByZcP3sMLgQSIgcbCywaRha5mt3nMzpLK38pYiqGmuziWfzYwcf4iCa/2H9zXJd12wK3Jwf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwvZMhfL; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36c6e69180fso7058995ab.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715343912; x=1715948712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq4Oif0buUnA9JqMotGU1jFbPA8b2GKc51i6wlfOjfg=;
        b=QwvZMhfLeMFpxIMsw2CyerntJUzNbmiHx+MszMZgyD2zNwU7QEHRgoltzzVdEiFjkF
         ArWKGp5qx/A5NwgNYA2Qsik2cdSaubrL29mQlM9SOVL34a8DAk7rjyPjYftWJv04UqKE
         dwZsybR2wzHyIfP0pu74AWJnO4Cv4XVFSs6Iq+iF5GhFLGLrheb+a2iI1UY//+5LFEMn
         BA5XTap3YCKdoLFWcMIQkUzpLUU7xYpY4fO5GbMccI8HOFBc0KU4wUrBLe6d/cfqzzN6
         Uqc1vkMQxNFiwetZM+97tXKvOoSqYoC6uKpKA0iI2tUHZaii91vfQK5Bygv+yeFzyOnm
         jpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715343912; x=1715948712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq4Oif0buUnA9JqMotGU1jFbPA8b2GKc51i6wlfOjfg=;
        b=jsRuFBImw1ObOSDfrURoSwzI2ALGAqlgiXCbh8kWQ1WUmdRHgjlNETo2F38DBcDehA
         v+Ww+mRtk2LNVLjVE5CTRQJD/4O4C2Z3OC00mhQgB85iHvHNEK4dElriq2U3DUQv+jp4
         pucZwWOMQH7oIAghAC7HOVc3vq6yRTwKHJMKGFGq7lOg3z00IY7g2E6UEV9XfAUNZcxa
         Zs4Zg2k6sG1tcwFp4y8C0QkpC60MeM5A14fvkWCQVwxXXGWUyH1Zbl4f5NdM85EN/yY7
         +7LEfgyb6pyajTuqL9G3zQw3iPAqV6PuJtndd1iF+njfFEjnASVaL+ffArip08G7omRv
         o8cQ==
X-Gm-Message-State: AOJu0YykNhEL+GN7kOtgYEsdENye0/Qv0cwwt+g/fi/fNMlyc0nOwmAe
	BLW2BdijQ8Vgc1u6t+3WpYV5hjDAB+7IUxxNfrQuGrUN1Thg+7Me
X-Google-Smtp-Source: AGHT+IF20w0wZzrB+orUxdMVjA8fPvyGn6djtVPMoKXJaJshCcwSWDQFeBzbXyeQuGcTwcp0DV/xig==
X-Received: by 2002:a92:c54b:0:b0:36c:7bdb:c86b with SMTP id e9e14a558f8ab-36cc143a021mr28596025ab.9.1715343911970;
        Fri, 10 May 2024 05:25:11 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b57f362sm2943530a12.30.2024.05.10.05.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:25:11 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/5] tcp: rstreason: fully support in tcp_rcv_synsent_state_process()
Date: Fri, 10 May 2024 20:24:58 +0800
Message-Id: <20240510122502.27850-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240510122502.27850-1-kerneljasonxing@gmail.com>
References: <20240510122502.27850-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In this function, only updating the map can finish the job for socket
reset reason because the corresponding drop reasons are ready.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index df3b6ac0c9b3..f87814a60205 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -8,6 +8,8 @@
 #define DEFINE_RST_REASON(FN, FNe)	\
 	FN(NOT_SPECIFIED)		\
 	FN(NO_SOCKET)			\
+	FN(TCP_INVALID_ACK_SEQUENCE)	\
+	FN(TCP_RFC7323_PAWS)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -37,6 +39,17 @@ enum sk_rst_reason {
 	SK_RST_REASON_NOT_SPECIFIED,
 	/** @SK_RST_REASON_NO_SOCKET: no valid socket that can be used */
 	SK_RST_REASON_NO_SOCKET,
+	/**
+	 * @SK_RST_REASON_TCP_INVALID_ACK_SEQUENCE: Not acceptable ACK SEQ
+	 * field because ack sequence is not in the window between snd_una
+	 * and snd_nxt
+	 */
+	SK_RST_REASON_TCP_INVALID_ACK_SEQUENCE,
+	/**
+	 * @SK_RST_REASON_TCP_RFC7323_PAWS: PAWS check, corresponding to
+	 * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
+	 */
+	SK_RST_REASON_TCP_RFC7323_PAWS,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
@@ -113,6 +126,10 @@ sk_rst_convert_drop_reason(enum skb_drop_reason reason)
 		return SK_RST_REASON_NOT_SPECIFIED;
 	case SKB_DROP_REASON_NO_SOCKET:
 		return SK_RST_REASON_NO_SOCKET;
+	case SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE:
+		return SK_RST_REASON_TCP_INVALID_ACK_SEQUENCE;
+	case SKB_DROP_REASON_TCP_RFC7323_PAWS:
+		return SK_RST_REASON_TCP_RFC7323_PAWS;
 	default:
 		/* If we don't have our own corresponding reason */
 		return SK_RST_REASON_NOT_SPECIFIED;
-- 
2.37.3


