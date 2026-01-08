Return-Path: <netdev+bounces-247925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B04D0099A
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3229E303C28B
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2221257E;
	Thu,  8 Jan 2026 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1DSsefc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2522DFA4
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767837939; cv=none; b=Sqvam+ApGts0pfWL/9vnMyzhBN9c7VjDzEMyDQ28RccuL7yaFfPGe2dAuPKwRR/0TDPDnnQ18F3TKUL3a+dHKvAGPxbkygGgT69JUeW1+yzNc7vI47RPIkhJO01yDLw+47BYqLWRbrQAUNrUmKoCwQoDwv+TILGUG6x1Zzotyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767837939; c=relaxed/simple;
	bh=W/9ls/sYxJNc4PXSWRebVqXrb0jPJ3vzxtI+LMb6ecI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2eF3TGA6ZJ9728P4cLaLpV9zlLOgllOFAlzk7kNfi0e/nS+Y3Q7BgceMclEP4lYzeN7dWzRnha8xXZ5Kgr7Udatc8XKbVAFV6Zuz1fxa2IhmBf5qBCcRzFRsel2HjaH+tLtndxOTZmYsImUU2rjbcMG+ulq9O/84CwDu8snGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1DSsefc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso7091145e9.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 18:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767837936; x=1768442736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lhCM1gRa8vpNx7KgT5LybyVzCbSwHGzAu5rK+6MOfE=;
        b=D1DSsefcR3AU26Z2gmbRJBaaqI0mLf/dJtB724L/P8kMH2H/sbNU9J8Ho1x/TJWX34
         tW7tIFBTKEQPUrHyl28Jh7XITYoQxoLHoDC/6SCw+ROw9ToxX72JdiD9OCDvgr2pfpMW
         vT4X7Dnwxm1MM4i+TzkZ3+/iki8t9qHkYhwqBh/nTtmzWKSb2ftkIJezHZkjnwENFygi
         45MF6/QjmP3lVGQ4c0x9auljQkpdyLwSYroGU9AE0KRLgU0vawTJPNtedeIOV569pzKa
         PSG5gdc6UsjlQSiJBZ1fblpaGzGfPfaikd3Amv8yaRu7IQcO9ELV3xtSoX5Je9uKUTpM
         MD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767837936; x=1768442736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7lhCM1gRa8vpNx7KgT5LybyVzCbSwHGzAu5rK+6MOfE=;
        b=xBBvAEWd4yyvwwOPq4XBshHSODoKfhPMEfMttLDLEZQYjAbg2FwwRqdaOap8pm/l/E
         FeZJ4oom+4VgAPXmgUk8wZpDNgY854JhAA/XUmU49gBr4Ea93Ae/Caz2toYrSzTR8qjE
         LzsidlYoVrAdKIqlLkwwZc/4mLYQK7FwUMCklVgM3NK0DNeTJ3aOXbUUFvj2Urz/YhWE
         wNcvJKgwOmXmC87Xx7qkcASRpuaxpLrcoIAzy3lQUlNP1taVyMe5GYLrACcwBBa9uv1G
         az6fsNh7pXDE7UL7cgqgkWVDQF1kYdxhUPfWwUbZLZjpK32RAJ/OWHL8SGItfZPVHjPL
         1x7w==
X-Forwarded-Encrypted: i=1; AJvYcCX+Pq9UiADQOyMVFjc/Yn0x4KWfBM7ybMpJOMDmKc+CGZztSz24y7msGKks020fJTRxv2KOkR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweN0+QmQJMhomOg9FyNVCa2jBRBOp90Ojp6tShZMPJ8hjDiEjw
	5EmwZ6eOe9TLJMfkbWE9zBaqKy7YF/JbK+CDPpaUbBTeueIZ4bLix3IZ
X-Gm-Gg: AY/fxX4hk+LzJW0uXtHNIz22qXPD9NlgAl0K5Df8bfMTqfg8JRCLORQuI7kbPGrne72
	62UzTHRRZgJHh2Z5a/jVQcGtTREfs0z/CG5ceqChi3Yj9FZfas8ExUNTvmmI5WEsGiYYd7ZAgxx
	EDcCdxvHxf/EGag+ytq3hT4zJpyD/YatJw2n5DZG6AxF2bBYKL0nIZ6DufbZMz/X3wdShIlbKZ7
	iCToftHV2+e8lkxW/mS5ZxjetK6FeF4J6y/7lB/GqkWCbtWEx7EFYSnawltlXJIf5DgAAXDu98r
	T3ur6EXxc1exGXKe423d6z+n0BCPaA+OiCQxlXG6PJRm2lPld3OPZWmKo7uDrClNo4SiaUZ3+as
	/bnEkr6xyhLlfhSoScYMjL0TQzMjhY9RQJqbKv0AfuNoaR9w56kCxl0j3QznYzIClTFZtJdLcyE
	tQF62V04ck8g==
X-Google-Smtp-Source: AGHT+IFmdOyIm7/CZjNooBMFQPNjkNdnh23ymuA+j+8gwy5TmYoYMYXT3llbRIx1cklOdpPYMKHtpw==
X-Received: by 2002:a05:6000:1a8f:b0:431:1c7:f967 with SMTP id ffacd0b85a97d-432c375b00dmr5781772f8f.17.1767837936383;
        Wed, 07 Jan 2026 18:05:36 -0800 (PST)
Received: from rsa-laptop ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm13411048f8f.39.2026.01.07.18.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:05:35 -0800 (PST)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [RFC PATCH 1/1] net: wwan: core: explicit WWAN device reference counting
Date: Thu,  8 Jan 2026 04:05:18 +0200
Message-ID: <20260108020518.27086-2-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108020518.27086-1-ryazanov.s.a@gmail.com>
References: <63fddbfb.60e7.19b975c40ea.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need information about existing WWAN device children since we remove
the device after removing the last child. Previously, we tracked users
implicitly by checking whether ops was registered and existence of a
child device of the wwan_class class. Upcoming GNSS (NMEA) port type
support breaks this approach by introducing a child device of the
gnss_class class.

And a modem driver can easily trigger a kernel Oops by removing regular
(e.g., MBIM, AT) ports first and then removing a GNSS port. The WWAN
device will be unregistered on removal of a last regular WWAN port. And
subsequent GNSS port removal will cause NULL pointer dereference in
simple_recursive_removal().

In order to support ports of classes other than wwan_class, switch to
explicit references counting. Introduce a dedicated counter to the WWAN
device struct, increment it on every wwan_create_dev() call, decrement
on wwan_remove_dev(), and actually unregister the WWAN device when there
are no more references.

Run tested with wwan_hwsim with NMEA support patches applied and
different port removing sequences.

Reported-by: Daniele Palmas <dnlplm@gmail.com>
Closes: https://lore.kernel.org/netdev/CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fecK1vnrghjG_e9UaRA@mail.gmail.com/
Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ade8bbffc93e..d24f7b2b435b 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -42,6 +42,9 @@ static struct dentry *wwan_debugfs_dir;
  * struct wwan_device - The structure that defines a WWAN device
  *
  * @id: WWAN device unique ID.
+ * @refcount: Reference count of this WWAN device. When this refcount reaches
+ * zero, the device is deleted. NB: access is protected by global
+ * wwan_register_lock mutex.
  * @dev: Underlying device.
  * @ops: wwan device ops
  * @ops_ctxt: context to pass to ops
@@ -49,6 +52,7 @@ static struct dentry *wwan_debugfs_dir;
  */
 struct wwan_device {
 	unsigned int id;
+	unsigned int refcount;
 	struct device dev;
 	const struct wwan_ops *ops;
 	void *ops_ctxt;
@@ -222,8 +226,10 @@ static struct wwan_device *wwan_create_dev(struct device *parent)
 
 	/* If wwandev already exists, return it */
 	wwandev = wwan_dev_get_by_parent(parent);
-	if (!IS_ERR(wwandev))
+	if (!IS_ERR(wwandev)) {
+		wwandev->refcount++;
 		goto done_unlock;
+	}
 
 	id = ida_alloc(&wwan_dev_ids, GFP_KERNEL);
 	if (id < 0) {
@@ -242,6 +248,7 @@ static struct wwan_device *wwan_create_dev(struct device *parent)
 	wwandev->dev.class = &wwan_class;
 	wwandev->dev.type = &wwan_dev_type;
 	wwandev->id = id;
+	wwandev->refcount = 1;
 	dev_set_name(&wwandev->dev, "wwan%d", wwandev->id);
 
 	err = device_register(&wwandev->dev);
@@ -263,30 +270,12 @@ static struct wwan_device *wwan_create_dev(struct device *parent)
 	return wwandev;
 }
 
-static int is_wwan_child(struct device *dev, void *data)
-{
-	return dev->class == &wwan_class;
-}
-
 static void wwan_remove_dev(struct wwan_device *wwandev)
 {
-	int ret;
-
 	/* Prevent concurrent picking from wwan_create_dev */
 	mutex_lock(&wwan_register_lock);
 
-	/* WWAN device is created and registered (get+add) along with its first
-	 * child port, and subsequent port registrations only grab a reference
-	 * (get). The WWAN device must then be unregistered (del+put) along with
-	 * its last port, and reference simply dropped (put) otherwise. In the
-	 * same fashion, we must not unregister it when the ops are still there.
-	 */
-	if (wwandev->ops)
-		ret = 1;
-	else
-		ret = device_for_each_child(&wwandev->dev, NULL, is_wwan_child);
-
-	if (!ret) {
+	if (--wwandev->refcount == 0) {
 #ifdef CONFIG_WWAN_DEBUGFS
 		debugfs_remove_recursive(wwandev->debugfs_dir);
 #endif
-- 
2.52.0


