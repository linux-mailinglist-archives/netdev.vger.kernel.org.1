Return-Path: <netdev+bounces-230284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE80BE6390
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 05:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 796EF4E02B3
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 03:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A052EACE0;
	Fri, 17 Oct 2025 03:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc1BvVqN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D5C2EAB68
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672529; cv=none; b=qmkT5mEoTmb2Y6PKsvPEDHrWiCtdHOwYZyQPJ8N9oBuq/zxaWXF1YbBFUexiboHVeGbpvV2cYgnPsy9WYuq5Qp3vsNetaNrj9/b6SsPcD3wGavsaPGv3NiLyUfMm+qnGS7qAJmRpsh+/kKKun1FXuwCpNqGofzL1Rt/Dg933svU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672529; c=relaxed/simple;
	bh=nSAbBo6hmHwIzWG43Awnhvd+dCEILV9ltGpKqgnBzoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYWgrnGi73IXCu7Zk/LbPxUWEi7WZsLEW7DKuDp5YyrSbJTe6Kgt5I9QpshVtBj3Jjxbh1ObXytOjVTFMfkuaB00rx6cC5wSNEQwyyzxS4x7IPAWyeahKnLucKaigSY/ek4/avuA7N0xMqQKcpwOeWJM7PMf3uUMN86B/5uQiYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc1BvVqN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290a3a4c7ecso15528675ad.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760672527; x=1761277327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fq128VBkLabfOGmarayrZTkCSwx/rnhK1ahk6nrKeko=;
        b=Wc1BvVqNLVKp8VZ7rFKsBNjfCfEicmPW/hePPwTHiTaGDz1ifTw2unMy4cFHbn4+TM
         ynvoBWTYijqv1ameRlXV6586ZA2snzCyF4lMCsYH2uPJZNjDn39+4ULvZqPTEM77y/o3
         v8yXaVMDUSbUvOh0paKK0DlCGsaoS7qTpvUkPk5yctSug3x30Rz/MaWq1IoCySi15XfI
         hdQPwsUGgWEmdecMTJsUcTDEGrhSMErABOd27NWp20AeXVgec35WAeCiqGq3YCJWimJu
         5M064hkwRiwhZq97Qju692hfI3xRfN1NJzxZxzZPJlzRjRz3U90OELXVJIseloTHPqrt
         lD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760672527; x=1761277327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fq128VBkLabfOGmarayrZTkCSwx/rnhK1ahk6nrKeko=;
        b=QNzgzyuwF0RPFoCXjDMiTVjVfeUGFQzRglgXFsshsznMrl+at/Bb2ZlUAZTRmfhNph
         kGzWK4hx2F7yUBFZ6QUm/AgdlJjjGUZN0mMQFJEuNrh13J9N7McxPvxo3aiEOvA9MvVZ
         3HCR3BEoWyatm64OBV6qdBDsAErSmPy9YbZGmmLBC7giTcAi6jcOeWa+h/zhMcr+X0+z
         ZpJJthB05YKW6Qa59/n3R0GiyyIwp+B4FpRmaAsawu1yI/M9tuBMgeosHzFMexngMmho
         QwOqJppBReh3WoeCUYbZi9R7UvcSNWe/O919RzwfEnCFgcqsIMxccKYDioH8Pzj0x6eK
         nHtA==
X-Gm-Message-State: AOJu0YzDficdH+Ww/ZAYkmv+1s9vUrnH8um5IFV/ZbsT4JhrcFqf6q+r
	PYU8mK7M5dOsVL15gAFnE3FxFsd3H1++IMD4dwxhVxfHALqkFvzgTsxuw55sJes3ygY=
X-Gm-Gg: ASbGnctFHofAfvUHKUcg/Sfb/XwWAqKfmrqIsWP4r5k1xFj/AN0+kMjXY9xuFcWoiLF
	pfsuOdFMInlLm5E9WZBCZYuZ2DwYrwjSWlAxwBoPKkXXzQ2VhEAEREwwE0+Q7jhEk0Phdb+Lbqp
	gruWMeXnY/kb23+oc/EfwPGV/l+1ofA5RM1JZE4L6UdR8pRZ7EyrzucLj3IKQ834hk36BTPcCK6
	IgLkAStDp7gqXUN0SatZA4TbRwlPZq70ak2ykfwzXjI9aL5db0x+FrvpkCVLHI9BY5ubT0MCKoj
	CopSLz+UDxza6A0m7zb3t3QwMwTSIxfdBKq3yqTCyi423U8jtBX+RgZmp/fzuKONwHkSpjzB1E4
	IOVc19w3nBjmGBUJRMrwy/d72PKTcYTg5go+SG3MmKcja/R/+E+anfPbXdd79AjIsLXVHzoj9VY
	16eubsqKUiS2NUOEA=
X-Google-Smtp-Source: AGHT+IEFDBuvqFtMO0ZbsNIV5j5E3bGqWNZuk8b5nqzr523R1CYo8BkrMi08LdYVPMbxUUEHQjkCWw==
X-Received: by 2002:a17:902:e806:b0:290:5601:9d56 with SMTP id d9443c01a7336-290cb27af33mr27618355ad.46.1760672526629;
        Thu, 16 Oct 2025 20:42:06 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab4715sm46695165ad.93.2025.10.16.20.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:42:06 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next 0/4] net: common feature compute for upper interface
Date: Fri, 17 Oct 2025 03:41:51 +0000
Message-ID: <20251017034155.61990-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some high-level virtual drivers need to compute features from their
lower devices, but each currently has its own implementation and may
miss some feature computations. This patch set introduces a common function
to compute features for such devices.

Currently, bonding, team, and bridge have been updated to use the new
helper.

v6:
  * no update, only rename UPPER_DEV_* to MASTER_UPPER_DEV_* (Jiri Pirko)

v5:
  * rename VIRTUAL_DEV_* to UPPER_DEV_* (Jiri Pirko)
  * use IS_ENABLED() instead of ifdef (Simon Horman)
  * init max_headroom/tailroom (Simon Horman)
  * link: https://lore.kernel.org/netdev/20251016033828.59324-1-liuhangbin@gmail.com

v4:
  * update needed_{headroom, tailroom} in the common helper (Ido Schimmel)
  * remove unneeded err in team (Stanislav Fomichev)
  * remove selftest as `ethtool -k` does not test the dev->*_features. We
    can add back the selftest when there is a good way to test. (Sabrina Dubroca)
  * link: https://lore.kernel.org/netdev/20251014080217.47988-1-liuhangbin@gmail.com

v3:
  a) fix hw_enc_features assign order (Sabrina Dubroca)
  b) set virtual dev feature definition in netdev_features.h (Jakub Kicinski)
  c) remove unneeded err in team_del_slave (Stanislav Fomichev)
  d) remove NETIF_F_HW_ESP test as it needs to be test with GSO pkts (Sabrina Dubroca)

v2:
  a) remove hard_header_len setting. I will set needed_headroom for bond/team
     in a separate patch as bridge has it's own ways. (Ido Schimmel)
  b) Add test file to Makefile, set RET=0 to a proper location. (Ido Schimmel)

Hangbin Liu (4):
  net: add a common function to compute features for upper devices
  bonding: use common function to compute the features
  team: use common function to compute the features
  net: bridge: use common function to compute the features

 drivers/net/bonding/bond_main.c | 99 ++-------------------------------
 drivers/net/team/team_core.c    | 83 ++-------------------------
 include/linux/netdev_features.h | 18 ++++++
 include/linux/netdevice.h       |  1 +
 net/bridge/br_if.c              | 22 +-------
 net/core/dev.c                  | 88 +++++++++++++++++++++++++++++
 6 files changed, 120 insertions(+), 191 deletions(-)

-- 
2.50.1


