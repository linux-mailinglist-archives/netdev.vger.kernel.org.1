Return-Path: <netdev+bounces-260329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF+bB6IqnWmfNAQAu9opvQ
	(envelope-from <netdev+bounces-260329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:35:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 791DF181ADD
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 136D331799B8
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC8527A927;
	Tue, 24 Feb 2026 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFsPvhXl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33D2820A4
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771907536; cv=none; b=H+rEmmX6pV+1ez7mnk+o77Qd5408UI15f9BhcSvVxQ/ooymgmBiv5WdqoAmQ48yJO43IaE/GFtuf/UoR5RuFfqdeYlL0KhK41COTBDzfpuUGHs/ZRkJ8q41qnyRQf2gB9oMXUpVOWtCcxYCdDOjIJAhhRvvYZoxHgLjmf06kYlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771907536; c=relaxed/simple;
	bh=PL1uF+miaRjncn9pPofTd48PdjMggPgKMuiNmOSdqqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NF4NrvMeOwj59WBTds2mD0zBs/fjv8tKI+e0z8QRczGhMATPE04C3QXjVa77osR1qF0p4GPAzdi2uWQASC3qMqFQnYcY2F1OJ6xww0aGPPudUo43ZFhmxwvsnzUoYVWEq6lM1PtoQPZvMnnZBIjNtLRNIjYKYz3etdHe/anbBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFsPvhXl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8f7a30515aso588194966b.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 20:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771907533; x=1772512333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWFYHX4cmQ4ANjjDRTxWDPBizHkpnwZrz9MSL1ntByw=;
        b=EFsPvhXlqISUkdROhUevWP5B8qFIsdytmWuvS/H5TVJQOd4zlW6ZOvmbwaygK1rpKm
         AwwVHlFtnMgNH2CP1ILv6L42SdmT8Tx6cyIK70Xq3m5p3wfdpz8vuWbLIa8H78WdiQpr
         jOQ5wdnuRj6hWHwrl9mgxI/XGsHeFmdxe4Ofpg7Ec5o9xur1M6lP8zv/eW53b23bUGP6
         9MAWtMLVzFKewQA/LQrsVtSB0nk5nQzd5g9nTntyY8Rmye0CnEgzWnlbQQufadOv063u
         3frX8RxuED/eQc0cnanQVHFOShzY1xfzIOsoXZSo3tcvRxHbVKcenY32thLHxf2DzlS5
         e9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771907533; x=1772512333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RWFYHX4cmQ4ANjjDRTxWDPBizHkpnwZrz9MSL1ntByw=;
        b=IpUf0SbGu23SLSQQWNBEx9seAvoMWF+Lq5SdDvzPurrU6lCuhRhX2SDtzmwyH1cmRy
         VZAADP0D8IarGDuXNk7XfN5UmeK8EkRIHlxmVo8epelHfVTX0d9cXDUCDhfOian4MrKP
         5ttVodsnQPp1GDaSZ6YoLyawhGReQfB+FEA+Jgexj9lj/SnrZY1tkptAk5SElRKXD5ir
         GFEpBm7V4MvBhOr9XN6Td+jm1eAV+7ISuqkaPBBK7R7Y9N2cKVcAyf3u4AcUo3G/JRtL
         Z547ZkBIHZi4jlzSI5iXqNyjAq7U/EC4al9PQzvKYijGGsBWe70/ZcyEc6CvSJjcQZGq
         3E4w==
X-Forwarded-Encrypted: i=1; AJvYcCWm3r7aPdAiXPUGj5/HigEsH4q+TcelTrsgXAM4TOPJ3E/r1sSl88IJXLkOv/DEUs/UXFypPI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNz85yNZic2bHxGERAIY987uI+xE2jW1UB9kkn44TjXVd2Nwqs
	TTtGVuPWw37wi9TrWWtHPdzzz1vKYinwK5/w70ZL/mprCiG6Ux7G6TWYeJPbk4bvYfRM/HRR
X-Gm-Gg: AZuq6aLQ/xO4eO3WZyhv5U4diMCVhxlXuMKQbskXZ2baEuvLRHXs2daIoQmhCCpbORI
	AypMNCgi9vH9a6nkG6vnPiTTXfXYMxnOhyMOnn4BfdJ7pDuSrfAOcXThYn1hSy3EkrNzlPKRS9z
	Uv2G3xYcdOiYrII+RTP+bntlvwzSh29pa6lRZV9KctgcbQ90hMD/xg62tgQA/2EHzoqs+Wb9DaN
	tD2YOGCvx4DTkaSiXeiOXLlKDqIutMlUOXQg7DUaO0dVdOzNCasKjIgBdJwjkxSfghxE9XG0KCl
	njxtK/BfTEc222M1PGWSrPwfRQ/Q6Yuvh9AESiE1n29lWlwUmiaMdBjxT6vP07/3OS2pf5ykcyt
	dBWXSvCfqp8MGuapw9HWWP95kD9+WPtGhx2XVOxuOIlTIFb/iWpcso09l0Y7q4jtWtqaPqtzoxg
	4IN4ygCmCAF/4mjxA45o1jBuQ2TqTycj9kklXUolLnA/FH4tY+o4Gih+smjo4x1GrsJbdzLUwTe
	CaU/jwj8LPOBWs3C1HJb5c6BlRmu7BTmbuk1mFQjI3jQIYk4S6rAJ14bo2aCEUjPQYzVkOsag==
X-Received: by 2002:a17:907:1c22:b0:b8f:de1b:78a with SMTP id a640c23a62f3a-b9081a2ce44mr719504166b.21.1771907532815;
        Mon, 23 Feb 2026 20:32:12 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-b.c.i2f7e30109524dc12-tp.internal (206.242.32.34.bc.googleusercontent.com. [34.32.242.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9088c8fc30sm371284466b.63.2026.02.23.20.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 20:32:12 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH net-next v2 0/3] net: phy: add Rust reference driver for ET1011C
Date: Tue, 24 Feb 2026 04:32:08 +0000
Message-ID: <20260224043211.1747-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223220504.2102-1-iprintercanon@gmail.com>
References: <20260223220504.2102-1-iprintercanon@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[umich.edu,armlinux.org.uk,kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260329-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iprintercanon@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 791DF181ADD
X-Rspamd-Action: no action

This series adds a Rust reference driver for the LSI ET1011C PHY,
following the pattern established by the existing Rust Asix PHY driver
(ax88796b_rust.rs).

Patch 1 adds a speed() getter to phy::Device, needed to detect speed
changes in read_status.

Patch 2 exposes genphy_config_aneg() in the Rust PHY abstraction,
needed by PHY drivers that perform custom BMCR configuration before
calling the generic auto-negotiation setup.

Patch 3 adds the Rust ET1011C driver itself, implementing config_aneg
and read_status callbacks. It is a feature-equivalent port of the C
driver at drivers/net/phy/et1011c.c.

Changes since v1:
  - Added speed() getter to properly detect speed changes (Andrew Lunn)
  - read_status now only reconfigures registers when speed changes,
    matching the C driver behavior (Andrew Lunn)
  - Removed unrelated dim2 staging patches from the series

Artem Lytkin (3):
  rust: net: phy: add speed() getter to Device
  rust: net: phy: expose genphy_config_aneg()
  net: phy: add Rust reference driver for ET1011C

 drivers/net/phy/Kconfig         |  9 ++++
 drivers/net/phy/Makefile        |  6 ++-
 drivers/net/phy/et1011c_rust.rs | 75 +++++++++++++++++++++++++++++++++
 rust/kernel/net/phy.rs          | 17 ++++++++
 4 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/et1011c_rust.rs

-- 
2.43.0


