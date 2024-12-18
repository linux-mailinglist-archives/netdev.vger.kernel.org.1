Return-Path: <netdev+bounces-152988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B649F688C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A7116CCF3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98941D5CE5;
	Wed, 18 Dec 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="EIwY/ufz"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36D1B0405
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532392; cv=none; b=dsKY7QjOT8v7eZR+47A4ls1jI3KtFDq6ipBZe6/9VtCzKMPO/i2jW6mXPk2ygkmZMptgYwNz8JUBR+EqqNP/a+qXKuZUGPKA5axzb7eC0ACmEayGxu4CvqV8LA6y1ItB1jfFkQbEE+48Oyi5i5OMM8H7g/Rb0KeV+NRRa3jsMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532392; c=relaxed/simple;
	bh=SfbuOyDa8+ndQMh2V1UGoOXKxb3uoTRmJgOU+SyjCtg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mcVnG1vdUZK4svlDjzBYBCI+FBOKT0sX2Fkl3hUqiFeYVz61LY4Nni/DDDNb7Pn4/wqQAOTy3yP1y/uV2gRCx3M2QK6YUEHvXlbal0XSIf3Fy0992dQ6L12rQQ1CbMgVVi6L20UNFoI/6mFkO9A4QrqrtoX7l2Q2yWpgjVhpZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=EIwY/ufz; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tNv6p-004s1R-VC
	for netdev@vger.kernel.org; Wed, 18 Dec 2024 15:33:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=lmnlWo2hPLs1HhL+gB5ZaOYhkc5GpETrDblCeltmDQA=
	; b=EIwY/ufzo7JfzyHbXXMLFjhL+D7mk12XApMFUYKsPJOd7NeebPb6A501j5+sbLGaXcRkEAavg
	J+b79NGO6+O3pI/cthoAFbOlOsrazzfV0TEvt4pqg6ocBfWdLmQHZBNTsMnyOz//O4LwFH7K3yKhO
	zXG4/6SMY9sw2Msks/rZHBXI++/hSddZEOnrXxfpmTTHXK2/NarMxERaS6DaQkJ06D00FzbNb45qW
	f+LU5Oep0yI9wgop4xxDT6jnSIQTYHgO1ATk+CvqV7nSlukN5ZZJacP1PZ9H9L5Q0l3c2tjTU7tvf
	RuncrksizdL+f/ZvjjQyV1NQsoQmjaLtrvjbsg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tNv6p-00070z-KB; Wed, 18 Dec 2024 15:33:07 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tNv6U-008Env-QF; Wed, 18 Dec 2024 15:32:46 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net-next v3 0/7] vsock/test: Tests for memory leaks
Date: Wed, 18 Dec 2024 15:32:33 +0100
Message-Id: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAHdYmcC/22NywrCMBQFf6Vk7ZU8mqZ15X+IixpvbKgkkoRQK
 f13QxAUdDkcZs5KIgaLkRyalQTMNlrvCohdQ/Q0uhuCvRYmnPKWcSogYUyQo9cz3HGcI4jeDFI
 ORnaiI0V7BDR2qckTcZjA4ZLIuSyTjcmHZ/3KrO7vbPebzQwoaMGw172SalDHcPHLXvuayvxLZ
 /90XnQpkbVUqpYb/dG3bXsB831Eg/cAAAA=
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
Patch 2/6 is a test suite extension for picking specific tests.
Patch 3/6 explains the need of kmemleak scans.
Patches 4-5-6 add the tests.

NOTE: Test in patch 6/6 ("vsock/test: Add test for MSG_ZEROCOPY completion
memory leak") may stop working even before this series is merged. See
changes proposed in [2]. The failslab variant would be unaffected.

[1] https://lore.kernel.org/netdev/20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co/
[2] https://lore.kernel.org/netdev/CANn89i+oL+qoPmbbGvE_RT3_3OWgeck7cCPcTafeehKrQZ8kyw@mail.gmail.com/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
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


