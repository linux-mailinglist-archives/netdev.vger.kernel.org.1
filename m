Return-Path: <netdev+bounces-101065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E587C8FD1BC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4411C22FF5
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795DC481B3;
	Wed,  5 Jun 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/PZ8Z/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1327450;
	Wed,  5 Jun 2024 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601665; cv=none; b=MTphiYaARCFfTFv88uoYDVVHHPhuQWN5sPtrpigkLhr4/KciOZpZC8Ss1LcVZ5f9nMdkehEuSdJhKMh4mDfOpvceNUKGqVbGQ+C8HX5ZXiTR6n7pXaBNpv/rTjamohWtTCHvfXd0NfaA/2/KFya7lHwZXGRRHi/Ru+x38Ic79Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601665; c=relaxed/simple;
	bh=ajRlHz4ISqja5UdXe1MvHhvYA/kLt79BL5wrslKLLUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XM4ln1d0//vq74w0ZeAJQ99VmMusySHbnShCH8uUAGseydwBeESVtbyCG5nJT3n5zVKzP8bOAWWChYbL69bBSx4zy2mhHs7atYoEfTVoEN0NTfyF2MPufo7PADLs3E0aH5+hELh/uimX4vo0In/6MhHZqs5/sJysMzft6m/WKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/PZ8Z/Q; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b962c4bb6so5969038e87.3;
        Wed, 05 Jun 2024 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717601662; x=1718206462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ozim78RZhEu9AGeHQuy80qkyfEbq6KZxgEz/yrejKE=;
        b=G/PZ8Z/QziOgyFUEkJPTtXQlr7lGLfdtef/bzWewatpru89h8niRPNvx+lO1gInnaW
         lEmxxbNDNcyEhghBEH0N3nck6Q/puN8s6gJ9k2G/oo/my3NEHW/u70db+JRPo6snhBb7
         nBVDKJQKA0HTNVLBbo5QIXu95ojRDJu50N6/DMo19HULoZzeK7AOkf0Wnvp9rncI0i80
         a9Czk+ayXKWvmq7NO2gDeAwieIhWVKYSbavsznHRW74WQywqacD+beE0mkywgcHkVjSz
         rSHYC5Kr9mFIX2aonLpt/IgoGZdCWSGPVn6bNegDchpvH0+sGbU7EUoighDIlxrKLET7
         1cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717601662; x=1718206462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ozim78RZhEu9AGeHQuy80qkyfEbq6KZxgEz/yrejKE=;
        b=ifuwUFZHJzwlAAejIsg8uv8Jpk4JRJU23LpEnwn0P05r2l5Nrp+jUkd/k81IIf29KI
         unXRdStXORm9ixm4MyD3LRYpmX0AjXznroC5KekbRUwzOv7xMp5eGLuNDH/lsy07xBpD
         6YphYtRuRoW405BqzojBrO6hwc8zTr2SRVthcyQGmEY7/0+55c6r6NAh7zDgQZ9kiGn9
         SnJhifHQnQEyYe1QhmNfwFrrFML1J3L8dVljAE0MIimdJpCfe9ULroFoYPMe47Wrpn5+
         y2TPNBURYo4kPB6Hee8WwuMg1HbJEb86UE8TQOsuOPJqo5XwwmPPdkj8+tNHrvNRiqR9
         e5ag==
X-Gm-Message-State: AOJu0YzlrbCHtn/tKI/Ss6VRpXwAeAu00vtbw+wXdeDnvNzucRez1e9C
	UwWdABCgW3joBPGFaDke1s+3g/9Fu/33ZRR6se5MqihB+eyy+Yyt33HEtPi/
X-Google-Smtp-Source: AGHT+IG8Pjb61i3+lCBe9lvPfRRYjfCsCB5bXJ+nq2F+RPU5vnSIUhD2Izw4Y9m1QwYMPd59Z3TqWg==
X-Received: by 2002:a05:6512:2253:b0:523:9515:4b74 with SMTP id 2adb3069b0e04-52bab4ca5e9mr2814781e87.14.1717601661592;
        Wed, 05 Jun 2024 08:34:21 -0700 (PDT)
Received: from sauvignon.fi.muni.cz (laomedon.fi.muni.cz. [2001:718:801:22a::6b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6831a91b36sm764215266b.167.2024.06.05.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 08:34:21 -0700 (PDT)
From: Milan Broz <gmazyland@gmail.com>
To: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	grundler@chromium.org,
	dianders@chromium.org,
	hayeswang@realtek.com,
	hkallweit1@gmail.com,
	andrew@lunn.ch,
	Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] r8152: Set NET_ADDR_STOLEN if using passthru MAC
Date: Wed,  5 Jun 2024 17:33:40 +0200
Message-ID: <20240605153340.25694-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some docks support MAC pass-through - MAC address
is taken from another device.

Driver should indicate that with NET_ADDR_STOLEN flag.

This should help to avoid collisions if network interface
names are generated with MAC policy.

Reported and discussed here
https://github.com/systemd/systemd/issues/33104

Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 19df1cd9f072..ea5c5be4a958 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1774,6 +1774,7 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
 		goto amacout;
 	}
 	memcpy(sa->sa_data, buf, 6);
+	tp->netdev->addr_assign_type = NET_ADDR_STOLEN;
 	netif_info(tp, probe, tp->netdev,
 		   "Using pass-thru MAC addr %pM\n", sa->sa_data);
 
-- 
2.45.1


