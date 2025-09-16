Return-Path: <netdev+bounces-223766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872B8B7CD25
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721953AB28C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E149F2EB5C4;
	Tue, 16 Sep 2025 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOyDszSD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC6298CC7
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064490; cv=none; b=X19HbevdDT8b8ehy/mksysZb1U43JIXKbChwODOl9jAsXQu6VxRPGaXtIXdhATEJENXqTOZnFfr3hVxHZl5QvlDT8rz99b8cQYOzl6OhcoFKOzGfzlLzQisR5ga9uZOcu0agXijkr/hRmhX/KrRrFfEuv3mqJdGETdZAL7qmIb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064490; c=relaxed/simple;
	bh=UzeLE9t6TJbNlA9ZxcaSnUI0XACZdEJ9qtc/UAIo6z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvOF5xSgy8rODU0hU49Er19+c1iBz6lmsMb8FQRHn7z9FtfcJKePpNsmzVQC3N+9K94Hln/dWyrmf6okbSZ+DkvU09pbmtnjpgCjwfRga0ADeDY9MvLM7APlTp5fkVQCTZxd3sEX8h8Ey2OL8j8j8EWJs7TAZ0SbYjo6X/A3W6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOyDszSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD0AC4CEEB;
	Tue, 16 Sep 2025 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758064490;
	bh=UzeLE9t6TJbNlA9ZxcaSnUI0XACZdEJ9qtc/UAIo6z0=;
	h=From:To:Cc:Subject:Date:From;
	b=EOyDszSDgoeSJwo85DguCh/73ek3LLx6kPKoP62fo0/Jyh3GDMAQc7uzTE2cBZR6v
	 0RYFRUdc+rr5Ip5eF35j23kGzgBqGLd4VDdfAVM8YaKDQawdaODdZUdWNs46vIL/Ve
	 hWgsf1384q0bnf1zNWy6xM1enHI03vYcnkNE3vxaRzyjCCfQb0WNdl/fmS4PU6fwxb
	 RcpNBHXq1fvmbvkN58oVhlGJfDU+3zB8cG3ULKMPtBOEkwPa+VCyian6iRpVVKk0NV
	 8kNmqJogd1m+SMUN3nHNAnDpM4xxNgQdKt2QfxhQ9ZlTMDrNfaY+avzi5GTL7fjKZi
	 Dr5T4Yfjlr2Ew==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	lee@trager.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 0/9] eth: fbnic: add devlink health support for FW crashes and OTP mem corruptions
Date: Tue, 16 Sep 2025 16:14:11 -0700
Message-ID: <20250916231420.1693955-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for FW crash detection and a corresponding devlink health
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

v3:
 - [patch 2] add parsing policies
 - [patch 7] use extack
 - [patch 8] split time in diagnose callback into sec and msec
 - [patch 8] don't report when netdevice is down
v2: https://lore.kernel.org/20250915155312.1083292-1-kuba@kernel.org
 - [patch 2] fix attr ID
 - [patch 2] comment and commit msg adjustments
v1: https://lore.kernel.org/20250912201428.566190-1-kuba@kernel.org

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
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  47 ++++
 .../net/ethernet/meta/fbnic/fbnic_fw_log.h    |   2 +-
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 249 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 241 ++++++++++++++++-
 .../net/ethernet/meta/fbnic/fbnic_fw_log.c    |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  39 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  57 ++--
 10 files changed, 659 insertions(+), 28 deletions(-)

-- 
2.51.0


