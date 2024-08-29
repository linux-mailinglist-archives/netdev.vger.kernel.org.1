Return-Path: <netdev+bounces-123515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F796524C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD3D1F21695
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAF01BBBDB;
	Thu, 29 Aug 2024 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiAAqjrH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015A1BB696;
	Thu, 29 Aug 2024 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968126; cv=none; b=BFcK9IGE7qAi3X/FRdGb5x8hiVJN5lWvDpu4UA01VA50ve7A5FzJfnsr1gknnaSgnHX+t6WyhfbOaEPqEaRzdEi3ilCTVjv67Njq2kvTOFV1yXVNQIWpVvIlE+K/0Sdd22fDPFa/M5Txj7wN5aUhVyvQ45JR0NTkULEcpVML/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968126; c=relaxed/simple;
	bh=DpvWD4Hx+ubjtWZr0SjKbPjMf5o7Xsp9yXZxbet1eYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPFm7aZX7pBn606Se24DTk/rEVlz81G9gVUy/Lvx76W2TTRl0L3IP2FTStLEdklmTSVSRTPFInkpveNUb6IpNPpo3FyPg4Ug3qG0PSuJkJIQzbDRIY82N1vuDqAWZCvJ3NIAclG+u0oxAkF+S8WLyrj1yj/Mn+C4++U6uWW5p0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiAAqjrH; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39d3b31e577so4961255ab.1;
        Thu, 29 Aug 2024 14:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968124; x=1725572924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIWx7O7Yfjr0NlWYq8rnxK+R+TlNba0mB+FqBvJfLL4=;
        b=BiAAqjrHiMPgRPL9Yf9PznWYWkyWIGlnFdOmdcTjyVekSRoldSLQdpMoP9O8a5mxwT
         VRBhApGhlTO38jgNQdNR2MtlcEdp3ADVEIJCf4lDlgogeLnVn/liwrbYR6thVqAiELJQ
         uIE0RAwjhxP9GMSBnGTrKSqJQd6pLLiuCbkvVdZJG6lNdlTDeL7L2PKL6gseT8NCzE0m
         vOLx0E2QLg/nPAdryu2sDhJREF+ZxhSqJWqitctJpboV4bTrYGPn3MwPBl/RhWJP5wo7
         7lFAe454U7bev+oCWOK6gFwxPNmvaVB9Ua64JlJWIugwIUrtlna9tDuUw7/Gj8Euzl0R
         kmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968124; x=1725572924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIWx7O7Yfjr0NlWYq8rnxK+R+TlNba0mB+FqBvJfLL4=;
        b=DbQdLUIj2As3MoZsU/6Op7hlgjngGWGEYZXYRly/RSl0+nFNlJzebZhfYtDehLg7sH
         xITfZAvCpf9rsbMNykectdUhRIvOgDWeVoTrg/sZVcw7OC4EGw35Shb7mLAHJTYmgMKY
         rpAwVNp6uu25yYWNFqxwINxlGYAgQwbCG+w5ylnhqdKt0z+UhF9ApsONHqBFgn6epB/m
         Aj3bq2mMLEjelms3gKXcnWEuwCSnHmXjeD1F6SPNPhVFPeglejj+YpiRYl7wIWqfeNoi
         lTHx4Aq37CRxBTTOjhSGgXcDQsVT/Tg1TO942QEMxi1qDn9ruj96VjpmFnRvT6CVLAxl
         RBQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1L4MyUegXwHZ/+kW3SCrykzoO3+siU+fRyFXD0OOP99QlWfliFZiMmcBxJrhv5jFmht1D587aA1oWI/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrkykkgO1kOyWmO9aZM/qnH4cmhlPDpSYN4FvPmb7qeRnlsxtJ
	sMfyDseuTCuxWcIusqZ1HDh5SSU/BAXqaaQ2nFrkm/DlLM0O1k5vjNFmuIHw
X-Google-Smtp-Source: AGHT+IHDPHIXaZ2YuwMnYDje41Rsstbt8vQ9tCYyOQmflj2gYiTOWkRUagGHXFVtl5wUPzl+oe+ZhA==
X-Received: by 2002:a05:6e02:1446:b0:39d:22ab:9b26 with SMTP id e9e14a558f8ab-39f377ce44dmr51989165ab.4.1724968123800;
        Thu, 29 Aug 2024 14:48:43 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77a7besm1708029a12.37.2024.08.29.14.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:48:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next 3/6] net: ag71xx: use ethtool_puts
Date: Thu, 29 Aug 2024 14:48:22 -0700
Message-ID: <20240829214838.2235031-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829214838.2235031-1-rosenp@gmail.com>
References: <20240829214838.2235031-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows simplifying get_strings and avoids manual pointer manipulation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 89c966b43427..b2e68e6eae12 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -509,8 +509,7 @@ static void ag71xx_ethtool_get_strings(struct net_device *netdev, u32 sset,
 	switch (sset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < ARRAY_SIZE(ag71xx_statistics); i++)
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       ag71xx_statistics[i].name, ETH_GSTRING_LEN);
+			ethtool_puts(&data, ag71xx_statistics[i].name);
 		break;
 	case ETH_SS_TEST:
 		net_selftest_get_strings(data);
-- 
2.46.0


