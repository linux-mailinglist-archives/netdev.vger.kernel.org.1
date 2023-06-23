Return-Path: <netdev+bounces-13311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7000873B3CF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 11:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D152819DB
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF1A3D78;
	Fri, 23 Jun 2023 09:40:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0513FDC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 09:40:56 +0000 (UTC)
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4886ADC;
	Fri, 23 Jun 2023 02:40:55 -0700 (PDT)
Received: from [78.40.148.178] (helo=webmail.codethink.co.uk)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1qCdHf-00DbgG-8Z; Fri, 23 Jun 2023 10:40:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Jun 2023 10:40:52 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 claudiu.beznea@microchip.com, nicolas.ferre@microchip.com
Subject: Re: [PATCH 1/3] net: macb: check constant to define and fix __be32
 warnings
In-Reply-To: <ZJRtinvcu2PAf+Cc@corigine.com>
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
 <20230622130507.606713-2-ben.dooks@codethink.co.uk>
 <ZJRtinvcu2PAf+Cc@corigine.com>
Message-ID: <f13928be3aa5b14908104993979df6f7@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023-06-22 16:49, Simon Horman wrote:
> On Thu, Jun 22, 2023 at 02:05:05PM +0100, Ben Dooks wrote:
>> The checks on ipv4 addresses in the filtering code check against
>> a constant of 0xFFFFFFFF, so replace it with MACB_IPV4_MASK and
>> then make sure it is of __be32 type to avoid the following
>> sparse warnigns:
>> 
>> drivers/net/ethernet/cadence/macb_main.c:3448:39: warning: restricted 
>> __be32 degrades to integer
>> drivers/net/ethernet/cadence/macb_main.c:3453:39: warning: restricted 
>> __be32 degrades to integer
>> drivers/net/ethernet/cadence/macb_main.c:3483:20: warning: restricted 
>> __be32 degrades to integer
>> drivers/net/ethernet/cadence/macb_main.c:3497:20: warning: restricted 
>> __be32 degrades to integer
>> 
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index f20ec0d5260b..538d4c7e023b 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -3418,6 +3418,8 @@ static int macb_get_ts_info(struct net_device 
>> *netdev,
>>  	return ethtool_op_get_ts_info(netdev, info);
>>  }
>> 
>> +#define MACB_IPV4_MASK htonl(0xFFFFFFFF)
>> +
> 
> Hi Ben,
> 
> according to a recent thread, it seems that the preferred approach 
> might be
> ~(__le32)0.
> 
> https://lore.kernel.org/netdev/20230522153615.247577-1-minhuadotchen@gmail.com/

Out of interest, should we keep the define then or simply go through 
changing
all the places where change is needed?

-- 
Ben

