Return-Path: <netdev+bounces-127207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5A59748E8
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC4928753E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7061CA936;
	Wed, 11 Sep 2024 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XDJB/1Ki"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4B4AEF4
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026389; cv=none; b=qcgPoM1wceUSlclMoV2e7msoMRUYGFsSTU+FNughYkLr8XeYuRkWNvaqhwlFhfH3fIF+XRwjYfvlTLFmkgmUgfqInqcM8DmX4/kMoDvf211fYj4iF8pQatmHqKl9xWQQNNl1RsA28IvABXnu1JO3sT2lCnFHpUicRi1HxFKZuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026389; c=relaxed/simple;
	bh=QTAU5QSJbQctG5WaISgyghKsFx+LOju88Pf8lcQag94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g8dg1fMDGddfjLQxvwx55xe+DigoQh9+XyaX2YWkG4Rl1ejjNoubWpWC17OJlSmTvxrLuwNOOPNaqry2BozQwuV9fRy1S2IE5uF+8ebgiJA2hgFGHUBGZfJvC4+OvUcZj67ze6tfj2H81gFJB0KmaXYrFlOXlHY4T8CgwTHplp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XDJB/1Ki; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 27B093F1FC
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726026379;
	bh=yL8cfuBHbv/+QDaz3oN6p41pZGLl9y8x1hYJn5znb/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=XDJB/1Ki3btbAQVtyBvI8uEY3qQyzbdhyQzkNtDiPZI1tJnqNglX6fAaFKYHPTOo/
	 /vNC6yiuYGGJGKLoRaOXqJAswwf66J86VNtDGva/w8JzpcHCSB2QcXHeiLiXUxT62c
	 TRw43dZ4KLLSo9kuXnzJpRcTKRdQwUGjOHZPY3oYpDAuQBXVJk620oXUONRiZy5wFa
	 RBrP/Vhg6j+NELA7IhZrF0ArU/h/X/kE3Nt5lD58caL/MbzKl/q56FGvmcGeLjUdJ8
	 Ap0vLqKsGAp0BtSit8JYYlafDvIv43Ul01GD+r+uNbgcPRLvPtKt+eUpB39sUUb9ql
	 XYwB3e8cwBfZA==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-207510f3242so9371635ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 20:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726026377; x=1726631177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yL8cfuBHbv/+QDaz3oN6p41pZGLl9y8x1hYJn5znb/k=;
        b=Pxx6zxCvOdDrMw27g/churUcoAO9rPtoiv0c8mDvueIumzuxuEhjEWCXyer5DDU/vu
         +nfWY6YQdjX+rZLGKMBlBP8NlQHPIA4WWUyTB6TBC7vpdrt2xnNT2J6qfGKnYY7qqRTC
         ePrzucvsUF+T5FYq1t0iV0BIkYsrZJHW6NqJZjMtMtVrq/GjfOiTd8XFGZP5/WN+laE4
         A3FLtRhoaabXiV8PsvfD9bqcmgjNxMZzjEzQNESZWFESZWWLFasPXnaYdDd+nGQxcrFr
         eyHOxH2n1b0t8PH/HxDwNd6RJ0RYd8VsPm5L9+FHx2/Eg/cyTYfl97PVZHu1uzrd88oM
         LqJQ==
X-Gm-Message-State: AOJu0YyNtfbeXxAC+4GHOlouKsjpqrWMUvseEVjTF7mrbW2KySNM3xpF
	Zo+CBRvkaa5Ycli9UHRbCjC6UU7+sg3ENc/gAJbvBoJVT25UE9zmJXdPFGx3Liq1BgFKS61s3ZX
	pR+g97oG10+LXOllN3jYqGd0DAF64nLYJNM75ybWi3zO0XA+YKEkrewD4rK6queEorlSJ5w==
X-Received: by 2002:a17:902:f789:b0:205:8456:df0c with SMTP id d9443c01a7336-2074c600e09mr38625385ad.26.1726026377563;
        Tue, 10 Sep 2024 20:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn4HKfDX0EUSTejd9Sn+M8Cd+nlp6ratYmkL3KHiSE3D1Pramd6+cdAuh/ZFDLwe3bKr3ZxA==
X-Received: by 2002:a17:902:f789:b0:205:8456:df0c with SMTP id d9443c01a7336-2074c600e09mr38625155ad.26.1726026377185;
        Tue, 10 Sep 2024 20:46:17 -0700 (PDT)
Received: from localhost (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20710f1e921sm54831965ad.212.2024.09.10.20.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 20:46:16 -0700 (PDT)
From: Atlas Yu <atlas.yu@canonical.com>
To: atlas.yu@canonical.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net v1] dev_ioctl: fix the type of ifr_flags
Date: Wed, 11 Sep 2024 11:46:08 +0800
Message-ID: <20240911034608.43192-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SIOCxIFFAGS call dev_get_flags/dev_change_flags under the hood, which
take a unsigned int flags instead of short. This mismatch makes it
impossible to get/set IFF_LOWER_UP, IFF_DORMANT and IFF_ECHO that are
beyond 16 bits.

Signed-off-by: Atlas Yu <atlas.yu@canonical.com>
---
 include/uapi/linux/if.h | 2 +-
 net/core/dev_ioctl.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/if.h b/include/uapi/linux/if.h
index 797ba2c1562a..b612b6cd7446 100644
--- a/include/uapi/linux/if.h
+++ b/include/uapi/linux/if.h
@@ -244,7 +244,7 @@ struct ifreq {
 		struct	sockaddr ifru_broadaddr;
 		struct	sockaddr ifru_netmask;
 		struct  sockaddr ifru_hwaddr;
-		short	ifru_flags;
+		unsigned int	ifru_flags;
 		int	ifru_ivalue;
 		int	ifru_mtu;
 		struct  ifmap ifru_map;
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 8592c052c0f4..4b317561e503 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -145,7 +145,7 @@ static int dev_ifsioc_locked(struct net *net, struct ifreq *ifr, unsigned int cm
 
 	switch (cmd) {
 	case SIOCGIFFLAGS:	/* Get interface flags */
-		ifr->ifr_flags = (short) dev_get_flags(dev);
+		ifr->ifr_flags = dev_get_flags(dev);
 		return 0;
 
 	case SIOCGIFMETRIC:	/* Get the metric on the interface
-- 
2.43.0


