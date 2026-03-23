Return-Path: <netdev+bounces-270349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKQoOtGewGnrJAQAu9opvQ
	(envelope-from <netdev+bounces-270349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 03:00:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1052EBC61
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 03:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7E01305D6F8
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3EE23A561;
	Mon, 23 Mar 2026 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGsqHg9u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533822157B
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230906; cv=none; b=cMH6zlsYOaB2C+Ix9slt3WUhjrfkC2POih1eZ0PxXvtDo2Ju1+ANIPNtEslC5ZmDnijgN1jCwjUqDGWi6NbGLNDeQWNua7PEj3L6us0o01uZYTBUJ6d7giObU6gt6joFLmG7/yS5Y8Qq4vX+fGV3Suub9GLeaLh3TJKbgqLHEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230906; c=relaxed/simple;
	bh=oa2EwaUUG59FtphzeTYHy1LbWnpif4xM00zY4CiwrfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNOzQn5b/EWdRZ0QkKVa2lPmFKiz/0UmFE/FsSYiEZxR3uubVJ9mINTHG4YC16zsph6YgJOECsfa5LSjDyeA4lWlKezepig0I1mqXnlHqfBqpihEYFnf6kpYxaD+hyxioZqIkxhrGX2qrDFvh8bHxj9+R57r9SZvbe1qbFxmdpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGsqHg9u; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3471412eec.1
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 18:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230900; x=1774835700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBYbOsFewxAK/zyXErJyI2wWdOZnO5pIFOiKOKYi888=;
        b=DGsqHg9u8PZBheqZmCbwCygye4QFZ5ls7ZTjLNcDdLc8lNWsLUAb7+azOoGrE2fxsZ
         pirnDYbzR3NgIV3X8c7NDwwT3bxsIalIYolIyIkEEVthhG4uEbhiwSJsF4LQoRqBsjWt
         NcPXkgrxG6p8YnvyQOQHlZiJfDqBZvFiNhUbSzVyanppF9lwjCwF37UDljU+sho4aXdc
         kA1QVEc5rNVpmEbfjh4WITCnjpp8qF0r2pOO47PSRdqVjeKbivsv7cOYAzTNJuix2XbZ
         MZmVcH/ZGGbzlAfOMtW1PWao0skp1Z40jqbSpnhHqzzjDYHyjwK+yDjQujbW4A4oNgSV
         dq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230900; x=1774835700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uBYbOsFewxAK/zyXErJyI2wWdOZnO5pIFOiKOKYi888=;
        b=P7hF+DpyWT4lizB3FcupSIpwOtk4K+wK5kRSNCRIA3jHt4d7u78LrLp+ddh7HS8eu7
         b/+3N2Xy0MHL43xN6IsMxk/UwdqNEgGBI1rEEj0ccEyMntKxjG1dZfR2XPZgGWTjtjiM
         ic4RnzEOUzDYngzLdY2n+kkmEt7Pkjst8w5TpBjeUZQC5MDdy4XsjXYzxHjUne2Vkwk+
         8ClfIBqJu3GUmF6GxpBLzms3JsZVnQJN2zN8ISrYFRO9uIEZ/VoWKopXE6DM5XhmUOYV
         G3H1KV8tycdyNRo5XhbwNwiem93+rzlWe1LDLXgwo8Ttk8e0jnvodu8UKjcFJs1j31Dg
         pnGw==
X-Gm-Message-State: AOJu0YwK/gn/IEr0Z3H3pR9FK1O97CJbxK+tqod5FOgFPtc9yxvXQb3d
	FomN9NDgqle++06rnqzJOUZRpyfqlN3OzI1eDfa/QH66FRUObYuIIw/u
X-Gm-Gg: ATEYQzzXFu6Mcpt6WCTuanfpioQvgPSRJ/390xbB4z8tELCmPcFMY9NTtG62uARrQye
	d2xyowRZck1xObtJkp3zoL2B6zyYI2V2+WAFDEYnl1zRQjFmEfWS5Hh5pL6oFzrNv3V/4t5JnOQ
	8mtSH0X8ljx0qsosRs0XsATGH93FRdvc2YrUDkFMldDezuDa+3dUwSXfsLPhJrDYUDIDpHkUEZH
	vqWPr898TQYs2WIA8Pmljy30Z5SMz9Vny3xffH4ADm9b/Fb0jFRsspXKUPDRMtObEQp4a5CmAxb
	u18B8DrjsNYPoGPJcy4jsFyuIiELeqIxDT6iLIT4lBj3DiIwzJAQ9/Sprw4T+D49bHLAlgrmkgT
	LiO7BdZieMlkGjytV5BckV5fvrKZE9O47TUPzX1Z42iSeEIVirgQm9tZIftFdAAc8XZ4OhxVbGn
	tYtXhutTwgkIl4p+rSNZd5i7M3OSngw5azJALFXFnjU7t/GrEJ4XekAbc9dv2KKeer5JK9zNcHO
	NVfDjxTvu/CrY0=
X-Received: by 2002:a05:693c:2b06:b0:2bd:c8a2:954 with SMTP id 5a478bee46e88-2c1097b8ae8mr5509864eec.24.1774230900153;
        Sun, 22 Mar 2026 18:55:00 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:59 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH 09/10] fpga: manager: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:27 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-9-b72eb22a1215@gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
In-Reply-To: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6826
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270349-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,gmail.com,axentia.se,armlinux.org.uk,intel.com,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4F1052EBC61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation to class_find_device_by_of_node() going away switch to
using class_find_device_by_fwnode().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/fpga/fpga-mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 2672070ced02..1e7585a4608a 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -716,7 +716,8 @@ struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 	struct fpga_manager *mgr;
 	struct device *mgr_dev;
 
-	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
+	mgr_dev = class_find_device_by_fwnode(&fpga_mgr_class,
+					      of_fwnode_handle(node));
 	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 

-- 
2.53.0.959.g497ff81fa9-goog


