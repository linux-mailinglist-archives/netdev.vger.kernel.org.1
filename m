Return-Path: <netdev+bounces-113699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775C193F99E
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342E6282E30
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CE915A84D;
	Mon, 29 Jul 2024 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="HwAt/1Ok"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51003158A3C
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267497; cv=none; b=c+Ud94FGOGFcifu4VL8/p5nn0XhTJsSqrHlUxjrDrbQTzvKfvo+slFcHcny2DBtUpVFszCSODY0FecyWrs8/yazaQkFbH9WBXlc5Ru81yXF1xrEBCg1rQ36UFpYIrm9cbZ+2prW4cKHs/6uT7yYVCygklbj1yChsI7LpnP8uq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267497; c=relaxed/simple;
	bh=iTT+MBvvVbh60MfgyqrVLxu2PYAR87uA1Il2SSsa7KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFWnVX7UpsH8S3CH4qfL7+pOpKfgfolCTZ+oIcrvZUGOhd31nZhdabBlGPMDPN/D537O0BidEp8eT0R/UqPusUkUlLlDVNg0U7Aa6kiXytt/8e05jL0Hzp6JOi87HhZsq61adVd0PiDDd012taAmCLwtc8smzgylLcBCrZUkhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=HwAt/1Ok; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 795787DCB6;
	Mon, 29 Jul 2024 16:38:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267495; bh=iTT+MBvvVbh60MfgyqrVLxu2PYAR87uA1Il2SSsa7KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2004/15]=20l2tp:=20don't=20use=20tunnel=20socket=20sk_user
	 _data=20in=20ppp=20procfs=20output|Date:=20Mon,=2029=20Jul=202024=
	 2016:38:03=20+0100|Message-Id:=20<4ee33c3696f7d2d75d4b553b977c8aff
	 8193477c.1722265212.git.jchapman@katalix.com>|In-Reply-To:=20<cove
	 r.1722265212.git.jchapman@katalix.com>|References:=20<cover.172226
	 5212.git.jchapman@katalix.com>|MIME-Version:=201.0;
	b=HwAt/1OkAVJvU+hWgs5k+0ywOPtUSGor77R3aXJXYFDoINGIIKxj1WtOBQuy89YjT
	 ykYJaLS4eUAmvpWz6VYrE7puF8ki8+xmJR7eg32K6EIoRibAllmLsQU9lQpv8lWQmZ
	 dNBsDWWEJF4zdh9SjUdOq/PX119/T6Uz3fG32EXWUPKDP/ZTH0yMOA2Q3j4z9syxuh
	 KU/42LKRFf08Kb2Au+iVJw5NjPx30qQHOesc34nXuY1/BnxIw395F7X1kS0ry3cLht
	 uMup3lmnpGxUl/0QmwDy/wTbTVkqasFl+9JdGl6vIV86INst0jissYasTormMaeQay
	 leKSjdOl1l2Og==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 04/15] l2tp: don't use tunnel socket sk_user_data in ppp procfs output
Date: Mon, 29 Jul 2024 16:38:03 +0100
Message-Id: <4ee33c3696f7d2d75d4b553b977c8aff8193477c.1722265212.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722265212.git.jchapman@katalix.com>
References: <cover.1722265212.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp's ppp procfs output can be used to show internal state of
pppol2tp. It includes a 'user-data-ok' field, which is derived from
the tunnel socket's sk_user_data being non-NULL. Use tunnel->sock
being non-NULL to indicate this instead.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_ppp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 3596290047b2..0844b86cd0a6 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1513,7 +1513,7 @@ static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "\nTUNNEL '%s', %c %d\n",
 		   tunnel->name,
-		   (tunnel == tunnel->sock->sk_user_data) ? 'Y' : 'N',
+		   tunnel->sock ? 'Y' : 'N',
 		   refcount_read(&tunnel->ref_count) - 1);
 	seq_printf(m, " %08x %ld/%ld/%ld %ld/%ld/%ld\n",
 		   0,
-- 
2.34.1


