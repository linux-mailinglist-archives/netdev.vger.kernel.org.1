Return-Path: <netdev+bounces-18140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2F75590F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 03:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B4E281315
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 01:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE701108;
	Mon, 17 Jul 2023 01:33:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF364A49
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 01:33:50 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 227E8B2;
	Sun, 16 Jul 2023 18:33:47 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id E21B960108C45;
	Mon, 17 Jul 2023 09:33:31 +0800 (CST)
Message-ID: <9880bad7-66b5-4d73-7464-8be859d8b56f@nfschina.com>
Date: Mon, 17 Jul 2023 09:33:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next v2 03/10] net: ppp: Remove unnecessary (void*)
 conversions
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, xeb@mail.ru, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: yunchuan <yunchuan@nfschina.com>
In-Reply-To: <ZLEQSivEvfpWXrdr@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/14 17:07, Guillaume Nault wrote:
> On Mon, Jul 10, 2023 at 02:40:27PM +0800, Su Hui wrote:
>> From: wuych <yunchuan@nfschina.com>
>>
>> Pointer variables of void * type do not require type cast.
>>
>> Signed-off-by: wuych <yunchuan@nfschina.com>
>> ---
>>   drivers/net/ppp/pppoe.c | 4 ++--
>>   drivers/net/ppp/pptp.c  | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
> Reviewed-by: Guillaume Nault <gnault@redhat.com>
>
> While there, you might want to also remove the useless casts in
> net/l2tp/l2tp_ppp.c and net/atm/pppoatm.c.

Hi,

Thanks four your reminder! There are about 20 useless casts in net.
I will remove all of them.

Wu Yunchuan

>> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
>> index 3b79c603b936..ba8b6bd8233c 100644
>> --- a/drivers/net/ppp/pppoe.c
>> +++ b/drivers/net/ppp/pppoe.c
>> @@ -968,7 +968,7 @@ static int __pppoe_xmit(struct sock *sk, struct sk_buff *skb)
>>    ***********************************************************************/
>>   static int pppoe_xmit(struct ppp_channel *chan, struct sk_buff *skb)
>>   {
>> -	struct sock *sk = (struct sock *)chan->private;
>> +	struct sock *sk = chan->private;
>>   	return __pppoe_xmit(sk, skb);
>>   }
>>   
>> @@ -976,7 +976,7 @@ static int pppoe_fill_forward_path(struct net_device_path_ctx *ctx,
>>   				   struct net_device_path *path,
>>   				   const struct ppp_channel *chan)
>>   {
>> -	struct sock *sk = (struct sock *)chan->private;
>> +	struct sock *sk = chan->private;
>>   	struct pppox_sock *po = pppox_sk(sk);
>>   	struct net_device *dev = po->pppoe_dev;
>>   
>> diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
>> index 32183f24e63f..6b3d3df99549 100644
>> --- a/drivers/net/ppp/pptp.c
>> +++ b/drivers/net/ppp/pptp.c
>> @@ -148,7 +148,7 @@ static struct rtable *pptp_route_output(struct pppox_sock *po,
>>   
>>   static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
>>   {
>> -	struct sock *sk = (struct sock *) chan->private;
>> +	struct sock *sk = chan->private;
>>   	struct pppox_sock *po = pppox_sk(sk);
>>   	struct net *net = sock_net(sk);
>>   	struct pptp_opt *opt = &po->proto.pptp;
>> @@ -575,7 +575,7 @@ static int pptp_create(struct net *net, struct socket *sock, int kern)
>>   static int pptp_ppp_ioctl(struct ppp_channel *chan, unsigned int cmd,
>>   	unsigned long arg)
>>   {
>> -	struct sock *sk = (struct sock *) chan->private;
>> +	struct sock *sk = chan->private;
>>   	struct pppox_sock *po = pppox_sk(sk);
>>   	struct pptp_opt *opt = &po->proto.pptp;
>>   	void __user *argp = (void __user *)arg;
>> -- 
>> 2.30.2
>>
>>

