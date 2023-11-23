Return-Path: <netdev+bounces-50342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B28CA7F565F
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 03:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F4FB21081
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D9420FE;
	Thu, 23 Nov 2023 02:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9671D112
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 18:21:18 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VwxeXXK_1700706075;
Received: from 30.221.129.10(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VwxeXXK_1700706075)
          by smtp.aliyun-inc.com;
          Thu, 23 Nov 2023 10:21:16 +0800
Message-ID: <ad29f704-ae79-4c4b-2227-d0fa9a1ceee2@linux.alibaba.com>
Date: Thu, 23 Nov 2023 10:21:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [question] smc: how to enable SMC_LO feature
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 yuehaibing <yuehaibing@huawei.com>, "Libin (Huawei)"
 <huawei.libin@huawei.com>, Dust Li <dust.li@linux.alibaba.com>,
 tonylu_linux <tonylu@linux.alibaba.com>, "D. Wythe"
 <alibuda@linux.alibaba.com>, guwen@linux.alibaba.com
References: <8ac15e20beb54acfae1a35d1603c1827@huawei.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <8ac15e20beb54acfae1a35d1603c1827@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/11/21 20:14, shaozhengchao wrote:
> Hi Wen Gu:
> Currently, I am interested in the SMC_LOOPBACK feature proposed
> by you. Therefore, I use your patchset[1] to test the SMC_LO feature on
> my x86_64 environment and kernel is based on linux-next, commit: 5ba73bec5e7b.
> The test result shows that the smc_lo feature cannot be enabled. Here's
> my analysis:
> 
> 1. Run the following command to perform the test, and then capture
> packets on the lo device.
> - serv:  smc_run taskset -c <cpu> sockperf sr --tcp
> - clnt:  smc_run taskset -c <cpu> sockperf  tp --tcp --msg-size=64000 -i 127.0.0.1 -t 30
> 
> 2. Use Wireshark to open packets. It is found that the VCE port replies with
> SMC-R-Deline packets.
> [cid:image001.png@01DA1CB4.F1052C30]
> 
> 3. Rx
> When smc_listen_work invokes smc_listen_v2_check, the VCE port returns
> a Decline packet because eid_cnt and flag.seid in the received packet are both 0.
> 
> 4. Tx
> In smc_clc_send_proposal,
> v2_ext->hdr.eid_cnt = smc_clc_eid_table.ueid_cnt;
> v2_ext->hdr.flag.seid = smc_clc_eid_table.seid_enabled;
> 
> When smc_clc_init, ueid_cnt=0, and in the x86_64 environment, seid_enabled is
> always equal to 0.
> 
> So, I must call smc_clc_ueid_add function to increase ueid count?
> But I don't see where operations can be added, may I missed something?
> 

Hi Zhengchao Shao,

Yes. When using SMC-D in non-s390 architecture (like x86 here), A common
UEID should be set. It can be set by following steps:

- Install smc-tools[1].

- Run # smcd ueid add <ueid> in loopback test environment.

   EID works as an ID to indicate the max communication space of SMC. When SEID is
   unavailable, an UEID is required.

- Then run the test.

Hope this works for you :)

[1] https://github.com/ibm-s390-linux/smc-tools

Regards,
Wen Gu

> Could you give me some advice? Thanks very much.
> 
> Zhengchao Shao
> 
> 
> [1]link: https://patchwork.kernel.org/project/netdevbpf/cover/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
> 

