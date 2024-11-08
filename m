Return-Path: <netdev+bounces-143276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5743A9C1C66
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09AB51F243D4
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8A51E570E;
	Fri,  8 Nov 2024 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="SYWN0siX"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05111E411C;
	Fri,  8 Nov 2024 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066275; cv=none; b=DfiJts6dbznKmqBZpxvH3pba1S4S/HqWWRW6+2KU5eSr2Bf/gfJugFzRQBgT7DVLCWx9SF9gUkvfpPDolO2yhiotiECO1yXep0FrsfAja6VlH5u3x3j38agOcWmXkNbYMPmQidCRbuTiK4OLljsD/spOO+HOVVrJ/giAJyu/tHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066275; c=relaxed/simple;
	bh=ET0Gze8UybLDnkwy0IpjRPcSFYxnsiDuor290UOR6Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KskwNapCyDMnvUyZ7p1BwGQzCv3wyw9GZTVKtHSn9CGvjZF/PWxgfhdOiMBJGB7tbiU2n5e8/dKLI5J8/SyCMlDR4SONPNoiyqWUW2k0r/qUA6W60K6tyIndlx14dCIE/WF3shptuBpdrqohCMX3lh+DhrwDzKJD82vs2sl0Qz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=SYWN0siX; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1731066257; x=1731671057; i=wahrenst@gmx.net;
	bh=6+biLB2vyBnJg099YjFn/sMIkw5aGC948JMXqyUDMIY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SYWN0siXazfn5QHdURtBn8gTFWjKmjMlzGcJfWItWc2VHUJtYsFrDxupqwif1ITA
	 0PzES3iRbNPyjSZdWZV/sAnu3NyDhQAgwLDflzWyxkbHJK5VSgsmezLesJR2XdqE+
	 04SPnUDGez82HXZrl4JCgLg7dgQ39ugDOT7ki1kzb/oFaWVVpG/JrqZjJzq91IBMm
	 t0XOyOI7UqU429HIdqstMu3FOmKfAfWlGDMqLAurN3KRIvc3AdBSPA6m83xmNhw1Q
	 yBmfxwy5hihjopFsYF3I1cHbnJUs9II5KG/XePe7Sp8/8KqnJy+G2RxRDGa31qXxq
	 olt7J/9ie6jqAxzDcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1t7iih32wE-006ImT; Fri, 08
 Nov 2024 12:44:17 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 0/2 net V3] net: vertexcom: mse102x: Fix mse102x_tx_work
Date: Fri,  8 Nov 2024 12:43:41 +0100
Message-Id: <20241108114343.6174-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2IqqhzABu7eQtaqe+l6Jab/0sgkUNniKw+7jJYZbfhrEsZ8UEU9
 0FXgnxIZnQlTSVAwleBPRSHqFayAYVFo5ApyyEq8gqu/anoWabAOssR1jAQZXFhUPBfZMuy
 v6FOYM/ZyWziJLMqECymuJNHDx2R56I73Q51hPeU3XUo1Hc8MP/DVSQ5tMNdsm4XdDHPwTw
 mqLnMsCrZYLmSjTI6QhcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BCnJ9HftvfE=;gwpFbdIPjIpMDzZCVlOQ0r+sfE5
 GwaJAaW/2RTDS4wH9V0CCIe3S7zxQWgo02GykfgT8/BwnMcWoS4LuLPSZ+oNT+NORU69kvb/l
 db2i0/+pgNyXSjqyrEsRt/aMfyk9gStqVcFqMdIZ0S++Nr64e7gaGkdLdu8hrNuMRpxvqzkS0
 CVm4YeT4TwxaxO0gn6KPfgYTM2wOXk2F2cIm/R5M5SLavIbe3tOeGTF5T9TanNHp5Pf/LQhww
 pTr0/iGo/lISmrjhDQKohOqFrlGzed93KCP+htv9B+WR7WiEwdAB93SjCxvLnuLwNAHrT/1cf
 M7Bha2/AwJXoZSfRxr8FNLvxjzpisRUpldqakCdeBJxB9n2qD2303eZ5QeMkUsYgt9DhUZtey
 tnk8iLJoA1lXgmMDuyNUJpHhGNlHh4iY430xxnTvU4LbSOv7uI+/luq0faANrg94n8JuigR+J
 pekquenf2dxvjgeXjxVJUGBGZeoZ7siDktG8IaKuxFxAxEG9HZPn0rMxv/+3My5qoQyp4DS7c
 1r2v8efuFXkWtzxAmYv7Tj0E9HQPEyXpX5J/8QfarZau822mxe+tDZGYnpwRcMU1A4wst/cC/
 XnPPoTAGx9/+d4vJFNxmlmW2XyFSFRMFEtnDG2BVSBuAg8AtJcdXAcfWOsPGzw0YbQqfkUkDe
 BF0xn35NT/SN7Scw9zDNSABVMHP7P7B4iMjdF4KB1YozhIUiuo0GkjrAWTYnf3IXUe+3VhaDq
 Nm8TmIG9YPEdxrupSIZ4PMJ/e+gFbp//xS8OG+5o/YWUHmDy+lRITx1SV5faPGXaUpBYTn5Kl
 M8WIJA3XJDLDPag3NcgHWJbQ==

This fixes two issue in the TX path of the Vertexcom MSE102x driver.

Initial version:
https://lore.kernel.org/netdev/20241022155242.33729-1-wahrenst@gmx.net/

Changes in V3:
- use a temporary variable to store the "original" skb len in
  patch 2 as suggested by Jakub Kicinski

Changes in V2:
- free the temporary skb in patch 1 in order to minimize changes
  as suggested by Jakub Kicinski
- add patch 2 to also fix the tx_bytes calculation

Stefan Wahren (2):
  net: vertexcom: mse102x: Fix possible double free of TX skb
  net: vertexcom: mse102x: Fix tx_bytes calculation

 drivers/net/ethernet/vertexcom/mse102x.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

=2D-
2.34.1


