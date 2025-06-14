Return-Path: <netdev+bounces-197721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C14AD9B1C
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B672189F69E
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3D51FCFFB;
	Sat, 14 Jun 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNO6vPYy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648A1F91D6;
	Sat, 14 Jun 2025 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888012; cv=none; b=FjZawOcx/xVPQmmfo0jGMdW8VU6/PKmrJ8eLkhgtoM9jm2RKsHVIallo2Mvitaa4hzSC/iMyS2bUZnzvDszZ2rjqGlaLE43x2n/kIEFv4OEPcnpb7m47YtS+Olf0IQwzG+B9RzooLr7n1lSdbqV4wAFrvErF7hxvXolKSL1wE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888012; c=relaxed/simple;
	bh=AvDSrMYOB+62sI2ATZ8euwTxBDYD8jeVulP2FTqyL5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPer7RhzD+9oHB1IW6mYSTso9yKxK3W3cJa+DWwVYYx5Zwg+Uunh/bd02AasXFSkVHUYyneNy9IFE4POrm3LHDg1Xg0cDOBkdTOaNZmVnh5NRnrfD5u93MsmaGeZKY1HjcljDTnIqYtohoeFSUb7zUn2HPArKs0DKw4KhV2vzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNO6vPYy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so21038815e9.0;
        Sat, 14 Jun 2025 01:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888008; x=1750492808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrO15ejqLeiAShTFCbp2Axq2Bd3inxDFGZkqqeBV+/8=;
        b=TNO6vPYyR4fWTBugwEJOK9Jeu7tD6AsiHWEBUXbHo8NaxANzzdlg83fAkdTLIESopE
         p7yNxq3VA5iZK01uE+RfKzwuQfRe0Ji+I82PLylkj0SmhSM0Xtz4lOmwiNRBvOqTTHZU
         9YCUn5ASg5Q3btmE9XlC3GJN4VfgcYDd+QNlHwPL7SY3nKnWd3s73VsZcAQrt4fOkJTV
         HM0Q2ZwDsdUHNGzYlzVq35iMaFhSkeq3iVXqdaWUIKZ6cpIKDNNPOE0k5KJJQyW0yi6w
         Jh20aINYERJKEbJCAZ+L0ipWBbF90yO82GtHfSVnzv6+/7R87OjvfMkEtqARi7eI1/FO
         SnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888008; x=1750492808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrO15ejqLeiAShTFCbp2Axq2Bd3inxDFGZkqqeBV+/8=;
        b=SkDDzrfjIvtDVhNIonHqOzfrEgWIw5QYhRtucnN9OJP+KFm91JGCVX9PCaYE8gKkVa
         VekvSFpbM3FE3xARMQOX16U60+9yURROl8q16dWBpY6dlqDkCAqBI7qLpFWeAOwOZ0Mi
         BehtKzx9FaN0NSbhNih7y4LmQZsI9PXvWI7QsaLljbYttv6YoQJNEy5fwu5v08RxWVyK
         YNPUKC0lpYNKtdOYKDxfwtsPgWxHselahw9xPyKOFSIf8TR7eCZGOPzqW6W84Zg0O6ml
         LpXC3CKbZZdHAgiOyt1WrYbo9ckHD5Yh39qgbQ2gVODvZE7Tep1476p7QVnc6uXSciKH
         FphQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIgWxefrXhNI1MNrFgD+bHukO2UR4FhtYQORFMuPuhx87cqwqiwjrv9csF5dYxywpkS553MzpK@vger.kernel.org, AJvYcCVy8x7YAeLedsHkpk7fmE7yrk1XYXvpVqJWa2ugWERBDNyLXd5gZBGt6Ueod68lgNT5Pp1aVI4/6oHc+G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGt4O2yZGOROFzTHnEmcGS0Bwdy698uV0WrGnHC+sB5IzCmeW
	SM70tQGLBkYjOVTUSzj97WPGMg9tLix38Qegoz7XJnz3LWGuOHRdo7wr
X-Gm-Gg: ASbGnctWCKWUAOeDfG2BocF2HsCwM+gg3ktZq35RmeW70RGA2JjFpWRGpBahAShbqca
	PJBi2q3O+hkm/ZUc41HQ77nwUlc7Eu1Lup0LM+Xud6CO9sdfVjksT4GiW71SBf8Qhqx8RnYRAkc
	mQyuCnyQLKEp4dA8skIxRCbiignjCrGr1u8M2W5tnCiSGGf9PRNEldU0R9jJmibY0Oqve1GxGsq
	sl1f1727gDYoealwMfiLrGuwXGMMIc6F2W5SrYAgm00bJIwXXU1L0URldsw7KFHlSsbxampKn4U
	p0M8KyZj+4If7oR6hRquXkp3YsfccHffjADqF6fGY3nNDa8iauHidWn8UvEYw6KNeYEBGAd7WxA
	UHAPxoVGgWGQrfSrTwZnFOOHQSmrvVgar6WcH6cXI96fcgbUxQ6d9HYXZ3IENfcE=
X-Google-Smtp-Source: AGHT+IFDxe1RO0oStKqmI4O5/PkufOYYRhxuHZgaGzGLIVDOrZFAQmaXBwfMM0Qy1Uba7dFQcgDSBA==
X-Received: by 2002:a05:600c:3f0c:b0:450:d07e:ee14 with SMTP id 5b1f17b1804b1-4533cb3be4bmr25596685e9.17.1749888008154;
        Sat, 14 Jun 2025 01:00:08 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:07 -0700 (PDT)
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
Subject: [PATCH net-next v4 03/14] net: dsa: b53: support legacy FCS tags
Date: Sat, 14 Jun 2025 09:59:49 +0200
Message-Id: <20250614080000.1884236-4-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
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

 v4: no changes

 v3: no changes

 v2: no changes

diff --git a/drivers/net/dsa/b53/Kconfig b/drivers/net/dsa/b53/Kconfig
index ebaa4a80d544..915008e8eff5 100644
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
index dc2f4adac9bc..9a038992f043 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2241,8 +2241,11 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
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


