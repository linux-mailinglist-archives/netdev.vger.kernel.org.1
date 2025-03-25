Return-Path: <netdev+bounces-177438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA8FA70372
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE857A6318
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7FA25A2B1;
	Tue, 25 Mar 2025 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="CNJSVftO"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6125A62B;
	Tue, 25 Mar 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912371; cv=none; b=qTqIJqWzJ/X11UtUFJq3duMgTj78OgJceyIw6zD+g/xUO6S2V6W0ML3UMlUc7GbGB6PYmfA+O/Y9m3XdyymVTjlyyMk7Fq1EXyxyPCzmSjtIcRdX2LswvuCGImB/DHZj66iKcqhhVnCvCyvbiky1ffGj5t7GLC5G4yXgr8WjdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912371; c=relaxed/simple;
	bh=GmM9nc0h7Rpsda36dj+2kNnrsCf+HAeRmCa1HiIvXRQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I7wvCdBozfZ8H9YNgWT45GRvSRNUkXdF02yd+8og3suph4kK4eRPmsM7kvDr128BGLe8IUvlGnRsooLOQJkkbI2Y8vGiobMPuE/adSG7XIA9lPdGXQQVxk3lmvuTdBDm8Qbutx6eJu38zPDIqdQ18xELW1BkZgITvb0cfbNIDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=CNJSVftO; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 1BAD5C001E;
	Tue, 25 Mar 2025 17:19:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 1BAD5C001E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1742912368; bh=xOIKQhfLeGn+BFImddppcHEQgCWq+xEUuCyR1dMleec=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=CNJSVftOKCqRKX5+oLBucq6KGFkuJIXJmSD9gEBUroZJAi6hOnGKYfhBCivitmyZh
	 fVCiMNTbdBJXgJPLyQKt09ow1ycjBdUG4JGBbRjgiq3EAWWj1IY8Wds74Abt6x22/Z
	 0DKgJ8qNj/7BK7RyLAuhNkeARzW52ltWp28hXbxJwOVNLtFP4bgI3UhUVz9EEZOgpf
	 NMox4+BP8i8B7fhqPFQJV61QSDUDh8TdoWhFemBkEexlvGcEyWNuPqqvxVCbxUXtqD
	 o46Cff3AHRDEI9Z4hnOVHgWBzF9d8brFEzl/Eorq0iqPT5P13RWjnXx3i0N2SlsFUz
	 i7nlZe9Bl0sCA==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Tue, 25 Mar 2025 17:19:27 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Mar 2025 17:19:26 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net 4/4] net: Avoid calling WARN_ON() on -ENOMEM in __dev_change_net_namespace()
Date: Tue, 25 Mar 2025 17:19:12 +0300
Message-ID: <20250325141912.499929-1-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, mt-integration.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.200.124.61:7.1.2;ksmg01.maxima.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192091 [Mar 25 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/25 08:37:00 #27838357
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

It's pointless to call WARN_ON() in case of an allocation failure in
device_rename(), since it only leads to useless splats caused by deliberate
fault injections, so avoid it.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 8b41d1887db7 ("[NET]: Fix running without sysfs")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2f7f5fd9ffec..14726cc8796b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12102,7 +12102,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	dev_set_uevent_suppress(&dev->dev, 1);
 	err = device_rename(&dev->dev, dev->name);
 	dev_set_uevent_suppress(&dev->dev, 0);
-	WARN_ON(err);
+	WARN_ON(err && err != -ENOMEM);
 
 	/* Send a netdev-add uevent to the new namespace */
 	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
-- 
2.39.5


