Return-Path: <netdev+bounces-122282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D052A96099A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F03628716A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B3D1A2844;
	Tue, 27 Aug 2024 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="alMtKGSj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA701A08C6
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760410; cv=none; b=bxQigsKVR1GzvZlFGlV2MtwMzigKrOJvE0gfakmhuJRPSQnwYsTZl2rtpaa3lAhyLWxNOiiMxiQirXg5mL9gYkm0H65irQHJViKPjbjzUgqjFa2i7vY9f6lucvCYSTS9mQstu6eWtv+IQsyaopV41PQtr1utSDEj9U9Abm67o28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760410; c=relaxed/simple;
	bh=XwxoLc0wzt2wo+3Tj9Lcvww9fx/PVTAodZ7I7IVHa/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pin++zp1lui54Y+LGaBwVOOkEyn5YyG6RvgtLjYWIq5g0mzeg5ENjGDG3pA/jtVrXT6lVGz9m8vR0pSLn2IO/dHVxAFIr2GwJ9Huw5RjcNz2d3NzKb1AhOOZJHqrA4V+4SJbWyhP+XaDYRWBNGJmr40AcaQOt8+UvYdxFdSQppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=alMtKGSj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280c55e488so29402755e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760407; x=1725365207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRUjbVsmHsrEffmbq8eRxnOHewDfpfyKdSqgab98o74=;
        b=alMtKGSjhicvfgvPlATG1QTmDc3wTX5zMYlNdxcfzyEgGsPKKeabhwMIWJp96IYo7f
         vuPA/ib1E6ojTVs4lRsfQkyvWCb8og9useVBPaGM7EXtzJJyt9I1fIFqOuAFfUuqe5Y6
         VWYNb5i5VZihMcL5Ad/J0gVB33VD7P4UFJ4sbomUc+QusChArjH/83Xef3YBzFtsYkTV
         PDcvbnEPdd1aHkFBBo71uYsAAsdH93YZ/JSVZqAnk32Rlq701hcsesZ4UdTH6TbRJgTQ
         gLCBHMI2NaSY75b7tKafPIe1Td8xTxhGiNKU+LlDCAzRKSbevnZqjHXGyfmLBTThXjje
         bXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760407; x=1725365207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRUjbVsmHsrEffmbq8eRxnOHewDfpfyKdSqgab98o74=;
        b=q2w10ZqD0AuZRL70Enqwfl4CCqfyBdUxs48H5fEt9uWUVAySwTc24nczeDRUuQFgd8
         Uem/263gMLuphby+q21qfREnDd3r93KBJGL2NM13ahgl+0Hjtxuij0kGPqDgqSNropJC
         8S7EftSia8ypULFQ9/t8RMbMmvMIJ5ZozhMnEJSOi1WwE4sFvwrwFzwXXrUiJr2aRqoF
         v4TO7iB1UpzyCMZd6vG+js67RCIfbFvRG2sc7sUygEYxIyURUvJNen7Ku4LchIMJEFXO
         s2psIapLX/ZdisB4ESi6Frjrato5uUNIyYAVV3fkXDBJP6BuE/dwsPqmdqf/N8hSPZe6
         vMgg==
X-Gm-Message-State: AOJu0YxwTRAVPAZDCOb04kOr9TZoaoBe0AsJeyfwubiHyNBnyE4wGbsP
	sgzyBj9CwpnUlcsmuvTqhhIlfVN38RB3Tu8wCUAYKj6AmHsnDmNXHXg5e0wFIokw8Umc7N2OaX5
	p
X-Google-Smtp-Source: AGHT+IEBUNtjhCPDcbgEYQ9YYCERPPsiwg9jXG2P1hnFIkbXHv1byMx4T2SyxeY8s4HrQwmDWB4Jdg==
X-Received: by 2002:a05:600c:35c1:b0:429:ea2e:36e1 with SMTP id 5b1f17b1804b1-42b9a681fc7mr16055555e9.13.1724760406817;
        Tue, 27 Aug 2024 05:06:46 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:06:46 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v6 07/25] ovpn: keep carrier always on
Date: Tue, 27 Aug 2024 14:07:47 +0200
Message-ID: <20240827120805.13681-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120805.13681-1-antonio@openvpn.net>
References: <20240827120805.13681-1-antonio@openvpn.net>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index f22259d76a0c..bcc90307c108 100644
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


