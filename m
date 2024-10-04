Return-Path: <netdev+bounces-132164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552ED9909C0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCA61F213C2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62A41CACFE;
	Fri,  4 Oct 2024 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="RGmROZbv"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C731C7292
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060923; cv=none; b=tohA88FEQsC5zwFoMhvF9Yv9g3K434s63rV+Xhy8nCL35PAuGeX8QkFQ/OqJb4oYkDR7rwwr0hg824F/OOhM34uPq7ljfLBwp/PFqbp2evwaNolj8C3thY1J7cCjnnSvPRDOjYvO2zh+q2s2LtD+NsF6DZSXN27rl2nNtqT6WVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060923; c=relaxed/simple;
	bh=SerrFut1Y1ERVR2tso0yxRegKLMxx977GUt5+V0dpqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NXm1HCju/EHyzBZt8Z5zDyIFRF/JxbP063cpZAa3ANGXVlBmLoSJkHpp2DcuYFqvC639/EhWts2NI10/2syAIY18bi8gfSq1mbARd7umosdNzX/yLV4h0rszY8ybyM92DA2oBLepwfMsTCCnC9pxMOljStZcyXXmLDQ1DIufvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=RGmROZbv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=7Ko7Q6y/3q1OHxisxRoOV/IlFJ79OSMVDcxVRFjuJ9E=; b=RGmROZbv2BU0U1qwQN4zgQTReN
	4eABstxC2VQbVOSw1xrPlYS5YDR+2LeeZ8M5vt/5siUlWDfLtQ1txmzzt6K9hZ6HOqQE9qFB0gn8o
	+tLBtGpU1qZme7VIeV4Ht/3cyz0yAalVeKJG9LkoAZMQ1NclVTJU0k9j1BKy4T0ixEtoQuaHJ3hHy
	N8ia5ZGVbqINP8AqIzEZwnoerGTOy5I3t8OZVjnpDoA4VZUDVfs5DaX8XVRQgB9e5S52FLGbuLZfm
	SOJt4m/etW5fNgmFlvzyAAwdSZHLrxK4N7ijrLUdH170t/wRtD6reg3FqKgDCuOSDYyxz+0xKBgCD
	izmYx+Hw==;
Received: from 47.249.197.178.dynamic.cust.swisscom.net ([178.197.249.47] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1swlaJ-000HW1-0j; Fri, 04 Oct 2024 18:55:18 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: edumazet@google.com,
	Jason@zx2c4.com,
	aspsk@isovalent.com,
	m@lambda.lt,
	netdev@vger.kernel.org,
	wireguard@lists.zx2c4.com
Subject: [PATCH net-next v2] wireguard: Wire-up big tcp support
Date: Fri,  4 Oct 2024 18:55:18 +0200
Message-Id: <20241004165518.120567-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27417/Fri Oct  4 10:53:24 2024)

Advertise GSO_MAX_SIZE as TSO max size in order support BIG TCP for wireguard.
This helps to improve wireguard performance a bit when enabled as it allows
wireguard to aggregate larger skbs in wg_packet_consume_data_done() via
napi_gro_receive(), but also allows the stack to build larger skbs on xmit
where the driver then segments them before encryption inside wg_xmit().

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Anton Protopopov <aspsk@isovalent.com>
Cc: Martynas Pumputis <m@lambda.lt>
---
 v2: fixed up my gitconfig and Cc's now

 drivers/net/wireguard/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 45e9b908dbfb..79be517b2216 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -301,6 +301,7 @@ static void wg_setup(struct net_device *dev)
 
 	/* We need to keep the dst around in case of icmp replies. */
 	netif_keep_dst(dev);
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
 
 	memset(wg, 0, sizeof(*wg));
 	wg->dev = dev;
-- 
2.43.0


