Return-Path: <netdev+bounces-15010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330BE745382
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 03:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5C0280C8C
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 01:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E79B387;
	Mon,  3 Jul 2023 01:27:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A8362
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 01:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35DCC433C8;
	Mon,  3 Jul 2023 01:27:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jvP9A47q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1688347656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/8FNBpNat7e309IgNwWfqNiKa7gq9pqAeqIgNCoAAOY=;
	b=jvP9A47qBYvZk6koIP8i4z89ZNHmYlqsDJUlnD2KrYYpVpJgq1Vugz0wW8/f4x11n0REyW
	zIV3Wj66diR++67tI0jx8N0X2kVqpVkhcb8M04ISIa9LMVHcVMZgM4CIjJ1VXefD6/H9La
	oWfvRMh++DRWCRuyeYPHHdmywq+Fp+Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 27e20959 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jul 2023 01:27:34 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 0/3] wireguard fixes for 6.4.2/6.5-rc1
Date: Mon,  3 Jul 2023 03:27:03 +0200
Message-ID: <20230703012723.800199-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

Sorry to send these patches during the merge window, but they're net
fixes, not netdev enhancements, and while I'd ordinarily wait anyway,
I just got a first bug report for one of these fixes, which I originally
had thought was mostly unlikely. So please apply the following three
patches to net:

1) Make proper use of nr_cpu_ids with cpumask_next(), rather than
   awkwardly using modulo, to handle dynamic CPU topology changes.
   Linus noticed this a while ago and pointed it out, and today a user
   actually got hit by it.

2) Respect persistent keepalive and other staged packets when setting
   the private key after the interface is already up.

3) Use timer_delete_sync() instead of del_timer_sync(), per the
   documentation.

Thanks,
Jason

Jason A. Donenfeld (3):
  wireguard: queueing: use saner cpu selection wrapping
  wireguard: netlink: send staged packets when setting initial private
    key
  wireguard: timers: move to using timer_delete_sync

 drivers/net/wireguard/netlink.c            | 14 ++++++----
 drivers/net/wireguard/queueing.c           |  1 +
 drivers/net/wireguard/queueing.h           | 25 ++++++++----------
 drivers/net/wireguard/receive.c            |  2 +-
 drivers/net/wireguard/send.c               |  2 +-
 drivers/net/wireguard/timers.c             | 10 ++++----
 tools/testing/selftests/wireguard/netns.sh | 30 +++++++++++++++++++---
 7 files changed, 54 insertions(+), 30 deletions(-)

-- 
2.41.0


