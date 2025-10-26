Return-Path: <netdev+bounces-233009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F800C0AEFC
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 18:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE183B2FF7
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747392264CF;
	Sun, 26 Oct 2025 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="2L2Qu9Hn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC261E570D
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761500079; cv=none; b=U7Q6+rDphZ7lMFhdLFE95s0YK6uPMkicShIE4nfpglcvqucIrQYxR7dig80msF2O2wVj4XUlrB+waHZmtqaVmZpK1LAw91L4cxXkYgl+VS3HL4aoIRy0bvVk7K5LRp620bn1bc4oz1U1xBupBJ+Y/MR7hQvlxxL23fTIVn40nJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761500079; c=relaxed/simple;
	bh=QCBFei7KB3yyz2A6/OKf5PD02Y+9+ae7zgwF2c10W4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CNuorKZuCMzcg4KVb3JsgyxGEdF9hit4p0h6AT6TfTx2PlDO0cWM474BKFJWAZLosbIaM49yG3mYXA8MBRxguVbfls+nJFYG+r4fp+/n+9ZJRTHJE5jq1VHUe5GWSZVCMQ49AEepQKekpVrS45UGqU4Kv06mBj5sbXyPaGB47EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=2L2Qu9Hn; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c531b9a45bso267347a34.0
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761500077; x=1762104877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5hQAycWTbfOVoFZsVkJMPoP0nvYfcVdGuBZb+36T10M=;
        b=2L2Qu9HnJ9lF8HXBSUvhKZmfCs0hE0cg+MWktpxVoimGNIZ2sWS4lrqcvoBpvjeY5r
         mO/qyeFWMkKFhUyd+fV1MBWXqbObZVXzaR5SP1LS62+z47TPoIiTwP0ESTGGOiMciAwt
         4WpZypzJv/CexDWwX45puLgFHHx/nR8AwvwdyrkaIAOi8L5v3kuNnlO4NZZvL49qj2rq
         ANvfGK+pq6HWh3y1GQhOzHJLqyvtGMiFGumdg21VyRhTqh7ohC+gGBKmFAhfV4u46DE0
         hioWFKeK6vKT9CXCZMtGwt+q1HLpsQZFO2n7WXrG5gPNLYMu9DljoOJoAOfkSylMcylU
         kECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761500077; x=1762104877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hQAycWTbfOVoFZsVkJMPoP0nvYfcVdGuBZb+36T10M=;
        b=uygSLOPgyPUAKXxl8o+BXRGl0yRySfrD1N3/mBfBADrU77Au2yceLcBDUFX/5yRQId
         IVKXiKtsAIQzNUCSKkyJR4WwIeWhReb8zauf1/j7VDORhR1kxqwbc5jFTUEauVqMhjy8
         FVnhcMs0XZE35WNrvLTY/+US2WxTAt+KTALPT8fjf6ErJRwiizZX5CO75T0eO0hcVKag
         p7egFnG7knicUIa1W7R1QXIGyvy/gxuyi1Ck7Kb6rGvJm1x9yRO3bdPfqWymffbyZYkO
         JAwGhCP9OojzlVh+jhqj29BTeHgFnFZlsA1tjd/haQ5pF6pqaF+Q+d28D7pRssGxz58N
         xqoA==
X-Forwarded-Encrypted: i=1; AJvYcCXCg3IT4zLPj9PVCAlpYJvKnKjcUwZfvz10Dnh+sv57b7PetJWRV0lVT6F/viq/97UFI3kWCMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpiYhjN60v68voVKmnxPY88k9G2F4/9iceGMINgIZ2dwBm339
	VDWEXotBsUaIiCyCHagNxWx8hO3IKMP5dWjf82S73vQjZ1L5tUTw9xhooYFWkWXppBc=
X-Gm-Gg: ASbGnctXyRDvzZlDZwVMRVtS7ClDenY7q36Xt7XiaaXsYROSm1gwW6D11+6NUCfnBe2
	tno7bnM1lZSDgArMWw95BiEyQXHWsU1I02wkIHG+Wu/z2f3SPyb/stU1Ih8KEUhtacy1IUv9FY0
	UfzIHP5waQvPlwN+UG1IU04FpJUmbj7U4peixVktCZO+u1Ld1kns+Md0y5OcQsoRXWRnmUCVefN
	NnIcnTwt593gwgsxJno5rbm5Y0R6xKM40cUnStPAp8MnFT9nj2REvuHgl0OsRcZHmPwfSEr9IiE
	q/PEv5a11GuMephVd43vScPscdMWNuVxwOej6Sy9QjKxEYUgPVBvBx4G61YJn4Q6PzhkYIT6/Ts
	mjxiwq690ddvvVajAXOC6N3T5i1rU0xv7ymrE/JmD2PNgpR45OoWbWbVaWuE7eQIckjSbJZuGKz
	kQD6GOOXD8ehCr/uuSxj7VPKrKgCEV
X-Google-Smtp-Source: AGHT+IGEqLdM2C1BN2NDHEbms/8SX7mak2n+saPOfiLXotnF1OBnVQ6BvXsjs9oX8v5tfy3LZqxEkQ==
X-Received: by 2002:a05:6830:2705:b0:7b3:5908:34d8 with SMTP id 46e09a7af769-7c524066962mr5183898a34.11.1761500076706;
        Sun, 26 Oct 2025 10:34:36 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:9::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c530221d90sm1526800a34.33.2025.10.26.10.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 10:34:36 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v3 0/3] io_uring zcrx ifq sharing
Date: Sun, 26 Oct 2025 10:34:31 -0700
Message-ID: <20251026173434.3669748-1-dw@davidwei.uk>
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

v3:
- drop ifq->proxy
- use dec_and_test to clean up ifq

v2:
- split patch

David Wei (3):
  io_uring/rsrc: rename and export io_lock_two_rings()
  io_uring/zcrx: add refcount to struct io_zcrx_ifq
  io_uring/zcrx: share an ifq between rings

 include/uapi/linux/io_uring.h |  4 ++
 io_uring/rsrc.c               |  4 +-
 io_uring/rsrc.h               |  1 +
 io_uring/zcrx.c               | 92 +++++++++++++++++++++++++++++++++--
 io_uring/zcrx.h               |  2 +
 5 files changed, 97 insertions(+), 6 deletions(-)

-- 
2.47.3


