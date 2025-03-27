Return-Path: <netdev+bounces-177929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A670A73088
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7612D7A2848
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F512135B3;
	Thu, 27 Mar 2025 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ADy8dPFr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8488B1F94A
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743075987; cv=none; b=o1m2bvne/ls9te5U3ZSPzObKNgM9CoHwE3tzk4t1+czrrFX+IAONsTCrdkKVJQN7dlTZvnRjqZeTL+Qghw3gyzyqpBKmlppXVpSdVQWL0bn2lN0M6YlqS2NRrysIH+RKdD+85suyMEJwInZ7WsPIF5o5+26HENsgdVNVeRaGTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743075987; c=relaxed/simple;
	bh=hpvyUgBhzqTOUywJzqlejQbJQ0es2g9y1qxZu3W6SmM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Zczrn29Ly4pSPfDEQDvU+dQShdOK+rks8uNc4JTzDUpVQ1IN+/0MuiqX4+wulVlWj0sT9MEqOwmPe7yxBlSO3uvGZybS9DG2xv5eiAjuXhhhh3Qj00WjmVPil9r3Hy6MLj1jaC/f4OPeUdLv62w9BbtYgLYa0tSucgUrCn9sq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ADy8dPFr; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-477296dce76so7851331cf.3
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743075983; x=1743680783; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VV/lBRiSuJDDrhxoZz5K4+E8i3rHnAJVh06dsi9WOn4=;
        b=ADy8dPFrFg6gpD6vC31VdM0pd40BpERAO6dCMnCUM9OS0XmI5qFTt19k8byJ/n94QE
         H2PUoehKCUP5958QT0oK12cQyIbCzENWSSwvSqT3Hsb/wi1azUs2FtABgy/vz93BWh9y
         wYUEZ2jp4wyYWfmtjgJLL8gAYiajpWeq3DTzKpSN/aZqoq1w8s5Rx4tpZkrMJinJLyHc
         F60pStHQIl8ZQngAFzOf7bfDJuU//BRjbujhH0pgRtrrSZjXM6nemnPyrs6iYyQaZGw5
         Zget3FEd9eI9ZiHlxKUHub10H8QDQYOVRZhRIsu6pD/fN9SU63Xbc5YnXRiIh8I2J0Sl
         tRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743075983; x=1743680783;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VV/lBRiSuJDDrhxoZz5K4+E8i3rHnAJVh06dsi9WOn4=;
        b=ahsm3FixPW8E7Vca0VtCW6U8G3eFnJCOmOpFdwcvvx5Y0QfBzbGt+eZzQxcpc3YZe7
         bXs1vVrVl0tu4eazsEW0aPRzUg5OnC4XYnWdVauBGCu+/jYVVsIT6zp0B12Wr2Jj+gTc
         JgiI4+T3m03v8C+UO1JOq2fIlbooessIez060OIqdMWZ5PuJXqS20E61uYjuLzWC/Yxb
         N2SSu63T+ijvpXnXx0PyIeqfrH3w+7DkzFY4UssYl0ByBRebZZWMrwncrr5+XsDN4RQx
         QDzV4C9dTSXdHo1i1fMVkalbXGTPI3cGAdGydURxHfVCEbrCymNyDsr0B0ZeaSmaGynw
         6QaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsdkTNe8p6/hSjFphMj5w00W6sfb/J6iKzclYa3LvQjQsCpO29yJyPOtFYz0vdYrGZlZtWmjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsuhPRcr90u9TRm9dvzwkb4tj1bsXHcNs8COqgbIdUwPe1w9Jo
	vl+8VEmfC0REVpO1TG3EQqoviE4n5wU7czmBf11pjRWRjeWuOaA68WzIztv+Lx0=
X-Gm-Gg: ASbGncvszWqjVwqjzwT5LE8JMsNdAWHYyxVWmwGS+mPCFyBHZ2L3A5Jf4jnK9PjY7hA
	mQQRJqPNiFa6gDBUw9A0dQRaZTmBZSw2DHAT1KTGOjHMrHaPRui6sBrQgxHY9n+rp9PqAJrZb3I
	z25Nk0wDlYqWW9s1ES2bWQyHkJrI9/54fwQbS0cI2RfUbKz3UjkM+wdJ4bNDPH8twbhO0He2qlE
	ZqDL+95cXVofbNznXD5LgXa8Ht1f0V5PSgOH6QV6aWOcZl2enqWo9GhSRR3jiuDp+0vZ6/0MYUH
	M/u/C7ua2SLxXg4qwkRQHTp7ux4Gd/c/YKRmwes=
X-Google-Smtp-Source: AGHT+IHc2yF+/jxv9d883lF9NXm2a0WWkE0XTbm46r8SpF+OzAfPLrXG2P1pfwr8dqUGArJ5p2lPSQ==
X-Received: by 2002:a05:622a:114d:b0:476:b7e2:385e with SMTP id d75a77b69052e-4776e0a060dmr53363571cf.17.1743075983086;
        Thu, 27 Mar 2025 04:46:23 -0700 (PDT)
Received: from [172.20.6.96] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d18f6a3sm83645371cf.38.2025.03.27.04.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 04:46:22 -0700 (PDT)
Message-ID: <12e0af8c-8417-41d5-9d47-408556b50322@kernel.dk>
Date: Thu, 27 Mar 2025 05:46:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: io-uring <io-uring@vger.kernel.org>, netdev <netdev@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring network zero-copy receive support
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

This pull request adds support for zero-copy receive with io_uring,
enabling fast bulk receive of data directly into application memory,
rather than needing to copy the data out of kernel memory. While this
version only supports host memory as that was the initial target, other
memory types are planned as well, with notably GPU memory coming next.

This work depends on some networking components which were queued up on
the networking side, but have now landed in your tree.

This is the work of Pavel Begunkov and David Wei. From the v14 posting:

"We configure a page pool that a driver uses to fill a hw rx queue to
 hand out user pages instead of kernel pages. Any data that ends up
 hitting this hw rx queue will thus be dma'd into userspace memory
 directly, without needing to be bounced through kernel memory. 'Reading'
 data out of a socket instead becomes a _notification_ mechanism, where
 the kernel tells userspace where the data is. The overall approach is
 similar to the devmem TCP proposal.

 This relies on hw header/data split, flow steering and RSS to ensure
 packet headers remain in kernel memory and only desired flows hit a hw
 rx queue configured for zero copy. Configuring this is outside of the
 scope of this patchset.

 We share netdev core infra with devmem TCP. The main difference is that
 io_uring is used for the uAPI and the lifetime of all objects are bound
 to an io_uring instance. Data is 'read' using a new io_uring request
 type. When done, data is returned via a new shared refill queue. A zero
 copy page pool refills a hw rx queue from this refill queue directly. Of
 course, the lifetime of these data buffers are managed by io_uring
 rather than the networking stack, with different refcounting rules.

 This patchset is the first step adding basic zero copy support. We will
 extend this iteratively with new features e.g. dynamically allocated
 zero copy areas, THP support, dmabuf support, improved copy fallback,
 general optimisations and more."

In a local setup, I was able to saturate a 200G link with a single CPU
core, and at netdev conf 0x19 earlier this month, Jamal reported 188Gbit
of bandwidth using a single core (no HT, including soft-irq). Safe to
say the efficiency is there, as bigger links would be needed to find the
per-core limit, and it's considerably more efficient and faster than the
existing devmem solution.

Please pull!


The following changes since commit 5c496ff11df179c32db960cf10af90a624a035eb:

  Merge commit '71f0dd5a3293d75d26d405ffbaedfdda4836af32' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next into for-6.15/io_uring-rx-zc (2025-02-17 05:38:28 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git for-6.15/io_uring-rx-zc-20250325

for you to fetch changes up to 89baa22d75278b69d3a30f86c3f47ac3a3a659e9:

  io_uring/zcrx: add selftest case for recvzc with read limit (2025-02-24 12:56:13 -0700)

----------------------------------------------------------------
Bui Quang Minh (1):
      io_uring: add missing IORING_MAP_OFF_ZCRX_REGION in io_uring_mmap

David Wei (8):
      io_uring/zcrx: add interface queue and refill queue
      io_uring/zcrx: add io_zcrx_area
      io_uring/zcrx: add io_recvzc request
      io_uring/zcrx: set pp memory provider for an rx queue
      net: add documentation for io_uring zcrx
      io_uring/zcrx: add selftest
      io_uring/zcrx: add a read limit to recvzc requests
      io_uring/zcrx: add selftest case for recvzc with read limit

Geert Uytterhoeven (1):
      io_uring: Rename KConfig to Kconfig

Jens Axboe (1):
      Merge commit '71f0dd5a3293d75d26d405ffbaedfdda4836af32' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next into for-6.15/io_uring-rx-zc

Pavel Begunkov (7):
      io_uring/zcrx: grab a net device
      io_uring/zcrx: implement zerocopy receive pp memory provider
      io_uring/zcrx: dma-map area for the device
      io_uring/zcrx: throttle receive requests
      io_uring/zcrx: add copy fallback
      io_uring/zcrx: recheck ifq on shutdown
      io_uring/zcrx: fix leaks on failed registration

 Documentation/networking/index.rst                 |   1 +
 Documentation/networking/iou-zcrx.rst              | 202 +++++
 Kconfig                                            |   2 +
 include/linux/io_uring_types.h                     |   6 +
 include/uapi/linux/io_uring.h                      |  54 +-
 io_uring/Kconfig                                   |  10 +
 io_uring/Makefile                                  |   1 +
 io_uring/io_uring.c                                |   7 +
 io_uring/io_uring.h                                |  10 +
 io_uring/memmap.c                                  |   2 +
 io_uring/memmap.h                                  |   1 +
 io_uring/net.c                                     |  84 ++
 io_uring/opdef.c                                   |  16 +
 io_uring/register.c                                |   7 +
 io_uring/rsrc.c                                    |   2 +-
 io_uring/rsrc.h                                    |   1 +
 io_uring/zcrx.c                                    | 960 +++++++++++++++++++++
 io_uring/zcrx.h                                    |  73 ++
 tools/testing/selftests/drivers/net/hw/.gitignore  |   2 +
 tools/testing/selftests/drivers/net/hw/Makefile    |   5 +
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c  | 457 ++++++++++
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py |  87 ++
 22 files changed, 1988 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/networking/iou-zcrx.rst
 create mode 100644 io_uring/Kconfig
 create mode 100644 io_uring/zcrx.c
 create mode 100644 io_uring/zcrx.h
 create mode 100644 tools/testing/selftests/drivers/net/hw/iou-zcrx.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/iou-zcrx.py

-- 
Jens Axboe


