Return-Path: <netdev+bounces-38164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEEF7B996D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 03:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 29C971C20952
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 01:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05814EC5;
	Thu,  5 Oct 2023 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeNnjCtd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2EEA6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 01:06:29 +0000 (UTC)
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E562C1
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 18:06:27 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id 006d021491bc7-57deaca4fc5so450957eaf.0
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 18:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696467987; x=1697072787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mQB1kQKW7T3L2uUwJbrYDEYlgsQvJV2Fhw2l/EpdGY8=;
        b=jeNnjCtdHLuLsynqL4oh+npAEvtBgPjHank4TqpJbRb4TxBqdqwAERymPM6sxtNrzQ
         GzysA0923XVu5ujPwcmw1C2ThxA/KUc0aNFthbQjeMddty13dI7FP97/FbfrNWdu25Cz
         WL0SdVTUYycCrZQG56AlWMsBG7bPxNfpfApAQNdjuovayB/RTZPnTmXHsR0b4t5vuRmA
         GRuNWLe7naVXB5JEv8vPuMJ0ZaDKfVl7BG6zc2HhQnF0iuCHNqULS9XJ+7jCSnSHbW1H
         0C3+HaqyWqIhGAivnj/bNt0IHJQgdF24DH+DTkmsDQPVPO9OMcxeyClR/yNlhYNk68Ct
         r6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696467987; x=1697072787;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQB1kQKW7T3L2uUwJbrYDEYlgsQvJV2Fhw2l/EpdGY8=;
        b=k9BL7CscIYvbQkfEX1NefLzH/HxQ0P9CmtbJzN2sqtd/uH+r0sDn7jVecoCo/N9i0M
         Tj09GXrjlZ/ysZSpx4P12wCkhlSOdFaZsJP+xzz9ZBmwIjHZ2VwXlqE0H2giTxHV46Mx
         hgI2RVvh5ioRClU9ehwPEeNwmV5BBP5tBnYW9wOKaNjpb8WJRz4Qg2q0p/dUez944uYH
         pwUgMA9C5FQJu1iGOLwjl/1avSC34VKsFybKrLznq4TTx97QWD3dp4K2D2wCIjP5Ooq+
         /jM2caQQLkxyIRMt+lpmjKQrx0T5Vg9PO0sc9On5cQ59VVSqdLURhhdoAMxcwtGGfVjr
         1/8w==
X-Gm-Message-State: AOJu0YwUC95pXqPTntV8Pk/iRxUn2sZOg67OFsRs6/H2BNNcXiXzhr0h
	SK0bhndlu/xl5FXNM38QO3btzox2KkG3alaoJg==
X-Google-Smtp-Source: AGHT+IEqGC2JyZf/APfbf0G671YQ1tje4obvLe/vw3B4Fz5AgOLZt88OOLHuFWH9gu/s7epBrRmuCxPyCtNJYZQx7A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a4a:3757:0:b0:57b:7849:1a4d with SMTP
 id r84-20020a4a3757000000b0057b78491a4dmr1189222oor.0.1696467986905; Wed, 04
 Oct 2023 18:06:26 -0700 (PDT)
Date: Thu, 05 Oct 2023 01:06:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABEMHmUC/x2NywrCMBAAf6Xs2YU00kf8FSkSk61dkLTshhIp/
 Xejt5nLzAFKwqRwaw4Q2ll5TVXaSwNh8elFyLE6WGOvrTEdapYUtg9G4Z1EMVFGygvJD7xyQV/ GcXB9ePAa8hsDdr2frXkO0TkLNbwJzVz+0/t0nl81i6Z8hAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696467985; l=2198;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=4MvL6upoNfTxK6wWGQu8y1cwwP7D33deQUgMGbxdScE=; b=H6NNTKVD4o6W+AmJyuzhgFGH552jbnH7scuh9fE3Q3Rj/0lixzMLTRS+2RM1KIzJtorlUJjDb
 zbBS3JJriDvBUHdkIghsUKKjQZHTJ8tkt5gBcyUxz548oJpIhh+D8K9
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-asix-ax88796c_ioctl-c-v1-1-6fafdc38b170@google.com>
Subject: [PATCH] net: ax88796c: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: "=?utf-8?q?=C5=81ukasz_Stelmach?=" <l.stelmach@samsung.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

It should be noted that there doesn't currently exist a bug here as
DRV_NAME is a small string literal which means no overread bugs are
present.

Also to note, other ethernet drivers are using strscpy in a similar
pattern:
|       dec/tulip/tulip_core.c
|       861:    strscpy(info->driver, DRV_NAME, sizeof(info->driver));
|
|       8390/ax88796.c
|       582:    strscpy(info->driver, DRV_NAME, sizeof(info->driver));
|
|       dec/tulip/dmfe.c
|       1077:   strscpy(info->driver, DRV_NAME, sizeof(info->driver));
|
|       8390/etherh.c
|       558:    strscpy(info->driver, DRV_NAME, sizeof(info->driver));

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/asix/ax88796c_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/asix/ax88796c_ioctl.c b/drivers/net/ethernet/asix/ax88796c_ioctl.c
index 916ae380a004..7d2fe2e5af92 100644
--- a/drivers/net/ethernet/asix/ax88796c_ioctl.c
+++ b/drivers/net/ethernet/asix/ax88796c_ioctl.c
@@ -24,7 +24,7 @@ static void
 ax88796c_get_drvinfo(struct net_device *ndev, struct ethtool_drvinfo *info)
 {
 	/* Inherit standard device info */
-	strncpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
 }
 
 static u32 ax88796c_get_msglevel(struct net_device *ndev)

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-asix-ax88796c_ioctl-c-56af20b7d992

Best regards,
--
Justin Stitt <justinstitt@google.com>


