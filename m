Return-Path: <netdev+bounces-261639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJXJKo/moGnDnwQAu9opvQ
	(envelope-from <netdev+bounces-261639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:34:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DAB1B13DE
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97C823010162
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D565239E7E;
	Fri, 27 Feb 2026 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH+CtYCf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11519217648
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 00:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152458; cv=none; b=oJJg7K9dg2J/jXzRfJhsmxpSbcqdO0+gpa/s+8W9XDlDhvazbyRc9+gnmxc5R2gCOCW8Im4w8pRUIY5wWffXRV9OvkkeXSJSB2pFoBiSHqRd3RK+LIo2wa8IpMdC1iS5wSG+1qizWL/Uym6F2NZiv3nss3h296OKy0B15+YDciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152458; c=relaxed/simple;
	bh=yzHLJjzwb4n4gW3VhMsS3shKMAbFBbbojDRBAEo83JE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LK53Zh2UWCpctoH9o0XI7T//6CzpgEWUFUnX30gEml3kTTt/WLm2OoOg58h9tfR36+EKQDW2E3l6WqTZaqVE7Z41yqR2Eo1XKZk3OJ8HJAsMYlT97XhpnSIOZop8tMFgU2Kke7fpEWDiqPPEngbyEkzjx1PD/vQaPJO2epdhBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH+CtYCf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c7103601c8cso555491a12.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772152456; x=1772757256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFfXFrEqVAtSKEy1ZLZ5f+PEt10WgQn8etbc6mkxu7I=;
        b=XH+CtYCff1/uLY0gxdg8NF09ZhrgMvxR2uW7gpDif7e+bppdU9KneeRRhcpNps6gQL
         tINX198MyHgtRb6RgBuRQ2qKV6QdVCv+4iZ1uugswngxKv7t1Hp+TcbBrNBIm+ZvMTcB
         /3syLM1EYtU2jlVieYns6Vi7Tiq9nX8wQ/k2EFf3kxJ0HOFzTGW46iLnNFTnd5V/vRYC
         qCs/3GLbclF0sONM/eGnd7BsWmmrfrWT3qlmL3UYCujUTMTilQ7C+65X9Rma5gHOzpZZ
         Ghy3/Kx3COKM7N5kkECC1fx5J5q+qa7jmCXKmR7mHn6iFPbBoq5neexq6m6ohGnZs1nx
         EIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772152456; x=1772757256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFfXFrEqVAtSKEy1ZLZ5f+PEt10WgQn8etbc6mkxu7I=;
        b=dEWrJyNxHYwJ6m1mGZs6U5shVKDALSWam04Lv0BMgFng/Qv+U6ATbw6cvQCosmkdKe
         9TfEEqL7ky/Ezw3HoNm6imaR/9oxwJUtwdC82l5H6eDvF7WVjb6i+gYL82x1Bo4XIuCW
         QUD/t7+vBHYR5NA2pnyS2Tb+npkGOWjCg+fhTieK4UmWSaIX1OA3HN0HnIDd0+K35e7d
         vDeAJZcgYJNXKgBCit9CtgVtPvk4lzoOBBWNa/Wt9dj21hSRCUrPHbKLsVhGy/ctHsoX
         lMbn8dB82BAmcdSZv0bzMvoPCmaIA4qMOv+KW4vSDVFTEk42izg4Svxz1E1wfgKlrKtz
         FdYg==
X-Forwarded-Encrypted: i=1; AJvYcCUCExdh4mQ3d10N7hSjvOs+x3N8DHXKAN1voF26wEs3zBNaGX2jlHOw6QoAAb3BA/cDqeTo+e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX065ArxE5fBRbk24tk+4973rF2prGiWzXcENvb+Oj1Nyi27OF
	OHrvzq3NjhbnbblQMBan1ZqzqLPaQR/c92pGIkXCJxWr01H5p+3Xl78c
X-Gm-Gg: ATEYQzzEPvHcBj9hgbEZekj7Daoi5AWOY0bG7iJqYYJE2dgOf9BnbQu6/WAWvI4PmMc
	nsZVlh/04FDf4FybIblpRsvsKeUFabeLMU3S79ywKJZu0MlUo8fkPUNbPgdmGtc06A9x3Dbia82
	rsg1RhV9TEqCMYsrjx64aAVvbfy7zEjU+yh5Fiaka0V/cACXLBiNlZFG8RKRjYSoHWgg+XA1xFs
	Yj8dXKD6VPlWRXUk2rAg+LW00IFEneCpJiR78MfEX1m/QPB7F04mjW4LAzWBDPh9/CjSaZJXfzm
	X/6bK3J/9N9OukGipXINRc08cRES5hS9WENXWIt8V86KFf8TI6vid8WkrEXwMsnjQjqTiNS1xV9
	TKZCRiJkc15KiNR3B/E7727s6tMX9X7EiqFn89qzAlIqp6nwVmGHE8U63p4y3UZktRX7uQLM6FA
	g9/qsqkXw5V7mqDs3j2Eq4Bw==
X-Received: by 2002:a17:90b:5282:b0:355:35b0:8b83 with SMTP id 98e67ed59e1d1-35965d02c06mr986223a91.33.1772152456373;
        Thu, 26 Feb 2026 16:34:16 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5e4aafsm3040811a12.4.2026.02.26.16.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 16:34:15 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v3 0/2] net: ethernet: litex: minor improvment for the codebase
Date: Fri, 27 Feb 2026 08:33:46 +0800
Message-ID: <20260227003351.752934-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261639-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,antmicro.com,gmail.com,jms.id.au];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14DAB1B13DE
X-Rspamd-Action: no action

Improve the litex code for using the device managed function to register
netdev and replace all the "pdev->dev" with dev pointer instead.

Change from v2:
- https://lore.kernel.org/netdev/20260119040446.741970-1-inochiama@gmail.com
1. Apply Andrew' tag
2. patch 2: wrap the line to match the characters limit

Change from v1:
- https://lore.kernel.org/netdev/20260116003150.183070-1-inochiama@gmail.com/
1. separate the original patch into two patches.

Inochi Amaoto (2):
  net: ethernet: litex: use devm_register_netdev() to register netdev
  net: ethernet: litex: use device pointer to simplify code.

 drivers/net/ethernet/litex/litex_liteeth.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

--
2.53.0


