Return-Path: <netdev+bounces-151539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6699EFF42
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01A5287E49
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ABC1DE3D5;
	Thu, 12 Dec 2024 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="yWSWZpsd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961BA1DE2C0
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042361; cv=none; b=EifkuNA+508TPWK6AIQpqmoTNHo6Yhfp6ffe2sV9n+T0fiHDby8aqAfJmElVOJA6VPPFBtYKkFI6DDfDgIHVPPY2i4qBSK4l0YuuNnqS+PraSn7RJXBVUZXCU7G7lcf322RlDD+JCvdNhvc69oPXwelB91LbUreccj4DGgdEfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042361; c=relaxed/simple;
	bh=Qzruh7IrzM9gCJjhlg2Cf1xdTc3VmRZZwoOUkD2sGl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aHgkKm5djo3qQL1hA9RectEwg8EKtDvQHiqjJi1JV2XMnCKdG+OMYSCDmsOrlrbmG4bjxnMl1iiCnbzwO4X8svk94WhGGhBySktKiQjELBlTE9wAlVwuIKuzXpCvVE5poH3Yet7TXsQoPSEl3mA2AEUcnMMHyXAwiIrP8WYSpuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=yWSWZpsd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee74291415so762084a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1734042359; x=1734647159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CDNYW2QZaIHPzfvfTOwvaiBmTla5Kl13HW9JTv8u3Ho=;
        b=yWSWZpsdVWDSVBqMZwR5UavFnotfhW0JQL57ZwszLbzJnGLO6KQqIuWBJAbBP7WBBS
         48cwkKNx+nW1k+tlqIq1M6ttHKDleHJ5YgeDc3kL/wE6eHxlKV7U7/z32/rP2jqPJTAd
         jXs2zgCMRg5QrJK2WArsku8/A13Z/8BRyUWWnepuk6gYXoGbZ8wHNn5hMVSUsmNtm965
         Z1bXPlT3P5fa4+O2rdO8UHw6UF+UQAfeX2SIJiF37kUnmaaXeW2vSqBoLXd0Rf08pfxH
         9Fc2RYg3K1OVud9RhnLACw8Z/rjxCD2w6FEVop+jC48sUdBYrtwbSkg8G9DjgkMyXGRo
         g57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042359; x=1734647159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDNYW2QZaIHPzfvfTOwvaiBmTla5Kl13HW9JTv8u3Ho=;
        b=pqPX5Rl8wtNwNB31mFvFc/9N9XoCbJ1xoJQRS5BCyi2XPbymVkG0tLxL0WTc1GUnS2
         q3qtFngQ+QNkWMLSUeO3wdxQvHNzyBFdAlW4DJ7XEx2kmpWPwPTr7LA3W3jyz9Yr5ghb
         l/ek1kjFIXm+cE70vSc0uPW5HIKzeCEnYOwaQ3ruCXL09EAO5XaIT5LhdUMkMSWHr/Ao
         PNA3SZaijMMf/xnCCKyOf9Fdo2uhCR/nGIrlaNzilMHUWK+CSf9teLKamXKg5cwbxku7
         jIjDZVOHSoPII8eD+0X/nsBgWeQhafSP26wypqVWk+cP8+++AitZIywqgHAjUkgcxoB9
         m6Ew==
X-Gm-Message-State: AOJu0Yygyryu7O3WsNVYWVqcBIc4ETa2ArGmQw/FYn7XKWjRxndLSKYe
	ePx7YkbB+cXE3zJQnR8Zi0aoqWGz86grgjGzXEpJZVahnoft3wMTOsjIV+lWFGjmsrfBscXFzlq
	4
X-Gm-Gg: ASbGncsA1dFiTuLpGdPs7iBdmgEdvx1dlp3xZHEx6FMUJInvXiZsBty4p2a7e33c8CX
	77DX3gKEZEuDpWpuARdAm3vIkL4W+Wf8CoPUOpgXIoNN2IBZFEvlTAcqDAaQe7bmD0Trls9/kF2
	aIS5TPmrYzGbrygBNQH15/4T3WIUOsFQ/gvJkIhcRory+srK+2KN/37mdq213yCT8sIuREXcMMm
	G3bpE8zDNixNNbygqNvgUIOtdn9fBf3/+j9EjPvnYTkM9wX1AExUY3iVnz0cRTFt1MX6HBHdsd8
	X+rq5czE0Q5sr9MiyN5TThD4h4Kbi2CdPA==
X-Google-Smtp-Source: AGHT+IE6pRAw2oLSRcS+aEmAxKOnxIrp1RQJv3bRehu2Zey3gnMSannMkEPSYoT1sMrQuJKmPt54BQ==
X-Received: by 2002:a17:90b:28c8:b0:2ee:6e22:bfd0 with SMTP id 98e67ed59e1d1-2f28fd727cdmr547234a91.21.1734042358792;
        Thu, 12 Dec 2024 14:25:58 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm1830071a91.12.2024.12.12.14.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:25:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 0/6] include file changes for musl libc
Date: Thu, 12 Dec 2024 14:24:25 -0800
Message-ID: <20241212222549.43749-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a set of patches to address some of the include file
issues identified by building on a musl libc based system (Alpine).

Stephen Hemminger (6):
  libnetlink: add missing endian.h
  rdma: add missing header for basename
  ip: rearrange and prune header files
  cg_map: use limits.h
  flower: replace XATTR_SIZE_MAX
  uapi: remove no longer used linux/limits.h

 include/libnetlink.h        |  1 +
 include/uapi/linux/limits.h | 21 ---------------------
 ip/iplink.c                 | 13 +++++--------
 ip/ipnetns.c                | 19 +++++++++----------
 lib/cg_map.c                |  3 ++-
 rdma/rdma.h                 |  3 ++-
 tc/f_flower.c               | 37 ++++++++++++++++++++-----------------
 7 files changed, 39 insertions(+), 58 deletions(-)
 delete mode 100644 include/uapi/linux/limits.h

-- 
2.45.2


