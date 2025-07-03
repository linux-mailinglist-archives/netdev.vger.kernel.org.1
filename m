Return-Path: <netdev+bounces-203861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41370AF7BF4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7671896E15
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08A2036FE;
	Thu,  3 Jul 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="axyeHQwX"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9D919DF4A;
	Thu,  3 Jul 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556014; cv=none; b=axRDg3QW6GPENhh3ut3cgI6M6qssFtTVwYhDkF8bWo/5hAvBo/FqiSJrcW+PK+HZBuJyu49tbtkk+fTf2GQjRKNW++443zcip4H++2NL2xKm8NWfJaEmW5wi9Bh1Q4AnLblD7oYzeVCuhTQ0lVO6tVpMT09xCVRerVJK0uejzuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556014; c=relaxed/simple;
	bh=zyW2JF7ggDwKeUggong4msxGGdYZUfGPspwnvMilfl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mv33TNhh3DQN36aj/RwjV5ElekmRfJji63/x5zj7Qp6UiuqckiSiFcBA9apeDRPIon/TGPCEbVMN71Oa0lprZM2JRfmXB1KGCKLhx6bnIloklq8nvpTeW8v4XolFs41b4R8xcGHQoEh5/dRixFQFY4RJA1G5A3dL+s+Qs6szS9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=axyeHQwX; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uXLjI-000o8Q-BG; Thu, 03 Jul 2025 17:20:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=PlGs9wh18mkqUl6kxctD4ftbMTeyT7vxlrNxpH3tPMg=; b=axyeHQwXaWu/SQM7ZduRiHASei
	+1PMePqhF9E3n4J/VumWPk+U+YeWedeIizyD/LlBRgZIPFYYccRYnx55M6yNJ5hKMRPtNWlEP6MNU
	73vZ1gjJRXxYnSKR3Msttf7htzO6nVY1RsYL4T+q+HxtdyOp1cmDhrhw2JisCsdlU4csk0yRYSL0l
	BO706XgTq5DsTHYwJryd+mLL2CXeE9PDWsPrb0n/sOnVaOeEBJMIVfvtxGa4o7senGS2idiqKVxM9
	YNQHQm5hLzRiQYxWbh113PaK1wuJ116LD24lTqCvDTFZtnINts/Eqer0KuHd/7X2XTkj/ABH3QhBR
	QnSYLBgw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uXLjF-0006dZ-Az; Thu, 03 Jul 2025 17:20:03 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uXLhl-001WIY-1w; Thu, 03 Jul 2025 17:18:29 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 03 Jul 2025 17:18:20 +0200
Subject: [PATCH net v4 3/3] vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to
 check also `transport_local`
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-vsock-transports-toctou-v4-3-98f0eb530747@rbox.co>
References: <20250703-vsock-transports-toctou-v4-0-98f0eb530747@rbox.co>
In-Reply-To: <20250703-vsock-transports-toctou-v4-0-98f0eb530747@rbox.co>
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
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 66404c06bdaa0dc453a625c08a04c7eb14a95498..1053662725f8f03b78dc6ef80d46c31167ba0055 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2581,6 +2581,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
 		cid = vsock_registered_transport_cid(&transport_g2h);
 		if (cid == VMADDR_CID_ANY)
 			cid = vsock_registered_transport_cid(&transport_h2g);
+		if (cid == VMADDR_CID_ANY)
+			cid = vsock_registered_transport_cid(&transport_local);
 
 		if (put_user(cid, p) != 0)
 			retval = -EFAULT;

-- 
2.50.0


