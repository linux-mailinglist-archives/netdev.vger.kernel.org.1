Return-Path: <netdev+bounces-183691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB895A918F7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B4B17F5AF
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E59235375;
	Thu, 17 Apr 2025 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HNPkFUci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AD230BF3
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884854; cv=none; b=Tw0GVQ+CodK23fXyyhyBFdJIXU5NKw4jC9+hRcc4QiRs5nQJDTZaJoNZglyeX4W4IxlHG8q2O83FB3vR7Vr8RyHPkdNaWX783ZF7El8ZaGQdn7sZq9jrSryJL8/MzYr6cqtauMjFah98+qvQIkjvrBWuLfJWkz/f6rCKUSCvURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884854; c=relaxed/simple;
	bh=KmdhX4NyNAkbogqxNJjMp5/2YzbGRzLXKhNQmupDvnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9HI4cu02Q/wwVSP8yfgR9pD2SOekvQBJ/PUaTrHPl/eA6OFLVxe/qsmghunwaQBHoA6xf2ceKOTa4pVpY2VP1RlkVd/omvzbW+AiymhU8/ci/hQuGxMhA1z36B5QYOST4h6/lrMIxHy+8IF4fvCluXXBRAet7cb/jADB2lxrro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HNPkFUci; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39ac56756f6so630271f8f.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 03:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744884851; x=1745489651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vH8Y6neutxbjmnuuQx3QFfzMHWNkWiM8LoFiRQ549q0=;
        b=HNPkFUci0zOJ9Z/iep/2FEIRhHPmmGORXxsqUc+hwYJxR4CLPHceC8F3yq/FeO7wbP
         nyEQMv48kbpvHikwCfDaLeXE+T+HSNJc3j38CXRwco8sD91KKee00K5v1sJLfpdQ5RmK
         nZuvFxkT/gWv4e3Nxn8YPzkBAfg0no2DD2Eh7FHodF6VkDd6GIzosqyrxhBJTs5CYG9N
         HQ4eepSsmQjOB9NSBprMyMiafisZDYQ8UwNfNyIiocLiJTFUUdt+NDy/jpSkQ2hQUhba
         USZDPCwc6Zm5u/D5ggy+Rz54BmkNgl/BY7fV7eg2HJ9Dz+Q2NCHwaohoYj3tO2Kw+diX
         DGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744884851; x=1745489651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vH8Y6neutxbjmnuuQx3QFfzMHWNkWiM8LoFiRQ549q0=;
        b=tw4zmIA2uLcBVuMXs6JB7E/VdjPlPIAGiQuTM68CyVH9ToXThGdll30Uki6XL32qvn
         XK6eu2fDQ8M4Fp/AwAto9XCFlNPUMFSbRhnEfoebUUuYG4sz3zSPV0D+DM/yUcGLrBmQ
         z4QHye7qLs6CxvEHu60nJYToVdiBh4pntZlK3usYNglFa3keug6vlnY2gz1NdOMECmTd
         Ewp32Q/MnERoh+ji6gnJP7LfLExKqmHrG7q+Z8uaDdCUBo+L7OECGElVQu6YfM9eMqAH
         EQ8FWJX0Gjy5gv7sSKB/zc0L8wKWT+hRwzmfjOt3Z6IqKd5UGbQrpWYGN1otQNw0a9M/
         9R2g==
X-Gm-Message-State: AOJu0YzE4nJHiZxeWpvfs7hu0NBL6mYfhzJldkn5f+HA17gWZFGm70Gw
	UdZ1xBcyd0ytLK85oIR+MPCeo5S3GBa03/ze+Y/CxjU+W1NNVMCXQuJZfksvQGRSu0M265xVXhM
	x
X-Gm-Gg: ASbGncvFIWbZ3mfH9yVLmGwzBXjvqhVwMNRVq+dagKnPWByIo8IppGmjVw9mcppl53C
	HjbEGaIkqNzq+/x6jcefZl/eiM102utSueO1AL1sxQSbBAel4huFIqtSmnjk/V/oJ+s3jX2Npo3
	kgvhs5HRZqGt8uuBlhBKaQ3ZiDyFTa+NogzDp2w4aZwkc2taEMX+Bv6Jvw6EsUld7kMY2hT90fC
	Ay19irY+ySzD8lcTbeQfCpOG1fUK4rAPMMwn7GiFwmR32VUHc5zfec2jMR89mvkUT/Dpopqla8z
	v1p6vHFj3anUUl6YfiNkBBPwnPUP1jfs9wNrje95Zuv9
X-Google-Smtp-Source: AGHT+IGUGV2qLUKcyc/MKWOBJCSKf6rWLfOhMtWglTKLH+xMtjyH2I9j2U9Ek+e0VoWdHhFzJuNe/A==
X-Received: by 2002:a05:6000:381:b0:391:3049:d58d with SMTP id ffacd0b85a97d-39ee5add5e3mr4366159f8f.0.1744884850679;
        Thu, 17 Apr 2025 03:14:10 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae97751fsm19431032f8f.41.2025.04.17.03.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 03:14:10 -0700 (PDT)
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
	parav@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: [PATCH net-next v3 0/3] net/mlx5: Expose additional devlink dev info
Date: Wed, 16 Apr 2025 23:41:30 +0200
Message-ID: <20250416214133.10582-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.49.0
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

---
v2->v3:
- patch#1 from v2 was separatelly accepted
- patch#1:
  - do not continue in case devlink_info_*serial_number_put() returns
    error
- patch#2:
  - extended patch description
  - extended documentation
- patch#3:
  - do not continue in case devlink_info_function_uid_put() returns error
v1->v2:
- patch#2:
  - fixed possibly uninitialized variable "err"

Jiri Pirko (3):
  net/mlx5: Expose serial numbers in devlink info
  devlink: add function unique identifier to devlink dev info
  net/mlx5: Expose function UID in devlink info

 Documentation/netlink/specs/devlink.yaml      |  4 ++
 .../networking/devlink/devlink-info.rst       | 20 ++++++
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 68 +++++++++++++++++++
 include/net/devlink.h                         |  2 +
 include/uapi/linux/devlink.h                  |  2 +
 net/devlink/dev.c                             |  9 +++
 6 files changed, 105 insertions(+)

-- 
2.49.0


