Return-Path: <netdev+bounces-153294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60DD9F78E6
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E411169970
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4B9222560;
	Thu, 19 Dec 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="LxwRIqNt"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043F221D86
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601790; cv=none; b=aaivmmKX6ET9GmaBLJ3iuh14nfxzKlw1Kife1l0/PM57z/Z77g5zyID2bSIjiXnJ1C8DYaF7tj+MMr9qpIFEBXISz7vVNeEs6bPEyZjVJ8RW/ANqEpPbHJPEp+mq0j2JHvqJH5GCG4teemnWQNvflvoMCodT7LWmEjmJgrbeHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601790; c=relaxed/simple;
	bh=RpbK11SwustFH4S+egEzkBqtrakqXTI7Z2gkeZmrd0M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JBHmlsUt6isPXXdDc2tTih2ghoUO5dNCZKthiEzDvJpe38cF5dQjHvH2w3PmUGTbQBn6wVbzbGLQzagAXhwQxfxIcWzgI428T0juvecii6gXgcc83xK9EFRvAvtSmqzntBd6O1Tj/jYkSh/PHSxSxznO+Jvb15mf8SCrkk4WZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=LxwRIqNt; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tODA7-007NpI-Qk
	for netdev@vger.kernel.org; Thu, 19 Dec 2024 10:49:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=ZubUsPhjEAWadbBhImH/a/z4WARiu4udq6bZ83CYzzk=
	; b=LxwRIqNtttKP59BMT/Ap1pKoKlFBlmP/+LH1UvC9m5tvR39JR16bW5GL57OTaaPlSi9KrWp69
	9i7HLocBqeAfleF2+t0S8uQ71z6G9e8SHMyTMgCgsj+3hl14qmbE9UBgCutorveU3oJvnoWw6NRfX
	JAN+147npOH/tbVl/FTeiz5CujgUftsaTjWVCt1UGGPPoG9mN4+RLaVsm0BpqPgwzfOxDa8p/duPP
	Pg/6D+zExBFj1PqEWj5CdwUK0GUUXxx0wBbGHSBBDyV6czlBFrYmIwgh4x34Zps3ShzDucX++CH3l
	gO0BZUd6plnOsHzpOTHeLbCOuipqwXpefNEObw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tODA7-0004r4-G0; Thu, 19 Dec 2024 10:49:43 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tODA3-00BSZD-6W; Thu, 19 Dec 2024 10:49:39 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net-next v4 0/7] vsock/test: Tests for memory leaks
Date: Thu, 19 Dec 2024 10:49:27 +0100
Message-Id: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACfsY2cC/23NTQrCMBCG4auUrI3kt01ceQ9xUdOJDZVGkhAqp
 Xc3FMGKXX4MzzszihAcRHSqZhQgu+j8WIY4VMj07XgH7LqyESNMUEY4ThATztGbAT+gHSLmymo
 ptZU1r1FhzwDWTWvygkZIeIQpoWu59C4mH17rr0zX+ydb/2czxQQbTkEZ1chGN+dw89PR+DWV2
 YbTPc4KlxKoILIRzJpfzrdc7XBeuKWt6AxYzZj68mVZ3nysh/s2AQAA
X-Change-ID: 20241203-test-vsock-leaks-38f9559f5636
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

Series adds tests for recently fixed memory leaks[1]:

commit d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory leak")
commit fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak")
commit 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error handling")

Patch 1 is a non-functional preparatory cleanup.
Patch 2 is a test suite extension for picking specific tests.
Patch 3 explains the need of kmemleak scans.
Patch 4 adapts utility functions to handle MSG_ZEROCOPY.
Patches 5-6-7 add the tests.

NOTE: Test in the last patch ("vsock/test: Add test for MSG_ZEROCOPY
completion memory leak") may stop working even before this series is
merged. See changes proposed in [2]. The failslab variant would be
unaffected.

[1] https://lore.kernel.org/netdev/20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co/
[2] https://lore.kernel.org/netdev/CANn89i+oL+qoPmbbGvE_RT3_3OWgeck7cCPcTafeehKrQZ8kyw@mail.gmail.com/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v4, nothing functional:
- Fix typo and cover letter
- Collect R-b (Stefano)
- Link to v3: https://lore.kernel.org/r/20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co

Changes in v3:
- Allow for multiple tests selection (Stefano)
- Generalize CONTINUE/DONE control messages (Stefano)
- Collect R-b (Stefano)
- Link to v2: https://lore.kernel.org/r/20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co

Changes in v2:
- Introduce a vsock_test option to run a single test
- ZC completion test: rewrite, comment, describe failslab approach (Stefano)
- accept_queue test: rewrite, comment (Stefano)
- Annotate functions and commits about the need of kmemleak (Stefano)
- Add README section about kmemleak (Stefano)
- Collect R-b (Luigi, Stefano)
- Link to v1: https://lore.kernel.org/r/20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co

---
Michal Luczaj (7):
      vsock/test: Use NSEC_PER_SEC
      vsock/test: Introduce option to select tests
      vsock/test: Add README blurb about kmemleak usage
      vsock/test: Adapt send_byte()/recv_byte() to handle MSG_ZEROCOPY
      vsock/test: Add test for accept_queue memory leak
      vsock/test: Add test for sk_error_queue memory leak
      vsock/test: Add test for MSG_ZEROCOPY completion memory leak

 tools/testing/vsock/README       |  15 +++
 tools/testing/vsock/util.c       |  33 ++++-
 tools/testing/vsock/util.h       |   2 +
 tools/testing/vsock/vsock_test.c | 265 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 309 insertions(+), 6 deletions(-)
---
base-commit: 2c2b61d2138f472e50b5531ec0cb4a1485837e21
change-id: 20241203-test-vsock-leaks-38f9559f5636

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


