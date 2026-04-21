Return-Path: <netdev+bounces-280075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AK7DgRX52nz6gEAu9opvQ
	(envelope-from <netdev+bounces-280075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:52:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B8439C64
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC8F4300A38C
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFF93B0ACC;
	Tue, 21 Apr 2026 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+40Tug+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xof4CRGb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64273F9FB
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768524; cv=none; b=FGBhVxpATU+Vpg5LsizSYHVaZAnchp/eUzJPWA/GyK45lE2eBoaWm3txA2Itj0ucI8q3gnwr6DVNMs+U/MsFrpOEBEgy1bpem5LlUfL4SeF2PfjlnQaKZ2HVvfJSH4hAyKyrRwGnZRk+iG+jpo/Rr9PbSdF5dppSrOIDSFBJFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768524; c=relaxed/simple;
	bh=HzcVWmFA4ImVLixni4jvJutqRX1rAYIazslLUCRvja8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WIjSUdNUQ/xs7NHVS03P67Edpbxm3//x9OQN3wv7mMpxC2XC6pQXUHzVBzczgntLDnRjrdOV4mwY3DeokLlzVa9fwd2TWk3bkMCMRc0wB3M8iFIrEPCrSeifMPFgH0cYwzcPNlEVASnn+fqlyhYgeZi41jdy1QfWEvmL65erA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+40Tug+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xof4CRGb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776768521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+wrCghi7sJQ0FqpH6ZV+YGjNkwnDZI6D5hjA5/ojo8=;
	b=H+40Tug+wm58VFqpUsvFEPm8Z0LY+di3EnIeUCc78/jRfcenjxWIv/4sCJSpXRzyvrh3wx
	VdegRJTBz9aJYot1uFGBLi77Jl+gI2wM5F/xO7EdEfSw90L+OSNnfYl+dKZ4Ql5l65OkDc
	BqX8bJphnn087dWRi4rJRiv2fvu7C0M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128--Z6FrY_mP6yVzwQfn1Kizw-1; Tue, 21 Apr 2026 06:48:40 -0400
X-MC-Unique: -Z6FrY_mP6yVzwQfn1Kizw-1
X-Mimecast-MFC-AGG-ID: -Z6FrY_mP6yVzwQfn1Kizw_1776768519
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c213b485so34843565e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776768519; x=1777373319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I+wrCghi7sJQ0FqpH6ZV+YGjNkwnDZI6D5hjA5/ojo8=;
        b=Xof4CRGbEsvbqB19smJKvXZowozmv4jjGfPK2HP+g2pnI+od/gbL39XGbEfYKlZfJS
         M76ZAN1rodwZL8ooGPAboVPAVYe1Op4GoKPqf0eQd3hP2LNqLNjWCmHje2OoI544nNCG
         H7BpDclFRfDpEGM7tg7LLj3PfKzyPtL9VydZWmpgY7WL8bwVjfXRzYMNSF7Shav0F+Tw
         5Z4GYaGvycRtcvW5rvvLsZwsxReI0MswekM2HQ/YFuiJlXWncwhXtTYbl+vPb5fbBFad
         yTrTrz0FqR+FTPPupibRZcwFI4au3fN+ne4FHgx1Ba9p9lnMJNQXMadIx8NWQmOnqoDt
         5pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776768519; x=1777373319;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+wrCghi7sJQ0FqpH6ZV+YGjNkwnDZI6D5hjA5/ojo8=;
        b=Y3hYkPUF0jFfec6pF4dv5g1t26C6uXILW8gMc4OHDTStFX0CLEHFTjdquzbmykM431
         YInuJX+iEYSxeh4s5yH+p1is30+790at5RCQWYIPcX03BrrNqZt7wRjjDBIy9Hzlr2dS
         RuH2gi1U1/hpYpSirZNi8JI1/Mjz25JxwArjCbanMosW98sGrN16rujFE5YcVwKZzAg9
         doCGiwpwowN4D9g5T47BHtUlFeP6LC/MGABw9ODswb1Wn64xHO+7hjKwgGeXwy6KDcwb
         tCTK2wBlciUCh3xI/43GmG67g8VLq8eVCoZXvKp1IunW4MU9CDcSJnOHIvZMQvgAeO47
         xXwA==
X-Forwarded-Encrypted: i=1; AFNElJ95YtZ7SOPaZbT6nhuMqdtVrbfuypfX/dFKRMfz5KxAsBr5XnN4V8TmScO+vKpekFsh09q6K6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCD5ZYQ0jSXjl19gnLxOaN1fKxYEEUGsnUGq/DG5GaBOdHLeUh
	prXgTJL8bXfFk9eXyKhJFRpqWBSeumxuwNxv6LiPIauRPttDj7k8xte2zdCtlz0rDCM8yXX2iZ+
	NICYAl29oZGDg+qMbdwKq4x55h+o1AufAtWVlz/hcG4Nr82mLcK2mumPX33mFI5M9xA==
X-Gm-Gg: AeBDievC2W3pPKvYJ11CXcZlGXdkFpmBust7SGhOTzScw0IrvFdHWAFQoFFtQ28Orzj
	uHDWXxJNIEyLf+XMaurLFugU0xs7iuql/eTSES9BRSGIHLSsHfe1TQkaBPGToZevli25CqbfZwv
	dOeaEBziBF0mmEL6qsBQRb2PSH0PIz+vbN3Vs3suPBuRq/ibPUkCC8i4KWvbM6RcfP2ottZmChE
	IxWYRdzzEFI88ctVSFKI5Iee1wgjBrHjwOii3UlILr/mAS8TvvaHYSKUTlgLkrOgVjHKvz4Tie/
	783Azw3P6F5YHID5uexEnZDhSMQuH5Y+/YE/cSP2QtD6NpZvSviDPrDVXdgGVBs9CXgApMksD2Z
	HKdX6PnhG9RMoTU37YZFnM7BkCjDwjAQT/hxkRWHhe4dirBi0LoOOXD5DZrNsHJlywFY=
X-Received: by 2002:a05:600c:c082:b0:488:b043:5efd with SMTP id 5b1f17b1804b1-488fb75f7a6mr191470605e9.13.1776768518931;
        Tue, 21 Apr 2026 03:48:38 -0700 (PDT)
X-Received: by 2002:a05:600c:c082:b0:488:b043:5efd with SMTP id 5b1f17b1804b1-488fb75f7a6mr191470295e9.13.1776768518466;
        Tue, 21 Apr 2026 03:48:38 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891bba6276sm74543965e9.0.2026.04.21.03.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 03:48:37 -0700 (PDT)
Message-ID: <12244c7a-07c5-4d75-98aa-3fe35c149272@redhat.com>
Date: Tue, 21 Apr 2026 12:48:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v8 03/15] net: cache snapshot entries for
 ndo_set_rx_mode_async
From: Paolo Abeni <pabeni@redhat.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org
References: <20260416185712.2155425-1-sdf@fomichev.me>
 <20260416185712.2155425-4-sdf@fomichev.me>
 <1d871492-2da5-44b0-b6fe-860966dff55a@redhat.com>
Content-Language: en-US
In-Reply-To: <1d871492-2da5-44b0-b6fe-860966dff55a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280075-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 891B8439C64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 11:52 AM, Paolo Abeni wrote:
> On 4/16/26 8:57 PM, Stanislav Fomichev wrote:
>> Add a per-device netdev_hw_addr_list cache (rx_mode_addr_cache) that
>> allows __hw_addr_list_snapshot() and __hw_addr_list_reconcile() to
>> reuse previously allocated entries instead of hitting GFP_ATOMIC on
>> every snapshot cycle.
>>
>> snapshot pops entries from the cache when available, falling back to
>> __hw_addr_create(). reconcile splices both snapshot lists back into
>> the cache via __hw_addr_splice(). The cache is flushed in
>> free_netdev().
>>
>> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
>> (cherry picked from commit ba3ab1832a511f660fdc6231245b14bf610c05bd)
> 
> Are you backporting from 7.2 via time machine??? :-P
> 
>> @@ -611,8 +633,8 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
>>  		}
>>  	}
>>  
>> -	__hw_addr_flush(work);
>> -	__hw_addr_flush(ref);
>> +	__hw_addr_splice(cache, work);
>> +	__hw_addr_splice(cache, ref);
> 
> I think here sashiko has a point, with the cache size being unbounded. I
> guess syzkaller or the like will find a way to make it grow too much.
> 
> What about hard-limit it to some reasonable value?!?

There are a few more remarks from sashiko at the driver level, but
AFAICS are all pre-existing issues.

I think even the above one it's better handled as a follow-up, so I'm
applying the series as-is (I'll just drop the cherry-pick statement above).

/P


