Return-Path: <netdev+bounces-237010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B486C43310
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 19:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA26188DCA3
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484512727FC;
	Sat,  8 Nov 2025 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="B8hnmsvC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065B273D77
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762625671; cv=none; b=e5xzA+qOKO162PDIgLQorMpOJPDu3AnvK0kDYC1RSFYF4r96mjTMNbYLE+K9ONNhtIRBKImpIqNd4H2afwUtwmCkUbEt1JU/Htmmdp9xGtuMgPJ/Qz/Q/8WxDRDK7WEFPrbBfNER704uq/rX51CQOvENtMUrABAOLqaFRQvloBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762625671; c=relaxed/simple;
	bh=vF0HB38wJkPTVly0OuNXG5FV6TL+Iq9ZY8RCdHo5Wak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/lZeALVsRz64c7FBW0rH1tgxjI1lq+761PwuG8WTqqRzC2z3d8ob49aflTMKu27KDZs9A9TJjP9LZf54pAfWuBVYXPSDSt28K8jrJfKN2VZ6hmtlGK4g0qfjpqvMZ6neLR2TWCiFXeAktH8rBAFpriLs0HMevk3PE/g1UB0Tlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=B8hnmsvC; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-44ffed84cccso354595b6e.0
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 10:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762625668; x=1763230468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4oSjCnI9JiSOr8eZcDeqKz0vplgjQLs/0qDcKMj/uM=;
        b=B8hnmsvCiWNEvoaZCvOuTUjquRC2ORFe/DVGS1mf49bsC7fqztGgquU4FbU6biOyDy
         39grLe7L2rc9TDWwV8qCvz02fb7rysVGAeClHpOs8ZjY9cWBAucIUZdX1y3NW1NzeIzd
         aqe37I3aXQvDKbb7zMPEtT8g/U6XwVQzoduOytHcz3JMbnP63A/IwPBevXqkcw0excF5
         cX7WkiLaoGE4+33p8MgPEcrX3VpzZejz92+C5XyIv5vz+0rZ1iHgDbSH6sTrL/ydNAY5
         U6vV/41mxsRpoyqVgKpPKZRjq4lEj0OEyAqJfUQJL2T81V4hmnwom2795ub5+/Za4Php
         3huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762625668; x=1763230468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4oSjCnI9JiSOr8eZcDeqKz0vplgjQLs/0qDcKMj/uM=;
        b=Hm1+gMushQL29pSaxgYOR2EODqsjhINeJSN00olJwPFFZju9zUSGr1tM4t8K9SrQzv
         1PZaRaXZqyrkqtU8KxROVsaSqCoANj9PIvBQF5mJgeENOcGZtml2K9psGMF0iH3t84NI
         Gm43qjnsya+KS5v3429H+eszNBKX7+Us5mLZw8LLr/moq/hOnst0TXpiN1aLFIt9wwuK
         qyz36C2t0Z0iVqYZlkbDgjxJMBAIeyZ/z9lSAoELzV6DAaj2vrYk7yhLUcPS3hin28sx
         1EBLW55hxTl8SSplB4EvzOX20U+wT4VkO/GlPgCuJmCJVkgo8TsD1XkyGB0KDwUl0X0n
         0sjg==
X-Forwarded-Encrypted: i=1; AJvYcCV71dAox1nW2cfA/sY/JVvvP5hJPa8WjzJYUxvcDOrK/H9qsqlz+0HwC5mLzBsawDVbqrFONSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxku25ZgpRFAYZYb0AryZ9F2W3DsZ9HdTQdSjk5/xCUU6Sq4UB3
	ALKKFLgq71TMAQqoB9Uj3kPFDltn734uhV538sFddZU5mUK/bcW6S8FJoAKlMWHkIMFaLFnOFem
	HdBmf
X-Gm-Gg: ASbGncujk+lUCAgH8u5K1BVgAJ1a2DEH7SiaFMiwb/KpyNsRQ5C9BLyAMLAbQA2eJiE
	pYbykcwr0Z5rojUsZLvHOMuEl/w3tSq/wHlKyCk5ola64j3VaRsSc2kwYvZ7Vyb3MtRBI+xxws8
	r89y3E3npSoxSBNZVNF08xf7M/QbpC8fy4rW0pe4cvN3m08oObWV/AgmO4g+++oVKjgot+V0qrv
	yLTxPXh9RfFlXpdk8Ezyv14v07V+5oFv4LYftbPYes7eH+S5e2L0ikTJYUvprzMATCHu0yDHgQ3
	tB3CeKRDYKBghNUisbwbuW5HjFfYroe1S/ckHggVmbIfLc13s0ThGepBXXhZLnjNanfTMJMQLEZ
	6sq2O53wibhX98kmZU7uQBuE5rEuNkebLu2R8y3qjnGBvFl7M2uvzk2NK6j75q7G6Mj08mHktIj
	l+vNeLxNnbwP7Ap7dnQsM=
X-Google-Smtp-Source: AGHT+IEsg+MmSrneFrsIwhV52A5JHhy7NSU97/Ab6EeSmSKRZcQtD2Z4wdEXTgfc83fHDbel7AKW2w==
X-Received: by 2002:a05:6808:ec4:b0:442:82:3efe with SMTP id 5614622812f47-4502a176dbdmr1543569b6e.14.1762625667713;
        Sat, 08 Nov 2025 10:14:27 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:49::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45002798bdasm3679000b6e.17.2025.11.08.10.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 10:14:27 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v6 0/5] io_uring zcrx ifq sharing
Date: Sat,  8 Nov 2025 10:14:18 -0800
Message-ID: <20251108181423.3518005-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each ifq is bound to a HW RX queue with no way to share this across
multiple rings. It is possible that one ring will not be able to fully
saturate an entire HW RX queue due to userspace work. There are two ways
to handle more work:

  1. Move work to other threads, but have to pay context switch overhead
     and cold caches.
  2. Add more rings with ifqs, but HW RX queues are a limited resource.

This patchset add a way for multiple rings to share the same underlying
src ifq that is bound to a HW RX queue. Rings with shared ifqs can issue
io_recvzc on zero copy sockets, just like the src ring.

Userspace are expected to create rings in separate threads and not
processes, such that all rings share the same address space. This is
because the sharing and synchronisation of refill rings is purely done
in userspace with no kernel involvement e.g. dst rings do not mmap the
refill ring. Also, userspace must distribute zero copy sockets steered
into the same HW RX queue across rings sharing the ifq.

v6:
 - removed ifq refcounting that merged separately
 - fill in struct io_uring_zcrx_offsets
 - shorten functions + structs
 - move ctx flags checks from export to import

v5:
 - remove sync refill api
 - pp mp taking ref on ifq
 - add ifq export to file
 - implement sharing by importing ifq fd

v4:
 - lock rings in seq instead of both
 - drop export io_lock_two_rings()
 - break circular ref between ifq and ring ctx
 - remove io_shutdown_zcrx_ifqs()
 - copy reg struct to user before writing ifq to ctx->zcrx_ctxs

v3:
 - drop ifq->proxy
 - use dec_and_test to clean up ifq

v2:
 - split patch

David Wei (3):
  io_uring/zcrx: move io_zcrx_scrub() and dependencies up
  io_uring/zcrx: add io_fill_zcrx_offsets()
  io_uring/zcrx: share an ifq between rings

Pavel Begunkov (2):
  io_uring/zcrx: count zcrx users
  io_uring/zcrx: export zcrx via a file

 include/uapi/linux/io_uring.h |   5 +
 io_uring/zcrx.c               | 218 ++++++++++++++++++++++++++--------
 io_uring/zcrx.h               |   2 +
 3 files changed, 173 insertions(+), 52 deletions(-)

-- 
2.47.3


