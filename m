Return-Path: <netdev+bounces-139055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5078E9AFE2E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8251E1C2129A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6641C1D3181;
	Fri, 25 Oct 2024 09:29:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4921C878E
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848544; cv=none; b=XeMVNjLVyv+dWZu+a+YUFZZIjlQ45B+w8KsdD9sSClHzEiUoKFyg1rJ4kv+kOTakbAU+7BmbOEZubdZd822yHNtvDFJWtOpE2E1h2BkGekyZw0nyQFCCspIpT5xilm09/5RTh2PlDW2XJiW8HL7JfNha/kEcaPgBV8y0DTRQkdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848544; c=relaxed/simple;
	bh=DcmIfM36Q2B1HVmM/46YusJ+QzU1G7a1r2n7/UR7Z9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VCmFb2bwML7H4s7zkEYJROkxKKDTLK6KBuRBZdbREpjEE/5/mGXnYssBVxfLEItMojEgc+mk7euhqSZ1rCY+hIJQuGi6pZ+oQ61k0zdCIXzvH13g/d+1rOP9pSqhb2hEg2dAcNDyDxSEpJZ2hfr7Q3bxlj7jqnzXufZ4btHJBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XZcs107myz20qp9;
	Fri, 25 Oct 2024 17:28:05 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id DB71918001B;
	Fri, 25 Oct 2024 17:28:58 +0800 (CST)
Received: from DESKTOP-8F1OVF5.china.huawei.com (10.136.114.27) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 17:28:58 +0800
From: chengyechun <chengyechun1@huawei.com>
To: <netdev@vger.kernel.org>, <andy@greyhouse.net>
CC: <j.vosburgh@gmail.com>
Subject: [Discuss]Questions about active slave select in bonding 8023ad
Date: Fri, 25 Oct 2024 17:28:55 +0800
Message-ID: <20241025092855.52212-1-chengyechun1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500016.china.huawei.com (7.185.36.197)

Hi all,
Recently，I'm having a problem starting bond. It's an occasional problem.
After the slave and bond are configured, the network fails to be restarted. The failure cause is as follows:
“/etc/sysconfig/network-scripts/ifup-eth[2747129]: Error, some other host () already uses address 1.1.1.39.”
When the network uses arping to check whether an IP address conflict occurs, an error occurs, but the IP address conflict is not caused. this is very strange.
The kernel version 5.10 is used. The bond configuration is as follows:

BONDING_OPTS='mode=4 miimon=100 lacp_rate=fast xmit_hash_policy=layer3+4'
TYPE=Bond
BONDING_MASTER=yes
BOOTPROTO=static
NM_CONTROLLED=no
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=bond0
DEVICE=bond0
ONBOOT=yes
IPADDR=1.1.1.38
NETMASK=255.255.0.0
IPV6ADDR=1:1:1::39/64

The slave configuration is as follows: and I have four similar slaves enp13s0,enp14s0,enp15s0

NAME=enp12s0
DEVICE=enp12s0
BOOTPROTO=none
ONBOOT=yes
USERCTL=no
NM_CONTROLLED=no
MASTER=bond0
SLAVE=yes
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no

After I discovered this problem, I restarted the network multiple times and it always happened once or twice.
After some debugging, it is found that the bond interface does not have an available slave when the arping packet is sent. As a result, the arping packet fails to be sent.
When the problem occurs, the active slave node is switched from enp12s0 to enp13s0. However, the backup of enp13s0 is not changed from 1 to 0 immediately after the switchover is complete. This is a mechanism or bug?

After thinking about it, I have a doubt about the select of active slave. In the ad_agg_selection_test function, if condition 3a is met, that is, if (__agg_has_partner(curr) && !__agg_has_partner(best))，and after the active slave switch is successful, why not enable_port the best slave in ad_agg_selection_logic?







