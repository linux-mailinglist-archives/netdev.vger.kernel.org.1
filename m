Return-Path: <netdev+bounces-194474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF085AC99AC
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 08:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33694A6C49
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 06:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7392367D8;
	Sat, 31 May 2025 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAU96o/c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5A22F154;
	Sat, 31 May 2025 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748674007; cv=none; b=uEG7uoxHqSAkSlXgTUF+zHd9Y4ulGdgCbu0v860/58lWJisLVoaEJkKe8VAvvbo5DfIiwXkr2JDLiwuHBQKNZb5AJV7RSW4RcmatvfAqB4KzIHlqdwtccU1b6j5+JAxPcGaQZ5vvUCPnbsJ/no2TdTS0DTNjNrNaAW7fRolGsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748674007; c=relaxed/simple;
	bh=kJHhCMPchGRegdd/rLWL991p93hqX6tlwuMJNQ8VRTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3Lf7NGxAMrEd4MaAorvt3Bmnduge9JJAM8vIllAS7mKcUnNx0rlBdu6VwoyocmR/T+OEF0ZssxbFouvmppuES37J9TPlgEg3rt78EJWrpKUvGAINvz/R+3xc93FU0g1LRL8muVA/PTJpTdLTlaXyyakQUC/f5dAWqkRO9XQNV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAU96o/c; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4f379662cso1903316f8f.0;
        Fri, 30 May 2025 23:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748674003; x=1749278803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEZTMJM9pvIuqA1503OtkplFn4omE0UxVG0G8NBdaq8=;
        b=cAU96o/coM0mB4cqb1YQxH6Zrq/XSHEe58qZuiTKOBWM9e+fGEc0ZB0fkrsUNdinaP
         v2QlAGpcgndcIvFyK6MNNOpEmrJA9568eu7r0SFSFdHjZhlownme8JHlFdIfcgHWvehf
         gJ4T5alx19x/YwbaZwN6bTYfaOYTcQuai79i5IdBQ2e4F9nSxSS3Vfx78QVtYs3l80ad
         5cA/q1c7fV5a9s2MiziBQhm41IdCQ1sBl9Ce3Z6mCuxxm1VHKmv9wWzt2jka1NHREhLj
         sb93dZO3lsfg0yAuywHslX3jvvV/fARtmfNTZpoP2qKRejgPYGrY4StBoGYIoRoHfhX1
         S3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748674003; x=1749278803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEZTMJM9pvIuqA1503OtkplFn4omE0UxVG0G8NBdaq8=;
        b=Lv2w/JVta+Y4XxNOM7zc6a+cj2/Nf2yw2A3gUyhO/9qOwfTTqwxhvZVz/wK74MJozF
         W1y8XICaGLwRPrbk4ITNmT0oMvh5QBxCBKaR+6VU7sk71HTimyV1Z7MgVJad5yEe7p0u
         KMOvye1yv9BdbJQbZy04H378WQgU+SEzOfjtxg5+8/iiSAjenzpu1sGoVuluupgcONd7
         TK3Qb1/EEG0B/k/eteHWFSpWa7g+1EpIN1OpW1GMnmc56chSWqY4PEeocQHhNsDCNtOY
         wASco+s8zgbVQQlGq3x+9NtOU6Z3mEhPKMKfyc0golSMPD2F3LZQ43JWxTIeQN9FobOo
         id6A==
X-Forwarded-Encrypted: i=1; AJvYcCW3WhzxmRW6g+0z++PlnVJf6ZQyokxA+GJqdgEmVxo9NjyfLDvlq6ebhJVQKdIUo+7sgHdZ2eFm@vger.kernel.org, AJvYcCXMJPr52ol3Q7lvqpWhXrb+boGagueG6EspAToruk1qzdXOww95+Qhf4LmYejaM0KxGK9pOLSKi/7Xm9Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYcJrjKOhKaHOFp0KdJGbPB2KiwGZiakwfkXqi0aS2FsWZTvc
	OTv0b/8Mxh5jSpJOBVMb/T+cFP0lWzE+D3aJdnuYklP7hGBqww6UFU0P
X-Gm-Gg: ASbGncvcLVjSNaDTdDYcx8T6LyPXVPgF0A5BmcIqPYQWrJgNQDTVEAMGZ63Ql0IECq7
	udNxjh9+dE5Vp/V7h7UYvH3n3TJGwwmQoAS26hMhXiurCAaXqHBeLyr4rFMdSYfkHaUuLzcP9Wq
	uaDYV4Gz90bQjO7eWY4NsXhBKZYYR9f8i0AQPupxhCcSBFJsMlQhRCOEAsxIfm+K1ryMAsWx7U8
	pG5nWSK946T9+8bM+uogR9rPEBzjQXVlSlO/uVJcSUcKEPXe+WP+HT7T6QAPj/Hy6n3QxuKifvy
	mRB1Fyg60pKZ03cdFvzZecgtr+zCAZbFSucFVEcAH7JSIg6YlOBO1WjKIaPz9OIfpW1SFicVNVM
	6Fn5FeWtzlQgAKGkbDtA2vpbg8nbhSZLVzJGrqAObwAbN/lzgJjqN64QjDn9dhSQ=
X-Google-Smtp-Source: AGHT+IH9jceSJwyuAZ+BuVedMH5uEvP11Dv3f//jz5Beq0/qu3VpXRgQpNd82+MVe5SSOXX4og0Bjg==
X-Received: by 2002:a5d:64e2:0:b0:3a4:f7d9:3f56 with SMTP id ffacd0b85a97d-3a4fe154c8bmr789019f8f.2.1748674003334;
        Fri, 30 May 2025 23:46:43 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000e9asm38324765e9.21.2025.05.30.23.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 23:46:42 -0700 (PDT)
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
Subject: [RFC PATCH 3/3] net: dsa: b53: support legacy FCS tags
Date: Sat, 31 May 2025 08:46:35 +0200
Message-Id: <20250531064635.119740-4-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531064635.119740-1-noltari@gmail.com>
References: <20250531064635.119740-1-noltari@gmail.com>
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

diff --git a/drivers/net/dsa/b53/Kconfig b/drivers/net/dsa/b53/Kconfig
index ebaa4a80d544..915008e8eff5 100644
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
index 132683ed3abe..28a20bf0c669 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2262,8 +2262,11 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
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


