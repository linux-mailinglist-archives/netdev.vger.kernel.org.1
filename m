Return-Path: <netdev+bounces-176426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEF0A6A3B4
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B773B8BD6
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5655F214A81;
	Thu, 20 Mar 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1j3by7nB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B4633E1
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466703; cv=none; b=UcLvbBU/SAc88qW3MSRd7epSPOqsMco+r9dpT4NGwSxmQeucFuAcHPu3yKf76AA5NycTJPwLPQ/fvtXud3ft9YIQenww4UNxlX05M82P2vS5jmUkN6W4y7m9/Eazs1rirL2/Ytagnre2xxEbjpo4t7Qi0qMWVhfLmVCFTloOdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466703; c=relaxed/simple;
	bh=tw24lmtCJvmoDfJGTUNNsi8jkbJRrTPAy6TP+alwFhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jv5lHEfEOVXCvjUQrIQqfF6NHFaX4ow8g28R2TXDMUhBMEZVav+/UQ2HZ5AgnAMH1pQ/wRiw679xW6FjPpgsF80opgzaCArnnKtcIsnJotr33IQxzLg5bpEfqedIEEnpHe4fkTvksforrliJpDc2kpua0pbKA6ODglcSGnYXHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1j3by7nB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so479348f8f.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 03:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742466699; x=1743071499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYWkQyxFkTsgBwPrH0la+g+GsogD1yd7EFV+X1J0FSU=;
        b=1j3by7nBRx4kycoRxtKCMo7ZibKMeLklz6aFhlM664nYLUHUI/3j6BK9bOvAwne/q+
         3wyXHWueF2m9E57z7gNodmRRY/zd/Eax2j4VYdQ3P7uoaHPmXIBdJlsxQEpBqlOBTxIU
         iSq6B8vU//Ae6Yg5q5iCN1ijSuGJbj5uvUhFKiExycb+EXHz9dEA1nZhz4B6sxrZ12ne
         F2lxdaPTlF/tFbtMV54OqXRmlxqd5WkxcQNEcNoWQoJBlT5p3SMhr8PcO/5mdtVovYV2
         9FGU3wvTmptFIKzHIT1Ina6UI8fLV5O5RIbQfQoVNea/zgD4Cf+Q58EunDtnzLruzjgl
         E+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466699; x=1743071499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYWkQyxFkTsgBwPrH0la+g+GsogD1yd7EFV+X1J0FSU=;
        b=eDdpQu/atnUPPldVsC4bQpUxztN8jCQCva7g+i9AuLEQSNFIv+iZI6q2u4fpusnUy2
         A7idFmPkdK3NlJE7d5TVaqWbIrng2uGWfEIfroJzoIHZzcuMOow2O4MuthtJuRPEqa5w
         Hx90YZImLN7rbAEnTrXaOc08rblunZdzB7AxdMpz2Rh/8KYt9C227P39giT1hlw/6qbc
         JzzBi7ElVF5zgOz2QFVn1e86dzR4X/t8GvgY/kVJJo1TvnVfrrRHR64l5gehCPNK+ZMN
         jTiED62t1Y/XgWOFpR1NV1q3WLZeclffjW/kbcMRjQIRsnS4HIt18bfo9SW0JKZB5eO6
         HZlw==
X-Gm-Message-State: AOJu0Yz3YzkwAedGCuTVNYtPQHhPiq/hUv6UTjZriFVPeR/YnGq9ijXp
	mul30oNZup5tXqQsq0NzzKO4HkQBhVZ3QhywYu9Mor24bsjkOlrZHmJF3k8h0+zpHYoNiEbA1ox
	Q
X-Gm-Gg: ASbGncuY1Gbie/Imv2UJ8PUaPvocACimXjpqNaPbx+Qqt/8lz977QwiC13Srs72ak/T
	xxwU/NDm3jffbF83BxEIs2P659SVMp27iJK517V83zZw/wfGyvQxw2iidEYpe7LOKHyyXcSlaWa
	U7lJelhwBKA+/fHHj8rzu0nekmTlTLNoNyqsGEqupq/7NthK+E6mfeUpq1FOTidxYp3Rt0yoi3i
	RAqEcupEWoCM9rWvsJXf1iUGv0D2qLAq85TXmidrasYi/2LU1HUADTzfXrJ5u1FLAEj+ggTMhuX
	TIGui34QcFQeTIJh1R1h764ZX8MSdMnui9xctHNbvf4PTD3h
X-Google-Smtp-Source: AGHT+IEkLOYLo4XAQVeIvtDwg+1G+LyBOiUDLU25QA/SrqM84vYgofks2exeF+HCl1fDwY4oUSBqOA==
X-Received: by 2002:a5d:64e6:0:b0:391:476f:d3b7 with SMTP id ffacd0b85a97d-399795df89emr2111415f8f.49.1742466698823;
        Thu, 20 Mar 2025 03:31:38 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f32fcdsm44746315e9.7.2025.03.20.03.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 03:31:38 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/4] net/mlx5: Expose additional devlink dev info
Date: Thu, 20 Mar 2025 09:59:43 +0100
Message-ID: <20250320085947.103419-1-jiri@resnulli.us>
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

---
v1->v2:
- patch#2:
  - fixed possibly uninitialized variable "err"

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


