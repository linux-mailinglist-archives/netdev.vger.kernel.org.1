Return-Path: <netdev+bounces-239577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A91C69D69
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4707E2B987
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E28B3596F5;
	Tue, 18 Nov 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7Tmhy6y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C7352944
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475053; cv=none; b=MzwwuIumT0ohrJVPTbzB6NQNUnZpd5BSvvkXbhKgTw9LzovdyJP9SYxQAjDw4MKMUgFJzF0q51OKmnkw6s5Yofl7mz6Nv0oxIbWpn8lul6OZqSwlz6ITfVAZfI/W7DdEydTrwWnsADsJHPwododY1rds8CsIDhVCcltAMPMI/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475053; c=relaxed/simple;
	bh=/rINBk6MG0iODih+1JN+gQ3BnOCiPwJurFke4FgdM80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3AwsGhLmu6NbTL6p6ijSQhbB9fQ1XKLXVV9Rip2zt94B6L5N3u/9aQ+PZ66CaLlIF6G12bleXlEbsBqZXogX333vwOybcpKpeQZ9kPFdT0N9ykswPNIwmKmhh6Itm4RxMgClrCgkyUGZAejRuHDi+HP6jItKXe5WeM6rgpyhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7Tmhy6y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763475050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=114JS9iXPjaTNUR3n7Ow74Ti6Gf2ll1b4RxA46sW0Hk=;
	b=T7Tmhy6y9ri2KTw6GWDSmcCSLSWmC7EFV5DM0NbRPf9n1CGJKn0rjbgf2ErpzEVjrIUqig
	X+8EmW6n2/M2+7dimOfZM+sN+EMPjFlECcEWBnQYZ/teB7NqPs4SiKDf1YEYZJKCwhyIY9
	/l+itc6gkcXPnE0NQ3yMuu8Ni0dfZL8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-hFxtFWeTNXm2kwedivFScQ-1; Tue,
 18 Nov 2025 09:10:45 -0500
X-MC-Unique: hFxtFWeTNXm2kwedivFScQ-1
X-Mimecast-MFC-AGG-ID: hFxtFWeTNXm2kwedivFScQ_1763475044
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51DC0180120E;
	Tue, 18 Nov 2025 14:10:44 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.225.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA87E3003754;
	Tue, 18 Nov 2025 14:10:40 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	ivecera@redhat.com,
	jiri@resnulli.us,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next v5 0/3] Add DPLL subsystem management tool
Date: Tue, 18 Nov 2025 15:10:28 +0100
Message-ID: <20251118141031.236430-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch series adds a new userspace tool for managing and monitoring
DPLL (Digital Phase-Locked Loop) devices via the Linux kernel DPLL
subsystem.

The series includes preparatory patches to move shared code to lib/ and
the main dpll tool implementation with full support for device/pin
management, monitoring, and JSON output.

Changes in v5:
- Fix checkpatch warnings
- Use structure initialization instead of memset
- Use sigemptyset() for proper signal mask initialization
- Remove redundant if (json) checks around JSON functions
- Use signalfd for signal handling in monitor
- Set netlink socket to non-blocking in monitor

Changes in v4:
- Replace DPLL_PR_MULTI_ENUM_STR macro with dpll_pr_multi_enum_str() function
- Replace pr_out("\n") with print_nl() for one-line mode support
- Remove all is_json_context() code splitting, use PRINT_FP/PRINT_JSON/PRINT_ANY
- Add dpll_pr_freq_range() helper function to reduce code duplication

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
 dpll/dpll.c                 | 1951 +++++++++++++++++++++++++++++++++++
 {devlink => include}/mnlg.h |    0
 include/utils.h             |    1 +
 lib/Makefile                |    2 +-
 {devlink => lib}/mnlg.c     |    0
 lib/utils.c                 |   17 +
 man/man8/dpll.8             |  428 ++++++++
 14 files changed, 2764 insertions(+), 22 deletions(-)
 create mode 100644 bash-completion/dpll
 create mode 100644 dpll/.gitignore
 create mode 100644 dpll/Makefile
 create mode 100644 dpll/dpll.c
 rename {devlink => include}/mnlg.h (100%)
 rename {devlink => lib}/mnlg.c (100%)
 create mode 100644 man/man8/dpll.8

-- 
2.51.0


