Return-Path: <netdev+bounces-112008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7E193483D
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 08:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39B51F23744
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 06:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5C66F2F6;
	Thu, 18 Jul 2024 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="acv/jEjt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Rt6as/TF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="virH7j9U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g7MgKene"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA88E2AD29
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721284956; cv=none; b=fDPWorKyPGbICUEV7JjLh0ISw/mor8znvwulfDlw94Qh8psiYeozl1PhQniFw5wT8w+gKETzwOC1eV4UDMPnhiki/Cuu71mWsEcBvcGFk0Txl+kcm+DnOH8ug0P0QLUzy2c0BP6MXaWRo8Nts3gAABp5WuxtIxMH9dP138E3eog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721284956; c=relaxed/simple;
	bh=Rr5XeNOzaHjqOcOMZSG74dWwTWDUxwMq/RPs6e6nytI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcsydOmD9XB3uYEviMjkyDA26DixwG7xhLeO/8BRg/S68du/t5RJS28OGd8a/CSQjaq72Li6Ov/caq24vmWqQr+uCyJKyDhvjofUzAB83fFHTDShPQoDbRzu2TDRUftyInAWC5z4+X0ZPiFV7C+kRGAE0Xx6Y0uTQcb6joemMJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=acv/jEjt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Rt6as/TF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=virH7j9U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g7MgKene; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0B521F8B0;
	Thu, 18 Jul 2024 06:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721284953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCdLaYYq2GRwcs8qxNxqcH/pkFKjVkJISd0LjkS/0x0=;
	b=acv/jEjtWB4IXU2y4B8WpLEVlwInvbuIGlBcbWCPvJanYx/oyh9cdOm3lw5v1ECPL4Enjx
	a5bL9yhlZYAswrvmUgEMELeZeUOhz2DICQcMc8mLh106t2R10bO3YPaAtRgNx96iaMeYbK
	/eCBtjyi1QWxm1oCMDB0BjrmtKfs5Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721284953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCdLaYYq2GRwcs8qxNxqcH/pkFKjVkJISd0LjkS/0x0=;
	b=Rt6as/TF5DqXzen7wq52pZAxIQjx/J4ldEV3OnQH1BU17TB8qPYOtj4H6hZIS5zj9xuc8W
	QSNoJ3VX1AhXVUBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=virH7j9U;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g7MgKene
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721284951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCdLaYYq2GRwcs8qxNxqcH/pkFKjVkJISd0LjkS/0x0=;
	b=virH7j9USiPJQZgRLgodRJb3oeraSW5cfy09+mmBzEV8+G/hBrKgsyViSwwjrEkb15BkJr
	VcaggOlqjbqCtoJU+KcTrarZitqL2Zv/3H5UCJE7VTIcpsFG35GjatlzvGCQ77kqBH6NUe
	0UwfN++K3uaZleBCuCarXaFVJDuHdJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721284951;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCdLaYYq2GRwcs8qxNxqcH/pkFKjVkJISd0LjkS/0x0=;
	b=g7MgKenewqNLO5UNv7M1bZ2w3tEWaWbZm3jVnHzQpFsDGUPZ+wovvLDJIIYf4D+VL8RG5g
	RI9/Z2uAGnYjiiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E78B136F7;
	Thu, 18 Jul 2024 06:42:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H5GAIFe5mGZOAwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Jul 2024 06:42:31 +0000
Message-ID: <a5473f69-5404-4c38-85d9-ca91c5160361@suse.de>
Date: Thu, 18 Jul 2024 08:42:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme-tcp: reduce callback lock contention
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240716073616.84417-1-hare@kernel.org>
 <20240716073616.84417-7-hare@kernel.org>
 <9b8b57ca-83ae-43a4-84c6-33017dc81a32@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <9b8b57ca-83ae-43a4-84c6-33017dc81a32@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C0B521F8B0
X-Spam-Flag: NO
X-Spam-Score: -0.50
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.50 / 50.00];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spamd-Bar: /

On 7/17/24 23:19, Sagi Grimberg wrote:
> 
> 
> On 16/07/2024 10:36, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> We have heavily queued tx and rx flows, so callbacks might happen
>> at the same time. As the callbacks influence the state machine we
>> really should remove contention here to not impact I/O performance.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/tcp.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index a758fbb3f9bb..9634c16d7bc0 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1153,28 +1153,28 @@ static void nvme_tcp_data_ready(struct sock *sk)
>>       trace_sk_data_ready(sk);
>> -    read_lock_bh(&sk->sk_callback_lock);
>> -    queue = sk->sk_user_data;
>> +    rcu_read_lock();
>> +    queue = rcu_dereference_sk_user_data(sk);
>>       if (likely(queue && queue->rd_enabled) &&
>>           !test_bit(NVME_TCP_Q_POLLING, &queue->flags)) {
>>           queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>           queue->data_ready_cnt++;
>>       }
>> -    read_unlock_bh(&sk->sk_callback_lock);
>> +    rcu_read_unlock();
> 
> Umm, this looks dangerous...
> 
> Please give a concrete (numeric) justification for this change, and 
> preferably a big fat comment
> on why it is safe to do (for either .data_ready or .write_space).
> 
> Is there any precedence of another tcp ulp that does this? I'd like to 
> have the netdev folks review this change. CC'ing netdev.
> 
Reasoning here is that the queue itself (and with that, the workqueue
element) will _not_ be deleted once we set 'sk_user_data' to NULL.

The shutdown sequence is:

         kernel_sock_shutdown(queue->sock, SHUT_RDWR);
         nvme_tcp_restore_sock_ops(queue);
         cancel_work_sync(&queue->io_work);

So first we're shutting down the socket (which cancels all I/O
calls in io_work), then restore the socket callbacks.
As these are rcu protected I'm calling synchronize_rcu() to
ensure all callbacks have left the rcu-critical section on
exit.
At a final step we are cancelling all work, ie ensuring that
any action triggered by the callbacks have completed.

But sure, comment is fine.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


