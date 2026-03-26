Return-Path: <netdev+bounces-271986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCtrFd4YxWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-271986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:30:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B08CC33486D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FCD930DA1C4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570BC38F22D;
	Thu, 26 Mar 2026 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g441ur58"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CFD33D505
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774524000; cv=none; b=rNXuLDMtV8GEsNyZixTRlDucBal6Rjgz2j+rF8LrLnpnq7Hjara9SUT4Mhg+FKEX8iukJSdf9GCQZfBXlImOb3e5hEp5RFd+2EpXVI67qJujXcOjOXjfVUzduveqMIhzZnY9Cu5ESRj1ZZCXpP+Ka8EOt1TLgiOhAwlvX8wEe60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774524000; c=relaxed/simple;
	bh=pjR1FeYWT3fCK07KymFSlvdN61443JK+C04q/CejLQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIcfa4QXoTQSbUJmGpA/phYEz+a3n/CY3yKcP00JDY1sNLCkLNfmvzjZYEHs927vOWQuFw81xyetIPagMy1RdOGGhg6LryD52VVGx6pcWuq53PaDkhG/0qXcw3+BHNq5QhiQIqdqafoAbN9r96MhrVE9drM5eVZb39dWqo4p+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g441ur58; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso6535935e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 04:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774523996; x=1775128796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1cM2Ed0+UHaZsndyPhA9BP7E7XUawbgfNpYu8w9suDg=;
        b=g441ur5810zFIj8p/ikB4/u9DQBIEXWGcwR0c546n+4wOqdhdX8dHbARNBS3gVkQx+
         KwU4yJemUQL57Gu/7Wux/arX7/4F8PCOaeeBItmkafzJUnrqaXl01WpxMB09N4aqjmSp
         B8ORP+zmTcB1EOISOhYCFmHeAEyctm8VxJ3i67nMXkwUkXEylLYEByeBG0MzynapI42W
         ROyl+IGbDgpSnhaIh9AZD3yRmUSv+4ZXAVTnT/+cVEVtVB4TEDWbfAgV4fUynvh6Ev8X
         0h2/XjcwnMsqHt2ttXPU0qo+I2DYs51ZZ9QXhWFQg1AfXBb/2jUxPMX+mhRrb9wL7KZJ
         jcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774523996; x=1775128796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cM2Ed0+UHaZsndyPhA9BP7E7XUawbgfNpYu8w9suDg=;
        b=PJOQ5wW2/YF/u3FoaKk7SskU3/3yhj5woC/rT3GLwNpj3GEeJJp3oG1R4SHJxO/9eQ
         9fq/rCjvGMFXLjWU0nKkurZdsgVmAMhSjuA0YgbfRGLgDAFWaNluYD3ipBvBtj0Lory4
         i+GYutwqHn1yelVHVTxHpHOvIQGWJvqhlqgmytX+lCg0IDx/cgJ8nA27yM8Y50Zo/g9P
         RWt/TNkMLlceQPEOyZnlK3VDgrFcw3AxpgVUyUOEK95/GZt9xxT0wYZjbN0uBu1e38aF
         UyLkhLo7Tcz5M0JNFL7XUyikuTL4wZzB4Z1I4rtcYaJoahe/nwtiwE2Ojz+T2CJa0uSc
         pVaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvMlawRSO0CQgiBd9ILKJQ+q+zeiCxj/3VEB5P3Nr8GDZx+N12CGD7o/L9iMMOiOQW3clPRy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SZxWgriOC2/X27xBpUt4uMeCLpGKonUaO4JHr9EmbX7SWi8i
	X2k+oHGtW4SWBSLqmCDgfpf5vPE3VgAU0DbAbWENvhsRX3tOYrqn9irK
X-Gm-Gg: ATEYQzx8eF5KJ2EXY0A+v3CmtNCuxsaqp2OB/WUAV8uO+9fmc4fvQziFDIlhkiN+fD3
	/C7AivZK0qlOhFT4Mw6Nma1p7uq/VWwv5lyTfM4VKqUCPF4Rp+611jHRawYGEp2XtI3qq0zGgXC
	HYRAOyw2L0b2GkgH6mV5WFGsLjkABuCypuG06oPdAZu5nNmDcH8WNFDtZXU6icdK+6iAY8bL8Z2
	DG9ee700AbG1PXnT/2p8HYf+++/U+e+bKhlTwpCeMO2V7OjfD6NpFI9+fcPK24CZo7HoKucEqUZ
	KEFqNvVNhjnUy6Gqj6LwcdAliPGPlhfDlEDjT1HnrB2S3CQKbQFCE5ObiuRgTrk2whlgZ+6MyYl
	N1SnnSvGgycW5BkBVYwT7ybd1eI+U4POCWJrIuzWThfZpzs7tLGEmbV24OtirygFMuXb3JW2Y/Z
	TmpxeIBHQrkRV8AxjitiEeUugF1asPJA1diyQo5Lh3KhHTDuqj
X-Received: by 2002:a05:600c:8219:b0:485:ae14:8187 with SMTP id 5b1f17b1804b1-48715fc3250mr98179175e9.2.1774523995840;
        Thu, 26 Mar 2026 04:19:55 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:377f:9a3e:6c94:560d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872092e105sm13428045e9.29.2026.03.26.04.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 04:19:55 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 0/2] Enable Renesas RZ/G3L GBETH0
Date: Thu, 26 Mar 2026 11:19:48 +0000
Message-ID: <20260326111953.31024-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271986-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[glider.be,gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,bp.renesas.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B08CC33486D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

Enable the Gigabit Ethernet Interface (GBETH0) populated on the RZ/G3L
SMARC EVK. The eth1, pincontrol definitions and hotplug support will be
added later.

This patch series depend upon [1]

v2->v3:
 * Rebased to boot series [1].
 * Dropped ethernet-phy-ieee802.3-c22 from compatible.
 * Fixed the typo txdv-skew-psec->txen-skew-psec.
v1->v2:
 * Separated ethernet dts patches from series [2]
 * Added rmii_{tx,rx) clocks.

[1] https://lore.kernel.org/all/20260324114329.268249-12-biju.das.jz@bp.renesas.com/
[2] https://lore.kernel.org/all/20260128125850.425264-1-biju.das.jz@bp.renesas.com/

Biju Das (2):
  arm64: dts: renesas: r9a08g046: Add GBETH nodes
  arm64: dts: renesas: rzg3l-smarc-som: Enable eth0 (GBETH0) interface

 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 241 ++++++++++++++++++
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     |  34 +++
 2 files changed, 275 insertions(+)

-- 
2.43.0


