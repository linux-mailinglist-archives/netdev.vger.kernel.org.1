Return-Path: <netdev+bounces-175799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC6CA6780C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FA2188B31B
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52317A30D;
	Tue, 18 Mar 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1sFfj+tS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677D20E333
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312195; cv=none; b=IEE6SxjVX96ACbp6XSP5CsqGraJaNXz7Pn8mkmhNpXt+qCjcYZ1PESPNSFwkE3fPbBFQ0gLc246YWQwzAZscJlGrBo2mJrwcfezuT46cGFl5x/YXi7LdGbOOCgT2okVaQ18ZSMhjVRqT9U6YQqOvIjIC8QKE1iWGujQ1S36yBP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312195; c=relaxed/simple;
	bh=c0GfpY34SerzYckqCnK50cpckfKuGiwAC1p2R/P9T/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwyacgNDqJiy+IzbRbizPIWJQ2pCEztcp4w3UVMs1UwW6zpXUjfeXm1FxB15sQ+dgcZgnB81p8EGPqwKnXhrVw4PV4YBaOT5TBnLXbULQAmwkCKVD6tfxwu53pkPnpWiUniKvyX8n5CweJk376ZAHFupiowNsqVMG4rDSpmQ4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1sFfj+tS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso26439935e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742312191; x=1742916991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjxeQqNvUz3OAMLVjVwur7a7aHj79kadNmROEZ2qm+c=;
        b=1sFfj+tSc5jiy19F4rDVl0ESA5AxHx4dKtOj9+velZSwSClTWeccWiRhZBF+PCdStm
         yxQNj+D3b3qwwd9JPfJdEaUmLkm7j4jNG2zW/khoK7h9xYUyqENHzSQPp15kJJDv+z9W
         U6k4fT8koOZ1izRqHMY6Nsf2XYqTlC4CexIPRbtXkDjnci/RXNdJUxX49/+U5iXH3NlG
         AAdVhyQhD1rHBt8cjI55FatAsPBgK11E06ykMmvUyEJFChURf1ozzHKGsmsHznUKJfNs
         aQ5w/ZfEJThpzBeyIPbh3juRgixnqU/JpW5mCMnBZh9HgOwYE4gHXg+3eBr5H7NEcpFs
         T1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312191; x=1742916991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjxeQqNvUz3OAMLVjVwur7a7aHj79kadNmROEZ2qm+c=;
        b=tBaPxiqyYdwFb4uRARKYvB7wXe/A1CWsBYhbEdCgocP7UAc1i0v6gw3mBRPqouqHn9
         Wck3KtbwbfRrB9o+0zIH5xikIGw60jfXdovqYFz8Nz9QEdEgiM8d0vEJ0+/UwBFDWsPs
         uDiciQe52sAbfLaCRctvl9R9OgYy0mExDfbkhU1Zn5idlQju4yzt/JHWxyICoepC5AFA
         1fNtAGDF4qd6QFYQ+x7oKUyOogYIc7JhH9qYMmMsScuw2N56O9tnf4xlMHESvQIwFpir
         vH5733sSkMJp6QjHNAhuTVl0xtIMNAhLteYdsHt8uX+a5xzQ13DUOTiAvLm0xyRxxWaV
         zGNg==
X-Gm-Message-State: AOJu0YxZlUwYJVCY5h9EcZahun4ip4ccayUXOXqKmrCEK3USoUBrrFSy
	JB3sWnzXzUXJn1nOygEIYlxo/8F9mRODIGPjTibvQxttAwjmN75h3AE083CtsmWLrbKtrbvuFy0
	2
X-Gm-Gg: ASbGnct4Slo0Y9z+xoLs0elPoMmjqVryXTBpSnh9WvhS3nqtNhG/VPK77Bzrjc6B6aF
	Zy1+liBebLKXKEdBT1sJeRZq19swXyA8j7Mnh1jt0H7lLEEs/tidwvhUP8tugkzIjoaBgEECZHl
	NFCao6SJZ01POz60sDZWkfBenunEgfWUk/hz5zIQgIkUivqwmfb7QGI+dW2LS5Jh5K5C230oj6k
	2i7Z1P5+TUwOQeufZ9uZUvO0PXvSXkuIFK27WrVczdDTONSB4WhB69soW2xP6VFqrmqlI7xTMEe
	S9ymw2LNON7OFOX4UdZ3sJ5IxTf9LF3Bs/0Prg==
X-Google-Smtp-Source: AGHT+IEOfbE3ER4vOVrbkAE+m+TRaJamKqBWJGSzHLvvrnqpmxx6/iPY2P3BjfmPDT43Kv0wtZUcyQ==
X-Received: by 2002:a05:600c:310e:b0:43c:fc04:6d48 with SMTP id 5b1f17b1804b1-43d3b7c9a0fmr31279315e9.0.1742312190963;
        Tue, 18 Mar 2025 08:36:30 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60965sm138325085e9.25.2025.03.18.08.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:36:30 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	parav@nvidia.com
Subject: [PATCH net-next 0/4] net/mlx5: Expose additional devlink dev info
Date: Tue, 18 Mar 2025 16:36:23 +0100
Message-ID: <20250318153627.95030-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

This patchset aims to expose couple of already defined serial numbers
for mlx5 driver.

On top of that, it introduces new field, "function.uid" and exposes
that for mlx5 driver.

Example:

$ devlink dev info
pci/0000:08:00.0:
  driver mlx5_core
  serial_number e4397f872caeed218000846daa7d2f49
  board.serial_number MT2314XZ00YA
  function.uid MT2314XZ00YAMLNXS0D0F0
  versions:
      fixed:
        fw.psid MT_0000000894
      running:
        fw.version 28.41.1000
        fw 28.41.1000
      stored:
        fw.version 28.41.1000
        fw 28.41.1000
auxiliary/mlx5_core.eth.0:
  driver mlx5_core.eth
pci/0000:08:00.1:
  driver mlx5_core
  serial_number e4397f872caeed218000846daa7d2f49
  board.serial_number MT2314XZ00YA
  function.uid MT2314XZ00YAMLNXS0D0F1
  versions:
      fixed:
        fw.psid MT_0000000894
      running:
        fw.version 28.41.1000
        fw 28.41.1000
      stored:
        fw.version 28.41.1000
        fw 28.41.1000
auxiliary/mlx5_core.eth.1:
  driver mlx5_core.eth

The first patch just adds a small missing bit in devlink ynl spec.

Jiri Pirko (4):
  ynl: devlink: add missing board-serial-number
  net/mlx5: Expose serial numbers in devlink info
  devlink: add function unique identifier to devlink dev info
  net/mlx5: Expose function UID in devlink info

 Documentation/netlink/specs/devlink.yaml      |  5 ++
 .../networking/devlink/devlink-info.rst       |  5 ++
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 62 +++++++++++++++++++
 include/net/devlink.h                         |  2 +
 include/uapi/linux/devlink.h                  |  2 +
 net/devlink/dev.c                             |  9 +++
 6 files changed, 85 insertions(+)

-- 
2.48.1


