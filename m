Return-Path: <netdev+bounces-270342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFcgGSaewGk0JQQAu9opvQ
	(envelope-from <netdev+bounces-270342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:57:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C601F2EBBA3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0DD5303FF10
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBC9221F1C;
	Mon, 23 Mar 2026 01:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuH0ewt6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA76228CB0
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230891; cv=none; b=e3+TOAiFiuU71aWmuc/YtkRDhonqQiTmFhuM4Vl7l0vVOxEzB8Wy0ji2b79jfFmeJu4MvXKbKiRatvED76oGgv7u0ogCgtJie1+/w0ilAoOw7MqTvowcPSHZqdWnI6/7qPlcAA+HDt4hk4WD3a9PiHj4K0JRxNV5qIZ6zBiM2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230891; c=relaxed/simple;
	bh=xYIn8ABDkpyr0YTUtgQcAiZf9GrzpDD84nxgrE/YbUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6LYDSGthyVraT4njRY+3EDrOoDsXHCjNq94AlYlATqBJXiKzrklYZhs0uqTlKKWqfcytDFEaSxYDhlxyDatNFRlVE7qSuOSNdNXtYGIij2Wa1sRCYPYwvyKukZakzCqFFdyi/81OxwFWFfFs1k583w0HOwSYe0vURZ9ihXSGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuH0ewt6; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c1092cc08cso1024273eec.1
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 18:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230886; x=1774835686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAxXxv6aPc5DTLbEJ2x2im/U0EJHM/Tk3mhYybeVkPQ=;
        b=UuH0ewt6j9doYzRgftaipYEooiTTIkDnwEeL664oX3BBapBISM72bytNNZxMAa4h0v
         smKp+BAMqQWX3Sb+cN3IAx1jyosIzqncLh5td1Q9uOwjBJ90T/rjLttujrT8V1XKlDT0
         uvj2KTy0eGCzCSWlgmzXzSDF+9XDCFr/2FkOqoaayc4xcFv4J3c/r6gV3IwQ5PSTV09M
         pbS+v333WMk01T3Xzm62pIMmp8j1NPCA1fQyT5heASGjKBHsP7b7Hp/aKiugs8PBmfqy
         OkFLzXNcpf8kU0KlAgEoMS1MJ7X8wAWB1uQWR69fdgcEdV3a96R/zx2MHWpHqimVjv5O
         EPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230886; x=1774835686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HAxXxv6aPc5DTLbEJ2x2im/U0EJHM/Tk3mhYybeVkPQ=;
        b=qzLdsk8T6SINYO4CnXarYgXSBzOsqwJ5uHN/vk7ZpJ4ql0CZJG9ZCSCJvRQUVSlKmT
         JmTelYgnTI3MJiIyMhxsfB5rKKXJTw0cH30sweliDz9CDxUOfIc2jzvdcjGilPhzX/V/
         Cy10qhEsN2BzgSYl6lQeO31ivu5oBErDxOUTc5NQqObHHCVGLEghRKSUplgACH3qc3ub
         KmsIpqhuVsXerM1YQhrdxbpK5xJ45/NCHFPELDbBacSoCnZhpndJr6MBmA+T+FGzkhzA
         I5stHBMw4Hp5e+3foJrqy26+K+C2YaV1jty6bvviL0eHIN04hvSBevweIMOmAoZDvlQt
         N5Mg==
X-Gm-Message-State: AOJu0YxGRmp+w0LAaJrPTVqTeQfF4gHx6lS/iYkLxSeRb08tRYM5sLLP
	jP5ippURXjk+Av3u5mbITnncLX0q9F+EDV0e9F0jDbAeJo0oQfmLKFQO
X-Gm-Gg: ATEYQzxAxoP4PjRY+u4XcMaDzIuMPDn/VdlFn9ok9l+NEIQozCU5UyxTwi7cRA7A/Tz
	uCVUA9tZ6lzuMjocO3TOKiN0RX0PhohFeQZNEjo44bCIQ8ttrDTJma5Q0+aP/hyUSttUcp0f2wt
	4M0d6262Y91o4eWCymn8ZZtLvqSoDsBNbnSqZUBdDkCRDOwWNPuCkcmmNpkrifdYYtck+QFLecb
	YqS35dajolDLE7eN18KR8kp8zdaeEITjBBcrULPOZ3Yj55WpT/5MjhaJGXwacESjqKdL1oBfn/u
	1egyUD4wMY/cvBAqIKxZIxgbSdFSLSaB6ZK0WmWJF/pZkI1jeowxqEP37LPRqXSxb/Y9vbSmLuN
	uTwZQLbA/nsmCysnUoa5fpfkYbvXjFWWpkXjnJSidJSGQPfZTHowbopFqOMSIXKJuyoUVPHJ8oZ
	GjInpe0v9L/U4LnDMoZz3VLFRNGFTK3q9d3BZyN4PTs8pIC0vNMHcieqUV6lOpAwVu/hNg+f91y
	7d5dhWsyY+QI3Xl3oSwfOWoGQ==
X-Received: by 2002:a05:7301:3f07:b0:2b8:30b8:58cf with SMTP id 5a478bee46e88-2c1095f867cmr4580068eec.8.1774230885998;
        Sun, 22 Mar 2026 18:54:45 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:45 -0700 (PDT)
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
Subject: [PATCH 04/10] regulator: of: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:22 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270342-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,gmail.com,axentia.se,armlinux.org.uk,intel.com,linuxfoundation.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C601F2EBBA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation to class_find_device_by_of_node() going away switch to
using class_find_device_by_fwnode().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/regulator/of_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index c0cc6cc0afd8..43ec0845c940 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -637,7 +637,7 @@ static struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(&regulator_class, np);
+	dev = class_find_device_by_fwnode(&regulator_class, of_fwnode_handle(np));
 
 	return dev ? dev_to_rdev(dev) : NULL;
 }

-- 
2.53.0.959.g497ff81fa9-goog


