Return-Path: <netdev+bounces-142221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F15AD9BDE39
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 06:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7324BB236DA
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 05:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F419048D;
	Wed,  6 Nov 2024 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv0XXUyS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E22F50;
	Wed,  6 Nov 2024 05:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730870092; cv=none; b=d88HoKScG89AAYWVKHmJqPYMHC2808f87mtZBRtWLgcnRdi74rsSgQqMA10v1vDJQbo2KGcwnGsC5FJz7YdgeBjJECbWNwveojZj8gZaxytZO7QpCHzDp5CE4YaaD/2+/pXyMu2FG8VgwEAvXMD9AGStg+Y12LSf2kbUx5pIvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730870092; c=relaxed/simple;
	bh=aOi00T4++Of1PkyHaGLAlfMIrUpqwxl1+VaBGZflApQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cc8EqPzXWxgJ+pSQnIAXwQ3qRzdauO+Z5/I1nRtg2zQBngBJK+ZXnB4/I+TYOEceb5vXjVGpFvjLreQHiXT7Xj+sZM/T17qcCV8G1yv3ypwsv9f+6R3yeC3zXvtelpd2hrxxqda4wzw7zhXZMrSxADuBcmbBW1qX7OMw0ekvqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv0XXUyS; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so4453406a12.1;
        Tue, 05 Nov 2024 21:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730870090; x=1731474890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MO2PJn9Xpr13NQes/KiEu9oCINUR98kGVv3+sk3Ibk4=;
        b=fv0XXUySz78B+aLkNBBv/ywGqxeSFQMaqyceO5ERPcofGOGE4pu7uIckLkU4rbwTbg
         rRLOYkEogKF4bcniHvSW8PMO8R6uZm+JAr3JoxamJTZxJzCb3FOJgBthRmkngwFFdKou
         QhunG2G5HKyU2w+S92ssJBhrOucD3PO0jTXarxGQxU/DBhMv8lsWtA56QO1w1XgCFs3X
         W2v1AdTGx36bgmdYKIRQCJNvTVU8EZ3qMcc3JZxfwZAcTPpmX0ZcIUZ5H3KjOe9cseL7
         xYu306EHbBWYxsUJYtyM0zSsZ96Q3DuqG6xsQpSHRSMmYalYATCUIOQMsZ1+o9rkRX/2
         SuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730870090; x=1731474890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MO2PJn9Xpr13NQes/KiEu9oCINUR98kGVv3+sk3Ibk4=;
        b=BHyiWx5BUPO7fLROj+mEXVMqAYp/4RQHUYt/eylHpCSwCddWNpkvUyJWAjmP119Kz6
         r6Iezp7j3z2ZYmOWMZ6UBfqznnN5w4ryiriZx9soA3A8cJJXLdBS8T0wI8941zlkldZD
         Z8FW81siAUHluyETeMeA5FGnjPf531/xgdFvSQ0SqO2cYTWYCb5/3jjOceJCTeO8oVld
         75b77+36IAgv2VmCHdQg95MWgfI5LHRCgcYkgQwp9oixzh/g8TPCGCvrziNzl7dNKvNY
         vOeA+YF+A0xTUOQAqwhH8Vn8J8YWr9YiDpSQXGIp3DBbRJRlF++uywaY7+yEey/MHt1D
         j/2A==
X-Forwarded-Encrypted: i=1; AJvYcCV9zgxFC+/A8XWNB9JXYVbRi5u+3Wv1kksdGV/0l+k61n35kDibRA1UUDTDPZ6T51a1iJFukTp4pDzmyYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0cpDPxQWXYqtUyKCOZfegAaAfnzCJNK8SnQ2cXWc0t6RhONN
	OltfCnmUlirpLOyr9Kqfs4AbCtMAp8rLTfp9BDw2JiRKnrGQJBx72ezvfaSsbCA=
X-Google-Smtp-Source: AGHT+IEFZOFJF55lJ2hFw1E02SJoWAMuuNfZ/Ht9/kHayjriut68adNfkSl4k2DkoyOeFrtf8I6Ewg==
X-Received: by 2002:a05:6a20:748d:b0:1db:f00e:2dfe with SMTP id adf61e73a8af0-1dbf00e2e10mr7570260637.39.1730870090122;
        Tue, 05 Nov 2024 21:14:50 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ee3e4sm87988945ad.3.2024.11.05.21.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 21:14:49 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 0/2] bonding: fix ns targets not work on hardware NIC
Date: Wed,  6 Nov 2024 05:14:40 +0000
Message-ID: <20241106051442.75177-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch fixed ns targets not work on hardware NIC when bonding
set arp_validate.

The second patch add a related selftest for bonding.

v3: use ndisc_mc_map to convert the mcast mac address (Jay Vosburgh)
v2: only add/del mcast group on backup slaves when arp_validate is set (Jay Vosburgh)
    arp_validate doesn't support 3ad, tlb, alb. So let's only do it on ab mode.

Hangbin Liu (2):
  bonding: add ns target multicast address to slave device
  selftests: bonding: add ns multicast group testing

 drivers/net/bonding/bond_main.c               | 18 +++-
 drivers/net/bonding/bond_options.c            | 85 ++++++++++++++++++-
 include/net/bond_options.h                    |  1 +
 .../drivers/net/bonding/bond_options.sh       | 54 +++++++++++-
 4 files changed, 155 insertions(+), 3 deletions(-)

-- 
2.46.0


