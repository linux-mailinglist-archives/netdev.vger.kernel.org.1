Return-Path: <netdev+bounces-212446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16374B20775
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 13:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB411893257
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B432C3745;
	Mon, 11 Aug 2025 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOvnX+Kr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B02C2C327F;
	Mon, 11 Aug 2025 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911335; cv=none; b=kedBPKvg7BgtNTCmRRALuiCIf5bVblyUVSIolHq4P17w37rvR3hRgjhFlblDMaijv7wnowi7u8I+msBBRWfhja6+q+qXdYjgLj6gDb6ZIyN0ksCAsa+bIwCyOTF191jhbSOWl9Zhy8BoFFW9oyilCWn7B5RmB20BAq6HdAWH6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911335; c=relaxed/simple;
	bh=mqTVABIauHO9LRTapJL80A3vtc4ZkZVHXgu77CE3mB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MdIB8HUyhm068iQ+CnRmGeps7RUXeKk2dGGr1HbdoR4mR84DrUu1HUtgBp2VgNzzQsuvHIVu+N9teZTgSMl4z2gFzsMIrjemYpvcwF0rMJNZ45jLqwm81SzauYfHiAgRJojaJXdV+7ygGB3Zh50uYdSYXcPguGczruRaQ4RK0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOvnX+Kr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-456127fa3d6so6291685e9.1;
        Mon, 11 Aug 2025 04:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754911331; x=1755516131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5g5hDi7jeqhhL4tmsyaBdgjOZMXvW3aL4OS/N5PPoYg=;
        b=gOvnX+Kro/IVPaWvUB9BnB8y2CPs5ZHu9WU/gpRjZtpQu7e9gJblnnTt1xga5lL4uD
         1q7gnsr/0pv80dpY3lJXaRlnEXXSb0cl2n/1P8U+uLyEckB9ddPuQvrh7HrPfFHowT/b
         PqGkbhLR4008JS3lLNPYbBSTJiCZ5tzl88/FsNUxDZx5bwpAn2wvsCVa0S3QLopLYrce
         M2kPGE/vLkreSpwesDYHO165c8ir7IdISsvuQxWoLUX0tWoWdSKkVVEr4inWv91q150i
         4Lcq9k5dVhscbZHnkduc9FHUMO5kbwGgC1R+K2+2DkARUG+AOhTweGLqbdpr8XYxFQ3b
         uTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911331; x=1755516131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5g5hDi7jeqhhL4tmsyaBdgjOZMXvW3aL4OS/N5PPoYg=;
        b=S0fcXn8VFjr6TARpUeB2SmMlc44A1EmGz58WiMM/GP1OOy5BXn1fPU73Ttk0Wj7c9O
         h8SHsHVlQxqxEnixwBd5tZ739jPXRQPcgt0DZuEuUh94VOsI51YQs3bIGyOtR1X2rk/7
         8r1vNsw8+Glmy2L40K7ur48Gjh7KhaIBY6MHkdjfwSz/XRmQudyp1/sXMFn6Y0Huy87Z
         mFdxqDvOjcYg1cezlR8UJzVEWgdgw9RCZR8rK1dUNBamk7sBxXL2ykECKKlXCIByhvNV
         tnYK6mtr+bLjGMIOexWtO7w6/Nr2dgbgrrcrs40HC1QaoHm3A1hRAXh0Dr5U1w5tm+A8
         /ZuQ==
X-Gm-Message-State: AOJu0Yz33YRiRPFY/wOhNjlygOvtp1c7kiM7KkQRUAYbTRUaOSAczzf7
	DlThcCOgowgQlc26HEbdMXc21etH3hRdaj3cUNeTRih4i1eXrAR+Bt+CpVa4gD/Q984=
X-Gm-Gg: ASbGncujQH+V/CvGn2awVySLBOCcVHWma+oExmwbsSFZAqzd9tZPf5fMfWznfsqOTRk
	GGRQd/IpXp/m8Y9PXhdoXfhil4pKHC90ZVUu5TOPBJ1NauLlwaOSiiHA4y2ISAWp2d0wgaLuByI
	zfCdWO18XrMClMK1SFTxPTscqgNDStsv+r7UaNbw1i8aBSssMOlcOBwU/SjZNI1FxbUrRL1LRxU
	/nVJMGpCAxAgDGCP+04q8LjEjWCU0e9R+l6W+KD1Ll5qZBxqDuLTUnwSETJOUGXL5oMSTlrrKmY
	M7wPlT7cVCPGUJUzp6Q7lcmLMiev8BWRsSToHb56N9NCt1WXN3GN89FtBv85PIsII7TxgL9rMLJ
	7mDL00KneP+Kon1JiINu9oVukEqriF9HaIdnUeggJaeo5NgfJOBBjQjABczrc2BMudfm+7inrSg
	==
X-Google-Smtp-Source: AGHT+IGH7TsHfHe4aY4SI1cXo67Gk3CyAYojTMifCQDhVfute1+x1Z+lPV6jjXMKTd2spw6sjIpuhQ==
X-Received: by 2002:a05:600c:6095:b0:459:d449:a629 with SMTP id 5b1f17b1804b1-459fc1ec115mr32073125e9.8.1754911331131;
        Mon, 11 Aug 2025 04:22:11 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm322605505e9.2.2025.08.11.04.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 04:22:10 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH] net: tun: replace strcpy with strscpy for ifr_name
Date: Mon, 11 Aug 2025 13:22:07 +0200
Message-Id: <20250811112207.97371-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the strcpy() calls that copy the device name into ifr->ifr_name
with strscpy() to avoid potential overflows and guarantee NUL termination.

Destination is ifr->ifr_name (size IFNAMSIZ).

Tested in QEMU (BusyBox rootfs):
 - Created TUN devices via TUNSETIFF helper
 - Set addresses and brought links up
 - Verified long interface names are safely truncated (IFNAMSIZ-1)

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 drivers/net/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f8c5e2fd04df..e4c6c1118acb 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2800,13 +2800,13 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 	if (netif_running(tun->dev))
 		netif_tx_wake_all_queues(tun->dev);
 
-	strcpy(ifr->ifr_name, tun->dev->name);
+	strscpy(ifr->ifr_name, tun->dev->name, IFNAMSIZ);
 	return 0;
 }
 
 static void tun_get_iff(struct tun_struct *tun, struct ifreq *ifr)
 {
-	strcpy(ifr->ifr_name, tun->dev->name);
+	strscpy(ifr->ifr_name, tun->dev->name, IFNAMSIZ);
 
 	ifr->ifr_flags = tun_flags(tun);
 
-- 
2.34.1


