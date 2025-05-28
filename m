Return-Path: <netdev+bounces-194056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3126AC7261
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 22:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23BD1BA4638
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 20:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFC3221D96;
	Wed, 28 May 2025 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="m+YoZGYd"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B517B50F;
	Wed, 28 May 2025 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748465139; cv=none; b=Czbpwx5GIHpLZsnLVf+WgbZvdwp+U7zHNwrNk9ele2s9RpST3aIVxcaXdA1cgcPGn8iXyY5zD7KzWA6D5bDaOLzaAK5QrPZ6sogLruhIS0zWxiUMz1OxKlt9sEw+umux3BZKsIOjzv0B+8PwvNfbLEdabZ4WJy3KI/PuZB3clnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748465139; c=relaxed/simple;
	bh=3hVQnUv6HQ7b3Vcrs7g4iPMlZImqNuEe5cv19aJL/X0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GDDTY2xOqHXaZ4v69QP+OtmYt230vroX5fqK3FKACRERf7QubaykPnuIYkBCPFhak+BrMUSJPMj5xMvOe7KBzdoWDj7pxoOVozV2+DOAk3HgQc3HTsS3w9CqkqvF6wydB5D/gdkhBXoKLSsOW41DDzhfSACLKfVtvCKDkL4jbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=m+YoZGYd; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uKNeZ-006kdy-2i; Wed, 28 May 2025 22:45:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=Rd9rH5LWALXhky9SyUkPFVgbR0mem8A0/IW38W7sOqo=
	; b=m+YoZGYdqcPmj1T0bKHa16j87Dv+HLFEH7mVQHnKTwJ98iE+crUre3xSDQxCQzW57m/yJ4A4Z
	0+fkuSmDK5T2v88WiXrnjgotOical13YGyZk6P2dX0S4b1+zhJ44JQp7M1cmckF9HbkLZWSiULPsT
	bDqAIBimRKEzTDVJNvozlbCoHbnAFVrHSaOV+j8DD52rEYxYxVwHgEv9HPbXNjCJx2phnlkgx9/Vg
	aRe898Aoi8RLiYHV2wmH+bNIQFUHdr2MD/Qq9f2bUwJJRCFltIpqUrCLI8UlKEBcw8HteX3gSlg7M
	529utMbocyijxvXsaZDb8L2YvnPlQTXUlf30qA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uKNeY-0008Q6-Bh; Wed, 28 May 2025 22:45:34 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uKNeA-00GEBu-SY; Wed, 28 May 2025 22:45:10 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH RFC net-next v2 0/3] vsock/test: Improve transport_uaf test
Date: Wed, 28 May 2025 22:44:40 +0200
Message-Id: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALh1N2gC/22NwQrCMBBEf6Xs2ZVmY231JAh+gFfpoUm3NgiJJ
 CFUSv/dmLPHN8y8WSGwNxzgXK3gOZlgnM1Auwr0PNgnoxkzA9XU1JKOmILTL4wcIhqrUbuEqiP
 ZEalRtR3k4dvzZJYifcD9dv1lliNaXiL0GWYTovOfcppEqRV/Q/KfPwkUOA2yqdvTQSg1Xrxyy
 1476Ldt+wKHbWUFwwAAAA==
X-Change-ID: 20250326-vsock-test-inc-cov-b823822bdb78
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Increase the coverage of a test implemented in commit 301a62dfb0d0
("vsock/test: Add test for UAF due to socket unbinding"). Take this
opportunity to factor out some utility code, drop a redundant sync between
client and server, and introduce a /proc/kallsyms harvesting logic.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Speed up: don't bother checking EINTR or respecting timeout on connect()s
- Introduce get_transports(), warn on unsupported setup [Stefano]
- Comment the code, drop the sync, introduce vsock_bind_try() [Stefano]
- Link to v1: https://lore.kernel.org/r/20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co

---
Michal Luczaj (3):
      vsock/test: Introduce vsock_bind_try() helper
      vsock/test: Introduce get_transports()
      vsock/test: Cover more CIDs in transport_uaf test

 tools/testing/vsock/util.c       | 84 ++++++++++++++++++++++++++++++++++++++--
 tools/testing/vsock/util.h       | 13 +++++++
 tools/testing/vsock/vsock_test.c | 83 ++++++++++++++++++++++++++++++---------
 3 files changed, 158 insertions(+), 22 deletions(-)
---
base-commit: 7e34abd434644fdc3f7efe02a7f0b7947cd06aac
change-id: 20250326-vsock-test-inc-cov-b823822bdb78

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


