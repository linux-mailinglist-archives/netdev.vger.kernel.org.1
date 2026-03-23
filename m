Return-Path: <netdev+bounces-270344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MisC3ydwGnrJAQAu9opvQ
	(envelope-from <netdev+bounces-270344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:55:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8432EBA9C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1C2530041C6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B840223DFB;
	Mon, 23 Mar 2026 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqZ8DMpb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2221222565
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230896; cv=none; b=VBhFxHetwusR9rwFSkINEYdYW9HAPNWbjwZ4010YdrwB9+Vpj9CtCSrzsv1EJJD+mabBg9nEuPBVWfIAh5zhVbmwX5hUiZa+ZBaNQDud9hVS9Mj6tWdcUrs0NMAQL89QnQRN1X9w9GC10ugjbBor2iTplWu51ylSRzzEZfkVWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230896; c=relaxed/simple;
	bh=RqL0mTRKkF4hWJurWBewRbPofeTnIMHQam2gd97mUZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOj1VCEBxmKkCweR0srpRa2WQUM9qlY5H+iNXuyCSI3nZCPe5tvFd0KO40RgIdVbImDmHjbDh6+tHfrvTiZ5SdnDt8xwbQqMRfNrQ9lf+IbjP/xLbM9/eOSf3LajFsUpR3ahmj76jKou4UCNWdvxN+oPN76J0Pbmi2n9x1HpztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqZ8DMpb; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c107ef474fso4398381eec.0
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 18:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230889; x=1774835689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQXLY86FxuKQON46KYMFrgiDaURA8SjvslLPqZRssqU=;
        b=RqZ8DMpbb0X5i5GNOEDtrcW3mRPokgfUOj+UjicWP2+P9aSKtHV1EpNICz9hjPr3Tk
         iyi/IWrJ25Koh2vjxA4VysTebsPVDPyB6DW24mihHcF+yHhq/fg74y722ODqj3RxrMjm
         jc/+N41+4+VXaukA/ZQCtSesjuB/buuj4RkpKh0OzAGpfP3Yx9FrbLdcRngwsAjQwii9
         w9+Urz5kDN9jJaQ1Zdugxr+oqbhvVwRH49BQLayYGY7Uk/8XpnbFdU5dJ2A7o8k8HdWZ
         m6vETI6scTyc4cZoUQRltOG4+c73fsDqQwQFt/ZXfL7ugewKbGA7Erx51Ta3jzkyaAME
         2Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230889; x=1774835689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xQXLY86FxuKQON46KYMFrgiDaURA8SjvslLPqZRssqU=;
        b=o0kqXAGlaabuhp6+z1wSoF43kwdwwijbtZCqXuo2a8hGL+6su7eKgLk7yOLBSCoMPR
         8LDh4TPF41Jig07QnKv/belmElsJnk4Vfxo+QYDi+IXmp4LM8YyJPprza/FWntwc0AZz
         MjgbHkoyqWvkYiFIydIw2LQQPfL3qmgqt8KIuBiTkFCjni6XHKv+s1b0GduVofOaC1oy
         ju/St3jDw9BD204en1H+gYaiNSdt+Kivk4h6l5FlCpv0JJSiZnNP0qg9nGrW+B85s2c8
         3cgoubfTmRWSneVZJSShZnEVMqKTy8oSk1WIA2fbf+YKiVjR0NkmV/BEPPy2lWekMdgy
         3myA==
X-Gm-Message-State: AOJu0Yyy16xaz5z12PdUx63ARD1z1bO//9x1akGlQGMu1cDrtSBaUvAT
	nfWdP7XA9s9UmmYYosIUpTVKVOcttGppfKJKnCnDC6UrPvDv0o/dCHeV
X-Gm-Gg: ATEYQzyuffHDCuPpIyKCaso8ppjzmRKOHIJEexifi1klnDAPNBVScqkzbG/QyvVGRAC
	TkI5kd3Af6LvNHZkBxT0vU39NgAdxDmhg/bzNu7W6UKpa5Pmoqk2ygCIvmsD8r3Bi7movgkqzlc
	8q72ZW+yKF2WKhmf/eMyslPnoHAJdVHGWeRXDqeLtK4hSKDnCUEAZQZLbRN9tXroYjmBQgO5i6w
	SD4T/QP55DaLWRrt7LugTx/clQTR+x9Rggzvcw/IC3DHAbTt30Ey8WzwPuLIhPV930qeENbCSgA
	7L/UeU51iNXqcPHyOuGK0t/4hejGmVNbNLcsko2nt1OWTix+gcEc3SI+d9WduoEkSzdviJEesKt
	C8+xTBjMKW1lnquQaLpM+m0lBnwmH7DjhiTRDiFx1ImRhHYD0IcTh8N2ChwfI241jj4XuxZfwJ9
	ykokwyrM2NP6Sg76OUh2LcaKuGqwhwIU+zUtGLtrWNYS97OyprF83lG6dnT8rScBNqFv1GG1Bbs
	vQ/bR9abZGNuTs=
X-Received: by 2002:a05:7300:572a:b0:2c0:bd6f:42a3 with SMTP id 5a478bee46e88-2c10974f0d6mr5302324eec.22.1774230888985;
        Sun, 22 Mar 2026 18:54:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:47 -0700 (PDT)
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
Subject: [PATCH 05/10] leds: led-class: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:23 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-5-b72eb22a1215@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270344-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,gmail.com,axentia.se,armlinux.org.uk,intel.com,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: BA8432EBA9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation to class_find_device_by_of_node() going away switch to
using class_find_device_by_fwnode().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/leds/led-class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index d34a19453560..8d7ec9ccb173 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -273,7 +273,7 @@ static struct led_classdev *of_led_get(struct device_node *np, int index,
 	if (!led_node)
 		return ERR_PTR(-ENOENT);
 
-	led_dev = class_find_device_by_of_node(&leds_class, led_node);
+	led_dev = class_find_device_by_fwnode(&leds_class, of_fwnode_handle(led_node));
 	of_node_put(led_node);
 
 	return led_module_get(led_dev);

-- 
2.53.0.959.g497ff81fa9-goog


