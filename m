Return-Path: <netdev+bounces-207352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 434A7B06C5D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 05:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60501AA3F63
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 03:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0770B1FC0EF;
	Wed, 16 Jul 2025 03:39:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051F1F2BAD;
	Wed, 16 Jul 2025 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637193; cv=none; b=LKWH5mLvMxdsucZRw7zyzYbKUct/2hH9/FyL9+fu7nmX8bxhVGr1mPrRQVzb3KAqD6/cqXBJ63WZgTVm0RVgMr5qiUnm6slsxLnBoE09DoHHwls5dTXrwgRchLmcy9ifF+uprBwEesrZzIiphNDjWtzAFVhUfvzKeEkQZiUvGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637193; c=relaxed/simple;
	bh=ht4L0EE8uzKsmnLAJcGoceCLucMT6AcamHdiD/fbMjg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rTub2eKvWn/jQ+ciisCm12qE9H3LSUNokoYKBtNR0OMUtLc33pR6WrxOnp2zhkCXKXK6AU4YCTsWL3qpz/oNOURAfCM9W3GELkdKYSpr68H5V7v7w2hrZvEoERnZ/8VRa9XlSkkD0VyF+46BvwIhIAnJydTz4SvijLhHc33UIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bhhXY4ZypzHrSs;
	Wed, 16 Jul 2025 11:35:41 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id BFCDB1402DB;
	Wed, 16 Jul 2025 11:39:48 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Jul 2025 11:39:48 +0800
Received: from localhost.localdomain (10.175.104.82) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Jul 2025 11:39:47 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <idosch@idosch.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<jiri@resnulli.us>, <oscmaes92@gmail.com>, <linux@treblig.org>,
	<pedro.netdev@dondevamos.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>
Subject: [PATCH net v3 0/2] net: vlan: fix VLAN 0 refcount imbalance of toggling filtering during runtime
Date: Wed, 16 Jul 2025 11:45:02 +0800
Message-ID: <20250716034504.2285203-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200002.china.huawei.com (7.202.195.90)

Fix VLAN 0 refcount imbalance of toggling filtering during runtime.

v2:
	Add auto_vid0 flag to track the refcount of vlan0 
	Add selftest case for vlan_filter

v3:
	Add Suggested-by signature
	Modify commit message description

Dong Chenchen (2):
  net: vlan: fix VLAN 0 refcount imbalance of toggling filtering during
    runtime
  selftests: Add test cases for vlan_filter modification during runtime

 net/8021q/vlan.c                              | 42 ++++++--
 net/8021q/vlan.h                              |  1 +
 tools/testing/selftests/net/vlan_hw_filter.sh | 98 ++++++++++++++++---
 3 files changed, 120 insertions(+), 21 deletions(-)

-- 
2.25.1


