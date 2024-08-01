Return-Path: <netdev+bounces-114792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED913944116
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83372874AA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E441EB489;
	Thu,  1 Aug 2024 02:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzI/CSx4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEBA10E0;
	Thu,  1 Aug 2024 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722479031; cv=none; b=P86ANebRUEAFFZkhoZF4rcHN50fx6xWe8ZPFA5JEFLppma5j4Labd1+RdgJA8od5jRHdJUw2PoPGLgCkyZk6pCtoZPTyI66XvjTO7EihK8wCrLZWW745v1w2YFa7NvoqBLtTkQoLpZuJ8Zlze4zMn2UriQ0grsYqT3JPvourCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722479031; c=relaxed/simple;
	bh=Awnf47VbdBqBCnqt1VRab2i0AW4HMqbmXA6P4toHOnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pydpCYd1kLKtUyZJwTULhy0vUAL8cMoqr8IwqR02QK4Z8pFVS5g/+vFaP8QIjhxCJe8D1tdVhL7tUpFV7UrIuV/8g6BBHYtEzz6zwHiacQ2LH4lN7C4Y0muGHnd7IdW2r3I4byHthPqn1UzOR7xf03qENZ3oHag/NqPrde0h738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzI/CSx4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc65329979so53372265ad.0;
        Wed, 31 Jul 2024 19:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722479029; x=1723083829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLnDPRKgknaGZzCCd3XmpPWrPrYVFYC91ZcyCfkqBq8=;
        b=SzI/CSx464OF11ut49ihM8WSmcjtb/eax0EBkSUaCKPPO5xb8jRqzHLrq8oF2FLTRq
         juM/J2BeysnkIAL+IOyOzNBtR96+Rg2Nk2Wp0uOV5TeCinAxEQPWczZoPCiAAe83qI7a
         Y4kwGREjrUSifTDUeCnTOC/mfO/+WfMfR+hLX+mTwtvbI3g3MxYq4489ns1Cto8fWN8l
         s9DgVcMiF5AgZ20ysEAA1Q2FvUmObWuPjQZtbFBuId0rzW4pYXjYWYbk7HmY09tmua/u
         bEPg/Aaou4dBKlsQ3Swq+PK0VIgcOJEjsgwfYXVKrwszbD7GNxNmU3EDfPilPNkzkDLA
         5HIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722479029; x=1723083829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLnDPRKgknaGZzCCd3XmpPWrPrYVFYC91ZcyCfkqBq8=;
        b=qhZmCNekcsMU7/iY2AbDr1n8MUPpSOeDuNy2zW5zPb2k5fdsnh96p7Rn9L7WoYxOtJ
         IZW6rgM9mkaGiQ0Z0aFTkf+AUS6AFepEfGtQQxCgCeDf9bTtFRQkxdCNjdOwJK2iEjsR
         3gIEbkUPnz1JRp3cSxMZeJ4IbOv90d/O+kS4NVrCZZ2cHwZNi//yNoDobBbx8pMN9sEL
         PXg54MmxWUQ0dX2R++NFsGEnB7aA2QvvVIKLWJDY+13ohZodIbwXMQPt+i8FNzSBZTXf
         iuxSQ+3pjjw4ywVPT93AsuUcXoiueKrmWpVZs2BgX1Px0wN3pVodxRlKeKmgvL7myUbs
         aIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSLyJ8/ReZuULTpB4bJyw+1OaOBW80eR20BlLDJnDt3AswUXykcF6/qtkWtE3kr9ginNwAno+cleaP/gE40IrNkeLNNIoSA/PV5b06siqa3F9Mo3fsm9OQFljsNYXkdSdtQBy2
X-Gm-Message-State: AOJu0Ywic1CLI+FjmeN8w8Kp62BOp5rehEM5zuW5X/quy9X4kTOXiNTq
	XRz5RkL/fevyEx6pHfDaggzJTbCpf2fZbAUCAF1M22IoGpmwRrmb
X-Google-Smtp-Source: AGHT+IFwgek8Wdri83/0mtz8JOXnQt9sIHUFS9pUuUs75DiejE7twn0Ovyy3B+236EKilu0z4WQmzA==
X-Received: by 2002:a17:902:ecc1:b0:1fd:acd1:b638 with SMTP id d9443c01a7336-1ff4d25c905mr16809785ad.54.1722479029232;
        Wed, 31 Jul 2024 19:23:49 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1364sm126956075ad.136.2024.07.31.19.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 19:23:48 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net-sysfs: check device is present when showing duplex
Date: Thu,  1 Aug 2024 12:22:50 +1000
Message-Id: <52e9404d1ef3b11b1b5675b20242d3dc98a3e4bb.1722478820.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sysfs reader can race with a device reset or removal, attempting to
read device state when the device is not actuall present.

This is the same sort of panic as observed in commit 4224cfd7fb65
("net-sysfs: add check for netdevice being present to speed_show"):

     [exception RIP: qed_get_current_link+17]
  #8 [ffffb9e4f2907c48] qede_get_link_ksettings at ffffffffc07a994a [qede]
  #9 [ffffb9e4f2907cd8] __rh_call_get_link_ksettings at ffffffff992b01a3
 #10 [ffffb9e4f2907d38] __ethtool_get_link_ksettings at ffffffff992b04e4
 #11 [ffffb9e4f2907d90] duplex_show at ffffffff99260300
 #12 [ffffb9e4f2907e38] dev_attr_show at ffffffff9905a01c
 #13 [ffffb9e4f2907e50] sysfs_kf_seq_show at ffffffff98e0145b
 #14 [ffffb9e4f2907e68] seq_read at ffffffff98d902e3
 #15 [ffffb9e4f2907ec8] vfs_read at ffffffff98d657d1
 #16 [ffffb9e4f2907f00] ksys_read at ffffffff98d65c3f
 #17 [ffffb9e4f2907f38] do_syscall_64 at ffffffff98a052fb

 crash> struct net_device.state ffff9a9d21336000
   state = 5,

state 5 is __LINK_STATE_START (0b1) and __LINK_STATE_NOCARRIER (0b100).
The device is not present, note lack of __LINK_STATE_PRESENT (0b10).

Resolve by adding the same netif_device_present() check to duplex_show.

Fixes: d519e17e2d01 ("net: export device speed and duplex via sysfs")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
v2: Restrict patch to just required path and describe problem in more
    detail as suggested by Johannes Berg. Improve commit message format
    as suggested by Shigeru Yoshida.
v3: Use earlier Fixes commit as suggested by Paolo Abeni.
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0e2084ce7b7572bff458ed7e02358d9258c74628..22801d165d852a6578ca625b9674090519937be5 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -261,7 +261,7 @@ static ssize_t duplex_show(struct device *dev,
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	if (netif_running(netdev)) {
+	if (netif_running(netdev) && netif_device_present(netdev)) {
 		struct ethtool_link_ksettings cmd;
 
 		if (!__ethtool_get_link_ksettings(netdev, &cmd)) {
-- 
2.39.2


