Return-Path: <netdev+bounces-199915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE6AE2309
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 21:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507FA1BC65D3
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 19:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA7227EBB;
	Fri, 20 Jun 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="bzkagKWh"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11EE221FBF;
	Fri, 20 Jun 2025 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449186; cv=none; b=m+pwHPxySe8Be23nsm4D15HfVwkYQYT0AHBw7NAQ2teoHQQp+AWSpu6onutclifXwWVxdz1abtwZ5KpBWh+9IdKYFWX5gqdn81ktwhRjnuIYQrOCoEVkygKCOFtOfPalPMd7krPRzogjDGH2DZeWZZnTkyjVTNXvnaqPeYoGnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449186; c=relaxed/simple;
	bh=IA1v21XSYp9brpbYgXg7OcdfSvZaDksDvp3fz0pIJCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HOuqYaGX/NCKrCFhpYiqJGgdqlFWaEz1Gt3Mh+RqqJSBOAP2bhmp+pP1ms/USSnshiXzVsIaOUHGvxwGuF2KiAS67JQmRAyaWepSEQgG12DApQ6ELi8FK+KrnC8dMhd8UQSORR97qePCZCcfhlkf54I8r/Us8d6Bh8DA6kqs8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=bzkagKWh; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uShnG-00117P-NJ; Fri, 20 Jun 2025 21:52:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=mAQn+LsaZ4KxkSKkcYxJ2lCZQrMV5oD1Rbyyax4M+T8=; b=bzkagKWhCKg6SwbYBr+HbsdL8H
	+hkdE7XiDraQ/p0S53rgS3RwqyMqwDvROukZ10+0sLHHLG61K5Pe6UjkcoZmQ7k+KtsC9iIuU3w+s
	sgtyDCckEa5NVvGHaG0sy1aBQ5fYJrzG9YVakBaW52XYJuITr9cV0HS3svwKh3Tv5+5UogsPHLWQD
	TXJd+aiOIoiZjstmKoEeYzx8mHH7PHB7HPYuQgFXDlIFzs2B5hdvP75tvjtEWfx7tRM5VQoOD/skn
	cQpmwG3ulgo7TNnfjQsJG/lbyOwZLPa3Hu2aC4RjYdZQB2RIiGw4p1itsnV48kIEIx2jMmEpsaHnL
	LGU84okw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uShnF-0003hD-PD; Fri, 20 Jun 2025 21:52:57 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uShnE-00CRMQ-10; Fri, 20 Jun 2025 21:52:56 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 20 Jun 2025 21:52:45 +0200
Subject: [PATCH RFC net v2 3/3] vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID
 to check also `transport_local`
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-vsock-transports-toctou-v2-3-02ebd20b1d03@rbox.co>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
In-Reply-To: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Support returning VMADDR_CID_LOCAL in case no other vsock transport is
available.

Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
man vsock(7) mentions IOCTL_VM_SOCKETS_GET_LOCAL_CID vs. VMADDR_CID_LOCAL:

   Ioctls
       ...
       IOCTL_VM_SOCKETS_GET_LOCAL_CID
              ...
              Consider using VMADDR_CID_ANY when binding instead of
              getting the local CID with IOCTL_VM_SOCKETS_GET_LOCAL_CID.

   Local communication
       ....
       The local CID obtained with IOCTL_VM_SOCKETS_GET_LOCAL_CID can be
       used for the same purpose, but it is preferable to use
       VMADDR_CID_LOCAL.

I was wondering it that would need some rewriting, since we're adding
VMADDR_CID_LOCAL as a possible ioctl's return value.
---
 net/vmw_vsock/af_vsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a1b1073a2c89f865fcdb58b38d8e7feffcf1544f..4bdb4016bd14d790f3d217d5063be64a1553b194 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2577,6 +2577,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
 		cid = vsock_transport_local_cid(&transport_g2h);
 		if (cid == VMADDR_CID_ANY)
 			cid = vsock_transport_local_cid(&transport_h2g);
+		if (cid == VMADDR_CID_ANY && transport_local)
+			cid = VMADDR_CID_LOCAL;
 
 		if (put_user(cid, p) != 0)
 			retval = -EFAULT;

-- 
2.49.0


