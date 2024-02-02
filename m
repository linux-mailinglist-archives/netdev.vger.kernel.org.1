Return-Path: <netdev+bounces-68277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBA48465EE
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 03:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F82289049
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 02:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBDE53BA;
	Fri,  2 Feb 2024 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5o1bYEN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22C63B2
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 02:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841486; cv=none; b=f49WWyNnflSO2RXsDg82+3cDYqSQjP4lBGnoolo3ry7t7HITQVcq5FOR+scxfwJTW3uc2rj6nbp3/0LJhIKMHIusWDPK17zyW3PgSH+36UxxdTsiaEiCEynulWFiG4WTf48tEahJ4QRdztMHuqZWYd3oF+S1LchZyPdyO/7lswc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841486; c=relaxed/simple;
	bh=/I0ZIE0N+I3cOxVP6141y8ezzj7uVU4N6Da3rjIqNUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAHMUBXRa9s2ovWmkaqFO/fDx3aZg6277YVOwJgcQwPOGqJBV7+aH+m7S9IXcXGercWLC9iHzuNc5Nm83bSFYikD4wehJNF+OfwjVLEwzZsTB5Wd8J32q1byoXaL7feTIAL9uK1l6EmzNBc+HWBYisEYA4Zc5saxtz+bmiLR28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5o1bYEN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d7431e702dso14480985ad.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 18:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706841484; x=1707446284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mp6JnrLS2U+WQKFgtFrbin7bUDAhQ9lEoPieaUeQ/Qg=;
        b=a5o1bYENgmcTMjLF7TwcXfECuwTg17e7KJdYULEem1hErdC9YXGU3cr2zMEY6/ZE3j
         DYodgrDn1XJy/KM7UMdKWFeKMz/DP5Tfpdp2vnDn8yEw0yz1xEcBi+vIdIEuIrEQE0I+
         ZX1W8dDxd/2d2wedkabZxmMNb4Yl9XTi0AtnFqRTQHJm04ecAiAaAwyfq+tK/0XetZLH
         Gy2ui2dHtnhQzyKjhLoFlv2moXdkBpfSbJFCC48/B4aAyJCzy/qMI7DDFXOXOBUzb3Qn
         RigOd8V7a5rg3CJFqAI32kSXDOFmuyOzLwQqgrr/6FT0WOdGHeU62dsEQ1hrQyopnyZD
         qhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706841484; x=1707446284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mp6JnrLS2U+WQKFgtFrbin7bUDAhQ9lEoPieaUeQ/Qg=;
        b=r1mxnoeUSLO83T+zjzjZ7CVAY0MNTdAmpECl9UFsgiU5AZDeKrrjq/zP5Hl9QlrRym
         ui3f+UUoWVjA9QLWcTb1ECFSPdKLrLo9ErfPKoCiX44Wca1irjqCci+QEUYgxCBOVp5T
         3AGIphk5g9KnKkAf24luST6fQFAoYLkJBIHiwI1qmeMO88vlwI9y/oRoBj6rZazzAWgQ
         MRJd+5+mKgQExy+NQ5vhtlmUD2u8ezfYivyO3JrL/ytzp4yulZhkg07wnX9b4HS4UVBT
         D3HPq9G8NYCsdggftC3VLq+Rd7E3N8ybatZS8NYIu4ewIc1be3YK0x9nU4dpvYs3bF+c
         JTZA==
X-Gm-Message-State: AOJu0YxNLiMdtfzturLOo0I7GFxmWGyKol4IJ0nx5H8AJuHz640ZQt6o
	jvoZwTnKO84t7erOWU7mIOGYxZB9Ix79AzXzfPmEULbi4ck0o6SSb22MhWRuArmniKID
X-Google-Smtp-Source: AGHT+IG3vesMWnqA+VwhZJOct0yLyzfsDSnw3YhtiA9UWpORbxDNkq/oaqrpZSugm5ohRqKPK6Y5ng==
X-Received: by 2002:a17:902:7086:b0:1d7:72b9:b114 with SMTP id z6-20020a170902708600b001d772b9b114mr5216245plk.60.1706841483694;
        Thu, 01 Feb 2024 18:38:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWwToYDgtCPpE1b//ddngBfIItn+ZBCCs6btTwIVROtJMtZuW7ZQAIltuae9KP02865hp0r+jk6qgWfGb3cLvxYLcoptn72mcvxjjxrp0kj5FB2G2hIkVGL49eqbz40648Qu5B5tXh1ygxvW8UDmvQn6WWhJbhFBxeznhB5/BdWk8fw88JTkppS+XATXr1Q0n7aP8XSFvOazSnH7dS7OH7JyhOjtbes8n2Qx0U1Gylrqh9TerGxzDBNs7S2zWw45VY+qA==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ji19-20020a170903325300b001d944b3c5f1sm493256plb.178.2024.02.01.18.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 18:38:03 -0800 (PST)
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
Subject: [PATCHv3 net-next 0/4] selftests: bonding: use slowwait when waiting
Date: Fri,  2 Feb 2024 10:37:50 +0800
Message-ID: <20240202023754.932930-1-liuhangbin@gmail.com>
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

v3: Rebase to latest net-next
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
 tools/testing/selftests/net/forwarding/lib.sh | 35 +++++++++++++++++
 7 files changed, 99 insertions(+), 32 deletions(-)

-- 
2.43.0


