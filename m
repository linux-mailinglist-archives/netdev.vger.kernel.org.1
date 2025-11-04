Return-Path: <netdev+bounces-235616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9466C334BB
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CA364EB08C
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2AC314A66;
	Tue,  4 Nov 2025 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="fbWy/xOC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7F2D3EF1
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296302; cv=none; b=Y1MACEiXYLEmm55GCdrt2W1JBRv/J2FmAuIprWEPhYeUmdeqKQBhpBl5zkiTgqr60goWymPHtdt/xRF4DCMwv/d7RNang7SGQ/BwJACVVdQ/t9GojMvJbtSB95gTqg5AkArw0iOxm5DAN4ERNtP0zGb+oW0dH125eEGYfL96oxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296302; c=relaxed/simple;
	bh=SzbY949HTbeuEbcREeo1jaQ7GGyIn8WCWHS7yaQgov8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nbgyhsf9QK+8W00/xUivv4NogvI404EQSAIhfr1sFCV1GW2wSJo9BuNCQHfbD/y/piyL5JnMU4KWZaFZu8US6JMMaVpK2XXwmvo/BJeIqq20rNlmXog80dx5gaOlZaVU1tyTTIPEtGjbiTfn/ie/p5Ei+UExvKOt/i/BQu6r7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=fbWy/xOC; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3c9975a3d6eso2197386fac.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762296300; x=1762901100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qX3+I65dPv2qgKgN/xQHOS5A8iQyG9INbe7rBCqX/kQ=;
        b=fbWy/xOCYe9hT14RrM9HtHMDk/2ge2Fnf+r1hjbR9K2AXoQQZxx6+jyYJ3j9MNjDg+
         yZt8zgltZRYAhfFTxq45LioQHh9PA235EBOnyVXB80tjfQMWBOOPIsCXfT4Yr2TW1MKt
         Xnib26mPmKI2/vmsvWO1GMtwCCIuv+glbGSpPvXTYc5gvSOppavUcibvbZy4eGhg/11U
         pUX4q6V+7V/T8c2H+Qilcd1CiYGV23uvHQNezNQgghODxu4Ap65mVE7lV2bxMEsI4hmz
         9rJczmwFTa0EeSFWcofJJ0JkuIbFUkV02I+4JYrQU07s34l0FU0mU1uaYjkHl7Ru0us1
         E8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762296300; x=1762901100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qX3+I65dPv2qgKgN/xQHOS5A8iQyG9INbe7rBCqX/kQ=;
        b=gCmj3qXKTQuSGJ2t5XB622jhZfPS5snqqek6qMoCzxO3F98bOlmAH3YItr5CKgFKMP
         Qe9GXkCDuZD6bfsbQ4ahgpB5qxo5orKabKFalyiNY1fwunodakSD8XhLhg8HUGa8rJuR
         Aetk5FJtaBYh/EHMDuQMf/dgHkXurJofycfJFKfqUAPNaweMdA9tPa3fCrrLc9LsbhJS
         WE7FxHI2wMIpTL8hnK8we43Ad8bGJmlNOSbBmcY7mZp8HsEus3asBMkXjohT2HYiDcOC
         5oYMbY1Feg5cTY9+dwjv1ipvQDFjb9689fyC+9EPZcN2BHHW5699Taps+kiWPdyRMK1t
         vvEg==
X-Forwarded-Encrypted: i=1; AJvYcCUDvOEHdrmW1M//mLBc76X0eUZu7Q23p3umy3+QMGfNE+9FvQ+0kX2+Mh5AFDjt4Jy5sgycQn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1IIrhUjadZtcB8pPjYcFfeJzzVO4LL2tr3ZG7tzS0M/RhfhIH
	DB9C6flod/+ZVR13yiyEHghf20FJcw+mlYjKo/1R64z+8r3u1p98qlitRTwfJhogRNw=
X-Gm-Gg: ASbGncvI7vSA5+JmnAWaVBiqWQK86o8BCSbgbRTvCANpOF+naS23+n9+CfrAH5PO+kv
	0n7nLW98Af1EagromiZLl6DXzoZ0jSbCiC+amMRud21ExZbD6yFOnrdU7OOO5tyWKgjbiOoBv0G
	dGChU6eA3/W3zCfGgeP9KXUb0rKE+Qxbkv3uAw9TtYcZeeMHARotosMRTAarvPnVzwMEt7p2FIO
	TQUfRlJmFBJP3gMJ1ac9/byHk/E0YgtOjt/X/5Hi/hW1xwPCKkR/oOswIsG/CzyL8U+qBX5Xhnj
	Nf+t62KKJj/sqsjvDGs9VrsQTEeA6viaXO2QZNQpJQX518B9/S4IIoeuRbb1DSGoiX+JPZbyTZF
	RqEoddks+ugNt4EFnQL2mcxDKpgxU7Z37VMObspjWOZVzp/aafjym+iFxXCdPvqhsWtYgDGRDhQ
	172Yk5+cLCsHVj6nKX1Pg=
X-Google-Smtp-Source: AGHT+IHSwP5/mzEm4oVJq2TsD2zENGY/Ep5zG4Qpm0jNwYERcESqk/zpzuvT+YFMn9xJEFZqVeGVqA==
X-Received: by 2002:a05:6870:392b:b0:3d2:590b:8d12 with SMTP id 586e51a60fabf-3e19b942b06mr426968fac.45.1762296299865;
        Tue, 04 Nov 2025 14:44:59 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dff736d114sm1483098fac.17.2025.11.04.14.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:44:59 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v1 0/7] reverse ifq refcount
Date: Tue,  4 Nov 2025 14:44:51 -0800
Message-ID: <20251104224458.1683606-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reverse the refcount relationship between ifq and rings i.e. ring ctxs
and page pool memory providers hold refs on an ifq instead of the other
way around. This makes ifqs an independently refcounted object separate
to rings.

This is split out from a larger patchset [1] that adds ifq sharing. It
will be needed for both ifq export and import/sharing later. Split it
out as to make dependency management easier.

[1]: https://lore.kernel.org/io-uring/20251103234110.127790-1-dw@davidwei.uk/

David Wei (7):
  io_uring/memmap: remove unneeded io_ring_ctx arg
  io_uring/memmap: refactor io_free_region() to take user_struct param
  io_uring/rsrc: refactor io_{un}account_mem() to take {user,mm}_struct
    param
  io_uring/zcrx: add io_zcrx_ifq arg to io_zcrx_free_area()
  io_uring/zcrx: add user_struct and mm_struct to io_zcrx_ifq
  io_uring/zcrx: move io_unregister_zcrx_ifqs() down
  io_uring/zcrx: reverse ifq refcount

 io_uring/io_uring.c | 11 ++----
 io_uring/kbuf.c     |  4 +-
 io_uring/memmap.c   | 20 +++++-----
 io_uring/memmap.h   |  2 +-
 io_uring/register.c |  6 +--
 io_uring/rsrc.c     | 26 +++++++------
 io_uring/rsrc.h     |  6 ++-
 io_uring/zcrx.c     | 91 +++++++++++++++++++++++++--------------------
 io_uring/zcrx.h     |  8 ++--
 9 files changed, 89 insertions(+), 85 deletions(-)

-- 
2.47.3


