Return-Path: <netdev+bounces-246721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF67CCF0A80
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 07:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A92F300C5F4
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 06:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D3D2D839B;
	Sun,  4 Jan 2026 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyJP66sH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D0B2BE02B
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767507763; cv=none; b=pJ1SqsURtIR8gW2B3FrleAidU953PFamhpeEiJwHa3csjPV8YwGUhZARTM87wm1zKqzHMRL5IyBi5qrWVoCim7NI0pA/zULyB9kxOnHA6o1uMtW9VqCOKwOI+SBWsMiIB+G/ktSKRr2+uviXjRO6lLX7xqirA+M357A3/OhHR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767507763; c=relaxed/simple;
	bh=8jPmQen44zA33S7n2Etxe5dVecUhiSgrXfORdR8FFMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ql25OVn5pu2388AhAzH86fjA/YUhhnp/cN8s0hiuLP5y8VobDWjCiuvi1ayEzEr/9O4x5i0x73hcDHNWTbBTsNJcDx2UW8AVaokDTXgo1gBhvEV60DPJsThCp1w2MtYX7/lB1av3xkVbZHHy76DxHnADo9T8Dk9S5QdqkGHBDVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PyJP66sH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767507761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kbhpEMXNgm3tTgoLY7Vy2dg7URMTphCxWjTZwP1bNlY=;
	b=PyJP66sHULmFZdfUGFw3a9+mxslvZPwGu+fxIGwT/ed4FozAxtxxhsOKTW1rBex9ZeShuR
	aMxg7rHcnym4C/i8/+sfyxLdCLcRhlDNJR/F0Hhwd7EAoPxXoXkGH31vy2+mfM/SgbVH7W
	82Goo6Yi5TXH7bY5Qp78zsm0kYh05Ik=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-YB025s2FNI6SL0g33yxu2g-1; Sun,
 04 Jan 2026 01:22:37 -0500
X-MC-Unique: YB025s2FNI6SL0g33yxu2g-1
X-Mimecast-MFC-AGG-ID: YB025s2FNI6SL0g33yxu2g_1767507755
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE5BC18002DE;
	Sun,  4 Jan 2026 06:22:35 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7322019560A7;
	Sun,  4 Jan 2026 06:22:32 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/8] selftest: Extend tun/virtio coverage for GSO over UDP tunnel
Date: Sun,  4 Jan 2026 14:22:19 +0800
Message-ID: <cover.1767074545.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The primary goal is to add test validation for GSO when operating over
UDP tunnels, a scenario which is not currently covered.

The design strategy is to extend the existing tun/tap testing infrastructure
to support this new use-case, rather than introducing a new or parallel framework.
This allows for better integration and re-use of existing test logic.

---
v1 -> v2:
 - Addresse sporadic failures due to too early send.
 - Refactor environment address assign helper function.
 - Fix incorrect argument passing in build packet functions.

v1: https://lore.kernel.org/netdev/cover.1763345426.git.xudu@redhat.com/

Xu Du (8):
  selftest: tun: Format tun.c existing code
  selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing
  selftest: tun: Refactor tun_delete to use tuntap_helpers
  selftest: tap: Refactor tap test to use tuntap_helpers
  selftest: tun: Add helpers for GSO over UDP tunnel
  selftest: tun: Add test for sending gso packet into tun
  selftest: tun: Add test for receiving gso packet from tun
  selftest: tun: Add test data for success and failure paths

 tools/testing/selftests/net/tap.c            | 287 +-----
 tools/testing/selftests/net/tun.c            | 917 ++++++++++++++++++-
 tools/testing/selftests/net/tuntap_helpers.h | 608 ++++++++++++
 3 files changed, 1530 insertions(+), 282 deletions(-)
 create mode 100644 tools/testing/selftests/net/tuntap_helpers.h


base-commit: 7b8e9264f55a9c320f398e337d215e68cca50131
-- 
2.49.0


