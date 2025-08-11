Return-Path: <netdev+bounces-212597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6268B21685
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 22:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B383216D304
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E15F2D97B0;
	Mon, 11 Aug 2025 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHeqLn32"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3029BD86;
	Mon, 11 Aug 2025 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944426; cv=none; b=aYQ1iBrg5baA1NzTkpaCBDBcW16Hr74qpzC4rm65Z9yp0+cnAjuw/kjmYjUeHdm764RNsQaPelueA0N0mtEwOVXAHy+xjXLIS0jlL6Jr9Gnh1bxuSSykd98QSgem3/FA0l1Qv4f/gwdoRH28VcHywkKbk+AEEp60nmkDpf9bTl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944426; c=relaxed/simple;
	bh=S5lcfUtp71/9il0VG77vgPWtjLtzdwdq8K2rrHgg+mM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPil29RNWUftQ28JkhdCVwA2snIXZApzIpkrWTZ/WV6JhEsoUNi14KPwYIXAY43J2O8dEl8ZAu9OQXK3VrOCZuNCii7lWiKplJrNiX4MWEg7FdD/8+Y/3ZPhBDGFEyzzeHwnn3+bPVXbHBELXMTOjUhfrxbfxVqktasilvwQKgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHeqLn32; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459ea4f40afso8698635e9.2;
        Mon, 11 Aug 2025 13:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754944423; x=1755549223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lYYrjSv6845A5J/SgoFFrJQ1Leg9B3UPlq2+hMK1TE=;
        b=JHeqLn32x9qZGTYNUi901TEgRQbNewAcX2d7JgjoOsTNDwGZcHqkYcsXX+ZukEethk
         8SdpjZf8WyTJ32uLWSNeftvaxQccvS7wkeb6lVq1XFwUEWNvpGmyU+2OgXa+CSD5/hMh
         EUYg/Hp8yqVpbTX0awK0xi7qKOeVnvF55uaUL9maIjYYynPIojwUJLvongsVpociDPFn
         uusCwgDVbbNeazSyt+uDnnLoF5sunXTgL5McE57Gf9T2Y+vAoi/+AWSumytvLtBcwwW0
         2FCtaPY6xUgPKCiQSKrDtGcxEKZWLdkVWj3u0KQ3qNvdn9v2fv/vNYgMDWbTYTHed8tv
         rk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754944423; x=1755549223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lYYrjSv6845A5J/SgoFFrJQ1Leg9B3UPlq2+hMK1TE=;
        b=ofDr2p6BXC7QJjmcETrO0YoUPFyQG/LUVqEO4m4F9JlDozAqfQ15exHxqWkU734qkf
         73uY02X7zPRKjNBvrwgKq758gbetRydh03hS3q0ycap4SfUttxuwPQZDpMnI+ffrxUfz
         CptjMiYxb2JvudNWVTzM/40GG+rlaV61fTvkilFIIgxTKfVXaxsHHvn7Yjkap43mPsJh
         nTj6kRXC91qWyuz33tvY3tN6XoafMMNZo6IB2Pv7U/5BX3e/cQuBNnZtfByXW96TH8xZ
         MYyaKeawBXelZ+C6B2xu1itCuXDmHP4UB9QJPE9ODWeOqc2qvOpsTh+GlJu5ivBDnegU
         qlFQ==
X-Gm-Message-State: AOJu0Yzsy4ydhCPILaMCRnc93Giq7KTP2Brqs4EmkfE/9lWbs79/wWze
	jcTIETk6YG/X7q/QJAkSg7cE4mOpvNfCHgaEMb7JanaAMgr4ZY2gD0cv8VCdzQiy7hI=
X-Gm-Gg: ASbGncu1edkOSRHmnT0hI89gXhPLNP+UryeZdW2YH5eodgSNJs+totzlexdSoo5ZXoE
	jYk9xy99ToyodlB5ssRELoyGq0PvymmOBGodUbBIVnHciv0LtX3Y0VrkO6RKCTBArTeA85qRqXh
	lU9n4lLNGAkmewaxukLXO9wwSnuhv1ngHEA0GIXDiloqzQwPI0ipoYpMp5L9TNRgFEm7bWShUs4
	2yiJdyY780jlFAP/UNuylPMT/BzJcJRApaj2rot9KfBqj9+L2shXeHhHiuV8DWnK66MECDXtGsw
	M28gkmpRyQbdpHOQ93iIBNOnsRij9cZeYg4kTvRDJ3zG0LSoZoeL7Vvzwb76maAVVQawO/0d7zy
	OCFspsi2FLFoMEaiHLDbTz0FjgylTP5EyHs8Wb62+Q4SETKutmjOv/mk/GsCeI7fVlfj2YLfEnA
	==
X-Google-Smtp-Source: AGHT+IG7Z6zeZBn211/I7M3dkItmnVEODQxBESmS2cvBBAYllidB3CYd7C+MjrADI4Pv1At5iFWIXQ==
X-Received: by 2002:a05:6000:2f86:b0:3b8:d95b:77a6 with SMTP id ffacd0b85a97d-3b910f8f95cmr312211f8f.0.1754944422521;
        Mon, 11 Aug 2025 13:33:42 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm364995685e9.22.2025.08.11.13.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:33:42 -0700 (PDT)
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
Subject: [PATCH v2] net: tun: replace strcpy with strscpy for ifr_name
Date: Mon, 11 Aug 2025 22:33:29 +0200
Message-Id: <20250811203329.854847-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6899fde3dbfd6_532b129461@willemb.c.googlers.com.notmuch>
References: <6899fde3dbfd6_532b129461@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the strcpy() calls that copy the device name into ifr->ifr_name
with strscpy() to avoid potential overflows and guarantee NULL termination.

Destination is ifr->ifr_name (size IFNAMSIZ).

Tested in QEMU (BusyBox rootfs):
 - Created TUN devices via TUNSETIFF helper
 - Set addresses and brought links up
 - Verified long interface names are safely truncated (IFNAMSIZ-1)

v2:
- Dropped third argument from strscpy(), inferred from field size.

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 drivers/net/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f8c5e2fd04df..ad33b16224e2 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2800,13 +2800,13 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 	if (netif_running(tun->dev))
 		netif_tx_wake_all_queues(tun->dev);
 
-	strcpy(ifr->ifr_name, tun->dev->name);
+	strscpy(ifr->ifr_name, tun->dev->name);
 	return 0;
 }
 
 static void tun_get_iff(struct tun_struct *tun, struct ifreq *ifr)
 {
-	strcpy(ifr->ifr_name, tun->dev->name);
+	strscpy(ifr->ifr_name, tun->dev->name);
 
 	ifr->ifr_flags = tun_flags(tun);
 
-- 
2.34.1


