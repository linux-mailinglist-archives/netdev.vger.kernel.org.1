Return-Path: <netdev+bounces-246296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F2CE8F1E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 08:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 888313001837
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 07:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC022D7D41;
	Tue, 30 Dec 2025 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgOAtBCK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14822AE7A
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081567; cv=none; b=Wsf7SbJUZ6xcXd1TwTlFT2DUWQ2wiijvfAYIgBipIjLAzf7KxfPkuCDUpqxHPd1sq2SXKceCzMTByv+VHwLmHoVj9WlQUhzBktHO81PfdDpYSV9m2qq4aMuXRWBsvu33H3kbR690xaiIWdFSRgahh2O3MMrx5KrNNbCUe5ew+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081567; c=relaxed/simple;
	bh=8jPmQen44zA33S7n2Etxe5dVecUhiSgrXfORdR8FFMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGLlwUid/X3n6Xny91i9wWNnTht1vNoJj83yTZf7FJJaubT1OGqJ3WvC7ve5srhHOcB1wlIb+m2uTdDjvn/lg3QM7mutDXGbfueIcNNSuqcjOpa/DFNI2WdlEsIU7KS6YULkaB33U5BM9/n74+Pu1fT3ZM+aTAb2yPLL44VcLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgOAtBCK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767081564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kbhpEMXNgm3tTgoLY7Vy2dg7URMTphCxWjTZwP1bNlY=;
	b=PgOAtBCKp8p+MH6QIALiOl3j6L0Yknsxi4sQPfiRBYwcjr7M9p4g3Qit+H8fBzTOMJF4vv
	gTV53dVb6cUsUvt3VW4MoiAX5lAYqjlinGFey47PG7fz6AYqxJxZ+z3gaT3UMHtYGXUCtz
	1d8qJ/yxIloWc14xRzeuQuiuZM23vZQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-_QIb2Xl2MV2RW5ULrHVCZA-1; Tue,
 30 Dec 2025 02:59:21 -0500
X-MC-Unique: _QIb2Xl2MV2RW5ULrHVCZA-1
X-Mimecast-MFC-AGG-ID: _QIb2Xl2MV2RW5ULrHVCZA_1767081559
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9479195608E;
	Tue, 30 Dec 2025 07:59:19 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 509C11800367;
	Tue, 30 Dec 2025 07:59:15 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org
Subject: [RFC PATCH net-next v2 0/8] selftest: Extend tun/virtio coverage for GSO over UDP tunnel
Date: Tue, 30 Dec 2025 15:59:04 +0800
Message-ID: <cover.1767074545.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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


