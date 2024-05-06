Return-Path: <netdev+bounces-93562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C288BC549
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD591F21B9A
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0793BBFB;
	Mon,  6 May 2024 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="W4fvz1z3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856173BBD2
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958140; cv=none; b=Zn0A5ZEwzAB2VdOi7YYvykiDGIZfY4ZDQzH1Fnzw7+3Ra5anOoQa5lhxYBmXv946JCEvOMlKMeBoxMi0rdNw7PY8Wwpo1GZ7PcxOoDXn6Er86WK4V6zHYx7cS8ciLLqXisu8nn7QlrEAov5c5sbKxpe2uaiv4s/EdAUHXNNV/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958140; c=relaxed/simple;
	bh=f6d6PJ2zzf14ouQ8eoRcdxOXiHNNdOT0+N7g5VQ0760=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6xhThrYchNPBO23TjYLqZXMMZw5pqdcOoFMQbU0GTN2LWDZ2WqN0AuizTsWvf2C80Ic8lyhllROiVC1BRd+pwliGbFPwvBHFvz4AjxcNwY9/gHdsi4oPFoiVmKxV3adzFehiopGDA1F8tscBz6jgIKIIKlsX9ClnQChPY8HHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=W4fvz1z3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34dc8d3fbf1so1192263f8f.1
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958136; x=1715562936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlGPvOT+kgjSxh4YhpfMrvYca0NKJF9WiB2Pr3HjiSI=;
        b=W4fvz1z3H9KqMnoO4+4Z65tZaB7A72267TBmXtkVjmDu3wJ9p8yM0+xL4kSvm8OYyu
         awgHWW0dRFy4mbwXO3EknTSFZBiXhMmaohUvpwteOj+IImjPgFUF2S/oCmqGBA3GWLQu
         zCbzoPT0HM+4hWgIhxFrvYFyPuoDtCj9q5/R/MGCKGAQPdlUIFrMR6LnFU60rKDWDlSb
         kslG9RKogCnucmZ+7KBwR1k2vTR+T9jD7NbcOJZ7UDwoVys6GNlPds9/Mn1JWPRiy0DW
         xNRz1hHjD3BoO2C2dbPjEUy0r7jY8VPe8oqo8aoUnvL4JVc7679RVfbMkF/nTaoetWG/
         A+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958136; x=1715562936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlGPvOT+kgjSxh4YhpfMrvYca0NKJF9WiB2Pr3HjiSI=;
        b=ePxH/WVvB2H7JWRuxfMAWKJaQqWNxHLnZ086Idf5FrVMQVDCbZTz5OpPn5fYZkzrfc
         UcK81dC/pVPb047KE0TP3IIW1kRW07b3O+rq+5mfLgEuCEUoi1mGJXns+EZmy68njRJX
         dOIbJRc/auNeEHi6pdw33adRbJrMAFhv9EAHM7OQJNAOlnRNOAcJMOVsbr08cuXlUpQR
         dJfsVg+1SMYBE7DoJzaZSIHx3BLfainRB4+Jfb5hj7SLCYnmIwNoqjgDDDRc7ff0Pok0
         Dzlb7gJOAWHihl6RW/ho2J0O8hKBQUmYEFFUMwGhw1Vry7m6YQ1C2DW2J7o5tdG6XGFs
         AF0g==
X-Gm-Message-State: AOJu0YyRxSJbtNJ9chqfgo8tmSgjYyUPvOLYN+LyZ42DszZmlVd/v3qv
	usxFqQNNkHZaQg3yIpW1R86f6bFd6LWvUPRgvyRhG6tI9vvL7kPzMIX+gbI41WUfoNLnEQpqTZC
	+
X-Google-Smtp-Source: AGHT+IEqjyWkjlBzyPJ6Auvu8Z+3WOEQhZZh44UMNlKNoSVCPI50ZyuOdk1tv7hclL2q3vaKF+eliQ==
X-Received: by 2002:a05:6000:e12:b0:34a:a836:b940 with SMTP id dx18-20020a0560000e1200b0034aa836b940mr5544350wrb.18.1714958136663;
        Sun, 05 May 2024 18:15:36 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:36 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 06/24] ovpn: keep carrier always on
Date: Mon,  6 May 2024 03:16:19 +0200
Message-ID: <20240506011637.27272-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
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
index 584cd7286aff..cc8a97a1a189 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -51,6 +51,13 @@ static int ovpn_net_open(struct net_device *dev)
 		IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
 	}
 
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
2.43.2


