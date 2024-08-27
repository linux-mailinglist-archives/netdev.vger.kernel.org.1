Return-Path: <netdev+bounces-122483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BEC9617CB
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD35B213A7
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC91D3192;
	Tue, 27 Aug 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QJzplBAL"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E61CFECE;
	Tue, 27 Aug 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785846; cv=none; b=OP4G2ZLctGukEgVWn15t1X/b9Zm2gavtZHlse+Cm1Lgf0mlQf5JAGHgNOL/Ohfot8bnFYOU3eNvEJ9ohKkzDG9sfaTeBW1f1mUWdZxQrxa/OJRpBOgGFcm2lwAuwpoYVCKLQnU+/QOcW8OlQ2c3sk5RoIfaA2D2m1OZISFa/Dz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785846; c=relaxed/simple;
	bh=HRc508RbmXV0FUoC3kABdxRTsv47VzpEFEzUtcw2HZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfcX+UQ17F+/oH4fvP66NWGvVipHSozhBxS0u9cmZA2GZUJgGrmxFmM3m74+2XDbx5So84ALkAVZvvmPMhU3QMZcvU57kxc5OflekJhpHhKtsAGnynaQGPtC4gPqx/5Ln7lFMz2MrKRuyIQipDZ6V8p8Mk4ThQmYge3uqMxmQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=QJzplBAL; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724785829; x=1725390629; i=wahrenst@gmx.net;
	bh=pG/5Ey5pW92eb7Gus/e9GS+zhwU9GERN5pNXlAVFNys=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QJzplBALM0r/vwdm7kbqAmKIbIHC3ZumAjGZUa07wWqn1MzQAKX+huVCw9z9TcH0
	 KQwFxybkH+LsiEMQf7PzGJqaeaeu4WsyJzPwGxLuHL3haqmwkrB5qIp1IJ6qIw26T
	 JxXlrc4h7LDAsuvC5yvTqdCyco01MnG5DMSYpAi2tM6G8lQcwS+yoWP8+esLZD/Ze
	 +lGXcWTMyvDWsSY9lfCnp5SE0FwBhu9RbN9vhv8K4E3j3xz8xN/z1PZKNI13cISob
	 dpmODwEWp1RF9ltPV/aETv6U7/fgtXsBcVig9QGyMUxuQsTlC/MMBhXDSroj8FpFE
	 LH52YsZTvvljdIjZOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1s3hV62REv-014HCB; Tue, 27
 Aug 2024 21:10:29 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 2/5 next] net: vertexcom: mse102x: Silence TX timeout
Date: Tue, 27 Aug 2024 21:09:57 +0200
Message-Id: <20240827191000.3244-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827191000.3244-1-wahrenst@gmx.net>
References: <20240827191000.3244-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:73bKUGUnFn9baLAlG2gPdFfDAWNap+UJv7Ta8ZKfi0g4mkEZmIS
 wxhABpHzTjuyQs8H+m+GbZovcRutydd1UMZZy+YUAkqfWinnB6WrcdT65AzQKLJTCtkm04J
 r/cqQv5B1rN1ul3F/H0hbArrA2rvVy80res6gbxPQgk8zlE9k3BG+Qs+UhOd99AdHdRmG0i
 v83QTbTVJxzVdFws2QGnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ORozQXzBRXU=;ztBVa1JIpth+dnJDlOSLlmtrKTl
 cNHOW+FhEajMg+rZ3gCq34Prcrnen1fU8Lyc4ZTQ3bqA+fkzdT4vMQpxKm5TGZv7Xqueln2EQ
 YuJGPOn8yQDHG1UGJWLgSWtn8MhfGzALTGo0u4YTybuSNHHccULSMuSHtla7BvPWmNCR9dKMf
 ZpqZVwFaHrnyMVmGMEe0helsskWqJuJq2APltNhXIH3H+mddsOj35RYNhAFRwAk0gecSbz5IW
 5c1j9VOp5J1Uk5mKjvH3afy3ZwXBgvNtZFju9FGvn6Ns01rZ6wYy7BD9PRAbRPsA1ucdKlODS
 xBTji6yE5jinRHryO2IGOBxZD97zVWA+QOHSevgZ5S8DI6ovVouDdgxGFBA+SSPcLUREAgSBw
 UgRJHNdlhu4o62TD7iTjFqr6qa/eFTYJRlRJFDCPEhgTTbSPn9K14nWk2TQByT6h+wEhwEt92
 0CKFOhe5nr1nzKrFkYF5Je/quYZcnb8ondDBhumQjcsiCivAPtZ90ySuAGdIol9rMIdIdZuSa
 dKxW/Binr82+XgylHirKFlAWkvgtsZaCXs2JektZpuZAf9/SHny5IWqxbZIEaTuQzyHNZOjjk
 sz0/41zxC6L54Xhu4VllKLtQfCziLP081IeMNiT8Gqc6Dwh8mh9SBC7qqXMiUWkByT2ttooRd
 dQM+ljksZ1a8XGhFMS8gDaO+E2+thgLX/g6ynQQ4KdpcnTgeU5D9j+q+slrobZBqolTTCAZbv
 +SPpgfZ8Y9wNubTlDFu7REL3z0U4KQrNyEp3VdyKjlvnIt7AjV/aYOSf6g75jVU/tHmBAqcJ5
 jImLJdsAaT5TJ+yEVnQgM20w==

As long as the MSE102x is not operational, every packet transmission
will run into a TX timeout and flood the kernel log. So log only the
first TX timeout and a user is at least informed about this issue.
The amount of timeouts are still available via netstat.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 0711641fc3c9..336435fe8241 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -451,7 +451,7 @@ static void mse102x_tx_work(struct work_struct *work)

 	if (ret =3D=3D -ETIMEDOUT) {
 		if (netif_msg_timer(mse))
-			netdev_err(mse->ndev, "tx work timeout\n");
+			netdev_err_once(mse->ndev, "tx work timeout\n");

 		mse->stats.tx_timeout++;
 	}
=2D-
2.34.1


