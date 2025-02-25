Return-Path: <netdev+bounces-169296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE25A433AD
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 04:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36365176FE2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62D0242912;
	Tue, 25 Feb 2025 03:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQCvo8XH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9D367;
	Tue, 25 Feb 2025 03:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740454764; cv=none; b=CRCwl6wR0IAhQ7AyvmCcirmSfHBzSQnXM4r7bnxyuVX5OWFNVjy9tztNC9phbYKfTLj4/kG0hfs8XiliDoq6Mlop2N80+V2CrvKYrqNqZR1qmZe9477nhSrPKq0Fizw1kn14L0XRGRp9eZKjZ7pGY4yv2W/SrF/OnQnzKNNErlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740454764; c=relaxed/simple;
	bh=Eo3O7fQNmnRYNoxJI3fzcjSQ+wsxJAPEukzQ+8e8wO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V7aKcr3FxS5xYBeHoXzXK5Olpk72J4UnuPaRk1wDc3HtR+bvYw4nvJX7OJa590Jq12V+m8Un4wJyoPx+AL0LfB5+ndZbFvTmoX2X7Sg9tYuYQjxBX7XWR4cYvNBlJpd7dJOnyId6Dcn39c7+QA4BCMXMmONUKZfAGvQ4KZ5O7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQCvo8XH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220bfdfb3f4so1385995ad.2;
        Mon, 24 Feb 2025 19:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740454762; x=1741059562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OjW4eNmpXZQk2be1o0LYhrX91M7wCrQClmxQ5N6YUyE=;
        b=nQCvo8XHmknVktvCiq/cRSXVin9K6oBBiRG1QZXA7UiA1aDSTNyldc13kWPxME1yk5
         oB/T+kQV5vz0jh2IVAZVtX+a/dlwMRHraJiKn3xSKTJ3Lf03zNadME3vaxQg6ahJ4eYR
         87tns2swmTlWY/PMyF+Fa++m3i6QYeW5EUSsV9pfVpDh+enHupZwhCvpkOSm5QSUwM04
         VQPdxGr9CiA0aqIeslz/TqRsaCcN11jX0rcjpdhNFFahUbJrXAlSdJitP5SpKhWavn1f
         jp+8nZmB8aTPUJvw5ODDqix6aO+/fZw8l5n5uGkpH5Oa3Ssqsse/gKvNJU/MPFJDBuoy
         E+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740454762; x=1741059562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjW4eNmpXZQk2be1o0LYhrX91M7wCrQClmxQ5N6YUyE=;
        b=Ya5nQMR3+NEFS8S/7YroaesRVRPwgPAlzfpUEh2vE8QBHEj6FNlxtsScpsrxT6CLH/
         Knwb9ioZbKXXmnDOUGJGGa+gMho9shHqjJphmNp3boe6UK/ldQsw6bdYNq7BU/mzYW54
         3hpo/h5rKJvlrM+/1Dp8hLe7wvsuEBMY5Pz3mIfg44IqvcUrS3/eFA0rHPR9lEUHYgwU
         SCdQJ1PA0l24T7Eu1l8Stncaw0vCtdPw+2qls4oHfyJ5JKDJUgq7EmDe2vH6u4t0qB01
         0q6OnBeRKvR3ngOlK5eMGEPGvglxWHysA4HonDBkcF4giXH5jMvEm4zskdpD/LK8MVO/
         vDow==
X-Forwarded-Encrypted: i=1; AJvYcCXvSdV6jhyUKColIKFLQRtpGcMykgh1SGGd3j3BDFaJ0dKKu8A0Ob9Z+zxnRmh9I93/l4C0mz7xlbA/P3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxr3JjoK4AX1UV46abaWgLtiCyl19s1+xXxBPRmDUAy+Knd9YQ
	dQMu31rZHWpwliUc6LgMDQ0vNQaWHUKy+a/qD2di0shyDMY3aCEJ6BMzh5t3l8+hqA==
X-Gm-Gg: ASbGncslJW1vuqCpEgYvlEhjeDB/i9OVvxmDZakpXechxVmUqc+fIvQ9gxxDu18xX5Q
	NLwvND7Jcqxevz6GOkLWM6G62SuExUpLPIfN7eB1vs0+m2eqjJGMyvJbvL/YLLgV0lCKQ+nHWJa
	+ZHOpVzsHUjkKyBNwjMuNxrDmFeLIGp9vjX9T0plqeurFC5RdSV6cve06UXFZpishlxQMNasU0P
	dGqNgqt1dvZAuhshF8oz26ZRgnvMkLEbOUclQljhS5iaTTTlScUSQpYST952GMNt9I5p3bfpKAq
	yUJr2K910HvYKSrrGfZrvlDGa/zj+RPxpLMwQbd2NdH/3g==
X-Google-Smtp-Source: AGHT+IEua4ozRUVgbw0wJY0ruAcgA1qyqPJMaJdoCsoBPJXy70mZg7lI8EW4WJuJ0MbsV8veWza8mw==
X-Received: by 2002:a05:6a00:3e0e:b0:732:7fc1:92b with SMTP id d2e1a72fcca58-73426ce7706mr26476942b3a.14.1740454762314;
        Mon, 24 Feb 2025 19:39:22 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f8258sm414205b3a.112.2025.02.24.19.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:39:21 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next] bonding: report duplicate MAC address in all situations
Date: Tue, 25 Feb 2025 03:39:14 +0000
Message-ID: <20250225033914.18617-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Normally, a bond uses the MAC address of the first added slave as the bond’s
MAC address. And the bond will set active slave’s MAC address to bond’s
address if fail_over_mac is set to none (0) or follow (2).

When the first slave is removed, the bond will still use the removed slave’s
MAC address, which can lead to a duplicate MAC address and potentially cause
issues with the switch. To avoid confusion, let's warn the user in all
situations, including when fail_over_mac is set to 2 or not in active-backup
mode.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v2: add fail_over_mac != BOND_FOM_ACTIVE to condition (Jakub Kicinski)

---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7d716e90a84c..7d98fee5a27f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2548,7 +2548,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
 
-	if (!all && (!bond->params.fail_over_mac ||
+	if (!all && (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
 		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
 		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
 		    bond_has_slaves(bond))
-- 
2.46.0


