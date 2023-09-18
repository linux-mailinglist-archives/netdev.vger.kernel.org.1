Return-Path: <netdev+bounces-34664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA4A7A5249
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337C4281EE1
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF402629A;
	Mon, 18 Sep 2023 18:46:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBE21F947
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 18:46:43 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9C3109
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:46:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c47309a8ccso11062495ad.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1695062801; x=1695667601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/zqxewMwzXBN5mCCqc1z6PKAhih/Vj2GXJTmg+7m3c=;
        b=go7hBU9dzQRgVFQsIFkc30Jy3iYT7MMe+igDotRNeF1gCu4CR7thgpdeNipUEQYG0V
         zqrnJahsrFe9Mq4GI1tI1IsOoKH5Spa8hMI4ChED5+s/imNy67lAgcbop4To5VOIKZWY
         vI89bo5CCcOtPawEOr2Q8gFPW5fz1VhtaNf3a3KRzbd00Jt/D9FPNLfuH86u83OmnPo0
         ul7rOVN8URGwiSytGYj3QeCRvpwSfBeBpyowEWvN8bhOanIhu5Y9C/b4pQd2Tv/8UrQS
         RsvPKcAac0olBR0lc69zJ6l6VAXrnRh89QRDAphzdPW1t6JUbYHOHNgWNXTJg6XUK1gr
         u6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062801; x=1695667601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/zqxewMwzXBN5mCCqc1z6PKAhih/Vj2GXJTmg+7m3c=;
        b=wKwVuEzZEAWW0jdSID7k11BLs6cwUTT9gp6TQHonXpg9Y0KM9rSOPy9morSYPuQcvP
         C9VBN1QNvvG25mkiQf9VPcGX+knsQkzfcSQNQ949m870O6cnYP2lnAW8fmUYniCiJEBm
         7C+B9aeLx8y/l/YR5zgs19qgao4YOCWti/19c3V8Us9m+5XxNqxLMW+pycLktXM/SbKv
         wRFGoNJGkxA8SM3asPKwyMyOhsm46AuH+OnuwaGcscM0JJQs4MmZy0a+tWEKDNi9a388
         BtfCppCnBNKTxXv/CU1i6s73fQ4tNesKd+LbQ3YDsSFlKAyqsaK4gq2xo+pCZ4vtrA7i
         poNw==
X-Gm-Message-State: AOJu0YxnmQPBmKV15j4qD7xUl7ygn2kfsWpg+AEB0K7+BoYF1WAjT0wR
	1WyniyEFT14Rx/7PVwy1kh6oM9CRLJz2ZaxYmbuYaA==
X-Google-Smtp-Source: AGHT+IHIHegstGuWy6JHK+cJgvwflewbqQEhGidnVx7m3JmwdP+QC8aYu/BfVzHAkpAygDaKyaH8kw==
X-Received: by 2002:a17:902:d2ca:b0:1bb:d586:d29a with SMTP id n10-20020a170902d2ca00b001bbd586d29amr588649plc.34.1695062801365;
        Mon, 18 Sep 2023 11:46:41 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id c12-20020a170903234c00b001bbfa86ca3bsm4488052plh.78.2023.09.18.11.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:46:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 1/2] bridge: fix potential snprintf overflow
Date: Mon, 18 Sep 2023 11:46:30 -0700
Message-Id: <20230918184631.16228-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is a theoretical snprintf overflow in bridge slave bitmask
print code found by CodeQL scan.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/iplink_bridge_slave.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/ip/iplink_bridge_slave.c b/ip/iplink_bridge_slave.c
index dc73c86574da..3821923b5da5 100644
--- a/ip/iplink_bridge_slave.c
+++ b/ip/iplink_bridge_slave.c
@@ -100,13 +100,20 @@ static void _bitmask2str(__u16 bitmask, char *dst, size_t dst_size,
 	int len, i;
 
 	for (i = 0, len = 0; bitmask; i++, bitmask >>= 1) {
+		int n;
+
 		if (bitmask & 0x1) {
 			if (tbl[i])
-				len += snprintf(dst + len, dst_size - len, "%s,",
+				n = snprintf(dst + len, dst_size - len, "%s,",
 						tbl[i]);
 			else
-				len += snprintf(dst + len, dst_size - len, "0x%x,",
+				n = snprintf(dst + len, dst_size - len, "0x%x,",
 						(1 << i));
+
+			if (n < 0 || n >= dst_size - len)
+				break;
+
+			len += n;
 		}
 	}
 
-- 
2.39.2


