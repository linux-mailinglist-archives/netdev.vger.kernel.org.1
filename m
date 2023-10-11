Return-Path: <netdev+bounces-40027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E607C5749
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF51C281F69
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C769A15487;
	Wed, 11 Oct 2023 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301C211A
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:48:25 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266DF90;
	Wed, 11 Oct 2023 07:48:19 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VtxFJ45_1697035696;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VtxFJ45_1697035696)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 22:48:17 +0800
Date: Wed, 11 Oct 2023 22:48:16 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
	Albert Huang <huangjie.albert@bytedance.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
Message-ID: <20231011144816.GO92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <00bbbf48440c1889ecd16a590ebb746b820a4f48.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00bbbf48440c1889ecd16a590ebb746b820a4f48.camel@linux.ibm.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 05:04:21PM +0200, Niklas Schnelle wrote:
>On Mon, 2023-09-25 at 10:35 +0800, Albert Huang wrote:
>> If the netdevice is within a container and communicates externally
>> through network technologies like VXLAN, we won't be able to find
>> routing information in the init_net namespace. To address this issue,
>> we need to add a struct net parameter to the smc_ib_find_route function.
>> This allow us to locate the routing information within the corresponding
>> net namespace, ensuring the correct completion of the SMC CLC interaction.
>> 
>> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
>> ---
>>  net/smc/af_smc.c | 3 ++-
>>  net/smc/smc_ib.c | 7 ++++---
>>  net/smc/smc_ib.h | 2 +-
>>  3 files changed, 7 insertions(+), 5 deletions(-)
>> 
>
>I'm trying to test this patch on s390x but I'm running into the same
>issue I ran into with the original SMC namespace
>support:https://lore.kernel.org/netdev/8701fa4557026983a9ec687cfdd7ac5b3b85fd39.camel@linux.ibm.com/
>
>Just like back then I'm using a server and a client network namespace
>on the same system with two ConnectX-4 VFs from the same card and port.
>Both TCP/IP traffic as well as user-space RDMA via "qperf … rc_bw" and
>`qperf … rc_lat` work between namespaces and definitely go via the
>card.
>
>I did use "rdma system set netns exclusive" then moved the RDMA devices
>into the namespaces with "rdma dev set <rdma_dev> netns <namespace>". I
>also verified with "ip netns exec <namespace> rdma dev"
>that the RDMA devices are in the network namespace and as seen by the
>qperf runs normal RDMA does work.
>
>For reference the smc_chck tool gives me the following output:
>
>Server started on port 37373
>[DEBUG] Interfaces to check: eno4378
>Test with target IP 10.10.93.12 and port 37373
>  Live test (SMC-D and SMC-R)
>[DEBUG] Running client: smc_run /tmp/echo-clt.x0q8iO 10.10.93.12 -p
>37373
>[DEBUG] Client result: TCP 0x05000000/0x03030000
>     Failed  (TCP fallback), reasons:
>          Client:        0x05000000   Peer declined during handshake
>          Server:        0x03030000   No SMC devices found (R and D)
>
>I also checked that SMC is generally working, once I add an ISM device
>I do get SMC-D between the namespaces. Any ideas what could break SMC-R
>here?

I missed the email :(

Are you running SMC-Rv2 or v1 ?

Best regards,
Dust


>
>Thanks,
>Niklas

