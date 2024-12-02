Return-Path: <netdev+bounces-147991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6FF9DFBFC
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D61AB21401
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827D61F9EB0;
	Mon,  2 Dec 2024 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="qKTfOB7j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22311F9A90
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128447; cv=none; b=WxX1zFy1fCTTRa1g1UXaCtHUcLaOa67xcOSzvNEp8nKE3nSEpk/M9O72RXVB2kzox3H2m0MkTEnsV2x5eJ0U6HcB1maDtJk9KJugYWB8bL9kzOOKJez9xrssma924GcU1i/o9QcZKKh+aGnpZ5gwh58Cob56KQq3mkCl/gda4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128447; c=relaxed/simple;
	bh=GhRp7JAn6rcOImHrJCrFQPMHal2W8dEKI12mch1qSdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hvJ6WxgvQgzRviGaNke5LEpwaw4Tv8gh1QkK9sWRWASQdzohL6xhHo3As6jRAoHPx6M9mkjZSf/6cxx7Bb7pVRcmjqOs4RCDvmI39ocnxKSurGn4N8D6DzpDiP9D+7pc5Rj6W90Zy+50YEZPS/l7h6RKZP4NVJ8SnAtBoQgAoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=qKTfOB7j; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53df67d6659so5633136e87.3
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 00:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733128444; x=1733733244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QzUuqdFRJBTOc5WUYdPFncGjQZclBe0xdjO8DYZWI9w=;
        b=qKTfOB7jYgFomvnPYrrdm2w1osEZOKYa/AHR9WhFRHb/BlK+XJu/Il5JIpCNj5RLw8
         e+dJm4tVS0b7XS0yp3kW/raaGnTeBjDpLv+Pm86iOeIMkfnC44kQ6VwcYxRyFyKHRYgp
         8E0hNObtOREQt8U42s0K3ZIRsyvi+ClI2V9rMbX97K/2CvdtQTf0oyBLK7wemGIQXBVg
         4oID0gBV6/ofIxntzH6KpX/Fn9w/qe3Id0J4QDempWWiyzZbVbO0zfZ6f7urpOvbKfNL
         r07YxD16YHaVQh4wD+xZhWfXlkCzyYVqflPsmijqXdEmx+bMVbxHgeCifNHk7ymuAxqF
         CeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128444; x=1733733244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzUuqdFRJBTOc5WUYdPFncGjQZclBe0xdjO8DYZWI9w=;
        b=cXKR+dD7PEs+qrhBAj+k8K6OuTwN9r0R2ySlmrn4W8CUzv/TiThDPiJU1Mm6AOpnxK
         gq7aSMxcDY8mUZ+/YYDTwOaf8V2fXeXfrsAVwtnm2Mi0wobJbroyYLPGTf6HObC1M7lA
         renmUwjtgNmz0fxSDj6Xtn/feNH9nzBLw+JSHaTLwc63AC7jJs+D7+x82Garxt1oiST3
         9D2OFqgnx+QfvsKVYlL4e84nh21g0kir7U2WZLyVZpix1NRfDzXU02RbxOWzTZkymIqx
         wIz0GARmwfubu+s1mX+Yo48KU7zGJXKwXhyIurjzXZrhwTVdFGO/n+Sle3jzb6OrifRa
         JjOQ==
X-Gm-Message-State: AOJu0YwFxEmw7uCxzjobPV/UUYDAYbouDH6BgNyNLfEGwj2XkQz0bcvl
	Gr/XnB1m7sZOwxSJcQV+EDwqg+SLVUHjRhATcarwFpP0USnpbo24aX+5eaLNABU=
X-Gm-Gg: ASbGncsRztT+slQIhmfa+a7acg5Kr/M1BJFunDsy0qL+weSxMm7gx6dSg1MI6wZEj9e
	93WR4mj8hpivBPG3ajT4dRtLd2xvDDYXsq8RlAfAMqISApMgmby+b2mcrQEB6JLoG8oVrYDsO+3
	lF+Yhv9nUci2P3VHuY7p4B4e5yN9VmJzhKYM2l2/W53eAp2LUbtvX1XeFfjrOn3uupvQYg1aqdE
	6JI7FO6lMwLBLDjcf8ZHOU25lc7ft3gbzwVkCgePBjDzwupLFlMBvDPJpzy9esZ
X-Google-Smtp-Source: AGHT+IF93Cj6VrT2AYZC5DEqo9FH75ITtrTeuuLtaax9mwkC+oOsEvZlaiWYlMoQiQwe7SW7NGiL3A==
X-Received: by 2002:a05:6512:3e1a:b0:53d:dbc7:981 with SMTP id 2adb3069b0e04-53df00d030dmr15664997e87.16.1733128443606;
        Mon, 02 Dec 2024 00:34:03 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649f5a5sm1409712e87.236.2024.12.02.00.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:34:03 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported speed
Date: Mon,  2 Dec 2024 13:33:52 +0500
Message-Id: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When auto-negotiation is not used, allow any speed/duplex pair
supported by the PHY, not only 10/100/1000 half/full.

This enables drivers to use phy_ethtool_set_link_ksettings() in their
ethtool_ops and still support configuring PHYs for speeds above 1 GBps.

Also this will cause an error return on attempt to manually set
speed/duplex pair that is not supported by the PHY.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/phy/phy.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4f3e742907cb..1f85a90cb3fc 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1101,11 +1101,7 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 		return -EINVAL;
 
 	if (autoneg == AUTONEG_DISABLE &&
-	    ((speed != SPEED_1000 &&
-	      speed != SPEED_100 &&
-	      speed != SPEED_10) ||
-	     (duplex != DUPLEX_HALF &&
-	      duplex != DUPLEX_FULL)))
+	    !phy_check_valid(speed, duplex, phydev->supported))
 		return -EINVAL;
 
 	mutex_lock(&phydev->lock);
-- 
2.39.5


