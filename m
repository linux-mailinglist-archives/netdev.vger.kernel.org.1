Return-Path: <netdev+bounces-67831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D64884515F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90536B238B1
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0701285C5A;
	Thu,  1 Feb 2024 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKvJzMkI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6D85C43
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769004; cv=none; b=diW4KOh6A5iW5crAtnzKIrjNzXOwXopY8KvBRREaroAj3N9hcEzDWkMcwcVT8PVgsTxNIdJKwZ2Sw2ISQxuy/7TjMElWpuRV6ji7DRhk3xUwtLaymTTLNjaqlnGe2O4fF+o1Gc0c5gKia5Qni3bHqG5Yrwn4VwNdX6UFsmWvcUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769004; c=relaxed/simple;
	bh=I2yRvRwoJe8NYhNMjDLJQUNmI0hI7Hs/5kgtIZg24No=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnDqKTKzdPyhqyDO+TbWWNNhQmgFMZ1487M3uXJsAR2EPGbdUVKKkqKDZ/9G6Jj+bHq9ZpjJWE+ont3wmlT03I1RZnRKwSUmfgiMCodN3fcpaUYyR0R/td7oxLsTC+VCgavcxxrtGFgF9rWTaBba14clBzKFEyL3raRci66jmGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKvJzMkI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-290a55f3feaso411762a91.2
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 22:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706769002; x=1707373802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZrL2VpEJa7UqL8kWj7kSRmwBGmurcLyNVJ3Z3snrz0=;
        b=PKvJzMkI3EM81Tlmns+wAiF3X3CbY/5orBt55SeDSsadq/9+46EweHSw5s7gdIQiax
         tlTlbv1+ba9Nui36uvwoWISvibgDVjg2kpntGiqwrPCgYcLzyzY5bBO0nFzUx6JiDyYq
         Xxp+HeMmW1V2t1EtnxKxyVGZnwnBvrHjSkc/aFI2DT+7ntECT6mkc07vRxZ38zsL0SvQ
         MtUuYUe34D7BR1Cp9cKIOzlxkVLomdIFPg6NF0312Kws7aREaMA7eCx2wmvI1IkEgA1f
         5eCiwgCi6aAHV0cOlNnt2+caMx/7F/6iNg35WrMxvxOPAXTWVtlxzp7Tg54b4W61qOQD
         ib5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706769002; x=1707373802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZrL2VpEJa7UqL8kWj7kSRmwBGmurcLyNVJ3Z3snrz0=;
        b=E5o2oMLD1JWfhefHNLwfXum0cW14A/DMONGiczVgI7bPAeyMvz5+rJ0HQkmhVJimzo
         MZLWo5OR7ApKfU7jIUwX2KbQ7P82roHUpgdLdy0undUoImwtnCxXb4ZLP2sXNPHhTaJH
         b2Ish9ugepZkdyX0Xe5RORfdeRdG0x76M+flG00pjuDwkmUGvSwCI65mekKL+GsVmOfj
         TlId4qs0gK6prsqNbl+HITMluFsiQVg9WBAKl4/42wJzfE6Fy4Poij+z4rJ76zgcFVS8
         RBW2tmm4VWcrCkBesSWzgxccf5Vk9KWt5Ep4DiW1oy+rzOVJsBb6lZDSmA5OOYThz5i0
         wJTg==
X-Gm-Message-State: AOJu0YzBV400boXFRZx2yt6fWQosCXhUNW6WyQO305yF5fi3c23cNCuE
	hfJ3pdaIqQGAoe39wz/1l9JST8yhH0T+wKD5HeIHAiwrxhVofemZWC6vPY447XMWaOx5
X-Google-Smtp-Source: AGHT+IEJFVL+SBeIPFuVeCjIgluczCSuwHrmjZ6fE/oWI2JzkP6p3gQhiIXX8vUtTeEUO3xLuIVaJg==
X-Received: by 2002:a17:90b:3555:b0:295:fe86:ad1f with SMTP id lt21-20020a17090b355500b00295fe86ad1fmr2791031pjb.46.1706769002062;
        Wed, 31 Jan 2024 22:30:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXBHbijGK5tkTdZVyXUwxeuJ8wfJCzMGhof1bRlQxpDHu49mBYal/xM2xM2hyjEXGe3p9n/onwWIxOpzF7f7LE9iVTpHZ1M6bUVhZH395KsAGdgz1ZVzNyzOqDRJ8GBZdiJ2YXochB2V2xHVjrCw1XAFpGfJ+l62J7j5n1T7/kihpSoZz1aLbqgSV66JihoEBikT6aaK1QEKpiFCRzi7dqv2wVcz22EQIBvIoA0MuGiNaXa+RS+jwFNeUZIkn7O0Sk8rQ==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id pm12-20020a17090b3c4c00b0029618dbe87dsm515895pjb.3.2024.01.31.22.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:30:01 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 0/4] selftests: bonding: use slowwait when waiting
Date: Thu,  1 Feb 2024 14:29:50 +0800
Message-ID: <20240201062954.421145-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a lot waitings in bonding tests use sleep. Let's replace them with
slowwait(added in the first patch). This could save much test time. e.g.

bond-break-lacpdu-tx.sh
  before: 0m16.346s
  after: 0m2.824s

bond_options.sh
  before: 9m25.299s
  after: 6m14.439s

bond-lladdr-target.sh
  before: 0m7.090s
  after: 0m6.148s

bond_macvlan.sh
  before: 0m44.999s
  after: 0m26.468s

In total, we could save about 200 seconds.

v2: Reduce slowwait sleep time to 0.1 (Paolo Abeni)
    Reduce num_grat_arp() miimon time (Paolo Abeni)
    Use slowwait for ping result in lag_lib.sh

Hangbin Liu (4):
  selftests/net/forwarding: add slowwait functions
  selftests: bonding: use tc filter to check if LACP was sent
  selftests: bonding: reduce garp_test/arp_validate test time
  selftests: bonding: use slowwait instead of hard code sleep

 .../net/bonding/bond-break-lacpdu-tx.sh       | 19 +++++-----
 .../drivers/net/bonding/bond-lladdr-target.sh | 21 ++++++++--
 .../drivers/net/bonding/bond_macvlan.sh       |  5 +--
 .../drivers/net/bonding/bond_options.sh       | 38 ++++++++++++++-----
 .../drivers/net/bonding/bond_topo_2d1c.sh     |  6 +--
 .../selftests/drivers/net/bonding/lag_lib.sh  |  7 ++--
 tools/testing/selftests/net/forwarding/lib.sh | 36 ++++++++++++++++++
 7 files changed, 100 insertions(+), 32 deletions(-)

-- 
2.43.0


