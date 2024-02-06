Return-Path: <netdev+bounces-69569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04C684BB11
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7D71C21D16
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912B83FEF;
	Tue,  6 Feb 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3XNTmKRn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED342186F
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237281; cv=none; b=UK/yAzSew+IVe3uZazMQbPadDIvJys/yjtvmBMCLNZH8LbQBuCdzaKRyDpK+xzBb0cu6gyNJrK4aIrt6ZxgHcqdzeIIZa07Zp19LVGdDr3nLEKSo4LiLEadiGnzJjkMLH87cyc93v59+ZaviZN5juVgyFjTd+MUOCvh/4tXokD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237281; c=relaxed/simple;
	bh=bKldgRH+jmoYG2UwNAWyPrn7nn5FOsDfMF3ysm38zmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMWVwXC9KUdkFZzHSFXVfFjDqdOcW+BcFg3W0C1+n2xgRZSn54v3vXIK6xkE1K3+gK6s60tGWhyDYtbXcyAQ12e1WL9nrCOGx3cuIq+c1QahP9YKZ49g7c/Rr9vvAQ95kextTYusiRYvrFN8kDrpiPE0kXwELxjRNBHhuihDLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3XNTmKRn; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bff2f6080aso40931039f.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 08:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707237279; x=1707842079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmXm6XjQKipONkpkmvyaJr75SDlHSLzJzAOD7SY3R9Q=;
        b=3XNTmKRn0FiIRnTJVelM9k1FZeHv+FR7MSJ6xzBHC3NdUafD+VwMMcbwzSmnO2DMV9
         YcYBPQawc7QBgZxtCgUNOlR/w9L4EF3j6IdORqkfjW4Lq14qNiM86GhmHQlElKGMBxTk
         3nnEOn0aqTi+ZJpgXSJfsifib5bhah8xdxGxhWODa24o2BN2q4nePEqS3dVBzkDEX1oF
         g96zZbnbNFTPAfOpsG22vOkknmHguJqi7tUiIeZyKlaTLuRJXr+L1FsYtV2L3+a7yojJ
         njuPsodgZOLc+Zndty+JlmwybMI+XcHkUPk43akAzIdkeCSdaoQKhqVipmtMbEcLbz4f
         xqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237279; x=1707842079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmXm6XjQKipONkpkmvyaJr75SDlHSLzJzAOD7SY3R9Q=;
        b=ouJt7nDi+zAEaxNWfYnFk+7opS/6JOcLxIn4kg8ec8V69wlUjG0zRY9IiW4twA9Qa7
         6ZtWvKb0FOb6DDnbemKeyeuz2cUmlmCl45afKmGpDtuMb1Fp1UdRxAht6PUOp2klaLaL
         7GUP7LuHU7NsvKRHn7MGQKIDzFSCt2+8/lKoyk0bPsHuHXVnM+f8ldL3AB/G+GdmkGER
         inIH+nMmmW7MjNJO/VskajJEEHBZxnAkm61mxQPGB3eUY73/nk1XJUwQf4zPdS0Z17bZ
         NLw5crOhRm+5roottA8gY3f7K4s4vTCtSG9w9ztvBZ/75STT8uwlpHkL7DJt0eJnbO0B
         s9AA==
X-Forwarded-Encrypted: i=1; AJvYcCVOjLM53IdOd9hWSqIEY2493Naq05mG9lyP8bIJ17PzSqI52Fx+hRHfVY5CLtZNHDJn6/tSSsJXoBjGC+Doc8GqIb1cOwfW
X-Gm-Message-State: AOJu0Yzxe5nRu1xEpxTCNxO4O4kqN5OZjB9RCKygT1kfEEHqBmsJgu5l
	LiqW5S8aR8FW4dJ75VeL6MyGVIYEbnIaEF/UL3zb6KCGQpUIvbqd4tUFxyZbglE=
X-Google-Smtp-Source: AGHT+IHKGGkvqPFOBW68s7G9dDl3gUexZCFm1JpOStska+Y0ajDj6Lj6nbokX0LXKobNRGJKpn5fzA==
X-Received: by 2002:a05:6602:2bcf:b0:7c3:eaf9:2cd with SMTP id s15-20020a0566022bcf00b007c3eaf902cdmr3534308iov.2.1707237279096;
        Tue, 06 Feb 2024 08:34:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzfA2NZOInnA0ehp3R5lXv0P2AZBbkhTAWPV7VmfmxMMcmWIUKZIfSyOKSCmzaZ6LPg3zw0PFr9YbJ0MBvKzB1BZmejtQWlXFHlBkRKozV+cDYMfWzY1ia3o5e71GkZQIXOX6caDMvKjSGbt6tKAY4qD4OQEff11BJg4L1vf4K0sU=
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u8-20020a02aa88000000b00471337ff774sm573316jai.113.2024.02.06.08.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:34:37 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	olivier@trillion01.com,
	Stefan Roesch <shr@devkernel.io>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/7] io_uring: add prefer busy poll to register and unregister napi api
Date: Tue,  6 Feb 2024 09:30:09 -0700
Message-ID: <20240206163422.646218-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206163422.646218-1-axboe@kernel.dk>
References: <20240206163422.646218-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Roesch <shr@devkernel.io>

This adds the napi prefer busy poll setting to the register and
unregister napi api. When napi is unregistered and arg is specified,
both napi settings: busy poll timeout and the prefer busy poll setting
are copied into the user structure.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20230608163839.2891748-8-shr@devkernel.io
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/uapi/linux/io_uring.h |  3 ++-
 io_uring/napi.c               | 10 +++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 26f78eb85934..4f41097a54b9 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -710,7 +710,8 @@ struct io_uring_buf_status {
 /* argument for IORING_(UN)REGISTER_NAPI */
 struct io_uring_napi {
 	__u32	busy_poll_to;
-	__u32	pad;
+	__u8	prefer_busy_poll;
+	__u8	pad[3];
 	__u64	resv;
 };
 
diff --git a/io_uring/napi.c b/io_uring/napi.c
index b1a3ed9d1c2e..8ec016899539 100644
--- a/io_uring/napi.c
+++ b/io_uring/napi.c
@@ -217,16 +217,18 @@ void io_napi_free(struct io_ring_ctx *ctx)
 int io_register_napi(struct io_ring_ctx *ctx, void __user *arg)
 {
 	const struct io_uring_napi curr = {
-		.busy_poll_to = ctx->napi_busy_poll_to,
+		.busy_poll_to 	  = ctx->napi_busy_poll_to,
+		.prefer_busy_poll = ctx->napi_prefer_busy_poll
 	};
 	struct io_uring_napi napi;
 
 	if (copy_from_user(&napi, arg, sizeof(napi)))
 		return -EFAULT;
-	if (napi.pad || napi.resv)
+	if (napi.pad[0] || napi.pad[1] || napi.pad[2] || napi.resv)
 		return -EINVAL;
 
 	WRITE_ONCE(ctx->napi_busy_poll_to, napi.busy_poll_to);
+	WRITE_ONCE(ctx->napi_prefer_busy_poll, !!napi.prefer_busy_poll);
 
 	if (copy_to_user(arg, &curr, sizeof(curr)))
 		return -EFAULT;
@@ -245,13 +247,15 @@ int io_register_napi(struct io_ring_ctx *ctx, void __user *arg)
 int io_unregister_napi(struct io_ring_ctx *ctx, void __user *arg)
 {
 	const struct io_uring_napi curr = {
-		.busy_poll_to = ctx->napi_busy_poll_to,
+		.busy_poll_to 	  = ctx->napi_busy_poll_to,
+		.prefer_busy_poll = ctx->napi_prefer_busy_poll
 	};
 
 	if (arg && copy_to_user(arg, &curr, sizeof(curr)))
 		return -EFAULT;
 
 	WRITE_ONCE(ctx->napi_busy_poll_to, 0);
+	WRITE_ONCE(ctx->napi_prefer_busy_poll, false);
 	return 0;
 }
 
-- 
2.43.0


