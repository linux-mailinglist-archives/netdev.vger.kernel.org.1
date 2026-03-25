Return-Path: <netdev+bounces-271540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLxeNRnhw2lvugQAu9opvQ
	(envelope-from <netdev+bounces-271540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:20:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BACB3259AC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1280D309320E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819EA3D88E3;
	Wed, 25 Mar 2026 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey/htoSD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5F33D7D8A
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444160; cv=none; b=j4FlzU6Kscclkjwkm3Sa39KhIxZHrZyUYlDzoYlpxyGL49ZQ/7ilvsAmKYx626yxiNQ3jL9UCmMDu5cO+mF368/eGFpkYPIxqUTyEi9M6FJg7i2nLPU7bcU5tkobEaVD3bUhhphclWIglZN13ZJiI5IfhjuTTpL6WwTRRGh/tM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444160; c=relaxed/simple;
	bh=8dcACiXoZPc7rI6bRDNFxNEVa6WUQdrHX1lzl6WzD+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lokfB7mJGUqFwqDE5Olky+6fAzGG0fexKjLO1RsWh+Q6ctCOdxYJvOUH7FOnspxyfQvulUPGCCE8DLLev8nkhM7TPKTLWJFljYZ7rKnItfiQT3MFGphhEi+w9UVu2xeT3MYbKVjGbFv/rKIXkd54xY0K+BA6TEjrHHcF6/v6wKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey/htoSD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b6d9c981so626133f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774444157; x=1775048957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tK8GZ6vdDAcYV6J0Km1TLOUN9CYUfFL+0DfUE0nS4c=;
        b=Ey/htoSDwgxsvvkCg725sp131aXX8mE72+xF2UMDgmY6Zy1yQRIpigpyMtSGH4CQDK
         gVmuc7uhKQwvVaceJr+4ciq/rpdj4+w4bYiFdea8Ng9WG+DiT05eWuY2fryXo5r0Cw5o
         A0r8qJRCzIU0jTAmly1ZpK8RGoCnI3mGPVZa6IoRKeyc5E4u1jmjLjqr7fBZVskSm5rp
         tb5zC8Nva7xmLQgNKbt9uFPLOfbYCP1L4aRcChrOdPzWGBQDu/GaXrmV0CtJubHyeQw8
         +JJBXo6tyaNTf3EOekSFh/SQYbTO4O1MnpYbuf+yEEqHfpUj7eO3RvA4qlz+2r3Uphoh
         rWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444157; x=1775048957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tK8GZ6vdDAcYV6J0Km1TLOUN9CYUfFL+0DfUE0nS4c=;
        b=aRdoFYTVeQT+NtqJxUDAp9hubGxTk4hgrCwumE3JKRvQkjoNE4yMb1y3utHg22KX46
         71mxT20V6IYlm2oMHrXvcVQXXMK9Sg6BQlzk+3BwYsRNhaY17D1Eul6b2OdvE2vTZNdI
         Ym9CJNkwf8jfDnsSbVzchT8IhWkMY/bxM85ph7fcRLECK7GOdjytwhimqOpjbcAbQHHf
         CT352Jhwn4iY5tnUkRTWGuEky6O5p77dwKX/l3LQz1Q25ncroz1QIUtTAbhRknZDj44+
         y/iDcwtZYn2TBqgb71IyLXID48uxlY1H552xHD8lf4yrugRpM4wzuOhtTdH8xtyh+Fzp
         2zHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Zm3W3F1j6GB4O8Cz6QemWrp2S2x+/9FFakpzDRKSMHX0H3ZBkQQ0zuAgK02nf+86x1ZmBUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6lH5/cqKO4zvVIZxngW2I8Oqo5Sm7ELLs6i1FdFXE4+fdiX+
	2OQ6nS4uqcXAv9n4liYuWZHdhmPqH1A+nFlImh6zyxzYxwucxHI7egNKkz5R8A==
X-Gm-Gg: ATEYQzxsfjlCsXyjLjrHEYQZqA4ICye4H9ODfxITNiMcX2DbURb5kdNyKWYnKTL965b
	kpZvvovqzzljEWplp1sRF6K6u+Fb1b4xFYHrWUK2DDnN+cLTFS1iinB0BepDj6ISXKlPJgx/QYT
	5EMmdQHQKqXk1Qb9RN4RxMxysqnw3l3Gmi4yhBW0H5gR+8PDVASwisl6xIrn9F4g50DzqSh9n3R
	sKZQHVXTB/BhdizzLjUeugPA6oK7R5pHgvWPBKVEeDxKyolIF7ycHx3kd3K8wUMwv9gIu+R6/qP
	qyLdrf+3cZXnFP2iQz2adKSfJWFkT0FWjqQL0h5JdUpXVioxYPRMBWcaUZQ3WL4ZMSGyTkr9Nrd
	TQs21Z4SEurFoxRqxywYLcrqQeVV7iyxnF+5BW7TgyOb/ldpw8yaq5ZXYZKFDYOjSbz5CZ5+Yph
	A53B6xMlso9Lz0s+G9p0Ug5GV8pSlMDOOFsBGTHKH731LmHxHolB4G1LZ0/4s8nR1e9uOZIFV+N
	py8qCqjSg==
X-Received: by 2002:a05:6000:2004:b0:43b:548b:e7c9 with SMTP id ffacd0b85a97d-43b8837864amr6104017f8f.7.1774444157308;
        Wed, 25 Mar 2026 06:09:17 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm54062611f8f.12.2026.03.25.06.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:09:16 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 v2 0/5] follow up zcrx fixes
Date: Wed, 25 Mar 2026 13:09:17 +0000
Message-ID: <cover.1774444007.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-271540-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BACB3259AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Follow up fixes for the recent update flagged by review.

v2: reject REG_NODEV + ->rx_buf_size

Pavel Begunkov (5):
  io_uring/zcrx: reject REG_NODEV with large rx_buf_size
  io_uring/zcrx: don't use mark0 for allocating xarray
  io_uring/zcrx: don't clear not allocated niovs
  io_uring/zcrx: use dma_len for chunk size calculation
  io_uring/zcrx: use correct mmap off constants

 io_uring/zcrx.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.53.0


