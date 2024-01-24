Return-Path: <netdev+bounces-65405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382A83A61A
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493B11C20CA0
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8786018054;
	Wed, 24 Jan 2024 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glwywqKR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850C182A3
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090304; cv=none; b=XA+mdrvlzONiRZ55gqQYfaRoEo21Jd5B+aBGlJZqMydBFx1ny2/RKwtofHuVFtm595bYyIzN4uEqOOVgecX3XLKc4tY9v2X4BxehbU6FaPtxVmNwXp8vXwkJGq+6UFX3/Djqv3/ZFDcS6n0GvlTYnapyQonyjDAS6uVZpqDrdQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090304; c=relaxed/simple;
	bh=LnW05ukvl+w8n7ULRPE9Gq9pWErnyfZDKp/jAq9Onnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pW9t8HtwxSTfe6YY58Xd7xllW0kMjtzinNKf5xarsUmdxwxJ3ChAbbZsZBvwmw2sPNYE8cYRiIiQoF7iEwLoS2RMuj++VdaGk2f7MWz5vMr9A0NtjqDouVNva6PqCeo9W1C0r12vLeoUt2Un/SAjleWwc6aOwMNb8Nm+cUykpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glwywqKR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso2053343a91.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 01:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706090302; x=1706695102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dgcjovezhFU3HKO3tnatzRqAGG4yR9hc1BiKbd61k1Q=;
        b=glwywqKRokpmEsZFfEmjDcDIaE7Adth56EPf0HTEkI00D+U7dIe580ChGjRyGc5xsR
         XWD8YD5aHgnllmaZBiHW6tRIEmc3alX1Y/R3qVCOTXVTCeswJQQ1zp8tI6+wd9gV0bhJ
         QJaaYef3oYtV/NmPKDJJeIHnuEnF4NdCCifDwdkJvaix/5O/xaS7YMdr1sidTMBV5nOo
         s3/YM0q562W0uqz1HuOPHtH3zIgCtUQlYMhhLo6zlcBEEfzuYpmqphgVu040kMSsc/nh
         CHM/MpNguXLp8Cu8MTEokGv5kr89jLdk6dEwRyWYKa+IufQQBTXj26z4vuORw5ESQPkH
         N7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706090302; x=1706695102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgcjovezhFU3HKO3tnatzRqAGG4yR9hc1BiKbd61k1Q=;
        b=NwfXE5Biqw+lfcjHNPJFO1RyieGNyJP8f5iu+zx6/AKW67yZdej+tnYZVuRH5rjsL6
         BHMgjBxxpeGQnYThtj4c+oMANfy9XE4KINHEMfX4EJX5t88rd3KePEvwIZbc2NX+3Nf/
         NcLdFTreg1Psk5OqRe9V+fUrd5CkjIguQ6fhKd1504ajPj/bQrfWZ+8jNcU647ru9rH9
         HNged4fUsGJsw+rwG/3Y3nF08XKRBMMD+bZgyj/BSNJN9anxchvJ80ugjyw8FlIAAyDF
         oA5jWvj7BVXETh+I1m/esE2kD3Tohp3k3BOcRde0Y1TTSpypKGdUay/ZJVUFLDyUTY6N
         T4vw==
X-Gm-Message-State: AOJu0YxV//Eq5OmoBSZIzs9nYpgUAbWPOw8XCys3WXUBT2PHrA2s4O6o
	Po/boE5ITcdFD5zkPqullzkp0AckLj7mStGT/xvyrqrdoE19Oq06Jj2EnXGbB3oZYXwp
X-Google-Smtp-Source: AGHT+IGu2fWnl4WjIzXSFk4jRFx9di9GBdkaxtSy8EAIH9DwURUzYJgO7GM9/kPA7Ck7/plHXFx9EQ==
X-Received: by 2002:a17:90a:ce01:b0:291:2:691 with SMTP id f1-20020a17090ace0100b0029100020691mr66921pju.14.1706090301661;
        Wed, 24 Jan 2024 01:58:21 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id so12-20020a17090b1f8c00b0028dfdfc9a8esm13055367pjb.37.2024.01.24.01.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:58:21 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/4] selftests: bonding: use busy/slowwait when waiting
Date: Wed, 24 Jan 2024 17:58:10 +0800
Message-ID: <20240124095814.1882509-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a lot waitings in bonding tests use sleep. Let's replace them with
busywait or slowwait(added in the first patch). This could save much test
time. e.g.

bond-break-lacpdu-tx.sh
  before: 0m16.346s
  after: 0m2.424s

bond_options.sh
  before: 9m25.299s
  after: 5m27.439s

bond-lladdr-target.sh
  before: 0m7.090s
  after: 0m6.148s

bond_macvlan.sh
  before: 0m44.999s
  after: 0m23.468s

In total, we could save about 270 seconds.

Hangbin Liu (4):
  selftests/net/forwarding: add slowwait functions
  selftests: bonding: use tc filter to check if LACP was sent
  selftests: bonding: reduce garp_test/arp_validate test time
  selftests: bonding: use busy/slowwait instead of hard code sleep

 .../net/bonding/bond-break-lacpdu-tx.sh       | 18 +++++-----
 .../drivers/net/bonding/bond-lladdr-target.sh | 21 +++++++++--
 .../drivers/net/bonding/bond_macvlan.sh       |  5 ++-
 .../drivers/net/bonding/bond_options.sh       | 22 +++++++++---
 .../drivers/net/bonding/bond_topo_2d1c.sh     |  6 ++--
 tools/testing/selftests/net/forwarding/lib.sh | 36 +++++++++++++++++++
 6 files changed, 85 insertions(+), 23 deletions(-)

-- 
2.43.0


