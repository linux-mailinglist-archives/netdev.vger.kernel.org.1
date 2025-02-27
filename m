Return-Path: <netdev+bounces-170199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3178A47C30
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B0518869BB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B88227E82;
	Thu, 27 Feb 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFt7GV/O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36F215F45
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655607; cv=none; b=iUiWNbqNHx0D50fcZ2oa6h7SzoRR3dszVFVCBtDkUl9B8gtXzSDFR+f9bNXo14t0pNVZAgQyu3renuKu5ejE5e+ynnJoVkCH2XOJCu/YWA5bqDGKSioACGRDMi22CRLjLLgpPhC98+zOJhJgkQVKeTtIpQNRRcn8ll6aKwiPLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655607; c=relaxed/simple;
	bh=LuLQKzayq+fnGtN5h9gW9KBizQxexSQyrWWB6ztfx6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XvCXfxXfgKAM6bV7DAxFhGEU9L9ltUyH8raIA4M7hbEOzZibFaynti+fYUSY/KBbqIqDFx3gKPUfyMhZZRB/wLs47k7CU8UCImq6MBZ6BknOJBj5QHWXNw5+7M2P1wnVgLOGJEGeYIyvprNEKL7KP60vB10jYrp+vGCMy4Js+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFt7GV/O; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so5308455e9.3
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 03:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740655603; x=1741260403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIjIdSKzA2eVUtoV5mf1i5EH2p9i1nwy2RPTLAojtVo=;
        b=JFt7GV/Oo26PJKuc8uqTsVfMc5BNKKGmO8zywS+EaUmJrh7m6/PMrMa0Lf27IRoGmu
         BQnezzBu5vjvERO4yMvRoVdzjMrNN5m2959gLpHHmhbwaf3l5WkwZK3tsGU3A+9ddUnH
         v4brwyHY2DjOKRZCF2wCeyH8xVCvCdL8Q3IlRCdC+pkCxzCW7HMZQZxVez8wjKOtI/o1
         FmCYPVlGvxCS04Tmw1yEaVP6UTrSgiptJ5eYtVvvDlQwT1JgO8dWYs4CuhotaZToQYcy
         P0iiyo/g+EeOyfDDOhbxRp7f6kNOT7vb31WGFaVqofTC1YN29Z85bFqG/6xKKnNZQeCv
         arGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655603; x=1741260403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIjIdSKzA2eVUtoV5mf1i5EH2p9i1nwy2RPTLAojtVo=;
        b=CK0drTAJb7mxpSxvDioMWvTyMAWYkhHxu2gKuvgt3WBpZsexiwtdu58mRO6dYTdSWk
         fVRuK3FA7EfcanljytTyqTkHSUSOaTj9LfkZuuqOJlXBLevDHKZAKPob5iaN1hvxF1NN
         EywFDIDFwwpb9hPvOAmow/CyuYgSJu/m+cKSx7nBgIu/FCePFaYd8A09ktDGw7JYo0iR
         khaORqNAXVagF7sN/Ur7QoCEE3gzWPaNonJJu+hbuF/rebKQxxcpxGuPpZjr2ev+GIUC
         a6MOMCqbI4xFOpsw3KdAdPjxAUvDgoGhbNu1FvmdRfu6dIfF1qZ0a6OmwIKo9sVeM4tT
         prLw==
X-Gm-Message-State: AOJu0YzyNwu7I2agc+duhdLbeSSw5VmC5OYTwbe2RMxLu1VLDKLIEoB6
	0J916X0fVM9eoX8ct2gHVNSarxPySKqJI6E900kV6KgQMZ4mmUOm
X-Gm-Gg: ASbGncvoTw8RfJDfnL67AEfRu5sNiWnbClPdZPQY9+aVR/UOIjSs/n7n/Xxfe8Fqy0S
	DXSC41GKZRDc/yH7CqZaydyyNTDfOiq9K9zqV9h6C1P6F2SXIbBCw8/ou5eHk9ZnaJImDMWSTUq
	HwXA4ANbKnGH9IV4nn7EPRmK/yJpVTIPT6Cmnva2fKDUOkLwdkvrhLZ9PVSmn0zfMVmwSjeEGHs
	5x5Dynm++HERAS/byDXXYsmOPT0m+TPCyfYUtWpjjLlsYIC4BjWOgTs+MZccEiFCb8BWPl4rviG
	UdRRJZsePMJ2vdWRKdALByV289DmpqpcBf4qGrY9oI5c75JAv+RRqe1MvACGtnuHytwrltRu2sq
	ocjpfKNNeuG1F/mtJ1FQ=
X-Google-Smtp-Source: AGHT+IFu1T4pLoL25QsCR1COSbwJyIcWG0N9WE4x4R6qTbMszbbqL4HbKaAbbkH/Bzgj04YnlwgYHA==
X-Received: by 2002:a5d:6487:0:b0:38f:38eb:fcfc with SMTP id ffacd0b85a97d-38f6e74eed5mr17477220f8f.7.1740655603287;
        Thu, 27 Feb 2025 03:26:43 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7a73sm1757685f8f.50.2025.02.27.03.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:26:42 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH net-next 0/3] Add usb net support for Telit Cinterion FN990B
Date: Thu, 27 Feb 2025 12:24:38 +0100
Message-ID: <20250227112441.3653819-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add usb net support for Telit Cinterion FE990B.
Also fix Telit Cinterion FE990A name.

Connection with ModemManager was tested also AT ports.

There is a different patch set for the usb option part.

0x10b0: rmnet + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
            tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
    T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  7 Spd=480  MxCh= 0
    D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
    P:  Vendor=1bc7 ProdID=10b0 Rev=05.15
    S:  Manufacturer=Telit Cinterion
    S:  Product=FE990
    S:  SerialNumber=28c2595e
    C:  #Ifs= 9 Cfg#= 1 Atr=e0 MxPwr=500mA
    I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
    E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
    I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
    E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
    E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
    E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
    E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
    E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 6 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
    E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
    E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
    E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

    0x10b1: MBIM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
            tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
    T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  8 Spd=480  MxCh= 0
    D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
    P:  Vendor=1bc7 ProdID=10b1 Rev=05.15
    S:  Manufacturer=Telit Cinterion
    S:  Product=FE990
    S:  SerialNumber=28c2595e
    C:  #Ifs=10 Cfg#= 1 Atr=e0 MxPwr=500mA
    I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
    E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
    I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
    E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
    E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
    E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
    E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
    E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
    E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
    E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 8 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
    E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
    E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

    0x10b2: RNDIS + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
            tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
    T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  9 Spd=480  MxCh= 0
    D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
    P:  Vendor=1bc7 ProdID=10b2 Rev=05.15
    S:  Manufacturer=Telit Cinterion
    S:  Product=FE990
    S:  SerialNumber=28c2595e
    C:  #Ifs=10 Cfg#= 1 Atr=e0 MxPwr=500mA
    I:  If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
    E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
    I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
    E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
    E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
    E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
    E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
    E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
    E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
    E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 8 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
    E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
    E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

    0x10d3: ECM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
            tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
    T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 11 Spd=480  MxCh= 0
    D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
    P:  Vendor=1bc7 ProdID=10b3 Rev=05.15
    S:  Manufacturer=Telit Cinterion
    S:  Product=FE990
    S:  SerialNumber=28c2595e
    C:  #Ifs=10 Cfg#= 1 Atr=e0 MxPwr=500mA
    I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
    E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
    I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
    E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
    E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
    E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
    E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
    E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
    E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
    E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 8 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
    E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
    E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Fabio Porcedda (3):
  net: usb: qmi_wwan: add Telit Cinterion FE990B composition
  net: usb: qmi_wwan: fix Telit Cinterion FE990A name
  net: usb: cdc_mbim: fix Telit Cinterion FE990A name

 drivers/net/usb/cdc_mbim.c | 2 +-
 drivers/net/usb/qmi_wwan.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.48.1


