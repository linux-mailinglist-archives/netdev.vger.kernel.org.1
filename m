Return-Path: <netdev+bounces-163215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADCAA299A4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817A57A154B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560E1DB34C;
	Wed,  5 Feb 2025 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5sTo0EL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A11944F
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782111; cv=none; b=TpKnw7eqeJ0nQJ91XIKWzgfbs1bfP7XUTBaZaOU7sYAtmys3Vx5vlpFqgT3sNx1orBfI1fsjaz+WW25d3oksjUEbHsqOCExl+Uqv38yI5gfdv9NAbMzw2C589kp9SPH9fFo1v5oxWeTTL4RvhaulrJE+mHY1Cab1xYX07Alf85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782111; c=relaxed/simple;
	bh=lE5sJ4HwM77M/6IGQbRfO21GFwNDKfSYJ7z0w5f8VUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbaNvX4XwOuuxU7vsvYDz+HpBVIYCxPxfg6ELdef64jGMy/JmJJNciJrCL9pxGtb6ZqJ8FVU8rQWq9iZd6jwTiRFuyB+KaKxu8IYNigrBqEF949jL4zbHnbqeHr79JESnKcWffWDcgTxhXhcRy6rsQJlsZxe2iOEa5Vdt/TPOoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5sTo0EL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F03C4CED1;
	Wed,  5 Feb 2025 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738782111;
	bh=lE5sJ4HwM77M/6IGQbRfO21GFwNDKfSYJ7z0w5f8VUc=;
	h=From:To:Cc:Subject:Date:From;
	b=A5sTo0ELbZkEhIi1XJOJ0C2tsrN1nAr3r6gLaOEHrlBRiXsEqT1dlnfsPGEndlqnK
	 lwBxNpyDrYk3yNNfSAyY3FfnGDXRtJczLP8Lrv5b0oxIIbyTab+4IfTBgqDzS8HYQJ
	 rPhpWL7uZ3UATwtQoloyBt4+wAfia6acjmL1HEAW06Sk71ONAq/U98f44LNXhAJaHK
	 WGIo8PdXlH03+dErWiCzM0w26WO15riZixyyUt2PvlCjLZ6BrBhCM+nNYrLdxfx1xH
	 OaAp3kHmk2+CGBPN1B4V1cpHGBgYUHbIax+3e26XfvM9O0QSUaS8mrPMFNC/GfgC8S
	 wg8tRbK0uVw0w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] net: improve core queue API handling while device is down
Date: Wed,  5 Feb 2025 11:01:28 -0800
Message-ID: <20250205190131.564456-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core netdev_rx_queue_restart() doesn't currently take into account
that the device may be down. The current and proposed queue API
implementations deal with this by rejecting queue API calls while
the device is down. We can do better, in theory we can still allow
devmem binding when the device is down - we shouldn't stop and start
the queues just try to allocate the memory. The reason we allocate
the memory is that memory provider binding checks if any compatible
page pool has been created (page_pool_check_memory_provider()).

Previously I thought we need this as a fix, but gve rejects page pool
calls while down, and so did Saeed in the patches he posted. So this
series just makes the core act more sensibly but practically should
be a noop for now.

Jakub Kicinski (3):
  net: refactor netdev_rx_queue_restart() to use local qops
  net: devmem: don't call queue stop / start when the interface is down
  netdevsim: allow normal queue reset while down

 include/net/netdev_queues.h              |  4 +++
 drivers/net/netdevsim/netdev.c           |  8 ++---
 net/core/netdev_rx_queue.c               | 37 +++++++++++++-----------
 tools/testing/selftests/net/nl_netdev.py | 17 ++++++++++-
 4 files changed, 43 insertions(+), 23 deletions(-)

-- 
2.48.1


