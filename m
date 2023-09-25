Return-Path: <netdev+bounces-36160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67557ADD06
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 18:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A95671C2080C
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5626421A1A;
	Mon, 25 Sep 2023 16:27:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FB21115
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 16:26:58 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B48EE
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 09:26:54 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id koQ6q3Yk8DuGykoQ6q06qm; Mon, 25 Sep 2023 18:26:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1695659211;
	bh=bqF3lbG0kh1bVAZBrRIplUrNJ8DhjKKRSQSx2fty2V0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OkHLq97M1aXHkJYZD8y4nPXi5uJJJzBTnQTJHMkVqdde8rtX3Eje3PNapDsW9TQ/a
	 6uYvQQsmyKopFlG87IIc28UPfubipI7y0mSEKZIv1N8X6GlpuT+6fVQUUHSKWbGVVv
	 4A7bNtXHeejeiXGvFUQICEsw0egoUTZA4/0nWMJcgWqrkaBFLplSwg/vHHQL3Kkyqx
	 ZY2gisEycvYzR1TUerI928arUdUUhy8YU3cGnrZq8wh+SKPuEUcDfS4R3yy/o3ji7U
	 ScU7TnjYanEelaovZjtUA2fltxxLiLSRylCHUeA9NDlz9i5kEfe0LaSZXI2sVjwFMd
	 9JUn79JwI4Nag==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 25 Sep 2023 18:26:51 +0200
X-ME-IP: 86.243.2.178
Message-ID: <f705117e-41dd-cb2f-ed06-6c47876fd6a2@wanadoo.fr>
Date: Mon, 25 Sep 2023 18:26:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next] udp_tunnel: Use flex array to simplify code
Content-Language: fr, en-CA
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org
References: <4a096ba9cf981a588aa87235bb91e933ee162b3d.1695542544.git.christophe.jaillet@wanadoo.fr>
 <65105d3a8e70e_12c73e29410@willemb.c.googlers.com.notmuch>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <65105d3a8e70e_12c73e29410@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 24/09/2023 à 18:00, Willem de Bruijn a écrit :
> Christophe JAILLET wrote:
>> 'n_tables' is small, UDP_TUNNEL_NIC_MAX_TABLES	= 4 as a maximum. So there
>> is no real point to allocate the 'entries' pointers array with a dedicate
>> memory allocation.
>>
>> Using a flexible array for struct udp_tunnel_nic->entries avoids the
>> overhead of an additional memory allocation.
>>
>> This also saves an indirection when the array is accessed.
>>
>> Finally, __counted_by() can be used for run-time bounds checking if
>> configured and supported by the compiler.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   net/ipv4/udp_tunnel_nic.c | 11 ++---------
>>   1 file changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
>> index 029219749785..b6d2d16189c0 100644
>> --- a/net/ipv4/udp_tunnel_nic.c
>> +++ b/net/ipv4/udp_tunnel_nic.c
>> @@ -47,7 +47,7 @@ struct udp_tunnel_nic {
>>   
>>   	unsigned int n_tables;
>>   	unsigned long missed;
>> -	struct udp_tunnel_nic_table_entry **entries;
>> +	struct udp_tunnel_nic_table_entry *entries[] __counted_by(n_tables);
>>   };
>>   
>>   /* We ensure all work structs are done using driver state, but not the code.
>> @@ -725,16 +725,12 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info *info,
>>   	struct udp_tunnel_nic *utn;
>>   	unsigned int i;
>>   
>> -	utn = kzalloc(sizeof(*utn), GFP_KERNEL);
>> +	utn = kzalloc(struct_size(utn, entries, n_tables), GFP_KERNEL);
>>   	if (!utn)
>>   		return NULL;
>>   	utn->n_tables = n_tables;
> 
> Should utn->n_tables be initialized before first use of
> struct_size(utn, entries, n_tables)?
> 

It can't be.
struct_size() is used to compute the memory size to allocate.

Before the kzalloc() call, utn does not exist, so we can't write 
anything to utn->n_tables. It is undefined at this point.

It is initialized the line just after, after the allocation, but before 
any use.


CJ

