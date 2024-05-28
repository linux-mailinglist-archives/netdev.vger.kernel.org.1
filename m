Return-Path: <netdev+bounces-98641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E070E8D1EED
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 351E0B22C10
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C892616F917;
	Tue, 28 May 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IObycwvI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB0D16F267;
	Tue, 28 May 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906892; cv=none; b=Bne3vTyD8Uj2pvMLS4Ujdimy6Xz356pT0n/MfZPxkxghsyRnUJf6VLZofQNqbxaLiE3oVB0bYt9KAsnt6zN2jy1QCl9H4Tzcw43ftr2HJD5fv54HKXzGiJKT60rXq3VCsylQ1T3vSYEa+UooKVLuKO+w85iK//7l+bKedVzWCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906892; c=relaxed/simple;
	bh=X0Q0HI1b9rH+fVZzvv90qJ//IfIjQBFp/0Kqy1oPHIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6aoU6ZNVAG/EH65QrWXwITYvcDpcoOE2F32U7pAUYrEK3naXBEQyjPUef/mP8rG0gTAhnAo/cnqXmR7aLnRuRJVCHywGn1ammMmXeG2e9kk5mVJfW24D55YPSltkWZeEh7cv3DbNGXYrMizSNjGtZlDGKs5Q56CstAEQWIZfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IObycwvI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35507fc2600so824751f8f.0;
        Tue, 28 May 2024 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716906888; x=1717511688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SuPdbyOGZB4+HwsptiUUcZmfTuqcWmYMtI45ENp1tfE=;
        b=IObycwvIdw+sa8X0Y3GELugl4NzQIC3Ma1fRw7isNtX01qMMf8+4nl47b8R/hPmiQA
         ZO0HZnUBWKTpeeZ3mlbkeGQ2xf/rgruZ8SWzZeHEbcghxMKqGiJblAKrrsFd5tuiI786
         CdJX1fFrZPVTIVnv4vTzscr16WrUQFRfQJGJkoDaMPWwObkgTBtV2hu6LndnXb6yVQsy
         yelNaiFv1XoC/GWWvl6j/GQo8M2Rk0+vUDEU+KlLVpST2W68p5a39YnK7wmFSVPWmY8m
         JjG/RX9vQ7P5sRN6D0vjHFBEbsvqEUqBJHfrL78WidJD7W1jq9HQ/3cc16tLx1K4GsYT
         1xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906888; x=1717511688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuPdbyOGZB4+HwsptiUUcZmfTuqcWmYMtI45ENp1tfE=;
        b=mp/mua+6dep2KCJHX3IVfSw/Tr3AVF9ZUHToH11tDJxvlz+3nquhDW/shP4Im04WP/
         tm9riNxTRHZ5lVMWDrFi5krbcnMWi5Hth7ERJQ2nDKkC8x4te2dru2W69ydXlKDkQ6zb
         OIswklZenlAPAQ/9/+jznMDbfi5A8YR0Q5//EyPlSIG8L5jX/w+48ovXCTi1GbtHkpui
         fioMVWMP9bJnALnGmmhMwuiRhPyGslwnPmP1k1yRpjZmR03C62YCUlmDIoghId6/MRnQ
         1ogztp7+8WmFEyoej0mAkMZ+wGkShvivo5thxA9/qSUIyBWRA48X+3RrtumJkCPMH/f0
         1dgg==
X-Forwarded-Encrypted: i=1; AJvYcCU91Ws+E3tgW4L8St+hyBjltKe/omX4Yi4rjbm4pYMc2wNBApl/DTpKNvj42DcpuEd5EefxzDVpj9jM0eRKsNBm/5Kw2g8BaO4NVkwPebRNIi1R3WpjwJMHiI5D1nGXBX1bKHMXzZPYyoHqDPaXHvOU
X-Gm-Message-State: AOJu0YzQwxiQRfrMYteFFu9/inXao31XsdPvaGk+/aeNaGc6J+4gg3ei
	NYHOKmbBzr6X1j9mMfd72+fPAYYvTsuKmpZpYkW8Snw9xaLLPy1D
X-Google-Smtp-Source: AGHT+IEvUe4Wyv5qEfelwlQENg4haCJlvDmuMJE1WNUxZ38maU8EjKZVfla4YQZqm+uzgYwJW3s/iA==
X-Received: by 2002:adf:e547:0:b0:354:fd11:2fa4 with SMTP id ffacd0b85a97d-35526c39f65mr9236960f8f.10.1716906887953;
        Tue, 28 May 2024 07:34:47 -0700 (PDT)
Received: from tal-dev.lan ([2a0d:6fc2:40d0:6100:3b6d:a8fe:60ea:3a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf08basm12193233f8f.108.2024.05.28.07.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:34:47 -0700 (PDT)
From: Tal Yacobi <talycb8@gmail.com>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	talycb8@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] mctp i2c: Add rx trace
Date: Tue, 28 May 2024 17:34:20 +0300
Message-ID: <20240528143420.742611-1-talycb8@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mctp-i2c rx implementation doesn't call
__i2c_transfer which calls the i2c reply trace function.

Add an mctp_reply trace function that will be used instead.

Signed-off-by: Tal Yacobi <talycb8@gmail.com>
---
 drivers/net/mctp/mctp-i2c.c |  3 +++
 include/trace/events/mctp.h | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b37a9e4bade4..22754f4e4a8d 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -24,6 +24,7 @@
 #include <linux/if_arp.h>
 #include <net/mctp.h>
 #include <net/mctpdevice.h>
+#include <trace/events/mctp.h>
 
 /* byte_count is limited to u8 */
 #define MCTP_I2C_MAXBLOCK 255
@@ -312,6 +313,8 @@ static int mctp_i2c_recv(struct mctp_i2c_dev *midev)
 		return -ENOMEM;
 	}
 
+	trace_mctp_reply(midev->rx_buffer, recvlen);
+
 	skb->protocol = htons(ETH_P_MCTP);
 	skb_put_data(skb, midev->rx_buffer, recvlen);
 	skb_reset_mac_header(skb);
diff --git a/include/trace/events/mctp.h b/include/trace/events/mctp.h
index 165cf25f77a7..d115c353dff9 100644
--- a/include/trace/events/mctp.h
+++ b/include/trace/events/mctp.h
@@ -73,6 +73,22 @@ TRACE_EVENT(mctp_key_release,
 	)
 );
 
+TRACE_EVENT(mctp_reply,
+	TP_PROTO(const u8 *rx_buffer, const size_t recvlen),
+	TP_ARGS(rx_buffer, recvlen),
+	TP_STRUCT__entry(
+		__field(__u16, len)
+		__dynamic_array(__u8, buf, recvlen)),
+	TP_fast_assign(
+		__entry->len = (__u16) recvlen;
+		memcpy(__get_dynamic_array(buf), rx_buffer, recvlen);
+	),
+	TP_printk("l=%u [%*phD]",
+		__entry->len,
+		__entry->len, __get_dynamic_array(buf)
+	)
+);
+
 #endif
 
 #include <trace/define_trace.h>
-- 
2.43.0


