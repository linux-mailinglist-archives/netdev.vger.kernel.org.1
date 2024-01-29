Return-Path: <netdev+bounces-66762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610184092F
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 15:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F51F27FDD
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ABE153BC8;
	Mon, 29 Jan 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PwQOMa0V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB71534FE
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540363; cv=none; b=sEEQ8INimEZ7yoX4UT3/mcGqUhX+qngS+kNjSZiAq1X6XBPm3iak+U7LWNru348FBb+62lizRqNLPc+VRunVONKbuMfwc2HadLBqEvZk0IX+ywEbZzzxsn5Hw1N6cMCwvyKL8m/um0lIkl4iq4LSS7ulTqf6kOU03UuXAO8BpAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540363; c=relaxed/simple;
	bh=8fyWiu78TUx1qjw/rHKWezThYy2WmsDxNXXasG4Etpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HfBSCCVo3WDsFP7u+9eG2O8vs3lPJEIrk+rcoP08rtVXAZ7z01QbzwDf1CQjtIpVyMV+lRzftU28Df9d+lwv+Cpip/tSXxsyInepAZ93IXbCJaJAHILHUmySWojfOY3TOkQ+t8c4lhXUjV7o3jhM+GIgLwrnH/IMv/rqRq53A9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PwQOMa0V; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so3155167a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 06:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706540359; x=1707145159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gtLmwrFuP5GfbtBwMBRzTK5bww1wqvpYAP+tbeJpdVo=;
        b=PwQOMa0VotE1EiqeImKXDrmAkk8zvKSB0ZQRZpqBqIU6GLAq09Ak8mKPY9c01UeoW1
         G3FqKrvcIhv53+CtQcee2lTuX6ikgaqOUPKqx3Y+zWU+cGUKDFU7Ueo/kBLYhH2TOj3E
         6cb7NYOw/7c5JSmRjUo79GJx0VQFOTS4cShhijIN/tj5Y8ML2sQLTl5QFFbQzZ4liUTI
         HYSVK0JhhcVfJ8Tf6o+QfLrCmGbABevkPpvk2xGw4VzvpAxAORBI9d990BIm84n60yZW
         JOjJtSPjFcOxNFujJw39JQW3jR0cTKrU3GLrrJor0zdDt515nRO2ye+ruXMHv0A6Z1vA
         i4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540359; x=1707145159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtLmwrFuP5GfbtBwMBRzTK5bww1wqvpYAP+tbeJpdVo=;
        b=XsfoDYT9qO1L9d9xhuvmU2RVhvgcKhlPRk2WYBBQzLXxX1Fb7TKH2URFfYBN+8hb+p
         +1frIConqsZ+Ke6eKWVthNgSNhCQV1RnAXDTZtut5l9amGQKKEUauziPTD8ofjcDLgoz
         70/rgXWNUz+3Xg3vPuSbURWoaLgEEJi94t4WlnFEoCAZh0tlhlXGS+37sGvM8uZAKKOK
         Tiy8ocET+Zd9m75LyFc7v1D4kfzhIweph2djUhohJ7IVmyM5o7sGlvzMHPFC/BTCzyrd
         Z5r/D/QtXDOUXaAHefjVSS7Oile9pjNRnyRyf06AsWLMGD2/wH9v+Ea5uuVG3w4z+O2g
         aOvg==
X-Gm-Message-State: AOJu0YwWhtiEr5aaV3jv+rD8mPBhpkDpUd9GKm8mnwh89vU80ml0P5Lq
	Lj9HW+v8bMhhPVCAqI9hDVx09Fi7NO0+YK2hEjkzKVsY8r1Xc713onpO4JIcrA7qUMfBAMJFtmR
	0RDT17g==
X-Google-Smtp-Source: AGHT+IHSibIdcm8lrff2QysP5Bm9dN4brJRvGC1GdrSyBD0qcYp4b2nn1TGKAU1AlCeW7hZ1nE0hhQ==
X-Received: by 2002:a17:906:d14f:b0:a32:31f0:f0e9 with SMTP id br15-20020a170906d14f00b00a3231f0f0e9mr4543622ejb.25.1706540359495;
        Mon, 29 Jan 2024 06:59:19 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id vg10-20020a170907d30a00b00a3522154450sm3329797ejc.12.2024.01.29.06.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:59:18 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	rrameshbabu@nvidia.com
Subject: [patch net-next 0/3] dpll: expose lock status error value to user
Date: Mon, 29 Jan 2024 15:59:13 +0100
Message-ID: <20240129145916.244193-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Allow to expose lock status errort value over new DPLL generic netlink
attribute. Extend the lock_status_get() op by new argument to get the
value from the driver. Implement this new argument fill-up
in mlx5 driver.

Jiri Pirko (3):
  dpll: extend uapi by lock status error attribute
  dpll: extend lock_status_get() op by status error and expose to user
  net/mlx5: DPLL, Implement lock status error value

 Documentation/netlink/specs/dpll.yaml         | 39 +++++++++++++++++++
 drivers/dpll/dpll_netlink.c                   |  9 ++++-
 drivers/net/ethernet/intel/ice/ice_dpll.c     |  1 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 32 +++++++++++++--
 drivers/ptp/ptp_ocp.c                         |  9 +++--
 include/linux/dpll.h                          |  1 +
 include/linux/mlx5/mlx5_ifc.h                 |  8 ++++
 include/uapi/linux/dpll.h                     | 30 ++++++++++++++
 8 files changed, 120 insertions(+), 9 deletions(-)

-- 
2.43.0


