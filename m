Return-Path: <netdev+bounces-158371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1E5A11816
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD49168B6E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D36C156676;
	Wed, 15 Jan 2025 03:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEj7gmty"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69769136E3F
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913216; cv=none; b=UNJgGub+H5GIKyj6stmp8YZ8jBj1FLa3+YyciV1W8BYuUAgmQPqdvPp+Fcj+5QwFKPDPhIfx+w93yHZ9/GJ2ydpICDxgmIxAGt6meE95iGMcdxIfOjhR99XKSgRaJbwK3vfeX1w+AEFdFElR4Eu6UpPxI/vh0DpvqJa4IaFA0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913216; c=relaxed/simple;
	bh=9f4nA0oH56PWsr4M4sj5gY2HaaEElyJTD0Xhc9rsehw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tm+eqwTW1ai2mABEhulYd4+3jKXTg4XpFua42w0VWjZ6/BY9BBZm6g9gDJxEsvjNCLp5T/fiYv1TW95laE7ry2URzjM9nJll7Q9Fa6FnHo8s19jTj6zvKLSaim83WnAe0z1r3k36KO5rNzxQH/1tH+soAMHJ4BiXJcD9Ars9imo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEj7gmty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0C9C4CEDF;
	Wed, 15 Jan 2025 03:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736913215;
	bh=9f4nA0oH56PWsr4M4sj5gY2HaaEElyJTD0Xhc9rsehw=;
	h=From:To:Cc:Subject:Date:From;
	b=OEj7gmtydy8NYIa2a8bC2kKHuG7AE/uefl5EOHHvWEZ1yVwO0Ec3Q55TZdXngy0A+
	 PhIRHSZcU8jQ5BqoxHVytRv/2/FoFhx1fudyXtdP/ls0vP0KfTXYTCLNgDN96fl8BH
	 DmgCoLTP/ZzhNnHaGa95VreB0Yt+69QUDBL7FAbppFsvFve/dQWZuyJ8AlxjU374aH
	 cZCDoaPmPXYcCTdbd7THR3qEsVCCniaeD589uqi3vxElCvm7WAarW0GTNnnuHsP4Pf
	 NyHGVNrVw/gNgWuIztIALfdGwsDpXowB22FIIHrXO1R8Auac81pADPOghMwDqwJyB+
	 nJ4TYozBSwxcw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 00/11] net: use netdev->lock to protect NAPI
Date: Tue, 14 Jan 2025 19:53:08 -0800
Message-ID: <20250115035319.559603-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently added a lock member to struct net_device, with a vague
plan to start using it to protect netdev-local state, removing
the need to take rtnl_lock for new configuration APIs.

Lay some groundwork and use this lock for protecting NAPI APIs.

v2:
 - reorder patches 2 and 3
 - add missing READ_ONCE()
 - fix up the kdoc to please Sphinx / htmldocs
 - use napi_disabled_locked() in via-velocity
 - update the comment on dev_isalive()
v1: https://lore.kernel.org/20250114035118.110297-1-kuba@kernel.org

Jakub Kicinski (11):
  net: add netdev_lock() / netdev_unlock() helpers
  net: make netdev_lock() protect netdev->reg_state
  net: add helpers for lookup and walking netdevs under netdev_lock()
  net: add netdev->up protected by netdev_lock()
  net: protect netdev->napi_list with netdev_lock()
  net: protect NAPI enablement with netdev_lock()
  net: make netdev netlink ops hold netdev_lock()
  net: protect threaded status of NAPI with netdev_lock()
  net: protect napi->irq with netdev_lock()
  net: protect NAPI config fields with netdev_lock()
  netdev-genl: remove rtnl_lock protection from NAPI ops

 include/linux/netdevice.h                   | 118 +++++++++++--
 net/core/dev.h                              |  29 +++-
 drivers/net/ethernet/amd/pcnet32.c          |  11 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c |  84 ++++-----
 drivers/net/ethernet/marvell/mvneta.c       |   5 +-
 drivers/net/ethernet/via/via-velocity.c     |   6 +-
 drivers/net/netdevsim/ethtool.c             |   4 +-
 net/core/dev.c                              | 183 ++++++++++++++++++--
 net/core/net-sysfs.c                        |  39 ++++-
 net/core/netdev-genl.c                      |  56 +++---
 net/shaper/shaper.c                         |   6 +-
 11 files changed, 420 insertions(+), 121 deletions(-)

-- 
2.48.0


