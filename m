Return-Path: <netdev+bounces-119397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6EE9556E2
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07D41C20D13
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 09:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792F813A250;
	Sat, 17 Aug 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b="Egq+YoXv"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF92F507;
	Sat, 17 Aug 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888054; cv=none; b=pmHocipnzlvluh6cc0tTZwVB35fNEh50p+wQ1v3KRwkeEeplaoCSZgyNH1x6PBKzjHtHY9HMuXJZh46YBUUqyFCE10bkUU+/PI2U/dnzOSHhf/E/NoKrYX6qUeqgt1pLgE8m2jOZpnE/vNRojIgAaKFUoFL6ayUcnPx614MNuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888054; c=relaxed/simple;
	bh=LGcCtWRxTFIjFNuEQ9Yrh45g9bM5KwqBZkoI96Xd0I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXqH/DrSJZkkX1na7deK1RhuilgbH2K12j+ciDyAbEJ58I8dxx6z90DKGHw7ZP2deqRwJPhGFdNYImZt5v5XaS6m/okywS33cd4TRA4kZfaseysk9a5TaFFjSO+U73M6guuJQaE2p6NF9Xwyfszldc3spAXPEhnJy2pu4uLYcLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk; spf=pass smtp.mailfrom=martin-whitaker.me.uk; dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b=Egq+YoXv; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin-whitaker.me.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=martin-whitaker.me.uk; s=s1-ionos; t=1723888048; x=1724492848;
	i=foss@martin-whitaker.me.uk;
	bh=7/ZcyEot4ft5v4C+IPoUax4qqtmH4liF+frQEK5vvSE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Egq+YoXvSstn6YNX0q1Zz844b1P4M9+h0T48YxEMC4XCCGFHMUHyfW8PpL99s4Ya
	 h5ZqSP9gu4kRexvoq258HuOu2MhNUaOWcx9mJVFhJqT2BAAAuneNjPwWsd7yPC/L7
	 w4LTc6/8914UmdB6HhmyN1/5My+y0oJ8ePZZ0lSYYXZ7L0WrIJdrzfQLLKmlC+ZOu
	 4U6rbM+KN1v8W3W2Fr3oVbXE7W4jtPSWVhtvane0Zf9kLBp1bPcF5reFUtbdd5ESl
	 UOGJ6QaTlWzboPZZdcP0SG9tCKb8AxLosy1aeSLtM0OmDNNz4o4FzhKTWaW1Lqieb
	 PS5FDzjUenq/xE5PjA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from thor.lan ([194.120.133.17]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.163]) with ESMTPSA (Nemesis) id
 1M89bP-1skT0q1gYt-00Auux; Sat, 17 Aug 2024 11:42:03 +0200
From: Martin Whitaker <foss@martin-whitaker.me.uk>
To: netdev@vger.kernel.org
Cc: UNGLinuxDriver@microchip.com, Woojung.Huh@microchip.com,
	ceggers@arri.de, arun.ramadoss@microchip.com, andrew@lunn.ch,
	Martin Whitaker <foss@martin-whitaker.me.uk>,
	"stable@stable"@vger.kernel.org
Subject: [PATCH net v2] net: dsa: microchip: fix PTP config failure when using multiple ports
Date: Sat, 17 Aug 2024 10:41:41 +0100
Message-ID: <20240817094141.3332-1-foss@martin-whitaker.me.uk>
X-Mailer: git-send-email 2.41.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BDuS5zXe6TSjR0GfbqEX+CqctxA9C/GgWOn0jGJsqySM+D/JI6u
 QS8AtpOusS7H8VQDesllLEyVhJLcxJ9wo3HOeR0lpzBXZZgiBoyObV9b7JNibOz6hskATzj
 fCZ5Coh2Akr8aEzgw4XUyXzMa4yiIIo0wiMaMnPYU+k4lfdgXq2Bl9rQ1wcmjiYyHzjzaeH
 Ca4DoFatI1JbdDatGnjww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jju6uKzkCqc=;3gIPgy/wSiJpS7yWVhLbVysR2Wb
 UU+u3wPQV8IOthK+7m5XlMhU3p9wQuPvJ8jNbhNZrz9LxvAUKh2H01duigrbg/kdHQMMjR0A/
 L8c9zuNd0k1b6ELhZkyF/sP/ykiKrzaqvGtrDFqrbgXS58w2R4VtCJ0BBDv0a8QWXdV0jOPQ/
 xrUtn1Tb3N3fYlFhe9yEo/HmHbsqqRYOAQ642OydE5MKyuRRX7UCRbIitKT5RJUWYEXGDnf3d
 vQDR/rY8pdLTpgBGg78n9p2Ty3jEsgVivakbFZuTOUvmxYkcIDqgdiFma13n6Q2yHEwprXhuV
 yzjagHa0xpyzewoSCm/FkYclBBsPlFQ3zUlKm4WPYgLe1AXmsREJpIaG84duez9YZGS0w+60o
 878bTl36SNB6YgBC+VLIuGGasRd4Ee6zAuDJ+LbSU6W7iqhHN3nWcPbe7uIbX9c+887hhpuy9
 tpshJVW99NEd8PQHXVQoyjnrtbF25lE38kZToOTZRaE/LJvJ0RTtXXBh3v0aU4qO4y4bDk+2c
 cTZG9Bx9DVZJVmsczh8Qb5HdweEy30zT1wlWbPHxP3nR4Lliy0nlm/pbwTyYwUKashldYKEoU
 B/32gminH3Q4FMu4xSmR38UKCcrKxGagzNbr4K6zi3qNDou9CYUpKxA0ILN9EAt4es4G+wyx2
 SWgyj56ie1/T5Yuzjjo5efGzUGzZeQ35jKADcVguDpVfUasya4jsSn4jfhftqrav1AMh6ub1i
 ZqvszuOnToSRMKrjdN5Ju1ehPil3YPFoefw4M+/+r+ghTqBeurhUQg8VUYxW54Be62ggzg4B1
 VPhf2RiRbak4/Go6TkK0QVBuPmb/gb3n05CUOcXx/G7YsnGLUoao03nxW5NE0nk1Tv

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
Fixes: bb01ad30570b0 ("net: dsa: microchip: ptp: manipulating absolute tim=
e using ptp hw clock")
Signed-off-by: Martin Whitaker <foss@martin-whitaker.me.uk>
Cc: stable@stable@vger.kernel.org
=2D--
v2: https://lore.kernel.org/netdev/f335b2b8-aec7-4679-993a-3e147bf65d1d@lu=
nn.ch/
  - add Fixes: and Cc: stable
v1: https://lore.kernel.org/netdev/20240815083814.4273-1-foss@martin-whita=
ker.me.uk/
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


