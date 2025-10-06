Return-Path: <netdev+bounces-227907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61556BBD20C
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 08:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF474348D02
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 06:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA3248F72;
	Mon,  6 Oct 2025 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gZpC7+J2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ozmOENuk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gZpC7+J2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ozmOENuk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D3319DF6A
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759731846; cv=none; b=OomE+wVLJKj2v2l6N4+2Liu8cdVI1+9g8suDg8gAXfE3sY4bJ2PNY29Z09Lyp2oKROFI+nmErwVzrASX9bF4PtlMw+35P9Rbr+SB1GfoLvck5FCmU/9I0RRfk6vyml4t61wQZgC0e6nivowwELMlrSXn81fidekcGEf1NOCGwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759731846; c=relaxed/simple;
	bh=meO8F+Li+RFwUt9elNeCgN+dCn/iGVgjjVnuy1DnIjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sih/OrIXs7/tQMXJMg+xshRMJRpCM8slQorfrrAjVNWrS3facW0Q0hzlIQ45OvI67XYVG9Xtdwx/QNYvp/LGY+JGnA+4z65oX8mLYh7YDPSrOOijuIjnIT0n7NyUaPbnMJsVt6+bCRO3WxTWcea4phv5t5ISVEy33L8s8BD0D40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gZpC7+J2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ozmOENuk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gZpC7+J2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ozmOENuk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D0621F452;
	Mon,  6 Oct 2025 06:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759731843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkgVnRB/5xOR8vyw0Zzr+WL75nZte6VHjkiMRoBbH4g=;
	b=gZpC7+J2LTxbEltg8i2OaeSCH9s7KcU5QpA4fOCAb3zBlo5IH3gOJI4fhp7YEgujQfyuNn
	hD2evKEEAX/3cbg9yfO4KyvjCUvKX7oDjObLPaPcm6FGEv2rWPFLs/9uUvynPwhaR6S5Jj
	6NgoXt5HVgIC07ABREiSPFKs4sNvKDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759731843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkgVnRB/5xOR8vyw0Zzr+WL75nZte6VHjkiMRoBbH4g=;
	b=ozmOENuk2YLRTTagv6uR2+iKJ2sL1lw+wt8QOtS8JwO42f3vDv0In2B2MI+G/YGQ8AeVsu
	M5aJx642b5TNnVDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759731843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkgVnRB/5xOR8vyw0Zzr+WL75nZte6VHjkiMRoBbH4g=;
	b=gZpC7+J2LTxbEltg8i2OaeSCH9s7KcU5QpA4fOCAb3zBlo5IH3gOJI4fhp7YEgujQfyuNn
	hD2evKEEAX/3cbg9yfO4KyvjCUvKX7oDjObLPaPcm6FGEv2rWPFLs/9uUvynPwhaR6S5Jj
	6NgoXt5HVgIC07ABREiSPFKs4sNvKDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759731843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkgVnRB/5xOR8vyw0Zzr+WL75nZte6VHjkiMRoBbH4g=;
	b=ozmOENuk2YLRTTagv6uR2+iKJ2sL1lw+wt8QOtS8JwO42f3vDv0In2B2MI+G/YGQ8AeVsu
	M5aJx642b5TNnVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B988813995;
	Mon,  6 Oct 2025 06:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sgdCK4Jg42jqCAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 06 Oct 2025 06:24:02 +0000
Message-ID: <59ed5ee1-95c3-453e-a53a-b7bfb330511a@suse.de>
Date: Mon, 6 Oct 2025 08:24:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] net/handshake: Define handshake_sk_destruct_req
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-3-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251003043140.1341958-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,wdc.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 10/3/25 06:31, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Define a `handshake_sk_destruct_req()` function to allow the destruction
> of the handshake req.
> 
> This is required to avoid hash conflicts when handshake_req_hash_add()
> is called as part of submitting the KeyUpdate request.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>   - New patch
> 
>   net/handshake/request.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/net/handshake/request.c b/net/handshake/request.c
> index 274d2c89b6b2..0d1c91c80478 100644
> --- a/net/handshake/request.c
> +++ b/net/handshake/request.c
> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
>   		sk_destruct(sk);
>   }
>   
> +/**
> + * handshake_sk_destruct_req - destroy an existing request
> + * @sk: socket on which there is an existing request
> + */
> +static void handshake_sk_destruct_req(struct sock *sk)
> +{
> +	struct handshake_req *req;
> +
> +	req = handshake_req_hash_lookup(sk);
> +	if (!req)
> +		return;
> +
> +	trace_handshake_destruct(sock_net(sk), req, sk);
> +	handshake_req_destroy(req);
> +}
> +
>   /**
>    * handshake_req_alloc - Allocate a handshake request
>    * @proto: security protocol

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

