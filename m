Return-Path: <netdev+bounces-307569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nQ+GAceKVmq38gAAu9opvQ
	(envelope-from <netdev+bounces-307569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:15:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E873775825A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:15:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZrwAAFES;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307569-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307569-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55F01301AE74
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85BC337110;
	Tue, 14 Jul 2026 19:14:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752EE31ED8B
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:14:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056486; cv=none; b=nzww3R2Uy8LNP0p01I3L4DHIds5TD7IC/3KHau+h8KhblfoEw96vSp2UlL9hBXdQIU5Ef72KVr9dliG/8wchN29sF1TUE5PUEP+i5+6s+D7TGwYWs53DIL39CYDlOY6QwC0HSzDwp6hp6I7D4huUCOQVmo4rb4tcI2ry/f+dfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056486; c=relaxed/simple;
	bh=nSCUFK/OMjdSa1QSD08/pZk0TevbcWQS6oI7xIYrSQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opnT6lSEPVLPlSRzalIGx4IJubLMIoUZlcTCr1iSM+iWBdTFUTNUF6Ijl1bs7zRQuw8jOLnPJo8LJB89nM4ilAn9KVVpaxl8Enof0llKq9IvipYTfjCgI4I3vCY9SU4Hia51Y2rDFLxG7cz5uDSb2jYkCCxYcQ+h4JSJffyB4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrwAAFES; arc=none smtp.client-ip=74.125.227.129
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso3971725ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056485; x=1784661285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kGEBxSja9QK9v749iu4BHEOzirdhrkQ+xdtjQ0ijsW8=;
        b=ZrwAAFESJcQzWFth7kUZDdjFtBBTf7/AGY1sEsF6AVf5lKsUsTA6gcjNKkSfBxn8Ns
         ytfMNKRdOxOniQ2n17xFFIugNlA9k0ks4CoXBueWAmDhF6/Ksurhi7LIdviUChOe4vA8
         bPIm2tAcWxxUvw7G8PqHt4qJeeRinvLfFK646TzdWBfQ8lbd4gyD7EySYzZ9dzF8eb2K
         UD6+YEQRfP2CxBPj2dHQ1ry9ToSE9nh+WergovF/sTsUxuIQEfXQGrLxUinDP3kaIJfZ
         boq6l7WCyGfeKH/0KUHKgCLX8MFP6YsvBvA1Q84Slygaxv4qGPC/y/EYSVFcwdfCUkgQ
         sv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056485; x=1784661285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kGEBxSja9QK9v749iu4BHEOzirdhrkQ+xdtjQ0ijsW8=;
        b=d1AZowi4jXzG/ssxs8KjLZcBP8mmFqxyAfgVqyzCS6fLHfCNlOlYzbywyQz8OziOCI
         +i75KxSb4jVFH5bKJNEpYOtWXHxK8ZqY6o0Igj2ZF+2dgElEFVrbrXECowghedJkIgii
         2TZTPKZmgm+s7gmvCe5qQkMDgtj4JCT+v4rxB5FtL+WYvKM8PEI9qAo/TI14hDjdZRbe
         0vko+AQWsgw/A08VpCVd8UkePbuf75nVgnYNaVvEbyDzBt76Px0mSRqN4htdNfkPL/W7
         mIfzFx16MqL3nubdFzakwS/eR3K8KPuwaSiNNGUtp69kLdfV+79GnpRcnu6lv+tYeHOW
         BqHQ==
X-Gm-Message-State: AOJu0Yz7BGP9pUQov5O8tj7RyKdP6skB5mU0mfBqhitUPn+I6VXa7iWg
	Wyp8mG1FBqiX3yjRc2LgaoIjIw4PqjWQaG8JYo9roQg0cFja32yYeke+
X-Gm-Gg: AfdE7clXXIh36EDOrwWmnuB2cXaDrJzn8NEVdHNRgBp3AcC+prS/FEqx5Nm5+bqojRe
	mqkRvscduyA8VbapAu+BgznrQGxpsgsSgkoWdHGmQDSQOubaxY5ccYn/gKIk0dvRZhT+BjAfB8N
	mEVChlF/3Ig6XFxCtiNl1Bz522IXHrZr2nXPj0j0JEnWTySjTIwwHboOrKJ2eGuoS8s60aeTNGm
	8lpjDuHUEIK2eW14GAzOrdVwr+dElHLpwIQJUNhC1dAt0RVAZjHbaG1TOpyMsqKWpLAyGndZePO
	lOCd4Ov5ld+tLfNo2Nt8Wp+D/4YQzTxuFJxVncGav3LUqqKVRzgtGPlqetK84MDr/Gb1WhARXmb
	rfk0DHbNWs0EXxr2TdNP6/NCAcaWktAAEAoSWdrvEHD3K9989VHuAOrhAAu7LpuFQ3ozDkL1iR7
	AyTFTIuQSANKg=
X-Received: by 2002:a17:903:15c3:b0:2cc:777f:d67c with SMTP id d9443c01a7336-2ce9e99be82mr146416405ad.13.1784056484883;
        Tue, 14 Jul 2026 12:14:44 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm120763245ad.65.2026.07.14.12.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:14:43 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [RFC PATCH 10/10] MAINTAINERS: add entry for Rockchip XPCS driver
Date: Wed, 15 Jul 2026 03:08:38 +0800
Message-ID: <20260714191341.690906-11-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714191341.690906-1-coiaprant@gmail.com>
References: <20260714191341.690906-1-coiaprant@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307569-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:robh@kernel.org,m:krzk+dt@kernel.org,m:heiko@sntech.de,m:netdev@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-phy@lists.infradead.org,m:coiaprant@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E873775825A

Add a MAINTAINERS entry for the Rockchip RK3568 XPCS platform driver
and its device tree binding.

Include the relevant mailing lists (netdev and linux-rockchip) so that
future patches are properly distributed.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 806bd2d80d153..8cba6a0a2dd03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23463,6 +23463,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/rockchip,rk3576-sai.yaml
 F:	sound/soc/rockchip/rockchip_sai.*
 
+ROCKCHIP XPCS DRIVER
+M:	Coia Prant <coiaprant@gmail.com>
+L:	netdev@vger.kernel.org
+L:	linux-rockchip@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
+F:	drivers/net/pcs/pcs-xpcs-rk.c
+F:	include/linux/pcs/pcs-xpcs-rk.h
+
 ROCKER DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
-- 
2.47.3


