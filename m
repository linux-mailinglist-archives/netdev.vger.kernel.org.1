Return-Path: <netdev+bounces-185010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C334A98179
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C867A3ABAE1
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB9E26C3AB;
	Wed, 23 Apr 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rsGbDGQQ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C326B2A1;
	Wed, 23 Apr 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394394; cv=none; b=bL0CT3eGGdGgNvYkhGefnTPcHy2IJoO23x+pj8pi2H9RiY+PCLpIw0wUj1vPz3piKgiAYjDBKpeV7GaivO/rnloM2w4MhON3W/piEguW6HB4Qz5sCL7P1Jv9OlH912u0OGlnuLf9rhWkCEwmc60264f7z2c1rpebmDL7Ot8EE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394394; c=relaxed/simple;
	bh=ZXP+q502u1qHNaU5v6BQ1Yen6wpIdo6X/xAfOiQjE6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DaOVlMz1FC3w8r/TbVj30YvMiqSsJDszf0EUlurXZpYIagE+knroBNC5nVvZxH4t3wD/FFDSbGdhi1F9wNPoSMk01JrPJ/rOiniDlhBZys4MTOB4O863kLvg+QQPLEksk2dMcjwsRFZjmTzl/natU4QxjnkXXMutBlnwvkx3eso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=rsGbDGQQ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1745394378; x=1745999178; i=wahrenst@gmx.net;
	bh=NZy7CxzfYYcimz4ZEhmuCpHqYGjXSktFeVXfg2A+7XU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rsGbDGQQArHESvu1mvIXiZivtLTB9kfRStBR+tv/CDltae/0RZ8j1YUxgIWSpGjA
	 wkn1cVBuHOweUQwHiWMznCmsflmp59dn7CGJyuIKTpTf+xSTvz+r+Hrg1VFTbWRMX
	 y921Ao3FP7mpZMT5evketu8yB8p2SedF9Z5Hoc/q3llSwPA+2Sz1lylHayb+1PZrH
	 HJ+C9OQgXIfpepDirqFSraoMlsYzbUOJ5mVcq5cN7iqTMfSI8X1wwfBtNz/S1PnvT
	 YFJ8ws5JCHnVD5i0I8zPuhLJE3lq9/+g/VBUK33tt8HzhC6pnZZffaTYreL34Kf2G
	 +WdrOJPorxD/wfjUyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1uBb9B2A8N-00Avsz; Wed, 23
 Apr 2025 09:46:18 +0200
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
Subject: [PATCH net 1/5] net: vertexcom: mse102x: Fix possible stuck of SPI interrupt
Date: Wed, 23 Apr 2025 09:45:49 +0200
Message-Id: <20250423074553.8585-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423074553.8585-1-wahrenst@gmx.net>
References: <20250423074553.8585-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m9PYOMQH1lapuAKBWr3ufXhy3of+mVSvrJDsHHdJD5AENFZtw2h
 juFZac7In6yHRt/N+l8WyjXHmd2QUdq3e1/A5xWeZrMlt8/YRLlFuY9Xu6GhFsvGtJN1wb2
 xDvM/g8FS0oFYw/gsEyC56FxbkzpkmagI2NaglL0oUDfVznS7EqzumZwB7QhJAZLdkE9iTy
 bMRXbXC4mC/2B/Mw7Mm4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E5DC7xJ6BPY=;D8sinKu31AKZx71CFliyceel0hF
 wDWDLxK9E+mQISkNHHoy0NOluuoLf73/qTtsWVL0yC+Cv/ZFPYKaDAFjP9COpnOvMW7SesKlB
 N3ccCqlVobd+MqgYoRTRuY7VB60c0ey48uvbHIAGGLWNiB6odY7GoWdz3l5Szgko3wVWlN7Lm
 EOB5+cjSK7jPHAq4LYbvEGtUkKGnDU0At1FIbwJIkc+3JNydUipGdDJhvpprVTJ8TdR5cT3GB
 3UH8XD06a95NuuVdgFO4/8I66murJnYPLL1qWxuTS2VpBPKZKOmZHHmCsi0XBkoyIrdjaGi+a
 zi12RlSyrsJiaYJRGWB5oSF6QouPrmaWTZJswC4xW/XlL/uTAslBglkmCYLagGYRzNuplLtFm
 68DigQ4oNnppX1/aTkHWNPYsjJ0gaOgF+LtnhzaiXLb9jO8Wu4MYKJbxnaPbFKMbL7WeMHgYq
 sag86XSD2AkmcbWWQ1ADRtag91OUT6ZI+XKC+iM966IeASFUlO0334kzkNIwB4HvlTK6rE8yl
 zULzazSCZ71Z+xaOBL8UeZ2IhNOznJJ1wGVw6RpwAAYFTbOcbTaUuIbBV6JYmkU07jrDsttps
 xmDVxGRSzrt8YJIg4c1Ka4CpwLJEviwa3f0kZ3szYi14XzySdZWm4yjAaNMc0KlIY4kDvHSNw
 yreZLTlv4wuXVLtifRcIoEGY+ms0Z23cufkgr0kldDooZtCV0EaY5Ek4Yl0cu/tJ2mH0Ts+5U
 gET+YWRMcZez88Qv9CpP0QtT6qBH8BVXZOGrbMwU4oSoAqdAWIx4yaQsIypsH2W1Lgy24CyCW
 R8egXbe3LyazhDZYIetl51wkWWBx0U+HqCg9F2cLAllsu6YPWxd3ycjc2U1CHG+eHaS+qg56Q
 DCp/vuLJ878ZfYRf1tcCMemNOn1kTX9iogH49udRl7dcpjpVLD2xR3HBoQjJ0VjEfCXLLR0OI
 KioQKIXq551EZkRHFCzERjWP9tU0HPP+QAdSmGMMVyL0RUrmgrHZ4EMJ3pc+VQ6NXoaQTeFga
 Nx5EZ7y/kymHtoByJaYiyvRkKf6t+vUl9p9pg4J1Ms33KIS/NtLmzqRWKKXvIj4QgmgOYeORS
 O3BCnH54EiVNVD5A8mO+4HwHpRfLDJfdVSYeE7uy137Qvpre0VWcR40pplwbmVj3cVMHMsArj
 NjvrhvGoBtaMLWsNYDpEHtP6RQRnXOmzT6Vu4jeKbs3X2g2SKgZj947EnplRYb+am067O8Res
 j4nUQb3RsLy1c/NGXGVeYrdh3If29JAz7hPvbnTYa9lvdYZx4g76VXDMNY2URz4+eet2cIDIH
 y+ifsO3smkR6YaLQtugbGdpcNhfYJ0I1MZ+C8wbIaA2iuee3+svC/Xys2EmnoMNbai3lugr6V
 d2FGUhuwcS1Her6VqkkRPn81y589MGd6aZqyg1U5ldcSwVxcwZc2rXSKZ0pGaL3tEnH7G+v+3
 0Uuxpty7Sy74mW716bn2CqaWOEGNQQhSDSGufYNXYrtJw+5aBKbFM0sT06j7Q+8DaGTq0D51W
 syfGyxUxROlGJLyrI76585UcgR0WXfdGUboGRr7FxV3oa1oOdLqivYaYAk6flt6cYu/kutuK4
 M+pAJmeEyUk099iwcuLk3Jd6sS3VxR61/mvxcgqyWp6CTOJ09ufLUEw23nmjro4iT15jZMvqB
 eS2dbRk/2N15xh8QpZ9dHg3zsp7y8myd3DkTQxeBiqm0O4uP6CwC2hBBqyFYvTrKcooXdt2MY
 fhIpORlIQm1iu4nX3j/oqoe0Fvg5TT0juwbtbIOH1eNqSydbrZ9bIPNIo7daapbh/N8p3OY7I
 tqStV37SK4dYDtkUttXU4UQM33OsTQ8y8RdPWp8U0AlGWQCgOrmvAXiD9iYuL7s5h+Prmxs+4
 S37khkmGhKBW/HnLnZuYKuplvN5CG/ytQPKvxKlXHHmGxzKZ88D040zl2crcRcLEZccs0v85Q
 +8RAFZ/Fxum9LqELeWqrmKvsoTPkhRPYU84PxbhzF3JGromEmGqIVvWGBMkOYKOkt3lDhC9Cu
 TMIkSDJwG3nH1PF74A3ddqWanUNPNiotV0W/CtBPDs3cko3IAMBkIswuRDYbNtZazrlzyZIqv
 s4SP6nivTKBRiRdbVYE3C4qPDLR1WwErZadg8R6u2EXxp/0gfaqxg2aNYrjsSs3pGmWOEkc6J
 ZF5nc/ytHnb1dd9Y+t3HB4KxlOmBmpblgrujhESVmr2LEHYt8ACymzRK+4+2BWj9zk1vaWJ9V
 coKis01w0m9yXI/E1eU+FsXFQvYAZyuuaKa0KAkwhZ/qhPTVV0D2PlFsHuTjVV1PM/nXTIWmE
 ysxcvTXpS2bdvZLuOJAw3YEeiqBRpga3BOtiLhgCGa9T1b4zkXNuuIqTGn/1goDz05zCHKORd
 oL6ISW0DQTGLB1+k85LL7ENDnjhfM/3/pIJBLbpI2aleE4WFfVadZVRzqCdSGJkCCOamq/pxx
 HU4NtG5Gm/PEbrFPGz82dUjtN8yNA+I1YA8uuuXOA+765CkECfmE+b/57U/lRLRSlnPJrVhb9
 LN5B91ig3js3gU554DKimFsnoqlBHR5UwZ786kfEuLjVJm5s3UvnefKNAMvhFX167JwHMdS4U
 ZYDWV0/udcjgBKkkneDitrjfHOCRCfv6MVVCj/3+qve66v08UYvUEstbqAKfcoF4cn6NnkbYP
 +/20MWsreU94y7aRLQxgZfc2EvMjpb+4tHKzbOveyZ+u5XwPQ3J1GQgI+4KkabLqtEd40V36K
 dKt7A8nvad1WAJCTKINt3qiPUKVDKZ58GUgKWt4V5EUEVK/roKh0Ni4UMOPFPtOQulmcgN8fR
 He02zWm0kkR84dcjiaTSYo+KgBnGJ+KmwVz6Lm/Y09GWq0QdcZItwLhSeCgtkDdAIskNcNaJh
 TtrEWYk+hENfClGazC0cpoFjm9a1NgPm8yCU5JiNt6on7ocKoW8Pd4hUhJ9GSMhues6yxqLSv
 +UgY6YBHuBks/Up8zeqtau1qo8Ia7V6GfLwGoATwODJxIrLsC4wODzRn+M2/RPjEiv+g5XEzI
 PI/vRGUsj6A+2xModkYHlv5M8zlnX4H2bPQdV9WfChH

The MSE102x doesn't provide any SPI commands for interrupt handling.
So in case the interrupt fired before the driver requests the IRQ,
the interrupt will never fire again. In order to fix this always poll
for pending packets after opening the interface.

Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 89dc4c401a8d..92ebf1633159 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -509,6 +509,7 @@ static irqreturn_t mse102x_irq(int irq, void *_mse)
 static int mse102x_net_open(struct net_device *ndev)
 {
 	struct mse102x_net *mse =3D netdev_priv(ndev);
+	struct mse102x_net_spi *mses =3D to_mse102x_spi(mse);
 	int ret;
=20
 	ret =3D request_threaded_irq(ndev->irq, NULL, mse102x_irq, IRQF_ONESHOT,
@@ -524,6 +525,13 @@ static int mse102x_net_open(struct net_device *ndev)
=20
 	netif_carrier_on(ndev);
=20
+	/* The SPI interrupt can stuck in case of pending packet(s).
+	 * So poll for possible packet(s) to re-arm the interrupt.
+	 */
+	mutex_lock(&mses->lock);
+	mse102x_rx_pkt_spi(mse);
+	mutex_unlock(&mses->lock);
+
 	netif_dbg(mse, ifup, ndev, "network device up\n");
=20
 	return 0;
=2D-=20
2.34.1


