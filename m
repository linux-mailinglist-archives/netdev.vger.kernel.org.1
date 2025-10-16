Return-Path: <netdev+bounces-229850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5325FBE15FB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C113AEEBB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 03:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE14218C008;
	Thu, 16 Oct 2025 03:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiv/hIdW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C85B1DA55
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585921; cv=none; b=gTaev9bc10th5zUjfKL7L8ImybQCslCRcnSsQvJbHD5tDdNfQduyt72TD9Ihnhd2S/6Z10+jdhBEe4leWoRHUFnX0WZW+/0D7fxmE/8c9Bxand4XRCA4yQFqT5APj/GzRObiInaNV3GRDnOGsGHWkPi1JXsODMOXzfKQIrhj53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585921; c=relaxed/simple;
	bh=fT5EgAbqNy2gpcNA1b90qen7H9ypoH4TcZnfcN1+l8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifeWYY3zwp1lXQ1RIA+BuKupOPyhBe0KnV+yZ3dtLGXLzsUD7E0saAMh1lavoB34FlCIdIsneOvZxy093C4bvWV2Tb2CUmooZIEXkUCzxKfeKOyNzngg4eztl2Aa/peJ3dGLmAaT2uejWX6llD3o1y8NPwkjcaU1H2mVVqZ5Rjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiv/hIdW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2698384978dso1997165ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760585919; x=1761190719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OkwCTPQicy3JSZBUTa3pajCwqzOFe6iOfTYWO6fwi88=;
        b=fiv/hIdWxW5ouXwO7pvfSE09nVPcOI/XPnJfqxWa2GsAEwLlPMZ2y0RSDOchzD5UCZ
         gZqIdZYMwDq99oG17RIFy1xZfFiwHcLTHtNnfkkd0pUCgBoNZSgN341DqkWJZvdq/Q4m
         lP/AwZpSzcQBZSRttiGTydGQMvxtAeKFgSHub7vOQgHWVoJnk1MzuOPPs0nzff5gCKpB
         LzmMFxF6z3W9exyo5TXc3A4p+whQ/XAhDievQQxvVVpZBgDnPROf5mla+zjiMjoiiFp9
         UKqRHDeBwoYn9BD8iB0qzkvRYJrmePSmWylUcmS6tA5DUcwpf2RQgBL9L8jXnobaTUPn
         Y/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760585919; x=1761190719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkwCTPQicy3JSZBUTa3pajCwqzOFe6iOfTYWO6fwi88=;
        b=U+hFwL5y37rbNhQ5lRB0tjfR0AQYLUehjWtE/sjTix366t+Nn0QnLnaOLPf2FvqV9O
         uO88AoG9dPcNyEBY1BtI7HtJ7tcFLfJtV88J8lU+A7koaOFEbDELo6rN8LWFMjMAFYFD
         P2KmP5uAg1LFs+VhhID9gXQmT/HBmBOU1wONjW7znIPihVsfIl6QHVp8oODWuxSrOwvB
         6Te99Q1GB2GR45aGnVs6wqw0aT01+JY9aWnrNIolBYlBvH140Z/zkOM1GnQo+3r0AE6D
         uFZSka5iMSkMKodALzAQ/Z0mWU/HwPPMlsUWApXNo6Ay+IMM8N9HQVTpVIZp7Rmo+B4i
         K0pQ==
X-Gm-Message-State: AOJu0YwQk9mp1jj4ARokxHhWQGjihmczo0tFCcwYfdFYrIRlQz7QQqSc
	yE2IIWgLW/aa396H4QvzHMQJCdZbr7LGIF56sngmrzmqofJ3RBj0ozgJxIXfJBmW4KQ=
X-Gm-Gg: ASbGncvx/CwDiBOVAfpgqlnSKBTl94Nxn1SAVKEUSE3fQ72f1mFuDYoZOaOc7gkGFAZ
	BV+3AE0wgGGNDvZx80ysEiXym+uokQ4B17N3BvynteKuXGSlEzTl5DeZFPl6y+VIyuOXysNedHm
	jbQmjx2cK0AKfUV2eUCOu0dOqnJgIyazKe169hIJbSHZT4rFvHW84JLCCTt9IYYW7JktlMJEVMQ
	wWKugRezeuMGZDMFQl15a6/pei4XXE+ZRf12h2i8GJ4Pk0WL/alpo5MQKkhWJbluXq1JfyzfmNM
	2/9DHrzk5cI7dRCpe/7PWt8CtTkKOsmCOd3RHGyrVHz7s+dmtndFY6OuIAHbBLXpaW/E7+6a7L7
	p8ub40FSczEGZ66CUbHsSM8xK1iug7pAHKfe/03ea1t+WSWmUACc/CKteSkgiIGTZ5oCoxxLCus
	ZorOFe
X-Google-Smtp-Source: AGHT+IGjtGxKJtL0FErTK/8j5Cc934yIVxzEaZBkQ6rShVkfbq1WeABh2CW2MFgBJPfgICcf9mHFuw==
X-Received: by 2002:a17:902:cf41:b0:267:776b:a315 with SMTP id d9443c01a7336-290272c2019mr371384375ad.32.1760585919218;
        Wed, 15 Oct 2025 20:38:39 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343065sm12507925ad.26.2025.10.15.20.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:38:38 -0700 (PDT)
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
Subject: [PATCHv5 net-next 0/4] net: common feature compute for upper interface
Date: Thu, 16 Oct 2025 03:38:24 +0000
Message-ID: <20251016033828.59324-1-liuhangbin@gmail.com>
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

v5:
* rename VIRTUAL_DEV_* to UPPER_DEV_* (Jiri Pirko)
* use IS_ENABLED() instead of ifdef (Simon Horman)
* init max_headroom/tailroom (Simon Horman)

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


