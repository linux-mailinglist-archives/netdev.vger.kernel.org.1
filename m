Return-Path: <netdev+bounces-208037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE52AB09864
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0963B17E4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757291F0E32;
	Thu, 17 Jul 2025 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZA8D24jH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518AFBE46
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795851; cv=none; b=E1U2NTtCD0Ad6eY/60sKXtqFNj0KpOCdfm0TAgpSs2UPITrjhL9P4p26J4xwqmpzYytgNQcicehp4Ej7upzttAMjgnH9OCDavrrI1Ux9YpC+ICzSfFg3FHuJKY6w/dJzIcek9A2Qe5ZDQ3AHnchUMoyQkGrrPJQ8SHJrfqYvOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795851; c=relaxed/simple;
	bh=umImrcTdXQxBS4ltdq5WMtPPW1ueGYCakBO1ttmJtm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZP3v8ZZQzQArryxXGTUWCUciaryJp0wGxcytyYv35Rnj+BIJD+wz/5v4kghnjCGWUuOUHMECtHo4AkTVVcBnvuyaHkCzPuOxfAzpxY7RC0U7RV7UQkOb1KrdTlm1xUZRRTfYCBoAli/gsjuQPEyW8eh7dX5jMrIV+xyv94JV4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZA8D24jH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DDFC4CEE3;
	Thu, 17 Jul 2025 23:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795850;
	bh=umImrcTdXQxBS4ltdq5WMtPPW1ueGYCakBO1ttmJtm4=;
	h=From:To:Cc:Subject:Date:From;
	b=ZA8D24jHaJbGWAy6CGdO9bgYWKK5NIPIeu2PbKGypdMW+ptBwkiikAkGHw7NO4tYj
	 dRUvGMYcFEWpyitWun8+m6miB6knYG0oY9Vod3xXknHU2Wxx1FKzcbNck/FqnR4+Mw
	 36UFmWKziAhWA33ZAyBgx+kXFbeKlAygLWRr3gqKL7N54OibIT98YJOcAQeNKX3TcS
	 crEBToV2prTrk7TFF8T2PMDhf7i5yYGuIqXQCQGHH65ZIhZCL76QLjTVCcgfyFAUSE
	 PhPjqkb4yl/gcNpWeLI3hq6FQJztp13rEfPFqyi2x6RvJXH9FXpvwyzuN68OJWTd7f
	 Msy0pP7t2AkIQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/8] ethtool: rss: support creating and removing contexts via Netlink
Date: Thu, 17 Jul 2025 16:43:35 -0700
Message-ID: <20250717234343.2328602-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series completes support of RSS configuration via Netlink.
All functionality supported by the IOCTL is now supported by
Netlink. Future series (time allowing) will add:
 - hashing on the flow label, which started this whole thing;
 - pinning the RSS context to a Netlink socket for auto-cleanup.

The first patch is a leftover held back from previous series
to avoid conflicting with Gal's fix.

Next 4 patches refactor existing code to make reusing it for
context creation possible. 2 patches after that add create
and delete commands. Last but not least the test is extended.

Jakub Kicinski (8):
  ethtool: assert that drivers with sym hash are consistent for RSS
    contexts
  ethtool: rejig the RSS notification machinery for more types
  ethtool: rss: factor out allocating memory for response
  ethtool: rss: factor out populating response from context
  ethtool: move ethtool_rxfh_ctx_alloc() to common code
  ethtool: rss: support creating contexts via Netlink
  ethtool: rss: support removing contexts via Netlink
  selftests: drv-net: rss_api: context create and delete tests

 Documentation/netlink/specs/ethtool.yaml      |  41 +-
 Documentation/networking/ethtool-netlink.rst  |  41 ++
 .../uapi/linux/ethtool_netlink_generated.h    |   5 +
 net/ethtool/common.h                          |   8 +-
 net/ethtool/netlink.h                         |   5 +
 net/ethtool/common.c                          |  39 ++
 net/ethtool/ioctl.c                           |  48 +--
 net/ethtool/netlink.c                         |  22 +
 net/ethtool/rss.c                             | 393 ++++++++++++++++--
 .../selftests/drivers/net/hw/rss_api.py       |  73 ++++
 10 files changed, 603 insertions(+), 72 deletions(-)

-- 
2.50.1


