Return-Path: <netdev+bounces-171287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF66A4C5DB
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2C53A31C6
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B412E214A8F;
	Mon,  3 Mar 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIE69zE6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0C2C181;
	Mon,  3 Mar 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017405; cv=none; b=aH562tFh7Ty0eDMLCU/BK5kLgI4KIT/0FTmJ7sVecsesbFqrFytA+6/6PSWAc35lOFQ5ZXpMQbydAGPYaWiUSOcMSGqrL43QHx6SXXVg5QunQtn5GuKf89VFwtfV2r1oEYtd5ecwbw+ZK9tPtJImMExBg82r42geUZbYYit54QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017405; c=relaxed/simple;
	bh=7rIOQzW2Kx4RVLmTaUmrZOQBt31H5EfH7snaYz0R6E8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e+HI0rrkOxuPP0HgVYAuO3eNf5t14UVzHB8SLZzAsGjzZHkqICpY+xatOwqbPnLA6ktBVX2ENvwABMTVc9E9XD/pvDJLJw9N4t0DvWFrdzb2FOBR7sJKEWX0VIl4LnSRK+oFDbtzjmuAz5orwj2HYBGsUTyXItm55F4mSYHoDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIE69zE6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so13986625e9.1;
        Mon, 03 Mar 2025 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017402; x=1741622202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AX2K9dF2sVTuMfiFarbphoOThRbbt8l8n5tN+Dee20k=;
        b=KIE69zE6k/eWOGReUFeMRNdIeBbwXkGtbbSZxlon6ZhCiLx7HhAKWqioh3uCeedEUo
         O+91YyUUWc55vPb67T3vozBKI8M5qv/RhxTsm8nhCEfC8BavEvihPT7kFE9hLqgB16PT
         HotdL+lyTbHi4g/LWjjElkE0UQ8XRlcg53ywW1Wt9vg6ZGsjmEFfG5xBInfn+kOgT5JY
         d9lk46Om8b+qAIEq7FHQjykhOstOQQjO3BhLrk6dKl4XTsryqFeBSOLAVv1FCM5qVcMR
         uHzzojcESONoeHIzQ7R0ttqQjKxMqJDEGMySY8FZOUgDQwNEZQV+4PvCfgmoTzqK48r1
         SSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017402; x=1741622202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AX2K9dF2sVTuMfiFarbphoOThRbbt8l8n5tN+Dee20k=;
        b=CSSjqvd0WL1cRsT3xfEJE29x3ztn/3UGChDr1owaK1sW+QCb1hucT4ZO1/YNubvv9r
         3UxvRDizagc6p3N6h040/aSk5UVXmWEIa4C7BU4+q2kOZk6m42HPV3sneDC0UlxyN/Ko
         eSYFNLj3XyRQ81Nw+D9wVBCOebp8MWMJ6ofhIlLC0bDQscM9qk1Jff+2icPR+qquvp49
         LwCcIGGre1OHzx6m6LtK2VW5oEeA3QYAQiWGclvILfJZPoT1RpeSxkYzh/WXM45uu5zl
         jKwxcDba7ube0zQYIXh+gPKKDVMppheyC+aEN+4cMhX2VfjdHI/gDYILa+CruNyJyjzF
         fJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQOfSTmTINlW5rZWSATgSx+fsf3B1Vl533AnjpM0LAUTGkQQubiKznJgssPr3dNT5OElafL/yy/uBLssA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7d9iMDD+3SPtejiSMUmxvpTCdvp+6muSVpxjPLASR8JavO44c
	b8OHdVFNvIhvySGr+lbK2+6YH8p7FX4LTeKFyPcqfLYCIpGThnkAFoK5LpjY
X-Gm-Gg: ASbGncuIxcILITV09EimFEVreLlU+AMGQn7jueWWzon2W/g7+OKEnt6NxqOlEpcKLJ5
	i76GOiPhEcv3USXWGUwR6bwVfNR35381DUs8b4GuGxTjQ/STNRmEbGVHeZcmBbil1OUEzVYGR32
	/ilBZd/D5tIELAsLWWOWoHkM4L7pvO6BZm6DhZNqzQ+VTNdgQ8tmKjzQCOxYOhrq/EyxWqAw3ot
	k2L3F5ktTNbwhTPk/dilRRy6HrB9R0/vJYfH+oXZuWEb5Q1TjKF6UwjAHKMKe14f01EIzd/Rhx0
	WoR9xYwU8KV6MasAa3vFGKAln25df9vRjxnjODl1K2+9xiZTUO0Sjmo1
X-Google-Smtp-Source: AGHT+IE83+IX1LdziB0TpVvQKV9XX+F11wAf/th5ziD87Jl7sy4Bma7ezgN95h5fTZcpxM653qPzzQ==
X-Received: by 2002:a05:600c:3596:b0:439:84ba:5760 with SMTP id 5b1f17b1804b1-43ba66dff51mr125265275e9.5.1741017402036;
        Mon, 03 Mar 2025 07:56:42 -0800 (PST)
Received: from localhost.localdomain ([91.90.123.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e13fsm14709382f8f.100.2025.03.03.07.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:56:41 -0800 (PST)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	viro@zeniv.linux.org.uk,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	stable@kernel.org,
	idosch@idosch.org,
	Oscar Maes <oscmaes92@gmail.com>,
	syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com
Subject: [PATCH net v3] vlan: enforce underlying device type
Date: Mon,  3 Mar 2025 16:56:19 +0100
Message-Id: <20250303155619.8918-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, VLAN devices can be created on top of non-ethernet devices.

Besides the fact that it doesn't make much sense, this also causes a
bug which leaks the address of a kernel function to usermode.

When creating a VLAN device, we initialize GARP (garp_init_applicant)
and MRP (mrp_init_applicant) for the underlying device.

As part of the initialization process, we add the multicast address of
each applicant to the underlying device, by calling dev_mc_add.

__dev_mc_add uses dev->addr_len to determine the length of the new
multicast address.

This causes an out-of-bounds read if dev->addr_len is greater than 6,
since the multicast addresses provided by GARP and MRP are only 6
bytes long.

This behaviour can be reproduced using the following commands:

ip tunnel add gretest mode ip6gre local ::1 remote ::2 dev lo
ip l set up dev gretest
ip link add link gretest name vlantest type vlan id 100

Then, the following command will display the address of garp_pdu_rcv:

ip maddr show | grep 01:80:c2:00:00:21

Fix the bug by enforcing the type of the underlying device during VLAN
device initialization.

Fixes: 22bedad3ce11 ("net: convert multicast list to list_head")
Reported-by: syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000ca9a81061a01ec20@google.com/
Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 net/8021q/vlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index e45187b88..73a92e748 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -131,7 +131,7 @@ int vlan_check_real_dev(struct net_device *real_dev,
 {
 	const char *name = real_dev->name;
 
-	if (real_dev->features & NETIF_F_VLAN_CHALLENGED) {
+	if (real_dev->features & NETIF_F_VLAN_CHALLENGED || real_dev->type != ARPHRD_ETHER) {
 		pr_info("VLANs not supported on %s\n", name);
 		NL_SET_ERR_MSG_MOD(extack, "VLANs not supported on device");
 		return -EOPNOTSUPP;
-- 
2.39.5


