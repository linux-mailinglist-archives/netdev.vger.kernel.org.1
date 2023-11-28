Return-Path: <netdev+bounces-51869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35ED7FC81F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 22:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC1D282080
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC51481CA;
	Tue, 28 Nov 2023 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QKBAge7S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4297C12A
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 13:40:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-285c3512f37so2767365a91.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 13:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701207639; x=1701812439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQpgB0hpYD1c6hlujz/aWaKFzOCbCq1mG9ijFrvdnyY=;
        b=QKBAge7SioihvVYTJUi05Yn5Bn9zeEOnfUYcXt3FvjWfrjySzZRNsKb9E3gQUikNpE
         0VWMg4qMHdBvsMqsZEtXSNGLUByzNdV/d+Q0YxbyXZTChLYxKjE8+H13qpuZjm5hCB5v
         1RH/TcQydFs38goys7py72n3XAbLte1AHFJcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701207639; x=1701812439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQpgB0hpYD1c6hlujz/aWaKFzOCbCq1mG9ijFrvdnyY=;
        b=wBa4tuDtpCZ/98N5j3Qxp3NSjW1nLwN0AiDDhh7v+gmk+Oz8gTuS6DCX+gtEGKlyFH
         /O1opREMsckrtqalRTupUo5MkOtpZqtO3DuYxmITbp2iKe6u1PQQbJ3DYy9I75a+Y75z
         krLLiBXrCnwEl72u88BQx1JnEhbaRXStcvuitywQMiFy/qKHY1Lh1NAG0ud40xK9dBl6
         Un4H8S4ECTVxRzN6rTKqS9OHwUeVG/F5behOnaNdM+ywke4ACZdr9muNdj5IuM12Avsy
         aCqKSIPB7WgLF0vPaJ5y9Sql4cFfwD2nHBuZOZO+DoOcq+dpdmMcCgcCRrpXTslKizdK
         B1mA==
X-Gm-Message-State: AOJu0YyDAZFrKO3GRjLNIJcgH8PYYFpzcOqLcugeR9Bjimt06j7c1D7j
	g4+vllMwgvWc7JQvIgFhaPxmFw==
X-Google-Smtp-Source: AGHT+IGdufnfU7w6XiSR48w3M0ObwdgFMLn6/XHezYmblLJU9cYVtIEIq/y+ik+j5vFBauLTdJDobA==
X-Received: by 2002:a17:90b:4c50:b0:285:8407:6152 with SMTP id np16-20020a17090b4c5000b0028584076152mr17639969pjb.8.1701207638788;
        Tue, 28 Nov 2023 13:40:38 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:fc3a:13ce:3ee3:339f])
        by smtp.gmail.com with ESMTPSA id ie24-20020a17090b401800b002609cadc56esm9634285pjb.11.2023.11.28.13.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:40:38 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Laura Nao <laura.nao@collabora.com>,
	Edward Hill <ecgh@chromium.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Grant Grundler <grundler@chromium.org>,
	linux-usb@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net v2 5/5] r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
Date: Tue, 28 Nov 2023 13:38:14 -0800
Message-ID: <20231128133811.net.v2.5.I1306b6432228404d6e61b2d43c2f71885292e972@changeid>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231128133811.net.v2.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
References: <20231128133811.net.v2.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delay loops in r8152 should break out if RTL8152_INACCESSIBLE is set
so that they don't delay too long if the device becomes
inaccessible. Add the break to the loop in r8153_aldps_en().

Fixes: 4214cc550bf9 ("r8152: check if disabling ALDPS is finished")
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Added Fixes tag to RTL8152_INACCESSIBLE patches.
- Split RTL8152_INACCESSIBLE patches by the commit the loop came from.

 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 26db3f6b3aa1..aca7dd7b4090 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5803,6 +5803,8 @@ static void r8153_aldps_en(struct r8152 *tp, bool enable)
 		data &= ~EN_ALDPS;
 		ocp_reg_write(tp, OCP_POWER_CFG, data);
 		for (i = 0; i < 20; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				return;
 			usleep_range(1000, 2000);
 			if (ocp_read_word(tp, MCU_TYPE_PLA, 0xe000) & 0x0100)
 				break;
-- 
2.43.0.rc1.413.gea7ed67945-goog


