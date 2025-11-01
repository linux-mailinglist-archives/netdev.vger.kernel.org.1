Return-Path: <netdev+bounces-234814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DC7C275EF
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 03:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 803A14E10F7
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 02:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D49256C6F;
	Sat,  1 Nov 2025 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="vFfB196g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785B253951
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761963893; cv=none; b=j6mZLt7CqTwe7qC8vlNolnrcUrHFhW/hEnPwFy0du86z2fyWSxTjcsPIiQLmSxJGyTdLBoZtQe4tjG8XvwskBeBQjieo9zW6IqUgx2VwnP6WZ8sLqlejwxz9xC7dwsUo3M79AbBZbDQ0hXHuTzxEGqKUgIVwVf6rHE5EEYDeKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761963893; c=relaxed/simple;
	bh=NBZnhJ2GP7HkNNHFloMfetk5aQHVsDkeThTdbTWtzaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WbedeL6lqFFTWD50Z+RhVe9vRazk0D55RBIMWLH3gZP3jG78Klwu0VMneM33hRnd78v70Lqg0dsUXTzs73Zl+zTzVzlGtXXP78+l60sMFi6xRj+dLmc66sI13d/vku//hSVVzSkZo+2/17hXwUsxBsHUp7el56ail19PKM3EWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=vFfB196g; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6567542a9e2so813221eaf.0
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 19:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761963891; x=1762568691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b0WZ0HvdkIjF9lJGgLW+KMUx5KiccKl90tsHcxRJ6Bo=;
        b=vFfB196g1xmA9wbR/Qw4T9FC7j/vFatsWjwPUNoiwWJY0FOq72d+XodT4pLKJSD8LT
         1QwXFgSSNxSGX3/YUqtW85zo0nn0oWBYB6XLvfgJlyC8kVMbYlahHYorey5UN0fEuFLq
         tqnZMb6ovapcxAMM/grDnTHzEkV2Ftvjk0oJdP67yq2X1uenDxgf+2jB2SOSXVsO9isB
         Xs7oPFWbqstAPixsS/BQKYauDp0V1vXvUd9xJUQFSBmEiREviikX8v4WsncXE4pK1ZXR
         ImoV0QGbs0rfzmEuR1Gop4lj95UM1khq0iSfnNRx4uINGijDh7KBygogUZGPEL+UlGv0
         FD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761963891; x=1762568691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0WZ0HvdkIjF9lJGgLW+KMUx5KiccKl90tsHcxRJ6Bo=;
        b=uzVv3CzCpUNQ5HXJ+xTfXv/pNjwFodIEmUNzCEjyYpPXHFtF4J0o+yd2cZ/t1DK2AT
         HmkfEIGLAok5ub5z1o18FTo3sgw9fenYxUOvsCf4bAmoMdtbtkh/UIFD1rvF4TNEYo1N
         IpFUL75ZarFC2ubAILfNraLSJfU15FvRneWLuCWQwnfZ3za9Bv4DylfL5iF7+8OF+i01
         QePIIiropfCNcNyK7f2vqTIEaeCxZwYaxjOWtp2nTQYbzawyre1kfFFVxX26gP9GqyWN
         FeE1QDrkUF4gwxHmbkFqY1Fb7obtuv98aiTAKSbt03azcFdbk1VCw4ZLANPK76YYFL5q
         BNug==
X-Forwarded-Encrypted: i=1; AJvYcCWOf382R71ASw7yI8d/nqNq9TmftU97dXygGyXSC1IrnIDMuNPX2YLFVt4o4w2fXZUDlfxKcCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQc6Ch07qdJy7k2J/ct5WEOgP4VBpJ+xnQKzS4acleDVcDH2WA
	G8LYPCCwE2c/O9GOt1IZOUJGYIoBZnikjHvv+aXHHGq98qAtuhi1c5Lbsb1XOumI9Wo=
X-Gm-Gg: ASbGncvmRoXeu4jb+tomtJ1d413r1r4I5jlOw4l8l6/s4dc+ThIWxisk2BXRXeln0gx
	8CQcjB+kHfuHJNfQQr0N7MXreYMaO7tB8xYmYjeM6bNNoSeAcWz+sbrP26Dr+n3y7dFjbrWVTrH
	OobW5hbfvlujaQQYuFZLOpJC4RYb7FxMmkMgFpIjQSuaKQ+2VjaeKMU86gVSfE5IC8c2qFGBNUt
	reesqFyLYLKiWyRWK9doL4MOV8VAx0WHIiw6gwkf15cJezZIGFyVzChAGDOtzol6FU4iJ9lZhe2
	HaETSr/4arcPnDkdc7Gd5S6BQx6QzYDWOZ/96UtPxLs2AEYeSM6L35Emt31O6FX47HCCTkF4DFV
	F+CfnuebtoGfy7KebXCZbwoWe+6tCHWwgTkKCKmlXkI+kMrJVeHazlMUSIvU7oLV0gLNcvvBsqq
	8H9b0vLjnmMHnfj/50gzUWXOIV03BOepxQ6jzu6Bo=
X-Google-Smtp-Source: AGHT+IGKuQs91jURGBXCKfpgU7GTzcduqh/upM1JP9+LrD4jKnsiLOQi1ib+newWIzWGAfcSlv+TNg==
X-Received: by 2002:a4a:ee1a:0:b0:653:6c32:6fe9 with SMTP id 006d021491bc7-6568a6cf232mr2505988eaf.2.1761963891311;
        Fri, 31 Oct 2025 19:24:51 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:5::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6568cf1fba9sm868232eaf.7.2025.10.31.19.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 19:24:50 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v3 0/2] net: io_uring/zcrx: call netdev_queue_get_dma_dev() under instance lock
Date: Fri, 31 Oct 2025 19:24:47 -0700
Message-ID: <20251101022449.1112313-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev ops must be called under instance lock or rtnl_lock, but
io_register_zcrx_ifq() isn't doing this for netdev_queue_get_dma_dev().
Fix this by taking the instance lock using netdev_get_by_index_lock().

netdev_get_by_index_lock() isn't available outside net/ by default, so
the first patch is a prep patch to export this under linux/netdevice.h.

Extended the instance lock section to include attaching a memory
provider. Could not move io_zcrx_create_area() outside, since the dmabuf
codepath IORING_ZCRX_AREA_DMABUF requires ifq->dev.

The netdev instance lock is taken first, followed by holding a ref. On
err, this is freed in LIFO order: put ref then unlock. After
successfully opening the mp on an rxq, the instance lock is unlocked and
ifq->if_rxq is set to a valid value. If there are future errs,
io_zcrx_ifq_free() will put the ref.

v3:
 - do not export netdev_get_by_index_lock()
 - fix netdev lock/ref cleanup

v2:
 - add Fixes tag
 - export netdev_get_by_index_lock()
 - use netdev_get_by_index_lock() + netdev_hold()
 - extend lock section to include net_mp_open_rxq()

David Wei (2):
  net: export netdev_get_by_index_lock()
  net: io_uring/zcrx: call netdev_queue_get_dma_dev() under instance
    lock

 include/linux/netdevice.h |  1 +
 io_uring/zcrx.c           | 16 ++++++++++------
 net/core/dev.h            |  1 -
 3 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.47.3


