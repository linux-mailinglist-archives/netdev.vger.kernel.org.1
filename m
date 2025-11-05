Return-Path: <netdev+bounces-236062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4526C38259
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA1B84E498F
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E774F2EFDA2;
	Wed,  5 Nov 2025 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7wSHmT3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403CF2EF65F
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380555; cv=none; b=EaKV/P7aHik0eZW/BaTAgNqGYLg546Od5YZc+VVv1gUaZ4fBZKCg0OPzm8h/xw4T9qRf18RMV6n0hkFQNwN2kWD6iuX0sJE0p4EFthfsVkpGFDzfsFuTS+v7kgPjnWezBrhjds1KjV7XmzmAK6x0lv3iWjSq0sHs9pBU9AwbGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380555; c=relaxed/simple;
	bh=GMAKjpv9SsmOWyvi5TWfRg+PSBiyI2Fy+vJlR7iMmhc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EXEb95cD9+gzJ0OFkqQGsqtn4tIxzJ+Gf4AnKC5G578jygzCnduN+L4vcYlQpGgIF5mArTgOUWVh/vBxV2WYpTK/xFTYqhDJocvbUZyo7oYJpZP+rdl04TfVYA1z8WZeJ1FBeSFoVKXeuAYPCt2Moii4dZYuwK015tMtUzkolxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7wSHmT3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso1490115e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 14:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762380552; x=1762985352; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYIv6xvZ38V7IZs7PIytdPm+7oS7w1p/Is01VA94ghE=;
        b=T7wSHmT3ACMJ1Dw8OYeX4L0++F3tnS1/vwtEA5DH/+cM7p+xdSWTj6SzRUgpFL5Q0r
         NJ9adRR0rmrghb+Vh+FkZ5j9RgwvHKyQtqJ2Pt5i3E9C6bvlraLCABhp1LjqfaVfuq+I
         UnTDLJlY67/xxAuSbBLjSTBWOXF8xTGb4yIjGR9pu8lTj+W0vJNHYSX7YJo390BL7VyI
         ClXGEoLRcVBEwCO24YqZ5e6Sc4sKH6QhKGY8t+PSC1J//xF8i9OufJZJhGIBujYUUD3h
         FDhiGdigjcohez3R0wx9j3r0gNoWribgOs6RgYOGGJhczQFsCTeA7tLNYMZ5EcuPVvLD
         7USg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762380552; x=1762985352;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UYIv6xvZ38V7IZs7PIytdPm+7oS7w1p/Is01VA94ghE=;
        b=Qpgm9zTxeaV6bt0nHzxKrqBMbR//qOs+gK7kGyayc1YJifDu74RA0RaRvPm/ObMvmY
         qOYpPI66+b9lyzkrTD7D2GfzvAGzCJ8qRxjjjmzxsduxQPMkZbRzP216JUoRKHly8Yqp
         C3qOtnuCGrNxwKnulHerTwtprUMEiRJ7kYQLgGJE/JYjnMbkIo6fQbXli5R7+t8SrYdw
         +e1m/TAzp8FUdEP/ah2+rbwygH6cCoTslLbLdtqBrps98Sz4MFPOm4q9rh8KSxoibGcY
         HD6CMVXpvms7JprEg+xIclenAQOMRns4OIPt0cff+kezogBKcflz32cuE+JG4K1tu/uz
         HuwQ==
X-Gm-Message-State: AOJu0YyZ8PCwylUmhz9SMWB9pGx2506/86DKg/NEnKIfAtCt4y07nLEt
	bctJ5Or4XJI/J7YXjECzzt20Lx8D8v2bZLtkOJfmgs0fI7vZK16rciJ5
X-Gm-Gg: ASbGnct/DvDl0FXv3FnonuFFN3UDfUkPBwwjSZ1pfPWAZGqbNdj1wAy0tQoLiqGr9qj
	v5DqBmmyW50qsM77sY73VDyjGJfVVA2KhL0HTCvTAbiVh6O8JVlioa8enrFKVjeoNBpDmHiE3WS
	PhZvlnlKcTe6+8cgULp8Kybaa1nzy0h0TSJD+Ws5jzqH7FY39EFQuRHUVFv/pdGKPGQNribyk6o
	grnGjcedYomzxFXXNlSuaYbRZ9GDVp8FJrhNsoTCVw0qEx2SleuC5NuvNMrpb13YWt4qTkMAA1v
	JmU/Yh+8k8ZPtSjdD0ss+1WtEhtpK9JHbhegikU2t9RwiLgKhLnWOxigQBjaBTpDP+T+3vURZ1E
	vC1LOAQ1+U1KgWgsWZ8zSqxyidaoJBsvC6NUG56s3n7lwdPKz+HAVmd7gcQQMBW8pV66MkpKsGX
	mX6HyHMzQa9gfSeFHbHJcanYZDfCadtjBbhhdszDqbizs04Snc3EEt2lQODIZd389k+CrltBgk7
	H0tggMUuy7oAMPLQR9UULMgybYqi+kY0JRiQWRvAMY=
X-Google-Smtp-Source: AGHT+IFrPZxupGGkdlg2zDQX1wHbev3OvJIxzDYzXudA9jVNFuIG/96EMvbmaaXRY1j4o3/3k7j2Tg==
X-Received: by 2002:a05:600c:828a:b0:477:e66:4077 with SMTP id 5b1f17b1804b1-4775ce2bceamr42272805e9.29.1762380552284;
        Wed, 05 Nov 2025 14:09:12 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2e:e200:8d41:e974:a931:222d? (p200300ea8f2ee2008d41e974a931222d.dip0.t-ipconnect.de. [2003:ea:8f2e:e200:8d41:e974:a931:222d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625eabf3sm11892905e9.16.2025.11.05.14.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 14:09:11 -0800 (PST)
Message-ID: <9eca3d7e-fa64-4724-8fdc-f2c1a8f2ae8f@gmail.com>
Date: Wed, 5 Nov 2025 23:09:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: fixed_phy: shrink size of struct
 fixed_phy_status
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All three members are effectively of type bool, so make this explicit
and shrink size of struct fixed_phy_status.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 2 +-
 include/linux/phy_fixed.h   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index d498d8a9b..9bd693741 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -224,7 +224,7 @@ EXPORT_SYMBOL_GPL(fixed_phy_register);
 struct phy_device *fixed_phy_register_100fd(void)
 {
 	static const struct fixed_phy_status status = {
-		.link	= 1,
+		.link	= true,
 		.speed	= SPEED_100,
 		.duplex	= DUPLEX_FULL,
 	};
diff --git a/include/linux/phy_fixed.h b/include/linux/phy_fixed.h
index 8bade9998..436bff20f 100644
--- a/include/linux/phy_fixed.h
+++ b/include/linux/phy_fixed.h
@@ -5,11 +5,11 @@
 #include <linux/types.h>
 
 struct fixed_phy_status {
-	int link;
 	int speed;
 	int duplex;
-	int pause;
-	int asym_pause;
+	bool link:1;
+	bool pause:1;
+	bool asym_pause:1;
 };
 
 struct device_node;
-- 
2.51.2


