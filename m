Return-Path: <netdev+bounces-258802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 55v8MPE7kmn2sAEAu9opvQ
	(envelope-from <netdev+bounces-258802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:34:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1326B13FC73
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E9D53009513
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF172472B6;
	Sun, 15 Feb 2026 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWwi8xJd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6CE86331
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771191278; cv=none; b=FRYjrk5wokGgLd1y7COny0XfdYG4jNiML+tUIeSG+bslKIagu5XE7I19fYM2nVWvgCqb3JGtgHtJaaIwRWv3Awgw5mbI9gQNsRQfasEnFyt6Bxb/pULrN5P7//vyNQQisoyLyEmNhkiIPkhfNERZqz7YWW0tN3Qax8wSjjwN9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771191278; c=relaxed/simple;
	bh=5+A9BM/9j4EZl47CcaalxWpYyqqhceOe5Lgrzliunqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYmbO+tTOZb7qCFaFH+AJ1rlSIEE2Ml11/EDaSmw6kdGpsSaYiLwQNC7sbHe/ipS+gMuDO3VZFSft0qxesFcxBTv39bA7GypH2O/RP/cbKd3z92wG0KrMnejesP1Q3HlS2sakS5z6DQRnlUE0G25rsV0LDFcaXu99CzSKB33L+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWwi8xJd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso21344385e9.3
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 13:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771191276; x=1771796076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pUXUjGf8GywcuWoq0eu0G//Qfj2+vuON25+u2VLtCU=;
        b=HWwi8xJdFwXP11R4GHQj9rYiIXqBHDdnN21ZJMHy+1hTV69Y2bxKi2Cbejd63JjAcQ
         6aXbWnx1gbBJTe6zE4ICHc+4nrO5laz3AFZBFwZMm+7onCMLTKqhuNx/CeModJezsOMG
         0yF0UceP8Gi3/walh7Eb5SmXaLH/idXfq8VUawdwSmD3mFmkAQAS26UPtl9A0EQAbeiz
         MM4ZjWfOVs8sGEhe85HEiHSJNaalr981tufrNOIs6WyoX83JtWMtrsqTPS5KN1T1eutK
         TBW6bfkpK4oHg/s43E6IbCb5fZp48FxtLmTdx2G9TDMspGfUE2lzRzjd2FYgDrT6RvK5
         0ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771191276; x=1771796076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pUXUjGf8GywcuWoq0eu0G//Qfj2+vuON25+u2VLtCU=;
        b=mBzSEWhetjkSl8M/MUZchhrMggStU3J8mGvXIjb7z6tZZHsZIFORCMYChTADEFSUxY
         Zea7KvGvZHvvvrZnmLKm9fWcWswAY2yDQHgtTMK2qluU5R55cPsyn5BvB6S+ODKUtOxL
         4OC/K3oT3E0YA5pyVRvIlZgH6SZXrsPaqh1vWr/JVfMge6DicJLKl5+o63IEC3JG5wES
         1mf1/QUlPbkBNYAN+yXqrVoxaT+4r4ri/3Zbb2m4wRcRqI4k0Pjp3LbxGvVOj4nG8EzN
         K/5ZDXaV5n9MtIf6aQ1qweNKpFuDgJUW5iTCQs5qOo8ysF00H/tyTZQSuKC02xdwh9aP
         P8IQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8RevPET/WSk/H6PeT+f/sqTx+DC5ZJZwNbDxytJhOF0dYJRirsDk8Iou8s2vuXl2QHNolPMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6nFfFLrLF9z7PM7RoZlXq03YSK49WpUAHinWqVetTRlubZRQ0
	/OdTVZiQWJWO03Nm+nzqDkLo4ePe1qSKftFIqUFGg8rAfwmQugWVWJBg
X-Gm-Gg: AZuq6aJlV6JSc7LCRLVy1PXxTC630vqdTRsO9LxqAvXnzwmrMlITeTMz93uQV69hA23
	0uymEzjXJaWEAqZunHkj+TaGsKx3PEWg6XQ5eqNhbAzGUD4gtDZRv1hBRMkCCU0MkPXSU2dWstD
	Dxkj5isN814zxDeAtE970xyYNNoMCr+9/9Ty88FGydme/7txxhtSlZpRV5PsBloS3WJNofN8UN5
	kQqhZt/vWG1xdBXMpAiT8Lo0KomHNg5ztNa3S3ipcwJ1BdC+8TnO4R/VV/IOjuKDsSxACc3B822
	2ArZXhSjoe7naiRwIMNu5+nCu8dv5PuMWLhnu6/aiqBbbg2iHLtqF07Y71L2MCqGe702yS3yFCw
	jyH83S3WNcwn+cUUGC+k1xpAL6KMsaFf5msxwgUSsigwNyEfBqIZknYnzCPtcj4eX72u2R6nEzm
	iTkUR7eJ4uzpi+vaQpJsaYx9X7deN+00TCk+cldGXZJ8ISYDjrSEtys+KoOaP5kV58IyqZ4ijvl
	4E0tyU5F+I96biIYsUBzp06/UEpyw==
X-Received: by 2002:a05:600c:3106:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-48379bfd705mr114445795e9.21.1771191275620;
        Sun, 15 Feb 2026 13:34:35 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd0e327sm378040235e9.14.2026.02.15.13.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 13:34:35 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.0] io_uring/query: return support for custom rx page size
Date: Sun, 15 Feb 2026 21:34:28 +0000
Message-ID: <2e8280467c93ead0c61ed3d68c036d6a0474bb78.1771188227.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258802-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1326B13FC73
X-Rspamd-Action: no action

Add an ability to query if the zcrx rx page size setting is available.

Note, even when the API is supported by io_uring, the registration can
still get rejected for various reasons, e.g. when the NIC or the driver
doesn't support it, when the particular specified size is unsupported,
when the memory area doesn't satisfy all requirements, etc.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

It's a simple change, would be great to have in 7.0 so it comes in the
same release with the feature.


 include/uapi/linux/io_uring.h       | 8 ++++++++
 include/uapi/linux/io_uring/query.h | 3 ++-
 io_uring/query.c                    | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index fc473af6feb4..6750c383a2ab 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -1090,6 +1090,14 @@ enum zcrx_reg_flags {
 	ZCRX_REG_IMPORT	= 1,
 };
 
+enum zcrx_features {
+	/*
+	 * The user can ask for the desired rx page size by passing the
+	 * value in struct io_uring_zcrx_ifq_reg::rx_buf_len.
+	 */
+	ZCRX_FEATURE_RX_PAGE_SIZE	= 1 << 0,
+};
+
 /*
  * Argument for IORING_REGISTER_ZCRX_IFQ
  */
diff --git a/include/uapi/linux/io_uring/query.h b/include/uapi/linux/io_uring/query.h
index 2456e6c5ebb5..0b6248175e26 100644
--- a/include/uapi/linux/io_uring/query.h
+++ b/include/uapi/linux/io_uring/query.h
@@ -50,7 +50,8 @@ struct io_uring_query_zcrx {
 	__u64 area_flags;
 	/* The number of supported ZCRX_CTRL_* opcodes */
 	__u32 nr_ctrl_opcodes;
-	__u32 __resv1;
+	/* Bitmask of ZCRX_FEATURE_* indicating which features are available */
+	__u32 features;
 	/* The refill ring header size */
 	__u32 rq_hdr_size;
 	/* The alignment for the header */
diff --git a/io_uring/query.c b/io_uring/query.c
index abdd6f3e1223..63cc30c9803d 100644
--- a/io_uring/query.c
+++ b/io_uring/query.c
@@ -39,7 +39,7 @@ static ssize_t io_query_zcrx(union io_query_data *data)
 	e->nr_ctrl_opcodes = __ZCRX_CTRL_LAST;
 	e->rq_hdr_size = sizeof(struct io_uring);
 	e->rq_hdr_alignment = L1_CACHE_BYTES;
-	e->__resv1 = 0;
+	e->features = ZCRX_FEATURE_RX_PAGE_SIZE;
 	e->__resv2 = 0;
 	return sizeof(*e);
 }
-- 
2.52.0


