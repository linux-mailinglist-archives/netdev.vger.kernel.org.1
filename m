Return-Path: <netdev+bounces-94916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708F48C1030
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106321F23513
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864591514D8;
	Thu,  9 May 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma1I1l7a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714136E60E
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260403; cv=none; b=SRBogDrNNPw6gBiLw3Cc7qnQ8o3SdgBsJ9BRnKl1XAuSLEKHquUcfbZhadUQK602hwJxzJmR5ykwO+FebUISqCjz0BeU9ubFNZmrv+G8Bpa5FEdUXB9ldBCclrw6ah9qiIpVTaNUdz17rLQGUbX+tpZ8++mHoYfaY/QorSdG+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260403; c=relaxed/simple;
	bh=OrfoT4YOwRlve6mV0AW69N1v9S7JlhMBl+7xYefdoZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xc1weI2JDuwqsDemazdl2Yi+EOE65dpNdA9AaPq9j/IzV9fX/dpONWR0pQC6X99LRlm5XXyTF0ziriyQcL2MS/u17p3oun5Sffg+MQhUwjvzkG2US5Msg9sjYFAsVgFUp+LITHUBtuxB2hGrGHCjDGmJBcZ0WqwWxrcbDat7kwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ma1I1l7a; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36c67760b1aso3760395ab.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715260399; x=1715865199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq4Oif0buUnA9JqMotGU1jFbPA8b2GKc51i6wlfOjfg=;
        b=ma1I1l7aYTzVmkyIl4hMjOZxuNGMxeYZr9D2Mb/iKgpJZVs3YjWUrTLP8HuScLtv0e
         zTf1NfVIJA/LLbtzVbh5LTn0th0tBtUNrWjH60fhwkg5xzXc5ACIFEEDUyEgsFafZKhY
         zPL0BcvfKobPVDcqRji+2a/ilQPeSvMhblr8v2/d2diJP+XfvQLpG8fxYJxdYS4UQGGY
         mXX/Yl8kGcc2FGtTVT/V0RPN6k/ZuwQe3xBu2ttRbl0W0Krc/wnrJelQsS8fdpQQCkjD
         h51C5QuA5yiw1MtvNKNv8LTKsdJ7MmAg4O6s/jjqDO7fGX/iuNK1g9GOFMiKn2Am3ew1
         2U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260399; x=1715865199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq4Oif0buUnA9JqMotGU1jFbPA8b2GKc51i6wlfOjfg=;
        b=h24YKbhNT66ihG1BjUL7dUirmCS3QqKEEHRM3o2IEwn8y/u/IEwMDf0jWoNmFNd+c/
         +Aipam/0Nt8LsfcBzU+UoilNb6syTlauReblV0XhbHEruqnZHsmIg9Nnxh5YK2LDTD23
         AStzXL9EuzB/SgB9mXHBf/TR2IBeIVtOBzAZX2RZmLhYcFqTASRZiOfKsQC+6zIaVJ5W
         enlt9pzubDN3b4uwLiETTG8HbrLFG48c3Wta92SE78Lb1QXNxuxyjGo49yDGV44tBvPi
         QFMp6zW94PObWfPZVaVkTCBSTo02c/eEETyYy/idCc2MZxoljEXOHQi0YjQhZEFZlGYb
         MzfA==
X-Gm-Message-State: AOJu0YwMnkfxACIFMe+zvQ9emKU7samg5BUtfwDpQ1AQo8TlAFOECMe1
	62Ci0CjDAUgBe1vaIdoJUFLkrJvwa9YegIQ/bR0/P1u8Tk2jIOa2
X-Google-Smtp-Source: AGHT+IFkXlK5Fw9HqxHXuwWt+eSGe976Aw5wYsCuo/AKR/LYYoSJoqyGI+6ifYHVIeoDtfAVeDPjYQ==
X-Received: by 2002:a05:6e02:168a:b0:36b:f940:ef89 with SMTP id e9e14a558f8ab-36caebb9100mr62397845ab.13.1715260399438;
        Thu, 09 May 2024 06:13:19 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411346eebsm1133887a12.84.2024.05.09.06.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:13:18 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/5] tcp: fully support sk reset reasons in tcp_rcv_synsent_state_process()
Date: Thu,  9 May 2024 21:13:02 +0800
Message-Id: <20240509131306.92931-2-kerneljasonxing@gmail.com>
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


