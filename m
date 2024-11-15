Return-Path: <netdev+bounces-145121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E289CD52A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA161F22172
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6877DA67;
	Fri, 15 Nov 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osiFEI7n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC04E58222
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 01:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635636; cv=none; b=iC1WEVEmHkjL9VH3g1YyWSiF7WVRx1DQVDOIxJUEcbJtyjNxJE/p9Ry/FEjhFEWgsw5t/QkgstMuqJvWxgMUofc6uOQu7ryvkhbBP2VR+/bljbIsHjHqIhJhu+k3rVt+S26tVxKvn9RnvzTtc2AIyNW7yuMvWAn+Ga7gTZBxr1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635636; c=relaxed/simple;
	bh=NGeLwWiXNnezvO162XvVXW/yi0USjtHWBcM1FmUkweU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIWt9zK8Sk+8x+IqDoP9Jb54NmhXwJc9WMApwaFlfvd2YttsFi3jMX59L38gO/9yRxM8P7LagQCNrbJStvS6c4N5QVL9peZ77ylyjc4WuWmRo/DvoVncjvd6YlLmZDzhX3St4uv6956QY5KI9Bfihhff7yo5iBSFXWroKiNDYXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osiFEI7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DBDC4CECD;
	Fri, 15 Nov 2024 01:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731635635;
	bh=NGeLwWiXNnezvO162XvVXW/yi0USjtHWBcM1FmUkweU=;
	h=From:To:Cc:Subject:Date:From;
	b=osiFEI7nUEHSDOaY134/TI4acPnc9qN8XI4h2q0W9TaM2sD+2YsBKiwKn+vGpql6e
	 lut1Ie3EQluTDAQgDtEQzIBjGfqfvIT3fenlvkqhEAkXHgtao/Xe1p8vDRJ/1D+kvy
	 bjceOW7nTxCr5NcJd40DZIDe3crNX6kkkhzBiPu8Ar+2mfxuE48WI1LNxtZtb/IEJP
	 ItS7hVQluB49gq6TelGO0EJa1hPAGGm4yNAsrCCywOJd/yzLDNw2SPmcajo7mKuomk
	 jHqfQLCRwAvdrunBpN5syl8Rzy+aCFVXlPM7cOv25v0wh9smYvBn2tRFD9kTjD8fZK
	 73R25JrrK8CJw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] eth: fbnic: cleanup and add a few stats
Date: Thu, 14 Nov 2024 17:53:39 -0800
Message-ID: <20241115015344.757567-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup trival problems with fbnic and add the PCIe and RPC (Rx parser)
stats.

All stats are read under rtnl_lock for now, so the code is pretty
trivial. We'll need to add more locking when we start gathering
drops used by .ndo_get_stats64.

Jakub Kicinski (3):
  eth: fbnic: add missing SPDX headers
  eth: fbnic: add missing header guards
  eth: fbnic: add basic debugfs structure

Sanman Pradhan (2):
  eth: fbnic: add PCIe hardware statistics
  eth: fbnic: add RPC hardware statistics

 .../device_drivers/ethernet/meta/fbnic.rst    |  43 ++++
 drivers/net/ethernet/meta/fbnic/Makefile      |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   6 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  47 +++++
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  68 ++++++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  74 +++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 193 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  28 +++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  16 +-
 9 files changed, 475 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c

-- 
2.47.0


