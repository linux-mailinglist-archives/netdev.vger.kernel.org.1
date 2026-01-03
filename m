Return-Path: <netdev+bounces-246672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C074CF02F2
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 17:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5D133015D22
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60E730C61B;
	Sat,  3 Jan 2026 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Moot23NY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B631C84A0
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767459242; cv=none; b=uOLRDmveP57jcfQgqBbBfNxO1HzkWTST4WK1x42OeMEwrECydHfsT3Og8OmcOYJUGtzS10u3s5gVwmOqIC0xAPYY/LevAvcXHfjCKtc7ASwPybftvXfn9G+kekevG58yWR8Ka4M4w2+pQsUHdvHohFLspo3oIhMSkBHXrJfXZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767459242; c=relaxed/simple;
	bh=1F8SHDkYj9P8vJc2VfBe80qCMQVQ50SmXIlCyUaFvJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QIRmW+bjY2RNx66/BQhwmycocn9LJH1RKM74fEo4R8c8n8OsGwhylpilFzOouzrId/B3sgNsAH9lj3WCE/MOXLlX0Ki7lxv6396vZZNMpck2BPnRSXiYQABDdpcYFxy91848yYoz7SgCLZ2/U8SXmk6uSekm2GRvgDlRe34srM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Moot23NY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b802d5e9f06so1646273066b.1
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 08:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767459238; x=1768064038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFfX3vJf9DTVjlOkf0wH6fhwjo83TZZ2A2wA1i3cDBw=;
        b=Moot23NYBoWu5lgzNN2oOOTa2GkATKtFg7+txg3fSZWB+MlJAE6CEiF2RC38HmsDuO
         mL+fNMtP9nHMA0J4GLmDeF2mZwWeWym+Ms8Ickhphm5zPIXt4G7Al2fr7UXk5yWsWGu8
         90d65f3IofCg9phLksh4WzctocwjGjSpA5PlwO8EwS+QWdhbHzTKXthQUoOTQi3taj9n
         DzcTbGhejmgue3qtz+qvbWMQDiEKfQUHwMqM75cyG86/Csim2LktUo1I4EsV4EFPc3Iy
         iNUjFM30reTjJFazflFNLkwkXdd6NTkfXwqOo1b1tcGmUI2iwMLRJcYGQDL3dZT3RbbJ
         Q0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767459238; x=1768064038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFfX3vJf9DTVjlOkf0wH6fhwjo83TZZ2A2wA1i3cDBw=;
        b=IBgBZrNA8J1cOe1abaDHKsrS9xzxokUaegbOLK2j3VjDd/zs7BvGm4vAeqdVwvwP0F
         qOzWIievHPfCyoEcFQpFlmgEW9Vx8EUFkgio/p8C/xqYojfzJMIf/sXvvKR8VwW/+6m8
         ohdbT6jaLgrlBgsuhVyM9697xecU8/uoAcKNG3lbEFGIjulCD02lpPXyY5LuQomNTO6g
         JWSj4IpEmHJmu9JZGlv6yy6HzVw9d65PvaPpPtIXSZIoHA7yUpMrOHsvU0v4dDS98iud
         lnxCFukIkXtVSXVP90Jw4OxS1mDoCrSnIUJmLTmNkw8vAN9LoX7Hl2fE2ISJWaev0yl4
         /X6Q==
X-Gm-Message-State: AOJu0Yy0jUsHhZpc8cs4171brrAZMV3mvqSBBCPPKp32TGaYYoH2AG0O
	Fg971KIPpMNJm7Ec8H+wk2gzYezqFR8FaQODVcTyMZnH32ueVNBfHKET5ZzFnESL9mA=
X-Gm-Gg: AY/fxX7MHcCASvblGEK/dNhQGHqxatbV+2JgvJIruvrpR0QyLpRsiOdL54xSvGpEUTB
	Rbi4aa6V2UmogWHu7OG521rNwsFyrgkxcraN+XokCZkR/2PL2FUxLJH8KrdOA9/zLFxu3qDa0JH
	5VQw5KetMHWUQHm4td5aUlQLDd5pMsGzoQo1n6rfdrS73Qi47oXtFhGAhbdXvqbhNlAu+mRC21r
	ZOshGi52Qq3h0xaQglHe0PeVJp0YnL78r4o7NmqB3HhWlo1XUc4uN3mp8PuexxrtA3zCrEbfqx8
	xn3ulqgUqo7lBp7dKkO9Bj440oEyMXdh6XX8/visS26lSPj8TBz42N2l2c6Y1B+h5vW5iWgebMw
	8c7EnU4W0b3J8Kr+OeUVvGOIMZzLZePV1TmE3PxEzWHgbP2DrC4RNrAbNJtuWeK+B5t06DD9KqZ
	pWBxf1otCI7APHhQxYor1b0r4EVI1F/+DictJCU1XJ/ninw6AV7mYRUouViQ==
X-Google-Smtp-Source: AGHT+IF5nUeBLAc0qSfmGGcgL0y5i5aLAp8+GwurMZcThRbqlEN0oX+GtGcqbx2MhkDZv5XsiCbW2g==
X-Received: by 2002:a17:907:1ded:b0:b80:4066:24b1 with SMTP id a640c23a62f3a-b8040662506mr3077015366b.62.1767459238092;
        Sat, 03 Jan 2026 08:53:58 -0800 (PST)
Received: from localhost.localdomain (194-45-38-75.mobile.kpn.net. [194.45.38.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8045a086fasm4790124366b.70.2026.01.03.08.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 08:53:57 -0800 (PST)
From: Justin Iurman <justin.iurman@gmail.com>
To: netdev@vger.kernel.org
Cc: justin.iurman@gmail.com,
	Justin Iurman <justin.iurman@uliege.be>
Subject: [PATCH net] MAINTAINERS: Update email address for Justin Iurman
Date: Sat,  3 Jan 2026 17:53:31 +0100
Message-Id: <20260103165331.20120-1-justin.iurman@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to a change of employer, I'll be using a permanent and personal
email address.

Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
---
Cc: Justin Iurman <justin.iurman@uliege.be>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 7a6110d0e46d..7354436a19c0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -416,6 +416,7 @@ Juha Yrjola <at solidboot.com>
 Juha Yrjola <juha.yrjola@nokia.com>
 Juha Yrjola <juha.yrjola@solidboot.com>
 Julien Thierry <julien.thierry.kdev@gmail.com> <julien.thierry@arm.com>
+Justin Iurman <justin.iurman@gmail.com> <justin.iurman@uliege.be>
 Iskren Chernev <me@iskren.info> <iskren.chernev@gmail.com>
 Kalle Valo <kvalo@kernel.org> <kvalo@codeaurora.org>
 Kalle Valo <kvalo@kernel.org> <quic_kvalo@quicinc.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa218..410fd1f199f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18283,7 +18283,7 @@ X:	net/wireless/
 X:	tools/testing/selftests/net/can/
 
 NETWORKING [IOAM]
-M:	Justin Iurman <justin.iurman@uliege.be>
+M:	Justin Iurman <justin.iurman@gmail.com>
 S:	Maintained
 F:	Documentation/networking/ioam6*
 F:	include/linux/ioam6*
-- 
2.34.1


