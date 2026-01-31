Return-Path: <netdev+bounces-255454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI02IAwqfmkJWQIAu9opvQ
	(envelope-from <netdev+bounces-255454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:13:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6EAC2EA6
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D46BF3008D53
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B587833BBD7;
	Sat, 31 Jan 2026 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhAYbRNw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117132938E
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769875977; cv=none; b=WcwfErux5ISHBld/y1Xad4oaLMDpWCyh3ffJAXrn3yuWnT/cgi7xsDafQtvLfkcLVxAIeYeR63OVmJQj81Y7QwtqgRCCk2bByZMFvnnVqf4Y39cYYNHowFPM89luC36qIbsk3wJFqF7/hiJBfVQA7kJBaDKarPzjUW3bEj9jynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769875977; c=relaxed/simple;
	bh=CPXqNX3GnHi/zUCKl5MQWer8/UGM0jn1T9tZTZx0QGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hCiijL4Zw+OduD1Yh2zdsf/TL73ck8V6TvkaQTKSzRE68dIzSAhlxGNbPhGZvGndP9EUxxM1kWwT37PNGRqbt3WGxYA6yjpYXRFEYhmvqtEfu7OM665zG8YOpoA6KFKYTEc2ETNhaQmvvXyCsjI8jTahr3FfhhKoEhXIJgggV74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhAYbRNw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-658d3d3ac37so5173126a12.1
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769875973; x=1770480773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LquA6UvIHZojV0lXQ8Twrjt3A7E6bOJA9Lb19ucfhkw=;
        b=EhAYbRNwr7+ZGWuUBFRfTpZJkalaMNQnBi53/+vgidUf+qxhvWaVtqI1LR6Y09jbQ0
         hug22kwNwnT8gNZ/hXDuFeQTUTlrM1OKCVQlST83WkR9+lOr+vcFS2I1LEjzniBiF6Au
         geXA8BiVuY1dPwQ0NRyhBDHvErv14lR+b/yrTTHOLSt3spTe0dD+uaApWBFF0r8AIO2b
         0ZGOJ8zbJSIr+uzsX4tEd/3i+DK0fA9JRH8KYoZcjZbLv7y5rhj6hJFA9lOUm3FlfnrM
         ffg4J3P1PvX5zoEf5XDp7CagHCqtb6QSlok8X84wvZBViJL9SHd3GxOC+RbT+O1rrgGI
         QzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769875973; x=1770480773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LquA6UvIHZojV0lXQ8Twrjt3A7E6bOJA9Lb19ucfhkw=;
        b=S02yTJRaGiPZljH3Til4qezqMIi/H8xU1O6G/Ne8HQQDNUdxUDnQbzRA1XgfrrAUgK
         cI51RIffh0MRLMINT9aSIE9uvdf+Hna/RWMKZCTfQnPodRPGWV84Cds4oJV1f6CoFqVg
         gisAaMcskH4rid7HmjKmDKfLQvqoFPkMOldGBqgTWjCffRWn75mh5o2NDfOlpABUQrYC
         2sB1c3BA6iBRlj1AwLx/u4T/hsisrQU12iuLwDP1+t36CCxKOVZ5g+DgVTIuP9487Tjk
         m2YPW3EW2r0iXXk/WDIKxaaRi2z0iVlPtSIArKYPB1GroPt7x4+hhgfAKVBARvfCVi9D
         W9mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCwfeZ/DSUUp+sYxgxJYnsHYoDOB04JewmU+mRLQFjNwl8AsWXwrbVjChDgtO3xvI+rn9JfI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+fNaNzhkYuZzF4mtYUZlIGr5fdoUaprdl4IKGkrX2nN37nnJ
	hYgKzKlx5BLQ30SyQaybQWMDMOAeSrY43Se0m7fvJmSdRPUIGncxYtIF
X-Gm-Gg: AZuq6aJ8Xhmzw7DckdEI520fs8vWc7bGda59KpKcrCfuaiyariUwaukpktoNJKwPCWR
	SPso6g6YEkcD8EJZMl4H/ymD6IbrTyvJ8YILYjmpuduouJixIQStm6UC+CGzZh/+rH/Hf4wsZwa
	jUGZm9V8bHEC7zqNvnip48VNabPIYIFyS3WtBvzwAFTiihf4Zg5wPFff9i1zjwp6plabmWKDjsm
	pX8eSn5hnydJARADaTeeOc++9x78i/qXz/gr0xOQ/UEox0ZfQ4LUssKaPVsouo5kusKNfBlUSdK
	m1oBTNKVyb5DbgqfgWHFPkR2X7dlzRw2u7eoPYe6Ti+SxZWGMF6JTUw66IyPgZIt7BCRpFAGEfT
	jmgvcFiIXIWFMJCqRktKkL4wIrcLnP3zxew1PTDyWyMHolmbBoz6MEyTx7tK+zXYqAPYulMrM95
	k8Ircyc8/5FaZ5tm1nefDudvtlDF2gwjMgdPI=
X-Received: by 2002:a05:6402:399c:b0:658:c140:4edf with SMTP id 4fb4d7f45d1cf-658de58b52amr2912149a12.21.1769875973316;
        Sat, 31 Jan 2026 08:12:53 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ad:7674:ff90:13f3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b46ac0e8sm5433232a12.34.2026.01.31.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 08:12:53 -0800 (PST)
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
Subject: [PATCH net-next v3 0/2] Add support for Renesas RZ/G3L GBETH
Date: Sat, 31 Jan 2026 16:12:41 +0000
Message-ID: <20260131161250.5047-1-biju.das.jz@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255454-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,st.com,synopsys.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,glider.be,foss.st.com,bp.renesas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 6D6EAC2EA6
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

The Renesas RZ/G3L GBETH IP uses Synopsys DesignWare MAC version 5.30
compared to other Renesas SoC such as RZ/V2H that use MAC version 5.20.

The RZ/G3L GBETH requires an extra clock compared to RZ/G3E and has pps
interrupts. Document the Renesas RZ/G3L GBETH IP in bindings and add
support for the RZ/G3L GBETH in dwmac-renesas-gbeth glue driver.

v2->v3:
 * Fixed the typo ppt->ptp as pointed by netdev-ai[1] in bindings
 * Keep the tag as the change is trivial.
 * Collected tag for the driver
v1->v2:
 * Separated ethernet patches from series [2]
 * Collected tag for binding patch

[1]https://netdev-ai.bots.linux.dev/ai-review.html?id=495cbea4-c154-4027-9ecf-0167906492fe
[2] https://lore.kernel.org/all/20260128125850.425264-1-biju.das.jz@bp.renesas.com/

Biju Das (2):
  dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC
  net: stmmac: dwmac-renesas-gbeth: Add support for RZ/G3L SoC

 .../bindings/net/renesas,rzv2h-gbeth.yaml     | 77 ++++++++++++++++---
 .../devicetree/bindings/net/snps,dwmac.yaml   |  3 +
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      |  1 +
 3 files changed, 70 insertions(+), 11 deletions(-)

-- 
2.43.0


