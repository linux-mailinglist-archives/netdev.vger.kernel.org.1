Return-Path: <netdev+bounces-22037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC7F765BC2
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF672817EF
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C52319893;
	Thu, 27 Jul 2023 18:59:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206FC27136
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D14C433C8;
	Thu, 27 Jul 2023 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690484382;
	bh=TriW/T/BsttrAIRXuR67dYdZESVnSPb/3te4Xa+LB/g=;
	h=From:To:Cc:Subject:Date:From;
	b=EqfHQw7AnoDKfFZSuUiG+BpWDz+S/gRwixFxUXpI/Q2V77OnDxHcl3TTaKbR1KLof
	 hKPM5fqnH2lmaCBnnXLzvakPZez0PHdCS2/UJnavWhTOThOIg20nskrB5D4Whc8/xs
	 r7ocJbOL6GyCA47+k4mAJZbiuB/IRhpkTIKnxQajvpO3u63Mc4xl3tgXrwrjLgitpG
	 5LTelKb/yFaSGnPQUZDbk1zwKbdwKSgvFpdBnxdLHqUP9iYJLKDi10Y2WlN2CknmOS
	 rYWVRvUOxxVln7tirl/dTY9lBZRMWF97ELXX99J/yI+0+HAUerw8+uNGKiH0oW0TJU
	 468BsvIoVARHQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH net-next 0/2] mlx5: Expose NIC temperature via hwmon API
Date: Thu, 27 Jul 2023 11:59:20 -0700
Message-ID: <20230727185922.72131-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Expose NIC temperature by implementing hwmon kernel API, which turns
current thermal zone kernel API to redundant.

For each one of the supported and exposed thermal diode sensors, expose
the following attributes:
1) Input temperature.
2) Highest temperature.
3) Temperature label.
4) Temperature critical max value:
   refers to the high threshold of Warning Event. Will be exposed as
   `tempY_crit` hwmon attribute (RO attribute). For example for
   ConnectX5 HCA's this temperature value will be 105 Celsius, 10
   degrees lower than the HW shutdown temperature).
5) Temperature reset history: resets highest temperature.

Adham Faris (2):
  net/mlx5: Expose port.c/mlx5_query_module_num() function
  net/mlx5: Expose NIC temperature via hardware monitoring kernel API

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/hwmon.c   | 428 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/hwmon.h   |  24 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   8 +-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   1 +
 .../net/ethernet/mellanox/mlx5/core/port.c    |   2 +-
 .../net/ethernet/mellanox/mlx5/core/thermal.c | 114 -----
 .../net/ethernet/mellanox/mlx5/core/thermal.h |  20 -
 include/linux/mlx5/driver.h                   |   3 +-
 include/linux/mlx5/mlx5_ifc.h                 |  14 +-
 10 files changed, 474 insertions(+), 142 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/thermal.c
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/thermal.h

-- 
2.41.0


