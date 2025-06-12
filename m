Return-Path: <netdev+bounces-196842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E042CAD6B02
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093EF1BC3B0F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D718225776;
	Thu, 12 Jun 2025 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXllOk3a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9C223714;
	Thu, 12 Jun 2025 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717476; cv=none; b=n2OIS5bLpz2fnu79dCZHP0pSRCEv+y7Tn7H212cVnkiUSJDvJOjkJqtRTNNKOowlYsibvZ4/9hsISk7mToTSdL3g07UzmoeTVrILrPA6lyXfPm7CVLO8K11KpqNX9akdqpTawCb55dLhHKGAftLzSH+kDTzj4t8VWcrcLB5NlIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717476; c=relaxed/simple;
	bh=3lcRTCoK6helibVxRxtuZ0AhUgecBUU/DefGsWxslBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+RIcf6wwOFik7uWBykFaJNft2lUxeDDorKz1rQikMusrNqNsU38wdt9haTmjuwrSbZtZhtNAZXB4QGxYVlSbvGXuA2Erw3ir4+pJZ4x5nDjxkjcPM7GzgTy3003WhqeedBJP5buq8ljQcade0NHWx69qMYo676F/Xp20sF+nB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXllOk3a; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a35c894313so632717f8f.2;
        Thu, 12 Jun 2025 01:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717472; x=1750322272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnz1Aho6mg87+r/pdfq+KytTWdWFTN3tXlweDvzapkY=;
        b=SXllOk3axJnhh4tK2aO48MjVR9DK/GOhiI4X52zdSlrdiXo/7EKlamLHwCtMuqgCTP
         Ooqh3YCeA94jxfjDDo3+LX7mCA37uyMIZqCD2ttNtDNUM2edgjZ4f2eXK9C/vo1K4O5h
         H01M/g3/zKXWQnTworKLl/429H8WyyqA/QFPcc50B3mRM7QQpO6tbL+2LZGAFXFGMPUG
         qgD819GFlzOmvuk9dcsEfbMN9keLRTEdvalbAqm7w3Hp81VclQeRtiplgfUv4wcoEifo
         wDIPADPUV40CBP8eN/8hZeWNMl8bWvBGboGp4faHjivj95F7ZDpAS26q1Gy2uXRMls4/
         lRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717472; x=1750322272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnz1Aho6mg87+r/pdfq+KytTWdWFTN3tXlweDvzapkY=;
        b=JLNQs2ih82bhYkBHj/2fAPW6eDJPJG1fLfACygLX9be7o8X61lbkdyxqgQ6cR9LVPv
         QvUk5LUgesCPl/5zRrYizi007OaiN9mnbZzQzPj1oSNQfiFaGUr1qiwHR1DwnO3e1ZkH
         R9Gbj9CvhXspi2wPBOZ+IIL6HREAeay94UXfCxz+RxYjJkeocVCE8x5Vm/CwQgUcD2hx
         Mi+i/T5fMRjysnRiH8phoLV2XgFrY0sWJCQCJGpwOKhUjp1FmI+jJ+sWlIMbV3FUZWyv
         H8kfOtW62abAsneMlKCbd8bXaUxMFLui5GooVS98c5o0uxsKw5+UBGzA7etSRCFFqDJS
         cTgg==
X-Forwarded-Encrypted: i=1; AJvYcCUDwUNuhLgS9b37uXyMb/mPo0U7A9d72mYGqATHLo2sWjVsGxMe7cQvOMDWzai599grdP9eqTkC@vger.kernel.org, AJvYcCWUBkF341i5pfRHqFECqilVtTGI2RRHVpF/vzpUZz0BzuW1vSohzDWUrUnW5LhMd8p6K3jM2/7oNo3NK4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YybYTmpcgMdL5qqJyPqFq9sAmlJ2SjNl6j9j4oO4E9DNB1nLQ9J
	lmjJqNV2fPLxEDl00GBsqPV/x3C9vfF9LoPx+ylenyDp2b+cwH1mIYFw
X-Gm-Gg: ASbGncs9wAjLtYOTqemPTwcPtTCq1CC8seSigbvzQbilWAICwWlvki9a+iQIZ96z4Ji
	s15z4QYGC8+BjcxNi0UbdoINeGGJ1nfJNEs/VmXfCf9AgOGcDMaAaVbtDyLWUB2rR4SFhCfms1E
	V0wits2BhOsvI6i0PgsHtS9PdTFryJxwJEJ1Yux7ow7ieCuMGq2rTqqOs4Yfm0flCsT+0j9O0b6
	p1dQ0v3FovR4eXn7OHGqWP+w0uvAx4ZCP30PAQx2hoP2tT4RDXgib1XWDkM3cvhtiHfGlLRWLeF
	yU5xm1cl4Nh/ZKEdMhmw5QMP/gMpYix/LdX7qmmyo3FMf68fXqAJu/zAZCGjUhY8xYggMBNk4Oz
	/hZ3PNfR9wBEeqBL0izjKNpRPaZZn+rvy9lGBZ+i1rS09EcWxPxehro4z7kYKd/qPo1QmBwajg0
	LGfxTh/lruiOWY
X-Google-Smtp-Source: AGHT+IEUJMADr4QGe11F8djL/zJ1nou0mzkg74o4ndABompJbu6leVbZKQ9lsSEeWKJtUzwq/evIyw==
X-Received: by 2002:a05:6000:2308:b0:3a4:d79a:35a6 with SMTP id ffacd0b85a97d-3a56127854dmr1630440f8f.14.1749717472346;
        Thu, 12 Jun 2025 01:37:52 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:37:51 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v3 03/14] net: dsa: b53: support legacy FCS tags
Date: Thu, 12 Jun 2025 10:37:36 +0200
Message-Id: <20250612083747.26531-4-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 46c5176c586c ("net: dsa: b53: support legacy tags") introduced
support for legacy tags, but it turns out that BCM5325 and BCM5365
switches require the original FCS value and length, so they have to be
treated differently.

Fixes: 46c5176c586c ("net: dsa: b53: support legacy tags")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/Kconfig      | 1 +
 drivers/net/dsa/b53/b53_common.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

 v3: no changes

 v2: no changes

diff --git a/drivers/net/dsa/b53/Kconfig b/drivers/net/dsa/b53/Kconfig
index ebaa4a80d5444..915008e8eff53 100644
--- a/drivers/net/dsa/b53/Kconfig
+++ b/drivers/net/dsa/b53/Kconfig
@@ -5,6 +5,7 @@ menuconfig B53
 	select NET_DSA_TAG_NONE
 	select NET_DSA_TAG_BRCM
 	select NET_DSA_TAG_BRCM_LEGACY
+	select NET_DSA_TAG_BRCM_LEGACY_FCS
 	select NET_DSA_TAG_BRCM_PREPEND
 	help
 	  This driver adds support for Broadcom managed switch chips. It supports
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 862bdccb74397..222107223d109 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2245,8 +2245,11 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
 		goto out;
 	}
 
-	/* Older models require a different 6 byte tag */
-	if (is5325(dev) || is5365(dev) || is63xx(dev)) {
+	/* Older models require different 6 byte tags */
+	if (is5325(dev) || is5365(dev)) {
+		dev->tag_protocol = DSA_TAG_PROTO_BRCM_LEGACY_FCS;
+		goto out;
+	} else if (is63xx(dev)) {
 		dev->tag_protocol = DSA_TAG_PROTO_BRCM_LEGACY;
 		goto out;
 	}
-- 
2.39.5


