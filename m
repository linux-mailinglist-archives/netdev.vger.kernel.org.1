Return-Path: <netdev+bounces-106786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DBF917A20
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097ABB24159
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667F015CD4D;
	Wed, 26 Jun 2024 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV2IGp9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E764D15820F
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388345; cv=none; b=d49c1gGhDzlMDUe0iYG+fYkVHQaY/l01uaX/LcDupnkWGmqHVDzftUO0fYIvWt0qxXuLLoiNHspNyiLZQYNAbk8u4b3udwaesfTRzwCrQgcIVVO1b3jvT9QwtbGDG/Q7qPj36c5W+6kzvIIpQrqK3R4YUiU0rnFmCxJSD7l+eR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388345; c=relaxed/simple;
	bh=7w0StIqNckR0lMBrwCHv7q8urGaMeab4igrkCb0F1YA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E5Ae202AX0xZR2UfVKrBF7nEr8p/K6l0MyUOxWvl3erzBw3u9ezvoyLL5HWo2704xrnim/MUlh7SLN+ZGqUDsbIL7GTyJVPsKwykHHfVJjjCaIt7cmjVk/9/sXSFvKOgH6qCAeemb/noTiJhYElgYKFysPk0+MR5gaGOMsS3zKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV2IGp9n; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fa2782a8ccso24604085ad.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 00:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719388343; x=1719993143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4K5gXbeStfpl4d3xz4WLZgupeyPxpwF730y9umE91Q=;
        b=gV2IGp9nkb6xJ10CzzDhrxu+JW+INNxbx0aHQvZgAFM9c8uOM3EAEJbI7EzdPbHXG4
         Z6rPhZ/YudXfdKh7cPPncaoGFP93ZXWdKZq37nS5c9slLes1IXY0cZMK2eeg14U0tghY
         TU71kfZY2xAUhZFY0k5eJQ11pOrVAgtBY8BzYF6oCLmRMYZwwTKKkeCMLhs17u0p7Cu4
         4Hj8KDKNspzM9w0bNKplR8FC9/Mhx7MeS83OGI/It+BeqPVmp7Prc8IV6t5HZQDiIqdr
         nXcCGxHNHUnpvzWOv0D4iwhS2S0LHSuH27W6DCNnnC4WWkSl5Hobs5HQnpsWGeOhtPKD
         NOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719388343; x=1719993143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4K5gXbeStfpl4d3xz4WLZgupeyPxpwF730y9umE91Q=;
        b=u2IrFs2cktpykTXGEa88KBaDL1dU4ciamhLLIT6cdDrE1M3rOX3AdTawWbcSVrBKCL
         +zbJSjqMxfDvA9seleQM3Xi9NtR00wgv9/3IapgoEynUZqakW3x90wx2BZmL7O7yUavX
         RMPZ/xoL0WTc9WRBO+G1XOTstfWknSJEDmR/KHlq5pWnFNGWjGjiVYInNxiZLGdlpuOI
         uTlBgLBPeK7QcfeKCUB1/fm28mvx1EtzUbSKr15vImG7VXXU1pyd0YAW4GyEsE3sj4Nc
         0m+Z/PPnLsjJMFs6YpogD2ZbJxE5rVEI67qtxUEWkIoNcEh60PSD4ecdMxhTyC2QerjS
         SVCA==
X-Gm-Message-State: AOJu0YypAMk7gZ7rgKejV4yoYevSvDi7zuE0nequWlhD4yKsKQ8cI9BE
	q/4x4K+8b+aKtgiTIWsbTZzgDHQqAMgDL3+F4jDp5vezWsqVQsi4niBXxRKrUM8=
X-Google-Smtp-Source: AGHT+IE9/7QoqIhl+e9zH+WrD/mha3VvqlFE9awDPci/3OVBjF8+nOHRdB4RAZyYMlMdiUM5+7XqaQ==
X-Received: by 2002:a17:902:d4cc:b0:1fa:2099:5c08 with SMTP id d9443c01a7336-1fa23ed4413mr105316735ad.26.1719388342634;
        Wed, 26 Jun 2024 00:52:22 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:7825:fd0:4f66:6e77:859a:643d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc72e9sm92760015ad.296.2024.06.26.00.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:52:22 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Amit Cohen <amcohen@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux state changed
Date: Wed, 26 Jun 2024 15:51:56 +0800
Message-ID: <20240626075156.2565966-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, administrators need to retrieve LACP mux state changes from
the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
this process, let's send the ifinfo notification whenever the mux state
changes. This will enable users to directly access and monitor this
information using the ip monitor command.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3: forgot to use GFP_ATOMIC. (Nikolay Aleksandrov)
    export symbol for rtmsg_ifinfo. It's weird that my build succeed with
    tools/testing/selftests/drivers/net/bonding/config without export
    the symbol, but build failed with tools/testing/selftests/net/config.
v2: don't use call_netdevice_notifiers as it will case sleeping in atomic
    context (Nikolay Aleksandrov)

After this patch, we can see the following info with `ip -d monitor link`

7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    veth
    bond_slave state BACKUP mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 143 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,expired> ad_partner_oper_port_state 55 ad_partner_oper_port_state_str <active,short_timeout,aggregating,collecting,distributing> ...
7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    veth
    bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 79 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,defaulted> ad_partner_oper_port_state 1 ad_partner_oper_port_state_str <active> ...
7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    veth
    bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 63 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state 63 ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ...
---
 drivers/net/bonding/bond_3ad.c | 3 +++
 net/core/rtnetlink.c           | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..b57c5670b31a 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -11,6 +11,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if_bonding.h>
 #include <linux/pkt_sched.h>
+#include <linux/rtnetlink.h>
 #include <net/net_namespace.h>
 #include <net/bonding.h>
 #include <net/bond_3ad.h>
@@ -1185,6 +1186,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 		default:
 			break;
 		}
+
+		rtmsg_ifinfo(RTM_NEWLINK, port->slave->dev, 0, GFP_ATOMIC, 0, NULL);
 	}
 }
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index eabfc8290f5e..4507bb8d5264 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4116,6 +4116,7 @@ void rtmsg_ifinfo(int type, struct net_device *dev, unsigned int change,
 	rtmsg_ifinfo_event(type, dev, change, rtnl_get_event(0), flags,
 			   NULL, 0, portid, nlh);
 }
+EXPORT_SYMBOL(rtmsg_ifinfo);
 
 void rtmsg_ifinfo_newnet(int type, struct net_device *dev, unsigned int change,
 			 gfp_t flags, int *new_nsid, int new_ifindex)
-- 
2.45.0


