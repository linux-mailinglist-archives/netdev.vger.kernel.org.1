Return-Path: <netdev+bounces-112710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1161593AAB4
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 03:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B87284193
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17CDDF58;
	Wed, 24 Jul 2024 01:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDwMFZfq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921941C6B2;
	Wed, 24 Jul 2024 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785644; cv=none; b=Y2cqfow//rABzycRameSVDxK5rEWAtqXpDoPxNpPMa3it1TfI340BmLlfZ0K/3no2Y24+W9rR6Eh+oob6EjpkxJ9bxOV62Be6vr96lyz9CSBttHzZKvboena95gS/ynwUGzyeef2S6R2jr48z9vNGvjiS3wFDK4RUr0KcUO2PWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785644; c=relaxed/simple;
	bh=HIPZaFh9Yecwx65PpnkfqLQC2xvEgZhlTWGXWm9wIlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPu8vnU+jOsH3PdqRjVzIYAHGw/O3vLOgFzU1U7es9lgJ0A0eBu4gU06NZAEQ+0r6NJOWhQvoihpn/41/mczsYgDwH4bxUXhz6D0Q5fm6XYdEX7ImdIjQwepIWNUhj368QeLG5HTgx6Nl4PgWKfYQWSbKqAynQvqkurSqzOlkew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDwMFZfq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d24d0a8d4so1814339b3a.0;
        Tue, 23 Jul 2024 18:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721785642; x=1722390442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixBaPt3HwUBSQNgJD5/MCt2lI2he2/bUzlD4zYQg34g=;
        b=dDwMFZfq5reqpiOFepVaOhIPc/R0rG4nmhLUdQ7jOcn9Yt+vcKp3sZFqlbnlqQ9do3
         CrCOuM7b3nkf0EydYWwerm+WbYVo4MJo/1vW2FOPMV3bvoJvv7SmIPV7aDZzCoEmKMzs
         6pETPSuP7SQiXtmcKuMlnK0QnqgViCXdfk38WelJo4s+TVOk54gnC1Ufz3t2kxHCC5Y5
         L9l7+egf2f27jYZJ5h+OqJTNTxXfXPwPeqXneiQDi9SCwkSL3SxonP5n61xqX+7vF1Uf
         MO3SJfct/ACQUfOHmKCtSgrpvzeLnu7TyWrNM58FyMgc/KCLxTa6P7rwXhSkNfa2L7Ly
         Dj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721785642; x=1722390442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixBaPt3HwUBSQNgJD5/MCt2lI2he2/bUzlD4zYQg34g=;
        b=g495qGGoCNo85PVV02nH8liaXHMjfuDxjOL3JVkVitdMtssiKAa478du+gV3t5Ayrs
         wci9ZjEDxPo2YXAqBKRPwF/NX6H+XLqjUG+qNUO/cIavsRiKRIQyzh1o5Fp3DOQePj3w
         94+Anmth7Xti4aePYjPEGJQHOdZAvSP9VEW/f+FgrE+zu/xqNrmYtrXGsU09+hX4eS0p
         x91fB7cLKs+SIsG0NM2pyjKNxQdMTw2aw2OPws0R25XqFImggUMC0xaVQ9mj4lNLZ3BQ
         ZfFYs6A0lWXrufvsrRFUETO0JGdi5Oxt0YQ5XQ+Rrn3+RXf3blcfWpyjMn8ErHPgvIzI
         ZEfg==
X-Forwarded-Encrypted: i=1; AJvYcCVzSqamxUv75pBsQCY2t4RIF2rgdCKfzWwK5/14IqTHHnOswTsozzRgRt6/3MKzCW1xFitv74UEXbiJZ0YXDIeHp9QXaxxNUwNHEvuE
X-Gm-Message-State: AOJu0YwblsyHVm1MdP7qwM5tl7NuLB7yZr+43E/G3h32V15tjLoVrXDd
	S8GYiP0iz3J6VJUh4Skk9nNaQ0fW8VIO9u7ijFLtPNuLEx2dt2dyO1K/eBvV
X-Google-Smtp-Source: AGHT+IEzb3HhOlXc05SU9bt4B8hsihQpnQJiUMKfpkiSYXtvWZtRhKv4Q3D5pKN5cYFnan7xoExGSA==
X-Received: by 2002:a05:6a20:841e:b0:1c4:2540:1735 with SMTP id adf61e73a8af0-1c4254017aemr13020132637.16.1721785642340;
        Tue, 23 Jul 2024 18:47:22 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73a5f5asm314564a91.8.2024.07.23.18.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 18:47:21 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Stefan Rompf <stefan@loplof.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 4/4] net-sysfs: check device is present when showing dormant
Date: Wed, 24 Jul 2024 11:46:53 +1000
Message-Id: <5d51ac5ca591bb38cc822376e878f0b30864b916.1721784184.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1721784184.git.jamie.bainbridge@gmail.com>
References: <cover.1721784184.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sysfs reader can race with a device reset or removal.

This was fixed for speed_show with commit 4224cfd7fb65 ("net-sysfs: add
check for netdevice being present to speed_show") so add the same check
to dormant_show.

Fixes: b00055aacdb1 ("[NET] core: add RFC2863 operstate")

Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 17927832a4fbb56d3e1dfbed29c567d70ab944be..ff2a1f6ef7e18be56c2de51902519066431e47a8 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -303,7 +303,7 @@ static ssize_t dormant_show(struct device *dev,
 {
 	struct net_device *netdev = to_net_dev(dev);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev) && netif_device_present(netdev))
 		return sysfs_emit(buf, fmt_dec, !!netif_dormant(netdev));
 
 	return -EINVAL;
-- 
2.39.2


