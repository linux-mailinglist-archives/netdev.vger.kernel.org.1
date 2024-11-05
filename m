Return-Path: <netdev+bounces-142038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C5D9BD270
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3990728401B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB34E1D9593;
	Tue,  5 Nov 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="OfqEOI+O"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE5D1D79B6;
	Tue,  5 Nov 2024 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824567; cv=none; b=sDapxP1mK+0CKVDAyKtVz+0HTQFndehysismY1tsHfptarZ3UP825O5ngQbkO9Kay0Ff8kFRfD92N6iDyuWxNBa/vJazSJ8V0ld7kYmX4xG0Nv8Yd1xUYJ10RJrVKDLZoG26TZOb/5NjQV/cEzepDV/R4cBSsWkigubEkK8Vdlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824567; c=relaxed/simple;
	bh=zBgug8KxOCsF2I+ttYqXDlHbomg2YCqtrPYDrbR4hKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zc0xByabEol19hMLXiIqCw1nE1B+1rNrwJky3H72I4XyFEdNv8agzwNIaUB0un/4uzUyvvCkrErsH9NQrHpXwPoum+aAu2knT1xprwWa+FzKSjjCypCE0Gn04X6wcvXT3MlrbHlMl7ThRcVfOvW6snXFt9Nsc2aIL39xLR9toRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=OfqEOI+O; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730824552; x=1731429352; i=wahrenst@gmx.net;
	bh=O/VqUoOSYgCxS0PztdZQLikh7kxbi09He3zNeGJYB94=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OfqEOI+OPmzYrU3On4qmGjvHXpURK9aQtx84Sff1feBmdbuPn116yLRDBxzyQ5mP
	 P8PXK0c9mDOSh4QjyqZ8Gcax+GJKYxBqHHFPXF6C+hPBgsyjL/cWU7LXo8+ODxHVY
	 4oOdxh7upnvMRA9e66cEK7zo2uvi3bFhcUl+/lGy+kFiJyScGonkbWbxBAHNfs7KN
	 bmkU+EwyfV3hpuMgJMG9KYN9EaAz7o2f3NzE+FSjg8iMCz0oir52mp4ecw+l/20cf
	 lu4B+QWx174PBvZu7CkwkT+iR3dD4F6IMP0vz5zwucd+CZqOCLlPusUmLsjn6EYF5
	 JuIZqMbS0cc6vdoWgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO24-1tb8pk333A-00gmLe; Tue, 05
 Nov 2024 17:35:52 +0100
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
Subject: [PATCH 2/2 net V2] net: vertexcom: mse102x: Fix tx_bytes calculation
Date: Tue,  5 Nov 2024 17:35:45 +0100
Message-Id: <20241105163545.33585-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105163545.33585-1-wahrenst@gmx.net>
References: <20241105163101.33216-1-wahrenst@gmx.net>
 <20241105163545.33585-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T6KvPqfzhbKPBZgam3WhN578u3fdkzZ3uYPiNaWCoonzwBK4moZ
 jzEKua6rYJGfz4N9DB1dEpE8sAF6uFuH07tzbN8AeIrEj7JPoI8W/aR0aNOTSvHu37knYSn
 e1uJolmILYDr9Qt4TliGRJ4B3DSKPumlm/W2KU9WfAk+wTtRxQY6b1t2BrdISNiKUTTG/YI
 DtUS90YIOfwbLqYJzS5Yg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d/xs1y8J3Y8=;9Hj4r5dZbtai7O/6AU2QhC8+KWs
 /uYygDK2dVSlb9qP38qbbdwBqFzaEgXydtg9sZ+XUy2JKiIJIslQMKcnUES/w3G0WuDcJDdCu
 BdM+DrfIrHV85vGJSUI2XuftRwlpUQZNly91CCMUYnngl2Aj3kkEFJ7rYsQvrY4Bi3yioUd2A
 Fs4jhk2vY9QeC9K5FuwXz+zR0ypeqMSNcxlXPCORV82r8srtdms/V8iwu5AuqCe58Siuj+Qny
 VPGuK/PllLX6v5Y/CNJOQoaeMIalqSZ27VxPUjt5Y/TlMWOHLfzamx6p61H2XfNx5u1wYNT8W
 H4MhooGBAXwT3ZOJOaRRJG3HoisjzBmSgNGmLHCYBUZqH0AWnMkj5CaXOiDGl6zYv9NeYWneW
 2hn6F5hdK+kIJwynAALJZjHBI7hms65fCZLDlKT8c+pMMtE63QbB3U3ZImgjGudEGwtlDPTwb
 tfZcAw52ZdpBn/UxzJhdz3MPuFsuv6qpSRxqkwux2o6aAJoVQVm1e6kCYSXwVr9DOX24qU6uu
 MemEZJ8IR62VHSKNTL8FmFVF1N2HrBdWseDOkMV/ZnAvLjEYPwQgyg1VzOD/CISKL4cJILNAp
 MMW50F+8wx2nEW8PBZ2fmD2ZPGeFscoTqb0TON+grAElYF+tDRqpv0TePHN0n94i8NCctB8BI
 rYs2F3R7VnZ+IiJO6jNSYlSEg+Pqmo+S/omR4yNtYq2aWFRKNnpYc2dZCTp63W4eyX8KH3bHm
 RNROC5TMwQZoJFz8nQnOljGawVo1FFq/tfT75shbpxpIE2zEwcdyWxXVf8YQFgJ9ZkHTXveLt
 LQecTtWn9hppmFOQROdsEU9Q==

The tx_bytes should consider the actual size of the Ethernet frames
without the SPI encapsulation. But we still need to take care of
Ethernet padding.

Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 2c37957478fb..1fffae6596de 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -443,7 +443,8 @@ static void mse102x_tx_work(struct work_struct *work)
 		if (ret) {
 			mse->ndev->stats.tx_dropped++;
 		} else {
-			mse->ndev->stats.tx_bytes +=3D txb->len;
+			mse->ndev->stats.tx_bytes +=3D max_t(unsigned int,
+							   txb->len, ETH_ZLEN);
 			mse->ndev->stats.tx_packets++;
 		}

=2D-
2.34.1


