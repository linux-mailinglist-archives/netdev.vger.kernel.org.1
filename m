Return-Path: <netdev+bounces-303956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q4/zOj3bRWqAGAsAu9opvQ
	(envelope-from <netdev+bounces-303956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:30:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 844DE6F3410
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:30:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WEO5ErPH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303956-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303956-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1F923098ABF
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652DC31715D;
	Thu,  2 Jul 2026 03:26:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29937314B76
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 03:26:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962817; cv=none; b=gVZV8uUiNooM97ppwtdUJ2kmuYIe7eJm6SCqvPxgd1UnB9CkuIkjHctx71+V+X+IbEYcC5n2rAkuDovt7+GxQBBVQ28IdLAW78bm9WawBxP0j4wXKILFirwLZ6oiY4Q7/9InF8FObcMH/BEZngF+NYPZtFcENIe8apc5uRMIhAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962817; c=relaxed/simple;
	bh=lUJuZmfJedsVTrHLnrVZyUNyCZC9m01NVzOw/lh4eDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcQe9JBXaZGNGIMOfBbaf3YlSugXvXqzq7G5nudpkhPkw6g/DL1vyXp8lM7OWBkqYusalX8FTvPYHYarBtwumGHPvCEXCsGJ4DKW3dtLu4Brw/wu5B5Kxe8Ds3+4ZRs7yQT5rzgd5VLgfg6juw5GrW+Y5BKgCOKEbVXQ7+P7sgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEO5ErPH; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b9d265355so873533a91.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 20:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782962815; x=1783567615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1K/++Gs970wFgVMGoTbdrKLAvB1O9sQvsTtAtbYYr4=;
        b=WEO5ErPHAlfTd5llm0DmJrGz4f+Ok/Nwne9BZbcSkDzxXI/K1lvoxAm5bY6f05Azjx
         XYy80Cyd69C6BAz5B5Y7+z+wdVIXYAzV7Xc0rFYyrqPCJE5vavqbtsqqbg059PsGeUX0
         jDSE9Guo7UOP68UtgjDMjY2XbBsk943SiK7NT1zQk/njBmbJsQ59wT+I5NPPCHzyLGiR
         SV0C85FWRX67Z1I9oByBy10XrmJ+DJhljC74qRjdYMd4+aPXQQail4nuqxRraj+qUl/S
         xwR8PpxuTyZSGoZZ5UoVfobSq+PbPdpXt4LL9b818iFDk6CV9Sfml7mFNKmcps664/ea
         6gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782962815; x=1783567615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1K/++Gs970wFgVMGoTbdrKLAvB1O9sQvsTtAtbYYr4=;
        b=EWI03AAr04PRLYPsAQd7LUGrp6h6QvYwdtvtoC8cpy9+DsBVyR7OtPV4kx1KXBBSWw
         JMzkfiV2VgakpSIRK92dUKO3rYVeDSEC6/J09Cta1pK/V7lQXdz1Ue5OG4YJ57+X5IBc
         oL4efX8TQBdKYnUbhF49o+5alhddz1sz63uiAFJcK4AOLu4noqpzl3HEojOwy9gJNH6D
         oNwmQ/yJr4Auyp4bfQ0QzUVHgB6tJRAg3U02/gIDwNNNq+486uVtDjLxqTRRj9Ghz2Nj
         SYELV87J3GbmrYFO3hvCw2z9tg9l/C729exp/eybNfac7+N4/zyLJLlOq3iAVc/SzWb0
         piDw==
X-Gm-Message-State: AOJu0YybmOtugt0XkGzuNlglW18tzhm+QrU77y8VJqGu3zWGHyvJkmnR
	z3eeYhv9PQqZ/uvRS/O3dKra3G+DdsN7flo7jBKceDurGnWOo4ZeKzqNTaeRAQ==
X-Gm-Gg: AfdE7cl4kVu82DWGtuRe72Vk90/MDTEDxxIDzrBQd7uSeXLOhcharV3XD0SPmfv45Ff
	o+iLYc/w86rw6Brz5rOhVgvPb0O8uhbakDFVBkcp6JnYz9uegxVsdQq/zgpaluqeApYRZFQJG22
	FJg/Ty1ZYWd60ytZ9IAIGCMRGy//moO8D6krEGIvpheavUzEKUam78ivm/dA57o+vIukDohBrVn
	hPPyOdi22wJHusjLY/WRTkI2WsL+uJ1bSmhMhG/7yUUsXFY9xGWPb47kQ3uDOlcIxhNtmzGBh7p
	NESX9ntHqn3TrKzRNOQVhYfRaEbjUN50+c6RYCG64FyZlOUPCIs7X7Lr0KBuOTZ93eDM5jckOMl
	xV82v2c8FuYTMH4Evk9jaXqU1jSaBIHraV9cgpERUCaP8Oeiw5ZWQElNxqxsuc16z7GyoEbPG9Y
	hyoqroYpa7kkN0dGUvzwgu1bSp7eWbqmmbMGv2OHANu1NUpCYnGq0930p/lLDTmvwlpNzuOAz44
	C/08KI1CQ==
X-Received: by 2002:a17:90b:3e50:b0:37f:9ce1:7359 with SMTP id 98e67ed59e1d1-380ba91d27emr2975847a91.26.1782962815070;
        Wed, 01 Jul 2026 20:26:55 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095c0b552sm1651289a91.0.2026.07.01.20.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 20:26:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: mdio: select REGMAP_MMIO instead of depending on it
Date: Wed,  1 Jul 2026 20:26:52 -0700
Message-ID: <20260702032653.1580616-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303956-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dtcccc@linux.alibaba.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 844DE6F3410

REGMAP_MMIO is a hidden (non-user-visible) tristate symbol. Using
depends on it is incorrect because there is no way for the user to
enable it directly. Change to select, which is the convention used
by every other driver in the tree that needs REGMAP_MMIO.

Fixes: 8057cbb8335c ("net: mdio: mscc-miim: Add depend of REGMAP_MMIO on MDIO_MSCC_MIIM")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/mdio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index c591eec8e97a..e57121019153 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -122,7 +122,8 @@ config MDIO_MVUSB

 config MDIO_MSCC_MIIM
 	tristate "Microsemi MIIM interface support"
-	depends on HAS_IOMEM && REGMAP_MMIO
+	depends on HAS_IOMEM
+	select REGMAP_MMIO
 	help
 	  This driver supports the MIIM (MDIO) interface found in the network
 	  switches of the Microsemi SoCs; it is recommended to switch on
--
2.55.0


