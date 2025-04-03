Return-Path: <netdev+bounces-178955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F362BA799D3
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 918037A51AC
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4300A145B3E;
	Thu,  3 Apr 2025 01:58:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311D1EB5B
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743645536; cv=none; b=hgQTKNUHTdAGXeTRyFBDBVLihuuNaH+RuiVBKg3KXKpCiX1KdHrhubEYxRp7bJYZ6myEw1W9Hn+sJe/J/48OLYM8DL+O5inL04FgMdYJr7Hw0WpwpbzYW/blUN+aKQh2qtRA1m0kgWEEY580vgtbtTCwXSTGGyqOWkG//pw+VN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743645536; c=relaxed/simple;
	bh=VZAGSjLTL5m5ca/j6p4TFu2DeSlZPyML4ErusQGAHIA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qfk3LqsCcNwVlnDykEHSoRdxHE1fuNaIv8ckRFlM/bXM9cCawdosBV+0vXyi9MKN9sDNZIFEOb8PeKB9IjzsYsOvmPr2c7JVo4In82IIjwVhwmdTlaOfJgmKaZvh751ZBciU7SlLgkipmYgRtpTk9k+8pjRw9sYbDdPmNHehfjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZSlDS3lwrzWfml;
	Thu,  3 Apr 2025 09:55:04 +0800 (CST)
Received: from kwepemg200004.china.huawei.com (unknown [7.202.181.31])
	by mail.maildlp.com (Postfix) with ESMTPS id D11CC1400CF;
	Thu,  3 Apr 2025 09:58:46 +0800 (CST)
Received: from kwepemg200004.china.huawei.com (7.202.181.31) by
 kwepemg200004.china.huawei.com (7.202.181.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 09:58:46 +0800
Received: from kwepemg200004.china.huawei.com ([7.202.181.31]) by
 kwepemg200004.china.huawei.com ([7.202.181.31]) with mapi id 15.02.1544.011;
 Thu, 3 Apr 2025 09:58:46 +0800
From: hanhuihui <hanhuihui5@huawei.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: VRF Routing Rule Matching Issue: oif Rules Not Working After Commit
 40867d74c374
Thread-Topic: VRF Routing Rule Matching Issue: oif Rules Not Working After
 Commit 40867d74c374
Thread-Index: AdukO8eHPEarsgm2SRa861lzHvi4rQ==
Date: Thu, 3 Apr 2025 01:58:46 +0000
Message-ID: <ec671c4f821a4d63904d0da15d604b75@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Dear Kernel Community and Network Maintainers,
I am analyzing the issue, and I am very happy for any replies.
After the application committed 40867d74c374 ("net: Add l3mdev index to flo=
w struct and avoid oif reset for port devices"), we noticed an unexpected c=
hange in VRF routing rule matching behavior. We hereby submit a problem rep=
ort to confirm whether this is the expected behavior.

Problem Description:
When interfaces bound to multiple VRFs share the same IP address, the OIF (=
output interface) routing rule is no longer matched after being committed. =
As a result, traffic incorrectly matches the low-priority rule.
Here are our configuration steps:
ip address add 11.47.3.130/16 dev enp4s0
ip address add 11.47.3.130/16 dev enp5s0

ip link add name vrf-srv-1 type vrf table 10
ip link set dev vrf-srv-1 up
ip link set dev enp4s0 master vrf-srv-1

ip link add name vrf-srv type vrf table 20
ip link set dev vrf-srv up
ip link set dev enp5s0 master vrf-srv

ip rule add from 11.47.3.130 oif vrf-srv-1 table 10 prio 0
ip rule add from 11.47.3.130 iif vrf-srv-1 table 10 prio 0
ip rule add from 11.47.3.130 table 20 prio 997


In this configuration, when the following commands are executed:
ip vrf exec vrf-srv-1 ping "11.47.9.250" -I 11.47.3.130
Expected behavior: The traffic should match the oif vrf-srv-1 rule of prio =
0. Table 10 is used.
Actual behavior: The traffic skips the oif rule and matches the default rul=
e of prio 997 (Table 20), causing the ping to fail.

Is this the expected behavior?
The submission description mentions "avoid oif reset of port devices". Does=
 this change the matching logic of oif in VRF scenarios?
If this change is intentional, how should the VRF configuration be adjusted=
 to ensure that oif rules are matched first? Is it necessary to introduce a=
 new mechanism?

