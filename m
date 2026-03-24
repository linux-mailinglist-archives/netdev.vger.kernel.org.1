Return-Path: <netdev+bounces-271081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBppF7qRwmkXfAQAu9opvQ
	(envelope-from <netdev+bounces-271081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:29:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3653096A0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C888C312E75E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3533A361DD0;
	Tue, 24 Mar 2026 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgKkkKaw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAE361642;
	Tue, 24 Mar 2026 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358281; cv=none; b=I6nqmN1pwH8Qv49XzR8xjFFSnXTeA9kvl39FZacaoJhBKOToDxfSDleinRqfN36iUG3d5puljja7xQYtex+iMazvGwOvN/+vlACAgoZnHn1Paj6p5D4eFiaZl+STlcg3TQOiql40Jj0fk/B2yc0xci9+16bzM/hi6AvoURc1SeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358281; c=relaxed/simple;
	bh=HpLBCnCa1xKeSeAwPwZvfU+iZI2wQruNJBD/Bjtt7xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+beL4VEnlWEl0Ybu6Ox50vRj5fnkoot2iEUwM3809R4SD92JQyTlwyreJAYhWvmKy2lzH7Wzze8LeXD4QTjS3wYNLByhnnaNbtC9tT2RYYCloYMhE2sR76EAMx7p9v/RL+1MO1OG7ap5i6BruEDXDvJ0D0XuFSGi4OfSd83+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgKkkKaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1CDC19424;
	Tue, 24 Mar 2026 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774358280;
	bh=HpLBCnCa1xKeSeAwPwZvfU+iZI2wQruNJBD/Bjtt7xs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SgKkkKawaLyaRSyyYzCRV8n53IrfhlExirYkmudIsRcPrVUShRbEoG7tJSpdIjP4n
	 abcb7cMTrrpqhSqHSyhmi0306RqDE86h0/FsAsg7A1V7kklJN9AxwWvmLOdBgjTmeC
	 C1+hwKp8sZ/uoyRIF8QFuwtbAiL6zKniR2evCXsFioBUil+TpXFbWbN+s0NzvFPILV
	 AVcdBxDVyoegkq7g6ojkPaKVQ8RBRC3pQPNA2zAFbDUgz8W1PexVkK2iGnZMSct0ri
	 mazOqv/Ye+oknsXXrZ5IkZb/dah7+FiIiII5nuxd3+jC789HflgXzaJVwBikBrUgi0
	 0pao3CRtXiYOQ==
Message-ID: <b48d4311-51f2-4e71-8324-303af224bac6@kernel.org>
Date: Tue, 24 Mar 2026 09:17:57 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PATCH net-next v4 8/8] tls: Enable batch async decryption
 in read_sock
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: john.fastabend@gmail.com, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
 <acFK4DWAD5h_Oc0f@krikkit>
 <5190a4bf-cc66-424e-9c67-ffb3ddb58030@app.fastmail.com>
 <acHH6NVykWZo5Q3Q@krikkit>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <acHH6NVykWZo5Q3Q@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271081-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF3653096A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 7:08 PM, Sabrina Dubroca wrote:
> 2026-03-23, 11:04:16 -0400, Chuck Lever wrote:
>>
>> On Mon, Mar 23, 2026, at 10:14 AM, Sabrina Dubroca wrote:
>>> 2026-03-17, 11:04:21 -0400, Chuck Lever wrote:
>>>> +/* Bound on concurrent async AEAD submissions per read_sock
>>>> + * call.  Chosen to fill typical hardware crypto pipelines
>>>> + * without excessive memory consumption (each in-flight record
>>>> + * holds one cleartext skb plus its AEAD request context).
>>>> + */
>>>> +#define TLS_READ_SOCK_BATCH	16
>>>
>>> I suspect that at some point, we'll have a request to make this
>>> configurable (maybe system-wide, maybe by socket?).
>>
>> I appreciate your careful and close review. The series has
>> improved significantly.
>>
>> I will admit that the current value (16) is arbitrary. I agree
>> that someone might want to modify this value. At this point,
>> however, the constant is straightforward and it is still quite
>> easy to promote to a tunable later if that proves to be needed.
> 
> Agreed.
> 
>> The right interface for this depends on kTLS consumer needs
>> that aren't clear (to me) yet.
> 
> In this case (read_sock), the kTLS consumer is NVMe/TCP etc, and
> specifically users of those features with crypto acceleration
> cards. I'm not familiar with either.
> 
>> But let me know if you have a
>> preferred API mechanism or a specific use case in mind, or if
>> there is a netdev policy that should guide the introduction
>> of a suitable API for this purpose.
> 
> Nothing specific, I just thought I'd mention it since I was replying
> to the patch anyway. I think at this stage "it seems easy to promote
> to a tunable later" is enough consideration (just to avoid getting
> trapped in some API (or lack thereof) and unable to change it, but I
> agree that it shouldn't be a problem here).

I looked into this a little more yesterday before noticing that
async crypto was disabled for TLS 1.3.

The hardware crypto engines do not surface a concurrency limit to
their consumers, but their ring sizes are typically much larger than
the batch limit of 16 I've chosen here. We can't rely on them to
tell kTLS where to set that limit.

However, the loop was structured to continue until the batch limit
was hit or reading gets -EBUSY. Either way 16 seems to be a safe
but fairly conservative setting. For the larger rings it might cause
a decrypt pipeline bubble.

So the true purpose of the low limit is to constrain the amount of
memory tls_read_sock sets aside for decryption in progress. That's
going to be about 256KB per socket. Yes, that could be made larger
or contingent upon TCP socket buffer sizes, for example.


-- 
Chuck Lever

