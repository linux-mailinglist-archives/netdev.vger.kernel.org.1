Return-Path: <netdev+bounces-238658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7629C5D022
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0C5E350E13
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC52DFA48;
	Fri, 14 Nov 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4fR3lMT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAA313E16
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121972; cv=none; b=cE6uhBwu2xd6w8T62qqDmb2H2lQk99RX9/vnV5IxGlKVuM2H3TwwVmMWo6agTBBtHuxjNbDjIypM+uNa0gRBPBkKmDwmyRhBs6+8//J9vnOpTVFNIzCWDEjmpowKxCKhqBxCuj/wFLgtA1X8wRT19fRfZHD5968gq28ujsGgjdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121972; c=relaxed/simple;
	bh=55HLKo1U9L1u78+Y8zh6QsOkJdYZ2tPr0vljzOfONM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i4xnpkPiPUNd7FqvsQvjXWMmh0BpT5PxCwNGYa6oE3Mrnml5G1ms+6LB9AOoWilFw0LtWSJU8HpBreB0FSc+bVEDAmhPyxgi3EycDNvbAy3pFEhEqEePZzEOHRgjvquCe58rHx+rekQsmY7BZFGYnwUot2NgCI3a8KmdkMEPlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4fR3lMT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763121969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hVo30B3evgsRaTN9YAaHUl6PEfrvxalbTRq7WUl556g=;
	b=L4fR3lMT74HZhPa9mMly8vg7CqlkLuP6D/k7GGSJyKz14keXJylv7kTf8BcgO7CPV+j9rU
	TQ0qKW7b49gvMQRhOVYnM3x5WRAbi4fP0vPLhsxVHijtJ50mLgltEaXARucChH17+yZ3x9
	EZdPvA0UcHXpKnt3YVM1r3j9bhzYFOo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-KvvIioQlNfKeU_xpyFQiLg-1; Fri,
 14 Nov 2025 07:06:04 -0500
X-MC-Unique: KvvIioQlNfKeU_xpyFQiLg-1
X-Mimecast-MFC-AGG-ID: KvvIioQlNfKeU_xpyFQiLg_1763121963
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA0AD1800350;
	Fri, 14 Nov 2025 12:06:02 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A7AD1956048;
	Fri, 14 Nov 2025 12:06:00 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	ivecera@redhat.com,
	jiri@resnulli.us,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next v3 0/3] Add DPLL subsystem management tool
Date: Fri, 14 Nov 2025 13:05:52 +0100
Message-ID: <20251114120555.2430520-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This series adds a new dpll tool for managing and monitoring DPLL devices
via the Linux kernel DPLL subsystem. The tool provides complete interface
for device and pin configuration, supporting complex topologies with
parent-device and parent-pin relationships.

Changes in v3:
- Use shared mnlg and str_to_bool helpers from lib
- Use str_num_map for bidirectional string/enum mapping
- Remove unnecessary else after return
- Remove misleading "legacy" comments
- Simplify DPLL_PR_MULTI_ENUM_STR macro
- Convert json_output to global json variable
- Use appropriate mnl helpers with proper type casting to respect signed integer data types
- Use DPLL_PR_INT_FMT for phase-adjust-gran to respect signed integer type
- Remove dpll_link from Makefile (mistake in v2)

Changes in v2:
- Added testing notes
- Added MAINTAINERS entry
- Removed unused -n parameter from man page

Petr Oros (3):
  lib: Move mnlg to lib for shared use
  lib: Add str_to_bool helper function
  dpll: Add dpll command

 MAINTAINERS                 |    5 +
 Makefile                    |    3 +-
 bash-completion/dpll        |  316 ++++++
 devlink/Makefile            |    2 +-
 devlink/devlink.c           |   22 +-
 dpll/.gitignore             |    1 +
 dpll/Makefile               |   38 +
 dpll/dpll.c                 | 2007 +++++++++++++++++++++++++++++++++++
 {devlink => include}/mnlg.h |    0
 include/utils.h             |    1 +
 lib/Makefile                |    2 +-
 {devlink => lib}/mnlg.c     |    0
 lib/utils.c                 |   17 +
 man/man8/dpll.8             |  428 ++++++++
 14 files changed, 2820 insertions(+), 22 deletions(-)
 create mode 100644 bash-completion/dpll
 create mode 100644 dpll/.gitignore
 create mode 100644 dpll/Makefile
 create mode 100644 dpll/dpll.c
 rename {devlink => include}/mnlg.h (100%)
 rename {devlink => lib}/mnlg.c (100%)
 create mode 100644 man/man8/dpll.8

-- 
2.51.0


