Return-Path: <netdev+bounces-132148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8F79908EE
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E01282465
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70631C3028;
	Fri,  4 Oct 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nPY9yl9o"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C52F1E3783
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058784; cv=none; b=H6pjknuPHkJoB4JA5RjNKYhFB2Uq8vjEAPnDLBGXyqRzlRDWEuSvyNY0uh53oXRRokyUCGiuX1OPi2ZprL3LSLetFOHqZWK37HgBoAihl3KTFxMNVMlxfYj5UxCII+tlGekFw1NKu8eyJ1sky8+GEsipJouzhUkgRnW7ogV4hSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058784; c=relaxed/simple;
	bh=pEV/MxMbuiBE8kfjwjbyHWDCwn0HO/vnXJb/zzOhWIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nIl661S5GcqBuiQb96Pjp+3kRiG8UEu1KfdUPjv4C0ChZAdPOh5wNBtqrLSdNURe+/aIRQ0n2d+1qyU7TRtCf8VDOVlAWIc4wQsOlJuoH34BRrC/EGYCG7tNkQ4hWpEVFaImMjyBFGreAwpvT2KfbcalStvg9KTNqX32jCvW4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=nPY9yl9o; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=1VRZhIoDkswjtSyTAiqATwQQKbDLVvc16+cgZRRY02g=; b=nPY9yl9oQyhgWDnMPbeh9Ii5bM
	4/49wyK/bcpeIIei5jWB7x1aDtcy6VeiMbu6lURpwvfoS84ILecNbaeDsvNVHAIrsCQcOusEzVffh
	esS1ay8DBrMbD+IG0GQqQVgBp3FNHrKgIpgkpbFtnqkp0D31INuHczKsOnzNeXXqlLIu4AtjjobUW
	QFk6JtBEs2WYyHbcrj1vMHjgnyinG7T3dYq/Y+6jxFJu2GPF28/tc6oUFEHhoFZC1QftYD5pQkeKZ
	eAyio6iIcx/z/rm8bp/0mWB3MDBbyyLC5DYNiFGIUonhpsCCme6IkT/zHZu/gp/29pPgcvLKdKkOU
	WTRoJuKg==;
Received: from 47.249.197.178.dynamic.cust.swisscom.net ([178.197.249.47] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1swl1i-000DH1-Qw; Fri, 04 Oct 2024 18:19:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: edumazet@google.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next] wireguard: Wire-up big tcp support
Date: Fri,  4 Oct 2024 18:19:33 +0200
Message-Id: <20241004161933.120219-1-daniel@iogearbox.net>
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


