Return-Path: <netdev+bounces-216202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7592AB327E6
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 11:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF29C685B05
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 09:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AD3238C0A;
	Sat, 23 Aug 2025 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqD2vk/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE71A9FB9;
	Sat, 23 Aug 2025 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755939997; cv=none; b=DApuELP5C0XJj6BrwsKw2/lTIBeXzQ6PPl50jMa1/8TKIeciYo+x8/yYDMWspPxRzMZ6zLj4dWBZxIb0PihYEwjSNX8s4I0HamdRUJKxpdeftqOsePa3PwdEXHbUWmiqrECk3Tntfd6EzvrPbtnVpstBhycqhZ0n9zEaDwe9Yyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755939997; c=relaxed/simple;
	bh=qYHz7RGWqHQbMsXb55U+KPH+NaSz1JOHrq0bnpnBaHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYvDBrxK4QP7tPqROH+qjtdjuFDZ+OD5gTne96F9zODAPoJKXtMJlfBBGn2Ba/PAKzBpESWY+vbgFJ5duPsYA3RiMZIGQD8Fczb4ABewBCcFWOWm51uXSmczOLDhxxGdFDdqmuwrEHkE55w6h/M+CpkJbV4cvtMbUqy5H/HrelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqD2vk/h; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78fb04cso383182166b.1;
        Sat, 23 Aug 2025 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755939994; x=1756544794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FmJmWx0DAk+hGzcYT5+wTZzSsQqxJwu6ekfF9Qdad9A=;
        b=eqD2vk/hnct2ydtwwLo6vi9yEiAdmXqtP98ANXtqf7h9enzPEOz307SDlFI8tsDgWS
         q9EPZ+vT7wDY8X4s18kQnumRZEuXkSxM1v7BTSq8KViXSHMKNP6RDMn9+kmdWmjoEwGX
         sdptWHnoFgcG1F54yTpfiDWfW/rs2NGs+33x571q3Ufqutvv9FM19PSrEEyhWVqRk22n
         Ub6ZrjcF+0ZTqTnmyWLSvO288N5oY5AjMyeY1KNzKeljGjzEWcwjzmc8CotgRFwRRA4r
         tmzRD4iF1UGE4Nh4b03KVnOJKeqCiuWUpAU5vGUdRZ7D4trDRCv4lTjU5oyicOYnQt89
         4sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755939994; x=1756544794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmJmWx0DAk+hGzcYT5+wTZzSsQqxJwu6ekfF9Qdad9A=;
        b=OFUVgUUEQoobPVwuqGM2w6yqqNBIjHQvBNoOMRdCqgBHsLsy+98Mn/X/ixt/t8m7bh
         7m6v4tbPhcWELQleedX3jeoDbCuKj6qGf4N0uOqAiHsqZsXPPscvD8B5EwQTHMrKjSDi
         e1bs90AvmivRRLtbICtaMjno5fFhdokIl+qQlVUC8zslTMFJl/eyjByyQmTi83zTZGMY
         0r3aqJxrGhXSs23k5wmylUlKfUL+wQn3tDfjJXJM/9XVbRoqiH2mqU0hZ0kX95Q5rMpM
         UaQakgw3EDYYyuSlsbXcXoWMeQM1vmJyATeoHHzLpxsSkf48yIagBxT8J4XpTl9OYg1/
         6qqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmRPc75EHuSpVvWP5SqkxzIcQyzCzM0ac8wE3gzYO1ENl2ozYrIPycRojbO+v8+ONwIXwPoUkrlp9V0mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyFAQoXgFE2uwVMSZJAMOj8K8Qk8iNYfrfvVaeYBU9p8EoO6La
	co7fP9HsjU+WM259uEh64kIASM2w0f12Iq9Wk5TPWHei6clxawbp004U
X-Gm-Gg: ASbGncvgaX82csBDrg6VfIJmWEeKijsFO0AiwCs6hnUuS/cl4nImHIkVHtEXzwpKdOA
	66cDw05LWWGb9EyRZR75i1ThZ9yddTngDJdzZrp6QQJjAufVe4Q9/c2WIVFzUhgF757CBT9iGbY
	GlWkU/E69qJKUVC5jFC86znKSfLaHHbYffxlQKEZe37hU57pKDwVqnCemRXiE17X2pRDxwoT7i4
	etVKHWBjoQ1HKbVI9z7BjC+STqOykSS0oMO9Ca+cASNptkKsIlTjaVfvftD1WqpA+bax4aI/7Yz
	v8fVWkFguK+nOR6c9eDEqDT+B9zmmqLSvJVHtNqwci03KOhBJqAlt0Xw74dGfd6QTv1aKu/Z/Dx
	7OulyALsvOiqvIapBYbP0cGZfOMPNoNnkoaVrrw2Wt8aaJGVUnmXj09rZ10mH2e8CXbNxB2bF4W
	CRa1l6pTsRfnsT
X-Google-Smtp-Source: AGHT+IHthF7+Z6tDYBK7vk8ZYlfLxXUztPbzWF1S9xXsI6UVd6WbTDRlcV08HFp7HETOH8bQMU0Vng==
X-Received: by 2002:a17:906:f584:b0:ae0:c7b4:b797 with SMTP id a640c23a62f3a-afe2963b058mr488047366b.45.1755939994195;
        Sat, 23 Aug 2025 02:06:34 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49310d7csm134947566b.83.2025.08.23.02.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 02:06:33 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonas Gorski <jonas.gorski@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: b53: fix ageing time for BCM53101
Date: Sat, 23 Aug 2025 11:06:16 +0200
Message-ID: <20250823090617.15329-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some reason Broadcom decided that BCM53101 uses 0.5s increments for
the ageing time register, but kept the field width the same [1]. Due to
this, the actual ageing time was always half of what was configured.

Fix this by adapting the limits and value calculation for BCM53101.

[1] https://github.com/Broadcom-Network-Switching-Software/OpenMDK/blob/master/cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h#L28966

Fixes: e39d14a760c0 ("net: dsa: b53: implement setting ageing time")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Lacking matching hardware, this is only run-tested on non-matching
(BCM53115).

 drivers/net/dsa/b53/b53_common.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 829b1f087e9e..b85ca17e8fdd 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1273,9 +1273,16 @@ static int b53_setup(struct dsa_switch *ds)
 	 */
 	ds->untag_vlan_aware_bridge_pvid = true;
 
-	/* Ageing time is set in seconds */
-	ds->ageing_time_min = 1 * 1000;
-	ds->ageing_time_max = AGE_TIME_MAX * 1000;
+
+	if (dev->chip_id == BCM53101_DEVICE_ID) {
+		/* BCM53101 uses 0.5 second increments */
+		ds->ageing_time_min = 1 * 500;
+		ds->ageing_time_max = AGE_TIME_MAX * 500;
+	} else {
+		/* Everything else uses 1 second increments */
+		ds->ageing_time_min = 1 * 1000;
+		ds->ageing_time_max = AGE_TIME_MAX * 1000;
+	}
 
 	ret = b53_reset_switch(dev);
 	if (ret) {
@@ -2559,7 +2566,10 @@ int b53_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	else
 		reg = B53_AGING_TIME_CONTROL;
 
-	atc = DIV_ROUND_CLOSEST(msecs, 1000);
+	if (dev->chip_id == BCM53101_DEVICE_ID)
+		atc = DIV_ROUND_CLOSEST(msecs, 500);
+	else
+		atc = DIV_ROUND_CLOSEST(msecs, 1000);
 
 	if (!is5325(dev) && !is5365(dev))
 		atc |= AGE_CHANGE;

base-commit: ec79003c5f9d2c7f9576fc69b8dbda80305cbe3a
-- 
2.43.0


