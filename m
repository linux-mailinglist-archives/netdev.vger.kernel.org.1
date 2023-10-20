Return-Path: <netdev+bounces-43113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C828B7D17B7
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDCA282630
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F0C25103;
	Fri, 20 Oct 2023 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l++ihJie"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647D23744
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:08:13 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382A6D6D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:08:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so1194489b3a.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697836092; x=1698440892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99XDTyUCvOUhQUp0MWN4ekbCgPLwBk+829H/gHSUoe4=;
        b=l++ihJieNoy2NHFRNriaVLflw6AB/L1XBBboft2BObY5YA6vlOKya89SzkA/PiNAjY
         wnnfJkVl8PwEs0SMLh1hnOAkRDjAVdKK6ClYDB9brBne42ZuBcTNry59JUSxHmfTNavA
         CvC8Sx21xeLXU8gKEACoswf8NN+MEWHoQKjM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836092; x=1698440892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99XDTyUCvOUhQUp0MWN4ekbCgPLwBk+829H/gHSUoe4=;
        b=VTOefZPa7xtPRJs1BRe3IewhaP7qobPaZGVsEzTFikKy74M5aBq/LGrEKsE+gM2Tpf
         nMOhRke7tDPlFjFmLHtdMkf9ypWaZfIR7cv6aGHpXHExtwvxwQ8hn8Sfnoh/l/5UDFW0
         AfgIZ+cqoyd/j/mO7MTtJ2cINxcu2hihrk0doalsLiQmBy3owDd6PfoaAZaNBx9+7Sgb
         k/NzBNCfmZMyve1n9RxFdNGMkFYDkLxLlZ/lwKtpNQXcS9uGTX3qXwZGUcezfrd11tlR
         9yFvtNhnLhGxsSOdC90GvQ7PDuLX/a/j30Lt5fBeiikrdv3HUElX1ughoP+iKUBFDD1M
         WKaw==
X-Gm-Message-State: AOJu0YxOPUG9UGXedYXsaEKI0E7vCr8SzWTthHTsste3Fujwf47bolXG
	3M0+FFFgNxhLJyu2So0ofMv5vw==
X-Google-Smtp-Source: AGHT+IHvwCyLBaOWjBmnEzbeEApD5EvvDgAzwVhB1HYymlZHneQb9iGP7cSle2Fs+uZmjFwwF7Mo8w==
X-Received: by 2002:a05:6a00:b4f:b0:6be:2081:f66d with SMTP id p15-20020a056a000b4f00b006be2081f66dmr3132834pfo.27.1697836091742;
        Fri, 20 Oct 2023 14:08:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c078:ee4f:479f:8486])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00686b649cdd0sm1969278pfq.86.2023.10.20.14.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:08:11 -0700 (PDT)
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
Subject: [PATCH v5 1/8] r8152: Increase USB control msg timeout to 5000ms as per spec
Date: Fri, 20 Oct 2023 14:06:52 -0700
Message-ID: <20231020140655.v5.1.I6e4fb5ae61b4c6ab32058cb12228fd5bd32da676@changeid>
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
2.42.0.758.gaed0368e0e-goog


