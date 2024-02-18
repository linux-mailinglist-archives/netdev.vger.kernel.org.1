Return-Path: <netdev+bounces-72786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D45859948
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 21:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682141C20B02
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 20:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD026D1AB;
	Sun, 18 Feb 2024 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSzpFWrk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58FD6BFC5
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708288970; cv=none; b=EFG2q8nRJBNJycVLa5oOZCGKfJ5fpi9nzgejQ/dVbHgYcN5//wNNWrt8DYgAZL7dL0aWxWdnYVVv17Z4RLa/zcu5otIOqPf+3qtR4HgfebntFZxYDMVb0xuK5k195/8jhqwLMvlPsumpI321hQcT2bMyl74eFXVA3d373i0r+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708288970; c=relaxed/simple;
	bh=gfVvYAWNY6yAxXBb1KaiR9CHUCQ11MCSpG5xdmXJV+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f3I7WSaUU9H4GgYtJwTkdyGtYub+yUFWK75Wk7MgMa2ENsMikaZtvun/LTbpNfMfSk/bFsVcJ9wZwPmZW4WlLCNjUsd8fUkK8SrUFXO3dL37lsFgM5XM3mCevj8K8ofvjls3Iuj6a2TT5DORiHZbTB6QT7EJu+0PgvMb5yfLsAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSzpFWrk; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5120ecfd75cso5188750e87.0
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 12:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708288967; x=1708893767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A4wuobbkvZGCZAhSKedoEZZtznCmj4kzN6YiqJeHCoA=;
        b=nSzpFWrkIYKmye2DkqV73V2UNKY3OTMiJOZB/ZBMEFxhwaDujzwZF/Y2PU9+ogrlh5
         5oq5BwbGwHpKV8h4WI3A3a/wghNpiugOZIrW6yWI820gU2qSairBUNyEk5b2wlfE+5aH
         VVMFCN0MSX5kgTJbeANJbrwZtRPeSPkdlie1NB/kpbmYiwTTH4szB3OGK6c7Nmedu3Tn
         s9zGMkp3XSuPGGxippim0Cze1m0S4a9Zv+AZhqHgC7w8vapPvD4FGL2B6ptoCiZrK8sP
         ug+SvFvjkHKafAwteka9nyy6MVxtuQCf6Tq95K0TyWe7PezvbTS3OaNTSAtfsUDgfDKi
         Itjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708288967; x=1708893767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4wuobbkvZGCZAhSKedoEZZtznCmj4kzN6YiqJeHCoA=;
        b=GfElVbmAJ43j+m+4elcdT4lOXKvroH8f9vX1wocD6PU6vm2UzC6D39NtQ7zGb4Qt7j
         H9S2dlLgbUCdTNVKhW/9Blf6mIhw07SIi1tulwECK62+Y6NePDuALFp/M0CMLZvHl27V
         LJK8vAVi1UC0H2j1+qf9AjUzlfElYOAxs5EaShxEutA6FP8iDWa3ej+WAyOFH4dXyW7x
         +o4Z/rbdRO9kaLMDfPuYgecJIpZzYeofSa2DRrEooj+jWeZZQmQQPoQVfi/a6IkK1HPN
         p10v7R5fLOKG2o1c+kF8EX6GPhkReo1Lok0KknAyn3gCE9cpfQHiKlbGlRPH2eRrJOZR
         CFow==
X-Forwarded-Encrypted: i=1; AJvYcCXwER/5+PaTC1pEofMDnngkRLuU/Zfy9MW1xkGXddvdkkPzHZzs3bcp3N35UXMTGB6acn3ZeVatfZTBcXVYRGiG8g3fdE45
X-Gm-Message-State: AOJu0YwXCOJGaaocdOq6mUo8UMJIoQ8Sg9ia0l/yBac328I9BQgIK3Tc
	Et4J/TufrAqcf/eMqfOWqx3T7QeBYqmmHpbq8oN3P0iLMufcxd4i
X-Google-Smtp-Source: AGHT+IHQrAkFosp2/Oq+wdEEibNuo7/2rDYcjzT1fw7vGkg10OV4FlM4yok6+Efb8csj9Ci98NOYIw==
X-Received: by 2002:a19:ad48:0:b0:512:ac39:d1f9 with SMTP id s8-20020a19ad48000000b00512ac39d1f9mr1287469lfd.37.1708288967037;
        Sun, 18 Feb 2024 12:42:47 -0800 (PST)
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id i22-20020a056512007600b005116e3c5b07sm649818lfo.254.2024.02.18.12.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 12:42:46 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] ipmaddr: Add check for result of sscanf
Date: Sun, 18 Feb 2024 23:42:03 +0300
Message-Id: <20240218204203.7564-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added comparison of result sscanf with 2 to avoid
potential troubles with args of sscanf.
Found by RASU JSC.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 ip/ipmaddr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ip/ipmaddr.c b/ip/ipmaddr.c
index 2418b303..00e91004 100644
--- a/ip/ipmaddr.c
+++ b/ip/ipmaddr.c
@@ -148,7 +148,9 @@ static void read_igmp(struct ma_info **result_p)
 		if (buf[0] != '\t') {
 			size_t len;
 
-			sscanf(buf, "%d%s", &m.index, m.name);
+			if (sscanf(buf, "%d%s", &m.index, m.name) != 2)
+				return;
+
 			len = strlen(m.name);
 			if (m.name[len - 1] == ':')
 				m.name[len - 1] = '\0';
-- 
2.30.2


