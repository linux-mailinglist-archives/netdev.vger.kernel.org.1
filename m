Return-Path: <netdev+bounces-125668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7808696E376
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DD61C24494
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E549C18F2C5;
	Thu,  5 Sep 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyvfALoz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B1189523;
	Thu,  5 Sep 2024 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565782; cv=none; b=ZOEIMbZ7Z+7Ej5Tw3pG+8kLoGoCVh9l/SjeglfZ7U16qZlRMcQEzmzYkSrTjpjSyclJEoVsOK6MWJuCiDRgIWwWpLvUyVz4kuMlth8gic+GdmE1MfnWX1DYzSFpmHOxziRCg505fytHRPhCcgru/EQH9yXPl35Rqaw73vbYRe9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565782; c=relaxed/simple;
	bh=wYNOonS+zkGTdeNzxFS0VTHR2V1SVj6W1xJozXLgYTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u6uA9T5+H0pwrxfzqhrYC7QMHd0gEN7g7Ukqvy7hFjx9EHu5jNycN+GLzcYyZlN8JTxIkewJuT8cTZok/07FHk6Zt/Sh2/DXq6Kz0MO9XSdQGTi3f1lB0V9Bp1xt/C4P6gAQP+ahmSuPr/GITac8KaCowBaA41Z10u2iL0y2pPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyvfALoz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-715cc93694fso1080156b3a.2;
        Thu, 05 Sep 2024 12:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725565780; x=1726170580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=doPbw8XA56nExWDq4i20kV0QJuWHUF5mkzAijSj8Kb0=;
        b=JyvfALozL7nfUtmWRgORZLooZE6b7jOjgCEExcS2Qy0tqejHIMty9pdQZh6CYESpji
         6F6vhhnAx3I20PrASlztza4DWlICQUgJUiqfY0vyjC7+yfE92r24Ny2Ni3T5uylGwXTQ
         Roax2mq2CqYusH6i+z2M1ycHwjdstBjaZEX6flVVFwwNLxH4L6QfeKC6qZzhC2beZ7H5
         Vs6kFhjnWGa+8xmCKshAI/MofZhCzjCh3eiyEz9W5n+nD7tnVJZLibZILRjX2+pwsCxI
         WC4Hk+xMieEVT3N/qf8V5sut1fntS4GALLW5jMiey25opmSyVm9XQ5fFWb2d2cwe/fRp
         hyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725565780; x=1726170580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doPbw8XA56nExWDq4i20kV0QJuWHUF5mkzAijSj8Kb0=;
        b=ovj8o+eDr1i+0NzNVAB6+py5IA3GBySCbvoSr5u/aaODy+kbG4aM2Yn/epLvSzzXAT
         xIu+ZKpfm3JW542hrzM9i5A5zI3n5ETYMIhmeo7Gu4024bTU0Qge0DJhZobfWFkWzdQL
         oZ9eDIxQC1NMUEJt9Wgqc+CPgYLrj98MMW4siZu042puSqbu2F8dUHyaY3MYTPLGxvQ0
         mwTA5eeySIZ2zJkFrpRiWXpYtiMY+5qSUfyFcyvOwXE6NRHCQZsFZxp6Hukns8RVuQuA
         zstMBEHyvJSfX0aBagexRxvC6ns3mVNoFnm8m5iqYxecOvVVcvlGeHuj1Az/79sYzuCF
         NnKg==
X-Forwarded-Encrypted: i=1; AJvYcCXwxweSs7gGGQAsGp6wAj3iGxkh62O/qR7D6CBSFUkFxK9HRtAtf6y5RQju3+CWAzAq0D8qjCxCYno4ozE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/tAvpXBTTu1jPJ4V2hs1JN25oWykyL5fHnLjWPoDW0oUoEzCA
	bLyEQInwTxtadz+nqKfcT5kkc0bejnpZk28DT8OqPuKJidzrVre7Xz3V6Jql
X-Google-Smtp-Source: AGHT+IGC2naycAt97O5kweYDEyujVx08lnVFnF/97SmZ9mLTUqykwEvxiZLd9SvAw+CV8DLP4eCNuw==
X-Received: by 2002:a05:6a00:94a2:b0:714:1e36:3bcb with SMTP id d2e1a72fcca58-718d5e0f288mr324122b3a.9.1725565780406;
        Thu, 05 Sep 2024 12:49:40 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71791e54585sm1248410b3a.182.2024.09.05.12.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:49:40 -0700 (PDT)
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
Subject: [PATCHv2 net-next 0/7] various cleanups
Date: Thu,  5 Sep 2024 12:49:31 -0700
Message-ID: <20240905194938.8453-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow CI to build. Also a bugfix for dual GMAC devices.

v2: add MODULE_DESCRIPTION and move variable for mdio_reset.

Rosen Penev (6):
  net: ag71xx: add COMPILE_TEST to test compilation
  net: ag71xx: add MODULE_DESCRIPTION
  net: ag71xx: update FIFO bits and descriptions
  net: ag71xx: use ethtool_puts
  net: ag71xx: get reset control using devm api
  net: ag71xx: remove always true branch

Sven Eckelmann (1):
  net: ag71xx: disable napi interrupts during probe

 drivers/net/ethernet/atheros/Kconfig  |  4 +-
 drivers/net/ethernet/atheros/ag71xx.c | 76 ++++++++++++++-------------
 2 files changed, 42 insertions(+), 38 deletions(-)

-- 
2.46.0


