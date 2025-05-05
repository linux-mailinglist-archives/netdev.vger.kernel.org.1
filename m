Return-Path: <netdev+bounces-187777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F8EAA99B8
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8699B7A7FD2
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E2F25C809;
	Mon,  5 May 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnzXHKt9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714081991A9
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463940; cv=none; b=YpILGgDlyAcNXUzVVm7x1RPar9X6S6INjra4U7LyZ31rXDzyymAUXlPdmXuaQFl6QrUBFWItk+GQg1jygtVSbbB0o5gGKD7NCcKIaRbneqjm5Ok/QjcaloPFs9vEZFcjtmcDHQwLOyg35m9bZwye3Ml/E9d2jRTQf8SVHzjppOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463940; c=relaxed/simple;
	bh=uplKRYim1nMkZHZc6TZNKTf29oTeJSPcTAUvEF95Imo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKa7vzEWPAp8M2wYo3fTUwbZJ2UCJ5IiLZ4Rr2dgtGnRBcivRcAZ05YswMNnDP8rIc/G0TivgPRUsr2/snxTefaYdWhSmkO+PqopkGFKNLw5/0qzOwR50I5MBY6SVGYodssTmcorNPoYj7izSTHSDVraJTLPFzEEa4TukTaVPrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnzXHKt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FD9C4CEE4;
	Mon,  5 May 2025 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746463939;
	bh=uplKRYim1nMkZHZc6TZNKTf29oTeJSPcTAUvEF95Imo=;
	h=From:To:Cc:Subject:Date:From;
	b=mnzXHKt9jylKxdezztVjNxpbEaF6O18Ufc7seAWm7jPOIyyTpTUQrqxozgG1kvJk9
	 FWNDCnyhohwlZFkICG0Ik0C0iWCcJwJQvmy6PrtRVtwxS7UbvBjcnSxLrdmqEvAnU4
	 K0a0Cz6O0AO8750VOZpTVVBKnwdzWnquF715YlKELnT4wzFdZ74kEuOWAAxLrE2blj
	 dX0H+QQD/hdZ8lowKtb8VyNB70VDvNwpOtpWHgUsLoTNVfxZfbNa950ykKWBq0Qjja
	 DFI8V0M6yl2BmdiTfqQaqaGjB3Mxu2qXKUDjkuThOCsqXpTzhR/CZdrOVenZy++QxR
	 jNDg7OE5WyXsg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] tools: ynl-gen: split presence metadata
Date: Mon,  5 May 2025 09:52:04 -0700
Message-ID: <20250505165208.248049-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The presence metadata indicates whether given attribute was/should be
added to the Netlink message. We have 3 types of such metadata:
 - bit presence for simple values like integers,
 - len presence for variable size attrs, like binary and strings,
 - count for arrays.

Previously this information was spread around with first two types
living in a dedicated sub-struct called _present. The counts resided
directly in the main struct with an n_ prefix.

Reshuffle these an uniformly store them in dedicated sub-structs.
The immediate motivation is that current scheme causes name collisions
for TC.

Jakub Kicinski (3):
  tools: ynl-gen: rename basic presence from 'bit' to 'present'
  tools: ynl-gen: split presence metadata
  tools: ynl-gen: move the count into a presence struct too

 tools/net/ynl/samples/devlink.c  |  7 +--
 tools/net/ynl/samples/rt-addr.c  |  4 +-
 tools/net/ynl/samples/rt-route.c |  4 +-
 tools/net/ynl/pyynl/ynl_gen_c.py | 80 +++++++++++++++-----------------
 4 files changed, 45 insertions(+), 50 deletions(-)

-- 
2.49.0


