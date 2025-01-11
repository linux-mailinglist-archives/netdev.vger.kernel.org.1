Return-Path: <netdev+bounces-157355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B0DA0A066
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 03:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178C6188AF53
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E5976026;
	Sat, 11 Jan 2025 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkK7wju8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3571110E9
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736563441; cv=none; b=sUWYbv/oHwwGKDrVl8aji+0QC4wXJu5pIMf9vlhEKFjU/cb6tWzoxrdCYpkuLvni95VFHYcS8q6nk2+GsmqLFDqi2RocdvVte9/mnm6/He4EXYllQostsFPM2f2ZGviXBAzzPcCC+0X1m7Pr1DTmteHoIE0vaGdk+uL/wSsSs0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736563441; c=relaxed/simple;
	bh=KdguJoAGlfTk3pS4ORLjgKmtYV/mysEHm7IJfiv9zUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrMD4gVwdqN8wA9FidUkEAoZ167uqXZC0B+Tp7wl9DOZridamwPL7+acl5SXLRGGd4FA0GE39HD7xfwk/GHAtngejaCEHoQ3g75/mX49USgIX8bleqEAjmRkZ+X48bhgkoQFglgHM2ahGtY6SvKShVwAJ3HAzuE3ayFyQw2ZlbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkK7wju8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A71C4CED6;
	Sat, 11 Jan 2025 02:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736563441;
	bh=KdguJoAGlfTk3pS4ORLjgKmtYV/mysEHm7IJfiv9zUk=;
	h=From:To:Cc:Subject:Date:From;
	b=IkK7wju8vLuVsGcgceRKbGQ8RIFFQC1d9/46xpz0puDoEv9GwV0cX2KCtUewla3UT
	 rxSH2DKdUjgtr7o41q0cg/A+iuY3yKS6Fe+N4B3my+WOyIjX/O1oiGH2QSa2xAgufy
	 MJzElNW5NTgOiJ0wNMALxHJTQjd9DvoXslLohR3siHJANdIEUcYotYVbESQ28t58i5
	 MIrch7sOGIEE3JAwuS2zM74leWAWN5uliiyQZxTAoJAFXxEyWOeskqf/7yfX9/FNE5
	 ays+KHIcvDh6D/hAvsIf3BuE0uPn6AUDWftPbWFcHdH+rmdBPQS1ql6LB8Lz+XeSCN
	 VRoSSRnSj+RXg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/2] docs: netdev: document requirements for Supported status
Date: Fri, 10 Jan 2025 18:43:56 -0800
Message-ID: <20250111024359.3678956-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As announced back in April, require running upstream tests
to maintain Supported status for NIC drivers:

  https://lore.kernel.org/20240425114200.3effe773@kernel.org

Multiple vendors have been "working on it" for months.
Let's make it official.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: spell
v1: https://lore.kernel.org/20250110005223.3213487-1-kuba@kernel.org
---
 Documentation/process/maintainer-netdev.rst | 46 +++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 1ae71e31591c..e497729525d5 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -470,6 +470,52 @@ in a way which would break what would normally be considered uAPI.
 new ``netdevsim`` features must be accompanied by selftests under
 ``tools/testing/selftests/``.
 
+Supported status for drivers
+----------------------------
+
+.. note: The following requirements apply only to Ethernet NIC drivers.
+
+Netdev defines additional requirements for drivers which want to acquire
+the ``Supported`` status in the MAINTAINERS file. ``Supported`` drivers must
+be running all upstream driver tests and reporting the results twice a day.
+Drivers which do not comply with this requirement should use the ``Maintained``
+status. There is currently no difference in how ``Supported`` and ``Maintained``
+drivers are treated upstream.
+
+The exact rules a driver must follow to acquire the ``Supported`` status:
+
+1. Must run all tests under ``drivers/net`` and ``drivers/net/hw`` targets
+   of Linux selftests. Running and reporting private / internal tests is
+   also welcome, but upstream tests are a must.
+
+2. The minimum run frequency is once every 12 hours. Must test the
+   designated branch from the selected branch feed. Note that branches
+   are auto-constructed and exposed to intentional malicious patch posting,
+   so the test systems must be isolated.
+
+3. Drivers supporting multiple generations of devices must test at
+   least one device from each generation. A testbed manifest (exact
+   format TBD) should describe the device models tested.
+
+4. The tests must run reliably, if multiple branches are skipped or tests
+   are failing due to execution environment problems the ``Supported``
+   status will be withdrawn.
+
+5. Test failures due to bugs either in the driver or the test itself,
+   or lack of support for the feature the test is targgeting are
+   *not* a basis for losing the ``Supported`` status.
+
+netdev CI will maintain an official page of supported devices, listing their
+recent test results.
+
+The driver maintainer may arrange for someone else to run the test,
+there is no requirement for the person listed as maintainer (or their
+employer) to be responsible for running the tests. Collaboration between
+vendors, hosting GH CI, other repos under linux-netdev, etc. is most welcome.
+
+See https://github.com/linux-netdev/nipa/wiki for more information about
+netdev CI. Feel free to reach out to maintainers or the list with any questions.
+
 Reviewer guidance
 -----------------
 
-- 
2.47.1


