Return-Path: <netdev+bounces-69655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E754A84C114
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 00:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39F52879DE
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 23:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516DC1CAA5;
	Tue,  6 Feb 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU0NF/EB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891DB1CD28
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707263715; cv=none; b=d2eiI34eFrs5v6LYQw4JTuAq32KKP498QokKWTefBKDl2cZ3QocyO6pimYKIT9aX7RPo2nRbO+d9ADYOuQPCIHWHWa44pf/cEjNUHbUROzKfrWSgjl1hhPtJu1FIm9y4rqWta52jH2ZgYCcf/YWlKkcMotS8tVmGA6ozLBLuhas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707263715; c=relaxed/simple;
	bh=s3GlX6Pltr5LZtjxp3xO7P71IiKX2IFX2eclHzX58b0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJEx6c6dFTqQAmVR1ZeRxsidBYLezSL/zTFqjNPP3mRMbHzRXcNkxXFvcrNKyX5vmhqw5cEFcNESwfGajSyOcciQRwPFxyEoLCTO3RuHppw/eeUcYWXFTgfIu1Su94tSUd6MgzTgxPnA+oGr/IfEYvpu/pV7O6MiQK/RfzS6XNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU0NF/EB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf4a22e10dso649041fa.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707263711; x=1707868511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQote9VNstFdBjKFmb5K3c0s7UKBANHfWJCH8fKkkio=;
        b=UU0NF/EBkgTCHb/SzUJfKLLIhmZTSwA/cKGljfqJcfapNzxgx0WZVA+z22K4mWzHD7
         fXOBCMYc1fCWSaE62nxU/MMSus5LsmXvaJPS5QXUvqgewnV2KDwUX6epqg62ihfjGLeT
         mq603aZiUq6zq+uaKtlAxnJ3Ft+kBDrTWExR8xJ8fHZyewUz1gETQigPeQmshGFvj82W
         WX814cxiAPMoOr9Ttz8a3NWV1hNpE1aubh+XWGuX9/ZtgUIb7solXX/d3LVDBiksNRyR
         +eHtQjxzEmwKTmf8894NZLmkPf6WSPuHjLqWsg7d+m3XwEn9RhGcXHFNEvgWNVw8RJyY
         umZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707263711; x=1707868511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQote9VNstFdBjKFmb5K3c0s7UKBANHfWJCH8fKkkio=;
        b=mKLuPLbSULM5XJmzGNQZYF0cSv2bClFxOjclZaaQEfClLmspT926a8vibxsUUUMjHu
         oekc5jqxZRXuCGZMWF61mfkDMK+Skkxey2azfRO8gkQp098c2HOAvIa11Ib/NGr8Ebzy
         HseFXy8DI0qiKOA04GwBia2eNlXVrXp0LcOt6Q8L6+Hu/dKcXyqwFsEGwIRzmK41dLL+
         s99ARIOJrbdAGaG0K3g6eDM+kphhs2UE8GSwUMTG7vS15zaBaI+Wgpa8+AcxaewIoTPp
         tOQXOE6vreYYDt2Fo0FkG+8PIGjzNMLHXBWruBOAaaETuJhqIabbAbdLLc0tWCuQpA3K
         NHag==
X-Gm-Message-State: AOJu0YzHEGwqVaZoE6aETqWYcqbZExaeJ3b74iYu/QjUx78pxMLWO0KP
	d9d3Xi1pFkf0G6uuQ+H+fGCQhM1McESP/YnNUPdBlEknZpJV0SnC
X-Google-Smtp-Source: AGHT+IHBIWolJUN6JKEHHz+nIVz7k9PN2gXv2/OPKX0xI4ujlA0QciUn1le7ecnrDMMq3napqkohAQ==
X-Received: by 2002:a2e:a9a7:0:b0:2d0:85eb:935f with SMTP id x39-20020a2ea9a7000000b002d085eb935fmr3620244ljq.49.1707263711444;
        Tue, 06 Feb 2024 15:55:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6Ggoc5GTBjVyLzXyyAo2cmbGDTpAC6cA6Lk0O9POBRVJELcrXqlezBARZnn4n3PxkFD/syFhyyf5QV8tsJZjwVfM7NoWV
Received: from mishin.sarov.local (89-109-50-200.dynamic.mts-nn.ru. [89.109.50.200])
        by smtp.gmail.com with ESMTPSA id v19-20020a2ea613000000b002cf1cf44a00sm7377ljp.52.2024.02.06.15.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:55:11 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] ctrl: Fix fd leak in ctrl_listen()
Date: Wed,  7 Feb 2024 02:54:16 +0300
Message-Id: <20240206235416.18086-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 genl/ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/genl/ctrl.c b/genl/ctrl.c
index aff922a4..783c3591 100644
--- a/genl/ctrl.c
+++ b/genl/ctrl.c
@@ -333,8 +333,10 @@ static int ctrl_listen(int argc, char **argv)
 		return -1;
 	}
 
-	if (rtnl_listen(&rth, print_ctrl, (void *) stdout) < 0)
+	if (rtnl_listen(&rth, print_ctrl, (void *) stdout) < 0) {
+		rtnl_close(&rth);
 		return -1;
+	}
 
 	return 0;
 }
-- 
2.30.2


