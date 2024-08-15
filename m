Return-Path: <netdev+bounces-118764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09439952B43
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F105128305B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 09:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0881A00D3;
	Thu, 15 Aug 2024 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b="kIUGT9u0"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E0E19EECF
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723711116; cv=none; b=Ist/H8SuP9D/0YULnxRMUmTV7GmHw+L+YcG9uYGIZFxmHa+gE62fGId5u6b7fImBS6/ozsw93oYp/60YgU2WU3ksTXvZSU1a8piUxqIEONGPkBayFfeygir6KdBHJmTBb5LhicVvaBuXH9iM3hy54QBVyVG2T9/wP1jM28wA4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723711116; c=relaxed/simple;
	bh=DoYXZggKWwas4BPjqmW28gROX9NXEaRFWWYOoOTn/G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1UwMOTE7DfxYkOxS+rV/NRQ4z77JlY/VWuJhXwhGiGfcZJdwnHT53oNFzNjT+UjkHM1CrrAhQPrQOCJMzXY2FFW7WGEmu9LTN2QtOE5fqkYoP8QcvMPV+URDj2k/sXCWZYJpGk9y3B0dniRw30TwBPlpiDJsDH3uobutQ1e+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk; spf=pass smtp.mailfrom=martin-whitaker.me.uk; dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b=kIUGT9u0; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin-whitaker.me.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=martin-whitaker.me.uk; s=s1-ionos; t=1723711097; x=1724315897;
	i=foss@martin-whitaker.me.uk;
	bh=m18xWgr3xx9aFGB0h0G2K0H6V7SEZm2JZmuWpA75Ww0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kIUGT9u0c0Voq+hDN7VHiCwAfkSl88zZbnJm+B96cLfcDSnhrSuzsYnH3Q+FVWJu
	 JBP09iBgGa0Ofql9doE+wp6NNSqLHD3qO5mvOJNdphLeO0e2PCUpI1hSRE0jNHdSn
	 qpz0x8R66396v53YtSIFMaNKQX0fypqd9/1kwv9AWeV8WynhDCvYGpQ/8D2jpciT+
	 1dAYSozbvu+TJgDTMe64Nw0Y/jnOkHBh40oRrlQQAmv8L8Of5qDtHVihfYQpQDKkD
	 ug7TltVjXavhjQz/E3GWZ8VM0saDKCT6vAjbBjhlE0ZIjL6msMNhPC6H0AT6ipGLm
	 fcGZrZd9ic9q2aJ0jA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from thor.lan ([194.120.133.17]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.163]) with ESMTPSA (Nemesis) id
 1MEVBa-1sPbTn2lEg-000DX3; Thu, 15 Aug 2024 10:38:17 +0200
From: Martin Whitaker <foss@martin-whitaker.me.uk>
To: netdev@vger.kernel.org
Cc: UNGLinuxDriver@microchip.com,
	Woojung.Huh@microchip.com,
	ceggers@arri.de,
	arun.ramadoss@microchip.com,
	andrew@lunn.ch,
	Martin Whitaker <foss@martin-whitaker.me.uk>
Subject: [PATCH net] net: dsa: microchip: fix PTP config failure when using multiple ports
Date: Thu, 15 Aug 2024 09:38:14 +0100
Message-ID: <20240815083814.4273-1-foss@martin-whitaker.me.uk>
X-Mailer: git-send-email 2.41.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a38OgKORuwsd2WIhwTp3RlZvGq1igiMRqt2xyz4vIvBqCalhf6A
 VMCM0LThM0hl21xKaNGC+dj4g4ctNBQPRyp4Virod6J/Ghw63jUevaiVT6OISB6JqALQtxk
 EoXt2JWkA5VtAiSOottHBJdEWNQP4SV5TBiPWins0eQNCSUWt4WmnuIMXU1WrcnedkLeY+6
 wfG1AvcTMNXBqE830hOTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PI88lZDMeMM=;IoRZ2g/YO2wFGk9C2hv9Kj/UEw0
 ZJccyH4AQ9m+CYCMXFB+ZgzV1xpEOfOFVUam1VON1svh9ZLXFu6J1yp/qf/1yRJcJXNolaOIm
 eeucMsEereGJoTyZpf7IIsZc8ipOW6TcNrrLJmLRKAyN3dUr9ijr1M809fMbPUheALv6gw4Rq
 SHYuaOh4YPGil5MkihLnhyXyGJviwaG5dhvJ5QLWTiYHQuNSnmUpwwQ2DVJCtPybRiyxDb32k
 lVhuvkms5VrluTPoXblQjx5KnQ7F/CAXmK957g7knMNXbKiTdLdJtkshJTeas8CRVtoXR9xl9
 GLr0ch3LTyaOX2yYq8UAF6O8e8MJMtPGCO91GAtj9LO/Yo69SUfDCfTV6cldyZp7E7zmcWz3q
 RVwol8qWRFUXJ48HvUuJH0CxS5qse8FGQAcUKHeQzf+M/HMhXlm5PVcZKVd4/o1DyrdQEfMcu
 fD0bXXU0csbR2ZGMe40pvWgv1/t/83UZAvtMPF9KOLhKl22XleMkjeCatXA8h1yinOzcK+eQ9
 cbtTcNXYShiajFjbOQ8KJW0RZiQIGhQ275XhtQpXZ1WZUhP99vBvrDkiPaBRFYiMH0i9iPsc1
 ENSsTZy1nLp8sQE5K4DZNK4+0IvBTZm6UvVIjFYQaN866ee09cJR0xzwlx2+36YoObs1p6ayb
 /ULWqtHUSMjDGXsCQjE8NMXpnmnv4WSm2jGrm/4yQtlEfvMr9y7LKgCxuFJOnp+s5ZgZceP53
 nU4/bmNS9LhtRAznk1Ey2hnupK2aS7F9A==

When performing the port_hwtstamp_set operation, ptp_schedule_worker()
will be called if hardware timestamoing is enabled on any of the ports.
When using multiple ports for PTP, port_hwtstamp_set is executed for
each port. When called for the first time ptp_schedule_worker() returns
0. On subsequent calls it returns 1, indicating the worker is already
scheduled. Currently the ksz driver treats 1 as an error and fails to
complete the port_hwtstamp_set operation, thus leaving the timestamping
configuration for those ports unchanged.

This patch fixes this by ignoring the ptp_schedule_worker() return
value.

Link: https://lore.kernel.org/netdev/7aae307a-35ca-4209-a850-7b2749d40f90@=
martin-whitaker.me.uk/
Signed-off-by: Martin Whitaker <foss@martin-whitaker.me.uk>
=2D--
 drivers/net/dsa/microchip/ksz_ptp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microch=
ip/ksz_ptp.c
index f0bd46e5d4ec..050f17c43ef6 100644
=2D-- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -266,7 +266,6 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
 	struct ksz_port *prt;
 	struct dsa_port *dp;
 	bool tag_en =3D false;
-	int ret;

 	dsa_switch_for_each_user_port(dp, dev->ds) {
 		prt =3D &dev->ports[dp->index];
@@ -277,9 +276,7 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
 	}

 	if (tag_en) {
-		ret =3D ptp_schedule_worker(ptp_data->clock, 0);
-		if (ret)
-			return ret;
+		ptp_schedule_worker(ptp_data->clock, 0);
 	} else {
 		ptp_cancel_worker_sync(ptp_data->clock);
 	}
=2D-
2.41.1


