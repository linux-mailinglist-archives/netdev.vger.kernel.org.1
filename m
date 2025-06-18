Return-Path: <netdev+bounces-199064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76DADECA3
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322677A2A00
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFDD2EAB91;
	Wed, 18 Jun 2025 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="JElnFsmk"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A792DFF2C
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250096; cv=none; b=VFVp1sU6r1gC7uvt4yO+OT+ml1t0MLzj7mWtELuOuyN4Bm3eyYtluE1CK08iV6ZdBkvSRQH5OYtJZnTavULvO9M5i7IZfL8gcp78VZlcMuywkEAo8T+qSq57UZcaZnIK4YDFvgJS8HkC6HYt2Scm4LsKc9SIO7K0hEoVNmmVC3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250096; c=relaxed/simple;
	bh=OYSnlxMSDp1QyT6402Hothb+zrFaG3ybPRSRwBAdG7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MiFD2nsYHhNXnppvPjWw2ppPTW0ZDMuaEMDk7usTZYN7pOqF/MUnKRJD4FJdatxGrEUYyzG1+Bboe2VU/9EOMKeZi+b6gUTml+R2gQ+kDBfrJ14y4Ae7Qa6tme66ViHA3arRTUhd2RQhnWmxMAXfTHIz56KfvTepVDRuVkW36Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=JElnFsmk; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uRs0C-00CJiE-DA; Wed, 18 Jun 2025 14:34:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=o948Ktsn/R4EkTqCGpE29a+TKc4BVDi7R6EuFteV3pQ=; b=JElnFsmk0LosS+WpdE58wIIqPp
	hpT4JNgnpubmNyW+9dz/J4oJa2hqLAK7LXjpWqhoMYo6gyLrCnQ7PHVwa+DvAAKKu7on0vFiuMVYs
	FeLzcfPbaeFlUrxj8qKmgmbKf+HblLqJvxOaLg5Us1T0hxrQ51B9PWCQsMo0x8RnUxjhevr6DSNAB
	Klt04gqMXfnwJHmKtUJnLhVjG+r0Knc1W+c0qT0Uof9xkWWvhXR60c7EVWU6m2gmAzxheSV3x2+v3
	bnk/V4OKj2dbIziuEMmX5s7sM++AIQxyn8Z3kp6QmByADJJHoEGB3FLR+UfVz9ISwzxBsA27IWju5
	NZ/k49EQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uRs0C-0001YV-1n; Wed, 18 Jun 2025 14:34:52 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uRrzo-00DbRZ-Op; Wed, 18 Jun 2025 14:34:28 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 18 Jun 2025 14:34:00 +0200
Subject: [PATCH net 1/3] vsock: Fix transport_{h2g,g2h} TOCTOU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-vsock-transports-toctou-v1-1-dd2d2ede9052@rbox.co>
References: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
In-Reply-To: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Checking transport_{h2g,g2h} != NULL may race with vsock_core_unregister().
Make sure pointers remain valid.

KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
Call Trace:
 __x64_sys_ioctl+0x12d/0x190
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2e7a3034e965db30b6ee295370d866e6d8b1c341..047d1bc773fab9c315a6ccd383a451fa11fb703e 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2541,6 +2541,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
 
 	switch (cmd) {
 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
+		mutex_lock(&vsock_register_mutex);
+
 		/* To be compatible with the VMCI behavior, we prioritize the
 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
 		 */
@@ -2549,6 +2551,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
 		else if (transport_h2g)
 			cid = transport_h2g->get_local_cid();
 
+		mutex_unlock(&vsock_register_mutex);
+
 		if (put_user(cid, p) != 0)
 			retval = -EFAULT;
 		break;

-- 
2.49.0


