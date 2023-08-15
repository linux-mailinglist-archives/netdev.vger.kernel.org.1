Return-Path: <netdev+bounces-27701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F577CEA7
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE062814F1
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B7B13AFB;
	Tue, 15 Aug 2023 15:04:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95531097E
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:04:57 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83975138
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:04:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 454B9218FB;
	Tue, 15 Aug 2023 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692111895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gX40rMQAaWgBzWqEjHojXs9AYynLgK+SuvL/w/s5uR8=;
	b=AwGZCyshceD92yFsUZy3GAfBVJCrm7QgEMTE0ITvIazOrjVLAYcd+pBrYP7n6EPbf4RpyO
	UX1mlyoSdmP5reTyFholEqpFBZ9pKxLaYDJoGJ5/YW0nKgBMjeUMi3UFOt6GDPiW8TADzC
	cX3KWVZ+LLINHz8e7GUAoe9WIoePm70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692111895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gX40rMQAaWgBzWqEjHojXs9AYynLgK+SuvL/w/s5uR8=;
	b=wV4tB+M0eR1RdycWinodPVUbscKXetVGTvLPuuFenlGufu3uv+NZrY/7yI+u44MiHSvvi8
	XcLfHJgjtYm0g9Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7E0D13909;
	Tue, 15 Aug 2023 15:04:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /TcINxaU22TvZgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 15 Aug 2023 15:04:54 +0000
Message-ID: <6fb98e7d-d28f-71d7-ee58-0ca7a013e8d8@suse.de>
Date: Tue, 15 Aug 2023 17:04:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 15/17] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-16-hare@suse.de>
 <cf21000c-177e-c882-ac30-fe3190748bae@grimberg.me>
 <bebf00fb-be2d-d6da-bd7f-4e610095decc@suse.de>
 <a7e01b78-52ba-9576-6d71-6d1f81aecd44@grimberg.me>
 <fdb8caf7-78cc-c39b-3dda-2d9db4128a34@suse.de>
 <ce3453f8-807b-301c-f18a-3d7a7bc0bca7@grimberg.me>
 <1eca42a4-ee8e-dff3-adb0-0f4799e4f96f@suse.de>
 <6a0e9122-87f3-b0e9-0a54-dbcc4cd9d819@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6a0e9122-87f3-b0e9-0a54-dbcc4cd9d819@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/15/23 15:34, Sagi Grimberg wrote:
> 
>>> How are you testing it btw?
>>
>> As outlined in the patchset description.
>> I've a target configuration running over the loopback interface.
>>
>> Will expand to have two VMs talking to each other; however, that
>> needs more fiddling with the PSK deployment.
> 
> Was referring to the timeout part. Would maybe make sense to
> run a very short timeouts to see that is behaving...

I'll see to patch it into tlshd.
I used to trigger it quite easily during development, but now that
things have stabilised of course it doesn't happen anymore.
Kinda the point, I guess :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


