Return-Path: <netdev+bounces-38055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887217B8D4F
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 88A371C20995
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D6E224C9;
	Wed,  4 Oct 2023 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pi8CIpn0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3114021A09
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 19:26:52 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA2C6
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 12:26:50 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c67060fdfaso118065a34.2
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696447610; x=1697052410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Zfzelmm1n/oCSSsu2UQQ3ShaAfhz3hNzTZf6CMU+g4=;
        b=Pi8CIpn07shffaXyjeVj/e+/7+yV2y5oahlK+xoXr7t7Btw9U8+wECYrKE1/YN5oO4
         OydR0Hn8PwKXEFr+uTO9r1lE3hxzosPOzZwMKAO03yKlSOng45Qe/QGXGu2gxWqHKHFk
         XUcK2Ay6rBJnExE+DGeY+WXg2bJHMdLdInhZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447610; x=1697052410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Zfzelmm1n/oCSSsu2UQQ3ShaAfhz3hNzTZf6CMU+g4=;
        b=DeM4uOfvL35WTGmsJK522TMXtX8UyAvJCsbpVFAHZ5V0hd0nu+R8q/qkXQrRfurCzn
         QIybiK6068fVxZVPFgEVgBoaVW/3HH9U5o663Os8pbc4X+xxV1xUxdOZg5nWaqDT9OKo
         nrfBJRJ6pN6JFcWfyrtBsbfqnMtf4E5RZ+LO/vze5KMu0j2qPrGbdehziLRdHfelm4wL
         t8aCXFfBPW/zz3zW2VWd9iWi2UMt3mu7PKDJ1jKKc5nkueX0Ef2i0uMSx29ArGSkYN0o
         Zw3hi7zQt+/wp0gSz5YXn6K9CYlImD3/1N6hlOajCVDHvYUz8/TafJtoMWtQhBnZMcCZ
         81pg==
X-Gm-Message-State: AOJu0Yz9vYxr51ez9BHas37wkP7UHADeQkXBitpEFt/ANBrtml5e8Z/n
	Zbrc/3BEyBmGlAWGKwgKlUgGZA==
X-Google-Smtp-Source: AGHT+IFLqgqksG+reeE7PZOYesE5gVIpvSs2k7VqK+4YgIVhHEe8hG2Nx3gW4/n0MzstshK1BGyLsQ==
X-Received: by 2002:a9d:7383:0:b0:6b9:2869:bd81 with SMTP id j3-20020a9d7383000000b006b92869bd81mr3271947otk.18.1696447609953;
        Wed, 04 Oct 2023 12:26:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9cce:13a8:f2b8:b799])
        by smtp.gmail.com with ESMTPSA id d190-20020a6336c7000000b0057c29fec795sm3649151pga.37.2023.10.04.12.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:26:49 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-usb@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Grant Grundler <grundler@chromium.org>,
	Edward Hill <ecgh@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/5] r8152: Increase USB control msg timeout to 5000ms as per spec
Date: Wed,  4 Oct 2023 12:24:38 -0700
Message-ID: <20231004122435.v2.1.I6e4fb5ae61b4c6ab32058cb12228fd5bd32da676@changeid>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231004192622.1093964-1-dianders@chromium.org>
References: <20231004192622.1093964-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

According to the comment next to USB_CTRL_GET_TIMEOUT and
USB_CTRL_SET_TIMEOUT, although sending/receiving control messages is
usually quite fast, the spec allows them to take up to 5 seconds.
Let's increase the timeout in the Realtek driver from 500ms to 5000ms
(using the #defines) to account for this.

This is not just a theoretical change. The need for the longer timeout
was seen in testing. Specifically, if you drop a sc7180-trogdor based
Chromebook into the kdb debugger and then "go" again after sitting in
the debugger for a while, the next USB control message takes a long
time. Out of ~40 tests the slowest USB control message was 4.5
seconds.

While dropping into kdb is not exactly an end-user scenario, the above
is similar to what could happen due to an temporary interrupt storm,
what could happen if there was a host controller (HW or SW) issue, or
what could happen if the Realtek device got into a confused state and
needed time to recover.

This change is fairly critical since the r8152 driver in Linux doesn't
expect register reads/writes (which are backed by USB control
messages) to fail.

Fixes: ac718b69301c ("net/usb: new driver for RTL8152")
Suggested-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/net/usb/r8152.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0c13d9950cd8..482957beae66 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1212,7 +1212,7 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_in,
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_GET_TIMEOUT);
 	if (ret < 0)
 		memset(data, 0xff, size);
 	else
@@ -1235,7 +1235,7 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_out,
 			      RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_SET_TIMEOUT);
 
 	kfree(tmp);
 
@@ -9494,7 +9494,8 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
 
 	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp), 500);
+			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
+			      USB_CTRL_GET_TIMEOUT);
 	if (ret > 0)
 		ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
 
-- 
2.42.0.582.g8ccd20d70d-goog


