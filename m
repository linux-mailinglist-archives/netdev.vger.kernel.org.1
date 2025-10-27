Return-Path: <netdev+bounces-233311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F43C11895
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 22:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A51F565E05
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2741D32AACD;
	Mon, 27 Oct 2025 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fB+KAZJN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gmZ07OOD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fB+KAZJN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gmZ07OOD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F131B83D
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761600033; cv=none; b=ZARRHI5IdOmNBfZLeVO8rNcTX/rHybWVncHaRMdxUDcPE2kM83J0CZVR6+4LkSdAdokvfgH0HzzxgPbej0Gufd30s3MkpzI2jW92/WkecbTwDHeKe25tZlfw7SdxfIme6zBDR29S3cdDINGFJz+qzrG2MzuGFm69d0MfFuBrJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761600033; c=relaxed/simple;
	bh=9TIwkH4I1E4ZLdCbAgkOe7fZ5rmnAJOlsMOgCChMBwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZZM/WOMKFXBmI5OIhGj+BDARJnNvAql+3NDWH0sQsk7LGfFUSi4xN3UJPQW8Oc33VVCDrigHmfe1dJs2GQP1QzY5qaFneO+16v+3nyL0rQ5kAPHzJTz7CffUJXENgWgpYgUU3vI744vBuk3Wnz1k7XYuq1vO+DebgHBEq2CiuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fB+KAZJN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gmZ07OOD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fB+KAZJN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gmZ07OOD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71E4521841;
	Mon, 27 Oct 2025 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761600023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cn3Ugr+qdQ01HAR+/u2rORvT+w57WeB4KaJS1A4oVhc=;
	b=fB+KAZJNv0YHA2E32CEzJ7L1BRnVA5egaklgaLZSbfg6rgo2Aj5+4TRRu1y0V4Yn3FhIVI
	LTMC1AR9rWDFAOn4WbA7Hz3tKaFFX1zu6AMAe2eApluYKMZL0kVgpXijmyy9QiQm6Kyjn8
	aJw7ew9PA8j+CLvtDvnhgZyBWbb5Ozw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761600023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cn3Ugr+qdQ01HAR+/u2rORvT+w57WeB4KaJS1A4oVhc=;
	b=gmZ07OOD57Ub3kZwpwstIHy9yQC1azhvbpufeSgTN/b5fI/SzEZrSxTgYsQMxvppW3G455
	TbgxlZc003l0jRCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761600023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cn3Ugr+qdQ01HAR+/u2rORvT+w57WeB4KaJS1A4oVhc=;
	b=fB+KAZJNv0YHA2E32CEzJ7L1BRnVA5egaklgaLZSbfg6rgo2Aj5+4TRRu1y0V4Yn3FhIVI
	LTMC1AR9rWDFAOn4WbA7Hz3tKaFFX1zu6AMAe2eApluYKMZL0kVgpXijmyy9QiQm6Kyjn8
	aJw7ew9PA8j+CLvtDvnhgZyBWbb5Ozw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761600023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cn3Ugr+qdQ01HAR+/u2rORvT+w57WeB4KaJS1A4oVhc=;
	b=gmZ07OOD57Ub3kZwpwstIHy9yQC1azhvbpufeSgTN/b5fI/SzEZrSxTgYsQMxvppW3G455
	TbgxlZc003l0jRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20C1A136CF;
	Mon, 27 Oct 2025 21:20:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wa10Nxbi/2gtKQAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 27 Oct 2025 21:20:22 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: netdev@vger.kernel.org,  io-uring@vger.kernel.org,  Jakub Kicinski
 <kuba@kernel.org>,  "David S . Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH 3/3] io_uring: Introduce getsockname io_uring cmd
In-Reply-To: <f61afa55-f610-478b-9079-d37ad9c2f232@kernel.dk> (Jens Axboe's
	message of "Sat, 25 Oct 2025 07:27:01 -0600")
Organization: SUSE
References: <20251024154901.797262-1-krisman@suse.de>
	<20251024154901.797262-4-krisman@suse.de>
	<f61afa55-f610-478b-9079-d37ad9c2f232@kernel.dk>
Date: Mon, 27 Oct 2025 17:20:16 -0400
Message-ID: <87ldkwyrcf.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Jens Axboe <axboe@kernel.dk> writes:

> On 10/24/25 9:49 AM, Gabriel Krisman Bertazi wrote:
>> Introduce a socket-specific io_uring_cmd to support
>> getsockname/getpeername via io_uring.  I made this an io_uring_cmd
>> instead of a new operation to avoid polluting the command namespace with
>> what is exclusively a socket operation.  In addition, since we don't
>> need to conform to existing interfaces, this merges the
>> getsockname/getpeername in a single operation, since the implementation
>> is pretty much the same.
>> 
>> This has been frequently requested, for instance at [1] and more
>> recently in the project Discord channel. The main use-case is to support
>> fixed socket file descriptors.
>
> Just two nits below, otherwise looks good!
>
>> diff --git a/io_uring/cmd_net.c b/io_uring/cmd_net.c
>> index 27a09aa4c9d0..092844358729 100644
>> --- a/io_uring/cmd_net.c
>> +++ b/io_uring/cmd_net.c
>> @@ -132,6 +132,28 @@ static int io_uring_cmd_timestamp(struct socket *sock,
>>  	return -EAGAIN;
>>  }
>>  
>> +static int io_uring_cmd_getsockname(struct socket *sock,
>> +				    struct io_uring_cmd *cmd,
>> +				    unsigned int issue_flags)
>> +{
>> +	const struct io_uring_sqe *sqe = cmd->sqe;
>> +
>
> Random newline.

Done, but this fix will totally ruin the diffstat.  :(

>
>> +	struct sockaddr_storage address;
>> +	struct sockaddr __user *uaddr;
>> +	int __user *ulen;
>> +	unsigned int peer;
>> +
>> +	uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
>> +	ulen = u64_to_user_ptr(sqe->addr3);
>> +	peer = READ_ONCE(sqe->optlen);
>> +
>> +	if (sqe->ioprio || sqe->__pad1 || sqe->len || sqe->rw_flags)
>> +		return -EINVAL;
>
> Most/all prep handlers tend to check these first, then proceed with
> setting up if not set. Would probably make sense to mirror that here
> too.

Ack. will wait a few days for feedback on the network side before the
v2.

-- 
Gabriel Krisman Bertazi

