Return-Path: <netdev+bounces-241091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96674C7EF1A
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 05:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E49B4E0606
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 04:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2602B9A4;
	Mon, 24 Nov 2025 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxP5yuV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6DD4F5E0
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763958828; cv=none; b=DMM4PBLJthRaIEXc+4yc/A/ctN9QSKGaQtnCWD5mbTY/qs9ce5JkzRJUif5djKk0UtG0/+9eEKSh1ZC4exhGxjgf3hcHaHQOmN4zQ0p6a/bgEvVmg5cLIBeAUF+CjZ4TpF6FWjUi/HWetApIvsyPxwsJchqR90ZA0qFh0x84WYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763958828; c=relaxed/simple;
	bh=e/AoVpfDZTX9T9tXTF5+ahf5ohAApaI0wzYrgFbGYpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJA85hzyNTrKBbt9fYlJ+fFY501HbFVSxJjPgxa9q/KuQ8FWY4iy/BxvVsYYm6cwqQOSiOKzcdoK6nyM6YWsT1z0nvluwrb3VcpL4IFZz3YScuHEO7AYBdUOtlMqkHSlFr/vObmDq7d8og3CcB/YWpryYhApi0ods+FL/aLJ8D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxP5yuV6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso3050088a91.0
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 20:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763958827; x=1764563627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VwZCpr6ssGUGaDo1rC+G3OqGBhMarfgRgqSNAILF2xU=;
        b=CxP5yuV6WH56yJOEljtEfKFNsf0GdlCvwbiT7sxGJH7oslZdt/gXgCLkwnJbz8gp+n
         I1e1W7+zuV1bb59Hfm+tZ586BO2mZYAKo0D7dd/whq50jY69dLsZiFvKD+4BkgLo51no
         zqTAtMmbFZIVvdVQc7Ghh2eVaKGH5dnFAYdx36dC2CSudz7rFpbQs1vqoCTORPIGoTY4
         uxiRlbdDZoqbatbGl/DNK9gfLqoKmMFZHz+BC7HIC6VtX/PdEQrk5hM/Z4fY4mtZc6UD
         zbvqLgOmH8gZuMoB4Yf61nujeCB6egzaGdvw36AzRMQxKYDxr+DkP37WLBGDj3vY8vKE
         fwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763958827; x=1764563627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwZCpr6ssGUGaDo1rC+G3OqGBhMarfgRgqSNAILF2xU=;
        b=GW8JKIH/8DoWjqg626QlyUI7aU+tx7WPPAmUzEhPdN5gsUXV1KExqviJ7lG2A6bEvw
         MpzHZADC2X+pA85gpUT7y8QD/XQx3K9ABHXpiIOKidoVGf7y6WO0u+beoh3BCyjoLd5t
         LbVxLX5KNrHltyocekyR+Ocv42eJke1m/6ymNHmD9JktGA/ziPjjAJVAd0MZCLoNnzLe
         y9OgwRyHWxt+bn2k7GXtSA/kZFOFBQcPlmbZjdp2w8IgYKimPatblDe0EBp0B+ZTYQ0E
         XSE+QKP3/h8qgaCRpZmFUyQDSsyZIGtKqv6p4uFLQqRbVjJiKtJvcZFL46rjEHhPBpGT
         2myw==
X-Gm-Message-State: AOJu0YydzSRnOWcRNlcjgwFziFRfJSMV02CcOcv4p9bE/EVLOMLBCsqI
	Gb7Hirsyapd6xlOL7wH2519uJDqdK4yJdsYONN0lCdCsyzMD1F1zZ0do5Af/FiMM
X-Gm-Gg: ASbGncvZrk1Xy1+NRBuKeuI0TFAmM0O7bblnsWw8hR//sQyDE45nJg0OkUvMfY2VZrr
	U+HfLRV7SgQt0JUJv4lcVj8fxlRuqETxiVoCz+66rnmQoaDhD6SBEJr7Wc/2YOCNplnWNmwM3EL
	IaJXVYY3sQxQiENd9qJHf1EdmEc5DFt1ViUnT2VsdkDT8lLfp32tmdwVacy7rI+jEk+Z7obFMvJ
	MbUdd6WJbV6RHTTvbi6Nr7r+M43XeLPP/vKZSRG2OfuuziCvSaBSjaBWMVDpqd1ZKpvBH0HNCvT
	jS43F6kQDq94BI7UIwyuMyp3X6wd9UOZkoRj5Dgf5naX4dUuGek4Sb4o937pmCAi4jec7cfwQlM
	l0x6PoKJFogUh7QKkUbasSmHEBJ+gZyXPe4Bz5T3lzEsbrlJ5AzxSpIUKWtrhMklaSBatH+DxZW
	CCXgM+Az5Z871PSIB5WI1ZL/lDCg==
X-Google-Smtp-Source: AGHT+IHb7/aqH/+p4pJDIK1CtU38aKJN92+dskTs7d1v7a/SymEoZRWv9YZwT22DrNS+llarXwSVIQ==
X-Received: by 2002:a17:90b:578c:b0:340:e4fb:130b with SMTP id 98e67ed59e1d1-34733e92f94mr11296929a91.14.1763958826590;
        Sun, 23 Nov 2025 20:33:46 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af0fcc0csm10359878a91.0.2025.11.23.20.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 20:33:45 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 0/3] bonding: fix 802.3ad churn machine and port state issues
Date: Mon, 24 Nov 2025 04:33:07 +0000
Message-ID: <20251124043310.34073-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes two issues in the bonding 802.3ad implementation
related to port state management and churn detection:

1. When disabling a port, we need to set AD_RX_PORT_DISABLED to ensure
   proper state machine transitions, preventing ports from getting stuck
   in AD_RX_CURRENT state.

2. The ad_churn_machine implementation is restructured to follow IEEE
   802.1AX-2014 specifications correctly. The current implementation has
   several issues: it doesn't transition to "none" state immediately when
   synchronization is achieved, and can get stuck in churned state in
   multi-aggregator scenarios.

3. Selftests are enhanced to validate both mux state machine and churn
   state logic under aggregator selection and failover scenarios.

These changes ensure proper LACP state machine behavior and fix issues
where ports could remain in incorrect states during aggregator failover.

Hangbin Liu (3):
  bonding: set AD_RX_PORT_DISABLED when disabling a port
  bonding: restructure ad_churn_machine
  selftests: bonding: add mux and churn state testing

 drivers/net/bonding/bond_3ad.c                | 105 ++++++++++++++----
 .../selftests/drivers/net/bonding/Makefile    |   2 +-
 ...nd_lacp_prio.sh => bond_lacp_ad_select.sh} |  73 ++++++++++++
 3 files changed, 159 insertions(+), 21 deletions(-)
 rename tools/testing/selftests/drivers/net/bonding/{bond_lacp_prio.sh => bond_lacp_ad_select.sh} (64%)

-- 
2.50.1


