Return-Path: <netdev+bounces-242310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D3FC8EC60
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 803A6347EE2
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DEB32E130;
	Thu, 27 Nov 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQHeAbT3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1331196D
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254014; cv=none; b=n1qCPBxEGbuve75O9/K0/i7nr5V58uOmwqo+tlznQBvfA5CS2NmDvcSO/+eoQSOBSDxNlZEKlCv5aWzr9OO+ZEEpZaztQoaKz0M43AktTgsn+xZLxTrJ73XAUlH4aDmlm8Q8YxL4VS8l00vUAVlm+VnjksCbgoRV3/oLXQpruOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254014; c=relaxed/simple;
	bh=tvZva6AUWDs6H9DZPxZEMtv2jwVTqWRwj57A2k4OIuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZlS/D/oSEXoDyGNSgLOTZlhejYAeXTq1XxYTTXz2QeLIHRECmY8ywZGM9Oa3YvXVhQUMvVOdBo3edEmFED0dy6VhY6jBlUxu4gK/9lcYieV0IDFNg+o/uamfgWd6LaH11I/6uK4mwZT2rGqZ3RzJAlYVjWanXPv08Wsa+98Srm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQHeAbT3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so1141632b3a.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 06:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764254011; x=1764858811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78FV6UYSi7/8C8kaIgUgHtZvrrRC53ZClmIsNXE7ZJo=;
        b=FQHeAbT3mQlmETrt5SGPEvZhnIvl1jsjx+iqFMMjgkP2IvemlI0qMyVnaVC2FhxppL
         gLg7LRJZ7HbIr+iTlIIEbe8I5NV08uSnBIcbok/53ucyXoYaPw5nMz3xBkpKu4U6B4qd
         cLNMLpL/z8kOFenOGh9ecAXh4FP39yBnk7EcySPbUZ7TPJ+5vLj90dnppBGCEos27YD+
         HCWg6mGios7kr1PfIa5j1YHCbl36cpp94cVp/w+OkKGgTg3VF+otTafp50mWWIEgTmnD
         lqnZxuuQjrH5Ntv4gkHC2RBw+IbaJ86LiVWAzCiyjJ2bj+zFVk23SbbgCQQjGhrlKnae
         ijtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764254011; x=1764858811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78FV6UYSi7/8C8kaIgUgHtZvrrRC53ZClmIsNXE7ZJo=;
        b=qPWv3p/9LdtQ5gKI0ODPAP3XpveD3CZBeNqSZ3PgRdOVirnQHNjihqtQvi0dnZh/U7
         I0BdiadrSCT8kjybo2hMqaiq0MJ738Vylvkl2daSJAkA/+4d9gDRLIcU+0sPsfL3oZ2/
         NU/TqaPq3EYYGsz2hd9y7HIVa4R+8L4g7u49FlP9fn4VylzwAmK/hCq/OcOW0S/baJqe
         /1JCqx1endIUKV2KWI8MVphVtffWpDYzslRm4NdP8DkK93/clZVRfV42tTE5F+yQ/dKJ
         VOOTBpZV4X8Zq1eVfcwnt3/lzRcQxNtF/QlVtIF9BGyEYIDnHqKGumicpiQZqG/mdmof
         Ierg==
X-Gm-Message-State: AOJu0Yx55KiX4r5DQ3P1umYaGw+r5JVGu22ivp5OcSDdrg9PmD5Nqp7p
	ZJDeapQtMFXaXkbu5ONQ7ivrucMluY+fpA/zJDiXE+6NUiJcgQOsOg7V9WY1v4YiszY=
X-Gm-Gg: ASbGncvG3k2vfkE3U1j+Ahwf8Dsnb7wD2sVjAMCjrvsAUt8VVKxDmCI2pRs7IT6T8at
	oz9ZMGoleLvNJ5efsyNKPb1c9TKKCjAYPGIYYxO523hi/lwhvFa/GLzzvmGpvMw/PNbUrnmpjL6
	h2hARUoheiBXxH6KFEVHIwyBz9uIjQw9yEyp9Ntb0gcxyDI//GomkibN16cffY3/OnrftHw/i+c
	+x9TCbHkEllMq05d5AXyIAcRzKcyCby2J2tFTgTrad+pCSjE6/Ol8ilBpkDLRKOQ9i02xddZs+V
	NPXOQOdYmpqF+MOe0tEtCb4XeUi8eyxNBW/Ma3klCYBhKls/W+Z3xKv7dqJ7uxyfqHjMVa3rTL9
	SJ4zUQud8BOlQsGyzE1DZd8WxUR6sOJ9Pq3iy55WgiBF8AWlP8K0pFtkyuafDJDJn52FlMbFBDz
	1JC/QuCYuu3fT5A3ZOVBhb/Kd/XA==
X-Google-Smtp-Source: AGHT+IHOjobWASJ73Zrh6Qa8pXI3uqzF83ifoElBRiObxI4QCVxxJ5b3Dg0i0XAfIuHwjIf0lHQCdA==
X-Received: by 2002:a05:6a20:3d1c:b0:341:5935:e212 with SMTP id adf61e73a8af0-3614eb77688mr22536575637.18.1764254010884;
        Thu, 27 Nov 2025 06:33:30 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f9260a4sm2157958b3a.58.2025.11.27.06.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 06:33:30 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests: bonding: add delay before each xvlan_over_bond connectivity check
Date: Thu, 27 Nov 2025 14:33:10 +0000
Message-ID: <20251127143310.47740-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub reported increased flakiness in bond_macvlan_ipvlan.sh on regular
kernel, while the tests consistently pass on a debug kernel. This suggests
a timing-sensitive issue.

To mitigate this, introduce a short sleep before each xvlan_over_bond
connectivity check. The delay helps ensure neighbor and route cache
have fully converged before verifying connectivity.

The sleep interval is kept minimal since check_connection() is invoked
nearly 100 times during the test.

Fixes: 246af950b940 ("selftests: bonding: add macvlan over bond testing")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20251114082014.750edfad@kernel.org
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
index c4711272fe45..559f300f965a 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
@@ -30,6 +30,7 @@ check_connection()
 	local message=${3}
 	RET=0
 
+	sleep 0.25
 	ip netns exec ${ns} ping ${target} -c 4 -i 0.1 &>/dev/null
 	check_err $? "ping failed"
 	log_test "${bond_mode}/${xvlan_type}_${xvlan_mode}: ${message}"
-- 
2.50.1


