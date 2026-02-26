Return-Path: <netdev+bounces-261513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK6fE1aRoGllkwQAu9opvQ
	(envelope-from <netdev+bounces-261513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:30:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B182E1ADAB9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0CB6320F43D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70573368970;
	Thu, 26 Feb 2026 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byF8qcdr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpNI2wOv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F173290A6
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126398; cv=none; b=ZTbApdqdO9KurL48Q/6m2bR5pFhsAHj/7VpyxFbd5akJ+2KPNgcHoDiXnAscyp+2aqLvn/ASndyrBx5uzLhwiiVHhe91u+vvSU6EQrX212q3kkdmq9oXmN0SlPt8xuQEUkGwHfBMQnnuXWnr/CcwaP9seIYyFNZKKQ/pBgk36/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126398; c=relaxed/simple;
	bh=439dE7sFUE8Ylr/hcP7uv5Gr5kbWRamHCpjN1hMqb0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDSbnsPeLzxdwxVc9/IfKvaqZozna7WRM95S2SkIxkHkseTqq4OaqWDQEBXGXu9AKxFkPMiwov/cTvPR56OniRFv2g0E47Jt5OVF+E78h5iObEcREEB59wcXMF2Q3wA6fjWEtN8HjgPFUCPsDiBhBjOTlAtdPjYeTxRzNoTn1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byF8qcdr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpNI2wOv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772126396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TquABwgtbOZ5KxkpbEKIOiEEuQnLW+9e9Fgru6e5Tlg=;
	b=byF8qcdr/knkkoPk73xXlamEJ2pz8ZMmtFPkGGL+nF4fIZ8m+XjxesIfqA/50msoExIS+0
	oP5zdKSTjEZErU0+qqKjo+p8osHQPXWzCl7pd5RJGEq24SGS2cxXzt3WGmAX4DjcA4XgXT
	jSWgP41mCkhrbiOljsmKeai6NLxXHwY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-s47EMVnTPiuJbpteZ8RcfQ-1; Thu, 26 Feb 2026 12:19:54 -0500
X-MC-Unique: s47EMVnTPiuJbpteZ8RcfQ-1
X-Mimecast-MFC-AGG-ID: s47EMVnTPiuJbpteZ8RcfQ_1772126393
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837f288194so8944265e9.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772126393; x=1772731193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TquABwgtbOZ5KxkpbEKIOiEEuQnLW+9e9Fgru6e5Tlg=;
        b=CpNI2wOvlmnrgocQz9Lfk1N0lDohOa+HmGusD8Pcir3iQGKsAxm5cgWU31w/BZKqtV
         155MKgUGyYHQOm9AjptotsjHTHWNUzwVVWDjMJrsoUYhSewTN4KWUMP9ael3h5veALIl
         Xz2B7MHkHTnng3fQ2fCqCQN2IuTH94top9hgAEzCU9WhbUkZA2+oD1WZYBn7jvgj2kuU
         MON3X00R6ClTlwBFKhrSNYDn1I7kL6wy4fNLstfA3va9JbFegbILTZP83Oaf3KVH6LUO
         96iFRoBEwgrOVZTW+TfkQDBg1bUp2gUAE1BB0qef4fFGekF3QegQP/ItXN5QwiN+Eiuk
         rjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772126393; x=1772731193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TquABwgtbOZ5KxkpbEKIOiEEuQnLW+9e9Fgru6e5Tlg=;
        b=GGrm3luIRQA6E0u5kID6+BLpsYLJM+62hMVr7tfA3uBVbr6k1u0QKjdfpaX772YWUq
         /6U+Dnkf9Ir5Hho+MziIbg8J86hfTBDyPoFW529dwVPimLNbT3CJYHSW/ydHU9bmFkgD
         K29iClcYqDs+ZbIFdEpNmb3itXNz0zYTK70VfwqrUmYr35q/tSwrgMrvROPq/dTwFhQH
         bBRn1WX8GtcccIf6RMbobJ8/U8Ci7A9ZV6dqT+tjVN3YFGdJVQZHC//TpQjcb6/z/20p
         yL62oXwzeXj4PHJqFWXt64wHzpTMCk+sjWbRpuo1IoGPIhDELVgs9uDeQt8sBrGkltOW
         VErw==
X-Forwarded-Encrypted: i=1; AJvYcCUvpP04QGlGpwNo9v0QX5gUZ/1KG/xWuHHEXqg9c5zDcy5iiUG3E9nvol0UVEZoto5XcCr3s6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrmRb8TNb0GxNrl6GtOx+H1jJDh6D/yuNQqCNsDVomPQGBzucD
	HJXmLcO3of1XCfu5+4nD7hMppIIbXGlkw6JWWcApU1Y98wlXm+9Qy+RhbYL2/C6WIsvw2ybPYvB
	W5D6YgiV7zvvTSY/u9Pdq6kx0zPL9lyLDZ61Z8nd0P8pvidPgC4AZ9u2yXA==
X-Gm-Gg: ATEYQzx7n80H5v74Weqk+zBz9soUD2QFiKuJPetLZxRCpVTpCYp4WMHBAmhwaUqvRsH
	UFKH3gqbJUsMQYnrgus6ieborZb5o//GGRodXwZvEe7woRJA1A+dcIrqb013CtQxQ3TY6BuaC7k
	L6/7H5OralBXf0CRUrX3oTZ3bzNhNVsopDX3FEnl8xzYEiv5bv1IJBYKjmSOnp1xbvf+lDFXda/
	d+FllRsXJTRwwZK7Qu1TStUlY41/wl5Yp6HKpPx6nc07oGjCJEl4/PkQMJz4XQBwuT5zw5imoGQ
	buu8htjfJW6HdF4FObLm33R6crwyjciHoW0hCRVVNHIgx+FTpnntF3t7gbIcqA6A6XfdiLn03Gt
	5beoTUUjDhLeB45txoMuIVqggMw==
X-Received: by 2002:a05:600c:6217:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-483a95eb550mr327319685e9.3.1772126393342;
        Thu, 26 Feb 2026 09:19:53 -0800 (PST)
X-Received: by 2002:a05:600c:6217:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-483a95eb550mr327319095e9.3.1772126392772;
        Thu, 26 Feb 2026 09:19:52 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb4f8bsm104020285e9.4.2026.02.26.09.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 09:19:52 -0800 (PST)
Message-ID: <6fd597ff-ab5a-4304-a56d-1a0c9642c194@redhat.com>
Date: Thu, 26 Feb 2026 18:19:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,2/2] netfilter: nf_tables: unconditionally bump set->nelems
 before insertion
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: Jakub Kicinski <kuba@kernel.org>, edumazet@google.com,
 netfilter-devel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org
References: <20260225130619.1248-3-fw@strlen.de>
 <20260226035628.1827287-1-kuba@kernel.org> <aaACGbUnAyQiV3ut@strlen.de>
 <aaB0kaSgbnSgVFBE@chamomile>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aaB0kaSgbnSgVFBE@chamomile>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261513-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B182E1ADAB9
X-Rspamd-Action: no action

On 2/26/26 5:28 PM, Pablo Neira Ayuso wrote:
> On Thu, Feb 26, 2026 at 09:19:37AM +0100, Florian Westphal wrote:
>> Jakub Kicinski <kuba@kernel.org> wrote:
>>> This is an AI-generated review of your patch. The human sending this
>>> email says "Is this legit?"
>>
>> Looks legit to me.
>>
>>> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
>>> ---
>>> netfilter: nf_tables: unconditionally bump set->nelems before insertion
>>>
>>> This commit addresses a race condition where a new element gets published
>>> then removed without waiting for the RCU grace period when the set is full.
>>> The fix moves the nelems increment before insertion and adds cleanup logic
>>> using the abort path to safely unwind the set.
>>>
>>>> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
>>>> index 0c5a4855b97d..834736237b09 100644
>>>> --- a/net/netfilter/nf_tables_api.c
>>>> +++ b/net/netfilter/nf_tables_api.c
>>>> @@ -7171,6 +7171,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
>>>>  	struct nft_data_desc desc;
>>>>  	enum nft_registers dreg;
>>>>  	struct nft_trans *trans;
>>>> +	bool set_full = false;
>>>>  	u64 expiration;
>>>>  	u64 timeout;
>>>>  	int err, i;
>>>> @@ -7462,10 +7463,18 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
>>>>  	if (err < 0)
>>>>  		goto err_elem_free;
>>>>
>>>> +	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
>>>> +		unsigned int max = nft_set_maxsize(set), nelems;
>>>> +
>>>> +		nelems = atomic_inc_return(&set->nelems);
>>>> +		if (nelems > max)
>>>> +			set_full = true;
>>>> +	}
>>>> +
>>>>  	trans = nft_trans_elem_alloc(ctx, NFT_MSG_NEWSETELEM, set);
>>>>  	if (trans == NULL) {
>>>>  		err = -ENOMEM;
>>>> -		goto err_elem_free;
>>>> +		goto err_set_size;
>>>>  	}
>>>>
>>>>  	ext->genmask = nft_genmask_cur(ctx->net);
>>>> @@ -7517,7 +7526,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
>>>>
>>>>  					ue->priv = elem_priv;
>>>>  					nft_trans_commit_list_add_elem(ctx->net, trans);
>>>> -					goto err_elem_free;
>>>> +					goto err_set_size;
>>>>  				}
>>>>  			}
>>>>  		}
>>>> @@ -7535,23 +7544,16 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
>>>>  		goto err_element_clash;
>>>>  	}
>>>>
>>>> -	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
>>>> -		unsigned int max = nft_set_maxsize(set);
>>>> -
>>>> -		if (!atomic_add_unless(&set->nelems, 1, max)) {
>>>> -			err = -ENFILE;
>>>> -			goto err_set_full;
>>>> -		}
>>>> -	}
>>>> -
>>>>  	nft_trans_container_elem(trans)->elems[0].priv = elem.priv;
>>>>  	nft_trans_commit_list_add_elem(ctx->net, trans);
>>>> -	return 0;
>>>>
>>>> -err_set_full:
>>>> -	nft_setelem_remove(ctx->net, set, elem.priv);
>>>> +	return set_full ? -ENFILE : 0;
>>>> +
>>>>  err_element_clash:
>>>>  	kfree(trans);
>>>> +err_set_size:
>>>> +	if (!(flags & NFT_SET_ELEM_CATCHALL) && !set_full)
>>>> +		atomic_dec(&set->nelems);
>>>
>>> Does this properly handle the element update path when the set is full?
>>
>> Pablo, why does that check !set_full?  The increment is unconditional,
>> so why is the decrement asymmetric?
>>
>> err_set_size:
>>         if (!(flags & NFT_SET_ELEM_CATCHALL))
>>                 atomic_dec(&set->nelems);
>>
>> ?
> 
> I think so, this is a leftover from initial patches that where still
> using conditional atomic_add_unless().
> 
> I'm preparing a re-spin.

Please note that patch 1/2 as been already applied to the net tree.

/P


