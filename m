Return-Path: <netdev+bounces-12484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AB7737B02
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 08:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEFF28149F
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 06:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D5882A;
	Wed, 21 Jun 2023 06:09:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C312593
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:09:43 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B531728
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 23:09:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37DFF218F3;
	Wed, 21 Jun 2023 06:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687327781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZvXMWBa2bU8sXnxYwsv0mnYtatClMz2EqHHJ2F+ogw=;
	b=dDieefXhTmoXlmJJw2VzHMyjHuts3AK69z6Oyn0pHFqWlgOAzKIP+hON+cxOAjo9rvjQxb
	0K/GvlNI4e3YuUI6RTrZLn5HJVkKDQCbQyt4+U/QkYwX+V5Z5swKOAHJjQFjZ/tRjpJmE8
	qwtw/kBAoGIgu9wI3ZPQ5+NSTUjBoSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687327781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZvXMWBa2bU8sXnxYwsv0mnYtatClMz2EqHHJ2F+ogw=;
	b=u2YY23+Y0HauK6Kq7q56Y+Hdy51TSCGapAKQr3p/rklMDNyzn1oBrK6acdgIecVbS9vsO5
	kiEaYoHcAjXVBYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07891134B1;
	Wed, 21 Jun 2023 06:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /dezACWUkmTnGAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 21 Jun 2023 06:09:41 +0000
Message-ID: <f63ed759-7a56-bb8a-8712-55d2a0d33e80@suse.de>
Date: Wed, 21 Jun 2023 08:09:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] net/tls: handle MSG_EOR for tls_device TX flow
Content-Language: en-US
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230620102856.56074-1-hare@suse.de>
 <20230620102856.56074-3-hare@suse.de> <ZJHd_2g-3-e8TNQU@hog>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZJHd_2g-3-e8TNQU@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/20/23 19:12, Sabrina Dubroca wrote:
> 2023-06-20, 12:28:54 +0200, Hannes Reinecke wrote:
>> tls_push_data() MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails
>> out on MSG_EOR.
>> But seeing that MSG_EOR is basically the opposite of
>> MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
>> MSG_EOR by treating it as the absence of MSG_MORE.
>> Consequently we should return an error when both are set.
>>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: netdev@vger.kernel.org
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   net/tls/tls_device.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
>> index b82770f68807..ebefd148ecf5 100644
>> --- a/net/tls/tls_device.c
>> +++ b/net/tls/tls_device.c
>> @@ -440,11 +440,6 @@ static int tls_push_data(struct sock *sk,
>>   	int copy, rc = 0;
>>   	long timeo;
>>   
>> -	if (flags &
>> -	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST |
>> -	      MSG_SPLICE_PAGES))
>> -		return -EOPNOTSUPP;
>> -
>>   	if (unlikely(sk->sk_err))
>>   		return -sk->sk_err;
>>   
>> @@ -536,6 +531,10 @@ static int tls_push_data(struct sock *sk,
>>   				more = true;
>>   				break;
>>   			}
>> +			if (flags & MSG_EOR) {
>> +				more = false;
>> +				break;
> 
> Why the break here? We don't want to close and push the record in that
> case? (the "if (done || ...)" block just below)
> 
Ah, yes, you are correct. Will be fixing it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


