Return-Path: <netdev+bounces-196229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 454F6AD3F04
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 18:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332F8189BA37
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C54A24395C;
	Tue, 10 Jun 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPeglLck"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3570242D6B;
	Tue, 10 Jun 2025 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573124; cv=none; b=Td8aqR0gRZ0p2kl6Lyu9YGhtlWA9f+OSP2g6FJM0Kh+jxhnCwpdV3f2YbuNls0kiWbKp/tDIlO9dV52u/IhRQKr36gIw7xaG+xJCX224mLsWZhYKdVzgR4f4eQ9u7SV7w87b6mQ3+c0a7zCMbdtusSoyPfWZGuUW5Pk3nacrRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573124; c=relaxed/simple;
	bh=hNuCDM0jUQWKqc6R9z3C05bZeqq7L3xWaTOLAJKfXZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qchqiNcQ0w0ZBOWUxmqdl6unvyiBdqEPySJ7lks2bN3wv0Wdt4Z1kr311OBXQlwdkWtCVaUPShPTuzPJnzB2byddnn8FxAzvPhBPJmrPp1RhSpqL68VvFxjo30BGXMJrfXkMkjQSQo/TISgwVC10iurh8zREtp9RmGywEhiluYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPeglLck; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so68549545e9.1;
        Tue, 10 Jun 2025 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749573121; x=1750177921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZI48i2uXHjCqf8G8iB6bi5iAlWdT2du2T86rodgrys=;
        b=DPeglLckwP1XLfp28/u0TKqOFl6d1YIwjc2ujup3MyhqoiuhBibTZn0DePpNI/RIOo
         ESEJ/UkSzSW/C+gsi5i8bC0NiVO7FaOzlsUSf7aN+k+T7S6aJRELhDkhAQY7ID2Ohp4Q
         uEVR7moEaU9++QasUPwrO0YUHdhkuXqZHNhBxYyIYFbbmJ6717/svEzcaXvL8NM48dWV
         71oVKyFi/n0zg1iPV1Coyvjc/wasbdo6nnUcnpJml2HOeZ08U7PC1TUwZAUx1hZGCrVw
         C6FW3E1OydX73Eao54nXnJR6AERfEHqePFKDrVM3/xLnAlbb2+Z/Jac359aZL1MvCshM
         rkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573121; x=1750177921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZI48i2uXHjCqf8G8iB6bi5iAlWdT2du2T86rodgrys=;
        b=sxh48ba7WOM1Kwp/5zQ0ByOQ8scO0lxhBz1YgO1akTPPcWkhzvigrUkGUUp+5JfE2p
         iXk3nOLqESYdtyCqJPVwBdIaWRG94fiEpKj1Omkz8b77SFsLel3fZq9WryUKnKWktTph
         mc1Sl/lHzaulsCk5ywSbaod92WETCQg6cC4aLLe30FpxYRA9g0GVCR4ul6BVaWf3Grxr
         sojTG9RGAMC8/39w0c0lluCeg2ZgfSoKsiSPYuQj2HLBT3VgIhFTXb9kmg/sAsCiscWb
         h881GGKPjOFt/0Mx9UcFohaXKPooK/lHb7f9ifVJwIQttpd+7gYqrMbAvV5YLw+MMUnf
         +4cw==
X-Forwarded-Encrypted: i=1; AJvYcCVhAnFA0qGkzt424VEJHtCXyNIZI3yaEfHJ0+0/SXwA/Pl5qHgOZL2sCR9orZeH0X0dHi8/73IT@vger.kernel.org, AJvYcCX1l9HNa448BCi0pqhGEZVulPuL6cwtcs/kGX/0AENEuqlF1kWerHge6Vq2MAEttnUUSA2tvpCOM8wc6J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWBOeX89dS9JL+HObHA3lHl4HRWKd+cKZr1I4ZAmLCnLTyJyG6
	7EDWVk6LBdGH9dI577G2ZZ4YcPZXhQSCniFns5JvpBpFnfBbM2fmNPpc
X-Gm-Gg: ASbGncu7Y1hCOdWxfe2HNGxweve1XBYEM5yNY636sbtkscij5MWRmZh0eEVcdDlDee7
	HUUfbIGw2nNTRl1eKahcL1J4KptJXma74iX2QQoSkAbg9mJ4fOiwmkmagt+YtI74focCqyAyfGB
	C5m4fdovsNXfInbkXrzi/EAiMkyXM5EDsSirBonF3Vnja6AMjPdzxAm2dfgPbI96a7AHg6TXYXw
	v7nk9CVNeSP92wWWUNgosQ15mKWvK3Ec5E4CQRvuTAB5L8uch7M+ecwr0WV/8XLqI1B5RtdP8ku
	1ZnLewij8k9G8YOQZNl7RH+p0Yfg0V8AVUoiPct2BSfrsSjpJUVVUXsRoCwpmk3lJ/O3e+vKKo6
	K7LJqIIBaNVVSyI21vG4ERB+doEKdlYmOa/2bEAKfVyk9P3S+EQifN2Wew8iq+oI=
X-Google-Smtp-Source: AGHT+IFvZxxK+tyRgFocFz3UtSFmfIb+tEX2An49P06Lo+Ypw8FLZLGdUNwpZKVta0rbMtZE8oRa2Q==
X-Received: by 2002:a05:600c:a00e:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-452013d7e0emr162270725e9.21.1749573120948;
        Tue, 10 Jun 2025 09:32:00 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1900-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532435fa6sm12494857f8f.48.2025.06.10.09.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 09:32:00 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v2 3/3] net: dsa: b53: support legacy FCS tags
Date: Tue, 10 Jun 2025 18:31:54 +0200
Message-Id: <20250610163154.281454-4-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610163154.281454-1-noltari@gmail.com>
References: <20250610163154.281454-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 46c5176c586c ("net: dsa: b53: support legacy tags") introduced
support for legacy tags, but it turns out that BCM5325 and BCM5365
switches require the original FCS value and length, so they have to be
treated differently.

Fixes: 46c5176c586c ("net: dsa: b53: support legacy tags")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/Kconfig      | 1 +
 drivers/net/dsa/b53/b53_common.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

 v2: no changes

diff --git a/drivers/net/dsa/b53/Kconfig b/drivers/net/dsa/b53/Kconfig
index ebaa4a80d5444..915008e8eff53 100644
--- a/drivers/net/dsa/b53/Kconfig
+++ b/drivers/net/dsa/b53/Kconfig
@@ -5,6 +5,7 @@ menuconfig B53
 	select NET_DSA_TAG_NONE
 	select NET_DSA_TAG_BRCM
 	select NET_DSA_TAG_BRCM_LEGACY
+	select NET_DSA_TAG_BRCM_LEGACY_FCS
 	select NET_DSA_TAG_BRCM_PREPEND
 	help
 	  This driver adds support for Broadcom managed switch chips. It supports
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 862bdccb74397..222107223d109 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2245,8 +2245,11 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
 		goto out;
 	}
 
-	/* Older models require a different 6 byte tag */
-	if (is5325(dev) || is5365(dev) || is63xx(dev)) {
+	/* Older models require different 6 byte tags */
+	if (is5325(dev) || is5365(dev)) {
+		dev->tag_protocol = DSA_TAG_PROTO_BRCM_LEGACY_FCS;
+		goto out;
+	} else if (is63xx(dev)) {
 		dev->tag_protocol = DSA_TAG_PROTO_BRCM_LEGACY;
 		goto out;
 	}
-- 
2.39.5


