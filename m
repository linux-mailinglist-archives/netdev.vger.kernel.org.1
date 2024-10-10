Return-Path: <netdev+bounces-134406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F8E9993AE
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364481C2304D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 20:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8961CEE8D;
	Thu, 10 Oct 2024 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4nR2BjE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540261BBBEB;
	Thu, 10 Oct 2024 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592221; cv=none; b=a/iLcVIXmhG83+7PVaKcrND5c9Z/5HwpRyTjLVTKMgCRbjjgW5W37NuQ+hVDc4ib5MnPwVaZe+qbJ1hWmLvjv5ZiM/NPgyzrZiK5xcw6y+Z/Im/M5KSfWL8ucr19MSnAWzYoAMEFHVIWJhB6zUfF6Jo3aWwP0AjsUIMilRLp6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592221; c=relaxed/simple;
	bh=Xfoy5x4j60RyTDi5mge63ITLR7dG5zN2yb76dSOiyY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+GwPpRhgPaorFiRhs6gxFSyqrhmCBZjae4+khOj9IwzXrIhEAIvQ7Rhbou3WJxGDulfivU3K0VrfPEXESqcUJLugkooABPXZk2v453gqMuFjxiNOO+dhJySnAVtTjlAqj6ekSea4nYxf6Z9qEWqOUxEOW5vt5G+SeeMRGUmCvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4nR2BjE; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6e232e260c2so13014767b3.0;
        Thu, 10 Oct 2024 13:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728592219; x=1729197019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YroJGO6PjfhfZ20pefw7162KbigTCkcCoLor9Hsx1oU=;
        b=I4nR2BjEVF550OdIQTCD9jGCRWU4QwjIYJi7re88hcqXkilqY2Nyf5lNGJQFlRBd4X
         CM1YS2+FTAPSvFUp02nKi2G+6Z7jOP/hDfSkOh8HbA9rlfShpRIwmU4p4QEtH2beBqCc
         bucaG5U60QSRWdDYHSaxa5Z7ab8L28Sn0N9nWmppuVt9qelGI+py7owkNpiewcuJ80h/
         q6iZGF8lmYPiSWgQ9z+ZiD+44uk4oXXInkCwE7eP7RS/4F7abMMTgUUcFahGVt4GI6OA
         4K+YO74J9+jbv77fcq2k/WEXY9a0VAgSP5lDWM7SyI3j9tR9XvMtIqrsmC1kx28zg0h2
         SDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728592219; x=1729197019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YroJGO6PjfhfZ20pefw7162KbigTCkcCoLor9Hsx1oU=;
        b=rwPw+2ik410AIFNe5WffCoUBaRHnUglHPmUKRyXvRP+Ma0awNkphFaKjKOWzETWlSa
         sYQT0Doft463HwZNWaSS0xobAQ+AI8LcXa4huRwfVkn2eCBjw9OLAN5DZMQ/b3EBd4rY
         bQlbX/l2m1f5hbRKCxmLmG27bQx5Z/ALMp1LmcaZIJgf6b3CxxNEdRqRvRKFjl8zmFFR
         XSTcUMT7iyAfoVRJ/naMj87aCFX/cCUetV9NfRcPwUrHVUM8xao6Dxl73lWZ+ie/zl8/
         tKyMEvRelh1zZoMumOjkH+Jvp1y/i4qAfQaXySj1/4cMMqh9VWpPYnhuxon13Zuy20ul
         EtvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvd5Dqydl2IaaUc6MOHWHgElet/m7S7wsAU5pAsDHRJQPzYkm2K4WOfXHm+rEbYEs9Ii0GzXK4@vger.kernel.org, AJvYcCWc/JgefZm0nqh6lW6WbWI1NqLDb9tV5ajOfzhnZYQiCnPc+5AoyIKmhSTzTCfFz3k/3yaZ3EqvrDjDl9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3y0Iv9MZACO9HkiZMCjtZloGFprcYrgoGUc+RaKLUs0QWx/+
	0URyPX7Kw7JXBDbti0z2pu/8DpRDBGk0kujMjz85sXeqVXLYccNL
X-Google-Smtp-Source: AGHT+IFXAqpm+avkXvxFV0INi5HtAmbH2KDLrpqYf71LYyLjMhdCd/QKCvKqB5vWMTyEZdBNrrWsrw==
X-Received: by 2002:a05:690c:6609:b0:6e3:36cc:eb74 with SMTP id 00721157ae682-6e347c4ce3dmr1412377b3.32.1728592219339;
        Thu, 10 Oct 2024 13:30:19 -0700 (PDT)
Received: from dove-Linux.. ([2601:586:8301:5150:3908:7240:1fb2:350f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332bae464sm3424467b3.58.2024.10.10.13.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 13:30:18 -0700 (PDT)
From: Iulian Gilca <igilca1980@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: igilca@outlook.com,
	Iulian Gilca <igilca1980@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] User random address if dt sets so
Date: Thu, 10 Oct 2024 16:29:37 -0400
Message-ID: <20241010202949.226488-1-igilca1980@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b4d4090a-2197-40ce-9bb5-1d651496d414@lunn.ch>
References: <b4d4090a-2197-40ce-9bb5-1d651496d414@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 net/core/of_net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/of_net.c b/net/core/of_net.c
index aa4acdffc710..a11f1c12c395 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -142,7 +142,11 @@ int of_get_mac_address(struct device_node *np, u8 *addr)
 	if (!ret)
 		return 0;
 
-	ret = of_get_mac_addr(np, "random-address", addr);
+	if (of_find_property(np, "random-address", NULL)) {
+		eth_random_addr(addr);
+		return 0;
+	}
+
 	if (!ret)
 		return 0;
 
-- 
2.43.0


