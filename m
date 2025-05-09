Return-Path: <netdev+bounces-189284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0D9AB175E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F01A075E7
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502B421CC60;
	Fri,  9 May 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WwdEbDi7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD121C9E7
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800871; cv=none; b=alUDCf8AOcp2gZsWhLZo9QKP7/HirW9boJ/KemEpHEGetDzSQvUdgc2Fz/l5fSKtbmwytxvtTbd2/pmoJ1Zh4kDY3vmgF4RxL0D+jJ4RxormSslDf0wS+7rRcwNIiQBkpHe/vHdebjdIXOyUW5Kk+6AUudLSjVRKpZUFTsPiR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800871; c=relaxed/simple;
	bh=zoFd6yM2jO4l5buq2BxdCOcGr33b+h3WWROBWfiOUHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEV5AVr6mqHJSm97XL3ST+8NC9luiwutUtDHRZ9s4PmCLY5hT6GtRwRgoUqRkkmhLEJlOZPIo9s4Z58hahxfrykk1GWZITUefln8ulTH2HUZFNVsVudSG+dZuOyHCKBFwW287MxzIoM2V2fMHpJvn4AiUDQnU6i0DpyakBHUP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WwdEbDi7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a0be50048eso1415301f8f.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1746800867; x=1747405667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPGy+GjHeYV+uwN6tyXbPz06AQDovozMZ+Px2Wp1mjQ=;
        b=WwdEbDi7NTUH1PZywMxBFWBmb+XrhDjpZksA3V2pTyIf9ECAHnV4Am1a6bxvNSW2ew
         wZyZ67NMt02NhMtdu3FRtPy36WVNTVqz7PnbSgELgq4Ros65WdIDplsU0vCehi6VWBuG
         k2+H4/LcD5By5YAVFAYyw4W2pxhKkxcIb9WPc+tx3+SPiwUVmcj/RIgmY/RWfz5jhauH
         q/Ic5H9azTFIOjT0AllhHtiDmpFYBTzeT2uFl8OVo2/H1fNVUJ+L1qXTTf7A/S8Dsdu+
         xCSntx0mlxitKWoesNjHv9V8DPpyJ+YNppKrTTqa4+Y9oCMwwLq0+6DwHcA7WVO7npIO
         46Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800867; x=1747405667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPGy+GjHeYV+uwN6tyXbPz06AQDovozMZ+Px2Wp1mjQ=;
        b=B3j/Dz71pNEyja/mawg+jXh4wGBzOc4mPdizTU2Mhf4urAIdoHGWSsldlOVkmLaMeZ
         xY0K59QlBFva0mEUnpJ/CEtPHUL1irWINxqKqay9teAwERnqpPldQUVB17pzVwTueWxU
         RTYDrTDgRz01+TPzOJ298xSTq5y/euSHmhiqPKkMZmVr+9O0hPpJQMsRTR0KUTc6CSuX
         XhQzsnB+l3VLAxTm8W0WsqbihfBDDqqmRJXM3EGAV1oHoZ37R7Ln00RLGj4XAwk2E5Lp
         sFv7f/IbdyAkl1ZEMNOeQd4Wk7yaJqw/b3/5qNcIStLz+Lp1vhQG5OxVvZDMVPMmfnXe
         pUkA==
X-Gm-Message-State: AOJu0YzLH6ZsfmW+hoiy0gHCXWJEuAyo1A9/t/oh3Pw5yX8KkAi0z9Qd
	B/Wv3kTh6BFjF1P4fB6P3+qRq0gyxmhzTI7PAjNEiR2h5JNdh3i43ubkVXaTyQNTNWh7GgKQFxp
	PJUexqnNu0Ju66RULD5wBC+qU7hjT50Wiv9WlufqPl5yMjB4qyBWb1MlfmevO
X-Gm-Gg: ASbGncvfPQLVy2olwQkpllfUwuP/gfxWxcxdGaEo4fICXUni81exkQm95MnyHjPPOlF
	Jyu5Wv3BFwYOnZQ1l6YnpngkS3q3LdfIXT+5tqaQ1mChci6oNFHCIghROEJf4YQRU9wFEscTR8K
	EFR39o1NnCIPP8AR1p7/0bXToKq+FP/wobfb6aRW7P0gCJVZKkTu8te4DLrk84ORPs8t1L06CWP
	E5asZt6ORx0ZNEREuGgPHenaB46rImWuicnvflCgS3hsee8MqsLCPZ49PDjGIvUj3czaDqJCBIX
	bIzsKWg6pHk6nv/K3o26Cx/B786khpS6YOjeR7Fm2j6gfcHgC3OHKRW/HTsfAQU=
X-Google-Smtp-Source: AGHT+IFtPyrQzSm3zyfnehI32nxVRQNmsmOAJk4AqeEuLb62d83wkWyRsODY0amde7mCxu958bM1tQ==
X-Received: by 2002:a05:6000:1786:b0:3a0:bb9b:5740 with SMTP id ffacd0b85a97d-3a1f64ae6bcmr2440165f8f.59.1746800867045;
        Fri, 09 May 2025 07:27:47 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4ed9:2b6:f314:5109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdd6sm30905025e9.38.2025.05.09.07.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:27:46 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 08/10] ovpn: drop useless reg_state check in keepalive worker
Date: Fri,  9 May 2025 16:26:18 +0200
Message-ID: <20250509142630.6947-9-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509142630.6947-1-antonio@openvpn.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The keepalive worker is cancelled before calling
unregister_netdevice_queue(), therefore it will never
hit a situation where the reg_state can be different
than NETDEV_REGISTERED.

For this reason, checking reg_state is useless and the
condition can be removed.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a37f89fffb02..24eb9d81429e 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1353,8 +1353,7 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
 	}
 
 	/* prevent rearming if the interface is being destroyed */
-	if (next_run > 0 &&
-	    READ_ONCE(ovpn->dev->reg_state) == NETREG_REGISTERED) {
+	if (next_run > 0) {
 		netdev_dbg(ovpn->dev,
 			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
 			   next_run, now, next_run - now);
-- 
2.49.0


