Return-Path: <netdev+bounces-124764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1910C96AD62
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 02:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32BC1F25303
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8853B7E1;
	Wed,  4 Sep 2024 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFF01TGK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555763D
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410107; cv=none; b=BgqA2w2uyv0fZMG+l8RmB0QMVYP92z543dcRkK1hw8AHhwv8WbqibrqI3MFA+aghFGlsrPtUKb3AZxONodJb5Ft9iJ70BN8eOz1rrt58gEhvHtrUzfI2szWIoNkjNQWFDvVfHEuwyI3ngTd+qnA/RcnrgyVvGRAL49YqOHC1iNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410107; c=relaxed/simple;
	bh=oDFcTcS6oBo+373TI7bFv4KeaNwwF2rnhIf/qHHWKyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MP7zXmGFNJP+DUfx94jbpnqdvnQemy7Dyyzr0TfT0zqu5S7ApX1nQcylk77jcu2gG9vfvtq5NCPds3zIT0x2Eil13BgjMVXozos7kwoaO4shNh0nJJihm1+WxlzGd+pjuMdOoHuHNkLsVsHVSt4ueTKF9+3KN7QnWAd7VIv2B00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFF01TGK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714114be925so4839913b3a.2
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 17:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725410105; x=1726014905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LfLR075+NY2dUSUBPEwQqwrmQsUB/t0REzRaFC+KAHg=;
        b=iFF01TGK73j77GtNsspQYOBJqQx7rS+RlnWkPSfCGjMyp5PveDX7XR6bSPKqbnSewD
         +dWtGpYRUldWbIB41lwh1vXOVkQFW/mOw+Dr6aDa5Z9H2hc7QvRf19nA7vwSYLd6Z58j
         f+cvywMyn535zeRDNvw1dwySzm3VOmcuEdecTuktag+f7HYlGyeYOrLHx+eDUQ2Ivxng
         fbqky5JUY25RjUbgJSkNu5KFz0+2zLT44Xcs4fu8o9tYTVQBhX3ePk/2CIMZ0OiRokZT
         U/fCUoUU076w7+R6PIBCVlT/K//G0BmEfvZwOf8+FS1aiyYKUh3KOLYXVGLqnijkb19R
         tgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725410105; x=1726014905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfLR075+NY2dUSUBPEwQqwrmQsUB/t0REzRaFC+KAHg=;
        b=tJRCRpK22IF/q4lDNMn6OD/DlzUEpeUd1oUOPgxPsKCDFHt4TIbjv5f1x8srQWO5EX
         IMKnaO4jb8SkvmvCRW9g5SUNT8tw/taZ5ckQWYvc129vpkjlnIXyZCKeL20+yxBe4AEI
         /Q4Aq7TERo795LQj8XqV5i0y6qF3DN3LAIg5JdlB2p7Gn2rqefB3N50TvrQvxSkaV5yE
         ktoZgLRX4XICjDAJpIVcMLxS3kupD2ngXdvAccHvKm8kTxo8Et6Lm9tc9TVgWYaD9gFX
         PzNcN3SUQAD4sTEv6GVJ6DMpE2QFvsA1fblGRU4qwk0Bl+1V6JVhb7QHcslPjgKGts9E
         y4eQ==
X-Gm-Message-State: AOJu0Yy9Lf12T12xMyEveoei8qgtk5ngd6+QdclkIPISBbgRyO/b58W6
	IhO97/hVHpFaETDkEP+8j8d5FUvhDGAvtHQFgAuiHGZhY3y0D83nenYh8Aw/YWvsCQ==
X-Google-Smtp-Source: AGHT+IGHUMRTymhFzoe9DwMp+XtGhdGmdEZo72CiZeyTsCyg/twpC7JZaHp2iGqi59IzBTFGv6PU1A==
X-Received: by 2002:a05:6a00:3d04:b0:714:2198:26bd with SMTP id d2e1a72fcca58-7173cf0f04fmr16284143b3a.11.1725410104865;
        Tue, 03 Sep 2024 17:35:04 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778589133sm444218b3a.109.2024.09.03.17.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:35:04 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv7 net-next 0/3] Bonding: support new xfrm state offload functions
Date: Wed,  4 Sep 2024 08:34:54 +0800
Message-ID: <20240904003457.3847086-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 2 new xfrm state offload functions xdo_dev_state_advance_esn and
xdo_dev_state_update_stats for bonding. The xdo_dev_state_free will be
added by Jianbo's patchset [1]. I will add the bonding xfrm policy offload
in future.

v7: no update, just rebase the code.
v6: Use "Return: " based on ./scripts/kernel-doc (Simon Horman)
v5: Rebase to latest net-next, update function doc (Jakub Kicinski)
v4: Ratelimit pr_warn (Sabrina Dubroca)
v3: Re-format bond_ipsec_dev, use slave_warn instead of WARN_ON (Nikolay Aleksandrov)
    Fix bond_ipsec_dev defination, add *. (Simon Horman, kernel test robot)
    Fix "real" typo (kernel test robot)
v2: Add a function to process the common device checking (Nikolay Aleksandrov)
    Remove unused variable (Simon Horman)
v1: lore.kernel.org/netdev/20240816035518.203704-1-liuhangbin@gmail.com

Hangbin Liu (3):
  bonding: add common function to check ipsec device
  bonding: Add ESN support to IPSec HW offload
  bonding: support xfrm state update

 drivers/net/bonding/bond_main.c | 100 +++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 13 deletions(-)

-- 
2.45.0


