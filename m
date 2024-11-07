Return-Path: <netdev+bounces-142912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B999C0AFE
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CCD1C20B75
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A7A218584;
	Thu,  7 Nov 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GyswEzpa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B6215F58;
	Thu,  7 Nov 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995784; cv=none; b=K7kXFta5iYaY9MnLSSFs7KT0jGud53dWKsi/eAUsZMfT3b3pVu4k0FbMpmiQ3Zw4vqBXPhZfXjbbRwUdD2iLMTiV7EcBwo6OIP8t0t8Mi9nP/3VUd8lDDGyioiGRwnEQCwihw/PSPywwJ848Md6rMwSEjHy50Z9A2QHFu7XkAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995784; c=relaxed/simple;
	bh=mVcg5Zlmse1S5SWLaXb3eWkRBh4cqZa0Xc/8eY8VLzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8TaKXjOqu4x3tvrdWwuAqdZIoIJQm3NaPTnXhYLthyFe5P+GDpGUm/dKaiuqoGk/wXRjsGE/x/JsvICY3ngGnaLe+/eN0TpdpiZxteS2LDjkMclHeT9tC9TQghLa5dOQC+ob5c9Ccmm5HJxVxogFWupBX2cZHbk/4ipXqtqsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GyswEzpa; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DfH1j009809;
	Thu, 7 Nov 2024 08:09:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=yVp1qu6FAe8bUfCe0RbPkjfyV
	LJGl8wEv7NgzvQxUfo=; b=GyswEzpaBiGhVItE9bzIbgMCr7izK879dZkE85y+p
	R+3uwv/YAHCsaZzX+SZK47Zx6Nr2fcaq+caTASr8sRnh64owHZ9EjKeHVudSAkGr
	TGBMwb3/1HwAHraASSBU/3Ey5NkmTyxWmPnwfdpEomqFgqDOxvOiLkGKHtjDtz0b
	GP3NatJNW81LpGCOzYac5o5SjiNrDQyKMGwaA6x2tB2df7RN+L58DLS+haiRsX7t
	HSDmG0Nt2X5DaOq2t2tTlHn8UKu7Kxg/77mKEN1CbiGdmZSwYoCLOJOz5sDLSiO6
	tr3j/5dN+cB+575lAg3GatNqHNoIYcehI/CBPr1W9WoeA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42rxn5gcdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:09:33 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 08:09:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 08:09:32 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 67E433F7050;
	Thu,  7 Nov 2024 08:09:28 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v12 12/12] Documentation: octeontx2: Add Documentation for RVU representors
Date: Thu, 7 Nov 2024 21:38:39 +0530
Message-ID: <20241107160839.23707-13-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241107160839.23707-1-gakula@marvell.com>
References: <20241107160839.23707-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: MhKRTfan-QLMpAFyvNjnbsIZmxD7unIy
X-Proofpoint-ORIG-GUID: MhKRTfan-QLMpAFyvNjnbsIZmxD7unIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Adds documentation for creating and configuring rvu port representors

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../ethernet/marvell/octeontx2.rst            | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
index 1e196cb9ce25..af7db0e91f6b 100644
--- a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
@@ -14,6 +14,7 @@ Contents
 - `Basic packet flow`_
 - `Devlink health reporters`_
 - `Quality of service`_
+- `RVU representors`_
 
 Overview
 ========
@@ -340,3 +341,93 @@ Setup HTB offload
         # tc class add dev <interface> parent 1: classid 1:2 htb rate 10Gbit prio 2 quantum 188416
 
         # tc class add dev <interface> parent 1: classid 1:3 htb rate 10Gbit prio 2 quantum 32768
+
+
+RVU Representors
+================
+
+RVU representor driver adds support for creation of representor devices for
+RVU PFs' VFs in the system. Representor devices are created when user enables
+the switchdev mode.
+Switchdev mode can be enabled either before or after setting up SRIOV numVFs.
+All representor devices share a single NIXLF but each has a dedicated Rx/Tx
+queues. RVU PF representor driver registers a separate netdev for each
+Rx/Tx queue pair.
+
+Current HW does not support built-in switch which can do L2 learning and
+forwarding packets between representee and representor. Hence, packet path
+between representee and it's representor is achieved by setting up appropriate
+NPC MCAM filters.
+Transmit packets matching these filters will be loopbacked through hardware
+loopback channel/interface (i.e, instead of sending them out of MAC interface).
+Which will again match the installed filters and will be forwarded.
+This way representee => representor and representor => representee packet
+path is achieved. These rules get installed when representors are created
+and gets active/deactivate based on the representor/representee interface state.
+
+Usage example:
+
+ - Change device to switchdev mode::
+
+	# devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
+
+ - List of representor devices on the system::
+
+	# ip link show
+	Rpf1vf0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000 link/ether f6:43:83:ee:26:21 brd ff:ff:ff:ff:ff:ff
+	Rpf1vf1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000 link/ether 12:b2:54:0e:24:54 brd ff:ff:ff:ff:ff:ff
+	Rpf1vf2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000 link/ether 4a:12:c4:4c:32:62 brd ff:ff:ff:ff:ff:ff
+	Rpf1vf3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000 link/ether ca:cb:68:0e:e2:6e brd ff:ff:ff:ff:ff:ff
+	Rpf2vf0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000 link/ether 06:cc:ad:b4:f0:93 brd ff:ff:ff:ff:ff:ff
+
+
+To delete the representors devices from the system. Change the device to legacy mode.
+
+ - Change device to legacy mode::
+
+	# devlink dev eswitch set pci/0002:1c:00.0 mode legacy
+
+RVU representors can be managed using devlink ports
+(see :ref:`Documentation/networking/devlink/devlink-port.rst <devlink_port>`) interface.
+
+ - Show devlink ports of representors::
+
+	# devlink port
+	pci/0002:1c:00.0/0: type eth netdev Rpf1vf0 flavour physical port 0 splittable false
+	pci/0002:1c:00.0/1: type eth netdev Rpf1vf1 flavour pcivf controller 0 pfnum 1 vfnum 1 external false splittable false
+	pci/0002:1c:00.0/2: type eth netdev Rpf1vf2 flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
+	pci/0002:1c:00.0/3: type eth netdev Rpf1vf3 flavour pcivf controller 0 pfnum 1 vfnum 3 external false splittable false
+
+Function attributes
+===================
+
+The RVU representor support function attributes for representors.
+Port function configuration of the representors are supported through devlink eswitch port.
+
+MAC address setup
+-----------------
+
+RVU representor driver support devlink port function attr mechanism to setup MAC
+address. (refer to Documentation/networking/devlink/devlink-port.rst)
+
+ - To setup MAC address for port 2::
+
+	# devlink port function set pci/0002:1c:00.0/2 hw_addr 5c:a1:1b:5e:43:11
+	# devlink port show pci/0002:1c:00.0/2
+	pci/0002:1c:00.0/2: type eth netdev Rpf1vf2 flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
+	function:
+		hw_addr 5c:a1:1b:5e:43:11
+
+
+TC offload
+==========
+
+The rvu representor driver implements support for offloading tc rules using port representors.
+
+ - Drop packets with vlan id 3::
+
+	# tc filter add dev Rpf1vf0 protocol 802.1Q parent ffff: flower vlan_id 3 vlan_ethtype ipv4 skip_sw action drop
+
+ - Redirect packets with vlan id 5 and IPv4 packets to eth1, after stripping vlan header.::
+
+	# tc filter add dev Rpf1vf0 ingress protocol 802.1Q flower vlan_id 5 vlan_ethtype ipv4 skip_sw action vlan pop action mirred ingress redirect dev eth1
-- 
2.25.1


