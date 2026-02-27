Return-Path: <netdev+bounces-261893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJDcHAO5oWkYwAQAu9opvQ
	(envelope-from <netdev+bounces-261893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:32:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A11B9D4F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 326B230BFF4B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B733F074C;
	Fri, 27 Feb 2026 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hihaAwzv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7A275AF0
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206004; cv=none; b=LFPMT9ip0uMpNNJ/Nuxfrx9YcuYr1jPpuhQhFz8dgwL9brtzYxG5Lsp6EpAkXk8tMWdN0kgwvfdN5DqO5dsW8W3SJF0ZPWOPkDa7vk1BQvkOWaJLuSlBjNF0jChTHHlrPX1ra7TKb8b3TFHK/FavAtAdesQyWf1xU5s4Fl+cZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206004; c=relaxed/simple;
	bh=nB4dU5ro4rB0p1psB/tOgNtIOVTU8bVlg3/4Kp9rrRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HYReXvwQAY2BuluAEQTn8BnE/EFhmewsiPPMoFJUgNP6D6ERVVvX3qZzRXo4pY3DW0qFUahC8NmJq8ojwHf5+JHqs7anVZyk6EgXRcK2WinMYKl7qhUF8T4y9p6U1Fl4CoKNHdBG8c9aGkihH9VlgNqZUOq2TVnQiAIMOicGFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hihaAwzv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35851eadc17so1301651a91.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206003; x=1772810803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UetmJfyt896bziHLm83oQ5Y9tswodav8qMkgJQV6wLA=;
        b=hihaAwzvjQqo3nkDiM3b31Iv3mE5GEJwj5l/yTpAzoFQSbbccHT9cZPBmVuilOKrTR
         hvzhYzNwq8/JdmWkkNKldR2BAiGXp5d7PYZSHNdQNBqr9mUizmtdIefp3JbTq2EwtCDl
         S2lv68D8O5bDb6jnk7upw/9XFglHTn3jdAGgFF4apH0zN0HtE6W+jp3tI70MdsuyEibT
         M51y8m3mCJN1Ky8uL/O/E3vtIptwNfG5d3FJNIUm3O9lJV0SvDji9fX8y/7UX6tGL1md
         KtI8xGQDOPakcuH5qSVEFxATapfYf9KofmkF/Q2ENGtCLmKoHuoKJyKeEoZjNyVT8ZVe
         g2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206003; x=1772810803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UetmJfyt896bziHLm83oQ5Y9tswodav8qMkgJQV6wLA=;
        b=q4bL+FobY62x23IuOsGXlIO4O13fuUJH/I3KtLUnIZPI07wDehgkZiD3hyPIQxIW06
         Zc+SQlPoLotJCSsiW1Oli1KwBkxcCur5LtyTQV2Dx6rCRfs/84Apsnf36AxJgTmdya07
         PtGIl+NUbkuhPIsal3E76W/T9DzhH5OVB3CA7qpFjUaFZgY9d1o5Q1sf4oxlTsxtjDNZ
         LIzVsNG24x4/aZPi5hwP2/qv/pr/YuQC0ZYUluXbJr/MKpRhmkK3pyMLvi4gcGwY1vzz
         oYhKOprrOTm93XaWur0UX48I/0ZR4N9M5MAqLvYO91hWbPAqLRgfA6u4sgAGIeoEP8Si
         dOFg==
X-Gm-Message-State: AOJu0Ywq/dm3KdIriswcHU1RSb1Px+YDe8iWDSPVg1TWT0c3Mhgh8JrC
	5DpiKLZe97W0vyzFNeqICFyLTAEDIFGAyBL8b/5wJOOQ6rd04lXhTafP
X-Gm-Gg: ATEYQzyu+5sUXzLhNuo2AFsshp8kA0lyJqz2nz126B68Gh7TSZ8YhATHhgaHaFNBs0C
	pb1zHPtRTmrJxaA6exePSGwCixgiW3nfSM6IRa8agDmXY4Sc6BhiUPSQXZPRwIb9wubSfDtrRMx
	MEIXfjcRw5BKtDKSRgSlLncXyz51uWJaFZONeYdzVCXiQ7Bu54D72+smWdBH6jlLVq8651TIR/u
	OmwnCFo+1xn76ZG6y2gvURnJ6CaMTOmSVIp6XQT9GxTm6/J9Z3QoXL5vQ1VvkMjE/QJI97PoLi4
	GqELEqApFcRohzaTLWGgpTiT2JxSMH8X5TizjVCwDejOGhTMmdHoI5uH44SCEzc6bbm8zQ35UhU
	wf4oS75hwxPYMk1vj2Qii4fe0f8lr0HgnGHL+51WglT7nRGIoANqYpISj7rqzbsr2wA/9gGUgTU
	vJRlPoCi8XETrXwoIP24rufvq5FZxs9E7fHIN0Y8iQ+UtLl0oQxyMlshd8mW5eeRMZcbNfxXXh2
	+7cfH8=
X-Received: by 2002:a17:90b:3f10:b0:359:5a82:5f98 with SMTP id 98e67ed59e1d1-35965b2fec7mr3609795a91.0.1772206003011;
        Fri, 27 Feb 2026 07:26:43 -0800 (PST)
Received: from sean-All-Series.. (1-160-203-78.dynamic-ip.hinet.net. [1.160.203.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35900700e69sm9053211a91.0.2026.02.27.07.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:26:42 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v4 0/2] Fix warnings for RISC-V builds
Date: Fri, 27 Feb 2026 23:26:22 +0800
Message-Id: <20260227152624.164964-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-261893-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D5A11B9D4F
X-Rspamd-Action: no action

This series addresses several compiler warnings found when building the
kernel for RISC-V.

The first patch fixes unused variable warnings in the NFS client (including
nfs4proc and flexfilelayout) that occur in certain build configurations.

The second patch fixes a format-truncation warning in the MACB ethernet
driver by ensuring the snprintf output fits within the destination buffer.

v4:
- Refactor patch 1 to use no_printk() in sunrpc headers instead of marking
  variables as __maybe_unused. This provides a cleaner, global fix and
  enables compiler type checking.

v3:
- Expand commit descriptions to include technical details regarding macro
  expansion, as requested by Andrew Lunn.
- Test the different platform, such as ARM, ARM64, X86_64.

v2:
- Split the original treewide patch into subsystem-specific commits.
- Added more detailed commit descriptions to satisfy checkpatch.

Sean Chang (2):
  sunrpc: fix unused variable warnings by using no_printk
  net: macb: use ethtool_sprintf to fill ethtool stats strings

 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 include/linux/sunrpc/debug.h             | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.34.1


