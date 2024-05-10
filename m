Return-Path: <netdev+bounces-95452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFD88C24C5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C84B1C21DD7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75EF5027F;
	Fri, 10 May 2024 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apGSHgm5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1116DED7
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343922; cv=none; b=V6q0zdYqwQVw7lY/fLepZd1y1tT66Ii0yKrzaIDMXqhLdMU3yoljvnJMd0K8IvDF8mlPVOdWafc0aDeHt+xJFUQ+ChXUxOrN435ZCfn49KHRxZAHNYueznIuf02EjgWlVHqv4g9tNTTtY6AJVWyxA35CuEJs1LZRrf5wnShrsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343922; c=relaxed/simple;
	bh=QhLHsr4q9mx8ubOT3pnejzEK0cBC1QdoRCtcOCZIiko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbncDdcCf+2CyhjgtmKMdjUdsW5kT5o27ZIhOZ7F6AUYiXtHHy6q4E8odKKLYDZZl+cffRm/xD7MpDaLSSolaYmFm5cesBXulpkUvNCOQg3AHgak+/xx8IA1VZ3Ma14oMZMutq/4vYVZI//FQXJIiVtsWhgL/gk5e/B9s8u2wFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apGSHgm5; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b273b9f1deso890878eaf.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715343920; x=1715948720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4C5pHde1tDmuDAUEtokuBbtsfGpTSJVnMuEbxlFEPk=;
        b=apGSHgm50rAFn2h4mStDOozZPsB4PcXlx9GMWvMfVZvMR9PIyXiVXxYGYt7scK56iK
         dZNm+nIwbWBdVHhNfL3tyrilIaYSmAuPaEbZPSxFges78TE0AXFLHeZa+F/a1VmkK22e
         zZOUHaTJATW0457YNC25CbwVkJYqxMrxRBmxA2oWl0br4/2Ht8a8X9c0bEfLYTseSNA+
         jrCCzsUgoxRARMX8M3hm37PqOJjX3I63vRHGqi7yOMv2D1T3ikb3tINJXCQZhQcspV/W
         wT8Bvjcyyvbbt1WiA688CUp3h8U6sbGakTuoaZBnc2Az/jb6nBHz5h3FqcGw7YIz9Cd7
         u/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715343920; x=1715948720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4C5pHde1tDmuDAUEtokuBbtsfGpTSJVnMuEbxlFEPk=;
        b=fYAPsTCFOFDcaPCNGCirxGhKNymrK2aDgsZQbsOLu76Ejvs5F2cfuA1Z7nxFA50/Da
         I416CzXDg1uwVD6IOuy0KWb7hGc+ytE6sHd3RHl2LzyGlOTA4fCMx1I7Q2lJcPcHnsfL
         wfBSXEKSTnOC2YAmzSJks9qS1oKJgSRSauSOCV0WSGzQp1ISqpCNheZ3KeUxEdp5trtO
         98ZvOthDiW6x6s4Is5W9pdHPyamYdoqFqlxLheoHm5EHI2VfpHVsY1DTmyZfYuz1NUbk
         TN2C8+XzICYhS8S2SHlmyq01l3aoAKZgEJXtIBZzGBqPz9hRfhLObtt8oaV7/O2PPNRp
         Lr/g==
X-Gm-Message-State: AOJu0YxKtizn+LmzXjyQzRnxODK4oaiR56MXByz9EVCGsDslsAheKz5m
	n23R/6uVdKowQ1VPYEjVfWQ1zmMnQ59+urMYtcTncgHzz4oWgqxX
X-Google-Smtp-Source: AGHT+IERpy4GujC1MROXjzfTjpMogp2cAILDXypCbn5APb+w3uqVqS1+13DK7LNjMQyFbkIb54e+2g==
X-Received: by 2002:a05:6358:5694:b0:18d:8c13:b83d with SMTP id e5c5f4694b2df-193baeda1f1mr270393155d.0.1715343920226;
        Fri, 10 May 2024 05:25:20 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b57f362sm2943530a12.30.2024.05.10.05.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:25:19 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 4/5] tcp: rstreason: handle timewait cases in the receive path
Date: Fri, 10 May 2024 20:25:01 +0800
Message-Id: <20240510122502.27850-5-kerneljasonxing@gmail.com>
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

There are two possible cases where TCP layer can send an RST. Since they
happen in the same place, I think using one independent reason is enough
to identify this special situation.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 5 +++++
 net/ipv4/tcp_ipv4.c     | 2 +-
 net/ipv6/tcp_ipv6.c     | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index fc1b99702771..7ae5bb55559b 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -15,6 +15,7 @@
 	FN(TCP_FLAGS)			\
 	FN(TCP_OLD_ACK)			\
 	FN(TCP_ABORT_ON_DATA)		\
+	FN(TCP_TIMEWAIT_SOCKET)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -72,6 +73,10 @@ enum sk_rst_reason {
 	 */
 	SK_RST_REASON_TCP_ABORT_ON_DATA,
 
+	/* Here start with the independent reasons */
+	/** @SK_RST_REASON_TCP_TIMEWAIT_SOCKET: happen on the timewait socket */
+	SK_RST_REASON_TCP_TIMEWAIT_SOCKET,
+
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
 	 * RFC 8684. So do not touch them. I'm going to list each definition
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 108a438dc247..30ef0c8f5e92 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2427,7 +2427,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, sk_rst_convert_drop_reason(drop_reason));
+		tcp_v4_send_reset(sk, skb, SK_RST_REASON_TCP_TIMEWAIT_SOCKET);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7f6693e794bd..4c3605485b68 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1999,7 +1999,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb, sk_rst_convert_drop_reason(drop_reason));
+		tcp_v6_send_reset(sk, skb, SK_RST_REASON_TCP_TIMEWAIT_SOCKET);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
-- 
2.37.3


