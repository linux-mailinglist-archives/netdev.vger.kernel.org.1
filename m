Return-Path: <netdev+bounces-238902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC30C60CBD
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 00:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C95D1351D12
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 23:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD923372C;
	Sat, 15 Nov 2025 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VH22xkVp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCA24A069
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249633; cv=none; b=GUEvJtlxD2Smq8W76BuBz4kloCBwQBoDTEBjnQbHN7f5IlCRqVDjWumHVg2DLiWl9sJ9ZjoaeHyrXkmpJQwwM90RAN8ae0EjM7t5YwCHKx6sIbEJNaqoBQlPsoLWS6rJdq7s0M1tUQf54dwe8UwwNFvecxQNMuEAxqhPEJHHp34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249633; c=relaxed/simple;
	bh=mD8u1LEgv/Ni0dgfjs1uXMPs6B8V3YQPUlTdJGGqCUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4tlKtMqCTAAzs/SKlUdKjLYv9hsNsMFJOljsFxxApftOm9PkjAiRI9y/fCMafUa9ZkMPXUtU4d0mmxmT7B8aExkm0p2m6FM7ABKCeiZ1PSdN4W4LpJRY12Oo9fr5vvvJY2xL3+wwKT8Rl1MHWbP1KfKMU0uNBaoT/+l+z9svxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VH22xkVp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763249631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZcYWD9dF+zfshn2OXyGUnjoKzc4InY3fRLHBkUYH4FQ=;
	b=VH22xkVpUtZfhMCJV99VbxdK3V4gosF21nH/Z1/s2pi4rsvPsMuClk2tabshB7Bgk9jJFJ
	gHI1IQujcavZWOjKLP09kxtt2R5QtCimp+BxP7LEOID1LtI7oqiiHnS6d+IXk1o2oTxLsR
	ghzFvZEEznVNdMaG3U/tvqYcNbEFfOw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-6YEts9qJPGawS9RYvFzJ1w-1; Sat,
 15 Nov 2025 18:33:48 -0500
X-MC-Unique: 6YEts9qJPGawS9RYvFzJ1w-1
X-Mimecast-MFC-AGG-ID: 6YEts9qJPGawS9RYvFzJ1w_1763249628
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C2A81956088;
	Sat, 15 Nov 2025 23:33:47 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0840019560A7;
	Sat, 15 Nov 2025 23:33:44 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	ivecera@redhat.com,
	jiri@resnulli.us,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next v4 0/3] Add DPLL subsystem management tool
Date: Sun, 16 Nov 2025 00:33:38 +0100
Message-ID: <20251115233341.2701607-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch series adds a new userspace tool for managing and monitoring
DPLL (Digital Phase-Locked Loop) devices via the Linux kernel DPLL
subsystem.

The series includes preparatory patches to move shared code to lib/ and
the main dpll tool implementation with full support for device/pin
management, monitoring, and JSON output.

Changes in v4:
- Replace DPLL_PR_MULTI_ENUM_STR macro with dpll_pr_multi_enum_str() function
- Replace pr_out("\n") with print_nl() for one-line mode support
- Remove all is_json_context() code splitting, use PRINT_FP/PRINT_JSON/PRINT_ANY
- Add dpll_pr_freq_range() helper function to reduce code duplication
- Remove trivial comments

Changes in v3:
- Use shared mnlg and str_to_bool helpers from lib
- Use str_num_map for bidirectional string/enum mapping
- Remove unnecessary else after return
- Remove misleading "legacy" comments
- Simplify DPLL_PR_MULTI_ENUM_STR macro
- Convert json_output to global json variable
- Use appropriate mnl helpers with proper type casting for signed integers
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
 dpll/dpll.c                 | 1933 +++++++++++++++++++++++++++++++++++
 {devlink => include}/mnlg.h |    0
 include/utils.h             |    1 +
 lib/Makefile                |    2 +-
 {devlink => lib}/mnlg.c     |    0
 lib/utils.c                 |   17 +
 man/man8/dpll.8             |  428 ++++++++
 14 files changed, 2746 insertions(+), 22 deletions(-)
 create mode 100644 bash-completion/dpll
 create mode 100644 dpll/.gitignore
 create mode 100644 dpll/Makefile
 create mode 100644 dpll/dpll.c
 rename {devlink => include}/mnlg.h (100%)
 rename {devlink => lib}/mnlg.c (100%)
 create mode 100644 man/man8/dpll.8

-- 
2.51.0


