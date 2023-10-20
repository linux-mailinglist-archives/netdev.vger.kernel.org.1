Return-Path: <netdev+bounces-43116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5226D7D17C2
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D12282649
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD3830D11;
	Fri, 20 Oct 2023 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JQpI4Xq9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EEC249EE
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:08:20 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D655A10C2
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:08:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so1227698b3a.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697836097; x=1698440897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Zu77mdO6sktTxTIEryyom1thHcuDOj/hZWn2X42FV4=;
        b=JQpI4Xq9/jEHrkcm4kJXBDeVRXV60Kerc9XYCSkWFo/LCREekDsJ3DWHm+24nd8KvB
         Lek83Q1Ofp5psUDEumOfu0j+LhCgvU3+DRgrLO/GPOholqm38o1ALoJWgeBIL6Adptcr
         TqLqCMKSbvugU36vN0YCUdzt9neldBO19oHTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836097; x=1698440897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Zu77mdO6sktTxTIEryyom1thHcuDOj/hZWn2X42FV4=;
        b=FmBITt6ju+awts+PEejqcthAQzdJfV/3bk4A4ekyX6MT3VKwxBNn/ZExMy7ZwwPvoh
         2PBpfSGxueC42hlmE383zDSe8oblEt2FGjdjRuhzetmAw95yGBk97MigNSGOTwhWmnFd
         BceQDriFb2pe6o7ek8nYDi98P+5L48x3JPwKtBpsC8aTkNdn4m3Yjv48G8yKF8+NIXCr
         1UGXWNo5nBLdzn2XesRqF+PyzAsTLGZQMP3n3vSQzIGehfQDyCTuTGf78J2MLGYFOeau
         daGaadjiYYZJCuhSnBKy9GEbOAHgYcVRaHgxXpGSbTcP8wXyWwnKW4lsg+nYCxUKvEm1
         3Qxw==
X-Gm-Message-State: AOJu0YzGHAVrlqQB55AjHt/OfRE4ghpVWIb+2KCwfrGwll9RRV7IBe7b
	tMorGkKoIelJRqrYhwQOEoFLag==
X-Google-Smtp-Source: AGHT+IFmPo0a3BDvOdl9WUSCn87DM1UjGRco3v8oKH5WLNOwecmjVvp8jXBxPaM4fCiQi2q65KUipg==
X-Received: by 2002:a05:6a20:7288:b0:13a:6bca:7a84 with SMTP id o8-20020a056a20728800b0013a6bca7a84mr3339806pzk.44.1697836097385;
        Fri, 20 Oct 2023 14:08:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c078:ee4f:479f:8486])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00686b649cdd0sm1969278pfq.86.2023.10.20.14.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:08:16 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Edward Hill <ecgh@chromium.org>,
	Laura Nao <laura.nao@collabora.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Simon Horman <horms@kernel.org>,
	linux-usb@vger.kernel.org,
	Grant Grundler <grundler@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Prashant Malani <pmalani@chromium.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 4/8] r8152: Release firmware if we have an error in probe
Date: Fri, 20 Oct 2023 14:06:55 -0700
Message-ID: <20231020140655.v5.4.I5cd5dd190df0826e38444df217f63918a8b4ad39@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231020210751.3415723-1-dianders@chromium.org>
References: <20231020210751.3415723-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error handling in rtl8152_probe() is missing a call to release
firmware. Add it in to match what's in the cleanup code in
rtl8152_disconnect().

Fixes: 9370f2d05a2a ("r8152: support request_firmware for RTL8153")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5:
- ("Release firmware if we have an error in probe") new for v5.

 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d10b0886b652..656fe90734fc 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9786,6 +9786,7 @@ static int rtl8152_probe(struct usb_interface *intf,
 	cancel_delayed_work_sync(&tp->hw_phy_work);
 	if (tp->rtl_ops.unload)
 		tp->rtl_ops.unload(tp);
+	rtl8152_release_firmware(tp);
 	usb_set_intfdata(intf, NULL);
 out:
 	free_netdev(netdev);
-- 
2.42.0.758.gaed0368e0e-goog


