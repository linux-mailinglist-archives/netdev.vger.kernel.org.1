Return-Path: <netdev+bounces-159470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB10A15946
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE5F3A89CB
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4CD1DDA32;
	Fri, 17 Jan 2025 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KroCqCC1"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849B1DBB3A
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151227; cv=none; b=uoraaXeS79Mktvb3gQ0XGJxv1maCznLrWgwMxwY1Sla0tm9Wxz7J0rPB3GVU8xjwbWiHkkUzWN6etpEf5NVyfkMp8rTaMbWvXOFMa+gYQnoQ8Uf0rO6UvDMIdhII5vlxd8edU6KYW0/kB9AOCO2rx0jzvSmnbm/bWE0I11TOhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151227; c=relaxed/simple;
	bh=aWcFSD8dZ1ceWBI8b2ai734AQYnf/oo//mkxB0waeSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FNTWf9U0VtQDAR9nUF6j0UkmTXAQZscjTsQhLAxGaGPogEAE5HWq2CCmdfNn0Kc+OEFj9EBnmY0Aq5BOarDUdSbHItoZ2W9DJvuEGGP2Q+tnH7GtYPup2MvkKbFZpmR7Yh/JoJfx8FkqVdxvoqYg37bW5S0iMZoLaY/NIN7rfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KroCqCC1; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tYuNy-008VCL-8b; Fri, 17 Jan 2025 23:00:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=bCGHZY9hFMXNrfi2nvA6hJTt2xtCzGr/p3elk8wugqs=; b=KroCqCC1kz1K1EjALgxFWmvZKN
	fCKLmtNg+vRMnmBjGSJb5bN8wdq/hX106I4kW5lAqNGmEdqOv44n+roPvHMe7nOjsxWgb3uOMO9fz
	XQMj0rV6kaZAU+uLS0nCYMZjghrl3r5Ps/6Mh3o0vQy0n5nTe0ZeovpPTZD0CbZ1gTB7hgMexZrJ4
	jX136YSUheeCZIGuVGbV+U//AoPECwF1xTP3BQ5mnnl5fpgQdVoMERvKqbeNMQF/fNQSBFdXcBcji
	30Y0A5lMOQC+UBF225jrIhqQHMikyMg1kradLhoWmYdSqleYKpd3/xzzZXL0NwMol/RaLNNofONzC
	1ewxdh6A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tYuNs-0004su-KH; Fri, 17 Jan 2025 23:00:08 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tYuNk-006md8-H6; Fri, 17 Jan 2025 23:00:00 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 17 Jan 2025 22:59:42 +0100
Subject: [PATCH net 2/5] vsock: Allow retrying on connect() failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-vsock-transport-vs-autobind-v1-2-c802c803762d@rbox.co>
References: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
In-Reply-To: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>, 
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

sk_err is set when a (connectible) connect() fails. Effectively, this makes
an otherwise still healthy SS_UNCONNECTED socket impossible to use for any
subsequent connection attempts.

Clear sk_err upon trying to establish a connection.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index cfe18bc8fdbe7ced073c6b3644d635fdbfa02610..075695173648d3a4ecbd04e908130efdbb393b41 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1523,6 +1523,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 		if (err < 0)
 			goto out;
 
+		/* sk_err might have been set as a result of an earlier
+		 * (failed) connect attempt.
+		 */
+		sk->sk_err = 0;
+
 		/* Mark sock as connecting and set the error code to in
 		 * progress in case this is a non-blocking connect.
 		 */

-- 
2.47.1


