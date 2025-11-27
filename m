Return-Path: <netdev+bounces-242249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 009F7C8E164
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7A3B4E2A6E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9B432AACC;
	Thu, 27 Nov 2025 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXqUMZK6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF932D439
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764243927; cv=none; b=Ew+qn0NDGqjUhPUpzDgPXME/A/ejAAIZoM+poWQrUk+jo9SwnRNGnMn2XXevmvxJrChBitHfLEulVRjpSsHJCS8rtKlrdR9nXKT7LLrBD5woKFZTjfh5mT2sis0IUu0vD8ZnMMpn/5QlX7zVMs9i7Wfb/AGI0Qx9Bpqip8kXRi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764243927; c=relaxed/simple;
	bh=EESbljAtO5cjI3g7QgoQDkGLxm+8rg6sF3OJT4VotsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q9XJ7hMC4kVc8dk3Y5LH3F2IKfFh9cjHsafgwR8eLjkzGDtDB4MTShS37H8MsoSYo45bsDkRHI40A6VPvTmSNdhp6zPCxVLhot368eGoQGGd1IHMGg20lEFDjelNbTIourYNob8pVt/ReOa0Bt+eDXt+o5gdvKg9kyb6WU5fSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXqUMZK6; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee0ce50b95so16267901cf.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764243925; x=1764848725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CupIus3Z1Plv91M7XDypdClnnpjXSaDFLm3Gq7Wk2yI=;
        b=MXqUMZK62b71X5KdcBLTkoxGY91yKFRQG78Yx1F1s1Ehuhhy6yGsyia2n6yUzgkB7S
         pCTg6dXYGqEehZkBZhc/+cDaaPmZMv2fzn6YWecv2SYszs0SWxS1DnoZnni4NE+bIEUm
         DBa5akae0RQCjEC5+L+3b7dM2RGefpiF6+AArGW0TKRHwAG51GXjC72r/2wUX2+z8/39
         h1ikpRtr56oZuir/VZiWjrnP8u6WoPkkXKMYb3I+7fBBUj1rQHSHW2wK/b4BV4fd8aSg
         sIlWiAX2GoL4yl+sIPktC8fNQKca16k6BmBLRQXIUgL9kiMm7QdBJpRnbpj+JKPC7YX9
         /Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764243925; x=1764848725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CupIus3Z1Plv91M7XDypdClnnpjXSaDFLm3Gq7Wk2yI=;
        b=t+xgB7+JMzyqTBmdn1h6FP9leMNB16VnamfHSY9CKwt7S4N6kSG2CP37DXua7GTspv
         /N+klcf8ubjRzMhYvPAvG7c8l7p98YDDkwRaH4ySlzwCyFH68qLcYTny9zdUlzBWca0z
         9cFlOH0r0f1+UBL7qFr6kd8uEl37IkRqdItYxCEDh8ETJlH2OUchCXakqTopoIKANSch
         VtH/FvPix6E6I/4syIuU1Y6XLOS4Fnrak9bQnHtkA8V7Wm3SimxrE0zibwPqqfWZpGqC
         07tRShb9z4k0HSEEECpiX8eW6UPcLIshgeBMDt0gOE+KIlzEIMVLUyub7Qconmpq1HYt
         Ga7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiEv+VvwhOevYmjX/+ebo4Hkcrfxkoy7m7JKDGP2aNGrylynoFS+j8+gyivh58gTRoqSKu3aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzFV6nvWeY46xZhKvS4lz/GhWXjzEDqn4bGTzbAltdmomC9S8/
	AAPk6BzngQ4woZpz+bBg3okGR+YThCMAjZpPBx6gu75SWSGiINx2YyCvtJN/lQIQxz3BJg==
X-Gm-Gg: ASbGncu8o7GoCIRZcFthe2npTZvujtuzZ5S9MVZIhrL+whq7h26R4Bh0/qcEYFuaOfa
	UVb8WlEh2hksSQ0YQjnQNclOVi7Vj6jVjQ0dk6ZpEKsfc+6lgu6+t1/Le4P0FkRfUbGaxHk5xuR
	kmN8RV1YZXlDaaeDIX3QTa3Kl3rr0lGgS8f9b12KM/pmGSEEXBJeX4P+x2Wm6tg8UWCbIlRsLj3
	+cBnhhcwuuJE+tzC9TDoKthEjWYWfAjL9Hkl9UCVELyrv0f7gQ220LNbiwrCHWwwje/a5cuY+Hz
	h+hSIZBeOeG4MQpxfrsT4D6c3uSsuiBW8Tcf5o9EUoo+bFUaseVi4FG0h6nwatCdK5BUkOdS6Sw
	rXChSPLj66g2M8nlEBjh7zWe8F0+8ZsECifP1ppSRstOYTAh1CEyyEMkACzzZ6R8cIX/PcM9zaL
	L1BdIX0wGg4HihHxMYn0bR0TgD3w==
X-Google-Smtp-Source: AGHT+IGKTat1Bt9+eEak4ZBvg0TjiSyFEo+1/NXc7jCwBi8L0hY4SpER5y4Frh9k5UZnClrSJABK7A==
X-Received: by 2002:a05:622a:110:b0:4ed:2574:815c with SMTP id d75a77b69052e-4ee5884a7dfmr313050661cf.23.1764243924879;
        Thu, 27 Nov 2025 03:45:24 -0800 (PST)
Received: from fedora (d-zg2-197.globalnet.hr. [213.149.37.197])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-4efd344a4c7sm7312931cf.34.2025.11.27.03.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 03:45:23 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ansuelsmth@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net] net: phy: aquantia: check for NVMEM deferral
Date: Thu, 27 Nov 2025 12:44:35 +0100
Message-ID: <20251127114514.460924-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if NVMEM provider is probed later than Aquantia, loading the
firmware will fail with -EINVAL.

To fix this, simply check for -EPROBE_DEFER when NVMEM is attempted and
return it.

Fixes: e93984ebc1c8 ("net: phy: aquantia: add firmware load support")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/net/phy/aquantia/aquantia_firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index bbbcc9736b00..569256152689 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -369,7 +369,7 @@ int aqr_firmware_load(struct phy_device *phydev)
 		 * assume that, and load a new image.
 		 */
 		ret = aqr_firmware_load_nvmem(phydev);
-		if (!ret)
+		if (ret == -EPROBE_DEFER || !ret)
 			return ret;
 
 		ret = aqr_firmware_load_fs(phydev);
-- 
2.52.0


