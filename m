Return-Path: <netdev+bounces-163286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F40C0A29D29
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E366168AD2
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464B021C172;
	Wed,  5 Feb 2025 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="X8sLA140"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78E215176
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796836; cv=none; b=mqyxa3TFvSxGSwNp9ZxgCkaoB4AoLE1zaxKCgEMTZXjWBPDcUwp5Cp2/sjK7jl2o13gd38W4HYlyAgFd7KTTpkvLAFJQ1Njq6s4k2CEGApuGNOt+xZhagv61RnBqatK96wv8n986TnGMixyve8NVNgHdcDah8MealbMFEzWmShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796836; c=relaxed/simple;
	bh=SK0VuvEbgc9wvDngzoRhhZzxbzZ3UpXOPAEBpYAF12s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=upqOUm9UgeS/9yqmyvl3GJHcCml6DuFcM/i/M1fXmmo57mnACCinv3w90FUnxVnvQx3FjoY5xaS5fK1Me4LvEj+PUQieV/mnc9Qg0S0bWsbawWrMi/K3i51OnbWIsxqt9Dthcy8zFchN98KB8sj/Ilo8M6/APen8mA2tcj0iPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=X8sLA140; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tfoU7-008fAu-Kt; Thu, 06 Feb 2025 00:07:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=WPnronCkJDxXRFUsE355gELKCTIvea2NYn+WpAEL2Qk=
	; b=X8sLA140V8m+K5MHMsem3O9VK/kYfqqcqFx0kJxj/FmDe/B9Cn7eYmC5A5Rt3jYDbhbhSRn1C
	3AeKSRC16oBeRoxVZEENYG4U7hbh3IgVaQLeHjuN+M8sDaSh6Ap+VidFqkDadChcnl/4IzBMO2zaL
	7Pdu4hYU/p2OFNU6kukEpdT2dVJstWxhNTOzYp4wtx25CSpa0OFc9pNKcdFG6WJb+1/t1ie7OuirI
	QHpwVO4xAywA+eLzJM1h80fKwW9mGjYs/VJBaf9igWM7Hnn+DsfAB5xFdKQZX1cP6Nlrl08NBS1w/
	ZqweuOp5Z4dmOo3FPbK1JhLt94qNQQXYVRCX9w==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tfoU6-0007La-LH; Thu, 06 Feb 2025 00:07:06 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tfoU5-009hRv-6A; Thu, 06 Feb 2025 00:07:05 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v2 0/2] vsock: null-ptr-deref when SO_LINGER enabled
Date: Thu, 06 Feb 2025 00:06:46 +0100
Message-Id: <20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAbvo2cC/3WNwQ6CMBBEf4Xs2TVLqRg9+R+GAy2LbCStabHBk
 P67DfHqcd5k3mwQOQhHuFYbBE4SxbsS1KECO/XuwShDyaBInUhRgyl6+8RZShXQved54MAjWsN
 ak+qHhloo41eBsu7iOzheoCtwkrj48NnPUr1XP6/+5001ErZs6nNLY39p+BaMX4/WQ5dz/gLeH
 ChwvwAAAA==
X-Change-ID: 20250203-vsock-linger-nullderef-cbe4402ad306
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

syzbot pointed out that a recent patching of a use-after-free introduced a
null-ptr-deref. This series fixes the problem and adds a test.

Stefano, regarding the test: I wasn't sure about the lingering behaviour,
so I've left that part for later.

Fixes fcdd2242c023 ("vsock: Keep the binding until socket destruction").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Collect tags [Luigi]
- Explain the reason for the explicit set_flag(SOCK_DEAD) [Stefano]
- Link to v1: https://lore.kernel.org/r/20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co

---
Michal Luczaj (2):
      vsock: Orphan socket after transport release
      vsock/test: Add test for SO_LINGER null ptr deref

 net/vmw_vsock/af_vsock.c         | 15 ++++++++++-----
 tools/testing/vsock/vsock_test.c | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 5 deletions(-)
---
base-commit: a1300691aed9ee852b0a9192e29e2bdc2411a7e6
change-id: 20250203-vsock-linger-nullderef-cbe4402ad306

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


