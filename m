Return-Path: <netdev+bounces-163161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E507AA29715
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34711678B2
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335991FCD17;
	Wed,  5 Feb 2025 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG4438XU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBC11FCCE8;
	Wed,  5 Feb 2025 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775822; cv=none; b=Z/BbisnM49eLRuSWv3V6eHjIBeMPg9sMExkql7D98j6wnddKv12n+KfoHtrb47f9NtPorm6BPHT3WLuGXW+F6jMSRlXLE61hS5wP55HWp8KoJrmEKujA/2xAEnlNvAbVNir3yc6OjxkOz3WDSuhQWPd11w6LCVh94M1UzICipbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775822; c=relaxed/simple;
	bh=IzxyEV79VrL9mBuqHA9yuBSdtotE3UlQUjx/JUkXp5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el/xv/xfZh47JnWKwsLMv6ZgFPd38DzP/p8eU/Q6nxXFI+ommSsV3cpA9Y98DRV29KzfGLrR/UKOg0olIHdPFY6CTsrfwJMM452kGCAyeDYK4AFx091I7OJWTOs7etJIlRUB1UisrqOAG9jRxuj90iw51wPwXBRZM5spaC1SgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KG4438XU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436a03197b2so49342585e9.2;
        Wed, 05 Feb 2025 09:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738775819; x=1739380619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qot9QaEaW3HgdsmlMYISo3E3Xzuk4neY6J8SlgwZNoA=;
        b=KG4438XUzC7Zc8EaQ33eYJXZI+kUGz6V7AJZXXZ/4SGM7fCFczIoCvrovJ0mlJKs+W
         MnVuKAxrkkbDBb2qkvOXOrTGi+mlJWlVHc+ieNdNRx4gEfbHYBSPdYWgnsdNwLA1mWKk
         F06FEuHRqbfG7c8t5TKS5RDV7V0f8lk3jxdiZMe/sogvXQ1IHY1Hb9CpzcPGRJpvfHKV
         HPMhXwAm8xW3yBbXcoGSzi/wiNndvTRCTVCW5BXiD65ooVON9hgTd0jGN+9cxwjChRfs
         W5G9a9uChRVjhxxV6tjD5FAmYrH8btcwF45IJwGqE9R4fXk1Bb5ZaBKu9oouCbaJ3E+h
         khQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738775819; x=1739380619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qot9QaEaW3HgdsmlMYISo3E3Xzuk4neY6J8SlgwZNoA=;
        b=Ez85d9gOIDVQwyqPc7TdqxcgjwYyme0YO38+/NQ3Sv1iZ1ki3YKW0QYflaLl8K3tzw
         QNApJ8x2/rg3arBi876DalfZwnqMnwYxkoVM5NQ8bzVWiuiULz+hba5BFSGyjItMT8pm
         ML2wQUk/4fWrFr5wEqPqoznzGvscp9DAgbcTGObNK3hY3xBlG/B4cL+iJILx6NJEDx3z
         kom8USMn73X8VWhifweX9M6h8c1OJAbVkAxFBelmGG4VTErSWDWw/ufj/wTp97mw7uk0
         fg/oaJWzpP6WKCnm/F/r1JZgdTK5WTBUAjoStCjM1F7cwCfUAaZpWZVl+sXToHetzBxt
         trUA==
X-Forwarded-Encrypted: i=1; AJvYcCVbhNYTK2faeX0xlbgHj9AUrJbyeKTQJp0bXepP1CRyOEEtAKgoSgy0+PLtM3qh0TQKUvfQYDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6hoJSX+Uh1WUETO0Hr+KOAXiufIK9GemQANU/mUKBRKKL8/u
	3CmPUAHDCT03Sj1m3UNKAYU7v9VZlWZ8cSKw0xeM9jwtIvbFYukMWSkpETBK
X-Gm-Gg: ASbGncsrFSbR9FHtJ68mNqLbxZjfcewhf7rQY3QB8fKfe7uZfEcTknNHUnB9daAhTOU
	UEH58dzxsoPGqk2nKQkZV+nSr1it/gP0BJMLq4zmQ2pi2AvIVqUJ8VHl3FY8gjeuTILh0iaL772
	EdmbBRl3YkHLwtfU5Mr11GVXLI7qXAroPG8nMOEvxeelPHMtrMoJpRQw/sPqNmJ8GHUsvTwl6xI
	InD8DtiZ+7Vw5qE8Don+uG9hyqFaHCnR7Yic+uav3rrXMfERLLskw9rTxnpg6LlXb85EwX8rVJR
	sPUG+TVgwwbOXAK62whm4KDe7FYKwLSn8AWUGTLgRDZ0Ng==
X-Google-Smtp-Source: AGHT+IHjtfhrVh0kk9hMRiGZb4fFlrretLRpwxxbLY2NEhW6ZAPhERfqYUMJWHMpC544iK7lcSEMmg==
X-Received: by 2002:a05:6000:1868:b0:385:f7ef:a57f with SMTP id ffacd0b85a97d-38db48bd27amr3288152f8f.27.1738775818389;
        Wed, 05 Feb 2025 09:16:58 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf4480sm27185705e9.27.2025.02.05.09.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 09:16:57 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH 5/5] net: usb: cdc_mbim: fix Telit Cinterion FN990A name
Date: Wed,  5 Feb 2025 18:16:49 +0100
Message-ID: <20250205171649.618162-6-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205171649.618162-1-fabio.porcedda@gmail.com>
References: <20250205171649.618162-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct name for FN990 is FN990A so use it in order to avoid
confusion with FN990B.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/net/usb/cdc_mbim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index e13e4920ee9b..88921c13b629 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -660,7 +660,7 @@ static const struct usb_device_id mbim_devs[] = {
 	  .driver_info = (unsigned long)&cdc_mbim_info_avoid_altsetting_toggle,
 	},
 
-	/* Telit FN990 */
+	/* Telit FN990A */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x1bc7, 0x1071, USB_CLASS_COMM, USB_CDC_SUBCLASS_MBIM, USB_CDC_PROTO_NONE),
 	  .driver_info = (unsigned long)&cdc_mbim_info_avoid_altsetting_toggle,
 	},
-- 
2.48.1


