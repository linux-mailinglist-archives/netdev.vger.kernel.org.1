Return-Path: <netdev+bounces-270606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLfIKXhzwWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:08:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E414A2F97AF
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B6BC317562D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD96F3BA25C;
	Mon, 23 Mar 2026 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOOTwuYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6F3B0ACB
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282472; cv=none; b=cz0steAMfXcStwzoAwvZFV2dVEsAmmjKLWSiYi4GenlhmUSDagXFWqHgoI8BOT3guVFx6Bwf/lPs+zk26+94HnNdhMN+/UHEMRV+wInqo37wm45bomnhD4JQD6tie0955sydnECExwtSknZvFwHEdmPTcwgQoYa1n08zb61ltNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282472; c=relaxed/simple;
	bh=/9wFtUpwo93aoF/yQoMMoKHh8Zo37Iy0Tbjo1nQyKJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULmuAFMRfQM6GrJCjgJ1DCzenbObfX0H6sJ0Du2Am6JybcVjm2bKAkg+koUR3S8E+REnbIu/4NernA6A/sQg2GSRzVQh0hEJLuZZYt7SNUiGSPaEy6zdpbfULy66CURp91Go3CBwunID/5/O2G3v8knpC+VF6/hv8q3+0Rjnd1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOOTwuYW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48538c5956bso40629065e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774282470; x=1774887270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5a/PBQoKYFTkqLtYH0BJ9gW0vtOTD5mPK1HUUNiblo=;
        b=KOOTwuYWe1iXWJrYWpTIqMbs9bUzm5iN2VZ0LhWNa3iT0blGatJ4HN9YByG797WOsK
         At5SMJdJq4F07tbPRpDUbDwvRI3teFg+i6lrPTPmWIOmlKW4l+ZyCde18bCRAB8D2Lj/
         KbcMSiH6N4kPVmLjmpKlAy5irVy7Fnvw3xSOoKTpscxyIUse8g0GE//jpS/OkRod4RsH
         wb2Jfy04fZ3T6P/DuQoSM0zSsZe6sFdFWS0CGDsjHdNGinSwSAkyUTTTpzN+t32EvbF+
         sdoGmK0bZAZ4t6D7mA4MqfyaFNWQG+7+m9PMj9ixTZNjd2cXfGlLJByiskDnVit99M3W
         vGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774282470; x=1774887270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5a/PBQoKYFTkqLtYH0BJ9gW0vtOTD5mPK1HUUNiblo=;
        b=TeOVCBi6zon4PXJtanhXgBW2XdyLnO1lFo9A8YxTD2Ywus5imuyHGjOgL1d8VKQ3Yb
         B6slMmK0wKjNmj/jkSWbRaoP4Un2f9AStEsaAW2QBzioZxBhEbjgbaraKQP1Dmehoz2T
         k6+nPF6eKeqFIMTOk5FdZmjL1SqvjzQGsrMXCPnQsvpHJ1DvWoDLaVo5CGyPBaj24olK
         8naImOXwsWzBvU4Z18WIy0LeIp5l0fdoZJjxT1GNL3DNa3TvvOXxXPZjdq1YuibcSw2Q
         /3CUPeJK4JZna1el/AvkBawUsz6FSfT+f3evzpzAEFTV0hzftBFHFGXOlhCpY+ihr7Ee
         e47Q==
X-Gm-Message-State: AOJu0YxGiJf2Yi5SPTLe0wP06+y0hu0Pw6FdhDBhetp0yr+MfjZB2PLf
	jzSnPVNhCYp87nnjaesF/NejCZp+4vWVIXwgEv+Ix1BRGVXa+kKUfPhY
X-Gm-Gg: ATEYQzzZEhfQbD1k1Lw2oQBS129vzfAy/My4KNAcZL6Zz5YSwcERbadAt+KCjoW+Qq5
	2MDEotRpKsfhwiCbXU2zh4Na1fXNLTM+9H3tZEj8ZrrDWe+/+2AcN3BHOjTz0ffsJp61+lWiGSE
	swTC5N/RXbppNKr5ESsN7Wi1SW9YL3aSpn54lbIAp9WTn8Rt5EppnVK02TZwYoti4r1FWvNy4aQ
	lllltjkfKOAnCapTyolr1jKI3L86NqUb+vZV/WglIoy5qh/RnrwKorTKhb+RZ1aYyTOFiILVdSZ
	UNONUMBTd3Tgck6rbtxBCM4iFyloAZ3La41v8OpbNEICaIO3RAK5KxZNUfTGhokZgJEnT+aMwL7
	sri+nEslVlLC7RbUyonNuLih/+dSJ+GAqSQLUF5hY81rNuxqqKCnDZNBdoJ/j4O8ZRJLwx6iKH8
	h6tafIeEwWNsWFCsXCusmtbmJXmrpk6vY1bzCiaPkCtdIFwFpH19yLKLdOzjOTfWyhDZAoB5iEr
	BfhJektOer+aaO8mZ/fGGb2w5a1yiLEq01t4yuBPd8rvXI78Z3xLolQqXc3ZMxfh9GIOTfgfl4Z
	xA==
X-Received: by 2002:a05:600c:4f0b:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-4870f202653mr2228875e9.11.1774282469407;
        Mon, 23 Mar 2026 09:14:29 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7e2665sm336315005e9.6.2026.03.23.09.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 09:14:28 -0700 (PDT)
Message-ID: <d1981803-0b3a-468a-9fe6-a751470cec26@gmail.com>
Date: Mon, 23 Mar 2026 16:14:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.1 01/16] io_uring/zcrx: return back two step
 unregistration
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org, Youngmin Choi <youngminchoi94@gmail.com>
References: <cover.1774261953.git.asml.silence@gmail.com>
 <0ce21f0565ab4358668922a28a8a36922dfebf76.1774261953.git.asml.silence@gmail.com>
 <1b3ad321-866a-4cb8-9810-5eae7805647d@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <1b3ad321-866a-4cb8-9810-5eae7805647d@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-270606-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: E414A2F97AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 15:01, Jens Axboe wrote:
> On 3/23/26 6:43 AM, Pavel Begunkov wrote:
>> @@ -898,12 +933,15 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
>>   			unsigned long id = 0;
>>   
>>   			ifq = xa_find(&ctx->zcrx_ctxs, &id, ULONG_MAX, XA_PRESENT);
>> -			if (ifq)
>> +			if (ifq) {
>> +				if (WARN_ON_ONCE(!is_zcrx_entry_marked(ctx, id)))
>> +					break;
> 
> This break is inside the scoped_guard(), does this need an ifq = NULL
> here? I do like scoped locking, but this seems a bit tricky...

That should work, want me to resend or would you amend it? It's a good
thing I was pointed at it, but I'm not too concerned about this case as
it's a warn once.

-- 
Pavel Begunkov


