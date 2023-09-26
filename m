Return-Path: <netdev+bounces-36364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199CA7AF5B5
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 23:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0848C2835DB
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 21:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A54B225;
	Tue, 26 Sep 2023 21:29:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D8E4B200
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 21:29:00 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F44A25F
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 14:28:58 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-692ada71d79so6295229b3a.1
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695763738; x=1696368538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVCYC0vkrZ6zXTzyEFnI7OnTxuwy99dqGDu6Ppi9+fs=;
        b=SJGNymYYAvCwIq47qwJNzf0kqY+QCYUyEqgOttrW+4HnQ2tokbmtWl1GicjlIg6y5a
         c5oIwCoVzEch2FvoWvgJEqYP72kB4KQfWVzqKhRxi9IKpdGl3oimCzrtXzu1yV7UtLgD
         wggXHhpwkNilkn+lNkZx5hi84jB3z/7qUaJFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763738; x=1696368538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVCYC0vkrZ6zXTzyEFnI7OnTxuwy99dqGDu6Ppi9+fs=;
        b=jgz7YV4MmcVQ/MffuThgy5IYOpwpxCUf3iygqsqDXIKg1pkhbRGjHAu8MK0sbGaO99
         CPTKpzMBWxska0BvuGdcInfdK28I3lNehJbn1aqhdj/x2uP135xr+dbuDpkSb6soz9nV
         JIkMiAn9w9MWlkrhN/UYOuVCaOPbyPWW7LI+7bj213/20tewb9B0iNEcHIrq4urx0v3X
         mQ3JaZ0vrw6+Hkhqc3slsB9q3CCjGx0HqqewwuVrLC0mtX0f2nTINgH4BzZCHqeP50sj
         DSRUu/S+LnwVJXWTWT/6RjbRKh6D8g2Ysz6d5TqJr37dUeHzHk4HgECZW5OnmiUIoYdk
         C61Q==
X-Gm-Message-State: AOJu0YwT7xOX65cQPSxI/jdlbdbvdQ0xbMzw38+cGOHT3DlxR52qJo7Z
	wGdsdT6ZSKiIRl7o2PhRtuD0UQ==
X-Google-Smtp-Source: AGHT+IHG1iNVZ2QkEqvmteXELKf2TZQxaAuiCqsMdO2hn0iNnxPeLxG8BUAPLN5Qx+Z+M0jVxMDFxg==
X-Received: by 2002:a05:6a00:1acb:b0:68e:29a6:e247 with SMTP id f11-20020a056a001acb00b0068e29a6e247mr233576pfv.10.1695763738175;
        Tue, 26 Sep 2023 14:28:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:f39:c3f2:a3b:4fcd])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b0068fece2c190sm10337251pfd.70.2023.09.26.14.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 14:28:57 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-usb@vger.kernel.org,
	Grant Grundler <grundler@chromium.org>,
	Edward Hill <ecgh@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	andre.przywara@arm.com,
	bjorn@mork.no,
	edumazet@google.com,
	gaul@gaul.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH 2/3] r8152: Retry register reads/writes
Date: Tue, 26 Sep 2023 14:27:27 -0700
Message-ID: <20230926142724.2.I65ea4ac938a55877dc99fdf5b3883ad92d8abce2@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926212824.1512665-1-dianders@chromium.org>
References: <20230926212824.1512665-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Even though the functions to read/write registers can fail, most of
the places in the r8152 driver that read/write register values don't
check error codes. The lack of error code checking is problematic in
at least two ways.

The first problem is that the r8152 driver often uses code patterns
similar to this:
  x = read_register()
  x = x | SOME_BIT;
  write_register(x);

...with the above pattern, if the read_register() fails and returns
garbage then we'll end up trying to write modified garbage back to the
Realtek adapter. If the write_register() succeeds that's bad. Note
that as of commit f53a7ad18959 ("r8152: Set memory to all 0xFFs on
failed reg reads") the "garbage" returned by read_register() will at
least be consistent garbage, but it is still garbage.

It turns out that this problem is very serious. Writing garbage to
some of the hardware registers on the Ethernet adapter can put the
adapter in such a bad state that it needs to be power cycled (fully
unplugged and plugged in again) before it can enumerate again.

The second problem is that the r8152 driver generally has functions
that are long sequences of register writes. Assuming everything will
be OK if a random register write fails in the middle isn't a great
assumption.

One might wonder if the above two problems are real. You could ask if
we would really have a successful write after a failed read. It turns
out that the answer appears to be "yes, this can happen". In fact,
we've seen at least two distinct failure modes where this happens.

On a sc7180-trogdor Chromebook if you drop into kdb for a while and
then resume, you can see:
1. We get a "Tx timeout"
2. The "Tx timeout" queues up a USB reset.
3. In rtl8152_pre_reset() we try to reinit the hardware.
4. The first several (2-9) register accesses fail with a timeout, then
   things recover.

The above test case was actually fixed by the patch ("r8152: Increase
USB control msg timeout to 5000ms as per spec") but at least shows
that we really can see successful calls after failed ones.

On a different (AMD) based Chromebook, we found that during reboot
tests we'd also sometimes get a transitory failure. In this case we
saw -EPIPE being returned sometimes. Retrying one time worked fine.

To keep things robust, let's try register access up to 3 times. If we
get 3 5-second timeouts in a row this could block things for 15
seconds but that hasn't been seen in practice. If we see that
happening and there is a better way to solve it then we can add a
special case for that later.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Originally when looking at this problem I thought that the obvious
solution was to "just" add better error handling to the driver. This
_sounds_ appealing, but it's a massive change and touches a
significant portion of the lines in this driver. It's also not always
obvious what the driver should be doing to handle errors.

 drivers/net/usb/r8152.c | 67 +++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 482957beae66..976d6caf2f04 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1200,6 +1200,52 @@ static unsigned int agg_buf_sz = 16384;
 
 #define RTL_LIMITED_TSO_SIZE	(size_to_mtu(agg_buf_sz) - sizeof(struct tx_desc))
 
+/* If we get a failure and the USB device is still attached when trying to read
+ * or write registers then we'll retry a few times. Failures accessing registers
+ * shouldn't be common and this adds robustness. Much code in the driver doesn't
+ * check for errors. Notably, many parts of the driver do a read/modify/write
+ * of a register value without confirming that the read succeeded. Writing back
+ * modified garbage like this can fully wedge the adapter, requiring a power
+ * cycle.
+ */
+#define REGISTER_ACCESS_TRIES	3
+
+static
+int r8152_control_msg(struct usb_device *udev, unsigned int pipe, __u8 request,
+		      __u8 requesttype, __u16 value, __u16 index, void *data,
+		      __u16 size, const char *msg_tag)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < REGISTER_ACCESS_TRIES; i++) {
+		ret = usb_control_msg(udev, pipe, request, requesttype,
+				      value, index, data, size,
+				      USB_CTRL_GET_TIMEOUT);
+
+		/* No need to retry or spam errors if the USB device got
+		 * unplugged; just return immediately.
+		 */
+		if (udev->state == USB_STATE_NOTATTACHED)
+			return ret;
+
+		if (ret >= 0)
+			break;
+	}
+
+	if (ret < 0) {
+		dev_err(&udev->dev,
+			"Failed to %s %d bytes at %#06x/%#06x (%d)\n",
+			msg_tag, size, value, index, ret);
+	} else if (i != 0) {
+		dev_warn(&udev->dev,
+			 "Needed %d tries to %s %d bytes at %#06x/%#06x\n",
+			 i + 1, msg_tag, size, value, index);
+	}
+
+	return ret;
+}
+
 static
 int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 {
@@ -1210,9 +1256,10 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 	if (!tmp)
 		return -ENOMEM;
 
-	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_in,
-			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      value, index, tmp, size, USB_CTRL_GET_TIMEOUT);
+	ret = r8152_control_msg(tp->udev, tp->pipe_ctrl_in,
+				RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
+				value, index, tmp, size, "read");
+
 	if (ret < 0)
 		memset(data, 0xff, size);
 	else
@@ -1233,9 +1280,9 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 	if (!tmp)
 		return -ENOMEM;
 
-	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_out,
-			      RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
-			      value, index, tmp, size, USB_CTRL_SET_TIMEOUT);
+	ret = r8152_control_msg(tp->udev, tp->pipe_ctrl_out,
+				RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
+				value, index, tmp, size, "write");
 
 	kfree(tmp);
 
@@ -9492,10 +9539,10 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
 	if (!tmp)
 		return 0;
 
-	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
-			      USB_CTRL_GET_TIMEOUT);
+	ret = r8152_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+				RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
+				PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
+				"read");
 	if (ret > 0)
 		ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
 
-- 
2.42.0.515.g380fc7ccd1-goog


