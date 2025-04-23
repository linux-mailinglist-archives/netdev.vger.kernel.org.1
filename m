Return-Path: <netdev+bounces-185008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833ACA98175
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D4A17BCA7
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B8226B2AC;
	Wed, 23 Apr 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="MuAoy5Jn"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1426A0D1;
	Wed, 23 Apr 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394391; cv=none; b=aPZmB7kcjHVCBFgalSf89k82xYCQqQCotUH2dfm6pJk/ek7qUjyuTb7FP5uvsmH60cT4j5vr3uk8CUExFpQAatz5dM6ttGSCWlb8HXI1nm2I3bkedlGY/6v/6989muzcXQeOvckxnlE1F3V//+qVZafZwW18oNI99fTsLlcYohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394391; c=relaxed/simple;
	bh=Ga2o5j3jSKoAno2xpRj2CfQ50rnP6/DQsQlw0yMjgQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z4kFkROvChjnXzihtul8EohUDqeT1xf35hoR2iAPLzG/8uOdI53++9E2N3LO0bO2AcT4RtF6q26MI20kOJwLHy8y8P0H1v4nqZZUcExTf98GOPpsEF55OfE8zgnuvyItzCirM6ne3CqC41PrJpBCJkpx3NYog3ArUszRTS2/qy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=MuAoy5Jn; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1745394378; x=1745999178; i=wahrenst@gmx.net;
	bh=MhSlQAd0W28TE1r//syKzr2OZo839iGIpMX9nJi+1LU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MuAoy5JneK7zxO9zIcuzF2SmnMtcEyBuQfyKWs1nH2ZGowhxs+4jqV9/458sysvl
	 gaPOjQYB1qdlDUX2k3lrXz9dY/oe2IwQGKroPFTu7Ekj9Kk805ArDy11IfEDneNm7
	 7PYDb8dobYTxyCpGiYV4V87mXiVR4oa+t/6myW+IfwK5nmKNeijIyWcqmcYR4rt4V
	 kyl1Gl0K+OlqtFk1qDetX7MuMD19MQQdevsyqE52dOChf/4BsCWEj/qkmJzoP35ju
	 UkHWWtyzO8kU77Gf/tix+y3WxvcquIMAVcmpmQ8y5bZ7ItSgNY2Zymh82sslrukjL
	 ejh960uPawZ0J+KfsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1vDMr70BiZ-00uxvJ; Wed, 23
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
Subject: [PATCH net 0/5] net: vertexcom: mse102x: Fix RX handling
Date: Wed, 23 Apr 2025 09:45:48 +0200
Message-Id: <20250423074553.8585-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dYqEZO5Zb96sbjeghkbjZKb08HCZCpLUDP70OPkIgjc8rCesMRl
 9lD80UDX+11hDF4e58hE8Bx/2ONOhRZ+XvvbRkshgVtmUlfLJP71792jP6EeFpw6kvuapdM
 zJBAg8FJ8cuv2RFH4+YDssDSZtOcb5OdRTH8xV05pZe3P0D2ij+l8QKSKNBliZ9RMt1RZrK
 UOnNes8ZLw6n9uqne73+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6mYsuqFexdk=;npqHsc2u80cSCTUPjKzlhOQojy4
 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
 OwPha5IPWiAko+7xdjdcVL7rtl980vI=

The series contains substantial fixes for the RX handling of
the Vertexcom MSE102x.

Stefan Wahren (5):
  net: vertexcom: mse102x: Fix possible stuck of SPI interrupt
  dt-bindings: vertexcom-mse102x: Fix IRQ type in example
  net: vertexcom: mse102x: Fix LEN_MASK
  net: vertexcom: mse102x: Add range check for CMD_RTS
  net: vertexcom: mse102x: Fix RX error handling

 .../bindings/net/vertexcom-mse102x.yaml       |  2 +-
 drivers/net/ethernet/vertexcom/mse102x.c      | 36 +++++++++++++++----
 2 files changed, 30 insertions(+), 8 deletions(-)

=2D-=20
2.34.1


