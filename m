Return-Path: <netdev+bounces-166219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFCBA350B2
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D243C16504C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3AE269806;
	Thu, 13 Feb 2025 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnTapvyH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4D245AF6
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483372; cv=none; b=mu/iKF/RzlE2FHVXA/waovPiEGIZNBuOKJwzB9pGI/VmPqnXSSp+It6sYwPOj5w8k7zy6lMlUJo0JtBXyrSVS3xChOaYBceSOC/xRQ0gQAZUGePf+O1DybCbTCc0YD8Ubrlprn1ZSwLc2HZ7Dio3abhlJZxTJyhsP3FvELxrsL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483372; c=relaxed/simple;
	bh=Zk4QDkA44tWiNc4z/YOWAiAEwT4xFqJn2oisOWTt8Q8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IYvLwdlQrCRnrkShOjzcDvOxZSqTIumcg7skDho3XW+UdPzYhG01SwgmpYq9zqpMt+ygKfljJv+asRJWB1EvUDOkne2XvIhVav0iq+zb6Nk0y1/DTr3jiwuIGxNf/NhHzfohu8oQdadg3btKROkxbtSjJhEm9hIcwPGJKLhIdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnTapvyH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de5a853090so3019441a12.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739483369; x=1740088169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0piG3yjRjEusyNC4nYKHzEr7L31oYL8tLO8Yfned4Ho=;
        b=nnTapvyH6AkoArWl6GRgkvT0YEFqMLDzDY5D2iW+FpIOPZL+neMizLwzGznlZ0O/4r
         3I6+2v/uld5+ZzFSVsg7dYhweJULWgtOfI6/KneIfBgrfyCZonu0FggRUAF1UHhXKZBC
         RRnJ1UkMekZj2kZRLyDS+UwDL5cMX34M1gzLK+FRnPkm0HUBSyW9jyKgcj2pkhQq3F92
         PDMviVNCLoBK4m7mIzHGtHLofwmEoimkV3OGVI8OlKop9y2Z1qAM7P63h5dCy+jz5lGE
         e5WWRK6Q3uwLrv8COk22I2phWCf8zaNtCPzjbqMVwsV/6uEZamCPEaIEISyzTN9DrYQM
         Bchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739483369; x=1740088169;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0piG3yjRjEusyNC4nYKHzEr7L31oYL8tLO8Yfned4Ho=;
        b=QwykkyroxS1RHCoeLe+AeL9z90+W8rqDjlLMpwox7unPfE2TRQD4QwWc9U6KwW1RTU
         fSd+LiYkYqR/CJY05coEGsRfxI4Ib7acd3VY/9cQJjoAce4P2RhcXxUG2VzAlPb21RWI
         W79oFciWGZvojILcEXCjR8mEkD3S/4jxD2AqJgbftkEU8Ipaew+/syQlB4O+p6ITFZdz
         HIa7Q31FhB9GNJY3JUuKx0kh70VItqqSBYzgLcRc9oLSi3Humgx452yL3ez953EljFKb
         BCCyej3HZcOAkqSpLruWGaAFigLmce6ec3kq3101XO4HKtXOSc8hNZKbEkIQl219PuHx
         wV/g==
X-Gm-Message-State: AOJu0Yw55fjP+3VEfpR9syxcL9PnKignAGNPKer6CUzznXYPY0sHj/5m
	sSBUYMMiuWl4npxILL6cD3avJyBaUQ4kbx5uzJcCzAbpxEHGbiZ+
X-Gm-Gg: ASbGnct4s9OCfExsqaVuxyIumpBupndVtZncvG0tNUXj5Dbp7qo61PJmJsgoRfTwWjQ
	1LfDgez3MeIyXz1YUsFTg2+xYRZJZEG/2K0hRjoXsAxjss5RCAmfUc8oflRDw4BYrhLdk+yWrZJ
	jNRBMFuNWRpaO53eqn+6GZFDpmdjZ9LAhnwWBnFfZdfqASAmYTs5Kcm3DtyOB+aFcunmKL68Fak
	fAMrVPc4rIiy0W3hz5ytkkXmLVAMorywahYvNOhCCKxYRtrF2E4wXA9fvTEi0qZDa0eRkj5KFTd
	3IL8razi1huirNLlkX6XrOub85rdRfRYVPxRhUMUuqAo3QSJWb/XA6Te8ojjf/FkvdrsaRcOXT7
	+b2tiXO3kOutH7LCGxXGE8lKbTDkJfmAZGqHML+TlD9Bquc9P+Td39I9Z7c6dspnEAVeThzRjkd
	AdHGy3
X-Google-Smtp-Source: AGHT+IHqHV9JLFLPGkLf9AelCYI7plNgMaDf0eeurp33KCxJZxh3K6/lzJBbSsQxihtO2ifXLpxW2A==
X-Received: by 2002:a05:6402:27d3:b0:5dc:9002:3164 with SMTP id 4fb4d7f45d1cf-5deadd7b9e2mr9151301a12.5.1739483368934;
        Thu, 13 Feb 2025 13:49:28 -0800 (PST)
Received: from ?IPV6:2a02:3100:9dea:b00:8140:d035:b1a4:911d? (dynamic-2a02-3100-9dea-0b00-8140-d035-b1a4-911d.310.pool.telefonica.de. [2a02:3100:9dea:b00:8140:d035:b1a4:911d])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c43b6sm1823890a12.26.2025.02.13.13.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 13:49:27 -0800 (PST)
Message-ID: <16986d3d-7baf-4b02-a641-e2916d491264@gmail.com>
Date: Thu, 13 Feb 2025 22:50:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/4] net: phy: stop exporting phy_queue_state_machine
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

phy_queue_state_machine() isn't used outside phy.c,
so stop exporting it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy.c | 4 ++--
 include/linux/phy.h   | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d0c1718e2..8738ffb4c 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -520,12 +520,12 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
  * @phydev: the phy_device struct
  * @jiffies: Run the state machine after these jiffies
  */
-void phy_queue_state_machine(struct phy_device *phydev, unsigned long jiffies)
+static void phy_queue_state_machine(struct phy_device *phydev,
+				    unsigned long jiffies)
 {
 	mod_delayed_work(system_power_efficient_wq, &phydev->state_queue,
 			 jiffies);
 }
-EXPORT_SYMBOL(phy_queue_state_machine);
 
 /**
  * phy_trigger_machine - Trigger the state machine to run now
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 33e2c2c93..bb7454364 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2061,7 +2061,6 @@ int phy_drivers_register(struct phy_driver *new_driver, int n,
 			 struct module *owner);
 void phy_error(struct phy_device *phydev);
 void phy_state_machine(struct work_struct *work);
-void phy_queue_state_machine(struct phy_device *phydev, unsigned long jiffies);
 void phy_trigger_machine(struct phy_device *phydev);
 void phy_mac_interrupt(struct phy_device *phydev);
 void phy_start_machine(struct phy_device *phydev);
-- 
2.48.1



