Return-Path: <netdev+bounces-12489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72DC737B8D
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 08:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B78028156B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 06:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E16A95A;
	Wed, 21 Jun 2023 06:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA978482
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:45:39 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B32271C
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 23:45:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5EB861F895;
	Wed, 21 Jun 2023 06:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687329896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbhW/xtXawV8CcYB2r3wrfEJyjcnLGE2+cj2i7CdGr8=;
	b=oYcKbW9d4asRiUSaLI7GdaATkUtnxaY3xnpXcr/RV/O9mIYKt4PnLWuzMT3xjpcYxZu+ve
	zfBbz//1xFBbZGD9xF+1F62O2Qv3hgRDAjyDETOwjcl9LkZTHZ+AwbUZi7+GN54jyrlPbW
	wqs0kVAd/SOkiNC1B4sn1N0KFR/dH/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687329896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbhW/xtXawV8CcYB2r3wrfEJyjcnLGE2+cj2i7CdGr8=;
	b=o0dhvQ653XkwtEuy5Ue/g1465bmo5k9uimtF/1EV7mcvN455BaUdNjZE1eh0W2DhzMlx5N
	e2oz699jB+575/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EC76134B1;
	Wed, 21 Jun 2023 06:44:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 092mAmickmRbJgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 21 Jun 2023 06:44:56 +0000
Message-ID: <bae9a22a-246f-525e-d9a9-72a074d457c5@suse.de>
Date: Wed, 21 Jun 2023 08:44:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230620102856.56074-1-hare@suse.de>
 <20230620102856.56074-5-hare@suse.de>
 <5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
 <20230620100843.19569d60@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230620100843.19569d60@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/20/23 19:08, Jakub Kicinski wrote:
> On Tue, 20 Jun 2023 16:21:22 +0300 Sagi Grimberg wrote:
>>> +	err = tls_rx_reader_lock(sk, ctx, true);
>>> +	if (err < 0)
>>> +		return err;
>>
>> Unlike recvmsg or splice_read, the caller of read_sock is assumed to
>> have the socket locked, and tls_rx_reader_lock also calls lock_sock,
>> how is this not a deadlock?
> 
> Yeah :|
> 
>> I'm not exactly clear why the lock is needed here or what is the subtle
>> distinction between tls_rx_reader_lock and what lock_sock provides.
> 
> It's a bit of a workaround for the consistency of the data stream.
> There's bunch of state in the TLS ULP and waiting for mem or data
> releases and re-takes the socket lock. So to stop the flow annoying
> corner case races I slapped a lock around all of the reader.
> 
> IMHO depending on the socket lock for anything non-trivial and outside
> of the socket itself is a bad idea in general.
> 
> The immediate need at the time was that if you did a read() and someone
> else did a peek() at the same time from a stream of A B C D you may read
> A D B C.

Leaving me ever so confused.

read_sock() is a generic interface; we cannot require a protocol 
specific lock before calling it.

What to do now?
Drop the tls_rx_read_lock from read_sock() again?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


