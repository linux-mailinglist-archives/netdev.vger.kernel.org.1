Return-Path: <netdev+bounces-175723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43705A67438
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923B017C7A5
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E17C3F9D5;
	Tue, 18 Mar 2025 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0evRHl6e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9021428EC
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302034; cv=none; b=BiUOY/7qzp+Yr7ZTgEdSSVGeRFjKSheZf39I3IP3mcIGE7AUXfuonhQCVF+vy9ZtJ6T4f7S5WaEQ7I3GZUQQC/gNpmya0ixE6sIjBAdu+qQWOwbIFRMwGfZ7OaT/2btLEvmrILY/qQtTln8Hmg6x176Q7DAXCneipsA6AXzCpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302034; c=relaxed/simple;
	bh=dKqfmQs8dG04QHthXwjyqw9zxJ9HPqAAvkwIdk6yvPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzrY0IK1EJi20TZcQh2rh3psoPGU1Yd9eRM3fJvWZCxZ+APhHMabUZfH0570NETF4ohNv6bmxdFdvQ9mlqeC491IyDBvX4I0poRSJ1Zy6aXJduHenZB1Z/e8CJ4H/rLsEk0Ldzm6l86splsA6oUKzIpEJBUefaWhadTyqcAU9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0evRHl6e; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf257158fso21700865e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742302031; x=1742906831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T4HQsB1wfuPIDS6nVs/QDseI2n83Z0C4w/cifCgVcRw=;
        b=0evRHl6eZiZ7a5Mme64dxsqT8xfUmOgwVqZQhSfcWrAmR3CAj3ugOB6PDQ1lFNKxUc
         orDYSC5giXRYAX0sVee6yHDRRkV9RLj2M8EjxlD35m0LSFQn/41xPNKxa11k9fwikZaQ
         ZKhExMk4sAwCByVezh0zyM9JmuKpF+l8LTsaRsS/jENcbUlyd5UX0H67yS6w6pyb422s
         tqa2Z7J6Y3KOGbwB08XYMxYYMppfkn3aU2ul/4tWscus/k+CNW+EU1xjebQaHkNrkyQl
         kKXgTnJ4aRfcHJDfKuM1c/TYmKGq6dxrRmmn+4eujkkKg3S+9Tpj3djTFZVpCcNcVLgL
         E+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742302031; x=1742906831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4HQsB1wfuPIDS6nVs/QDseI2n83Z0C4w/cifCgVcRw=;
        b=mpl4yHYuDuOJon7WffxvNHcswTyOnDffJ3ZYVQ9n9jkB1uOoR+sYi1/qmfcMi2A5RD
         leYrAAFHzMFirJPPGpTEYa45WXfnMmcueaUxM/qaHpI52uRKr/tYWiOWJngVrZWXT8wY
         ZbldQRALivWBDq562h70ivjC8ShnMl6kn3Nx4D0nsB0TztK+UNHuKQehtJ0F/rdJUAJF
         OFsozvJGFf8u/CjZfRf0Kzli6dM5ts03b9a7tPo52JZj+TY5KNrCeQVp2zNzFFgd4Tig
         2UHnIDa2EdN0ZBUGHO0Q8ohcQOmAmy7T6srqyzA7jLoHUt7RLJlMi4TebYuJXPPcSgDr
         y2TA==
X-Gm-Message-State: AOJu0Yw/dPiNxqntPa0zhwiwNjgP79kbbly/+/P/s3VbAS5Gr9J47cIv
	wgcUWX+PrWnOobqIHCUyrVgXjeb+PdzHNgOutuI3yHHo4OAYu2Gm1bEgYnflDUvqlFbwKYZCneQ
	p
X-Gm-Gg: ASbGnct9gxjn+0xe109IgyNhoCaDs4N7hAwCUHsAfhr3YAtb0B//j+SvTc2e5ewjFVw
	jN5/UTxHmPs2j6cFJdEyxf+rocJsJw6tezvU34weITtGlykRN6NV4oUe3jDfltSYPWdN9JNUYGq
	e3J6uDvtRJLolIzkhLpkqj8FhXCGwdvJowMnCXesd93ifVPlW0k3OjWYBY63CCEpo6Txg6BYLwI
	YG7Y2bJ2xGS/LX9bHAH7tu8+rvSnjifmWa/rs+OAXZrV/HkuQem7eWAEFWpWKBnWA8Ffd1rhSSz
	xbvoaYGmnX3xyU3DfLxewtWXTEWCTA5GBiEwTQ==
X-Google-Smtp-Source: AGHT+IEbt7Gv+VXXYullIKLaitYl2BssmBbT48CEZ9dujyyl06wFfn4k+AG8erOgj6WWJnUe+kI14Q==
X-Received: by 2002:a5d:59a8:0:b0:390:f6aa:4e72 with SMTP id ffacd0b85a97d-3971d8fc8acmr12794541f8f.18.1742302030580;
        Tue, 18 Mar 2025 05:47:10 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39971b56299sm100807f8f.98.2025.03.18.05.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:47:09 -0700 (PDT)
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
	dakr@kernel.org,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	cratiu@nvidia.com,
	jacob.e.keller@intel.com,
	konrad.knitter@intel.com,
	cjubran@nvidia.com
Subject: [PATCH net-next RFC 0/3] net/mlx5: Introduce shared devlink instance for PFs on same chip
Date: Tue, 18 Mar 2025 13:47:03 +0100
Message-ID: <20250318124706.94156-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

This patchsets aims to introduce an entity, that allows to pin
devlink configuration objects (params, resources, etc) on for things
shared among multiple PFs.

As the shared entity that kind of float above the actual PFs does not
have explicit a PCI function, use faux device to back the devlink
instance. Expose the relationship between PF devlink instances and
this new shared instance by nested devlink attributes.

Example:

$ devlink dev
pci/0000:08:00.0:                   <--- PF0
  nested_devlink:
    auxiliary/mlx5_core.eth.0
faux/mlx5_core_83013c12b77faa1a30000c82a1045c91:  <--- shared devlink for chip that PF0 and PF1 are part of
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0           <--- ethernet auxiliary device of PF0
pci/0000:08:00.1:                   <--- PF1
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1           <--- ethernet auxiliary device of PF1

The first patch is a little adjustment to recently introduced faux driver.
The second patch introduces the shared devlink instance.
The last patch introduces example devlink param for the shared instance.

Jiri Pirko (3):
  faux: extend the creation function for module namespace
  net/mlx5: Introduce shared devlink instance for PFs on same chip
  net/mlx5: Introduce enable_sriov param for shared devlink

 drivers/base/faux.c                           |  20 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 236 ++++++++++++++++++
 .../mellanox/mlx5/core/lib/nv_param.h         |  14 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    |  18 ++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 164 ++++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  11 +
 include/linux/device/faux.h                   |   6 +-
 include/linux/mlx5/driver.h                   |   6 +
 include/linux/module.h                        |   2 +-
 10 files changed, 469 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h

-- 
2.48.1


