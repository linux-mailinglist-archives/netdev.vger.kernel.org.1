Return-Path: <netdev+bounces-239023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C13C6281A
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C0C235E598
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 06:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A2314D19;
	Mon, 17 Nov 2025 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0PLjFoU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A191DE4F1
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360722; cv=none; b=U7Ohf0YGllh1gcamTD3pa/OWoKDFv/E88ouPy2kSOBVxKNjk6IHPICZLCwT5VBic+ZTOy8lq8ukjNA5zJ4g3eG/dJXIudtOOmdgxoiO4kFz3UpJa4gUJVJ4nKbR6BvX6GCcTQFQB6y0cKdok9460Z/1+/roRHzC3fer98kYHIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360722; c=relaxed/simple;
	bh=itp2jCFtVxFpObkMuTkoz/PFN6kuVYIVR1oWSNUaQHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjwrdEYftMQ5UqIBaGS4KpFejz4mjeadidK31PMo+08nDJG8fFKiq1+FBlmwcTBPCWpq6hZdQs+GAr4BTixIofo2fjOS3T5Y7Q/UEj2r8XbyG6/Pul+yCCfDBaN7WQUR3AMFCpTm624d8JRevfwGFha6Ahhh1i27KJSMYLh9dMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0PLjFoU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763360718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LdWeIGPKRT0xHtD/pd9bR3mN2YoBO/Vu4W5sYnjuBDI=;
	b=W0PLjFoUdTuwptevt1QvRL0mzg0olQ4rX+8nR6egsEu1DQMjuMyvhVhWrJYUl4F4v08CPm
	39MtZXzLbFBRrWqdbJjfg0CY/yKHRrddhT7nJD8ONzIpurhrHE3WBp2uc5iWatd7+SrIZL
	Qq+spB8ifucoKDr3kNNGsqdYV49uL54=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-kAOJ7JabPze7Y0PYryvPUg-1; Mon,
 17 Nov 2025 01:25:17 -0500
X-MC-Unique: kAOJ7JabPze7Y0PYryvPUg-1
X-Mimecast-MFC-AGG-ID: kAOJ7JabPze7Y0PYryvPUg_1763360715
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 671011956095;
	Mon, 17 Nov 2025 06:25:15 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.141])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A2B7E1955F1B;
	Mon, 17 Nov 2025 06:25:12 +0000 (UTC)
From: xu du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 0/8] selftest: Extend tun/virtio coverage for GSO over UDP tunnels
Date: Mon, 17 Nov 2025 14:24:56 +0800
Message-ID: <cover.1763345426.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch series increases test coverage for the tun/virtio use-case.

The primary goal is to add test validation for GSO when operating over 
UDP tunnels, a scenario which is not currently covered.

The design strategy is to extend the existing tun/tap testing infrastructure
to support this new use-case, rather than introducing a new or parallel framework.
This allows for better integration and re-use of existing test logic.

*** BLURB HERE ***

xu du (8):
  selftest: tun: Format tun.c existing code
  selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing
  selftest: tun: Refactor tun_delete to use tuntap_helpers
  selftest: tap: Refactor tap test to use tuntap_helpers
  selftest: tun: Add helpers for GSO over UDP tunnel
  selftest: tun: Add test for sending gso packet into tun
  selftest: tun: Add test for receiving gso packet from tun
  selftest: tun: Add test data for success and failure paths

 tools/testing/selftests/net/tap.c            | 286 +-----
 tools/testing/selftests/net/tun.c            | 884 ++++++++++++++++++-
 tools/testing/selftests/net/tuntap_helpers.h | 495 +++++++++++
 3 files changed, 1383 insertions(+), 282 deletions(-)
 create mode 100644 tools/testing/selftests/net/tuntap_helpers.h


base-commit: df58ee7d8faf353ebf5d4703c35fcf3e578e9b1b
-- 
2.49.0


