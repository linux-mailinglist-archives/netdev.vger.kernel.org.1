Return-Path: <netdev+bounces-29293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7776A7828BA
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 14:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B04280E4C
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 12:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5093C53AB;
	Mon, 21 Aug 2023 12:14:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F3524C
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 12:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C87C433C8;
	Mon, 21 Aug 2023 12:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692620097;
	bh=r1NIOj8bIDAh7N5rqHvucaHlDZ9m0bo3+9/KsHUS0f0=;
	h=From:To:Cc:Subject:Date:From;
	b=kJeSiVRBXpIgURglLgEnyiQ3ek1Opg40Oj9rDnfwwHQe0n+nyz0yFSr1lSWUAjBye
	 Jf89+DgJeaNPB4Bx20YuK3skcX0nPVoSYRemtDc6YoDT63b9w+dsbBiHsgar+i3pti
	 AH0q8/YGve/EgrmNHSkMA69fSwrze0ZxPGJnsryE3E4091lRZAIpvOqLdXk4glJrJr
	 w9omOgrFf89Owsn93h7N6EWoQVdLJmpZAzbE0L1Jn9yKDKn41IskIqAc8v1a/FVik1
	 FZikJ2238k7PWSiTJp4f/ghCx/xrDDgskMOTjSNqikx07ugMVCNW0Q19ydFyZvWhuZ
	 cdEVsCFIwOF4w==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net] leds: trigger: netdev: rename 'hw_control' sysfs entry to 'offloaded'
Date: Mon, 21 Aug 2023 14:14:53 +0200
Message-ID: <20230821121453.30203-1-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit b655892ffd6d ("leds: trigger: netdev: expose hw_control status
via sysfs") exposed to sysfs the flag that tells whether the LED trigger
is offloaded to hardware, under the name "hw_control", since that is the
name under which this setting is called in the code.

Everywhere else in kernel when some work that is normally done in
software can be made to be done by hardware instead, we use the word
"offloading" to describe this, e.g. "LED blinking is offloaded to
hardware".

Normally renaming sysfs entries is a no-go because of backwards
compatibility. But since this patch was not yet released in a stable
kernel, I think it is still possible to rename it, if there is
consensus.

Fixes: b655892ffd6d ("leds: trigger: netdev: expose hw_control status via sysfs")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
Andrew, Ansuel, Jakub: since I came late to this show, I will understand
if you do not agree with this.

Marek
---
 .../testing/sysfs-class-led-trigger-netdev    | 20 +++++++++----------
 drivers/leds/trigger/ledtrig-netdev.c         |  8 ++++----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
index 78b62a23b14a..f6d9d72ce77b 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
@@ -13,7 +13,7 @@ Description:
 		Specifies the duration of the LED blink in milliseconds.
 		Defaults to 50 ms.
 
-		With hw_control ON, the interval value MUST be set to the
+		When offloaded is true, the interval value MUST be set to the
 		default value and cannot be changed.
 		Trying to set any value in this specific mode will return
 		an EINVAL error.
@@ -44,8 +44,8 @@ Description:
 		If set to 1, the LED will blink for the milliseconds specified
 		in interval to signal transmission.
 
-		With hw_control ON, the blink interval is controlled by hardware
-		and won't reflect the value set in interval.
+		When offloaded is true, the blink interval is controlled by
+		hardware and won't reflect the value set in interval.
 
 What:		/sys/class/leds/<led>/rx
 Date:		Dec 2017
@@ -59,21 +59,21 @@ Description:
 		If set to 1, the LED will blink for the milliseconds specified
 		in interval to signal reception.
 
-		With hw_control ON, the blink interval is controlled by hardware
-		and won't reflect the value set in interval.
+		When offloaded is true, the blink interval is controlled by
+		hardware and won't reflect the value set in interval.
 
-What:		/sys/class/leds/<led>/hw_control
+What:		/sys/class/leds/<led>/offloaded
 Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	linux-leds@vger.kernel.org
 Description:
-		Communicate whether the LED trigger modes are driven by hardware
-		or software fallback is used.
+		Communicate whether the LED trigger modes are offloaded to
+		hardware or whether software fallback is used.
 
 		If 0, the LED is using software fallback to blink.
 
-		If 1, the LED is using hardware control to blink and signal the
-		requested modes.
+		If 1, the LED blinking in requested mode is offloaded to
+		hardware.
 
 What:		/sys/class/leds/<led>/link_10
 Date:		Jun 2023
diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index c9bc5a91ec83..03c58e50cc44 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -406,15 +406,15 @@ static ssize_t interval_store(struct device *dev,
 
 static DEVICE_ATTR_RW(interval);
 
-static ssize_t hw_control_show(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t offloaded_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", trigger_data->hw_control);
 }
 
-static DEVICE_ATTR_RO(hw_control);
+static DEVICE_ATTR_RO(offloaded);
 
 static struct attribute *netdev_trig_attrs[] = {
 	&dev_attr_device_name.attr,
@@ -427,7 +427,7 @@ static struct attribute *netdev_trig_attrs[] = {
 	&dev_attr_rx.attr,
 	&dev_attr_tx.attr,
 	&dev_attr_interval.attr,
-	&dev_attr_hw_control.attr,
+	&dev_attr_offloaded.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(netdev_trig);
-- 
2.41.0


