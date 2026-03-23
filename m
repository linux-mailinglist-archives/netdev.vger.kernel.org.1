Return-Path: <netdev+bounces-270343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHoLJJKdwGnrJAQAu9opvQ
	(envelope-from <netdev+bounces-270343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:55:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0CE2EBAA5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4004A301629E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46609221FD4;
	Mon, 23 Mar 2026 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK1KsAcb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79821FF2A
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230894; cv=none; b=gFIXEekTXuBwSNATF9/j5v1uOkLntn9Oj+ahYFmHOj+nkU9zE7Qosq3Es3Qij41Rzw+ldCSlVXcwBZB567AT7kQP//RAX7BKE8ueYAAck6m8du1Leb92o/CWqRaVDqC84MGzvy5a+ZFe6l1dXUZc8CB4kR2sIc624PyTXd3v5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230894; c=relaxed/simple;
	bh=vhx5QpoROnyh2q914MrL5geRu8AVJM0r0udOxsoTw6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2hHLq3qn2v/nEP6il+KRjbWsFK7UsKuUuo845RGIPqXeJCm6T93bxydTtK8snHNDgz8UDVCHb3yrlUPdWkmdQj8lt5sHtVq90njC3eIunxSzSzdbNbt7P1T8rQN1qJNWA8x8A0Xguyw+ElvsuY8d/dcEIeeFrinrbLyJOpgc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK1KsAcb; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12a80c36350so773278c88.1
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 18:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230884; x=1774835684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFZooOyb7hfKDEpM9yx+Ztfv9BY6tuw4luVBl13uVrY=;
        b=VK1KsAcbFk0ksbY+/+vt6XBw+4QjtQuHRNv2SEHPfOltUX5iNis2R33+Du5wZHsRqr
         WrIvRasmCEwSh7fqmeugCo6feE8XtxjYVAWVs/aJTax+83KN+3yRpRiZCmHHN41kGc2E
         76E2GGvW0zof2A8SVr/BVlPkGidLkiOUt0hgfTa+VgwSDTvrIJY6IurRqy40KFb+FtEB
         wko5608F7xyI/q7h8A/GWDyJCZ0HJ7yB298qb2dIQbetqQ8w+Pcud+IFZJPxpS6mn9WL
         8sIGtXhR2VICewq97fNB6oQcilgCg1aGpsGvaPbSi+wk7JHrmVt562VfDZYB8cq9XLjF
         K0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230884; x=1774835684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hFZooOyb7hfKDEpM9yx+Ztfv9BY6tuw4luVBl13uVrY=;
        b=bmpwibICyY/Nguw/fkwfTgKwiI2R0sUU1sc0bV6ImFbi2W6Wi5V8rhNC3nY2zKEP3K
         0qZdU3uP/dxTsC0RRio+GDLFw8r8GhIcs2AZa/3BR686za3ol0Bm8TOPJsEu1LZycZCl
         6XI9cPyIAfQaIWHL5gG4fpbHdho8KQzWqSvspaS/XiWC7ND51ngZVNLMw9SfV3dP+dp5
         84IgtX5Lf0SO3pMHE7dM3ipGR06x3UN5youp96PEF6IHzPwOb9lo5GfrJ8dNP2f5Hstl
         cP6odV6vbsghaTFOB9T2LSNhM+8wjXUvqu5o6f29vt2ndyLwiCmtOiBrZGeT6Kjz3Q3s
         qpfw==
X-Gm-Message-State: AOJu0YwiMGQa7CDDgCgskASqpnjvEnPv3kD7NIqYfwM3Bv1dwjzx/MRE
	Uec5PbXZWIRNrkSqhR2EEDjHMtPL5ZfXJqYbZi8/XTU4pBOgXlkVKNbO
X-Gm-Gg: ATEYQzxKOkv/ly5zmWMEv+N7q8klWE4LPS5tLcfjFJre+LoPIbVetj+HPXfQA3Ozusm
	v8jtkfATyV9NT2vfznPcDMB87AMr1VdT2TEwazEikQ2SLaj4tVQJkSbzCjhLtxL+ckmNteap9e7
	04ZghxSX3B7hll4V4FiL0uloshucfGpp1WqWT+oi57X1GIiNivWJ85tD80u1G29F9TvlxoipNyc
	BOwhVGoIdk0+QfukQNsWz+gJMj4iAGWzZCtb2MO+Mv89E3P60sWyu7ZB/IIALgBhA//3/Dr523b
	OBk3rO72BS1JgT9VSbWryiH/18VI3RDcPoF9jEyBXv7Bx9b+Q8cnsiDXj30mK8HEyRDJl1l6bwz
	H4SAMvOUyGetBmzo2PEfm9L2dbzs/Lsi8nu6em2CMs0J9xTIm6ZPZL5wFuQ9qGafVkf8VYzrEL/
	rAytwK04xC+IjCH+rKXP813sm4x7CcsZ7p0VvlC9a7jt15jlWkjcDQL9vohOS0gmI3+BELu9p3u
	VLHFW+btAwpcgw=
X-Received: by 2002:a05:7300:d517:b0:2be:1cb2:3a6 with SMTP id 5a478bee46e88-2c10980a523mr4129993eec.33.1774230883846;
        Sun, 22 Mar 2026 18:54:43 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:43 -0700 (PDT)
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
Subject: [PATCH 03/10] spi: switch to using class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:21 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-3-b72eb22a1215@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270343-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,gmail.com,axentia.se,armlinux.org.uk,intel.com,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 2B0CE2EBAA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation to class_find_device_by_of_node() going away switch to
using class_find_device_by_fwnode().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/spi/spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bf1df365f795..071a9ffdb59d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -21,6 +21,7 @@
 #include <linux/kthread.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/percpu.h>
@@ -4948,11 +4949,12 @@ EXPORT_SYMBOL_GPL(spi_write_then_read);
 /* The spi controllers are not using spi_bus, so we find it with another way */
 struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 {
+	struct fwnode_handle *fwnode = of_fwnode_handle(node);
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(&spi_controller_class, node);
+	dev = class_find_device_by_fwnode(&spi_controller_class, fwnode);
 	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
-		dev = class_find_device_by_of_node(&spi_target_class, node);
+		dev = class_find_device_by_fwnode(&spi_target_class, fwnode);
 	if (!dev)
 		return NULL;
 

-- 
2.53.0.959.g497ff81fa9-goog


