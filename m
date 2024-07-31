Return-Path: <netdev+bounces-114552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9C4942DD6
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52381F23B04
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD6F1AED3F;
	Wed, 31 Jul 2024 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmgsyvsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BF1AE877
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427822; cv=none; b=H9+JTVLvlNY9zuwW4aV8OmGvU8G+mBQR9wIc2btqTlgfmOny63S/R6zyMaL3kgMQ2g2Fe4NlwmO8kRRf37I8IL+Xw/5SzaEShmVDgn0bSIZSqqUAE7se69liNmyQFy39b0xK+//KdqFeJH5zcNXb8qVMmyxaYplMN2Rs/bJlHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427822; c=relaxed/simple;
	bh=BPDLL0zi+iLWsaCwoWShPKLRtDzcWRw9A9agSb9HcK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/IBKgOFEnTRy3JT6PA2blxqrFUL5Osg5voMys8bPCxxdmz7NvYDhiXECbTrqAnLZZYpP7T5KFfQVqKSUHZdnPQTHAt6AARbY8VI/QRKlk/qWpdvoGRNqD8Am3PfYvJevfsXEA7XRB9iyEkeOco5WqA8MbwS52FvR5POqqx1f4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmgsyvsK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b703eda27so3557040b3a.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 05:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722427820; x=1723032620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHon0uilYTfxxaoms7BYfICF5Ub7S4yk95M44g2vUgI=;
        b=BmgsyvsKOD/nht3dUtEHnsS/4Xm/2q2wpLv45sROKnBdZUJ/pk/8AFQBdhTYCEQrVy
         vW2sSt4EupdACazkT0JO0ml6ccVSky1ci3T9l7pfZnEVqX/oSOWeZRQDQSt3mZSKC+RN
         6sNELMg/asTbQ0xh6X9XhMHLAOJaIQc6eh06vMuvZKFmAx45Qi4D0l4tgFdm5TAJC3Wj
         PyK6SYpYkVDlbv1zimLfdAmlY9HQweHykMTHjzhzZKdb1IQLsUyaLGhXYlshI00N5v2e
         W1xzWutzd9UdpTFdP6+DIJIxjdrN6QNJIE+/3A7gDfxNpdEG4rlhLYDuhV45fxj98ieX
         kl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427820; x=1723032620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHon0uilYTfxxaoms7BYfICF5Ub7S4yk95M44g2vUgI=;
        b=ucKTTSSAQnwSu2QPZYfVJoZ/rIa6rxVlMi9M5LwExqX/9gXYBLVIaX8wkTlfE33ujz
         HlNhdKDSmlmPdtEXaOUKg5FGYVN9xGGopHng1JJ1pd87OV4n5D23S7jmrkeSAAwpsQoN
         rJmZujamWYPoQGsw4OQrNsirQ33Pis/llOs5Fz8T7BvtF2IBSekq/5Wv+/UNZPwIzeMS
         ZbGqDRs/t5UvWtMpymoDVquzKvwaDdK/tOZ3SMCwNLb6qEl+blGjzQSD56xsgKouNcgN
         5GMBdsrEYWt9XYt1g6iXpTSngFA29cYWPjWan/Kgl8rY3whG2RuwGcbmHY0nvYqZyRKz
         OpUg==
X-Gm-Message-State: AOJu0YwA8/rYYkkI9COxVq1wTjKB4fixKGn98UaBtmqmknClE1+C/Mmm
	AgKwcHTSdoOg445e7Q94lY/ouGFQd7c1phLIbsleKr7fJp/axTGn
X-Google-Smtp-Source: AGHT+IE1XtFfeORgVD0aS4G12gI0kbjs7noyblSIwGCfTDwNUYD1aRUIHbAmoCTyvYUxgzoIoaUifA==
X-Received: by 2002:a05:6a20:1588:b0:1c4:c7ac:9e5b with SMTP id adf61e73a8af0-1c4c7aca0d0mr10644547637.45.1722427819957;
        Wed, 31 Jul 2024 05:10:19 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70eca8af213sm7488545b3a.180.2024.07.31.05.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:10:19 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 5/6] tcp: rstreason: introduce SK_RST_REASON_TCP_TIMEOUT for active reset
Date: Wed, 31 Jul 2024 20:09:54 +0800
Message-Id: <20240731120955.23542-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240731120955.23542-1-kerneljasonxing@gmail.com>
References: <20240731120955.23542-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Whether user sets TCP_USER_TIMEOUT option or not, when we find there
is no left chance to proceed, we will send an RST to the other side.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/CAL+tcoB-12pUS0adK8M_=C97aXewYYmDA6rJKLXvAXEHvEsWjA@mail.gmail.com/
1. correct the comment and changelog
---
 include/net/rstreason.h | 8 ++++++++
 net/ipv4/tcp_timer.c    | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index bbf20d0bbde7..739ad1db4212 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -21,6 +21,7 @@
 	FN(TCP_ABORT_ON_LINGER)		\
 	FN(TCP_ABORT_ON_MEMORY)		\
 	FN(TCP_STATE)			\
+	FN(TCP_TIMEOUT)			\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -108,6 +109,13 @@ enum sk_rst_reason {
 	 * Please see RFC 9293 for all possible reset conditions
 	 */
 	SK_RST_REASON_TCP_STATE,
+	/**
+	 * @SK_RST_REASON_TCP_TIMEOUT: time to timeout
+	 * Whether user sets TCP_USER_TIMEOUT options or not, when we
+	 * have already run out of all the chances, we have to reset the
+	 * connection
+	 */
+	SK_RST_REASON_TCP_TIMEOUT,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3910f6d8614e..bd403300e4c4 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -807,7 +807,7 @@ static void tcp_keepalive_timer (struct timer_list *t)
 		    (user_timeout == 0 &&
 		    icsk->icsk_probes_out >= keepalive_probes(tp))) {
 			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+					      SK_RST_REASON_TCP_TIMEOUT);
 			tcp_write_err(sk);
 			goto out;
 		}
-- 
2.37.3


