Return-Path: <netdev+bounces-113475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DEA93EA3C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 02:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33AF281B35
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 00:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5569D163;
	Mon, 29 Jul 2024 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmaEHYLB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15E38B;
	Mon, 29 Jul 2024 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722211961; cv=none; b=pKf0PUvvde/UBOcHdr1LpE5+6OjppAHyZQaBCyoMoPnSlpJ+cToPacWvDEUdq4K5n3bXvh+/rcUtNdntY61EodisX+iY2wxTmAg1JVk0p9znkSuURhlhS9bdh1pOn2iv6WVkS5ZtsssUEPgVvjG3jogfJ9n9v3nXmhlH3uAw3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722211961; c=relaxed/simple;
	bh=Xai3wjFM5baFFtysPa1Zqx7AxUbTkRehOK/vCsm1ISY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JoShIDHm7ndl1g/vS/8gzYMXu+9+CIzps+Ta0MlTi6dYGVwkWlwDzGRJdacKLP8c46ikzX0SsgoqQooMxvfNAR35ZkZeuotxyB5XZeHYj1/kH6UnB/Hvb0hyU358UEOP3SLlomb/Lfd9k/7eIwMVoHEQHn9Yc3j/BW/kZwqfnEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmaEHYLB; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a1d48e0a5fso1401838a12.3;
        Sun, 28 Jul 2024 17:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722211959; x=1722816759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMdVU8mEwzXRv8+EeAgVWtBrBMCb5y6Ue9pFbF+sbk8=;
        b=PmaEHYLBH1V3v0wwcY87Lzh46lbT/KtsWvD+ltOyKumnOzhqXzVXK6Eq7ApmpdQ4z+
         vH+y2GepkmMdRGfa0F7+d2a8JeIWznn299bOR0IkJc8kkPWUDwSxH+K1C+r4/YSfvfuX
         5ZAoHH1X4uXzTDQZjPiS23XIVIhsMgjeHjljXarcAAr+7dzwFyZcmjA0FjFq0Mqk3X6q
         2wBIT0fvVV7rU0Lskc8Sj9C7RR00bdvisNxCdgE7UeBNkix3wYc3T5nGox7zK0t3DW/D
         fWN76r7MnUm9b6Fij+gEfpAObXjJME3BGJmbRGXZVlk6xBVUEFWL4RmStf+Dw2QnPIPt
         9HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722211959; x=1722816759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMdVU8mEwzXRv8+EeAgVWtBrBMCb5y6Ue9pFbF+sbk8=;
        b=YfMQvvSJCRscK/y8GHr6xLBsppTuHhGm0y+YRvz6jgZngGjLNNXMKzhjV4ySjZLwbq
         4DfUvJsyuPgvjjtV5+E1EVI8op5Dd4YJc1mr8/xSXebayhN0X6s9s/RuEuAmCGIMKkB7
         s2Okza+0NR3RxuwPE+wzC7URucMCiISM/4cPbOypo/+si40ssKJtuI26UXZ/vwq8Uc3L
         EcGvj5Qr2olQcOsF+svdWCsuIuS8RlvgTmGOrz9Z5e5LJ4UHRxbmkKvW6ScdrqP7fW+T
         HhLo5unqNesdshvQo8ueCt0nszmD+Wd4N9HZBqPuDf1rwqdzKLUqRAf8wo61RcGwCZ4o
         hdhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEFMswUy2qrv9QzI4+qZZKs3xDB0uHHlB7tyNjcPeExiE8clTh89wSYLWVF3N83cdo104DL4nKi61iJ5sfNVA7Kd6Rsb5N9Ehq8cv5Mkkj0kbebTvTVTxW78jw2/nca6Ftc6br
X-Gm-Message-State: AOJu0Yyz3y/goWfnlZopgt/GcJ+c9A4n0JtUfbL0n5dMxG6aXQC0nL1A
	2rB2m5KtEZOzzbtBdzhLiXk1y+RaHaRWfqldcyNVGrqYVf/AGb3n
X-Google-Smtp-Source: AGHT+IFV/ggEHzpg5AUBnzWv+n4rr/MoLUf4IiuyPH3eHcNfHoEr8lYFiTBt/m1Sxp3m4sxlRYXemw==
X-Received: by 2002:a05:6a20:3948:b0:1c3:fc87:374e with SMTP id adf61e73a8af0-1c4a13afd3cmr4696361637.41.1722211958931;
        Sun, 28 Jul 2024 17:12:38 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f677a0sm70106035ad.234.2024.07.28.17.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 17:12:38 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Decotigny <decot@google.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net-sysfs: check device is present when showing duplex
Date: Mon, 29 Jul 2024 10:12:10 +1000
Message-Id: <85228e43f4771609b290964a8983e8c567e22509.1722211917.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sysfs reader can race with a device reset or removal, attempting to
read device state when the device is not actuall present.

This is the same sort of panic as observed in commit 4224cfd7fb65
("net-sysfs: add check for netdevice being present to speed_show"):

     [exception RIP: qed_get_current_link+17]
  #8 [ffffb9e4f2907c48] qede_get_link_ksettings at ffffffffc07a994a [qede]
  #9 [ffffb9e4f2907cd8] __rh_call_get_link_ksettings at ffffffff992b01a3
 #10 [ffffb9e4f2907d38] __ethtool_get_link_ksettings at ffffffff992b04e4
 #11 [ffffb9e4f2907d90] duplex_show at ffffffff99260300
 #12 [ffffb9e4f2907e38] dev_attr_show at ffffffff9905a01c
 #13 [ffffb9e4f2907e50] sysfs_kf_seq_show at ffffffff98e0145b
 #14 [ffffb9e4f2907e68] seq_read at ffffffff98d902e3
 #15 [ffffb9e4f2907ec8] vfs_read at ffffffff98d657d1
 #16 [ffffb9e4f2907f00] ksys_read at ffffffff98d65c3f
 #17 [ffffb9e4f2907f38] do_syscall_64 at ffffffff98a052fb

 crash> struct net_device.state ffff9a9d21336000
   state = 5,

state 5 is __LINK_STATE_START (0b1) and __LINK_STATE_NOCARRIER (0b100).
The device is not present, note lack of __LINK_STATE_PRESENT (0b10).

Resolve by adding the same netif_device_present() check to duplex_show.

Fixes: 8ae6daca85c8 ("ethtool: Call ethtool's get/set_settings callbacks with cleaned data")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
v2: Restrict patch to just required path and describe problem in more
    detail as suggested by Johannes Berg. Improve commit message format
    as suggested by Shigeru Yoshida.
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0e2084ce7b7572bff458ed7e02358d9258c74628..22801d165d852a6578ca625b9674090519937be5 100644
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


