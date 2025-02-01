Return-Path: <netdev+bounces-161885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC61A24633
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 02:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00201889D83
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 01:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0BBA926;
	Sat,  1 Feb 2025 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4QvARD9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057254A23
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738373459; cv=none; b=dXvL+57txHz1bE8ybLZ5uqCkiEWvuPYnp/H3Kf38bxdmFDHqMXrHiouC4QwwChp0d2vynad6r2zTihF6OLEBMW+Amy4ipGqYvi/nFSDKH1W7gBk0tzVloPYUauolXaakB6XXAq4VppXS7gnvcSUDrw3O7H55xkjrlmPKOl6YBEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738373459; c=relaxed/simple;
	bh=Pfvavqg2aDgFxkDUVJ4FmyDYEYWb5HwcujLPcX3Dkz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VC8lOF+Mj0Ix3hedKPLKSYdD8fR8Kh8gfGA5KJknsf3mhFIgfneKnJh4dwA7gfkxOvB3zOhEsDJsAuFMPfOLHcnuObU8b5CH2upN0vJuWrMChg5Xy3wNOrEcR0CmUoWvTEUj7F47xjysxjgtV1raQmoYmhjrgnF/dXrM0rxFTbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4QvARD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3558C4CED1;
	Sat,  1 Feb 2025 01:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738373458;
	bh=Pfvavqg2aDgFxkDUVJ4FmyDYEYWb5HwcujLPcX3Dkz4=;
	h=From:To:Cc:Subject:Date:From;
	b=h4QvARD9mZT3DSHTBXuPBfXmIe+yPZfvg+UONnU8FtpHzcajtwEpIfpMsE3Ge41t5
	 Qcg6Z0KiZl8Jmidi4ljK8ih0QC988G7Ko4SLM9fYqc/HY+jEFl0sh0/ouGn6PPS4ql
	 VeI9BQ/faPzwI6IkbJ53DC7Oy6VgIrXnCVAUTBBqDUfGgSMLZavcUr2Sg1XjsTnNTu
	 sg3yGpaWkayAmOEpV/DVoLm7vrQH/Y9O6q3gw5xpFbvYMX62oxdgZGMWg6w2howftu
	 mCc2xMKEZTy9PAIBvAJy0sPNe3v/rNjFiBFVLlkIa28A/Gm4pczuxPI1RP/Mr4S1iR
	 /EatOASEDXSVQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/4] ethtool: rss: minor fixes for recent RSS changes
Date: Fri, 31 Jan 2025 17:30:36 -0800
Message-ID: <20250201013040.725123-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure RSS_GET messages are consistent in do and dump.
Fix up a recently added safety check for RSS + queue offset.
Adjust related tests so that they pass on devices which
don't support RSS + queue offset.

Jakub Kicinski (4):
  ethtool: rss: fix hiding unsupported fields in dumps
  ethtool: ntuple: fix rss + ring_cookie check
  selftests: drv-net: rss_ctx: add missing cleanup in queue reconfigure
  selftests: drv-net: rss_ctx: don't fail reconfigure test if queue
    offset not supported

 net/ethtool/ioctl.c                               | 2 +-
 net/ethtool/rss.c                                 | 3 ++-
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 9 ++++++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.48.1


