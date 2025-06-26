Return-Path: <netdev+bounces-201673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB09CAEA837
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 22:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24687561BEB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 20:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA33325F961;
	Thu, 26 Jun 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9hr0cCk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C8223335
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750969730; cv=none; b=gAu5KeoHEXH8o2STbF2iR9HPo+qKIrLzWDRHiyhk2LTKrTo8Lrt7+HX/C/cTd5+ZzJcL7SetamtNRXkBQQ/VJzMukR04LuNllKEwh4M2N+TiyD7GwC+LizkjLfyu2/5fnrxbYQLVTAtgnP30rZOoTXJCOybp2C0bbn/sudQARtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750969730; c=relaxed/simple;
	bh=Wh5i1JPdbudoJkUYoRqlAkF4i+bTFhqMCPlU9VAwLZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lc3SB8yQRVUp/aMCmWmw3S8Ctdrw15jZI/OFSOcsOL1Ff5PBg1rypnmLPImarKNYRh0ti1MC8WaOcSmQjiqfCnNJxvEOSIJMTl6tHwLX7nnCGGYWcUpHqXn8vdhecim3sXCZrZptqlO2Sq6ZUfK7IGpfkyVNdEoADp0Ftid8M88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9hr0cCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF33C4CEEB;
	Thu, 26 Jun 2025 20:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750969730;
	bh=Wh5i1JPdbudoJkUYoRqlAkF4i+bTFhqMCPlU9VAwLZU=;
	h=From:To:Cc:Subject:Date:From;
	b=A9hr0cCkYPSz1J9j06YvQv9qN/gzCDWCV9dmcStAz24hDfa33RYDuWRB0Pz37NAN0
	 Z6C25XeR8Zu704eP52mZfc7gloo5U1CJ0mk4aqIEpml/z9yfa95/mbp0xNYXvJXrHl
	 pZBAdRcrAh+zI+UCcmvAUWYPAQOx/cysZN+sSSRCfw8C6S93iTTkPXhyJ6hNVV4OWH
	 0fvpGapnM5jfc1RxHuNhkcqIe2ibnUYJbOA8U34NWySLQ5hl0ciT/hu0Bb6TirkXu6
	 jnxk1NAAk/df6lySxpEnvL+kgMqoERUveA3jfqwC43qaef3n9+oufx8e0nvJRYgPqJ
	 xikWj9C2Dq5Aw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] net: ethtool: consistently take rss_lock for all rxfh ops
Date: Thu, 26 Jun 2025 13:28:45 -0700
Message-ID: <20250626202848.104457-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'd like to bring RXFH and RXFHINDIR ioctls under a single set of
Netlink ops. It appears that while core takes the ethtool->rss_lock
around some of the RXFHINDIR ops, drivers (sfc) take it internally
for the RXFH.

Consistently take the lock around all ops and accesses to the XArray
within the core. This should hopefully make the rss_lock a lot less
confusing.

Jakub Kicinski (3):
  net: ethtool: take rss_lock for all rxfh changes
  net: ethtool: move rxfh_fields callbacks under the rss_lock
  net: ethtool: move get_rxfh callback under the rss_lock

 drivers/net/ethernet/sfc/ethtool_common.c |  9 +---
 net/ethtool/common.c                      |  2 +
 net/ethtool/ioctl.c                       | 66 +++++++++++++----------
 net/ethtool/rss.c                         | 23 +++++---
 4 files changed, 59 insertions(+), 41 deletions(-)

-- 
2.50.0


