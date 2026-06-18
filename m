Return-Path: <netdev+bounces-300431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CmKZK9/sM2pSIwYAu9opvQ
	(envelope-from <netdev+bounces-300431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:04:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 136F96A04B9
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:04:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AvOy8Eb4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300431-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300431-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC1C03103829
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00443F99E1;
	Thu, 18 Jun 2026 12:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E323F7A92
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 12:58:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787508; cv=none; b=adUYZ0fIv5WVs9sAxowncdegZXEDtMwC90sx8Uu9cKrVWyPcOJJNBor05ptDR/NqtrIIeZcZRv7C/zwOc7U3oCX3pJ2GM3I2oEdrSohyZoXIxNw5UyWAsuqpqQLMsZH8jO8guaB0+iUYCWRyTooE26daHvpmXq05Lr84HO8G3qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787508; c=relaxed/simple;
	bh=AtNohlQ0WYu7yAy0ZDcPtcuY1C2JeuynsMtDfbhK1Oc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxD6IEeR6nLUBGDmyrFRwxWASMPkIBh9WiVS3Zc1kNxe27qq7pznFd1ZZ4pY4kmNQlHVhR2FLbss3+TD3i057iPcaWvmlKiJEBsehv8gx1oabyu7rKPcrZ4eT5MGBtp6cJ87BkVIF9xwSlBe0SVSTQO/V4C/wm9gMd1GbvT0dhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvOy8Eb4; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso6072035e9.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781787505; x=1782392305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7ibR1uk6j3yRvHUeSG7+Ts5vUBpNZwTn1NirzFE3FA=;
        b=AvOy8Eb4O66msKeiGx9eKXsBNctPy7nQL4W2hlD8s60TyF5D1pddEMLn3117zVTmxk
         YNvSxXaMZbPe782JNFuvTz1oLtsLItPH0wtYxoV47mmqHtQjs3llYiNA4MHwhGl3sjNR
         2SE70W4ed+/o9dqqdYgTvZMjINPAHyS+gkKwVov1wMG138uWeb1G2FMICYPxCtBGGyYG
         MVXDi1qEflcuvTKuEt9y+vdQ8P2i4GTMVkzjZQgjdElMGPB97BPAnTDOycQfg6weUgrE
         Hw9Fk2BG9DomVaVBRqpebEsGO0l29Rke3mxLDvd0tObP82kSQd+WivKesac9BiGVagxm
         kBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781787505; x=1782392305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z7ibR1uk6j3yRvHUeSG7+Ts5vUBpNZwTn1NirzFE3FA=;
        b=lqr0MU5+W5snyU6W/bvgAT98WdRD7eJtneLwUzeaJS0P4YOhV8F6wSNlkzEknXASH8
         oGli1fKuBv28QVf590vT9NwL5QpvDHpdv40jUvDvHuwQs6aoRRnCCYzegx4RiMckkLa3
         FFU2nVphofhl0p6nQQw1WsiJw4ihs3D5AjGN3u9gNYQwLVtVqkFehxrsQc5FCCXqHd9k
         +hvFVci4o2QLqP7B2wpJLXpTW6Nu0HOxCLlnRdW+N2DgAPRLrIoSjaGkf77GRpDoQzKY
         UnUHsmFOoIlGrd+ZmKJLvS9c/1Kr1+fU7AiuwItaxwqCuMn1QWd7jGZ7JDR3kmEAqKsF
         99Vw==
X-Forwarded-Encrypted: i=1; AFNElJ8ekc0XGdCFdo0p/E81tlvjpDZAAITw4Nu2QPLKG9BWUsV6vA8H456hdEZ30nIZHbM9S/gXVos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlWP9LG3Uax6w7t1ibyAEOME8dhDL1XOVnwOXZ28Lah7KZCOS7
	wHGhoITIhlMYup7yUi81uPHz9DYD3MmPCOoKT6EscAjDELOMiZHQoTM1
X-Gm-Gg: AfdE7cm0Ok3vksE8Mv2uk3ZTYe7eRWN/svKalTPovvhUcTwfM3IpE7IKhmgoy4OLkBi
	u74p0AmG6tXvnQ5Q4dTKv7ssqtasL/qVrnKksFWbzs51qtf9bmtBAldIL8iqy1bh95vXkY8OgNs
	Q7Gq3ot4ZyQveebA8wlAeL7V31RBulhjTO0gJxjXhP1uFQRsvaEbc0OEL28OvdH92MUofFlU0UQ
	rlTJ3kDESKikA5hFtTx1RLq70n9XRs8UO7jzdn+tyowP3C+dFnfHMK6bzZzkOL4kDykX3xbTmQp
	AGpa8RnI3pbSkodCQVTMjRfocyu3LDzexY994w7tfA8STNWQySkgaEYWtFcdL16Zn0O5lMiLIEf
	c/1YUYW/YVnIQ13gCenzTTpEt3SRFZaZR26zRDRDLARjY4osA//bvVe9YGqsuw1F8g5gqvYDccP
	XC0N81Fi21U39hWoBN979mC0x6HdwAbCLj8pmb+3zDk1tLOguRgs5VQicFoHwATA==
X-Received: by 2002:a05:600c:2947:b0:490:6237:5200 with SMTP id 5b1f17b1804b1-492333f5dbamr93229425e9.10.1781787505189;
        Thu, 18 Jun 2026 05:58:25 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49230a458f2sm241451585e9.3.2026.06.18.05.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:58:24 -0700 (PDT)
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
	llvm@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [RFC PATCH net-next v8 07/12] MAINTAINERS: add myself as PCS subsystem maintainer
Date: Thu, 18 Jun 2026 14:57:15 +0200
Message-ID: <20260618125752.1223-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618125752.1223-1-ansuelsmth@gmail.com>
References: <20260618125752.1223-1-ansuelsmth@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300431-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:ansuelsmth@gmail.com,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev,bootlin.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 136F96A04B9

List all the files of the Ethernet PCS subsystem and add myself as
maintainer.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1dde0c9067..ef3ef5096d08 100644
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


