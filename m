Return-Path: <netdev+bounces-162315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1953FA26893
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100F73A607D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D926F2F2;
	Tue,  4 Feb 2025 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="k07ffh2u"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A0288DA
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738629047; cv=none; b=Q/2kM8FEnG5A1leURBJHZSxoTEvM64cVAPNfA7fxjmCidl4OI5o9OWVL69XCCTS5ZD2KAH33idgEZl5S3TiHf4wlt2B2QhbCuN0JzI0ojP0IcnrJ8Awt1sb7m+lcuN6PNbuc3GaPKn1un7lH0/NJ9mVE2ZE9AzGwx9ppcUccFNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738629047; c=relaxed/simple;
	bh=CuIl7I2t0fGfMMd6kSjwkoXS5Tu1ycO7OH/IQ1EUdfU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N4yZd8GEdkhGAaW/ZOTxIkO799pScMxd6AAP/9BZwkOILroFssXSQHO653yvz9G8ydIyNySo7gkoQPsRDvpjkiiU8mtF8DH3i/ZcQ4IwGP6LBfT0jwkbcnxBsoyr+JrG3Y0HuOP6wcrfk/EazAe9HRX0fJYke3H0OtFvP0/A8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=k07ffh2u; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tf6po-003AWm-QZ; Tue, 04 Feb 2025 01:30:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=WpNwp/TaoFlYIowmpVf9fwRABgYTYg7N3X4s+5U6JFE=
	; b=k07ffh2uclBLk2Vp7clJ6H9uF5pRLUWsstTNqaZsIvIjdMy/bYTKj/ZynfjSqqIlrdBkVeubM
	C4WDAEzq154lHItguhXC7rqfxTlzirpYrFqKVyOOWG8r0/OoS1MAruGUycZeKoZoMTPLQhcitx3p2
	X937NQfd2CRrIR0viyOy62a6Pb+eLF8C1GmF0S6ma1C2AwLwCe8J6wZ4vsdKhRpQypYeabGzqa/Wq
	kS39Vk3pdTh2iO1+JhfZseUfcTszlzRncfFhZgkgFZUEPkdxua0dPhUJHYXd9FQyT+NR3iLSfMxb0
	aCnziXA1VpwMn2vCsj6we7XXKXIZaEzfleJ0HQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tf6po-000847-1x; Tue, 04 Feb 2025 01:30:36 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tf6pX-006aWc-IG; Tue, 04 Feb 2025 01:30:19 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net 0/2] vsock: null-ptr-deref when SO_LINGER enabled
Date: Tue, 04 Feb 2025 01:29:51 +0100
Message-Id: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH9foWcC/x2MSwqAMAwFryJZG4j1s/Aq4kLbqMFSpVURxLsbX
 M4b3jyQOAonaLMHIl+SZAsKRZ6BXYYwM4pTBkOmJkMlXmmzK3pRFTGc3juOPKEduarIDK6kBvS
 86yj3H+4g8AH9+3458UksbQAAAA==
X-Change-ID: 20250203-vsock-linger-nullderef-cbe4402ad306
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2

syzbot pointed out that a recent patching of a use-after-free introduced a
null-ptr-deref. This series fixes the problem and adds a test.

Fixes fcdd2242c023 ("vsock: Keep the binding until socket destruction").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (2):
      vsock: Orphan socket after transport release
      vsock/test: Add test for SO_LINGER null ptr deref

 net/vmw_vsock/af_vsock.c         |  3 ++-
 tools/testing/vsock/vsock_test.c | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)
---
base-commit: 0e6dc66b5c5fa186a9f96c66421af74212ebcf66
change-id: 20250203-vsock-linger-nullderef-cbe4402ad306

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


