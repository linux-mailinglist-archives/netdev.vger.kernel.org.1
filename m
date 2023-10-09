Return-Path: <netdev+bounces-39275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D6D7BEA23
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5AE281AC0
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38833B294;
	Mon,  9 Oct 2023 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv21Hteb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208FE35880;
	Mon,  9 Oct 2023 18:53:02 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05A0AF;
	Mon,  9 Oct 2023 11:53:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-991c786369cso814835966b.1;
        Mon, 09 Oct 2023 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696877579; x=1697482379; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4iEFw2KWu0uLaXIWh95J9DkXgQ94Tm3AGN4RoICln98=;
        b=Lv21Htebuds0cZAr+gOXmTjJMSbr2Z3yuu4bb9jt0U2CPeab+yAh31yIXeBTjmBrZb
         Ujn7HtoPX3MzXJQKyj4ozksyVnoMVyMsfV0JXF2FKLv7y7QHt0omlDDjWeu473ubdS3N
         eD2bQORfMkDZVNd9fj+kfUiwO3BKuYuKdZt5wE94D+Y9lYyJ5dgZ7GjbRGbh80ATREUE
         lFakJ2AvQc5RZlXz5zIJ7+DrG6pi3NypNek1LcjwdZKRvFP6k4+XrYXQeSTMI8vOCdJ9
         NKGVT0hpAUFpsLcIwcyIdIncG+yRHgZn7rYjeDbt+bdChLpERT7H5lN0IQd5bGf4YoEq
         EDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877579; x=1697482379;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iEFw2KWu0uLaXIWh95J9DkXgQ94Tm3AGN4RoICln98=;
        b=InXUxhHfQJx2sKjVFTjVIhgJkxqYnW1D79Oiaxs7lHQc9uy6mpFn0Nq2WFs436irET
         rH1oiioYu3xDHHVyQBUTbMe+rWr5nGbW2PMUhKyEW+bWiFbMZPCayw4jR9UkrMjUbWmE
         pXd72odMF5xacHwGe5lNrgG6+803c563E0+2FEo9H4ih55VllQaPDHcJ2KMfsMa0lA1M
         fSqqNq5Re7eyP+DkR0hJO0fDuwi1W/HVOmDGW6eA97uudFH4hlk+EZRnsorScntayFLr
         8fETbZ9ywRa1qZwF5THzbrzQY5wchl0/CTN/B1NncFy4P0PMYiHEcdFkVd4jIo8ZsIdy
         +9/w==
X-Gm-Message-State: AOJu0YyarLPo8JIHT1XR0xSc+Ms1htpK4JoXAls4kCUzFslCYw8jSY7X
	2RKwjy5amKTnsOP00TDDkY0=
X-Google-Smtp-Source: AGHT+IHstENxO/CXBuztPUegYH2i+Eluu2FwXYIb3oRGpR+JbD37gpX5p6/pDya5W/Q4FEg4oGasbA==
X-Received: by 2002:a17:906:fe4a:b0:9ae:5120:5147 with SMTP id wz10-20020a170906fe4a00b009ae51205147mr17596835ejb.38.1696877579020;
        Mon, 09 Oct 2023 11:52:59 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-0d7c-652f-4e74-10b8.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d7c:652f:4e74:10b8])
        by smtp.gmail.com with ESMTPSA id dc4-20020a170906c7c400b0098e34446464sm7115079ejb.25.2023.10.09.11.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:52:58 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 09 Oct 2023 20:52:55 +0200
Subject: [PATCH] net: usb: dm9601: fix uninitialized variable use in
 dm9601_mdio_read
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-topic-dm9601_uninit_mdio_read-v1-1-d4d775e24e3b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAZMJGUC/x2NQQrDIBAAvxL2XEFTGmq/UoqscW32oIbVlELI3
 2t6HAZmdqgkTBUeww5CH65ccgdzGWBeML9JcegMox6vRmurWll5ViHZSRu3Zc7cXApcnBAGheZ
 mzT1GH6YIveGxkvKCeV7OSsLaSE6xCkX+/sfP13H8APazsqmIAAAA
To: Peter Korsgaard <peter@korsgaard.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696877577; l=1746;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=mr8zo8GkO8oFsYnOO1Ir3z/Ohnh9ZkCWi74Q+XjdrAw=;
 b=Ci4voJZHNqhGCYzpafxEBwQNK2Id3/J6q0wWFflh/IM3YXHIfzqgqFA9hmTzXxoS1OJAXksGz
 LWVNIUycrJ1C1HWJbFsXM1X/UmIAfk6Gh9utnaVXx36HBu1VipFOaVJ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has found an uninit-value bug triggered by the dm9601 driver [1].

This error happens because the variable res is not updated if the call
to dm_read_shared_word returns an error or if no data is read (see
__usbnet_read_cmd()). In this particular case -EPROTO was returned and
res stayed uninitialized.

This can be avoided by checking the return value of dm_read_shared_word
and returning an error if the read operation failed or no data was read.

[1] https://syzkaller.appspot.com/bug?extid=1f53a30781af65d2c955

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reported-and-tested-by: syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com
---
 drivers/net/usb/dm9601.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 48d7d278631e..e223daa93229 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -222,13 +222,20 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	struct usbnet *dev = netdev_priv(netdev);
 
 	__le16 res;
+	int err;
 
 	if (phy_id) {
 		netdev_dbg(dev->net, "Only internal phy supported\n");
 		return 0;
 	}
 
-	dm_read_shared_word(dev, 1, loc, &res);
+	err = dm_read_shared_word(dev, 1, loc, &res);
+	if (err <= 0) {
+		if (err == 0)
+			err = -ENODATA;
+		netdev_err(dev->net, "MDIO read error: %d\n", err);
+		return err;
+	}
 
 	netdev_dbg(dev->net,
 		   "dm9601_mdio_read() phy_id=0x%02x, loc=0x%02x, returns=0x%04x\n",

---
base-commit: 94f6f0550c625fab1f373bb86a6669b45e9748b3
change-id: 20231009-topic-dm9601_uninit_mdio_read-a15918ffbd6f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


