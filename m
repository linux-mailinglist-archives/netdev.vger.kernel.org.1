Return-Path: <netdev+bounces-297110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Y3zCkEzKGoSAAMAu9opvQ
	(envelope-from <netdev+bounces-297110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:37:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F909661D8E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:37:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FXEgfN6L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297110-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297110-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66B2D3164C1F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C006347DFA3;
	Tue,  9 Jun 2026 15:13:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B049251E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:13:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018015; cv=none; b=GgJJKCEDIAYejEykC9TpjkKs31sP2npVdhwbyKilPhhPN11ABIml5c+BwTLvo5iqmHa1jVOCkIMvdP/3DZpRV+Y6pksvbGpOntMpESic4CxA/PPSdgK4bW6iKz2EvqmcAPFluuFLfnCxWD12sMfx617CwjK/XL6aMYX3v0t6JEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018015; c=relaxed/simple;
	bh=22JVSQJjGwljeiZ18Gw1sbCII4IMcchJHTBgkArVf6c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnntssbgqzHysiP9P3g+627YQW0nRp3UMQxqMH3fCfZjqSMecAGHNSVkO8ghq9qgqp0U8P6LmR0uVO87rY56JSdSiSwZiozi+hsOabfeE2BFf3s/c8tfzPb5bZ8gIFkxArArW6xxSlUbQ9FSq4GCgZjSArEjlIPE0Lp3ncjvesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXEgfN6L; arc=none smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so5797633a12.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018003; x=1781622803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1RxjqPGCItI5U8gOH4PdQCpjTve/F/Wr30HG8OpZBE=;
        b=FXEgfN6L1Sq9TXRgK/T4lKpB+1arlqUMK4ABXd5vTaVjegpJVljqcDsuRh5dRd1mMA
         M/LV4phtc4JRkyAv+k1Oyq7zxJ9aDnV0wQxnX0RO0Qb9jPiA2ZfO/w9Ygf1GoflDvujJ
         pf7zhPV6flBXlhWach9y2luV6AdMAP0zVXHTVnsYOV1lPLTvzATJDoPAJEq7DPBUgJpj
         a8AgQMdqTubUMW/bQYtp74cUv/gKVZ48Z72r6PMeZn6zD2BGzszuBIjiC7VbRpEjLXYz
         21HSRkeqB2/tX++VeAzs/F/VHwh69g8hqf3MyroIMsKtCzVLt1M7rnRa3lvLLGfbjDRQ
         f94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018003; x=1781622803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1RxjqPGCItI5U8gOH4PdQCpjTve/F/Wr30HG8OpZBE=;
        b=N35yymQDkYYSNENhWPkxDbvVAxSoU5HVBz7oRml2f/VkP/CUvqSRB7F2TTxIejYny2
         oGjhXc3FpNL9PcJw1Cr7yc3HxeZ0s4E2yVJf1ofkECe6s6hNjruu7pdxpa5TlQ4goh6A
         zrXQ+Z+ORxhGH8mVajJAApdHKqJp6bPMZzT+hSOoqOlsKlP092gaxKsQeEKEF4RvxrlO
         bRW9XWrxRr/oZLlAphugWf9IDY4G5bo+wJOx+/g+/ZTwxf+yfegiOaIvslLQEclh5q6j
         +5a2VTSn5GLSp4yzdAtJE2gv+yWaKDoniP9EI52EY6IGiFOHR8U4HWYYIzOpZx9V7dMz
         UfRw==
X-Forwarded-Encrypted: i=1; AFNElJ8WTUlRt5nEv9yhlwtWu10I1/OZqVSpHx3mve0Bwo0huNIDKMAsAOpnMu1APJH9R62vjYO7Yng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMQJWzdvZ/zgYaWp0QfCe8u1Y3JZ3BDHWi2mzmZK4kjw39P9h
	Xsk9XWH2gF75KfQK3+BVxt75kutXTYuTU48U260xlrercbgcOjf1Ur9A
X-Gm-Gg: Acq92OFCDm0y5f3aqncEVjTlY5t1X9piDN4jWY/RtWKPhS58wx9fj5SejwQn6yqA5wG
	aqhswpz3UxZ+wtu9J9V57DKKU5MBTg65tGpt8k+UbfYE3Kx2UQeSlXSE/ZWO1ljuCya9COCQ8gv
	wTYgync+m8Qigac55kMVN1w2ypZ7LMnqbTCyg6QeHZqyDBWMGAV5qazYwUDxX+5OVheVkpBXDRs
	8eCfj0ZFPN620D/TQlkEWbRsoItVk98yOVkv2JuOXYbnzkd6V9RX/xsASCOSt+FNRPEkzWkS/kL
	AQqgARJ1dxZ+kf3J48cPE4T38+tBmySomf3zMuNmgDvuS1+AOUmMdpUd02nIdPqeXGDYAy+2fzx
	gSzdCDxsVPuguEIKRaZs20sIwihlAoXPJFdRR5jFUYo5lsVE+5LS/ssr5fyXUgST9yHatM+VFgq
	voWrLnhc+2shSKHhS5Vl+3bpXp+cqUSVsc
X-Received: by 2002:a17:907:724a:b0:bef:1df6:12de with SMTP id a640c23a62f3a-bf36cdcebf5mr953590666b.0.1781018003482;
        Tue, 09 Jun 2026 08:13:23 -0700 (PDT)
Received: from Ansuel-XPS24 ([2.195.136.12])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bf0517721e5sm1073637866b.9.2026.06.09.08.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:13:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v6 07/12] MAINTAINERS: add myself as PCS subsystem maintainer
Date: Tue,  9 Jun 2026 17:12:03 +0200
Message-ID: <20260609151212.29469-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609151212.29469-1-ansuelsmth@gmail.com>
References: <20260609151212.29469-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297110-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:ansuelsmth@gmail.com,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F909661D8E

List all the files of the Ethernet PCS subsystem and add myself as
maintainer.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb8cdcc76324..8174f005ab43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9593,6 +9593,15 @@ F:	include/uapi/linux/if_bridge.h
 F:	include/linux/netfilter_bridge/
 F:	net/bridge/
 
+ETHERNET PCS SUBSYSTEM
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/pcs.rst
+F:	drivers/net/pcs/pcs.c
+F:	include/linux/pcs/pcs-provider.h
+F:	include/linux/pcs/pcs.h
+
 ETHERNET PHY LIBRARY
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Heiner Kallweit <hkallweit1@gmail.com>
-- 
2.53.0


