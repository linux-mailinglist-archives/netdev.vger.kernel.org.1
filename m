Return-Path: <netdev+bounces-160071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FDCA18047
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC4B3ABD68
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F371F4717;
	Tue, 21 Jan 2025 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="qhKlXX6F"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE531F4295
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470693; cv=none; b=NfzX6S95dP8kBsZVpdaIixZanR4qObKGSuJDUh2vkuqUrFAWbMMDjxScIJNFapkTZzKepQOi7WoxbXAu8BCCGX7G6nQxAcWMxoDVb+R2LJUmucm0arNvQR66Ox75drorW/TEUD7eosoC83s1anEyZhDyEkZZIZD/UCXMJMmmkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470693; c=relaxed/simple;
	bh=yNTnDaq+a4v0/CMaV71dCWSKTCKpb0EegqkdF7lsFG4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XxswXDgMx/37PED5RwB4EpTeGtusDMm35FnRIJ78gPwqEThtWramrRIfuLCcOq733V5l3gyGWA33JxLDwG+5izQZ+QXGjvXr6vkqg7JJlybk8oBB2Op1E+YJjEzvScU8Eon8hgKOcrs3Bb672Cl70p3n3SQ2NK2y3mNkxB14x4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=qhKlXX6F; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1taFUi-0014iT-EL; Tue, 21 Jan 2025 15:44:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=qJnB7DfrmyizvWumI5+Wxlw9BvOaaBydwRoPixjthXk=
	; b=qhKlXX6FmlJCBeuXFxrfjZkkmldHYoPKhzStPERXYm+ArIy6jBohaBrk87e4M7jXZlpFqfsjA
	c4e4jpyBVH2yx4msSzRVyfiHcD/pfsjo05+jlTjUu6WHmWnFv4rpb/1IRjsgBWoD6jVZHcEIYYgME
	dlnbA32FKMm11eBIaziR3CClZ6zEpmdcACwvEnuU8pTRvdDEELvprP4ctfoA9Jzwalga503p288XL
	e85DKB5Ap0mnmyqB5sP/6wJHtu2i6A4mTk/yKza2EwByZ8/1G6nDiHAg78G1J8yaBtQ/GFDm4eKCE
	NOI0BwqarGXNhHNUNDm1iTByNSLX6aIuouITYg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1taFUh-0007M3-P3; Tue, 21 Jan 2025 15:44:44 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1taFUP-00AHot-Rk; Tue, 21 Jan 2025 15:44:25 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v2 0/6] vsock: Transport reassignment and error
 handling issues
Date: Tue, 21 Jan 2025 15:44:01 +0100
Message-Id: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALGyj2cC/32NwQrCMBBEf6Xs2ZUk2lY9+R/SQ5qkdhGSsomhU
 vrvhuDZwxzeDLzZIDomF+HWbMAuU6TgC6hDA2bW/umQbGFQQrVCyg5zDOaFibWPS+BUGPU7hZG
 8RWX1+TpJ22qhoRgWdhOt1f4A7xIMpZwppsCf+phlnX7y/q88SxRoLkKVnPpO2TuPYT2aAMO+7
 1+l6JDsyQAAAA==
X-Change-ID: 20250116-vsock-transport-vs-autobind-2da49f1d5a0a
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>, 
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Series deals with two issues:
- socket reference count imbalance due to an unforgiving transport release
  (triggered by transport reassignment);
- unintentional API feature, a failing connect() making the socket
  impossible to use for any subsequent connect() attempts.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Introduce vsock_connect_fd(), simplify the tests, stick to SOCK_STREAM,
  collect Reviewed-by (Stefano)
- Link to v1: https://lore.kernel.org/r/20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co

---
Michal Luczaj (6):
      vsock: Keep the binding until socket destruction
      vsock: Allow retrying on connect() failure
      vsock/test: Introduce vsock_bind()
      vsock/test: Introduce vsock_connect_fd()
      vsock/test: Add test for UAF due to socket unbinding
      vsock/test: Add test for connect() retries

 net/vmw_vsock/af_vsock.c         |  13 ++++-
 tools/testing/vsock/util.c       |  87 +++++++++++-----------------
 tools/testing/vsock/util.h       |   2 +
 tools/testing/vsock/vsock_test.c | 122 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 152 insertions(+), 72 deletions(-)
---
base-commit: d640627663bfe7d8963c7615316d7d4ef60f3b0b
change-id: 20250116-vsock-transport-vs-autobind-2da49f1d5a0a

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


