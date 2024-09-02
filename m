Return-Path: <netdev+bounces-124287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7A6968D25
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907791C21F06
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF9715250F;
	Mon,  2 Sep 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqFiJ3Wk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598F1CB539;
	Mon,  2 Sep 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300935; cv=none; b=iW/Hw4Dl3a3Q3GrtBklltEvfXLIwbJJxPApnP2eUQV7jst9koX3DXXMFmvg3OlFkBhCYkotd7VmrjjSEAiLNioHjbXHxoNoH1lEh7rhC3k/SuBeq0ZK8mGC42sgROyAH1nsWlk6sK05qSVrANILYyZ3mrRfDCMGUr/2opqugZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300935; c=relaxed/simple;
	bh=znSjoMQg1HhWt93uFHrwPqGoJgEjX9RIq1lgtQWd4JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pI96rzJu7TYIMsD1TeMKbK542m7ScX2GKTpk22QINa7GjBXUwP8iC7t8+C+2hWiWxvSfwRMn6FTxXY1y6rpeZQrrDmEiYMuzl1YfwYy6ZFQanomOkYVdRHYRfhnBbyI1fOxwS4Jv0U5GHZHaibUvMnRw2VzCfyQ+o906512fExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqFiJ3Wk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7176645e440so374147b3a.1;
        Mon, 02 Sep 2024 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725300933; x=1725905733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=un7/IFpKzgCp+4A0jckhNEuXDpv6EUswWkBGhAfXo80=;
        b=iqFiJ3WkgSlhLg/7q7bQV1/qThIzXdw9xwXW8ViGhW5qQed0stnDcvqyDhaGKVGjb+
         qMrdgSQxZjDdmzO+M5L5fU3PlYkvIPJox79MkX60Npc/Ab4gDS2yIYV9sDJtVQSpvYIQ
         pi9wzSKVRO4b3DKr6nYZlTWRVh9vIlc5eKRc3witwASu0GnA/Utssy0+Xeb83ZvT6WcY
         Z7kgoZXS+3nlEQIhXV0LDr8XjoQ3QQ5Ury+xD5x6OZhNZcfGm0amklYixhKwJAzwYKwi
         O+HyFRW7LL64z9bp47Ti6t/KIFcTns4LAPVSUyUkLgAKvUO9zSrFdaR37K+GXGQpN+xd
         gfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725300933; x=1725905733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=un7/IFpKzgCp+4A0jckhNEuXDpv6EUswWkBGhAfXo80=;
        b=fhAUvW7gP5yrAMcRwXZ3ghqKiulnC8FB3ldarVRE95aUw5ZAGPEtU5b1c08t/7Yl/z
         Wa0rKWLgM+tMmoNZ8RSkJvn6XWWh1TTSoL9jaTTmJED7Q24FXSLOV6ln5y+oSlO7w/EB
         rGg6q8W6kQ2uaSvFnE2BcaYm/IvYFvEy2VRCEpp4P8oR6ICcBQdBVx+YzPVZmLF/8BD+
         +QDuvcyLRzrbwM44sKc6VqZRlYcaI7PC3MSjsQ+YEo2S1D6P6bWe5uSQbaHF51NDUe45
         +Zy7qmHJ43pQQEI4Ldi+dypCdtw6yk5OHTJuDTGFj6UoK1ZIYZQ+N5KWrTnWoJwsSihX
         IazQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXrKOdnWgs6knmUYyGKwc3uJBxonob1XACz+0WP1IxMyvGEVQD8xmyQwS6JlrwOuhyErY/UxwmbXoHklI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbWbC+glhtqlIsDaoEz9+0zaA62wW9vRpuWJGN9VYwBbPntF1
	QhskTksUaInZoSvYfrCOYj+Yb9cfHn/6wIT4bn5Lb7V0PgMVTbYqjBCHwJCX
X-Google-Smtp-Source: AGHT+IHWxx4KQsibhYLnAQyW2uoea+wtTKPWTv+Rb8aJxXVDykG3AwC1IUHDHTbdbhsAF0j/2/gcQw==
X-Received: by 2002:a05:6a00:181a:b0:714:2922:7c6d with SMTP id d2e1a72fcca58-715e101f8d7mr28043965b3a.12.1725300932624;
        Mon, 02 Sep 2024 11:15:32 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d7804sm7109167b3a.154.2024.09.02.11.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:15:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next 0/6] net: ibm: emac: some cleanups and devm
Date: Mon,  2 Sep 2024 11:15:09 -0700
Message-ID: <20240902181530.6852-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a very old driver with a lot of potential for cleaning up code to
modern standards. This was a simple one dealing with mostly the probe
function and adding some devm to it.

All patches were tested on a Cisco Meraki MX60W. Boot and
Shutdown/Reboot showed no warnings.

Rosen Penev (6):
  net: ibm: emac: use devm for alloc_etherdev
  net: ibm: emac: manage emac_irq with devm
  net: ibm: emac: use devm for of_iomap
  net: ibm: emac: remove mii_bus with devm
  net: ibm: emac: use devm for register_netdev
  net: ibm: emac: use netdev's phydev directly

 drivers/net/ethernet/ibm/emac/core.c | 130 +++++++++++----------------
 drivers/net/ethernet/ibm/emac/core.h |   4 -
 2 files changed, 50 insertions(+), 84 deletions(-)

-- 
2.46.0


