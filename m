Return-Path: <netdev+bounces-289430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK7TNKhODGpIeQUAu9opvQ
	(envelope-from <netdev+bounces-289430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:51:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2971757E08C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6175B30E24CF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB1E4B8DCB;
	Tue, 19 May 2026 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0Kyt5Np"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914924ADD8F
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191098; cv=none; b=pWF5ux6c56toM1UQA9u2nu8/uR3QlvaBa6TQ9oZrUyVvJMFiC3SU2RH5auQOzTAa+MpSEWvw/2PfILlZTtBSkQiJEGuo6yoalIXtQC0foa08iyZ4ZFojFFRtuWFzfxWxiLJ5PNfxBcnlYynkygcp7r9Y5mgP8V8J4opHXNabrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191098; c=relaxed/simple;
	bh=tltTlQ3YCwN7E+MKCK/eCm7hU0LC7TKmmGm6F8GyX/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZqnFo299/Hsb9RODi2QG53JHxIIaMT6okO2MWnVoFY8ajD5b++Xiu99InGrLIoKGinpzA7cC8zUV0d/cwEYfYboC/aXCmEqIC6cH75NpG1RIt8dFuyRzz/7sJQnfdw6KcwYlRKr9+kA8qwrTDIG7u8GjxR3ov856VTYQ4ICrwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0Kyt5Np; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso33814695e9.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779191090; x=1779795890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLYW+cBqNKZlUyA1TVrGmuB7j5Td0XVJ7Y06ky9n+m8=;
        b=T0Kyt5NpzOptgR5dP4fAwGwf/sZJF3C8OA6rmY2Jq6enwYo2DHxRcBpzii8rM1Sffv
         Dsf5bgkBTgpuNTefsNAv3ZjBhMepWO8eGhmRq/1bbixeuLqypUChQxQN3X508O5lMTYh
         cJGPjs5GZMd4WZ903Jfp5Q9g8SjSl2jvWI4w7VvGkhlLxaT5B3XF4q5tcSSTogoGbXTk
         TWEVkST6jrwuD31huOeGhkEPzVT8baYQ52N9Nw5XuMU+07gk8Kz8mQv1aEMN3vwhEPvJ
         7rZsGomAVr5a9Jt6slWQ/Z8QmBmWeXr55rFc0YnL1urINXI39UqaZyBZPB+BRAsO7Bwg
         kOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191090; x=1779795890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GLYW+cBqNKZlUyA1TVrGmuB7j5Td0XVJ7Y06ky9n+m8=;
        b=ZS+sV73Mr+zS7H4l9g2n5TOZl8SB3UwuqoZrbWK6cAEgpWP1A05lrMhhY+Tx1svm0P
         pBe7hfuMmLHLMkJUsB5xb0PJchLfF3MPpZZQh8PUZr17455LEQFdqS1B/GMN4A5B7tb0
         gKK7QN07AGJi6mZFATihi9NxrS8s6s5J+lD0B/qdD2UfiYeSzmdS//BUM7MFDbPyUZeF
         DBfkZOklgXgvQyVudlSTOBX4eEzFBb84N4v4KrePOQVo7YICscg2ICfJBsqCARuvHBdq
         5orgcupxGvj5s9m76MOKQevpf0hqfHTGobuo7CJC1hH5s2tuxsQBy4CfLwyDwcAuNp+7
         BqnA==
X-Forwarded-Encrypted: i=1; AFNElJ89tQUC7TiQRmCZU+8YYEy6IjkDRPqz4KyF/1//O/HZiMp1LRSyw+C8cOhogIude8ncx9F19gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5js8FGLonO5uTp3nB8nMdkzJ/VLdqy6CDDiimVce6YUExUFt
	8Ne2sr2nPBqLubotGG0D2p72VRygzr95Em3G3n18XYjf78oSukj6r3ID
X-Gm-Gg: Acq92OEqU3lw0eSi3umT1/7x7FzdRpMZ2UDPAnvslU5Fe+0Xzq9Lkp+uPbM7dRKYwS6
	OnuKA45PTxGqpz+SPmj24u04IgALVkHmoctUwqAPizaWrzc8oTy0tG9NBU358vNzmz0Jh1fBzA2
	4me0vd9W1nA45EmZX7XLRfdcaHK67tjfG3znL1ZAkKWThPPtj4djS8V/TppEPH79ITm8R1Kxn0b
	TzbWi2K2C0c1ClamA5dd/s+uOJDh0z+kt6WYHiIbthbB2d05fp3C7RbeiTYMLqmxfS56J6nGbAb
	9l9tHZkz+t4PWibxKOMMkXc/gxfrKNwvlrayVSkBGUQyg8AaiZuI6+i8ylDFeqqFz0XN9FTI1IE
	35sC/P5Eu1Q79P4myGJCtm4yjGOODunwy6lLkf0bhV8h2/c3yVr8MmwRQkVfSBM/JPP0GqIPzKn
	4xQlilg2VgSkNnh0oSp7oLhaRY/IyrdFnsaUhezxnhSB7DOJH3jtDjyO0jNE3ph/XoDEQS3SjPm
	xv+oBuhVHz/Cy6hDJhSaIH1QHM/Mg==
X-Received: by 2002:a05:600c:4692:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-48fe632661bmr308857595e9.19.1779191089839;
        Tue, 19 May 2026 04:44:49 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694f2csm323392445e9.4.2026.05.19.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:44:49 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 7/8] io_uring/zcrx: notify user on frag copy fallback
Date: Tue, 19 May 2026 12:44:33 +0100
Message-ID: <3d54bcd8bf10b3a1e88beb0cd39c40c3937bea4f.1779189667.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779189667.git.asml.silence@gmail.com>
References: <cover.1779189667.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289430-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2971757E08C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Clément Léger <cleger@meta.com>

Add a ZCRX_NOTIF_COPY notification type to signal userspace when a
received fragment could not be delivered using zero-copy and was
instead copied into a buffer.

Signed-off-by: Clément Léger <cleger@meta.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring/zcrx.h | 1 +
 io_uring/zcrx.c                    | 7 ++++++-
 io_uring/zcrx.h                    | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/io_uring/zcrx.h b/include/uapi/linux/io_uring/zcrx.h
index 67185566ad3c..3f7b72b09878 100644
--- a/include/uapi/linux/io_uring/zcrx.h
+++ b/include/uapi/linux/io_uring/zcrx.h
@@ -70,6 +70,7 @@ enum zcrx_features {
 
 enum zcrx_notification_type {
 	ZCRX_NOTIF_NO_BUFFERS,
+	ZCRX_NOTIF_COPY,
 
 	__ZCRX_NOTIF_TYPE_LAST,
 };
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 455226790553..1e7c305da0d0 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1533,8 +1533,13 @@ static int io_zcrx_copy_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 			     const skb_frag_t *frag, int off, int len)
 {
 	struct page *page = skb_frag_page(frag);
+	int ret;
+
+	ret = io_zcrx_copy_chunk(req, ifq, page, off + skb_frag_off(frag), len);
+	if (ret > 0)
+		zcrx_send_notif(ifq, ZCRX_NOTIF_COPY);
 
-	return io_zcrx_copy_chunk(req, ifq, page, off + skb_frag_off(frag), len);
+	return ret;
 }
 
 static int io_zcrx_recv_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index e8b7717d6adf..54d91b580eaf 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -11,7 +11,7 @@
 #define ZCRX_SUPPORTED_REG_FLAGS	(ZCRX_REG_IMPORT | ZCRX_REG_NODEV)
 #define ZCRX_FEATURES			(ZCRX_FEATURE_RX_PAGE_SIZE |\
 					 ZCRX_FEATURE_NOTIFICATION)
-#define ZCRX_NOTIF_TYPE_MASK		(1U << ZCRX_NOTIF_NO_BUFFERS)
+#define ZCRX_NOTIF_TYPE_MASK		((1U << ZCRX_NOTIF_NO_BUFFERS) | (1U << ZCRX_NOTIF_COPY))
 
 struct io_zcrx_mem {
 	unsigned long			size;
-- 
2.54.0


