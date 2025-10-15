Return-Path: <netdev+bounces-229520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AADBDD737
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4565E4E164E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9267D2DCF44;
	Wed, 15 Oct 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zge8wSFb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC342D7DE4
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517419; cv=none; b=ja8Zt7vVoHpIeuQxlXzxAjSb0a0WllV8JtYpdbAm1OQ1rbt5UuH6ulAKc7DvCnboU32kBwqQmFaVe7GjyEGAOynwlhqCQ+sxwpxLRyUWlR+NoMTEkyZCjwsKweuQ4yzaqSt8feLL//WcJoNdjEN+4yuFnDs24BlEycN2pUNCdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517419; c=relaxed/simple;
	bh=5NLI4zsp1SBd4gOuOIKIYNZhIQLrzLg9SuY97NLQhDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZu6YUMajLHzsX5co7cXAYefFP2lfbiAUOINK5FzArXxvkOtn+MAb8rGYQEI9SxHVuc75AgD22pL8CUdQudts27Na7SbP+Sm+sqlpFGadou9oJlWbrPLTLrQtbyrWUAxdr9lSK5objIgBEAzHgWI8P4QMyxDHcFoKDxoU5u3F6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zge8wSFb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-782e93932ffso5597481b3a.3
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760517417; x=1761122217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQEmu+bNGaiI4ph/ihH+xulFUxvjHHAKj8u1RiEsGpA=;
        b=Zge8wSFbjwm61sGT+XRVskayrotCRJlgFRYnYJoCAj7qq1aBGSY05djGzbIDdd62De
         N1XL+Cy/K0d5ddNkit6V0+6avdkQL3kTiG7Y0bSjTUN7KH1VigZqzikIpVXUURhhof/6
         onl+9+ExJl76pUAE8rcJUnGMybHh6R4c6U7q/4Oh1IdjYu2BgTp7Fb7Gp+WyyljaUtem
         cDsaWBlxuV0TPXi8Zt0gYhj0KZ8zhjzYadJlBUxZFoUpfMMMFrgM2c/uitG/4a+uFpI7
         3IqCuTfHNRLmS8TWtGfCTBUICh+/HVas4vm6GXrRHB9DbeVjmm+x34QK+GfPscsV/FkX
         020g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760517417; x=1761122217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQEmu+bNGaiI4ph/ihH+xulFUxvjHHAKj8u1RiEsGpA=;
        b=PCS/yy5tR9AUl/ccAe55BWaZ5akI73WDziwQL+Ht9yK6RGahhEECaXXwHkcXx3+6Oa
         Wi4DIg2yuK3NoMYtE2PWehoqOBLR2hWu8ZE06YVbaOd4Z63OkLlnRIIQXw6L3/yrZ09j
         5fevtItkbgMQhSiXTDRkp8vi528xZ5Y1V6KRsyVEYvQTU2W++dsIcWR6mwI31kfjMRSJ
         nQxxqHHi69Nc0C3EBCjZbK89ovZb0tumLyZHMkWtwdlBi9NZBCTkQQskHBy1ZERGqtF1
         Chjrl6G27da1c2MJJa7FM+C0XIwGdKVLPZ39FHsAzcpwZuZ0Kmkw5f8LsbA98QQf5TAv
         cSDg==
X-Gm-Message-State: AOJu0Yyy2tBFyFDBQlvoGa9ypcFDwSJKYiV1WPSa/1rkoJAZaw8PWwXZ
	NkFUcGkIlLhor3wfS0g+9u+lqRhQjaNpPxToBU4Ym+fjj5wiCSfmp6UpnQ5XcX/bLrk=
X-Gm-Gg: ASbGncuhFVbrSubibM2Dj13u4HFC8lRmae9UZPGmlMEEcBqRLYg5CkRY5WWofi+RESv
	ECCLt/cM95ti9yH3MDpNm1DM+z2eSYuscodRhvuE0eoaI6WS7tkwj1HcxhVoUOTUc9WZiCtL2oE
	yTSG7nQqcYA9Am8UBbN0SGdxsBCZbLO1WFpk65qzo+lBCGriS1PGgV3ToO0zHnbRr1F5pw2vAjM
	gHgNe8ukvM/fi+CW+mEJkOk3R05nEu4ONa67NOdCrGLScMNytpVujQKGLBSD9mpKfprMQgqg8mv
	8Mph8p/953HZNiw4nylL0u4JvqOXlrgQ9Sp63VY8iVIBjjBDAhXloky/J0YyllFPSx2ySBSM+pD
	7vzsS5bpeqbLv+ysI1cBi8p8ffgjqiodwtFEe7KOpVvBha6ekzOpvpf9Z
X-Google-Smtp-Source: AGHT+IH4uRC/LwL4VguDjyrCqgeVwmaAxPM2fBN14NSAtfh0MRz3lfPwgrQAHOYcJn6D5c+3iWyLSA==
X-Received: by 2002:a05:6a00:ccd:b0:781:1562:1f92 with SMTP id d2e1a72fcca58-79387a287dbmr31259981b3a.26.1760517417062;
        Wed, 15 Oct 2025 01:36:57 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb18e28sm17879570b3a.29.2025.10.15.01.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:36:56 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next] netdevsim: add ipsec hw_features
Date: Wed, 15 Oct 2025 08:36:49 +0000
Message-ID: <20251015083649.54744-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, netdevsim only sets dev->features, which makes the ESP features
fixed. For example:

  # ethtool -k eni0np1 | grep esp
  tx-esp-segmentation: on [fixed]
  esp-hw-offload: on [fixed]
  esp-tx-csum-hw-offload: on [fixed]

This patch adds the ESP features to hw_features, allowing them to be
changed manually. For example:

  # ethtool -k eni0np1 | grep esp
  tx-esp-segmentation: on
  esp-hw-offload: on
  esp-tx-csum-hw-offload: on

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/netdevsim/ipsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index 47cdee5577d4..36a1be4923d6 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -277,6 +277,7 @@ void nsim_ipsec_init(struct netdevsim *ns)
 				 NETIF_F_GSO_ESP)
 
 	ns->netdev->features |= NSIM_ESP_FEATURES;
+	ns->netdev->hw_features |= NSIM_ESP_FEATURES;
 	ns->netdev->hw_enc_features |= NSIM_ESP_FEATURES;
 
 	ns->ipsec.pfile = debugfs_create_file("ipsec", 0400,
-- 
2.50.1


