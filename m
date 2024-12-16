Return-Path: <netdev+bounces-152173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D809F2FF9
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C151884943
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD82320468A;
	Mon, 16 Dec 2024 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="j+dbecKp"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD90145A11
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350486; cv=none; b=fg1KACWqJqCbkpcavfnhMOz31vXu+Ou5zPUqZrxbj9L6APokZ+u7m3t75Lv/Jj6TOXwGfTejQqpoVAzllHFmrOYiWXf5bbgjgDjlpY/fipnxv5m/jSmOJt4G95UNSBA2B+jvRucMdgOPwM5bK32/hIbFlMOl/zzid5NsaLs+Spo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350486; c=relaxed/simple;
	bh=sNV9Y3VGeVgFDgfIlWqqehwU0YXoyxqjgso3GkkCEGs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JCMeksYIeF+HHqiL7aPAJUi4y2rfbXTJHKjMm66O/PVGw/QwVic4lH8aUFwmraPjBkiM5zLt7QQcs8SxDZYJDnJAp49rbzGZ12P1sAjBs2nxDer0Xfi00nUYX/qBvFLEv14pv733HVNmuHIeKGikneoIzw6J3F58+mzqveCFFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=j+dbecKp; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tN9mp-00Fljj-8V; Mon, 16 Dec 2024 13:01:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=kHwI018f2tp0JKSQ7BtXODdqIZnKVYb9OOshWYhwUCs=
	; b=j+dbecKpfD3pdRIdWwaGHwsggGMSCZXevr72eFP6d0DcZ5XRfJ7Fyhy3hSpUV9QaC79tU14l7
	WpGrB2WegruiHZL3Fz69XXeO5fR9f1XfXolVHoVA6acEAVbqY9jquZLRAEJQz6vA+TlR69WsKqhRs
	qg5u9ROj4rD4gIrSMcSzZrpg2Pa3WLxWn5q1CKfjQqf4McpHgFEnW+EvSeMuKFgYOCe01MqjZkeCz
	z3CYFl092V6VSAL0GXN+E5T3F/GAaNbI4hPXxU/niCK3z7tigOV2lHLyVvfzXJ9Z1q8Q4F28yjELk
	yEXr71vDF7w5AEf2NDRNCpdhpdKUKq7C5HUEiQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tN9mo-0007oN-SS; Mon, 16 Dec 2024 13:01:19 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tN9mj-00DDDe-7C; Mon, 16 Dec 2024 13:01:13 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net-next v2 0/6] vsock/test: Tests for memory leaks
Date: Mon, 16 Dec 2024 13:00:56 +0100
Message-Id: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHgWYGcC/2WNywrCMBBFf6XM2pEmMX248j+kixqnNlSSkgmhU
 vLvhuLO5eFwz92BKVhiuFY7BEqWrXcF5KkCM4/uRWifhUHW8iJkrTASR0zszYJvGhdG1U291v2
 kG9VAma2BJrsdyTs4iuhoizAUM1uOPnyOryQO/8s2/9kksEajBHWma3Xbt7fw8NvZeBhyzl8+3
 VJRuAAAAA==
X-Change-ID: 20241203-test-vsock-leaks-38f9559f5636
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

Series adds tests for recently fixed memory leaks[1]:

commit d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory leak")
commit fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak")
commit 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error handling")

Patch 1/6 is a non-functional preparatory cleanup.
Patch 2/6 is a test suite extension that I try to smuggle in, but is
unrelated to the tests and can be safely dropped.
Patch 3/6 explains the need of kmemleak scans.
Patches 4-5-6 add the tests.

[1]: https://lore.kernel.org/netdev/20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Introduce a vsock_test option to run a single test
- ZC completion test: rewrite, comment, describe failslab approach (Stefano)
- accept_queue test: rewrite, comment (Stefano)
- Annotate functions and commits about the need of kmemleak (Stefano)
- Add README section about kmemleak (Stefano)
- Collect R-b (Luigi, Stefano)
- Link to v1: https://lore.kernel.org/r/20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co

---
Michal Luczaj (6):
      vsock/test: Use NSEC_PER_SEC
      vsock/test: Introduce option to run a single test
      vsock/test: Add README blurb about kmemleak usage
      vsock/test: Add test for accept_queue memory leak
      vsock/test: Add test for sk_error_queue memory leak
      vsock/test: Add test for MSG_ZEROCOPY completion memory leak

 tools/testing/vsock/README       |  15 +++
 tools/testing/vsock/util.c       |  20 ++-
 tools/testing/vsock/util.h       |   2 +
 tools/testing/vsock/vsock_test.c | 263 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 296 insertions(+), 4 deletions(-)
---
base-commit: 2c2b61d2138f472e50b5531ec0cb4a1485837e21
change-id: 20241203-test-vsock-leaks-38f9559f5636

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


