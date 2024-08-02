Return-Path: <netdev+bounces-115293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257C945BE6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BDD1F22BA5
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB1D1DC476;
	Fri,  2 Aug 2024 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndm5H5Hl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1664A14B962
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594096; cv=none; b=bOQmQ8u4W+I3XaaVnrGGJ65z+XIRSNCtNcssDCIT65SewwJiBIzmDu2k0Ya1tzyYKsQurtpQIoaBoTB5m813stVXsjcu1+7OqizGvO6lI64/NCD8z/ikxoRj91kVjKmEKduV4FK1CKtGGz3Q3yhttVDMA2/6t7j5fz9Z+5x7WIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594096; c=relaxed/simple;
	bh=TAf7vSMPjg9YoUJQxzY3quR/+whtotVL+zF3O5FIKY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbL49s75nU6+CTjhi+FS/6MlIdjLUxZxtMNeXbmumOL2dUvMd+CmQS+HIT8ikiNP/gnK4RAcP59f1DLA7zwx2AUnZk7xtJKNWJSkMuEnqDI00vsUkFaPXzrxfSfBh0J5B5Myn6SenHz4ZGyj15Y0LDK2AHzcntnOJ/WR8lw+tfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ndm5H5Hl; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70938328a0aso3597469a34.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594094; x=1723198894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o8y3DpLGZWl/CzpBkARBWumRB0/ZAK66arUOn9zZFw=;
        b=Ndm5H5Hl/SfUwLPnIvcxPNNytKSimxa/4Yu2iSmPfMnJxN88ZshywMjSUlhsyy+jiV
         zE5LzTPko30MYgt+wT+E56Frv36s/bskV+I2pN0SSz7ARp0nlhJGLWOy5/4Ql0L9mrTA
         1JrMzHU7y8OueeiSlpC5voS/oKEIxWZdyL/22X6J37OKBiDawXR1Mcnuzsi3eS7MbtJM
         NrjoxTKC80z8VQldI2Vxoa1RpAf5aASGLqbKCX1RqVbWDMGo+u0G1Pu++k5BvjXvnQW5
         oJBuNbcUIe7xBtBeiTZz/txa1cTzdiEovD1OeEHBuZVJcmfTft+f/RFOP9Yh5OLg8tgh
         Xv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594094; x=1723198894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o8y3DpLGZWl/CzpBkARBWumRB0/ZAK66arUOn9zZFw=;
        b=iU62YN94Q8nl52PDTip0hiJru117Gz2Y58Pzmf9PqXwCwk3AI0IDwRipJYmxrrPttf
         kQkx1t81OOUh/K4V6xvqAfwzF8HqNBpigt+Trju2Bh7WIorX4hPLv14c01K/5t+8OFR7
         zo51Luc2ju2ZvfxP7NKob7eThzL2oCM29y+qUGvBAK6uSDG88FtPXWRV+WFpSSTpwEYh
         fNMVf0o5fa+zWgdcHknF7g6exix1Jhm5501j2r4arPX71Mi3OEnYdpAsWk6O9ADbbrPy
         /8P0+CjIUOjh48/7dOiyRGZq5sarE8gpvZZwkJ23JfQxI+ZEAzPM69L0y3trHG249ogK
         4MJA==
X-Gm-Message-State: AOJu0YxuC3pESRguM6ZI6D8YGv2L9Ysi5su6F/4IXCHKOPnaCJmceTyB
	RsLB9PA1bv8OjT/ohhdSyu3d5asO5DDxN35Mc+qqpTpyA3CcLYku
X-Google-Smtp-Source: AGHT+IEHCVVBr/5LhrU7dEMEy7rnBwOSkPjeiGaE+tfAl2mxTr4jfKWjpaHgYbM3srt/pMx4mgbGnw==
X-Received: by 2002:a05:6830:7006:b0:709:48bd:b150 with SMTP id 46e09a7af769-709b3218eeamr3720825a34.14.1722594094126;
        Fri, 02 Aug 2024 03:21:34 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763469e79sm1109050a12.26.2024.08.02.03.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:21:33 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 5/7] tcp: rstreason: introduce SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT for active reset
Date: Fri,  2 Aug 2024 18:21:10 +0800
Message-Id: <20240802102112.9199-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240802102112.9199-1-kerneljasonxing@gmail.com>
References: <20240802102112.9199-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introducing this to show the users the reason of keepalive timeout.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v3
Link: https://lore.kernel.org/all/20240731120955.23542-6-kerneljasonxing@gmail.com/
1. chose a better reason name (Eric)

v2
Link: https://lore.kernel.org/all/CAL+tcoB-12pUS0adK8M_=C97aXewYYmDA6rJKLXvAXEHvEsWjA@mail.gmail.com/
1. correct the comment and changelog
---
 include/net/rstreason.h | 7 +++++++
 net/ipv4/tcp_timer.c    | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index bbf20d0bbde7..9c0c46df0e73 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -21,6 +21,7 @@
 	FN(TCP_ABORT_ON_LINGER)		\
 	FN(TCP_ABORT_ON_MEMORY)		\
 	FN(TCP_STATE)			\
+	FN(TCP_KEEPALIVE_TIMEOUT)	\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -108,6 +109,12 @@ enum sk_rst_reason {
 	 * Please see RFC 9293 for all possible reset conditions
 	 */
 	SK_RST_REASON_TCP_STATE,
+	/**
+	 * @SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT: time to timeout
+	 * When we have already run out of all the chances, which means
+	 * keepalive timeout, we have to reset the connection
+	 */
+	SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3910f6d8614e..86169127e4d1 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -807,7 +807,7 @@ static void tcp_keepalive_timer (struct timer_list *t)
 		    (user_timeout == 0 &&
 		    icsk->icsk_probes_out >= keepalive_probes(tp))) {
 			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+					      SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT);
 			tcp_write_err(sk);
 			goto out;
 		}
-- 
2.37.3


