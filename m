Return-Path: <netdev+bounces-149786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CD89E7828
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A9628344D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 18:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88A91D5CC1;
	Fri,  6 Dec 2024 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="oMQmg5tP"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E11D45F2
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510163; cv=none; b=MwvmNFzUOsofp4JnauJUM9dpqge2NTtxpxgtD7WFxL0Wm25ZTTJIGt56c6lzlVZ3jT7pIKL6czsaJU9spZQwgTirLPOVm1VlKs6nA4iIeqeg0dVdxcprsO+IQs+LkkNka0IqkeNqL7s7NUoC+3L4ANi6ILxNlqftMO2Q4bo0qes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510163; c=relaxed/simple;
	bh=tyKisxqBAb563Isl8LLOvajWbb+u3mG4SSp/ELJ+qtY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qHd2UJSEOWn1f5iB96Qx0vJC4exirONB0yQT/YQF77Il9ANgg8Rmqwm9jlJS7Yg3akRZJkcS+VBHlFVWxyqRWhK7ZMA73PLCgPqyGNuUQf70XLN0DWOHxB1Y3NGgg6osTKiwwO2u4i0Z6MS5TWCrbDHKWCaVD9JIK95//44ran8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=oMQmg5tP; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tJdB8-004RMe-Md
	for netdev@vger.kernel.org; Fri, 06 Dec 2024 19:35:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=t/+8WnLSAvJNH/PwD2jMJfy8OEHgybPxnjHfzY+9bVs=
	; b=oMQmg5tP31CJVZkI3k6A/1CTIYrJk1gsXTDz8e1vShrI5tFI/lvBTsngAseKXsG2MG9+c62Fj
	rmkfKARBLPBscP7vWIuMybCfXvEGpSPya/noqFJ4+vSl/flFREUfKBNJT0jRB/c2FcjTxkQgQ32Hs
	PHoipWLvhxSbO9jQKE4f5GS+JyJaL5rwekeJ/uJKdhtYNZidohotoEVw8a1dnWsk++hnn8FL2vsJ2
	kV7yhYTrz+oIRaseOsOIYUz2BOOOd2qsLjfaUDoUJX1k+vtnbBLRzHP/4VeEQkhNr2SfY7mMmV0QI
	c9xyj0b9gJK9WyYqpedYwX2jP7mjXSGpwI7Jeg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tJdB8-00073N-B8; Fri, 06 Dec 2024 19:35:50 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tJdAo-007yMC-KU; Fri, 06 Dec 2024 19:35:30 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net-next 0/4] vsock/test: Tests for memory leaks
Date: Fri, 06 Dec 2024 19:34:50 +0100
Message-Id: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpDU2cC/x3MQQqDMBBG4avIrDsQEyO1VykuRP/oYIklE0QI3
 r2hy2/xXiFFEii9mkIJp6gcsaJ9NDRvU1zBslSTNbZrrXGcoZlPPeadP5h2ZfcMg/dD8L3rqWb
 fhCDXf/mmiMwRV6bxvn9zIUFIbAAAAA==
X-Change-ID: 20241203-test-vsock-leaks-38f9559f5636
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Series adds tests for recently fixed memory leaks[1]:

d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory leak")
fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak")
60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error handling")

First patch is a non-functional preparatory cleanup.

I initially considered triggering (and parsing) a kmemleak scan after each
test, but ultimately concluded that the slowdown and the required
privileges would be too much.

[1]: https://lore.kernel.org/netdev/20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (4):
      vsock/test: Use NSEC_PER_SEC
      vsock/test: Add test for accept_queue memory leak
      vsock/test: Add test for sk_error_queue memory leak
      vsock/test: Add test for MSG_ZEROCOPY completion memory leak

 tools/testing/vsock/vsock_test.c | 159 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 2 deletions(-)
---
base-commit: 51db5c8943001186be0b5b02456e7d03b3be1f12
change-id: 20241203-test-vsock-leaks-38f9559f5636

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


