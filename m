Return-Path: <netdev+bounces-48856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF7F7EFC13
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863B51F2802B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C241447771;
	Fri, 17 Nov 2023 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b60qmXZr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5873D7A;
	Fri, 17 Nov 2023 15:19:37 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5099184f8a3so3684266e87.2;
        Fri, 17 Nov 2023 15:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700263176; x=1700867976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6GsLzHscU8yXDN6TiLq2nBefNDUx6j1mcmIXFk/Jmw=;
        b=b60qmXZrXpcnsvhqMBqdWZ7LdNGxsOsukBJjpyQrsrDqUq2yGsTiX8FtekSJqq7DHV
         45Hr2s58RyGVuJm6tdrkxfPw1jqMDnlChc2ZnocoqLaev7HU9ZhSVgjQgY2GsT4mFcS4
         11NsONJK6Md2VhFNDZougnjbUvxHS31vL0VTDD6n5sc5xGVDPUPBkGM0XJ3q2WB5s4OB
         0CFuh2GMVX0TFv59q/Y3lkGZnhEe/79o5S4eNHpu+aCV9dvACeH7YqhX0m014xjsIjBl
         NPDdpkCbo1IFDMGHvpfCJCxRgzKlT1pm+rjt0njJh4IXLGF8JFHqsR2G1M7gHzWZkddG
         akEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700263176; x=1700867976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6GsLzHscU8yXDN6TiLq2nBefNDUx6j1mcmIXFk/Jmw=;
        b=SbfK4CgFqpkrl12wkidNzbTSETv85TRr4ntrxQyqxvHw0Ubfs7NrCxzgT0mMbPaS9h
         484lqRu+r2TbGpNwocYjW6cb5LCRAzeadFupBGW742aOSN6D9W+bVyqN87IhRYAY8F6s
         za5+YImsbEDlFx87LgByVRWUyE3bJDm8h5OPoV5ysgJ7+lERgprFPDdKk3CqBHAP+4nv
         8sOxeRtzwGy7lcaVBIn0Aep/y+XlLXPbq9aorWt91rCdkFgWH2oc3enzUYo06UP9XrZI
         tnlxgdBgp4wSqQ1+PRxt8R9A/w/v1/e00d267KXpD8cRFdxUCQvxrghx/BemAfNyfP/O
         JNxw==
X-Gm-Message-State: AOJu0YyWSJIf/xCWOYcvLaB/6RldVd0IMa0CNp/SiHUpvRTKk+S0nGfM
	ln8S18JpgNnhx5CmzBBrRW7oho1DsgIugQ==
X-Google-Smtp-Source: AGHT+IG3QG4N7rbjOQNMHrLbf+ywamuEF8t0YgMdoAQcoq91DxVQQpucUmkjl2psV+qgzE+4JdKgKA==
X-Received: by 2002:a05:6512:3d2a:b0:507:ae8b:a573 with SMTP id d42-20020a0565123d2a00b00507ae8ba573mr1018067lfv.51.1700263175940;
        Fri, 17 Nov 2023 15:19:35 -0800 (PST)
Received: from rafiki.local ([89.35.145.100])
        by smtp.gmail.com with ESMTPSA id q22-20020ac246f6000000b005095881dc1asm377788lfo.87.2023.11.17.15.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 15:19:35 -0800 (PST)
From: Lech Perczak <lech.perczak@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Lech Perczak <lech.perczak@gmail.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH 2/2] net: usb: qmi_wwan: claim interface 4 for ZTE MF290
Date: Sat, 18 Nov 2023 00:19:18 +0100
Message-Id: <20231117231918.100278-3-lech.perczak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231117231918.100278-1-lech.perczak@gmail.com>
References: <20231117231918.100278-1-lech.perczak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Interface 4 is used by for QMI interface in stock firmware of MF28D, the
router which uses MF290 modem. Rebind it to qmi_wwan after freeing it up
from option driver.
The proper configuration is:

Interface mapping is:
0: QCDM, 1: (unknown), 2: AT (PCUI), 2: AT (Modem), 4: QMI

T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=19d2 ProdID=0189 Rev= 0.00
S:  Manufacturer=ZTE, Incorporated
S:  Product=ZTE LTE Technologies MSM
C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=86(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=4ms

Cc: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Lech Perczak <lech.perczak@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 344af3c5c836..e2e181378f41 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1289,6 +1289,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x19d2, 0x0168, 4)},
 	{QMI_FIXED_INTF(0x19d2, 0x0176, 3)},
 	{QMI_FIXED_INTF(0x19d2, 0x0178, 3)},
+	{QMI_FIXED_INTF(0x19d2, 0x0189, 4)},    /* ZTE MF290 */
 	{QMI_FIXED_INTF(0x19d2, 0x0191, 4)},	/* ZTE EuFi890 */
 	{QMI_FIXED_INTF(0x19d2, 0x0199, 1)},	/* ZTE MF820S */
 	{QMI_FIXED_INTF(0x19d2, 0x0200, 1)},
-- 
2.39.2


