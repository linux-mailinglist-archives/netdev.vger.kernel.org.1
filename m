Return-Path: <netdev+bounces-106072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5AC9148AA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89281F23226
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF9E13A3F4;
	Mon, 24 Jun 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AO3vumtR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D313A3E3
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228588; cv=none; b=nKf+eaJJH8sY1fKB/LmaLM2EZM1DF8KqhLnp4J9nOgb2IZOwFUnWAPGkxQu8h53bsb4I9LI8Ano+pH5HZudGhhDbNM37Ko2OF+ykWS4CQVSbEhdyJVz74ERT5+V0n+CeyIFgx14tFWRmA4K8rr51LOnIcxGFZqY0CFkNENQNTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228588; c=relaxed/simple;
	bh=XXwpUhM31bW2Piiqd+8cOJ6+ulZZMITgIuIybhrzrB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJIP+lAa32sGK/7quvihkqeKcra+CcharJRDLy44eTeC6Tpz07O9zXP/QT0nL40Vw3FDFUmPBEnlcYafdI7iO3wV7UsiaUpIGabMXlNGxjKy2xX0ATS7/90Zg+XK/quKRTZZ2ORsfkq/sSxPfz+iHThFgNxSuNEMCCLUpNFCF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AO3vumtR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-361785bfa71so3187424f8f.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228584; x=1719833384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woK5EokpP7Oj+IDQQmUPUDM5W2CzY1qhohWhjnlCr0s=;
        b=AO3vumtRwpZ5cUS6XBr8LDFZhIsub4HAhaZAir8AwYR7K/dr4Xt0JPykJY/pyojFUa
         mDam7muIzj5hFB7Dlgdlaft7IOMxEtTzV3MICZODW+Eoh908Ls6veCZFvcTZh5wvxvmq
         bKQFCpy1zGRvOTrwhVB1EhgH0GUDX7wLyjfxU0SnCUGeZe1n06JWLGm0ybk+7XDosCSU
         /wiRY6NwbzSljNTaCj4af7tAuy7b0bMlRKwC9IcINZxlY6Qj+/bVCR/7HxV/GJDw8Nnw
         kzRr/19hknZa3HL+If6M8lvV551VKJtTeRKRhb4kfXx+0NMH9T24/l9q6z/iuyHjHo4m
         5f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228584; x=1719833384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woK5EokpP7Oj+IDQQmUPUDM5W2CzY1qhohWhjnlCr0s=;
        b=vi6E2ahCrWunTrC7Kl68q8d2P87bqalnI3rseuFx0evuLl1WP9hCz4SPN7KSqk1rN9
         s7mbKkOm3DFqus5xEtwmaDUXGLcE2Di7/CVZLXhIn34l5lqcgKUu7It4SxVMMHp4r4kS
         WXBM8DQ6Qe9D/w6CHhhOc30O2zYabQzt6eCO8fsUlPcXt4odIum4fFQOldIaXVYIvUly
         snk6DF976UDXkZ5ifgI35HmnM23PMmSiFgxAdQQjlVhIeBot4ZjLZfPCHmygq0WafXzF
         xahb1l3U6Ohvl04LhyVq+GamHvxSU4BtVBb1+ohijYuQ+OsjFtOY1A3dBOU827LukZ0A
         Y9Ig==
X-Gm-Message-State: AOJu0Yzf4pXJuYnfiXX54LR2EGWkkDNdBD5HufWtCarYY04MCRGa0qgh
	zj0tHbep0l7pNrzJzg3HikE3H5fW/exgxKV0Js7rHFxSzjuJfm6OJWySHs3qLTafqv7HPZMnUNK
	c
X-Google-Smtp-Source: AGHT+IG0qD1g+ylk7u2bo9AqZ5sBl/Qx2bGeTJbG7G7jva+td8Z8kMmKC5HkLl+iC29Yjm8KvRLs3A==
X-Received: by 2002:a05:6000:a83:b0:365:e76b:e908 with SMTP id ffacd0b85a97d-366e79fe983mr3073333f8f.24.1719228584413;
        Mon, 24 Jun 2024 04:29:44 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:29:44 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 02/25] rtnetlink: don't crash on unregister if no dellink exists
Date: Mon, 24 Jun 2024 13:30:59 +0200
Message-ID: <20240624113122.12732-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_unregister_ops calls __rtnl_links_kill which calls
unconditionally ops->dellink on any related interface.

However, if a module hasn't implemented dellink, this
invocation will crash.

Add a check to avoid calling dellink when NULL and rather
invoke netdevice_unregister_queue to schedule unregistering
the device as usual.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 net/core/rtnetlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index eabfc8290f5e..be79c2a051b2 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -453,8 +453,12 @@ static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops)
 	LIST_HEAD(list_kill);
 
 	for_each_netdev(net, dev) {
-		if (dev->rtnl_link_ops == ops)
-			ops->dellink(dev, &list_kill);
+		if (dev->rtnl_link_ops == ops) {
+			if (ops->dellink)
+				ops->dellink(dev, &list_kill);
+			else
+				unregister_netdevice_queue(dev, &list_kill);
+		}
 	}
 	unregister_netdevice_many(&list_kill);
 }
-- 
2.44.2


