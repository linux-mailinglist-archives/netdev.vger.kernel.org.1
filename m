Return-Path: <netdev+bounces-13313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EB773B3DB
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 11:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BD21C20E48
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29983FF9;
	Fri, 23 Jun 2023 09:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F93FE4
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 09:43:16 +0000 (UTC)
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E2E41;
	Fri, 23 Jun 2023 02:43:15 -0700 (PDT)
Received: from [78.40.148.178] (helo=webmail.codethink.co.uk)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1qCdJv-00Dbly-NU; Fri, 23 Jun 2023 10:43:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Jun 2023 10:43:12 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 claudiu.beznea@microchip.com, nicolas.ferre@microchip.com
Subject: Re: [PATCH 3/3] net: macb: fix __be32 warnings in debug code
In-Reply-To: <ZJRsYtU4qPZ0h1xp@corigine.com>
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
 <20230622130507.606713-4-ben.dooks@codethink.co.uk>
 <ZJRsYtU4qPZ0h1xp@corigine.com>
Message-ID: <fbdc3741b28a0174e3058a998e253439@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023-06-22 16:44, Simon Horman wrote:
> On Thu, Jun 22, 2023 at 02:05:07PM +0100, Ben Dooks wrote:
>> The netdev_dbg() calls in gem_add_flow_filter() and 
>> gem_del_flow_filter()
>> call ntohl() on the ipv4 addresses, which will put them into the host 
>> order
>> but not the right type (returns a __be32, not an u32 as would be 
>> expected).
>> 
>> Chaning the htonl() to nthol() should still do the right conversion, 
>> return
>> the correct u32 type and  should not change any functional to remove 
>> the
>> following sparse warnings:
>> 
>> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: incorrect 
>> type in argument 1 (different base types)
>> drivers/net/ethernet/cadence/macb_main.c:3568:9:    expected unsigned 
>> int [usertype] val
>> drivers/net/ethernet/cadence/macb_main.c:3568:9:    got restricted 
>> __be32 [usertype] ip4src
>> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: incorrect 
>> type in argument 1 (different base types)
>> drivers/net/ethernet/cadence/macb_main.c:3568:9:    expected unsigned 
>> int [usertype] val
>> drivers/net/ethernet/cadence/macb_main.c:3568:9:    got restricted 
>> __be32 [usertype] ip4dst
>> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from 
>> restricted __be32
>> d
>> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: incorrect 
>> type in argument 1 (different base types)
>> drivers/net/ethernet/cadence/macb_main.c:3622:25:    expected unsigned 
>> int [usertype] val
>> drivers/net/ethernet/cadence/macb_main.c:3622:25:    got restricted 
>> __be32 [usertype] ip4src
>> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: incorrect 
>> type in argument 1 (different base types)
>> drivers/net/ethernet/cadence/macb_main.c:3622:25:    expected unsigned 
>> int [usertype] val
>> drivers/net/ethernet/cadence/macb_main.c:3622:25:    got restricted 
>> __be32 [usertype] ip4dst
>> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from 
>> restricted __be32
>> drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from 
>> restricted __be32
>> 
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Hi Ben,
> 
> this code-change looks good to me, but I have a few minor nits for your
> consideration.
> 
> 1. Please specify the target tree, in this case net-next, for patch 
> sets
>    for Networking code.
> 
> 	Subject: [PATCH net-next ...] ...

Ah, was using net, but I assume net-next is probably ok

> 2. It might be nicer to write '.../macb_main.c' or similar,
>    rather tha nthe full path, in the patch description.
> 
> 3. checkpatch --codespell says: 'Chaning' -> 'Chaining'

Ok, thank you. I didn't know about that.

Since there's another patch that needs work I'll re-send this early next 
week
with the fixes in.

>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 56e202b74bd7..59a90c2b307f 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -3568,8 +3568,8 @@ static int gem_add_flow_filter(struct net_device 
>> *netdev,
>>  	netdev_dbg(netdev,
>>  			"Adding flow filter 
>> entry,type=%u,queue=%u,loc=%u,src=%08X,dst=%08X,ps=%u,pd=%u\n",
>>  			fs->flow_type, (int)fs->ring_cookie, fs->location,
>> -			htonl(fs->h_u.tcp_ip4_spec.ip4src),
>> -			htonl(fs->h_u.tcp_ip4_spec.ip4dst),
>> +			ntohl(fs->h_u.tcp_ip4_spec.ip4src),
>> +			ntohl(fs->h_u.tcp_ip4_spec.ip4dst),
>>  			be16_to_cpu(fs->h_u.tcp_ip4_spec.psrc),
>>  			be16_to_cpu(fs->h_u.tcp_ip4_spec.pdst));
>> 
>> @@ -3622,8 +3622,8 @@ static int gem_del_flow_filter(struct net_device 
>> *netdev,
>>  			netdev_dbg(netdev,
>>  					"Deleting flow filter 
>> entry,type=%u,queue=%u,loc=%u,src=%08X,dst=%08X,ps=%u,pd=%u\n",
>>  					fs->flow_type, (int)fs->ring_cookie, fs->location,
>> -					htonl(fs->h_u.tcp_ip4_spec.ip4src),
>> -					htonl(fs->h_u.tcp_ip4_spec.ip4dst),
>> +					ntohl(fs->h_u.tcp_ip4_spec.ip4src),
>> +					ntohl(fs->h_u.tcp_ip4_spec.ip4dst),
>>  					be16_to_cpu(fs->h_u.tcp_ip4_spec.psrc),
>>  					be16_to_cpu(fs->h_u.tcp_ip4_spec.pdst));
>> 
>> --
>> 2.40.1
>> 
>> 

