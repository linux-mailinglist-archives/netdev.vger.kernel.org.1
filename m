Return-Path: <netdev+bounces-222704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6251B5577B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F113AE288
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD8C2BF005;
	Fri, 12 Sep 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGlyMGd1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5AF29AB12
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708079; cv=none; b=kW2lNN2+i/gbmGZKR0WNr4YTPz1oKAoCl7K2q5SQmAsz3IxYMGxzqBf2KrmpsfjQS+gONjOtChv3lb2w1gwhtxG6jYe6ag05kCEf6znypqVtlbMMKv3Arcqxbsm262ObpcEMK1sxDjP0SN46cel5z7SeSgeTuWpXFtYC2KdI14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708079; c=relaxed/simple;
	bh=qoG3YG64mjOqFh9nOrtxiOxtOG6lGJfBHY28ySpsDf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jYPmGB89eUP2GX+KFSAID6WbcSAIYek8qPYKw0W2zkX6/wbU5n8HaE2g40J+COkENsUjenVVZM8YtKrH2BHhBqUE+BVQ27W1v7vZ47gnUQ9yhxpMrI9+Lz107cKq/9S7hvmDEoLs1wo33/YAXxg5/qn6HJsapvUKoTxjo+pr9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGlyMGd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95487C4CEF1;
	Fri, 12 Sep 2025 20:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757708078;
	bh=qoG3YG64mjOqFh9nOrtxiOxtOG6lGJfBHY28ySpsDf8=;
	h=From:To:Cc:Subject:Date:From;
	b=vGlyMGd10zaj/7XlOwjXzGokFa6QMO7OUHPpgt9C6vI+dUX7UiFK+cbeuVTR+g4bA
	 pMFZyREbl4du5Tk3tuTSAfO2bp0vVWgDa2vLsWv/E8uXORZeSp84btSAeQshvH6gfc
	 tHXIHVIo1+93E/6jU+IHrbZJZ04r9MtCDoi4kZzatNrCdMIYJWe0oxWslwrcuBEoZR
	 g6adGeZh4hvsjhYLmOJAJdgGPBgs9hPSBQQhdt7iUxAu8+xCd9QlpnpwCp1uGWVB1Z
	 2qF0ytDX7OUNHj8isPdUgl5w1nQ0QOPG/KSK/i5Wqq3pU52ijDkqcL3SRePi4OVT/S
	 yqryT/mpJjm9g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/9] eth: fbnic: add devlink health support for FW crashes and OTP mem corruptions
Date: Fri, 12 Sep 2025 13:14:19 -0700
Message-ID: <20250912201428.566190-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for FW crash detection and a corresponding delink health
reporter. Add a reporter for checking OTP memory health.

The output is not particularly exciting:

  # devlink  health show
  pci/0000:01:00.0:
    reporter fw
      state healthy error 0 recover 0 auto_dump true
    reporter otp
      state healthy error 0 recover 0 auto_dump true
  # devlink health diagnose pci/0000:01:00.0 reporter fw
   FW uptime: 0
  # devlink health dump show pci/0000:01:00.0 reporter fw
   FW coredump:
      5a 45 01 00 04 00 06 00 00 00 00 00 4d 01 00 d0 
      .. lots of hex follows ..
  # devlink health dump show pci/0000:01:00.0 reporter otp
   OTP:
     Status: 0 Data: 0 ECC: 0

Jakub Kicinski (9):
  eth: fbnic: make fbnic_fw_log_write() parameter const
  eth: fbnic: use fw uptime to detect fw crashes
  eth: fbnic: factor out clearing the action TCAM
  eth: fbnic: reprogram TCAMs after FW crash
  eth: fbnic: support allocating FW completions with extra space
  eth: fbnic: support FW communication for core dump
  eth: fbnic: add FW health reporter
  eth: fbnic: report FW uptime in health diagnose
  eth: fbnic: add OTP health reporter

 .../device_drivers/ethernet/meta/fbnic.rst    |  19 ++
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  13 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  18 ++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  46 ++++
 .../net/ethernet/meta/fbnic/fbnic_fw_log.h    |   2 +-
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 235 +++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 239 +++++++++++++++++-
 .../net/ethernet/meta/fbnic/fbnic_fw_log.c    |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  39 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  57 +++--
 10 files changed, 642 insertions(+), 28 deletions(-)

-- 
2.51.0


