Return-Path: <netdev+bounces-156905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66517A0842E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 01:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933793A9E01
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E590C27450;
	Fri, 10 Jan 2025 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2TxFWtV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7BBEEB5
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736470352; cv=none; b=Kr/OY7lzqSVzX9FnjCeaiBDjihNTBLRcyTm5Xhb3VGZyHBcDXKYfA9bkZN1TexsdzvH5HgsdI9P8+vrJl8hR15Si7fa9/vb1SzkEmi6hAf61sOfo48T83mNI75Ndf/3pnx9/sy+8XVfV6s7cCk4HW5TlHJhK96aXAG/Wls0MoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736470352; c=relaxed/simple;
	bh=RuWfNOKXpF+KwOOTGYxL4xnTb01+cuA9I1iSJN/fk8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kaQOZX/uDbbdjQBgxmc1wpWbmkKUAD54JtjYPzOEeyzDCNj96VJ3fu454fMhuPdkp1u8Dpp57BxEWcN/4NS7+u6KJQWLtvVpUfbBYwZqOcSpNwDb67lvTywzZdASMhsloHKdRIfJqdTOWxtR6+DMQYZzZPGqyxDk+I/ZwqGFiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2TxFWtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1F8C4CED2;
	Fri, 10 Jan 2025 00:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736470352;
	bh=RuWfNOKXpF+KwOOTGYxL4xnTb01+cuA9I1iSJN/fk8g=;
	h=From:To:Cc:Subject:Date:From;
	b=F2TxFWtVDmOXD0jF4+6jUEo4NqJpgZfpDx+4rED4taRq/QX5Nru04VetOUjcYEd3D
	 xF135F1ZpzUFD1iTgxpl4u7p8lcp2hEgCsuq8r/Y1MJGj3zNX+qgnnkKLgMZ7LtpZt
	 U7J85jmvRhKqNYkKhehC1ja1gZlFLS1rF/WDXSwvCyS/DyxmOSzy7m3BxzCch8+2Vc
	 h0EER8vc+6I7ySMKe1mh0A3DGHd0OLtyD4VKV03dHjCZfOIBwzyCHr/T5jNNBQtTVs
	 7MsSFywhKyI1RLJIg+KKSXlPHYqMKp5yt7hPO+MK2wMPQ57J126q4TheGD9/DdM0VX
	 ZtcFbpTzBt1vQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] docs: netdev: document requirements for Supported status
Date: Thu,  9 Jan 2025 16:52:19 -0800
Message-ID: <20250110005223.3213487-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/process/maintainer-netdev.rst | 46 +++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 1ae71e31591c..72d8d31b8485 100644
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
+vendors, hosting GH CI, other repos under linux-netdev, etc. are most welcome.
+
+See https://github.com/linux-netdev/nipa/wiki for more infromation about
+netdev CI. Feel free to reach out to maintainers or the list with any questions.
+
 Reviewer guidance
 -----------------
 
-- 
2.47.1


