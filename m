Return-Path: <netdev+bounces-114155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA750941341
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738642865FC
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76501A00E7;
	Tue, 30 Jul 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST57Lm+6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613C51A070E
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346543; cv=none; b=q9Pn3cY5+Zgog8nISqMQXklHyMOEhJcGsdA/64lf+9ysY7jlaNwSU7ncDawdkxh003V6uU+NEC53q1EDJAMh9VHAa9RWT9XJGLBHbcXvFl2wV7047sxMYFfRer2syX8UIGQLFFKAczd2ufXbU/quayrDHPXafWhpEi4yeWiAMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346543; c=relaxed/simple;
	bh=muj48Rby8axVXDjlC75D5v6qvbHfw5sbPBHewVslqvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FfwroZYdKzJkkLE/M4SwaIUM+12ZDEk8V4kKeT8kSATftvIaeR3SaS9n0TemI5SjkvQY2LpdfNKO6oBcnxmLVwRIH82XzJa8lWhz3m75XmPDzG47XSx2Hj1wqperIoUQZ961a4MRCdq/n1OrO0Ec7p/IKwYXK6HGgY0KUOj4cV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ST57Lm+6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc5296e214so32736875ad.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722346541; x=1722951341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBwC0xtR8VWUdgnjbtcrVKP8K9w2i0toxt+qfaBwjT0=;
        b=ST57Lm+6JvSPQLWjst6PwiEL5fY/ep/uQPTFs4oz8zaOcRDs815tMDh24YpVWRQ9tF
         YPTp/De+WDjCl89xjqz8j1LulK+SF5ExWD8k6O8btlVnRM5iAdadx7gErg6+2uPmwHzn
         +x2544alnsqVv5y9F7PnDuGxPhR8B6m+BsGkQd+vBPA5pKBUM+BJRSMqaBhOAYo/k9de
         XfZD9oP+4kbw/6QwPM8F8R2LpiXd4TH7JHSTxw4xBSXQWAV6gGuhF9LZIUKo8rsCKhyH
         3RD3ZXSlfdbLIfOi0t8Kkn/l5AAAIAKWqjZX4VH2GAn7XJ/PPluQsE2cHhwJuN4OhfXn
         GNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722346541; x=1722951341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBwC0xtR8VWUdgnjbtcrVKP8K9w2i0toxt+qfaBwjT0=;
        b=idjOJ8OdKMjNghTqBw1tLuXZrfhZyZxB3egOQS0QDZr7GdOvT40eswuuzqnyIGXTRd
         VvKBoBYKXGLo4O5P4rTHu+YYwxQZekyzlWJYf8fgfOXtqHyI7l8XiiDZkWFGCz4H0voP
         AoDqqj3IGWHKhNSOwnczaQWV6utIWYWlsbGLLYF3swhIaVlqOGSRpt7JX6ivuCbrAnid
         sri+sffESkYf9Z++VQU4ZtERS7VOC3jCcXNx8YnyAnFS5ywa/hCbYtoHtqm/mk1tQYaa
         Sy2530dEqkOqyNzX8ANTybtyEGdQoNnG1Us5GOorRmbXKd13NLipVh5dA8VVwZfYAUlH
         S8lw==
X-Gm-Message-State: AOJu0YzPWDXK8E81JJQj2fhn9l9cJboRoIXuwhygVden6S/T9tW7kj9J
	PTamYlg0MWkdzWN7q1LKJY7J0vN17aI555cOEpe1VUIEP9fI1zCKYGeBwWeI
X-Google-Smtp-Source: AGHT+IH29OGxC1WCdq3ZeS71ASq64KrnqyJRe4YX/PzdxMMI0/A3sH095L1OjUP5T9PQGboJYK9TMA==
X-Received: by 2002:a17:903:1c8:b0:1fb:a38b:c5a7 with SMTP id d9443c01a7336-1ff047dd4a3mr154008005ad.13.1722346541617;
        Tue, 30 Jul 2024 06:35:41 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9f279sm101562515ad.256.2024.07.30.06.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:35:41 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 5/6] tcp: rstreason: introduce SK_RST_REASON_TCP_TIMEOUT for active reset
Date: Tue, 30 Jul 2024 21:35:12 +0800
Message-Id: <20240730133513.99986-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240730133513.99986-1-kerneljasonxing@gmail.com>
References: <20240730133513.99986-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only when user sets TCP_USER_TIMEOUT option and there is no left
chance to proceed, we will send an RST to the other side.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 7 +++++++
 net/ipv4/tcp_timer.c    | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index fecaa57f1634..ca10aaebd768 100644
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
@@ -108,6 +109,12 @@ enum sk_rst_reason {
 	 * Please see RFC 793 for all possible reset conditions
 	 */
 	SK_RST_REASON_TCP_STATE,
+	/**
+	 * @SK_RST_REASON_TCP_TIMEOUT: time to timeout
+	 * When user sets TCP_USER_TIMEOUT options and run out of all the
+	 * chance, we have to reset the connection
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


