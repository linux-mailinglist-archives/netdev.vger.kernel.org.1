Return-Path: <netdev+bounces-42820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A31E7D03B9
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 23:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016861C20E82
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638113E003;
	Thu, 19 Oct 2023 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MPcZ51HN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8876D3DFF7
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 21:22:10 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCA110F1
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 14:21:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1caa7597af9so890885ad.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 14:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697750515; x=1698355315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99XDTyUCvOUhQUp0MWN4ekbCgPLwBk+829H/gHSUoe4=;
        b=MPcZ51HNc62moeK+/HePn0XOKEHJX/127aI6KsxoMr0BIV9AkaT9ImsCYxCC0jAXUV
         3ZznDtvUVFzDoSdxlMhQvO8fXUCOK2ccN762TnO8JMzZajWOF0IWh6JPZ1NuY1mqOEMo
         WobmXd56f4+WENYmSJfy7D/y8DA3xgWDEL21c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697750515; x=1698355315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99XDTyUCvOUhQUp0MWN4ekbCgPLwBk+829H/gHSUoe4=;
        b=EEvD7/KzgMBF7TFIGa3ioud2w4Hh8Dk1yYKQ/Ltt3FjArsNePzhxji9HZIkJi6p1mL
         b2jEtPMUCubpaFAJS7PkiIRqq6vsgliI0s02Dk/9L1acYmosZhGX2SffpTZhkq903fD3
         YbMwMj2sQzseLpyFx9AjxjP0u2+nJph2L4vydOMiZgiYHAoFpG3LsLfH9vg3XqWAKRj+
         WfINc6PyGl1PXOUfmmWINzZCbkIGzF9iA5uEEa821aZ4Pse3aSqxKfYHh+PHQAwC5h5z
         thzmzN/5JpQFmiVqWIUibLrn/EHfhcx0o0FGdmnfAoEhV+N/7mC0QdBnxHsDaPuOIm5Y
         iFng==
X-Gm-Message-State: AOJu0Yzk4b1CWGltxmgNUNI0sD9OjKVwpSNPwIZBk8+hA9/ektR4SZAJ
	PqgSC1acMreF6xyESbYTGZBf7A==
X-Google-Smtp-Source: AGHT+IGHsyaazfKztgV6shIemQ+jlC7THOn7sKDO8SWa/SgIufIDIoOEAm3zf/DhGhEpv0iSNhqHcw==
X-Received: by 2002:a17:902:e204:b0:1c9:ccbc:4c98 with SMTP id u4-20020a170902e20400b001c9ccbc4c98mr75405plb.37.1697750515162;
        Thu, 19 Oct 2023 14:21:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:a6da:6f08:412:e04b])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b001bbdd44bbb6sm154100plk.136.2023.10.19.14.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 14:21:54 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Grant Grundler <grundler@chromium.org>,
	Edward Hill <ecgh@chromium.org>,
	linux-usb@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Laura Nao <laura.nao@collabora.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 1/5] r8152: Increase USB control msg timeout to 5000ms as per spec
Date: Thu, 19 Oct 2023 14:20:20 -0700
Message-ID: <20231019142019.v4.1.I6e4fb5ae61b4c6ab32058cb12228fd5bd32da676@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231019212130.3146151-1-dianders@chromium.org>
References: <20231019212130.3146151-1-dianders@chromium.org>
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


