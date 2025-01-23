Return-Path: <netdev+bounces-160501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C24AA19F8E
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD403A1233
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 08:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80AB20B21F;
	Thu, 23 Jan 2025 08:08:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337F26AF5;
	Thu, 23 Jan 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737619694; cv=none; b=NIvdncbrQ5e1X5K3Ii94OEBfUibA46sjQZPONrQ5IYCtd7Ul8ztPiKhp8feJad9tvH+Rh2oThkCyPnkAeusaebXhohTSsHoSneJavjySTXrFCrfPpv5YBV+2TH5NKglHrVhJz+d+MP0f4X5WGjq3YsRaf/rb8W8oSMiVAnr/LtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737619694; c=relaxed/simple;
	bh=6eUXLLsO5+YBK05pnwwwcSNSgNcQr52XvtTm4+at4Y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cv/lxbWEGCaEoTgvvzqljuHmVZJK1NgWapCz3ytM67NCz/O/jp9vJtrZDToKQZO7gDiJ9CAOd2d1uxb6TBQP9RqR7LPEukEO92pmz+PNXrQw9Fta8fwR/jmje6dUpngwa3O/Pre8HOpPyfnGENoRumlSX8r313aMa7njQot0Ubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ydtmn6QVRz6J7pc;
	Thu, 23 Jan 2025 16:06:01 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id AD34D140519;
	Thu, 23 Jan 2025 16:07:58 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 09:07:46 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: <przemyslaw.kitszel@intel.com>
CC: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <gur.stavi@huawei.com>, <helgaas@kernel.org>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v04 1/1] hinic3: module initialization and tx/rx logic
Date: Thu, 23 Jan 2025 10:20:16 +0200
Message-ID: <20250123082016.3985519-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <566b3d82-5e66-4e97-9808-a0e8e212fe67@intel.com>
References: <566b3d82-5e66-4e97-9808-a0e8e212fe67@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500005.china.huawei.com (7.182.85.13)

>>>> Auxiliary driver registration.
>>>> Net device_ops registration but open/stop are empty stubs.
>>>> tx/rx logic.
>>>
>>> Take care for spelling: Tx/Rx; HW (just below).
>>
>> Please elaborate. Spelling of what?
>
>In all code comments and commit messages the acronyms and abbreviations
>have their proper spelling, like "Tx", "Rx", "HW', "SW", "ID".
>
>of course lowercase names are still allowed for variables/fields
>

Grepped drivers/net/ethernet (whole word only):

hw 34681   HW 3708   Hw  170
sw  1198   SW  675   Sw    3
rx  5913   RX 4042   Rx 4042
tx  5424   TX 4095   Tx 4907
id  5545   ID 1967   Id   56

I don't know a quick way to separate variables from comments but I
believe that there are very few hw and sw variables and most tx, rx
related variables will have some prefix or suffix so lots of the
whole-word-only come from comments.
Can we agree that while Hw, Sw and Id are improper, the remaining
forms are acceptable?

>>
>>>
>>>>
>>>> All major data structures of the driver are fully introduced with the
>>>> code that uses them but without their initialization code that requires
>>>> management interface with the hw.

