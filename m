Return-Path: <netdev+bounces-256353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID5hE8IggmlIPgMAu9opvQ
	(envelope-from <netdev+bounces-256353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:22:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 298FEDBDAD
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 250FF3079BF4
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 16:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DBB3D331B;
	Tue,  3 Feb 2026 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sz0cHxFf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C903D330B
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135568; cv=none; b=aDSeHuOV3p0t9QD2vxkHaMpk+tXH4JWbsXqVNyTa6hh7e50LUh8fdaTiJs/Z/BGHDBXXdKNIt/pDYUMOa1qsfitYYVePHH0PbELDflEI8aW+kglEHOP0q9h5Edk6GzAoYprH5SPomlkPXU+HQAqqhBIsXHMvX53W7yzvOKB2IDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135568; c=relaxed/simple;
	bh=qQXywwliKiapdNiYt6dNWT6x/lDJ9YflmLKRdBQeGyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S82VYkfM7C+g8PnIdyvOWyeMqcjEUNyvTAO67bQ1bvXHfgcjUvX0p/dsK86hP0M5/j/9Yfr8l0hNZ3Z9OqZkOpSbZ+zSMaJLFAVws2unyTMuVX2tNJ2dFMGSO6IE2OgwvorYS0PwxRdSzTwDHOASFGbZM00hsLbAfbqKNox0b10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sz0cHxFf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-481188b7760so39635985e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 08:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770135565; x=1770740365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5M1ZbJBKUwOtAuomtIJGP1xLtlDmn08RXJLiC0W3qw=;
        b=sz0cHxFfNl/3CGqWQVtv34vGdT2jimV0+aTwD3AuaVg1FFvAPiqQUiEf/N0I/9e+hp
         bU4z+9HBhmbZix6aYQJjyrzLknhXdACxUYJ0I3uP2bZJhT0sqayVq51jbsnuYJpGndVO
         swKwarzj32vbel7EDr01cytgi/Fc4zCKceG3HJw1Y4nIorwhFaLjc8rAwB/BIpBLLb9f
         +rov7jZCe5YeA+UhXseF6Mc53ZxmCvIO9Ma6VmzHZ0dnNkJcC2vgjG6/d13sNaw0dql1
         U89uKLjtqJQ9hOW4PKYsL4ZIW2zoOG32Rg/i6xUfUD5xD9nj6J/wVk+Uw3PC6Wr8WELe
         TlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770135565; x=1770740365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L5M1ZbJBKUwOtAuomtIJGP1xLtlDmn08RXJLiC0W3qw=;
        b=liJPjhqe06OiPahrja4+30SzpYay9PdrfiHhm4tUU9fo2mSGPlMTMSsjkqeLQvXaSE
         gdAqb+BvLCyKEcmvKRW8ABvsfxitQTBp75Ydmv5DtlhRBsiWrFK9Fgp38F8A7cW3pOrK
         7mPeBsnZKvMLgmULLKphk1HcQ0Lo48ZKfYKnLlLYwRi1pbv/PyT0VdGQWRq8nXEpN5lg
         YG1yw3iONdlld7hHGphhZfT8gFdllUDzPYtro8C0lBXiNXGTR1HLMdb26f52OhCH2Us+
         DBsvF2kSUdGHd3C4phq/KhoWA6BJvYnduaygGNgtAtrgDq/ZX9IM1d23VoyOJDnnws4O
         ljyw==
X-Forwarded-Encrypted: i=1; AJvYcCXpAL7DQvE13jTDqwp/xZEkaDI8y+9PfgOJlqZPO0Y5KWlxRY4MzwubldRalRn2UVUu7qlwXQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtb55K5dDZXFL7ak6JzRqWaoXNWnsKs6Ix2ZiNcGhphbUAfVE
	hRbfBqjsUQ6OVnd6VeXwvCl0TSAXYI0nQVJ1ldXxo52mpI8RFStUayaYnEr8CG7e3M0=
X-Gm-Gg: AZuq6aJrUQ9V70bQyQxEiVhHHp47OM2nN4XF8KwqgsIWoAYrq8JAzlJ2Km94iF0J48J
	80/D/oCZodtUgLH/AK7xo2AIDh4D5flcgBIn+pE6OLPAtgTcsNKs9pTpfqTPnFhkAf2m/eGkF/l
	ud/NLg5U3cdLM3GwqACeLBe1531A13+nv4hhdU/L6m6Y+7i+ZodQwRwSMbejDYkcFnFPf13X//h
	gTIpTFvYtrAb3kNPg6q+gtWS8Yx1fCd+8bC3Y9r6KUm0DgyvJunXG6LL4S1G8downix3/ZpsYrk
	/zEhJ+vs+MgZaYjG5kywLGPExRgXuBeTsgptIUTfmfd82J0LoTF1mUhRG2eJgQBM2bmV5Ay7bTJ
	3V3hsd7kf9YeiDb3JH3IR3hdl3xARbyoBW1I+Neg/eHle76Ej29hBEHgj5UkgAbgqvMYJKdprTQ
	sgsSmbe+4Hq4lEu0mrccw=
X-Received: by 2002:a05:600c:820e:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-4830e96abaemr2199595e9.18.1770135565342;
        Tue, 03 Feb 2026 08:19:25 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:81d1:b874:c1dc:42e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbd21f5dsm144120785e9.8.2026.02.03.08.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 08:19:24 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: vkoul@kernel.org,
	neil.armstrong@linaro.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ciprianmarian.costea@oss.nxp.com,
	s32@nxp.com,
	p.zabel@pengutronix.de,
	linux@armlinux.org.uk,
	ghennadi.procopciuc@nxp.com,
	Ionut.Vicovan@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	horms@kernel.org
Cc: Frank.li@nxp.com
Subject: [PATCH 4/4 v2] MAINTAINERS: Add MAINTAINER for NXP S32G Serdes driver
Date: Tue,  3 Feb 2026 17:19:17 +0100
Message-ID: <20260203161917.1666696-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203161917.1666696-1-vincent.guittot@linaro.org>
References: <20260203161917.1666696-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256353-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[digriz.org.uk:email,nxp.com:email,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: 298FEDBDAD
X-Rspamd-Action: no action

Add a new entry for S32G Serdes driver.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67db88b04537..fab748292821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3206,6 +3206,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
 
+ARM/NXP S32G SERDES DRIVER
+M:	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
+R:	NXP S32 Linux Team <s32@nxp.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
+F:	drivers/net/pcs/pcs-nxp-s32g-xpcs.c
+F:	drivers/phy/freescale/phy-nxp-s32g-serdes.c
+F:	include/linux/pcs/pcs-nxp-s32g-xpcs.h
+
 ARM/Orion SoC/Technologic Systems TS-78xx platform support
 M:	Alexander Clouter <alex@digriz.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.43.0


