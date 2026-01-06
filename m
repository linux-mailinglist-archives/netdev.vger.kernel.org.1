Return-Path: <netdev+bounces-247325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 314FDCF7577
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 09:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4B7F303C2A9
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0D27E7EC;
	Tue,  6 Jan 2026 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="mrjPrQqF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624322F77E
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767689312; cv=none; b=hq9doiO55KP159JwPuoNOEKBdl3v4IkhPtwhzYlrEXzjfNWMouP2AwCTxmDLkauwaHEv2I0UaDpc/6dYdlIra/UopwhvwEJ2EEs2xC0j41wVZqet/z63FCiBgC+UCZitYWBI0uJWvGyNH+ic0LOV8wTUEe8RxNLCiIWs8B1Pb5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767689312; c=relaxed/simple;
	bh=tzas3/joaMGBU+SDtnWhUHfVRcM4fTGJmqiHajhVV8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+FqD6oDyrGvXkOZFGDdZWeNodi5C67qF9FNIO4DwW9sc0MXwo4eQEYzoqhQ4qYp+EA7TGEnZF/2/afGp+E+x/HYPvGk2PUUkS6E40c24fOxXA0yLcN9bzGDGdPj/Uj9KgKONKHxYPZBZlWe5SL7TJQ3jTesPlRhfr9W0ABHocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=mrjPrQqF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so1135244a12.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 00:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767689309; x=1768294109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XxK6mB3Dr2ZqUnEijrTyuH4FtxcVLOKZHeBdJMmwl24=;
        b=mrjPrQqFSqKB70HKsGgI7jVzLP6HBAMcTnEiJONvbI8/vhwybbgySVRD2/5dOYSi0k
         N3Z/w1SHJ1kg3d51xfubfWr3VNSl4ANCbnlROfjAiImi18GVtd0zeVjFVTsA7WYZTDRX
         ylMw0eFfj2V5qGNQWxAsyWOWOK9NzVpRAn7bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767689309; x=1768294109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxK6mB3Dr2ZqUnEijrTyuH4FtxcVLOKZHeBdJMmwl24=;
        b=rN9iAO5mgqyz7Hs2j/28pu+uL/G/K8yt+0XYrcLjEUFYVidnRf455JoWbtSoE0YHwi
         9zEO6x3LuQuDC+ffsb11vcJ9H3T/+MkqVS2ewUxOkLbjc1QA30z1ZZCaii+n+FkB/I0Y
         ykdSYB0/kYWacIq1XkenjEli674SnsuLaKiYTBG8XpTk9ACpjT1wzeGeX+E2diM73CJX
         dsC9T6QTjCDc/9yx42pzAQvfLiXIXrK9gKGOG/1cnXFB1wSBMzEsdvxy8cHyDUqsXMQz
         a8QBSd5Wp1ZKPWZBVPQAjPLWn1skuYPwnnChqltanINxjWuMgMF70oiMXamBmtvhVR7c
         ghCg==
X-Gm-Message-State: AOJu0Ywps39lukP+X/czatfDyGdIB7GJsLOLbJ3HUHlU8XtYOfjGv2Ng
	sBSuAnsECJROkO+iqB9VSCCXky6Ww0ypRIL7tk4uTQYa3H4+nK8D7UWT5CL39Kg83bW0rSus6/8
	0BBans2g=
X-Gm-Gg: AY/fxX4j1r2473U5XaFMhYHYcMDkqS13bHghHz/IQPOt9Owi1fXv8nOdjtxU6QD2Yd9
	fFubry4ReY7zYPOTngTFqK3CMisneE4qdNnDFtba5QrpDwvMQQ19wZEeJsNdJP7jp/089kE1y9d
	2ICw3uJ1EDyTuvzY0RuuSzt1Nu+6tLxQDOrJSD1ZwwxMjuf17bm03TTFA0588diL5hnh4fBlmIO
	A1PdWhSuVGOD7Z0hfDkra+j/Das0Z3XCVjwQeyJdn9i+4L2psgacFy4fFeYRQ9NmEgAMJQYiNu+
	f+fSzlQwf9iKXE24YucQii+oypTyl3vW/rCtptl6zX3iuycojxGAxB79N3kQIOQuhvoCv9hSD61
	Yv79Da68s9aZCEAk7k4oRdBnBl+1nI/h4qVMP2X0mc6XMhJEK3ki2Jjr5wvKZpA20yX+Ica0v8W
	DWW2haQQGk5YGfodXJLWg+UZvBRiQnjujbLPUfmCE=
X-Google-Smtp-Source: AGHT+IGNZG9HYrU6znG1XT2PLBjL9IBlLbwC6us1VE4nZSB+4uRh97YAaMpzUsuYysrkWNcCZSkDdg==
X-Received: by 2002:a05:6402:3594:b0:64d:589a:572b with SMTP id 4fb4d7f45d1cf-6507954bd5amr2316942a12.17.1767689308605;
        Tue, 06 Jan 2026 00:48:28 -0800 (PST)
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4ed5sm1513832a12.11.2026.01.06.00.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:48:28 -0800 (PST)
From: Petko Manolov <petko.manolov@konsulko.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	stable@vger.kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	Petko Manolov <petkan@nucleusys.com>
Subject: [PATCH NET v2 1/1] net: usb: pegasus: fix memory leak in update_eth_regs_async()
Date: Tue,  6 Jan 2026 10:48:21 +0200
Message-ID: <20260106084821.3746677-1-petko.manolov@konsulko.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petko Manolov <petkan@nucleusys.com>

When asynchronously writing to the device registers and if usb_submit_urb()
fail, the code fail to release allocated to this point resources.

Fixes: 323b34963d11 ("drivers: net: usb: pegasus: fix control urb submission")
Signed-off-by: Petko Manolov <petkan@nucleusys.com>
---
v2:
  - replace the auto-cleanup form with the classic kfree();

 drivers/net/usb/pegasus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 81ca64debc5b..c514483134f0 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -168,6 +168,8 @@ static int update_eth_regs_async(pegasus_t *pegasus)
 			netif_device_detach(pegasus->net);
 		netif_err(pegasus, drv, pegasus->net,
 			  "%s returned %d\n", __func__, ret);
+		usb_free_urb(async_urb);
+		kfree(req);
 	}
 	return ret;
 }
-- 
2.52.0


