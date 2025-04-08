Return-Path: <netdev+bounces-180374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D292A81224
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D43443319
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D3222B8C4;
	Tue,  8 Apr 2025 16:18:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1622AE59
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129095; cv=none; b=nY3lkAoHYKqInh6HPqOQSA+DB5CEOVRVHdgk80rZ+PYDlpqggtruhnvGsB6wKtT+LSltapxp12jbmCF6d2E6bIutEy7H6x/3YSQnmfgKrpQcmzgIx1f7+OmMT1X2Pi+MQB/EUN5y0rI9FREA8/1siBeHkYyXfRIwVgNBOwJWU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129095; c=relaxed/simple;
	bh=FIpn+oZo2PJgyV37DjMwb1/ODNQXaxwke/SjUr2PmdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGOMkqpopQb5o5q/ZBR4SJKUAX3K1rNJqw/uFJrW0Cq1Rxp24U6nx3vrTShrEfS0wu8xPq7qwVHst/b1owaFHgAUFgiYx8anNDKNrr/qBqmbgWE1kYfqNvH5lyUNiqFHtARODdDIy0aqD6RM4S8Ioo8IP/iyPi2r8y/17M1/lXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZXB2C1YJzz1k1Hn;
	Wed,  9 Apr 2025 00:13:07 +0800 (CST)
Received: from kwepemg200004.china.huawei.com (unknown [7.202.181.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E9061A0190;
	Wed,  9 Apr 2025 00:18:03 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200004.china.huawei.com
 (7.202.181.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 9 Apr
 2025 00:18:02 +0800
From: hanhuihui <hanhuihui5@huawei.com>
To: <idosch@idosch.org>
CC: <dsahern@kernel.org>, <kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: VRF Routing Rule Matching Issue: oif Rules Not Working After Commit 40867d74c374
Date: Wed, 9 Apr 2025 00:17:56 +0800
Message-ID: <20250408161756.422830-1-hanhuihui5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <Z_OMzrUFJawqfYe5@shredder>
References: <Z_OMzrUFJawqfYe5@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200004.china.huawei.com (7.202.181.31)

On Mon, 7 Apr 2025 11:29:02 +0300, Ido Schimmel wrote:
>On Thu, Apr 03, 2025 at 01:58:46AM +0000, hanhuihui wrote:
>> Dear Kernel Community and Network Maintainers,
>> I am analyzing the issue, and I am very happy for any replies.
>> After the application committed 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices"), we noticed an unexpected change in VRF routing rule matching behavior. We hereby submit a problem report to confirm whether this is the expected behavior.
>> 
>> Problem Description:
>> When interfaces bound to multiple VRFs share the same IP address, the OIF (output interface) routing rule is no longer matched after being committed. As a result, traffic incorrectly matches the low-priority rule.
>> Here are our configuration steps:
>> ip address add 11.47.3.130/16 dev enp4s0
>> ip address add 11.47.3.130/16 dev enp5s0
>> 
>> ip link add name vrf-srv-1 type vrf table 10
>> ip link set dev vrf-srv-1 up
>> ip link set dev enp4s0 master vrf-srv-1
>> 
>> ip link add name vrf-srv type vrf table 20
>> ip link set dev vrf-srv up
>> ip link set dev enp5s0 master vrf-srv
>> 
>> ip rule add from 11.47.3.130 oif vrf-srv-1 table 10 prio 0
>> ip rule add from 11.47.3.130 iif vrf-srv-1 table 10 prio 0
>> ip rule add from 11.47.3.130 table 20 prio 997
>> 
>> 
>> In this configuration, when the following commands are executed:
>> ip vrf exec vrf-srv-1 ping "11.47.9.250" -I 11.47.3.130
>> Expected behavior: The traffic should match the oif vrf-srv-1 rule of prio 0. Table 10 is used.
>> Actual behavior: The traffic skips the oif rule and matches the default rule of prio 997 (Table 20), causing the ping to fail.
>> 
>> Is this the expected behavior?
>> The submission description mentions "avoid oif reset of port devices". Does this change the matching logic of oif in VRF scenarios?
>> If this change is intentional, how should the VRF configuration be adjusted to ensure that oif rules are matched first? Is it necessary to introduce a new mechanism?
>
>Can you try replacing the first two rules with:
>
>ip rule add from 11.47.3.130 l3mdev prio 0
>

This does not work in scenarios where the routing table specified by the oif/iif is not in the l3mdev-table.

>And see if it helps?
>
>It's not exactly equivalent to your two rules, but it says "if source
>address is 11.47.3.130 and flow is associated with a L3 master device,
>then direct the FIB lookup to the table associated with the L3 master
>device"
>
>The commit you referenced added the index of the L3 master device to the
>flow structure, but I don't believe we have an explicit way to match on
>it using FIB rules. It would be useful to add a new keyword (e.g.,
>l3mdevif) and then your rules can become:
>
>ip rule add from 11.47.3.130 l3mdevif vrf-srv-1 table 10 prio 0
>ip rule add from 11.47.3.130 table 20 prio 997
>
>But it requires kernel changes.

Before the patch is installed, oif/iif rules can be configured for traffic from the VRF and traffic can be forwarded normally. 
However, in this patch, traffic from the VRF resets fl->flowi_oif in l3mdev_update_flow. As a result, the 'rule->oifindex != fl->flowi_oif' 
condition in fib_rule_match cannot be met, the oif rule cannot be matched. The patch also mentions "oif set to L3mdev directs lookup to its table; 
reset to avoid oif match in fib_lookup" in the modification, which seems to be intentional. I'm rather confused about this. Does the modification 
ignore the scenario where the oif/iif rule is configured on the VRF, or is the usage of the oif/iif rule no longer supported by the community after 
the patch is installed, or is the usage of the oif/iif rule incorrectly used?
Any reply would be greatly appreciated.

Thanks!

