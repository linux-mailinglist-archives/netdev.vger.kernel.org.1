Return-Path: <netdev+bounces-228078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F90BC0ECD
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 11:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07B11881F3B
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179B2222A1;
	Tue,  7 Oct 2025 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dnwj/8Pa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z0OLcOkB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dnwj/8Pa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z0OLcOkB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078751991D4
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830695; cv=none; b=px9ciygVo4DbOtIc62+UocP8KiQYMqWg/1j1cJ4EuhwKMeTmIXG2a4YZk9Xvlg/E2bwk1NKdAJkA5Hdl/Utg5X9BmlRHBVRLl/0ZhAj6atLHZ+n4AB05qasj9kAvETvYOrw8sqJCjdbJnbttX2bGFAmN1yPVyFbNTN7Y0jiO70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830695; c=relaxed/simple;
	bh=N4TqPLvCylts6kJn1Yyifs5XQBQjcyPhMM9Gq/YcQ0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0aRIrBVv0pYOUdJjC0uUWEgnXrf9hP4RgLFW9GySuJA6n6wn4g75z3FSLdP5MC8uz2YctIvkCQkZj2r8QV/800vBPtoCLknvMbM6TpM4VUwH0NrQDqLm0e9HM3IndipgWsfSPscX4ZimB8vJZBRdGshovOvlij1VZnEgCtq4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dnwj/8Pa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z0OLcOkB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dnwj/8Pa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z0OLcOkB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 268BE1F7B7;
	Tue,  7 Oct 2025 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759830692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hXPaqmmq2s2Y3lyXsf2ahFy73j+9/j9vaK8FcUsZ9k=;
	b=Dnwj/8PaBsqiZdcg3fy/YHJKs9ngFLes8ErwGbAKwBpxAxGkosdYZcymQbd2ezu+WTVvOh
	e1QpViuPhxgMQQ4yLfD/FrYUHHj4gsPvzEilFDUTCJLS2DVWJQMLmx6rWp5rZxeiOdx6Gy
	SZDjIITrSeI0cg8Lu+FveuMjro5lrDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759830692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hXPaqmmq2s2Y3lyXsf2ahFy73j+9/j9vaK8FcUsZ9k=;
	b=Z0OLcOkBD4fuK/FQWLJqP2gC9h+WJ8a+X/Fg7IIduo2zVzsSLl3DRthWmTP8ohtMoNqrsO
	Iz2K8LoWU5mRJQDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759830692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hXPaqmmq2s2Y3lyXsf2ahFy73j+9/j9vaK8FcUsZ9k=;
	b=Dnwj/8PaBsqiZdcg3fy/YHJKs9ngFLes8ErwGbAKwBpxAxGkosdYZcymQbd2ezu+WTVvOh
	e1QpViuPhxgMQQ4yLfD/FrYUHHj4gsPvzEilFDUTCJLS2DVWJQMLmx6rWp5rZxeiOdx6Gy
	SZDjIITrSeI0cg8Lu+FveuMjro5lrDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759830692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hXPaqmmq2s2Y3lyXsf2ahFy73j+9/j9vaK8FcUsZ9k=;
	b=Z0OLcOkBD4fuK/FQWLJqP2gC9h+WJ8a+X/Fg7IIduo2zVzsSLl3DRthWmTP8ohtMoNqrsO
	Iz2K8LoWU5mRJQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2F1013AAC;
	Tue,  7 Oct 2025 09:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n320OqPi5Gi2VgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Oct 2025 09:51:31 +0000
Message-ID: <8e5a3ff3-d17a-488f-97fb-3904684edb47@suse.de>
Date: Tue, 7 Oct 2025 11:51:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/tcp: handle tls partially sent records in
 write_space()
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20251007004634.38716-2-wilfred.opensource@gmail.com>
 <0bf649d5-112f-42a8-bc8d-6ef2199ed19d@suse.de>
 <339cbb66fbcd78d639d0d8463a3a67daf089f40d.camel@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <339cbb66fbcd78d639d0d8463a3a67daf089f40d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On 10/7/25 11:24, Wilfred Mallawa wrote:
> On Tue, 2025-10-07 at 07:19 +0200, Hannes Reinecke wrote:
>> On 10/7/25 02:46, Wilfred Mallawa wrote:
>>> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>>>
>>
> [...]
>> I wonder: Do we really need to check for a partially assembled
>> record,
>> or wouldn't it be easier to call queue->write_space() every time
>> here?
>> We sure would end up with executing the callback more often, but if
>> no
>> data is present it shouldn't do any harm.
>>
>> IE just use
>>
>> if (nvme_tcp_queue_tls(queue)
>>       queue->write_space(sk);
> 
> Hey Hannes,
> 
> This was my initial approach, but I figured using
> tls_is_partially_sent_record() might be slightly more efficient. But if
> we think that's negligible, happy to go with this approach (omitting
> the partial record check).
> 
Please do.
Performance testing on NVMe-TCP is notoriously tricky, so for now we
really should not assume anything here.
And it's making the patch _vastly_ simpler, _and_ we don't have to
involve the networking folks here.
We have a similar patch for the data_ready() function in nvmet_tcp(),
and that seemed to work, too.
Nit: we don't unset the 'NOSPACE' flag there. Can you check if that's
really required? And, if it is, fixup nvmet_tcp() to unset it?
Or, if not, modify your patch to not clear it?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

