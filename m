Return-Path: <netdev+bounces-191235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91494ABA740
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430DA1C02238
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367D484D13;
	Sat, 17 May 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dj3RgLnq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C9370813
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440691; cv=none; b=K+AYUOTyWYCDBsnqgTpEkzcwjPZ5xqPD40+1SVQveXcAuw4WeiCWXB5gZEk16jF2k7VLEVVg4IC18G5GSc9tq5Kv1PgEWF+874Xae95G5TkChCixuta07bEqJdXsgcIlWsd7uGmxTdkur55TTKlQ0lXkv8PnSMo447qAxSuOnUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440691; c=relaxed/simple;
	bh=4rglfxQ8e43NAo8sjfzdrwp9gt2rF2n/CmwotQFqKo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S8TsSDMpNpZt1P6y24BEPhaZ5TvkIyEgT15GXKImUELHdbgFMchW4RdJCFO06rHMX2H2SNbJQoxIrqNcR49YV48Maalf6yVu6XOoY7dVZbvp+wxM2oganIvcWhCs7IrZKjCVwV5m9eaynpz/m3a1K6tHvD7ZmzYzYT8WoS7/+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dj3RgLnq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ab5d34fdbso2786747a91.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747440689; x=1748045489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMvnnMEFZ5dqB3r/UXxZSIBB69p1DCz7ZEgCufDQ4uk=;
        b=Dj3RgLnqkd6gvb2Okb0oXSvsVCF1y5nk8ThOsLXlUrp9TnN4Shapt16KB2IUVx9PzM
         MLtWPMy0pnng1HaGOTANhiZOxwJPi0aJ4d56giNGwpqcwqSZQ09RhqLyT/v3V86Sqo2O
         LD13ZYc4+qpMA7cfIs5hJGtTB6VB2Hqutxs3l6yDw4iaKkAgaZsIpdNduVT9QCwpMDDF
         D/5SWkuXCbKNfzjWI8/eajKDAIbz7mNdbcSyisjmrWpkVELseTcSYFUaRNAIrqgBsB/I
         ZtHiP5xK6lF2BAlBO/0Fl8U564/lRbhDnO1ZVSd++EUW9guYtAchxIh51/MWkVhpYZHs
         eIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747440689; x=1748045489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMvnnMEFZ5dqB3r/UXxZSIBB69p1DCz7ZEgCufDQ4uk=;
        b=hlef8JYVi1K0/vWwmlZA0RMk+N1iQ0DF3qZSUyFa9aI8YXMogxr6Ege2uFegUUUbuX
         xsylFsdSOEskYMZ55U4ITTGNRvkm9J46SHLgsu5ti7MCL6gxpe8X8vAj2tpPvZRLDItl
         RM2fUglJkJ2/6Xj2eibtsAd0YYgS97BUlGhGkvQrI6KiUiEIMUDa3N3YCXyeuYegrAhW
         V9ItTylnSdt+WDAS8UW+1k9+d+n2NHwZMTa6N3uOn0K4bJi3GmGNXhyYKyEBmjGzJkjf
         3FEyGR9GAxigcA/6Yuscvt7z27BlKXuWnaB6YgjWBMSODrCzjPapzqse57X9EkLAOrBv
         gzww==
X-Gm-Message-State: AOJu0YwxBsZ1ZFYt0r2MOGqqRs0clEDvFFga2QSHLnbaNQmVk2D3j153
	KWQHR5stitdx6kd7SZchgTgTW6SxI05fXEszLZ23kwn12WjmdAFH9uO16gOgt5EZfSdM6UgaUiv
	zD3BrcLkDCeeLLR9Ge5LmQX/xOFBcVvmyMZD5BsGyk+ITJ2Ti01niN4YwZ6FPIThZ9iGBRXzgvu
	iUf0h4GpQBeRUh+F7Ecovn6ZCUZC/hNeaVZePvCnYBCneiI1fdcVZ9BGB+JQ6WC20=
X-Google-Smtp-Source: AGHT+IG46JxU0jfSTXvusA4Eomfk59BlIHtg11FHTnd9jKqASYShcps1JjwfGgMvZcQtcixOG3gO82yT0GIGNAewiw==
X-Received: from pjbqn7.prod.google.com ([2002:a17:90b:3d47:b0:30a:9cb5:7622])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c105:b0:305:2d68:8d39 with SMTP id 98e67ed59e1d1-30e7d5221efmr9137782a91.12.1747440688761;
 Fri, 16 May 2025 17:11:28 -0700 (PDT)
Date: Sat, 17 May 2025 00:11:08 +0000
In-Reply-To: <20250517001110.183077-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250517001110.183077-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250517001110.183077-7-hramamurthy@google.com>
Subject: [PATCH net-next v2 6/8] gve: Add rx hardware timestamp expansion
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: John Fraker <jfraker@google.com>

Allow the rx path to recover the high 32 bits of the full 64 bit rx
timestamp.

Use the low 32 bits of the last synced nic time and the 32 bits of the
timestamp provided in the rx descriptor to generate a difference, which
is then applied to the last synced nic time to reconstruct the complete
64-bit timestamp.

This scheme remains accurate as long as no more than ~2 seconds have
passed between the last read of the nic clock and the timestamping
application of the received packet.

Signed-off-by: John Fraker <jfraker@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 Changes in v2:
 - Add the missing READ_ONCE (Joe Damato)
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index dcb0545baa50..c03c3741e0d4 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -437,6 +437,29 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
 	skb_set_hash(skb, le32_to_cpu(compl_desc->hash), hash_type);
 }
 
+/* Expand the hardware timestamp to the full 64 bits of width, and add it to the
+ * skb.
+ *
+ * This algorithm works by using the passed hardware timestamp to generate a
+ * diff relative to the last read of the nic clock. This diff can be positive or
+ * negative, as it is possible that we have read the clock more recently than
+ * the hardware has received this packet. To detect this, we use the high bit of
+ * the diff, and assume that the read is more recent if the high bit is set. In
+ * this case we invert the process.
+ *
+ * Note that this means if the time delta between packet reception and the last
+ * clock read is greater than ~2 seconds, this will provide invalid results.
+ */
+static void __maybe_unused gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
+{
+	s64 last_read = READ_ONCE(rx->gve->last_sync_nic_counter);
+	struct sk_buff *skb = rx->ctx.skb_head;
+	u32 low = (u32)last_read;
+	s32 diff = hwts - low;
+
+	skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(last_read + diff);
+}
+
 static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_ring *rx)
 {
 	if (!rx->ctx.skb_head)
-- 
2.49.0.1112.g889b7c5bd8-goog


