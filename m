Return-Path: <netdev+bounces-134943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF31999BA5C
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7371C20AF9
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BC51494AD;
	Sun, 13 Oct 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="rYsO3j+j"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5FC1487E1
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728836846; cv=none; b=o3VXno8rcuPSr/yhzSOoNTI3D5BVwJwuB1VXiCMAF8dIWWL31UU5PVr78xKNjOEZ0Ky3o1YJSR/Qceh7lLC2Da3874rmWbegPFZXA065Epb2OqhM9cF6VxDdwqnx9pkal2EFgkf/VKqitCkMklAH0Ov295jW4bUXN/7wITVqQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728836846; c=relaxed/simple;
	bh=olaOSyChHMbeG4W8B0G7QsCxdYh41Rc05My52eM0jII=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DmkqdgWlZxVMh1AHHK99VJZEYNoWanrkBycmauma6JwP2xgVjcwlUGp8GV2JQSKbWSdrhTpTpFTSb2h9LpWi75gpoZcbsZKLo2cSlTsg5EYJTie+hSO++q5hf8xPTIvyOZnhzhQJHs9zixuhKBGRcoJYFg6aZQMZtByVZ/1DhrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=rYsO3j+j; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1t01R3-00CydG-Ra; Sun, 13 Oct 2024 18:27:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=bFNL3E90nuaW+linBZtdt2yJ7cj3i+af7f35gE6PaLM=
	; b=rYsO3j+jy6b2ISGjwyrwpHtFpkSRZnvFFWf+Y7qcj6xjvR1fXyoByVrxXmv2VatOOyCmKg+lr
	qW87ZISqMtacqF97FFB3mTc3tPp/wtfhKwYjg2BZYFJEiJ6WfdbEKaESmSAFb2FYxwRHA0RJ4zOpc
	OT/wY0Tq2TVXt97tVhSbnEcgBK12w4O6kn+azkLFmWTcx4tW2Byl+uQMjUIIaVu9lEwdRido/7Czv
	v61f2shSKXPNysU6C7rx5J4E8T9aLnIDHIhgfyWzB9qWjLUJPOzIXUin3JlLYqT4JIrMYcv9Uc8mo
	Hjry7jDtky0vEI5/k9a1u7aTSrYFb1cOgNZViw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1t01R3-0007Hc-G2; Sun, 13 Oct 2024 18:27:13 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1t01Qf-00GV5b-H0; Sun, 13 Oct 2024 18:26:49 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v2 0/4] bpf, vsock: Fixes related to sockmap/sockhash
 redirection
Date: Sun, 13 Oct 2024 18:26:38 +0200
Message-Id: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL70C2cC/4WNTQqDMBCFryKz7pREYmK78h7FRY2TOhSMTEqwS
 O7e4AW6fD/fewckEqYE9+YAocyJ41pFe2nAL8/1Rchz1dCq1milbphT9G8MvFPCEAWFZhbsrVO
 ONPVeGajsJnRWKvqAaQswVnPh9InyPb+yPqM/s1mjQjJdZ7QNdnb9IFPcrz7CWEr5AaTpZ2y9A
 AAA
X-Change-ID: 20241009-vsock-fixes-for-redir-86707e1e8c04
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Series consists of few fixes for issues uncovered while working on a BPF
sockmap/sockhash redirection selftest.

The last patch is more of a RFC clean up attempt. Patch claims that there's
no functional change, but effectively it removes (never touched?) reference
to sock_map_unhash().

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Patch 2/4: Send a credit update [Stefano]
- Collect Reviewed-by
- Link to v1: https://lore.kernel.org/r/20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co

---
Michal Luczaj (4):
      bpf, sockmap: SK_DROP on attempted redirects of unsupported af_vsock
      vsock: Update rx_bytes on read_skb()
      vsock: Update msg_count on read_skb()
      bpf, vsock: Drop static vsock_bpf_prot initialization

 include/net/sock.h                      |  5 +++++
 net/core/sock_map.c                     |  8 ++++++++
 net/vmw_vsock/virtio_transport_common.c | 14 ++++++++++++--
 net/vmw_vsock/vsock_bpf.c               |  8 --------
 4 files changed, 25 insertions(+), 10 deletions(-)
---
base-commit: afeb2b51a761c9c52be5639eb40460462083f222
change-id: 20241009-vsock-fixes-for-redir-86707e1e8c04

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


