Return-Path: <netdev+bounces-105175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A80AB90FFB1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3651C21358
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635291A4F36;
	Thu, 20 Jun 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7xNSWxK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E475242040
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873819; cv=none; b=rmJKbSBUeBlhODUImBokfu2ilEXEJhg+SrXy3xtrnqzUUncKAedNEbM14XJx+c0jTZgl7kbLgSZ6Nx0Q/eMbDRGa8vnfs0IixuQYmgUdUVOA6Dagy+SM0DEetdMehA6wcj/Bhp/Bk90tx2VY0qunRhGpZzdXOshMiecemok1ObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873819; c=relaxed/simple;
	bh=IpwFMixaWYLToUCvCL75BdRcN69mIzkLmir087nboQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZropRpeSOIR0yMHrDF1fDAuKJLi7MFblxOVCvwD4F6mCgTgbOZdi+GLkgl1U1/wab3JvhVTEv9dm/d1kalpPqALcPYuwaZ/honIxqUTwdMhM4JMJbNFqGvjQodbze4ZywnQOogkNSTaZWO/+fp4dDkWQcdAAk0EhfjIbdj14ADk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7xNSWxK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-706264e1692so546862b3a.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718873817; x=1719478617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rPZyS8J6cPb+po12AvP8fI1lO0sEfNDBUfVktw4N6ic=;
        b=A7xNSWxKTR2ycndtXXwAkCtJibHFB4nd2KkgW2qYpFlX3JSW8XaVgBMorF/ZBWpDqw
         F8DDHlssez7dZzPPzKs523mWkT69hlikootaQTxk3Nu+q3KCrptJeehQ1arTzHs1/Xj4
         AXLHwOsB7mHoqw0ul1uVyX5aeAeS0DUpqV6VJiBfVMF6cC9lWxG3W37WtCSQLZeIyeyv
         yCGdd4CGAyUjL+kNNl8cO05yvDWwxVravyVQmRgsUbmLCrcMpwRRD8sDJY7p8kOWHGfH
         2y3Viib/ia7QaX/iAsdBon7HOZl/eUl43tajFo5FhZYBYpw+wgmSJEa0+9mORsetaggD
         bmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873817; x=1719478617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPZyS8J6cPb+po12AvP8fI1lO0sEfNDBUfVktw4N6ic=;
        b=mLnsXHJlTjXQf7xAXyHP+m2z1AERqURClkNAMh2YpVhppF/7sqYGHmAp50zwbpcM0p
         kCgTcBYOkMNEN23db8Rz2CVAkNeeujaX7C6uaxMMZE6ujQfteIooffSrXJ3jYKf5qjNf
         +trVR8T6pUCl4Q+hFYOei/L3u3a6IwJs05YycVVuqMYCZ1nl8BtjeEtbE5ykfM2rChEa
         a1EPE1mpTpkv0cyRl6WQp207003g0XsFv3UdN5JtkTSV1XD9zznBE/u4ptTyFRka9bci
         4ObdV09Hk8upfYi5gvj+B4yKNmacNDKDvijWk6XOJvUreLhC+atEonGXBG+v3kTn5VGc
         dz4Q==
X-Gm-Message-State: AOJu0Yzh1vSPab8O8F48QS30crGY+VvSbHw+H9tTkuy1kJI8x7mUXMZC
	auxmsalUB505q0GlMT/KCBZQjGmZjurtmWiAgwxipUn/5Rp5coXyVwunZt+Z
X-Google-Smtp-Source: AGHT+IFZZwjAQOJmOyB2PkmMTLe8yiAYIiykxvMqoEJj76HTPWGIccwvgTzb1ahIVJBvIbM2R0OtMQ==
X-Received: by 2002:a62:5e45:0:b0:705:fe85:3672 with SMTP id d2e1a72fcca58-70629cce6c0mr4771346b3a.27.1718873814717;
        Thu, 20 Jun 2024 01:56:54 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:782c:cfa0:b84b:f384:190:dd84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc988700sm12283851b3a.91.2024.06.20.01.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:56:54 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Liang Li <liali@redhat.com>
Subject: [PATCH net] bonding: fix incorrect software timestamping report
Date: Thu, 20 Jun 2024 16:56:26 +0800
Message-ID: <20240620085626.1123399-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __ethtool_get_ts_info function returns directly if the device has a
get_ts_info() method. For bonding with an active slave, this works correctly
as we simply return the real device's timestamping information. However,
when there is no active slave, we only check the slave's TX software
timestamp information. We still need to set the phc index and RX timestamp
information manually. Otherwise, the result will be look like:

  Time stamping parameters for bond0:
  Capabilities:
          software-transmit
  PTP Hardware Clock: 0
  Hardware Transmit Timestamp Modes: none
  Hardware Receive Filter Modes: none

This issue does not affect VLAN or MACVLAN devices, as they only have one
downlink and can directly use the downlink's timestamping information.

Fixes: b8768dc40777 ("net: ethtool: Refactor identical get_ts_info implementations.")
Reported-by: Liang Li <liali@redhat.com>
Closes: https://issues.redhat.com/browse/RHEL-42409
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3c3fcce4acd4..d19aabf5d4fb 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5773,6 +5773,9 @@ static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
 	if (real_dev) {
 		ret = ethtool_get_ts_info_by_layer(real_dev, info);
 	} else {
+		info->phc_index = -1;
+		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
+					SOF_TIMESTAMPING_SOFTWARE;
 		/* Check if all slaves support software tx timestamping */
 		rcu_read_lock();
 		bond_for_each_slave_rcu(bond, slave, iter) {
-- 
2.45.0


