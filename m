Return-Path: <netdev+bounces-105214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E3791026C
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2841F2128D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9591A1AB539;
	Thu, 20 Jun 2024 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="KawJvG1n"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0663040858
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882574; cv=none; b=HFwA37ea3bYqtwQZ4k4BgaEkAgzEahvT/OROqEaEHlMTkUtCriOvygOuT9bYdjFsl4YL6N6MJY5CVcXYt/OfY9vLDpUpIcjm6vaIXfnurgn5lDXzXveoqF9of1zBAVBvLbs7owuRdyJTK3FiHKhhLsHsy+UKdjL6v1nXFog8ghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882574; c=relaxed/simple;
	bh=ZDWkuludQ9F11fb/xY48nVSfjmsVOYr5oQoVk0TFdks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P2qUTFc60zMqIGDXihfVxih/q9vuzS+5oxpdv/kLDgRdVU6fbN7izXHNc7KGEwIWcYaSceys7MV9tYpSe00Enx3eTSDFU1dcMwoO+CSiCcim213QELI73v+gruaB9JazCPHyf7AI47mLYnzkG7yFXz35Rmuc4Qu4vsW6Rp8xGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=KawJvG1n; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:530f:c40e:e1d0:8f13])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id BF1497DBA8;
	Thu, 20 Jun 2024 12:22:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1718882565; bh=ZDWkuludQ9F11fb/xY48nVSfjmsVOYr5oQoVk0TFdks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20gnault@redhat.com,=0D=0A=09samuel.thibault@ens-
	 lyon.org,=0D=0A=09ridge.kennedy@alliedtelesis.co.nz|Subject:=20[PA
	 TCH=20net-next=205/8]=20l2tp:=20don't=20use=20sk_user_data=20in=20
	 l2tp_udp_encap_err_recv|Date:=20Thu,=2020=20Jun=202024=2012:22:41=
	 20+0100|Message-Id:=20<64bd5a94be8b52f4c401737333246939367cdaec.17
	 18877398.git.jchapman@katalix.com>|In-Reply-To:=20<cover.171887739
	 8.git.jchapman@katalix.com>|References:=20<cover.1718877398.git.jc
	 hapman@katalix.com>|MIME-Version:=201.0;
	b=KawJvG1nN735/Jv/MAyeHD4W7fNfnf16RztoamsyXGiu4qYAGLpqCvdyIJjilf+XL
	 OeWdKk6RaAKSIMw4AB7MFR8StW1/pzbzS3M6LQEmtMF0gcPx5y8Bm43YBkYmlA5dGV
	 UQCcSckXPLmUT0RBL9ekmTnKQx6V8wkIENlPcMnbcwA3jdv1uctQlIFlJsZczZDu58
	 ZWTZCXPWKqgf5Te4yhggrTQ5WbzZkSMWpcGFzo8Ljwe5yZ3H/gZWPt70ppsVftsjte
	 UdT6BpL6iybk1O4fxRsmbEZF3gb4K1oT7r9pf/c9wBiI8Dfab/leIdCQ4zCCj7splN
	 VPZzUBCfGgE0g==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: gnault@redhat.com,
	samuel.thibault@ens-lyon.org,
	ridge.kennedy@alliedtelesis.co.nz
Subject: [PATCH net-next 5/8] l2tp: don't use sk_user_data in l2tp_udp_encap_err_recv
Date: Thu, 20 Jun 2024 12:22:41 +0100
Message-Id: <64bd5a94be8b52f4c401737333246939367cdaec.1718877398.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718877398.git.jchapman@katalix.com>
References: <cover.1718877398.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If UDP sockets are aliased, sk might be the wrong socket. There's no
benefit to using sk_user_data to do some checks on the associated
tunnel context. Just report the error anyway, like udp core does.

Signed-off-by: James Chapman <jchapman@katalix.com>
Reviewed-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 2c6378a9f384..cbc5de1373cd 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1030,12 +1030,6 @@ EXPORT_SYMBOL_GPL(l2tp_udp_encap_recv);
 static void l2tp_udp_encap_err_recv(struct sock *sk, struct sk_buff *skb, int err,
 				    __be16 port, u32 info, u8 *payload)
 {
-	struct l2tp_tunnel *tunnel;
-
-	tunnel = rcu_dereference_sk_user_data(sk);
-	if (!tunnel || tunnel->fd < 0)
-		return;
-
 	sk->sk_err = err;
 	sk_error_report(sk);
 
-- 
2.34.1


