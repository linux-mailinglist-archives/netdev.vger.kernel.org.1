Return-Path: <netdev+bounces-107267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D991A751
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AAC1C23037
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C310187543;
	Thu, 27 Jun 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="e83hIWcp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578E18754E
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493678; cv=none; b=GTBbLGUMXDKjDGgVlVdV/gMFrg45RSlOkMw6ElZSMcZHnbOaRqQSt/Zy2knO5Us/QONL/qy9J5NV/m8tOnmjYbmROYSssOShhqiLGmRb39IZny+1/0/ByziirlFZ4fPsPyW1x2UiEbDeqgmFzmfk5+iWWuIbHK4n/Im3cT0FXyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493678; c=relaxed/simple;
	bh=hVNGcW4+EE4t7g9/WDNUt292tXLE01iqI+ySm/i3fS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuHpqXwo3+0rfb+OP7S7etH3VDepg4QGbjO//K5feDZ9yrX6260Imk5iclNJJEYmCiJhdZzhvP/1in3eB1E/pwP/S7vbuh4cZrdrhYlVAHX898eCmstZaV/RfBuD5JgxrTOjj7IIPtAAPMEL9HvVRZ+S2e9rkjd+gl4VBE+Opm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=e83hIWcp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso11496625e9.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719493674; x=1720098474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjYfRpz7d/pnzQIIVZvDS+ZUuV4pfFWfqrT+udRi1Ik=;
        b=e83hIWcpyd9TCtD8uQtxCO718f9zgenrVfztCnuK6IEWi1EPRoBW+vAOb4JhxBTtVl
         vLmn+fgIR3hZesYPXcwxKTBGqTF/dcA50ozDwDByclu7eFNXCiHq0SEe8XWsDMe1hILp
         OWx4rqt6Cxxd2M5Yl9XU3vvalZjt9OY0gcg+pAmVqXuBHtwopRGSoAmUJy8+kkNDp5cE
         /xoFYUi3oizzhlK2Z+rooDfQL7zC23HJww+/nWc9MOUyUPK87YUbalmjHgIsdpJie2Se
         QTgnPb76s8zbaL2W1m1Op3uVSSguCVN3sMq9I+4oZ7253QZmPSJNv4Tkp+syJW+W+JZW
         EtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493674; x=1720098474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjYfRpz7d/pnzQIIVZvDS+ZUuV4pfFWfqrT+udRi1Ik=;
        b=tBrzfRMt73f7CcLUEl2Fz9+GU7sPpt31NwShQEqO+AmmuBtmthE0uaMREjH6jWEib2
         HV5bg+YUI945kOMf91DyHs87lgGtmYs7hRfvdjgTffe2XjBVtpvdpE8BDW22Rc1mYgiI
         pPpAkTzgTKMWJGMPu7ONxM0VaA1eSTSzYf8ocKtVafgpSDFJuh6N31uzv6KB50Dn3Vsf
         p69IdFfh/xVvcLO5RLW7v7nbhDOUMnFHrpEUty5KnZf8ylWAp8N1kVwc1cldkKOSEd+B
         lk1IxBpMnt7EwL6s96VE3gAyHeCWv7XFQGgVQal16fshOheD0e6aGfLRVN/T9eljDYEc
         n/5A==
X-Gm-Message-State: AOJu0Yxq4EWIX10rBV+76bneM59JVse4EwprVH83gy+4MkNY2b0vyR0v
	8Q9mRNgQLfpkqoaM7y2uIPevDgoQTOyQ07lvJ6ECjhlGwkBHKeaSoFhtjEcgPQshjGInhKr450S
	p
X-Google-Smtp-Source: AGHT+IGPlxlquhvNuL2EBgJ9dFbRCpsMvVvinfOGj3ekkahIYf5tnaY1u98ZSlfizKISKin9fXJ9OQ==
X-Received: by 2002:a05:600c:4496:b0:424:a578:fc1 with SMTP id 5b1f17b1804b1-424a5781096mr43902985e9.25.1719493674478;
        Thu, 27 Jun 2024 06:07:54 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b6583asm26177475e9.15.2024.06.27.06.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:07:54 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v5 07/25] ovpn: keep carrier always on
Date: Thu, 27 Jun 2024 15:08:25 +0200
Message-ID: <20240627130843.21042-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240627130843.21042-1-antonio@openvpn.net>
References: <20240627130843.21042-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An ovpn interface will keep carrier always on and let the user
decide when an interface should be considered disconnected.

This way, even if an ovpn interface is not connected to any peer,
it can still retain all IPs and routes and thus prevent any data
leak.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 7e3e9963d2fc..d0abe8b91a86 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -50,6 +50,13 @@ static void ovpn_struct_free(struct net_device *net)
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	/* ovpn keeps the carrier always on to avoid losing IP or route
+	 * configuration upon disconnection. This way it can prevent leaks
+	 * of traffic outside of the VPN tunnel.
+	 * The user may override this behaviour by tearing down the interface
+	 * manually.
+	 */
+	netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }
-- 
2.44.2


