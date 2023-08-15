Return-Path: <netdev+bounces-27594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD4177C7B8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A621C20BF2
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88205C9D;
	Tue, 15 Aug 2023 06:20:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45B567E
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 06:20:46 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D1F3C05
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:20:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D20A21992;
	Tue, 15 Aug 2023 06:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692080440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4odYFRAf0mnDRB+A3xq3whLMLph3njV54CRH8KxPF4=;
	b=vtEdqnfwK1QK9BePGHYn84vHHipyqL5S7qBma2OZxEY26dTyYVQyIAJSFETIGuvdqoTBgB
	+7gl4sOME0NQUdgSuTOoqOUtQO86y+FgvG2exbb7BjV7G1d27GeLrcHok7xU8Y/GqTCoCG
	pJo2GdLTyY6w+OaAiO9AEBi7vv1s0Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692080440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4odYFRAf0mnDRB+A3xq3whLMLph3njV54CRH8KxPF4=;
	b=IHpYArTeoTlWy1IjvBeSPc/oq4civzCxSId3lkeuOXzifiQjrbDs1Jv3bDhD/eDw/Wn5tT
	gAuz7w/ZDp6DzjDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 329DC1353E;
	Tue, 15 Aug 2023 06:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id SOMnCzgZ22SnagAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 15 Aug 2023 06:20:40 +0000
Message-ID: <92692ffe-a83a-00a0-553a-7e7a1aa5e23a@suse.de>
Date: Tue, 15 Aug 2023 08:20:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 17/17] nvmet-tcp: peek icreq before starting TLS
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-18-hare@suse.de>
 <304bc2f7-5f77-6e08-bcdb-f382233f611b@grimberg.me>
 <f9ebbd9d-31be-8e2c-f8a2-1f5b95a83344@suse.de>
 <b9ec8b98-dcde-1d89-9431-4799240f0c80@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b9ec8b98-dcde-1d89-9431-4799240f0c80@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/14/23 21:05, Sagi Grimberg wrote:
> 
> 
> On 8/14/23 16:18, Hannes Reinecke wrote:
>> On 8/14/23 14:11, Sagi Grimberg wrote:
>>>
>>>> Incoming connection might be either 'normal' NVMe-TCP connections
>>>> starting with icreq or TLS handshakes. To ensure that 'normal'
>>>> connections can still be handled we need to peek the first packet
>>>> and only start TLS handshake if it's not an icreq.
>>>
>>> That depends if we want to do that.
>>> Why should we let so called normal connections if tls1.3 is
>>> enabled?
>>
>> Because of the TREQ setting.
>> TREQ can be 'not specified, 'required', or 'not required'.
>> Consequently when TSAS is set to 'tls1.3', and TREQ to 'not required' 
>> the initiator can choose whether he wants to do TLS.
>>
>> And we don't need this weird 'select TREQ required' when TLS is active;
>> never particularly liked that one.
> 
> The guideline should be that treq 'not required' should be the explicit
> setting in tls and not the other way around. We should be strict by
> default and permissive only if the user explicitly chose it, and log
> a warning in the log.

Whatever you say. I'll modify the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


