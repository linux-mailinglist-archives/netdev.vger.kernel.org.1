Return-Path: <netdev+bounces-266269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMgLBDhXsGkJiQIAu9opvQ
	(envelope-from <netdev+bounces-266269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:39:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A162255B64
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8DF8304AD0D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887AC3D5223;
	Tue, 10 Mar 2026 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuJUvMuE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11C3D47C3
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164334; cv=none; b=TT5rdzwfLY9/9a4obJ6kECT3Bql0avt5d7iXD5O0iK1uIz3a12TidTMXWaM8R7WY0L9+fxW2NMP20ycCCvynNHvpgpduhFXEyRV5aud4Xa+aGnOFIJ9jVsOHq95EeI3RlQPTC0Ng9vOVfCyyScx/rPZzKV8eCmeHPR5EdngCwpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164334; c=relaxed/simple;
	bh=gMpNvbA/trS3NU+BTse6Rix5R6BzD4pVqoDkvYr4Ioc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKeaEiNli6IC6wjlc/cGHjR2WaZVWk4bkhuWR/DP9udaeIcNuVlxazkQgeVkEj99pQ7opBQ3A9TkZdnMhM1On5wWFCDNvvjJiD2G8XkzaNfEERHoKSvSyZbthtThL2HlDhExSIRO1waq/CTTD3KonfQSj0/1p/rgaaJjapNiya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuJUvMuE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso14003425e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164332; x=1773769132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ieE8e1+SXTVLenv18290igX/i+pY0PQ8nKAIjWBC1pc=;
        b=EuJUvMuEEE9nclmfPXas5j7jNtgXMqbieMO06YaOx6W9A5fiUA8mLQtOw0MVef2vjK
         EBIy5Xj+OAX3NYkn/3ZlOaE1gPtDrZzgkIRk9qfkHNW2Tf39DJd+fjtwDTaXp2iHUJZD
         fitwvL7i8zYBwRV+ni8jnD4VJtIa5168mJuFPn08BEqB6N/aAxwPdDRroq5WhWEpyNv4
         6ODY9+bqCw73XxYJEA+WHY6e/Pval/DDc5FlEjm2bWrOZ8EF5yLU1zcD3gDDYYgYNDqW
         YfR3cZiwOpZVDEoWTfB3EuYFlS+o4ZglSIT/tTafAWup6A8rJLAZxcdMBTKmGND/FF9W
         89zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164332; x=1773769132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieE8e1+SXTVLenv18290igX/i+pY0PQ8nKAIjWBC1pc=;
        b=KoMTa8Mgyrzu0AYEN90MU2+GuVgpBEneSBJ00MW9QG22FbExB7KsCOrYG+XuK4O9L7
         7z4ZBLcaMTSqxDpyKaWtF3E9J6gMbtjOaXrqtfVY8HXYPioHUT3nY/AH2I9gSgoRtEHC
         L8TVfYazMrCf+mY24GNfrdCJkIXFLPOwOeAXp/O4XSM1Jh8veB7o2dyMoYKTfQNYPed+
         IYWJwtmz7PrIujE00qnOhAGSnSmCv7JIrsUzHCwxAF2TnODVdiNtK2TttCYH68SGBA9O
         Qy1CpAZISsX10zoWRxfdZtebzUKH6JOhDomTRGB5GfdjhZXMFHA0MpATRS+d/m8WMPKY
         hZTQ==
X-Gm-Message-State: AOJu0YzuPEULVgpeUl1w/SpAGm8HogB6RC3Njza/urALcqFFhEesFxW4
	jY3P9jl4XjcLRtjEdehB8qjhIkf0Pe3ARDQq6oZ011X6ToGLIE30XH3O
X-Gm-Gg: ATEYQzw8iuk6h05+vxkNmrPW5U9kAClCPil7E8f4ZHbF5bTKXy9exlopSJK+FWUJUv7
	dwRJZReU9CyF5aPYZ2w+31MGdHehc4rhHrPc62QWkwoKs3zxAF04UXD4PwsHPIdsw4aWTXdf2EM
	dR9mW1QHP/UaCcynF+fzFWKqblgomR3dHg02fb7f7h1lx1CBRg92JEn0UV7zIwb+mGF/ZAdzuez
	/9cBUs+X3RpfzHMA7rjE9YmSuaWHg7+eVmgAHP90cngE7NZx5NZVtQfz9WQww1gyfu/TR1KOUjW
	wjx+sVYwIY75p2rNn3PrgCiCthy0S8uo0FR2DQBOK9eNqExlOhdoBV2UVo4NmLhuQy4umGq0pFQ
	6Vq+gGosX5RlmS87ctgUnsdUwBnCik3L6fdPIRDcKu5Xg1rT4SPa0V/KI4/lR0Eq0AMQZ76oOW8
	CVyPTKwUqumJq8mRUiMvROd54=
X-Received: by 2002:a05:600c:4fcc:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-48526964a1fmr257839325e9.24.1773164331326;
        Tue, 10 Mar 2026 10:38:51 -0700 (PDT)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a900easm103239295e9.9.2026.03.10.10.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:38:50 -0700 (PDT)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH net-next v7 0/4] net: phy: realtek: pair order and polarity
Date: Tue, 10 Mar 2026 18:38:42 +0100
Message-ID: <20260310173846.230923-1-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A162255B64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266269-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The RTL8224 PHY gives the manufacturer some flexbility with the pair
order and polarity to ease the wiring on the PCB. Then the correct pair
order and pair polarity must be provided to the PHY to function
properly. This series adds the support to configure the pair order and
the pair polarity to the Realtek PHY driver.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
Changes in v7:
 - drivers/net/phy/realtek/realtek_main.c: factor out a common helper
   for package bit modifications.

Damien Dejean (4):
  dt-bindings: net: ethernet-phy: add property enet-phy-pair-order
  net: phy: realtek: add RTL8224 pair order support
  dt-bindings: net: ethernet-phy: add property enet-phy-pair-polarity
  net: phy: realtek: add RTL8224 polarity support

 .../devicetree/bindings/net/ethernet-phy.yaml | 14 +++
 drivers/net/phy/realtek/Kconfig               |  1 +
 drivers/net/phy/realtek/realtek_main.c        | 96 +++++++++++++++++++
 3 files changed, 111 insertions(+)

-- 
2.47.3


