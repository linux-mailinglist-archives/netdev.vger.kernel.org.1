Return-Path: <netdev+bounces-141671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF639BBF2E
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9762820E3
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268B11F8189;
	Mon,  4 Nov 2024 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5MRBVmb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6471F80C6;
	Mon,  4 Nov 2024 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754099; cv=none; b=ZDTrXGKcwvXCSclqh3ubyQPlzFm916dJQ1XsdJMzQyXNoUMQHj+heIETXoV0m4evgXPJNvSdf0j3MrqRwEKKVENvjH2AAf75tRm8hl3UReSMYUz6YjkGS+ypK2U5AM4b1Ch4TbH3BPyjEYi3CToqZPlX7A6DEVojn4kCDIZlwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754099; c=relaxed/simple;
	bh=OxRINzWdRircfPeLvtQUkVRBFmCoiRjSQgjI31+NbKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkWWNI2HTxMCuxgJg5zhOpbRuWV+QOFAF0pt460ATXCsXChnNROpnAtbFFEXeuIkOlSFVhtcxiG33KPznWhV1eYiiWF8Ke4OMf+Aj6H+CMuJ5xlxNchWOTD2Pxd8of4BTKLL3MnihjUo3SACVJMHKPA6sR6CtEpn9dbP4ROoxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5MRBVmb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720be2b27acso3839516b3a.0;
        Mon, 04 Nov 2024 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730754097; x=1731358897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB0r+fmFtPPP2FUicFB9grwBKEnYit58WrhtOqLd8qs=;
        b=G5MRBVmb/+EfQsC1LTnUi7WkeJnrhWYEu/cZ0XYDPtNaff1EVGSzvmbo01RK3SsGlb
         TXKHlOO+hXB69WgXPGH63yVj7jIucMounmDDZHi4blfYw1+hHYV1T3MmclguTbql1zKV
         CxLh1omn8PEIWzXAYi011L0YXQWwC/Gme2aUWl1uCUyWIqzzBNpDLLQDipqKpCV3p3Js
         HVAdUE76ZzzwZ+jYtoDdwr1JFLehWLKV2xDW8A0v4qmY2gbl/ypaCPWr7lenYwF88uHY
         OZvQ4n6OZxEXfZNEw2oYvxMTsLSYdufxBGgTWEqYBLCUh9PGJWa5UU4oLpxJ6zYWdseJ
         wd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754097; x=1731358897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HB0r+fmFtPPP2FUicFB9grwBKEnYit58WrhtOqLd8qs=;
        b=tSIE8ST0paJmX3g9iBawyMlG4nCwOGyZUYzssgq2i0OkPvVECr9gNRUYl6Js+H9g34
         PY3WWynWeM19vFjh17QNoIYgN9F3QTxr49vbTU6hjVH9RKbiss97YAZGbv8xuEB9dfoV
         LVl9MAD/wed0UrUgYXuKUVpo8SSImgwsEiIy4xlCYHYsCdfZQLc+TexmYlkZYp1NflI6
         jqHB6UcwHjiOvg322SFexRlMAvYzRubpeMG4zHq1aZQOiDeEUBBAGuqmDOGrGQE2Jnnn
         cZrBzupVFaj7oojBsMgBRN9vjsouMOUIe9zqSm5XoFyBl5uSF91ppV5dxcwyAXr//dAC
         ksiw==
X-Forwarded-Encrypted: i=1; AJvYcCUT3Rn8Uoxubg+/XI9ZX/bviAQk1lSEdY/dT+GI5FzQfbn56uOfdZJe4GCt8YCC5L/4lS2lDh29egMQDkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgwB8nMLzEJTR2SpiEBTsnM5vQgrtY4TlC8c0j5eIvgLc9XlPK
	35PLKgN+cbjqJ22fho0s0JYk8g0ZdTeTx508knxhI2uCm8ASNM7aFNxM0VQz
X-Google-Smtp-Source: AGHT+IGwMD0UoRgk5kv/dUnGGU4iyNpQ/ODgMyjPi1OiOmbCLzk45IZoztu6i5o/DRbm+JHdKLu80w==
X-Received: by 2002:a05:6a20:d525:b0:1d9:1bde:bf8 with SMTP id adf61e73a8af0-1db91d87351mr22961733637.14.1730754096456;
        Mon, 04 Nov 2024 13:01:36 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8971sm8307755b3a.12.2024.11.04.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:01:35 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	maxime.chevallier@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 4/4] net: ucc_geth: fix usage with NVMEM MAC address
Date: Mon,  4 Nov 2024 13:01:27 -0800
Message-ID: <20241104210127.307420-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104210127.307420-1-rosenp@gmail.com>
References: <20241104210127.307420-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nvmem is not ready, of_get_ethdev_address returns -EPROBE_DEFER. In
such a case, return -EPROBE_DEFER to avoid not having a proper MAC
address.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 88a9e7db687c..30453a20e467 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3735,7 +3735,9 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 		goto err_deregister_fixed_link;
 	}
 
-	of_get_ethdev_address(np, dev);
+	err = of_get_ethdev_address(np, dev);
+	if (err == -EPROBE_DEFER)
+		goto err_deregister_fixed_link;
 
 	ugeth->ug_info = ug_info;
 	ugeth->dev = device;
-- 
2.47.0


