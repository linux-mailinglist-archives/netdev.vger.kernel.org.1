Return-Path: <netdev+bounces-243152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E858C9A242
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 06:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D61134649E
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 05:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0A12FD1A5;
	Tue,  2 Dec 2025 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HznplaTg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE92FCC16
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764654805; cv=none; b=RRTO9UCL1mR6F197ob5ajXkTzxIwqGN1PjgU9OTx9UdkCkf8F0QvvDVfVQJ6GxLwmbtO1nRRd55CEzEr6ON6cCvaCZyNGKJUgv8W0gubZy+0xQBe4ch0qQpjuhRrL1w7x5sPos7gooANoqmUIZuYVbZnN2cO+eukaYviniPwvcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764654805; c=relaxed/simple;
	bh=RS679pmBcUNmWYxAl/iEPHDqJTgajd7MgWCxCF+d0nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8TqHYA7TWHfPt+OYQAwnHH4zz6TWLit8xJnk9AKk6NrZA1YfQcxquIia83fRwPz4G33YpZtvzDF+TgbKVOof/mkN6JL1Wm9fomB8gnBk0chjvzaxOFzOjE52E+g24ZGEz8YfHgQtHxwlDdPwaIkgUW7ePRsqByqX/rhg/fcULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HznplaTg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764654802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DDgeq+2RNeYqaPe0pc9rErvVCt69njUp1MbWVyX6tgs=;
	b=HznplaTgNUVD6tj4/7PEC/2Sp/DziT/skWJDhmH69HWY9t3KREqqU6rHIzCfKz90VkQGpe
	5ykMtWU7BuAvQ7QILN597HBUpV6wIJp0wD45ZSF664tTqfk2HBpU4y6Fy685GUuLoPhpUd
	OyhVO/CNr3qLxKw/0HSJNScroFIPcg4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-hAUFj8e0P42LFiiFEFYdvw-1; Tue,
 02 Dec 2025 00:53:20 -0500
X-MC-Unique: hAUFj8e0P42LFiiFEFYdvw-1
X-Mimecast-MFC-AGG-ID: hAUFj8e0P42LFiiFEFYdvw_1764654799
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 817481956080;
	Tue,  2 Dec 2025 05:53:19 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE4C030001A4;
	Tue,  2 Dec 2025 05:53:15 +0000 (UTC)
From: Xu Xu <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	Xu Du <xudu@redhat.com>
Subject: [RFC net-next 0/8] selftest: Extend tun/virtio coverage for GSO over UDP tunnel
Date: Tue,  2 Dec 2025 13:53:03 +0800
Message-ID: <cover.1764640939.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Xu Du <xudu@redhat.com>

The primary goal is to add test validation for GSO when operating over
UDP tunnels, a scenario which is not currently covered.

The design strategy is to extend the existing tun/tap testing infrastructure
to support this new use-case, rather than introducing a new or parallel framework.
This allows for better integration and re-use of existing test logic.

---
Link: https://lore.kernel.org/netdev/cover.1763345426.git.xudu@redhat.com/

v1 -> RFC:
 - Addresse sporadic failures due to too early send.
 - Refactor environment address assign helper function.

Xu Du (8):
  selftest: tun: Format tun.c existing code
  selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing
  selftest: tun: Refactor tun_delete to use tuntap_helpers
  selftest: tap: Refactor tap test to use tuntap_helpers
  selftest: tun: Add helpers for GSO over UDP tunnel
  selftest: tun: Add test for sending gso packet into tun
  selftest: tun: Add test for receiving gso packet from tun
  selftest: tun: Add test data for success and failure paths

 tools/testing/selftests/net/tap.c            | 286 +-----
 tools/testing/selftests/net/tun.c            | 915 ++++++++++++++++++-
 tools/testing/selftests/net/tuntap_helpers.h | 608 ++++++++++++
 3 files changed, 1527 insertions(+), 282 deletions(-)
 create mode 100644 tools/testing/selftests/net/tuntap_helpers.h


base-commit: 651765e8d527427e1d91fb7f606c5506f437f622
-- 
2.49.0


