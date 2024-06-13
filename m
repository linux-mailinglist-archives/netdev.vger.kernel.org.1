Return-Path: <netdev+bounces-103075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B52906220
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 04:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097C42830C4
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 02:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E3F12BEA4;
	Thu, 13 Jun 2024 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="rgkV2iSr"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C933062
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718246951; cv=none; b=FZxLoJTd0EzbFSgjhOrFmPO1murdd6UeBP165oekYFvU730veib+UucRhmWlyt684SVRNX3w+gV+Mjtdc0SRT2OSuAO5qSixQ9NzyNTPAP583VOfE/WrZhLuQXa1+nlYZ9dGKrQQLu6DUQqfmll5qFpKMKJeP4NNzl5+BVhatdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718246951; c=relaxed/simple;
	bh=i41TnQyuzo72lyY6rLOnHW3byV4A0fg3iLGHfWTareE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iblkn4bcKdIUQF8i2DDvy/72uBjojYSw9Kn9mehybSSJXSf7UbnQtKmUsOp7yJnZeBCuqiNf/LY0oR942nb61R3pe3Fv8yKTvQyn5/UCU8eHt7xKhn5lHwLMR4LaomZPqjJdT4Dzj+ppArS0s7+WfD0UU7GaxDlCbnLXm75ZASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=rgkV2iSr; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 96DBF2C02AE;
	Thu, 13 Jun 2024 14:49:06 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718246946;
	bh=LdwNjTGIaey8kRU1x3WGCCMT9yyC8LcfYrwno3r0wHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgkV2iSrHo0KFEx7e6a7lV6gr91WTeVkS/JdS2kruKCBSTV+it41AcqnYnasgmM76
	 ID0/nguX6HyVJ6YEF+An1b3musb2fb3E7aDNTGsYQ8FzRfh4R21NfvRiyacOL/fdfS
	 okSo1+Ealr3uYBW41xlnsqBxWZrqNx8Y6bDDISXdQIGyDFAlwYQ8GZxGSkKNnB641a
	 okyiNfxAo1uG1oEdMa8KqW1NXSFWLrFG3uZ++V+1Q3yCsu24/u4hfeAfXPcbYU6hxX
	 hC2VfoiwVdkLQpW167XiiXQpt8u0kwIIC6zktdZZ4fjxVfRM4yEpYLRrocwvJm4UKk
	 XyQGqjsDFL95A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B666a5e220000>; Thu, 13 Jun 2024 14:49:06 +1200
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 7217613EDE9;
	Thu, 13 Jun 2024 14:49:06 +1200 (NZST)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 6D05D2A2270; Thu, 13 Jun 2024 14:49:06 +1200 (NZST)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: kuba@kernel.org
Cc: aryan.srivastava@alliedtelesis.co.nz,
	davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	mw@semihalf.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH v1] net: mvpp2: use slab_build_skb for oversized frames
Date: Thu, 13 Jun 2024 14:49:00 +1200
Message-ID: <20240613024900.3842238-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240611193318.5ed8003a@kernel.org>
References: <20240611193318.5ed8003a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=666a5e22 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=T1WGqf2p2xoA:10 a=nUjTbgbENZD28nTSGwIA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Setting frag_size to 0 to indicate kmalloc has been deprecated,
use slab_build_skb directly.

Fixes: ce098da1497c ("skbuff: Introduce slab_build_skb()")
Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
Changes in v1:
- Added Fixes tag

 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
index aca17082b9ec..05f4aa11b95c 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4001,7 +4001,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struc=
t napi_struct *napi,
 			}
 		}
=20
-		skb =3D build_skb(data, frag_size);
+		if (frag_size)
+			skb =3D build_skb(data, frag_size);
+		else
+			skb =3D slab_build_skb(data);
 		if (!skb) {
 			netdev_warn(port->dev, "skb build failed\n");
 			goto err_drop_frame;
--=20
2.43.2


