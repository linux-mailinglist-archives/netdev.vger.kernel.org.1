Return-Path: <netdev+bounces-300314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 79ixNt56M2pLCgYAu9opvQ
	(envelope-from <netdev+bounces-300314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 06:58:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E5F69D920
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 06:58:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YCfoL2Sh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300314-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300314-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 164D7303E2B2
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 04:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DA1347538;
	Thu, 18 Jun 2026 04:58:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497CC2E7396
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 04:58:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758683; cv=none; b=Hwo20ggWuVuNn1SUBKdI0mfXEOlihASZT2ZgA9bXMvXtKX4B01oR9ucGtKQin5PT8hf9OOHcWkg30DwuweFAUDjp4gHeokaMobbm5XKgJ7KdccksHlyEA1gFFi3KFbI/mkocm8Fnh1Sdp8gfF89QTWAPp69+fwaJobor4xEd/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758683; c=relaxed/simple;
	bh=fcJZVCd4rqqpaz+9ULGeGk3h6Fv1G6tv/WpF+yZ45bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCcuRuXUipXFaal5pcT7LUUwblv7wB/fwUBiSqkxpbLPRV51PiXqLMvNWyaQ1qDvF15Nhb0S3af9lCXMExcx8TsoreTF4sV2EZVLOWPThg+GVrx/+1NvIQozrNAwUe3LZ+VTQOTazg1fFLLNLvvzlAlAxdsW/mZzAi38bdQfbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCfoL2Sh; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b900f350fso529137a91.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 21:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781758682; x=1782363482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHSvIRDQemxGadgD2iE0xf18mNVbs+dB/ONQrSSSMCo=;
        b=YCfoL2ShWv1p5M+pPW+asVskRor0flxkuxSGvacHoGCC022JmxnFgyoVKeIOkMMCvu
         7PTBPswCfCx6k17fm2hUkAbeTpY6HPPPXO9O6mLqrxdFOfQS+7PvxyTP/Nr/yqq05CKc
         /tCtCXguKXDRrL10U46qkpMUgNIQqdLbxdKaY+xzDfm7p7OKhc7akAe89vKbHvLCjWqS
         Wx8GzBe0Bedvksd7Slf9Nq0G6cG6sGE1U2z8kWu7yX/R9M604AwKtirEOEupWsDpMKqk
         lBQCrILbhS/oPLdcyWTcJJQ6xVoKZoME9SUoCQaVxCayDDmzrmMbP6Up0+/OpFgSSXtZ
         04Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781758682; x=1782363482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHSvIRDQemxGadgD2iE0xf18mNVbs+dB/ONQrSSSMCo=;
        b=IgWHh+JXyItf/U6/XPJtjIemX2KeQXA2EQ6cqgRLCI3mbn84FB/4bd9iTk6kn/BaT/
         eiG9+ic5j79quYSOjjukHP7dpsQHkAPUwFnUpn7fubiLj42MNVhncqKthfFptusmRcXk
         5GMRaihMneAZm57PPficHo5rpT8u9shCXhzKDMAdAzIpnpj8WvJmMtcoR56H2PmPvlVx
         TTkdBmI07dvggj0kaVLfszHKAQNCJ4aeQdn3+q40Fp3An/WnNKUt3/0H2I0Wsrf4X6+p
         Um7anmdAmjw8GAM8+AuIAW7Z5ONokAoySbZMR+LzWOLIEpWz2gH/WSAIMr6Zn3q9+T8/
         vc9Q==
X-Forwarded-Encrypted: i=1; AFNElJ80TFEjpYNznvEuBBkEv1FZdFotFbr3+LIXGk0NYwHL82xXFMPlpOyQ6yZLKqpcWbZq3iOPbi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEsB2SBPsSlneA8QzCtOMc2v8vLTIut/Qa6ZM0GrEZMaLTu9W/
	h8elNJb3WdELmmYLG6xHH7i8q99CShJNrnWwyp1MK16R/s8qpJ03+McO
X-Gm-Gg: AfdE7ckHO4JQUg5Y2T9Pdgy7JRhWEm5gqXnBqHhTD6tOZbpv3TnVjcp6W/Yr8/XSCby
	TtLiKnoqwVta5/ejPt9h2fxg+XxpiHNopaM2z7Z1lZeWtFb5CPRhwAmYe4coK929vyr2y1zeECk
	fxZFNWyNBQz8IdTaqIHUbm/yKWzddzNZ4rJ2uYVDFPlTM266wDYX1jmC/eEsBIc2JiyQgDopcdO
	S/mghJSS9udNyGjmFWrZi0b3Q9jL4yHvY2984KZxdCs5sJYbU0iWlFv6jAUQsv2g7JSyFtO64RP
	gzkCnLd17++ZqQSunpSoQrF4Vnia9Sn5xikr9dqvCSr/gRDhtd2XLeyMWXv/EytOoZ4dsMb/Qk/
	SHYckJ8kDYgPx6fu7FvSR7z3CRlTk8/by6Dw7KylRL7iANxmIBbotqTl434zCH2x9xeRIFeFuT/
	69q1Oy0Cd3bhINVP0Yr401tCpDRoC2kkm07yykC1j3DdpwOsq4
X-Received: by 2002:a17:90b:5807:b0:36b:b3f4:d578 with SMTP id 98e67ed59e1d1-37ce4545be5mr1884346a91.15.1781758681588;
        Wed, 17 Jun 2026 21:58:01 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ca980sm7976715a91.6.2026.06.17.21.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 21:58:01 -0700 (PDT)
Date: Thu, 18 Jun 2026 04:57:54 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: bobbyeshleman@gmail.com, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Subject: Re: [PATCH bpf v2] bpf, sockmap: fix use-after-free when the stream
 parser resizes the skb
Message-ID: <kktndchjc5mnxcc4p3urfwu3sbkkpfvqo44st7z5djzntixvr7@2vnocsbraee5>
References: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
 <20260618002559.1479884-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260618002559.1479884-1-kuniyu@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300314-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:bobbyeshleman@gmail.com,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cloudflare.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,2vnocsbraee5:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46E5F69D920

On Thu, Jun 18, 2026 at 12:25:57AM +0000, Kuniyuki Iwashima wrote:
>From: Sechang Lim <rhkrqnwk98@gmail.com>
>Date: Fri, 12 Jun 2026 12:35:51 +0000
>> sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
>> to find the length of the next message. strparser assembles a message out
>> of several received skbs by chaining them onto the head's frag_list and
>> recording where to append the next one in strp->skb_nextp:
>>
>> 	*strp->skb_nextp = skb;
>> 	strp->skb_nextp = &skb->next;
>>
>> and then calls the parser on the head:
>>
>> 	len = (*strp->cb.parse_msg)(strp, head);
>>
>> The parser is only meant to inspect the skb, but the program may call
>> bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
>> bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB.
>
>It's bpf prog's responsibility not to abuse them.
>
>Even setting aside that, why not simply block such BPF prog ?
>
>It cannot be done at load time, but doable at attach time.
>
>>

Thanks, this is cleaner than cloning. Will fix in v3.

Best,
Sechang

