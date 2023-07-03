Return-Path: <netdev+bounces-15094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C94A3745A12
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0751C20911
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F380C4691;
	Mon,  3 Jul 2023 10:21:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2213524D
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 10:21:35 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FA29B
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 03:21:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D9F6218F4;
	Mon,  3 Jul 2023 10:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688379693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PXiRM0a3dmypsrorncIWVWJXTdEOFXIDi7ZTxVgIG4=;
	b=LojkcgkK68Qv8Yy5Fy+4+fJYiuWyRbK8H74bfbuYW0qRvzVOj8IhkVYkhU8mOD1D6GVjHn
	8Zw3Xif+hqdYtcTOxXXBv53NiOqQt/xRwNIN+B1nU6UXjGrbRqx+7REYDDNqvmL2juuv9p
	2EQq0GMV9xvFEQkjvBSpYAUlA+PXR3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688379693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PXiRM0a3dmypsrorncIWVWJXTdEOFXIDi7ZTxVgIG4=;
	b=MoQU04qAqnrIUvOwxvZ2ArrPDOzcpOltKo4doJg8eiyoxlfUsUKgCLrWp5oL18J6Ab85WH
	ZK0mjM8IJw2RH1Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A959138FC;
	Mon,  3 Jul 2023 10:21:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id zsSpDS2homSWMAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 10:21:33 +0000
Message-ID: <0e230fdf-6af6-926f-305e-2f34ac6a6812@suse.de>
Date: Mon, 3 Jul 2023 12:21:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] net/tls: split tls_rx_reader_lock
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230703090444.38734-1-hare@suse.de>
 <20230703090444.38734-5-hare@suse.de>
 <1ebc60c1-c094-98a0-5735-635a8af5bf63@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1ebc60c1-c094-98a0-5735-635a8af5bf63@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/3/23 12:06, Sagi Grimberg wrote:
> 
> 
> On 7/3/23 12:04, Hannes Reinecke wrote:
>> Split tls_rx_reader_{lock,unlock} into an 'acquire/release' and
>> the actual locking part.
>> With that we can use the tls_rx_reader_lock in situations where
>> the socket is already locked.
>>
>> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   net/tls/tls_sw.c | 38 ++++++++++++++++++++++----------------
>>   1 file changed, 22 insertions(+), 16 deletions(-)
>>
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index 9aef45e870a5..d0636ea13009 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -1848,13 +1848,10 @@ tls_read_flush_backlog(struct sock *sk, struct 
>> tls_prot_info *prot,
>>       return sk_flush_backlog(sk);
>>   }
>> -static int tls_rx_reader_lock(struct sock *sk, struct 
>> tls_sw_context_rx *ctx,
>> -                  bool nonblock)
>> +static int tls_rx_reader_acquire(struct sock *sk, struct 
>> tls_sw_context_rx *ctx,
>> +                 bool nonblock)
> 
> Nit: I still think tls_rx_reader_enter/tls_rx_reader_exit are more
> appropriate names.

I don't mind either way, but I've interpreted the comments from Jakub 
that he'd like this naming better.

Jakub?

Cheers,

Hannes


