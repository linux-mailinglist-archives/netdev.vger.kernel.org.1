Return-Path: <netdev+bounces-100114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E638D7E7B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D837B20D7D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A3E7E777;
	Mon,  3 Jun 2024 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PdLafWwM"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E90E757E0;
	Mon,  3 Jun 2024 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406859; cv=none; b=kqnnh95iyNoDPmxe0WLbxAG4TYbBQt5wn1WJq9cxWKYI3uXZCAgs0VYUvRyOYKODOu72WSP7+ERNyZbuoYvD6dCSf3+CsKKZpioxdvguT8+RpvAYIgPQvhdmqsO0zRcI0z14g/ntryWyHoV9uoUNlgPOfwqMxuIfYP70JPE+Nuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406859; c=relaxed/simple;
	bh=x9ikFYNncfJUkrFfp9JJ8ryQsRSyVgqBkaGtU/Z/r4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=otrmccm3c8Kw+kqCXZpcS36j152enVasl3uy6nm2Dgz6vnFU5giHFFQheFfW5wR9LeNHHaN5tk6FPIzubCEo/+NtXl7UYGFwlCY7sHG4dqzHxbsclQQcZ4DI+t6FfgQHyUfQQmwVV+aQukqqsy1uM36BXvPmrxkjfZGCRKZ72so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PdLafWwM; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4539R1xf081601;
	Mon, 3 Jun 2024 04:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717406821;
	bh=SB5jmnTW30z7D427AIs51/dYcHrGUq+FjEIld/CWbLY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PdLafWwMwv4a4/btdJOZNlxq40sxLkDWcVu8S6JJci8GPFuqmKiNi1Zi9ycjoEiy9
	 KaqJotzBQ8VgW3hK52PLTDCu2zBJ60yxLZzxQfCdz7/5SBaTFBE/5EA9TffFE17Ge4
	 V8U+2IqNS9TwWaCtaYPGjaxijP8HeoCoOkm6czLM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4539R1ec110664
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 04:27:01 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 04:27:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 04:27:00 -0500
Received: from [172.24.227.57] (linux-team-01.dhcp.ti.com [172.24.227.57])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4539Qsjq056761;
	Mon, 3 Jun 2024 04:26:55 -0500
Message-ID: <c1380aa4-d8ae-4e77-88a8-59555dffdd57@ti.com>
Date: Mon, 3 Jun 2024 14:56:53 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg
 driver as network device
To: kernel test robot <lkp@intel.com>, <schnelle@linux.ibm.com>,
        <wsa+renesas@sang-engineering.com>, <diogo.ivo@siemens.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>, <vigneshr@ti.com>,
        <rogerq@ti.com>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <rogerq@kernel.org>, <s-vadapalli@ti.com>, <y-mallik@ti.com>
References: <20240531064006.1223417-3-y-mallik@ti.com>
 <202406011038.AwLZhQpy-lkp@intel.com>
Content-Language: en-US
From: Yojana Mallik <y-mallik@ti.com>
In-Reply-To: <202406011038.AwLZhQpy-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 6/1/24 08:43, kernel test robot wrote:
> Hi Yojana,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yojana-Mallik/net-ethernet-ti-RPMsg-based-shared-memory-ethernet-driver/20240531-144258
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240531064006.1223417-3-y-mallik%40ti.com
> patch subject: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg driver as network device
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240601/202406011038.AwLZhQpy-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406011038.AwLZhQpy-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406011038.AwLZhQpy-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/net/ethernet/ti/inter_core_virt_eth.c:76:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>       76 |         if (wait) {
>          |             ^~~~
>    drivers/net/ethernet/ti/inter_core_virt_eth.c:87:9: note: uninitialized use occurs here
>       87 |         return ret;
>          |                ^~~
>    drivers/net/ethernet/ti/inter_core_virt_eth.c:76:2: note: remove the 'if' if its condition is always true
>       76 |         if (wait) {
>          |         ^~~~~~~~~
>    drivers/net/ethernet/ti/inter_core_virt_eth.c:65:9: note: initialize the variable 'ret' to silence this warning
>       65 |         int ret;
>          |                ^
>          |                 = 0
>    drivers/net/ethernet/ti/inter_core_virt_eth.c:330:24: error: use of undeclared identifier 'icve_del_mc_addr'
>      330 |         __dev_mc_unsync(ndev, icve_del_mc_addr);
>          |                               ^
>    drivers/net/ethernet/ti/inter_core_virt_eth.c:331:26: error: no member named 'mc_list' in 'struct icve_common'
>      331 |         __hw_addr_init(&common->mc_list);
>          |                         ~~~~~~  ^
>    drivers/net/ethernet/ti/inter_core_virt_eth.c:337:28: error: no member named 'rx_mode_work' in 'struct icve_common'
>      337 |         cancel_work_sync(&common->rx_mode_work);
>          |                           ~~~~~~  ^
>    1 warning and 3 errors generated.
> 
> 
> vim +76 drivers/net/ethernet/ti/inter_core_virt_eth.c
> 
>     59	
>     60	static int icve_create_send_request(struct icve_common *common,
>     61					    enum icve_rpmsg_type rpmsg_type,
>     62					    bool wait)
>     63	{
>     64		unsigned long flags;
>     65		int ret;
>     66	
>     67		if (wait)
>     68			reinit_completion(&common->sync_msg);
>     69	
>     70		spin_lock_irqsave(&common->send_msg_lock, flags);
>     71		create_request(common, rpmsg_type);
>     72		rpmsg_send(common->rpdev->ept, (void *)(&common->send_msg),
>     73			   sizeof(common->send_msg));
>     74		spin_unlock_irqrestore(&common->send_msg_lock, flags);
>     75	
>   > 76		if (wait) {
>     77			ret = wait_for_completion_timeout(&common->sync_msg,
>     78							  ICVE_REQ_TIMEOUT);
>     79	
>     80			if (!ret) {
>     81				dev_err(common->dev, "Failed to receive response within %ld jiffies\n",
>     82					ICVE_REQ_TIMEOUT);
>     83				ret = -ETIMEDOUT;
>     84				return ret;
>     85			}
>     86		}
>     87		return ret;
>     88	}
>     89	
> 

I will fix all these issues in v3.

Regards,
Yojana Mallik

