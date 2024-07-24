Return-Path: <netdev+bounces-112708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2E093AAAC
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 03:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283681C22BE5
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 01:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF7F9474;
	Wed, 24 Jul 2024 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3SP7yxd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAB4134DE;
	Wed, 24 Jul 2024 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785636; cv=none; b=SGX+fcPwBAoGTWOg2/yyejC/VuOagy4tZ3qy1YvFc/Vg4U8BQWlsBDUATiNT+FxCscNJELEq7dVVtpk5Jvvo6FYa6jUTvHnU1sTq6G9ka1HkqDJn7ZdQfBZ/X4ls2e9BkCvRvPGfCNkPq4nzPo/lainiSfZLk5H/v1d2NQFEU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785636; c=relaxed/simple;
	bh=RRiFrZgzAdxtadZssrRgYYenCeicBdiczxoMgVLyZRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U47bI6XyodhVDC7aqIm0WME+dG6Gj7ilW0NdlW1H7jzC+DiVNQPSMHsq5fM0BaINxHs+bvh7KmWoF8toO9Y0WdcnGRn6kHB6zEcHhyGeRSQjBjuJT81rRC7vtVDo8X8ekbvAJFZVHa1/9pY+SKnW34to/ADQoOiMNBW3Y1EKFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3SP7yxd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb57e25387so3917551a91.3;
        Tue, 23 Jul 2024 18:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721785634; x=1722390434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6mREQmkxMWGeSPDPiv6IBNi7tWuWaCf4o+Mf9Xiwjo=;
        b=K3SP7yxd6dzBCSh/zP8JqMoaVnC19B9Fntxuqul2DLSggxH2aa5sfZU9Uhg3rkDPOT
         7MCDZS0G8lNpFEEDzXIBaqQNWrT2A9RSI8kNRBxo5ICFIN6fUYi9I1Js9RG0qRPrAjjq
         IwAbH38JnJ/vyvAt4gYtBx3mU7uWkbOtYDt7sfckPzSso8nbTiR5chOMK4v9Gqds5NiB
         23jw9jKhCv2beVqbMbPxhoiNbgRxXjiShBq47L8VRNlRv2DaFbiS6wrozDJ3jAdXUjxO
         wXBoVZdj0h9BZv2IV065CJ/F5zTjb+mQTw1x5SZSr2H9LRj0c5QGXEDJUp3iFpxbGgD2
         AdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721785634; x=1722390434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6mREQmkxMWGeSPDPiv6IBNi7tWuWaCf4o+Mf9Xiwjo=;
        b=qe5HI/AUNROixSuNVk/NyJ9SSBKtUb6YZ6TXp2njrgW4Bh0difDlBShvN9DHsstewn
         wZX9l2odK9y8l+o7mihrzt9sSoc1R+jvWyBsWh3MamOOfA6mL6JYt7URCrl+mC30arpj
         LVH5xxnOGgwZJV82kqTCXdjstpGfJoNof7l59h3SjxPWSszYPJ7K3AuzZt4ji295XZZ1
         qAj668sSv/JY/kIzhromMwQhZqQj5twDcwKhDU1EZzT/3txiMegLSn6EMzM/kj6aklTn
         9WMozUqlkdYPOqPwuKpBYoMj8gsRR9KkEl1f96RJDPI4CZeGXu5gvaFiNeW/dxDh2OFj
         HNdA==
X-Forwarded-Encrypted: i=1; AJvYcCXgNcNLynudR2g/jewspm7e0Hn+K7k+Pv6/nAFHVXm24y9Wy/ah+jXMna5IoNEHe3YY74G/6N16UBKZMVtKr67oxkTyUM83C4qTOS+O
X-Gm-Message-State: AOJu0Yyi6T8isSEYG4u6GOKmFVKArORUHfLA8M5dFrJE2f9sV0WkRc1R
	OUH+8XVE7i4WEdU8uup8b1AHu5mGLfToFuJf92wfOPA+w/dW6zp0fs0Ff/vA
X-Google-Smtp-Source: AGHT+IFpJMucoex5Iams7A4EI9gSuS1aXy0D3+wE3hhFmoW6nR2s1YA5rlgV3vhgGcXLPwx6F6PB3Q==
X-Received: by 2002:a17:90a:c908:b0:2c9:6ad7:659d with SMTP id 98e67ed59e1d1-2cdae2ec122mr1681152a91.6.1721785633996;
        Tue, 23 Jul 2024 18:47:13 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73a5f5asm314564a91.8.2024.07.23.18.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 18:47:13 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	David Decotigny <decot@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/4] net-sysfs: check device is present when showing duplex
Date: Wed, 24 Jul 2024 11:46:51 +1000
Message-Id: <f0d97fe4c339798a79265dfad811bb68f4f2bc63.1721784184.git.jamie.bainbridge@gmail.com>
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
to duplex_show.

Fixes: 8ae6daca85c8 ("ethtool: Call ethtool's get/set_settings callbacks with cleaned data")

Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 7fabe5afa3012ecad6551e12f478b755952933b8..3a539a2bd4d11c5f5d7b6f15a23d61439f178c3b 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -261,7 +261,7 @@ static ssize_t duplex_show(struct device *dev,
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	if (netif_running(netdev)) {
+	if (netif_running(netdev) && netif_device_present(netdev)) {
 		struct ethtool_link_ksettings cmd;
 
 		if (!__ethtool_get_link_ksettings(netdev, &cmd)) {
-- 
2.39.2


