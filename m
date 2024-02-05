Return-Path: <netdev+bounces-69135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8553E849B4D
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B651C1C20C44
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023D3171C7;
	Mon,  5 Feb 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJyh30Hr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E131CA8D
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138063; cv=none; b=RemV3W5Mp3UronNBstKnmDmpoXsJ8exO6Vh19nwASi7JoRGyFFRwAZn5jVw/nCED0IC27XDFonMr5iK8p2raLKajBMmZxgRfvHJow+GHmtwS1aKU467ooebCUuYZRZObvs4ptEXMbihBAGCDofdl5KZr8/leMk4XFGgef35+Dd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138063; c=relaxed/simple;
	bh=BuIkpGGW8EXIByZO1HmiFfL6LTA5PUB0HsZNmu/xFyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9gTahfJWWkWJi7Bcbw0szEEyL/lej6+L4sdhdcBHSYlZR9xObK/ytJUM0SKWOWp9tb0Lvd8Fw3+OmUZfMAZrjzQVg3drZDQb0C4VGD8w5Bh7+0IY6Q7tVxsyfqZIbM05a/kxCwu/gcQd5jnU0rayjwsKqoM9JJC0nCRrQtvucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJyh30Hr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d944e8f367so33744765ad.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 05:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707138061; x=1707742861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONcymMlKnLR2NJ8Ij6CYLejVZwmhYgyOCwCZBxrENWc=;
        b=KJyh30HrOBFse7TAmxxviOB4o16CY63t53viZ4dp5fN/CxBIlL9jGcsbNKK8CPldl1
         GEyinmb1zPIc0Pc37YcJSpsZpjKRlrRMTMZn9erdKZfLZiTnZzkFW/FaTWYtv+X2Q8zW
         SoYQR9f8s4PTPKrweY67Kjqrdc0k9zqJObk1ObiDQ7yqXWXj+L7JP/EsL4M/8hUqNslB
         MvOuxZpZsNPMDM4BYiO6qDDatyeg+rYmpO6O1FlixQDO1/mNfaQEs7JpV5YkEhFSKTQv
         WLYG4CNC+WHfVa6yUZeDfWVRzNB5qRwAePXuZekIi5ejxSlGkrBSyZXOfCIw5AWRPDPM
         v07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138061; x=1707742861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONcymMlKnLR2NJ8Ij6CYLejVZwmhYgyOCwCZBxrENWc=;
        b=DOMVkXq4TMu9ewrW4OetGETwaPpON78P6r/uBGC/VvaTsw4N2F1JY0bxuDjqvv1Th3
         R/FDm+ldnxePF12ndnmfLXWkry7YYF1ZQP3JTn2mZ6vD7odhIJxrNEyjlH+/rZmmG9ir
         FJ0Cuj9H5LqZ2z2Q4SjUIl1MEKyajWJDxHLc6sUTYJOVo7AIqy1M9P6kUTSAaU2Wzbo4
         o4tsUq+BDJbU66B+6qQT5BEzkaEE0tdrccvqvLES20zOMI1u2je1mI0ah/SoQDpA1EEO
         HVYFk4TRo/zvYgQlCJOqz4sHHaCYkbK21Uw6VmS/qDCIAsemhNiKjjfITNZghGWtE+S5
         cARA==
X-Gm-Message-State: AOJu0YxfQEydyi+w0kXjOPwCE0YAzJjds5GuzBmVyeLXMkCYviBTCBiK
	MuwGtSIKyJpO1NPP1f/Dg7jzNwDANRbsaxdJW7neSlIBE3IrV5Z+8plOXsaRd/Emig==
X-Google-Smtp-Source: AGHT+IHr1sBDyr+di4zUwXvgC4uMa0AU0yhqB+yHNh4HZXZW/Ce6vwXgdUe1sonZ+uTcH5Ze5BxIQA==
X-Received: by 2002:a17:902:e892:b0:1d9:143b:eaf with SMTP id w18-20020a170902e89200b001d9143b0eafmr13241053plg.61.1707138059770;
        Mon, 05 Feb 2024 05:00:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV3xj0epzOiAwWBC7cAIDskhvAWE/Moss9vM1x1AKrSW0oZrIbBuciALqwetGmUSD2WTbTfsYglXLPoqs0fXbga73PFtz2W5QeExUIMae67wO1P97d+Dvu0r2uKRdBpiXyr3zBev9xWnQcxWQTfqkZO6Vpt2hD0CB+/tqnDDTm5BLlan9rDg7zmZcExHVDb74DMlwf4gjmfJa+dvN6hKRGjyk5bTUwW6l7kCDEkGqZKbZLphe+Abz1fFHxj4exc+2Nqrg==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001d9351f63d4sm6252159plh.68.2024.02.05.05.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:00:59 -0800 (PST)
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
Subject: [PATCHv5 net-next 0/4] selftests: bonding: use slowwait when waiting
Date: Mon,  5 Feb 2024 21:00:44 +0800
Message-ID: <20240205130048.282087-1-liuhangbin@gmail.com>
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

In total, we could save about 180 seconds.

v5: Drop the changes in bond_macvlan test (Jakub Kicinski)
v4: Make sure the client could reach to macvlan2 (Jakub Kicinski)
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
 .../drivers/net/bonding/bond_options.sh       | 38 ++++++++++++++-----
 .../drivers/net/bonding/bond_topo_2d1c.sh     |  6 +--
 .../selftests/drivers/net/bonding/lag_lib.sh  |  7 ++--
 tools/testing/selftests/net/forwarding/lib.sh | 35 +++++++++++++++++
 6 files changed, 97 insertions(+), 29 deletions(-)

-- 
2.43.0


