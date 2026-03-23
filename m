Return-Path: <netdev+bounces-270518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OS2GxE3wWl1RgQAu9opvQ
	(envelope-from <netdev+bounces-270518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:50:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E49A22F2375
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F072302BE03
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C4439F19F;
	Mon, 23 Mar 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHWdFaLX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937138A71F
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269845; cv=none; b=mfjrrfgbpYYzmGVJat/CVEHCWUUjo2QOV64G18kwrVYUHxOoYFPBdevSVE6hyPrERedgzRjCt7S8FK07tjAg6JV7uxztZ8iF8jn+Kad7TxD34kb64e/4Sx2HlpETLQFjZId53WFVJeNB1nzDk41GvOpRbdr1eA4N7FWLhVR6VrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269845; c=relaxed/simple;
	bh=G6mXLFYcUH6oI5I1LJXYCNY/0zYyH/Ijjh3eAm1LxDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/e7foG6Ios0pJmmRDDdkIE9e3yNSWN1YPtnbe8JLOg2mRQMcOynOEpxpc1ThlWB1VUmd9jbM14b4h4bzVeRESj+BUilUGY23bY2vKQEWpSWdLtDzOyUIvfJypDqAECr2R/4575gooLSV0Rrp0o250W4L1lXHhLvoZ/7SnSSTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHWdFaLX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b2965d4bso1933012f8f.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269842; x=1774874642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mbc9t8qQAUbV+W1yw7w/qNXR/GMAzA8hewMhzmWu3g=;
        b=jHWdFaLXw0mht5DgxwPR54tlxsFjoxuRREcEGdq8m3iKQZHQejsD19JqotqAW2N4pK
         MP9rILWDdJOWhZvGBj4yXIQQQk95VfxjZ76Skh/8ImjOvsLoD+b6TakkSAKhHZY4mUJX
         DtjPhLzNpxj3rV0Vc0oVE4G94WWgpnV2eFcyCjN6pyd4J2zcQJe+CnEPyZVAH2vzV6RQ
         UQCAToyZVF0OHCAEffP+B4R6G+OBw05dIOZCI5URUnCK17xYRrCnQqQamnfL9myF/p6u
         HL4YQvloceQwRm/7Kd13ijMjHD45ZnkUQRJeNQ8sCLzXiDIR8D4HIBiktqmmv1I0Rcyz
         q87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269842; x=1774874642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Mbc9t8qQAUbV+W1yw7w/qNXR/GMAzA8hewMhzmWu3g=;
        b=ee5Rvo9vLqzGDi4MVhOQXo2NqkksiC6w95y2lR4xutTjfYYGMAv9CLBEZ0eFvOGBCA
         uF6BBe169avuZfiBt/4/0f/zvQvYkRdjM+X+tJr+gBCc8oASDQAmGCn0Rb3jw0sHc4RZ
         CS3fQDcV1E02fTNBtIBZjl+QN2FnZDYMezmcXPiHi9r0+Uld0Rm25f78HHLiweJw+qaL
         0tE3DTUQDCcO9WEhXoo/wXElfU8FCMC+V4FMXY9eEskOZdRRx5P/y0IbmOEEZASabrrK
         X2774SknxnNYng8VHEn27PS4IhFvNdjZ2EkFdDeH9BShMSVrXG3c1L/3ZrHalFoeOe/H
         G1mQ==
X-Forwarded-Encrypted: i=1; AJvYcCW80F5saL/bsrtEYSs+Heh4krWxojaQBOiWoN5oa6AsLMmlqUmnZ5APR2HHfUcrEGnV+/EuD1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+OqUPRkyyRINRnAIyTtZp5q8DsWR4AeB5DS/0gy/WTY8wvlj
	qFm1WdsVfUpq1j2K+bi55T9pGZ3BZQluW5FVeP55EM9sJIgJfuUSu60K46tCqg==
X-Gm-Gg: ATEYQzy+MK5gQhLslhXVH4ZlkNBJYgdVXznO/uDx5hJeHTOHUOto7nVYQW05CfzuRwa
	RLicPXHiSpiJs23TN10sp+qdbf9+VVkGJ2fPxXWecqsAPm+XPE2mKZ14t0bQgMCg55jNtqncQuy
	RX61rN/8yr3HYqTINJi7vYqP0Ij2M6MuxN30tkMIJanaHw+isYAH7NvLDw+PB9pP4PaLW8UCdBT
	amMwjQnln6NUgXEZTlIBVqTxX3saMs1ZSz9ucqW4S9qv37l1tvMcu42r3NWWsCl6VymcyfYOFWD
	hm9s/NI08AAgfVVbyos4NYH8t517C6dDEZ3e8Tqk2mhESoX1HxOW9gMzW6r8n4R8kh1GGTAc94s
	YCNNlYxAHbOVRtqTNubSiFvk9+eZ2doHrD2qeTbbZPitSEZBX6nn3zjar2X42fh0XTSDjhLH23E
	w4Os6SlA//Sus0TRm87wRyk5fHamjWrgA67wILcJiMBLN1tguBsIZjUxGAk22fv1gFcWOeddZbN
	VTRaP9lhE3Qixr1937u
X-Received: by 2002:a05:6000:2502:b0:43a:16aa:1448 with SMTP id ffacd0b85a97d-43b6424f499mr18115317f8f.22.1774269842300;
        Mon, 23 Mar 2026 05:44:02 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:6969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm25520861f8f.0.2026.03.23.05.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:44:01 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 00/16] zcrx update for-7.1
Date: Mon, 23 Mar 2026 12:43:49 +0000
Message-ID: <cover.1774261953.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-270518-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E49A22F2375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The series mostly consists of cleanups and preparation patches. Patch 1
tries to close the if queue earlier at the start of io_ring_exit_work()
as there are reports io_uring quisce taking too long leading to fails
on attempts to reuse a queue. Patch 5 introduces a device-less mode,
where there is only copy fallback and no dma/devices/page_pool/etc.
Patches 11-12 start moving the memory provider API in the direction
of passing netmem arrays instead of working with pp directly, which
was suggested before.

Pavel Begunkov (16):
  io_uring/zcrx: return back two step unregistration
  io_uring/zcrx: fully clean area on error in io_import_umem()
  io_uring/zcrx: always dma map in advance
  io_uring/zcrx: extract netdev+area init into a helper
  io_uring/zcrx: implement device-less mode for zcrx
  io_uring/zcrx: use better name for RQ region
  io_uring/zcrx: add a struct for refill queue
  io_uring/zcrx: use guards for locking
  io_uring/zcrx: move count check into zcrx_get_free_niov
  io_uring/zcrx: warn on alloc with non-empty pp cache
  io_uring/zcrx: netmem array as refiling format
  io_uring/zcrx: consolidate dma syncing
  io_uring/zcrx: warn on a repeated area append
  io_uring/zcrx: cache fallback availability in zcrx ctx
  io_uring/zcrx: check ctrl op payload struct sizes
  io_uring/zcrx: rename zcrx [un]register functions

 include/uapi/linux/io_uring/zcrx.h |   9 +-
 io_uring/io_uring.c                |   6 +-
 io_uring/register.c                |   2 +-
 io_uring/zcrx.c                    | 364 ++++++++++++++++++-----------
 io_uring/zcrx.h                    |  33 ++-
 5 files changed, 257 insertions(+), 157 deletions(-)

-- 
2.53.0


