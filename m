Return-Path: <netdev+bounces-203362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46ABAF59AC
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163C24E6107
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB60289824;
	Wed,  2 Jul 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="XQ/KeHj+"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811DD28936F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463536; cv=none; b=fY5ikVuCPRf4aagROjA6qpTtY3LazbTVC3UYm7Yn9MxJJF/EX04qXhYeNEtSyUhBYeUMKETVugAKNc2uHHsXNfjU0Eo0BEvDYZxZf/pYKMxfLAd035lwrINrgQwKC1vBnY6sKTtJY6VbROEV8hS642lN0Htyw5rMt7zZg5PzU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463536; c=relaxed/simple;
	bh=jdFrNC6NiwknkJyl69b6rDUa9Yoz8gcCJi1eybxIXcc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cw/7Jvrv/J9l2P0iTkMUwxgx/Ziw6GeMMbyNnjpW/HlCiJHgUhufemgUTk2ztRxtxOOkvBtXN0ML4hnTCNyvEn1eFFaJlSQvDvFgVD9VlASgjajxdPL8fbJOsIMYS1MOUOXJn9MhEw/ZbfymlaIzqz51fAn4KqIoqrDDjyyKmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=XQ/KeHj+; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfo-00GxRl-KK; Wed, 02 Jul 2025 15:38:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=6ZRtUO3nIsi2U4OeyB53Qpuv1fm+SVSeTb2FbQzXyDI=
	; b=XQ/KeHj+hAsqPPd4QOSYrC3UmojqOdFrkrbQ+Nj1d52YZJequSvlSHitllhkS2LRquDzCK5LQ
	D2bhYa+hQ/PusniCmJPRCNHJ41BmjhQQlWPoElAMxA3sGaEnPtFtkSHx46x5YsBPyYcPb5fWJLgqO
	UNkr48pO2+/tLGlcVYMleFCWLCy3TiytANrILB83kdtr2gxaId5b38oorz2znYDfG87vuq6PcVY10
	nfO39erBpskye2lcvsmpZTcCN6v5i9GY3Y/uARNmR8dwHCALuPBZLo/IggyvmfZA2bhg1aQfrU9wz
	yiWZAdgdn9qOFsuO1ACvbbZhSi1Ct5WyiyWQig==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfo-0005HR-1s; Wed, 02 Jul 2025 15:38:52 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWxfl-009LQl-Jp; Wed, 02 Jul 2025 15:38:49 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v3 0/3] vsock: Fix transport_{h2g,g2h,dgram,local}
 TOCTOU issues
Date: Wed, 02 Jul 2025 15:38:42 +0200
Message-Id: <20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGI2ZWgC/3XOwQ7CIAwG4FcxPYuBTnTz5HsYD4NWR0zGAkhml
 r27hItedvzb/F+7QOTgOMJlt0Dg7KLzYwnNfgd26McnC0clA0rUUmMjcvT2JVLoxzj5kKJI3ib
 /Fkdz1tRZ7FupobSnwA83V/kGIye4l+HgYvLhU69lVVcVPql2E85KSEGEhEzclR+uwfj5YH0VM
 /4pKLcVLIpENoTSKJLNT1nX9QtCDdMMBwEAAA==
X-Change-ID: 20250523-vsock-transports-toctou-4b75d9c2a805
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

transport_{h2g,g2h,dgram,local} may become NULL on vsock_core_unregister().
Make sure a poorly timed `rmmod transport` won't lead to a NULL/stale
pointer dereference.

Note that these oopses are pretty unlikely to happen in the wild. Splats
were collected after sprinkling kernel with mdelay()s.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v3:
- Static transport_* CID getter rename and comment [Stefano]
- Link to v2: https://lore.kernel.org/r/20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co

Changes in v2:
- Introduce a helper function to get local CIDs safely [Stefano]
- Rename goto label to indicate an error path, explain why releasing
  vsock_register_mutex after try_module_get() is safe [Stefano]
- Link to v1: https://lore.kernel.org/r/20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co

---
Michal Luczaj (3):
      vsock: Fix transport_{g2h,h2g} TOCTOU
      vsock: Fix transport_* TOCTOU
      vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`

 net/vmw_vsock/af_vsock.c | 57 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 11 deletions(-)
---
base-commit: 561aa0e22b70a5e7246b73d62a824b3aef3fc375
change-id: 20250523-vsock-transports-toctou-4b75d9c2a805

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


