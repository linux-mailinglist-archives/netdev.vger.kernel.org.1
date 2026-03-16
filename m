Return-Path: <netdev+bounces-268009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L9kHUpnt2mQQwEAu9opvQ
	(envelope-from <netdev+bounces-268009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 03:13:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0D0293D90
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 03:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD843016514
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A36330B520;
	Mon, 16 Mar 2026 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJFxpa95"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F912DFA4A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627029; cv=none; b=R3MTL1jmq6f2nVB0mdEmdg4s2fFTfZoBH1Ch5SR2+exGy3yvSREeI/rvb0cJI1ftmSC2/hZVlpdH+cgRCzF2M2NApJNmYFOQN/J9eS13HPdeTAi941wiudZ0DYgZaO07siLT/y0qtEC5YAr7okOi5UgeZmUq6mcA0J2WaWyyWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627029; c=relaxed/simple;
	bh=VDfs2ZzZ7PrOeFBVnLQw/hMFYfMhAJiuPwKNIE4+KfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/dk/DrZl3UxO9EdojslTRXyZjlNqaiZtJdPiFwoRTjpAsMRirw3aUFi4dKXFdz83biCbx4dnFARGH26yvYsLY/ZzIdjghUwAZNTrZfXQBGc5p22bppexZi7tGXXHtRGKWrUzNlZ6mYgn0qqMZWjwJnT+movNTyYDe1tlHhJdcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJFxpa95; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so4355001a91.3
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 19:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773627027; x=1774231827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVE8EHBWMVmiuxrDtBRiYzF9KN88X0W28eYNYUUIxFI=;
        b=BJFxpa95xssz2hGe+ZpabFKZe4y3Y5Np0FTUuF/d9y5ZNIre/OCu6LtsUM7buBKPxH
         S/DdppvgoIjOO9zExi+NNowL0Oj4oQ7gqBUErbFpaQRBIOULhO5CAFI538RSBx78uyeN
         72V066IpAs6IS503umEHVgdipTYhkL/YVIoljc5oX0723a3Fxxa5BgWr0S3pepAMZ7ze
         T44tcYEFtL5mYOc8rB7cC6hcrRAziJB88KH6EhXK74It3mU1b4HpRg8cgmF7avrTtis5
         UXJudOzxW97FkrtuO3BUdnn1nIkH3i5nvPVJMotSnccRY+a9n7NfcHB7zjLHyzAP6PqX
         tSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627027; x=1774231827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVE8EHBWMVmiuxrDtBRiYzF9KN88X0W28eYNYUUIxFI=;
        b=DCeLgik/2gKvGKKX5CLywqwWc4X9YZmgssiTF9vrl76xWtQp6n8Gt/i27ywnpXl8Gq
         ohHn9EvCZeTw590oPLSxrlJX2dQ6z59P+YKWv/LcAiXsBjBjYxhhJcgBSYrdXxGKrCsg
         TXCskCXuFOgHZD9cAnHQpl4OsyoxKbrwQnDi4IjWx2Fd3u/v7ikjGdbdX8WCspjGOupv
         +69v8WORU632Yoekjir3gU4BpJw1M8EKMRDIrjI98OyzndCipTkQbR2d2k1glkKWIyX9
         8UwFjCVslDfQbkEhEI2eHVjRQLcyhl0Lfx7+DwaRF5MCXrxHS1qeWhoBqFxDgIvBrSho
         OOvw==
X-Forwarded-Encrypted: i=1; AJvYcCXy6522tGCsu2JCVlmCBXb3IwJIp/gy4f5QN/3hZ7yjFjyfb0AQUNSIq2l3e+tI/7bvzHzqxUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvlHkiGIpbIAQg/lRiIzuwgRiWtLK38TjMT/Eis8bvTu5cojpY
	6teLCmD7N+/kAZX5LUL6VA8CehdkprXc7t1TaYDTIA8vXpMrjmNtYLN7
X-Gm-Gg: ATEYQzxMi8i6fZzGqsfvxm2qa5n6CaDtSvapdOrj8cvDp5w/1O1Ngv8N/yaMPZ4uAJW
	/gnv3Hh44YXHExzvyOoC1GhbFm0CYUnNh1f64tBYWcLYGMmIU7pjb/5oq5rQ/DHM7Pgn5kZaVHh
	LTJ0Ytp8ewTQIrPBiaqjImsI4WUOHyzXjYZ8/yevvFEApfGJUvk4Gn3Y1tqr0v7ydU65VRtOeW7
	6d2FKIGmJAXAIiOn4ZYjuUis/zAHdB+gxKEZTiSIvTAU3rR/iWks/snHsSkh8GBuY4WNnf0/7J9
	w7ZzKBC23/ajz3BKMzUDCdQ6/NjpVDFGQZtjrSxCfIxW0eZULHw2zkKhmu6N5CFNVoeP5bTofbe
	+7+VDFWmyjE8WCQbgnRq+MrIit1uVia0IkwB6vB3ujy/uoUof5srp0eMZ5bCcuCrqsniOUKQyFk
	pS3suir1neCwxKdIADxG2rfq8LcQTRWW6e8f48rHjmXULnGSjrcn19RfSCCP5gvhjG
X-Received: by 2002:a17:90b:4e8b:b0:35b:a53a:7d0b with SMTP id 98e67ed59e1d1-35ba53a7e94mr399741a91.20.1773627026902;
        Sun, 15 Mar 2026 19:10:26 -0700 (PDT)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffdfb7sm17705805a91.14.2026.03.15.19.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:10:26 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 0/3] stmmac crash/stall fixes when under memory pressure
Date: Sun, 15 Mar 2026 19:10:06 -0700
Message-ID: <20260316021009.262358-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-268009-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD0D0293D90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi netdev maintainers,

This is a pair of bugfixes for the stmmac driver's receive pipeline. These
issues occur when stmmac_rx_refill() does not (fully) succeed, which happens
more frequently when free memory is low.

The first patch closes Bugzilla bug #221010, where stmmac_rx() can circle
around to a still-dirty descriptor (with a NULL buffer pointer), mistake it for
a filled descriptor (due to OWN=0), and attempt to dereference the buffer.

In testing that patch, I discovered a second issue: starvation of available RX
buffers causes the NIC to stop sending interrupts; if the driver stops polling,
it will wait indefinitely for an interrupt that will never come. (Note: the
first patch makes this issue more prominent -- mostly because it lets the
system survive long enough to exhibit it -- but doesn't *cause* it.) The second
patch addresses that problem as well.

The first two patches are minimal and intended for stable. The third is a
general cleanup that removes the `limit` clamp and *solves* the issue of the
loop mistaking dirty entries for filled ones, rather than *avoiding* it.
Because this final patch changes the range of stmmac_rx_dirty()'s possible
return values, it's intended for -next, not stable.

I look forward to your feedback,
Sam

Sam Edwards (3):
  net: stmmac: Fix NULL deref when RX encounters a dirty descriptor
  net: stmmac: Prevent indefinite RX stall on buffer exhaustion
  net: stmmac: Remove stmmac_rx()'s `limit`, check desc validity instead

 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.52.0


