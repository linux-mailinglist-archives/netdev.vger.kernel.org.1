Return-Path: <netdev+bounces-149800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D739E7880
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4925E16399E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACD620B213;
	Fri,  6 Dec 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="I29150/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273320626B
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511652; cv=none; b=Ycsr3+9D/KRcJLKyCee7rvtb9L/d8RyL89PKsRlv0BN1Xqk1o9iP71WHeuSBHuE/qgTO2Eb5ZFYLTInXbe8e9kEB8/mZ4Q+gJ0F1eINKtDTmugbeF99W4VMbrvRunok5cIuoYr25giVsmzGX9uUoptCKpIQ9IqkDjBjP85cUEzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511652; c=relaxed/simple;
	bh=Oug/7vDlEmuLkveQoKotO5NLIXni795nVP0v+lTs4CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ULBoVsY7yqjVCrEDmKzNOWVpnIUakjlXz8OKbHSrUTLAUbIVyL702R1EiP6M6yjFFBSDkUbaVp7gvjfDIMzMJT+M5X0ybb8726h7QQ7Hjt0r7cFVPZHPRqP04IqPrQ3JkO8biCzi/ADojccujIPGXaPRTuYNQGQ/YtpZ901ZVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=I29150/l; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so5190991fa.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 11:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733511648; x=1734116448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRtfoUuaiSmawV3D7PM8LTv0BVbgF0vB56WhOBoL48I=;
        b=I29150/l5AMSvygq3eX4FGWfKPNihBpQA0nMV66C2E3x1KYlSmxXPmBOaNKQGpDeji
         Y06PhD+v5If38T6CvvXmhm5hvTSAwcrQ+mvFGhUZLMduRx6lF6SSxxpvtN4wBYFt3esU
         Ec/K/x6NxsQOB/1iVOEKlMNRu0hWmwQkl6UOURgVKFL7S/OJIHr4PC3NtVY+SacmRAPF
         kAmr5hgd4cfkSUfYGedSgUKSzqFEOkp18d2mWqn/uluatfx+cB4R7yTRRhweftPl8qfB
         oRCuxqehyRBiQWlxwqesMN/t+dAkHokqVIlEAMRzh7iF46K8UrCuPqGhcTCeyJdlegZq
         21NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511648; x=1734116448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRtfoUuaiSmawV3D7PM8LTv0BVbgF0vB56WhOBoL48I=;
        b=VzStSQrTnyPPVRgnHXlMjcjMwLT7wsNr9D6acDG0ywP3eY7fbtVLo/BjWcQYRv0XJR
         5XZDT0KLf5c9iJeArE/JqV3XKKA9S3+dacfe2GXXB5k+l2tmnepaPVMMgRN2Bz+J7PJP
         Nqbj9ZKi1kzODROlpxEWcNHSl9CSkG4E41oCPw/br3zz7CTTKroIZOloNFLWEZyfyDlQ
         j5kgQhYnAaJh5I3uZQUAJpgtYsLJz44JqigFECKG8WMgc147JO+D7DVnCvLLSvYXLDxw
         q6csqCvb4fAUpTKjqCHWg/ua+H5do7sGKaUokmcZlTFl6jPtBJc/cNhanHbZ96Mj20al
         HAsA==
X-Gm-Message-State: AOJu0YyYsSX8jIEN7qAN5DynVXeehItcikABQmwQdJiifSCB7vjIxfUb
	KE7YeQt992Gt+S8mHb4axhA6VvJrGnEJ5JPZhu9QQ6TAKibSYzLkcpIndxn8R4mQAMXgCASg8RK
	bwoo=
X-Gm-Gg: ASbGncsWtCZoVvAPZpvMO8Nt2yLQ72iAJUWc8+sbGuCC2gEcULjoZ1oVwgrWZGCCCxR
	lynkPYjE9Sz5mypk50Xr27L9GhXLOCgrkZhNyr2gDAhVJg642ni7SGoROhalqUTTMm46j4FfC7y
	F/SQrR68vkYTqrlcmIgQTKdRDOUfTJxiRxqc+XLTOSumJyPMk+fRklMJjhSfMwT9nOluXLukS0M
	pWgcURnhbfdUOgsPZ3TA8nRj8ByYU52/LrPMSsbTeOYmqjf4jgxGiaagRxuQlhW
X-Google-Smtp-Source: AGHT+IHHUgZX1u6gj5ZZhnbZvFvdFxtWjem7qzmC9NdGd/PDARE/4bpEVRG4Dg3PrMiq11s8UCNfVg==
X-Received: by 2002:a2e:b88c:0:b0:300:3a15:8f26 with SMTP id 38308e7fff4ca-3003a1592e3mr14869321fa.0.1733511648446;
        Fri, 06 Dec 2024 11:00:48 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e58200sm5523201fa.113.2024.12.06.11.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:00:48 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net v2 4/4] net: renesas: rswitch: avoid use-after-put for a device tree node
Date: Sat,  7 Dec 2024 00:00:15 +0500
Message-Id: <20241206190015.4194153-5-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
References: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device tree node saved in the rswitch_device structure is used at
several driver locations. So passing this node to of_node_put() after
the first use is wrong.

Move of_node_put() for this node to exit paths.

Fixes: b46f1e579329 ("net: renesas: rswitch: Simplify struct phy * handling")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 9c55f3480678..57cf211ac1e1 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1892,7 +1892,6 @@ static int rswitch_device_alloc(struct rswitch_private *priv, unsigned int index
 	rdev->np_port = rswitch_get_port_node(rdev);
 	rdev->disabled = !rdev->np_port;
 	err = of_get_ethdev_address(rdev->np_port, ndev);
-	of_node_put(rdev->np_port);
 	if (err) {
 		if (is_valid_ether_addr(rdev->etha->mac_addr))
 			eth_hw_addr_set(ndev, rdev->etha->mac_addr);
@@ -1922,6 +1921,7 @@ static int rswitch_device_alloc(struct rswitch_private *priv, unsigned int index
 
 out_rxdmac:
 out_get_params:
+	of_node_put(rdev->np_port);
 	netif_napi_del(&rdev->napi);
 	free_netdev(ndev);
 
@@ -1935,6 +1935,7 @@ static void rswitch_device_free(struct rswitch_private *priv, unsigned int index
 
 	rswitch_txdmac_free(ndev);
 	rswitch_rxdmac_free(ndev);
+	of_node_put(rdev->np_port);
 	netif_napi_del(&rdev->napi);
 	free_netdev(ndev);
 }
-- 
2.39.5


