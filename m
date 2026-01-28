Return-Path: <netdev+bounces-254247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIljJDIIemn11wEAu9opvQ
	(envelope-from <netdev+bounces-254247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:59:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CA1A1B3F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC23D301D33F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E6F350D79;
	Wed, 28 Jan 2026 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQN/xOnF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE6238D54
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605138; cv=none; b=phEe9UkJQuJaGn5Ut+GfL67Nh3xHGLqMrevhmyUS59iuBgJ2qFuatQHgQcPPKjCF/DVD1jjnos+Ve6CeaaEC8Fm+wRqnNnvpF81/qdgbGIBUAjyTXXBgMr1Y5cHP2vF3Cb+SNorR2aa+kHES5fAOeNKzK3r//4gBkQG2FT61zIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605138; c=relaxed/simple;
	bh=cH0fBpdk2tUr/24Xbejg9Yyq7ERsxGwxfiswzi+cHUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrZIHw5sd09+r3CiZaDbpGTcswnX6WvqkzlE3IbOVRomlXad3OIEjjwm4p1DHYpiCNJfb7fupG6AWmlUOE6S6gdBO4BUjILX+F1drXjk+ny0i3LBXJzf7DpsS9pW55YPlXe91bD7Tdi2yTgQwIPfISP1vslAhwrOTGYpvdZZdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQN/xOnF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b885e8c6727so176306866b.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 04:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769605135; x=1770209935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=klJSobxqRNPxXq5lBBZpXaYGDx/qIxNfyIEWdrVXkm4=;
        b=QQN/xOnFETe/zNBcniAYPySQqY/f4A2NZvX+uHOUnOq9HzxHpLFkKVGUr0pb9bUrgs
         01gi6FpCWLpRfDYcyrz+n3M9PnGT9JXT6dqQwd+EJd0P3UUUrtftuUe60+wDk4GfQPtI
         7xxEDCa1l4WgVpzN8JILIGG5HAB5SSP2E4DxMx5xxDnYHyn+CUB8pqcP4MsKHZD+a0+o
         GS9Fz2ilrlFNTYc4JdWBTdyAYmGmwQV+08ogT/xgpj2FmF9y2BEaVLQvIjSGS0IopE0F
         lNOZOdt8V4ad6ROI5OMipZGHOc/qASn5tzQIZCk8sen7iqJTlXBOfFJavKMRGvwIfXrJ
         eikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769605135; x=1770209935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klJSobxqRNPxXq5lBBZpXaYGDx/qIxNfyIEWdrVXkm4=;
        b=KtrHqdzvdIYER4cmnGecHAwr/lq0hFu1HQglwge0/k20tPpAxmfK7CYzOxnrxopW1N
         HpqDsP35HzkTH/ELlRw3LsAb9ggJG923NUichtTuFH8xgBZigCfkKadqQRIeT0Nrv/HX
         vz562jhrI+M9sKcCFdYYeueRKTcisp9P4S/T/q6tUJfjP+rCO+0B3h+NtN2voyUwj7to
         bIa2JnWozsN6hrsCTfiYiMHvLzhvPZru6UOh+T8H/kuFpbTxOGgY7sjFT4Fs+1GlFRj5
         uJZZ+N8vmdJAqf79BkPdU7umUZqZOSSF944shf56+AdSo10J3FsHrQ+yQSKqR/x2mZg+
         /AlA==
X-Forwarded-Encrypted: i=1; AJvYcCWsHjo4MkGSDs+vZciX8tbC8NjdGXzFlAq+TCLpR+h2Pi6bFCB0+uOpLhkmVEv1FFz2sZHkgcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAa5HKSA/aepZlkF08jQ/U1Nn/lByuEu2hGIs+YkhfsGkjlv/4
	2fpL7Fw/yOYWx7+sS182fE1cNiDECdKWysVjQDbPLMDJ6sxfYPrdgV62
X-Gm-Gg: AZuq6aJUe7hmhQ4+mCu4/UNWYew3EBrW+Z4bFqhYp7YNPIzJmD8iSkHs0UBhvNX8XPr
	XROQZ7WWQiW7LTbxQ79i0yBYgMKnGvhAq8WTmmB4P6KJzW8aAvgwRWaY8OA8C0jIqPgsSgs0MPi
	rx9JnNZJLLyEEQBIUnSIlYxYBXPIaYEltYGz7ECY4ELozcVlk8F+gZearfkOEBEy2bybBl/s+FV
	jo7orsDViIRhwPbyapaOSxDfI7hZN+ztLCAH3Dy1Y1KxrDn+MX/61KrvhWMjHcAat5BNlfYurst
	FQDr2UWVIMG4y1ucL7Rp/ioaqn7btm+qbLULQ8h6E9p7BZuYGOYztIeP94L+Qp2eq9QzB23TQDt
	gSr8neVI8GVtls5Jwp4DIzBHx8ZlFw05KxCl48B6DjfFS8mJRLYYBjPsoLn3Kc1Tbr14KaD8HTV
	JFY5QaGN1x9c56SjDdxRX7U0ZNg5gE0DRGF+66zJgtY6wU6Q==
X-Received: by 2002:a17:907:7f8c:b0:b88:3d20:3f44 with SMTP id a640c23a62f3a-b8dacdc3040mr351146966b.26.1769605135007;
        Wed, 28 Jan 2026 04:58:55 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e29d:6e0e:72c1:d15d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2f3e26sm123344966b.67.2026.01.28.04.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 04:58:54 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH net-next 0/8] Add support for Renesas RZ/G3L GBETH
Date: Wed, 28 Jan 2026 12:58:37 +0000
Message-ID: <20260128125850.425264-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254247-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,glider.be,foss.st.com,bp.renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[bp.renesas.com,st.com,synopsys.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 06CA1A1B3F
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

The Renesas RZ/G3L GBETH IP uses Synopsys DesignWare MAC version 5.30
compared to other Renesas SoC such as RZ/V2H that use MAC version 5.20.

The RZ/G3L GBETH requires an extra clock compared to RZ/G3E and has pps
interrupts. Document the Renesas RZ/G3L GBETH IP in bindings and enable
the Gigabit Ethernet Interface (GBETH0) populated on the RZ/G3L SMARC
EVK. The eth1, pincontrol definitions and hotplug support will be added
later.

Biju Das (8):
  dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC
  net: stmmac: dwmac-renesas-gbeth: Add support for RZ/G3L SoC
  clk: renesas: rzg2l: Drop a check in rzg3s_cpg_pll_clk_recalc_rate()
  clk: renesas: rzg2l: Add support for enabling PLLs
  clk: renesas: r8a08g046: Add support for PLL6 clk
  clk: renesas: r9a08g046: Add clock and reset signals for the GBETH IPs
  arm64: dts: renesas: r9a08g046: Add GBETH nodes
  arm64: dts: renesas: rzg3l-smarc-som: Enable eth0 (GBETH) interface

 .../bindings/net/renesas,rzv2h-gbeth.yaml     |  77 +++++-
 .../devicetree/bindings/net/snps,dwmac.yaml   |   3 +
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 237 ++++++++++++++++++
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     |  35 +++
 drivers/clk/renesas/r9a08g046-cpg.c           | 120 +++++++++
 drivers/clk/renesas/rzg2l-cpg.c               |  70 +++++-
 drivers/clk/renesas/rzg2l-cpg.h               |  10 +
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      |   1 +
 8 files changed, 539 insertions(+), 14 deletions(-)

-- 
2.43.0


