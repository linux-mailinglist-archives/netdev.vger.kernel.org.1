Return-Path: <netdev+bounces-43115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C947D17BE
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAA5282649
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1A32B757;
	Fri, 20 Oct 2023 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fvrGT2uI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E344A2B748
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:08:17 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58427D7C
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:08:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b709048d8eso1097481b3a.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697836095; x=1698440895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvOeqgh1R0cFVT/LR2McM1sRBuOsLz4JWxKyKe8PLwc=;
        b=fvrGT2uIFyeVVEgMKDDOv3hLBZrccgGahRS/L1FAcXmLUZw5xzd2FtVuNtbPKMbGDL
         PeH3tsTbm/+zEesEPqmYR6QvH5lgY5LvCpv7DaDEoeeQJ9P2MQMV4FkaO1gPSxBdGUPT
         gucm08DAC2ueM/EG1sJl2tWDOzj90Kc35i1lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836095; x=1698440895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvOeqgh1R0cFVT/LR2McM1sRBuOsLz4JWxKyKe8PLwc=;
        b=Qgw1tJzg0r36I26u/wVwMuAM+RCDzCEk3RikWKWIEtfIG6xsHGOsJwjnHjD+e1TOsR
         qNoQXR+NCtkenc3ZjygB/DVPdAzYA/CqHd+hFP+YAtwMEvRzQj2KSEiEp5NjWvt8wKZM
         wz215c7OPZMMtCquuD4EJbbqIzpr4IeNAkJR6tHvInIm+LdLmT+zKp5nxa+7Ssku7Pz5
         gQtnwH83DWo3AgpnE66+j/L2er2SzhnGLBnySsGkgRbcADrS8vMJ9mQbYBBf8DX7mtTV
         Lbc2X9x+ISS4jn7s9uhkdBz8srJfgkzVHdIJPJcN1jMc+pcXN1Oq2p2UVsBemvtLyLa8
         cWIg==
X-Gm-Message-State: AOJu0YyR8RpCZWz5SwRifdZVTBBf63ZZb6lIju3+VRNJe8JOsGMziBGi
	W1PTpAM6aZVKSny6CWzoJEUAOg==
X-Google-Smtp-Source: AGHT+IEzitYnZ+qhAkuPmGLMEpNU1IygWpXUTt1/zzwHbDbA+VfqgbH3v+NEMoQ+ttmtINkvfrrfsw==
X-Received: by 2002:a05:6a20:432c:b0:17b:1696:e5ea with SMTP id h44-20020a056a20432c00b0017b1696e5eamr3319169pzk.14.1697836095564;
        Fri, 20 Oct 2023 14:08:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c078:ee4f:479f:8486])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00686b649cdd0sm1969278pfq.86.2023.10.20.14.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:08:14 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 3/8] r8152: Cancel hw_phy_work if we have an error in probe
Date: Fri, 20 Oct 2023 14:06:54 -0700
Message-ID: <20231020140655.v5.3.I33c8decabd2e77c37524db02b4e6b9b4dbc3a8d6@changeid>
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

The error handling in rtl8152_probe() is missing a call to cancel the
hw_phy_work. Add it in to match what's in the cleanup code in
rtl8152_disconnect().

Fixes: a028a9e003f2 ("r8152: move the settings of PHY to a work queue")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5:
- ("Cancel hw_phy_work if we have an error in probe") new for v5.

 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 201c688e3e3f..d10b0886b652 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9783,6 +9783,7 @@ static int rtl8152_probe(struct usb_interface *intf,
 
 out1:
 	tasklet_kill(&tp->tx_tl);
+	cancel_delayed_work_sync(&tp->hw_phy_work);
 	if (tp->rtl_ops.unload)
 		tp->rtl_ops.unload(tp);
 	usb_set_intfdata(intf, NULL);
-- 
2.42.0.758.gaed0368e0e-goog


