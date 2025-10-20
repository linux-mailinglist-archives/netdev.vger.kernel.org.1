Return-Path: <netdev+bounces-231006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65170BF3B84
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 23:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E18B54FE6FF
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 21:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C146D334C33;
	Mon, 20 Oct 2025 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liUGcVyg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBD334C1C
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995429; cv=none; b=uuIxUHt4UPmBqh6ihFQeDcwxx+iqiJdMSgtdaRgPLOd7mVmWnDDXvV2wXxddS74N/L5gKiiFuea9NZq1ALE9CNu89McU1vrtUOHuFks/oC6Q5bJnxFMCuUgG7qFf0QTkVhYmxwdEPQwxA5fJ/bPagu7/Q54UVGbS4u6wPfmNVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995429; c=relaxed/simple;
	bh=ibhPvtx39doJjXzqMVBHPIxV8whgIxw3fdx9JJ7FKfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nTNIRpLVTPcdaGd6YkKztA5theZtxNz5Ktp4ccymR6Hcx6rW2yJxefMSP5LY5Mv/dSmnpUX7gpEXKapBKVJCZsOD+NDbjcKGJRliTvbs2L02/5ZWXxjOJNz7npPxeQ5UiYjrCLEcU6OBjx4aeUE7wxt4FthCm4+qBslZQvksQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liUGcVyg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4270900c887so503912f8f.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760995426; x=1761600226; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wc9icIF6ANq7bIYtjR0bXRUcBUAsbuuGXfXqpMDQNE=;
        b=liUGcVygdye/ajx7eBmNlJqxsDUvPOQBCesrNkiw15KnpbZwfScNtWqYR15mOeSQ8w
         9Zk5aWnFIsNI7fuilYhfAFfTGGEv70dSvcJyRTBfh3xca9NE32AAEkrppDUvJ4kzLof0
         F+Ts8Py8a+Gcnx3rxQGLIDomUX2dGlcWs/f+QPfjH1cmOmVyAus2ORI8Y7id2U4lpdee
         GVvhx4pUbK84jc8WAQPJW9y8dVY1kX1zxYkhY79J6HcojeASl78GcYjSX3Igv5M0F8he
         xNHSOr7gZW05ATnr9a21SR0BWGgSSkhs7V2zmYBVaIcOHl1oSQEOrkhfUNSLg/HjYgg5
         SX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995426; x=1761600226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wc9icIF6ANq7bIYtjR0bXRUcBUAsbuuGXfXqpMDQNE=;
        b=Co7Kff2zKpHu1RmJR0GBKJ96CQzMGAoHLE0yKhb60/NIJK4IsPLGbvO/ldGxYS5vZ7
         iGHDuWI3TB/YPq71o8r0rPY8IJ2IdJ28gwXfL6shpus2Fy6aTL1apr509js95NCxk2LZ
         0e6qG+uUPE1/rmrfBlNLWt2+6/7mEpn3fO+JbIEJsSV9r/E/Mn1aQNEeLbnBoEWvD4VK
         q8yz+i4YmCRlPEWBXAwIpcQ1UcopjVzkvgSpHgVqG+i3bcdPYty2knYaDjHo9YJ4tsvj
         k/pX3Jzs4/kBTMFT0dk8fBCulwaoH9cX7YOo5IrnbBOO8fm21gr7nTDvPHKdZCojvdar
         JJkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnxsGcIRNUefXf537dej7RgMiPIQwcukSRP4b3GU/+nWLbFqpNoAuppTB9pcneOmS20SNpDjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQuzrxsxIRn3QxlraV08fcQ3hgXKyNYjNbY9x8Z2CpHluCIyEe
	EbdeW937Yqdsv3MlR0pDkhvEGKAyBYGWlJoMQE4ZbjgtYntgtrlluD7G
X-Gm-Gg: ASbGncv1JED41aNK6pBSSb5OtQOOcUheySTvVxnblsA+lvhpXMHpbnR8EvMyX5p5P5f
	whZbkjXO00DWpwcWje6aYXPHP9FR52RSIYvInSrT57sG3kGYklZYf0Bg3DhezF6vFcIQh0K2IIv
	B7gDvbX86W42FZ7Pe6edVcmJ+Ntlb9geXJTEVnD+hkVKUV+/LEHP1ImNeeXdQm0pkQIxJKbIfhv
	41o6DIXaihR1x1WzFXeeNC1UysLwrEusuReTUw3CfddivZX6rjT6b14zVQLFqnBJTONkqFUxjKs
	0ExwYzCZrssABzVOATZ02iEtjVRseh26WeEYp0bpHVs1wWAt4M0QRaaDwoi98zs6uGqo94UFeE3
	M/ymvhi2DE/0S4FuJt6kbGewr/dnjRSbC76KfoIzIFwn4JV3sOcTtBh8aV5RGLuoT0+OMHbxjV3
	0QIl8O
X-Google-Smtp-Source: AGHT+IFKeEzNOuZE8Rb5SdMiZ8cxxtJjmrvr71zG4Tr9HOdYTow9+lCka3okRv5TO5BvJQ/+TEWOJw==
X-Received: by 2002:a05:600c:1d25:b0:471:152a:e574 with SMTP id 5b1f17b1804b1-474942c4fa0mr5690495e9.2.1760995426167;
        Mon, 20 Oct 2025 14:23:46 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4a::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d916sm157517505e9.4.2025.10.20.14.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:23:45 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 20 Oct 2025 14:22:35 -0700
Subject: [PATCH net 2/2] netconsole: Fix race condition in between reader
 and writer of userdata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-netconsole-fix-race-v1-2-b775be30ee8a@gmail.com>
References: <20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com>
In-Reply-To: <20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Matthew Wood <thepacketgeek@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

The update_userdata() function constructs the complete userdata string
in nt->extradata_complete and updates nt->userdata_length. This data
is then read by write_msg() and write_ext_msg() when sending netconsole
messages. However, update_userdata() was not holding target_list_lock
during this process, allowing concurrent message transmission to read
partially updated userdata.

This race condition could result in netconsole messages containing
incomplete or inconsistent userdata - for example, reading the old
userdata_length with new extradata_complete content, or vice versa,
leading to truncated or corrupted output.

Fix this by acquiring target_list_lock with spin_lock_irqsave() before
updating extradata_complete and userdata_length, and releasing it after
both fields are fully updated. This ensures that readers see a
consistent view of the userdata, preventing corruption during concurrent
access.

The fix aligns with the existing locking pattern used throughout the
netconsole code, where target_list_lock protects access to target
fields including buf[] and msgcounter that are accessed during message
transmission.

Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 194570443493b..1f9cf6b12dfc5 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -888,6 +888,9 @@ static void update_userdata(struct netconsole_target *nt)
 {
 	int complete_idx = 0, child_count = 0;
 	struct list_head *entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&target_list_lock, flags);
 
 	/* Clear the current string in case the last userdatum was deleted */
 	nt->userdata_length = 0;
@@ -918,6 +921,8 @@ static void update_userdata(struct netconsole_target *nt)
 	}
 	nt->userdata_length = strnlen(nt->extradata_complete,
 				      sizeof(nt->extradata_complete));
+
+	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
 static ssize_t userdatum_value_store(struct config_item *item, const char *buf,

-- 
2.47.3


