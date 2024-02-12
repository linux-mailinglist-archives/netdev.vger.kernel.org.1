Return-Path: <netdev+bounces-70979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C15851739
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5D81C213E8
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A2739FF8;
	Mon, 12 Feb 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="RI2qJGKY"
X-Original-To: netdev@vger.kernel.org
Received: from forward205c.mail.yandex.net (forward205c.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E83C07B
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748979; cv=none; b=XeQiL2uIf7xyLbRzH+iGbzFFTKpyv7JJyL/2cQsYuAg6lm9FpKwPUB2onOJGdH9BzcZ53VmhalGG0rHLYxe5BqRMoBCPc13nf1INmAnzoH848cYyO0KjaqJ3nmwDteXwLm6EoOzT0yY3SfBARPnKn46iGr0Hk7LixX91S66HsXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748979; c=relaxed/simple;
	bh=+lZciFymIFJwD/jU7Qojsl0yl5ukkvb8Exw+rSCLWAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPzEteLXdCAB5I2Tz6bKXUxr+FWAZKgoe9KxzfNIRQouL/i/lUbAfGG16rr1n+y3QXEBWBqZqgV6vrLGaYjU0dcXD5a6+OM+oRBJ8rf5dADQylQdx5VDxRCAeaeL/MAApIv0EH2KH6W2CkNhBT/NsbEEvcfABIveCSvcDsu3B7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=RI2qJGKY; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward205c.mail.yandex.net (Yandex) with ESMTPS id D37B763FD5
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 17:35:16 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:edad:0:640:6050:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 6A525608F4;
	Mon, 12 Feb 2024 17:35:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6Zn1e7RxTKo0-XevZilbG;
	Mon, 12 Feb 2024 17:35:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1707748507; bh=KutVQaZZTcGNOKFqN5L9OMGEn+KX5O52pWznSbShxpA=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=RI2qJGKYeKBQtxrtGxO+TuFQVhrqD3MJCh69K2Pz30cZogM1gSs+4eDGtCGFE0wMW
	 hs77pV5hEt0gvAxK0LBGOQ6o6i0NIPkOFZxQgeu2fuEIsfNbObSNv9MpjlzVDomNNk
	 VRA+0jl5J+JmTRakd89Isa5sgLYCSeodJaNq45KY=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ursula Braun <ubraun@linux.ibm.com>
Cc: Karsten Graul <kgraul@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] net: smc: fix spurious error message from __sock_release()
Date: Mon, 12 Feb 2024 17:34:02 +0300
Message-ID: <20240212143402.23181-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 67f562e3e147 ("net/smc: transfer fasync_list in case of fallback")
leaves the socket's fasync list pointer within a container socket as well.
When the latter is destroyed, '__sock_release()' warns about its non-empty
fasync list, which is a dangling pointer to previously freed fasync list
of an underlying TCP socket. Fix this spurious warning by nullifying
fasync list of a container socket.

Fixes: 67f562e3e147 ("net/smc: transfer fasync_list in case of fallback")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/smc/af_smc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index a2cb30af46cb..0f53a5c6fd9d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -924,6 +924,7 @@ static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
 		smc->clcsock->file->private_data = smc->clcsock;
 		smc->clcsock->wq.fasync_list =
 			smc->sk.sk_socket->wq.fasync_list;
+		smc->sk.sk_socket->wq.fasync_list = NULL;
 
 		/* There might be some wait entries remaining
 		 * in smc sk->sk_wq and they should be woken up
-- 
2.43.0


