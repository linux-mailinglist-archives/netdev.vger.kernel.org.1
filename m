Return-Path: <netdev+bounces-245007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05861CC4EFA
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 19:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F35CF302AE1D
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 18:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C7B326943;
	Tue, 16 Dec 2025 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="TAHKPXVm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1F33C533
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765910501; cv=none; b=Ee2E891RUqlAxzHHDTJkGRFOLD7h66NaAjtfXkMQLbjVh/tsZzflYLn4ghMz6KGWSjh2TFhhPpH8Nzb4BHs0P8m/eghhfVQSjp8/psOBUNFlTW0aJNhRUZAxFT373iRYZs71ZQQ3vOqcer1Q+zTRS+70V7wxND7ZiY7afSSqogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765910501; c=relaxed/simple;
	bh=V0yuNg0iV+B3gIISWOZEjmLZs+sFhcR3AfRXnuoFwWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtER8TZbd9Aq/moJsrftFzOGUoK0vDwR1UQOzregTjj+wyu5Z+IAAGMyzkop6/GOW5XK+4HgpA9eusaA+EQLVpaUhblV3JOEr9R3ehxrkI1Ok6EQxjtN6GqK1WwFTBLQybKyWBXbXuaf/mvtGpPQt40HOHY0ToPC/IXJjQgESbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=TAHKPXVm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b73545723ebso338336966b.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 10:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1765910498; x=1766515298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nss51I/Jwq0hJeDmfg399hmUyY3dbLkceJU5Wfbrx+o=;
        b=TAHKPXVmX/20bHRS1U61Zt+nRkNB3o0XBLZSY6o9WKXj8tjRDsWEsVK25GTKIibzje
         ZaOTpvQ41QgyI+Cu80zADgcALfqKkqW2bdLIx32IjClxGBMMxr1dv7rSLuYYViE2im4G
         KnqlfNZxo1DJnyylZCJpk+W5rJh2gxa75w5e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765910498; x=1766515298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nss51I/Jwq0hJeDmfg399hmUyY3dbLkceJU5Wfbrx+o=;
        b=oToeS4uJp0HknJjYThgyga1KI3hckS39y2jd5AswVs5MmlQbQM/z4BEKhV/CJTotgj
         xnPhFpDMfY8mauko+0UrHih7JXAxN7MaeEaC0rRXubajFD+fYTlBaSabnw4jqErQgU2Y
         j2e+lwuMx1i33vMz+fHfZAgc5M1L6W3yPCiW2TLbSIDm+/NnjMAmQ0KlOdf0Vd7pNuaZ
         i4OxhFof0dAArVemiZsgyNimmalwt0Egbfy9L7ELSH4rYo8T6pDyotaH6W5Y3w3t0yKs
         h+OuYkuvQuYcANjreVb8xSufyYU9LOyyFzeqSCyS++eG6uVVs0VzqApfEQHkVkMWT/PD
         kIcA==
X-Gm-Message-State: AOJu0Yw1aHS/hzAzQJaLzyCBQemD3RghUq/xcId45JRn+x03cYqDqaRc
	/3r6pZPQK4eamyVjfIcXYyqIi1smBALOZ5hKYkC33u0vldb3PN0mPODrfqYX2Kleq7A=
X-Gm-Gg: AY/fxX5ZA/vTaLjxr0NjmBAWsNasju6aVY1R60KI0JyLJlmkZ5fuM/qzSS+aYunFl+6
	oaRn0hvK5yBPSQT3kcps/duNtRGcczf4ndT9jLppVeh7UU+w/TEf/wveI6blInNT8YTgXluJgIg
	JI+xW0lSHiPO2dHj3XFy+Le/JRsRVOcUsL1e3fxd/xyh8R9qwnzfXpcHRF9FX6iFKrAj3lN0AIx
	jBH1KF9HT9pcjVfQi2+8NVMsrhfrUJBJIkMcbZS4XU614YYi4w8qUxmvwJvnJiV6qzAw75nTtRS
	4qXwtW7Zcx/e8oInpaNNBa+YEy4CXxBTCXexqRDqf/0xZ/rlnERgN0fkzkI7gaBw+MToH8VdSWN
	LnDALGyEdwcyTqvxOI5d7oJom9aFCIAvl0HTOdM23OziK4TAUv0WhYDwG6P5bKVlbaVjVKwHMZp
	oKpgjeo5cYsKP9vFv0QOEva9C8Mt47X6tNv0U1Fco=
X-Google-Smtp-Source: AGHT+IFrlQiy9aIQ+9DdbQkq4o0jdSo4LXZz5Sddp7jQq9o+qaF7ZY8ITl0iy06lK91XkcBPG9K4rQ==
X-Received: by 2002:a17:907:3e02:b0:b7c:e320:522c with SMTP id a640c23a62f3a-b7d23b1c40amr1761406966b.53.1765910497792;
        Tue, 16 Dec 2025 10:41:37 -0800 (PST)
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa56c152sm1709454366b.56.2025.12.16.10.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 10:41:37 -0800 (PST)
From: Petko Manolov <petko.manolov@konsulko.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	stable@vger.kernel.org,
	Petko Manolov <petko.manolov@konsulko.com>
Subject: [PATCH] net: usb: pegasus: fix memory leak on usb_submit_urb() failure
Date: Tue, 16 Dec 2025 20:41:12 +0200
Message-ID: <20251216184113.197439-1-petko.manolov@konsulko.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In update_eth_regs_async() neither the URB nor the request structure are being
freed if usb_submit_urb() fails.  The patch fixes this long lurking bug in the
error path.

Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>
---
 drivers/net/usb/pegasus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 81ca64debc5b..7a70207e7364 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -168,6 +168,8 @@ static int update_eth_regs_async(pegasus_t *pegasus)
 			netif_device_detach(pegasus->net);
 		netif_err(pegasus, drv, pegasus->net,
 			  "%s returned %d\n", __func__, ret);
+		kfree(req);
+		usb_free_urb(async_urb);
 	}
 	return ret;
 }
-- 
2.52.0


