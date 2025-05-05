Return-Path: <netdev+bounces-187740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515AEAA95AF
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BD117A46C
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 14:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5825CC5B;
	Mon,  5 May 2025 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="b7aBQxXZ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3521125C81B;
	Mon,  5 May 2025 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455096; cv=none; b=GGIoAMkfa/DgpuhUeQBJlzm6/1/7ZeVKGfvZHeGG4OOEcXQ88SyogoGeptB6vM8GZZLpuBA8GXEeXavGl9/ahVQhSN7m5WpuUba8YJKU7LJPSiB5rs9S8tovUkkdw59QlTemgpx5cdi5jQdPvHXKWT1Dacj/Mtdvv7ATTzVongo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455096; c=relaxed/simple;
	bh=IsBI1QU2mmfyZmUGJlgiUg5jJJkOqqH5NvQ7wLer8LI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTjMZbk4QxMzphaY8FNPs4Vx99BRn7DTwGZwYZ+QyMCDv9CcGtIDmXW7eOHP/o7CVTA/TKLZo/bwp9WdtBxROB1hfJ6MC9nrKW74pBbOaBl0omG/c2kZth8BPbq0B0qZVhngHOBHmQ9cQL9wT9FufWlqYk/JGxuSw5lcxXzi7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=b7aBQxXZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746455087; x=1747059887; i=wahrenst@gmx.net;
	bh=mvtmY8KOS06jSa8t7zB743lFyulPJcii/7nLEUqW9sQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b7aBQxXZOBeh29iZUERzW4oRON0O4IZOE2eN3JRoKmmKgOWOxZc11izX3q67H15f
	 n4/Lu0azdcNtiGJ7+brxufYil4767OkKs97F8/kCA50pQp/0TQfzQhLDWOWNTC4bG
	 HC9ZvUa9xd0FBLhe6RBzdk+rv3j+XpmVHWYI36buUHZrwrbeHOf+K7rsQWF8rNNtc
	 ctCXgGKc2Pahn/M4hkynLPR7K1H/mDk0JdMizs8my66JhzNDq8+OrY5m7G+DenDXd
	 TT4Org9dBHXvXeyXGXgH316A7wANIjlcmrLt4k9TuHPLJY+ZnEH2rm77mNMxVK3K0
	 F2fDvHZac8qiXaLGBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mdvqg-1umewT1G5O-00lxoW; Mon, 05
 May 2025 16:24:47 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH net-next 2/5] net: vertexcom: mse102x: Add warning about IRQ trigger type
Date: Mon,  5 May 2025 16:24:24 +0200
Message-Id: <20250505142427.9601-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505142427.9601-1-wahrenst@gmx.net>
References: <20250505142427.9601-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4iGy/NSwIJ/wFx/1MqoGPkY2OgCimw+OICrgX9D2SaPJ6g4fBsB
 r8N9NielyNeBhAAeSvCQQalVppEh1FU4W+0/kvpQJiFTD3OrumIKkDJUGXAQ9acGv+weXZO
 gG48YbqVwsJtPzCQ+YpFgmfmJSAMKPVR5n+6pjjFNnMOeMegPTLgDG9hr94ZxMmxaddEBUg
 Qc+Htc7jebx+N5Uhb5PDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:duUEEAlQ6Rw=;5xfyEP7xmAw3ThMMKS6Oa5c0Yd6
 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

The example of the initial DT binding of the Vertexcom MSE 102x suggested
a IRQ_TYPE_EDGE_RISING, which is wrong. So warn everyone to fix their
device tree to level based IRQ.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index e4d993f31374..33371438aa17 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -522,10 +522,25 @@ static irqreturn_t mse102x_irq(int irq, void *_mse)
=20
 static int mse102x_net_open(struct net_device *ndev)
 {
+	struct irq_data *irq_data =3D irq_get_irq_data(ndev->irq);
 	struct mse102x_net *mse =3D netdev_priv(ndev);
 	struct mse102x_net_spi *mses =3D to_mse102x_spi(mse);
 	int ret;
=20
+	if (!irq_data) {
+		netdev_err(ndev, "Invalid IRQ: %d\n", ndev->irq);
+		return -EINVAL;
+	}
+
+	switch (irqd_get_trigger_type(irq_data)) {
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_LEVEL_LOW:
+		break;
+	default:
+		netdev_warn_once(ndev, "Only IRQ type level recommended, please update =
your firmware.\n");
+		break;
+	}
+
 	ret =3D request_threaded_irq(ndev->irq, NULL, mse102x_irq, IRQF_ONESHOT,
 				   ndev->name, mse);
 	if (ret < 0) {
=2D-=20
2.34.1


