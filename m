Return-Path: <netdev+bounces-19737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F875BE32
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 08:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DCE281DBF
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 06:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C34DA53;
	Fri, 21 Jul 2023 06:04:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B73D9F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:04:10 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4753C17
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 23:03:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3BC1206EC;
	Fri, 21 Jul 2023 06:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689919408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPBQuRzNxQw18t9j+rYQduOBhkqtLoro+aysNop9G+I=;
	b=OyK0x8dD0Le9yHUzL5KpsVi50NeXgm58G/WnxaPWLIgjOP16FLkmkiNT06IPYkcQhf+jl3
	POm8WOp2pXD79yhiliFwoXX/7jt0sjwe3O3F+rAGwswUusWxBhN+uJPGJ9olYD//A/hSEn
	00e3O2FR54QKQdzO5SctGCkGX0Wfilo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689919408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPBQuRzNxQw18t9j+rYQduOBhkqtLoro+aysNop9G+I=;
	b=+BmOmsWv6NDklO/L72/NX4lOWMztuiZZhmno/x+yVkrdfZMUetNUy4JnedLXJhGoK2RGcI
	o9NFACVqJjB6ChAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC84E134BA;
	Fri, 21 Jul 2023 06:03:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id w7woLa8fumRgDAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Jul 2023 06:03:27 +0000
Message-ID: <985419bf-adfa-15fa-056d-743e18149257@suse.de>
Date: Fri, 21 Jul 2023 08:03:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/6] net/tls: implement ->read_sock()
To: Simon Horman <simon.horman@corigine.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230719113836.68859-1-hare@suse.de>
 <20230719113836.68859-7-hare@suse.de> <ZLl9wUxKrZpgHMxY@corigine.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZLl9wUxKrZpgHMxY@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/20/23 20:32, Simon Horman wrote:
> On Wed, Jul 19, 2023 at 01:38:36PM +0200, Hannes Reinecke wrote:
> 
> ...
> 
> Hi Hannes,
> 
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index d0636ea13009..4829d2cb9a7c 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -2202,6 +2202,102 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>>   	goto splice_read_end;
>>   }
>>   
>> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>> +		     sk_read_actor_t read_actor)
>> +{
>> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
>> +	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
>> +	struct strp_msg *rxm = NULL;
>> +	struct tls_msg *tlm;
>> +	struct sk_buff *skb;
>> +	struct sk_psock *psock;
>> +	ssize_t copied = 0;
>> +	bool bpf_strp_enabled;
>> +	int err, used;
>> +
>> +	psock = sk_psock_get(sk);
>> +	err = tls_rx_reader_acquire(sk, ctx, true);
>> +	if (err < 0)
>> +		goto psock_put;
> 
> skb is uninitialised here,
> however, it is used in the psock_put unwind path.
> 
> Flagged by gcc-12 [-Wmaybe-uninitialized] and Smatch.
> 
Will fix it up in the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


