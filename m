Return-Path: <netdev+bounces-302689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IicZNKOMQmpW9gkAu9opvQ
	(envelope-from <netdev+bounces-302689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:17:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 408CB6DC8CC
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:17:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=b5ZbIrUt;
	dkim=pass header.d=redhat.com header.s=google header.b=s4+DPnR8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302689-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302689-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0A57313725B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA0942980C;
	Mon, 29 Jun 2026 15:08:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D74279FC
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 15:08:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745717; cv=none; b=JJ4M3MNFjHtfx35j1arxMK0T11aVGOgtpCgQVs6fB+YeduZ2TBb1NIENA3YyBmRRjKUWOVX86pPTZ+r0Dp9QLFAz3fF76CwA8ahn81znQKKlmQ11jx2q3nuhE1qozMXuTLINsvwuBpCjhNQhfsb9qrKJc+irK+jYYWyRNKyLDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745717; c=relaxed/simple;
	bh=lMco64SlCp2iFk0E6dTwrSjmt/kwqJaHvhyZAbJrpBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lWToHzRNvBq2Rj2GJlcDr9/03TMj1Nd0MEhuRGiX1+cZ9pl9EraaQBeUygUsvC0+CQ4CUag7BiAxM+TRAFpncEI4RksZPMgXWPLDBwEVvb3xBsZYfiHmIL2tKwal9Eugnet19bYUq3cprx79ijArJxjf+MZ1DuhUZnG2VHoONiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5ZbIrUt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s4+DPnR8; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782745713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HnLlIWAqKGkYvHzL3qLHQR1QHqWY2RRH9mZcPadrEj8=;
	b=b5ZbIrUtJ2KPwudBIEZBC+5T1uJzJV6MXH0jNRtzanYo17gfx1U1molluh9joC2z87eE2s
	aAYoxC2kalUKGhUIpnNdnFcRfMMw3cgDTollCteWnE/qxSmKn0feKkLP/VhAXhw9kZCY/4
	P1Zz2gM08ndW8sM37VMzL2rQcEe24hQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-9WXGQtIsOD2dfnZLc5NKDA-1; Mon, 29 Jun 2026 11:08:31 -0400
X-MC-Unique: 9WXGQtIsOD2dfnZLc5NKDA-1
X-Mimecast-MFC-AGG-ID: 9WXGQtIsOD2dfnZLc5NKDA_1782745711
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-698376ecf7cso2082637a12.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782745710; x=1783350510; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnLlIWAqKGkYvHzL3qLHQR1QHqWY2RRH9mZcPadrEj8=;
        b=s4+DPnR83b0302ZQ/XbDG9FJWKm66/FR0E2Tlg9H3b/w4BTuI2Frim1fxSaFIG8ztP
         smo+AVNGR2y9gq2sZJHoFVpRho5ocPMZPsmJwGD+xNvT806U8gZSwZr6ZYH4GHstRyi5
         4TeBlPCHo6UuCveZkGsP1lNtqaB1F6JTyptugqFfBpo4SGbb1tCm+7Hf/Tk2QWgbIH0v
         OrSyhPwG/r+Qivl5s0AvVzNIzlqwP+DnTHjCqR/ptzC8Tyovsb868vWwiO2YFNa9dlpS
         yYGzOpY/vY3O8rYWWe6kd8X3R0R4gnq6Eg9T8cJag66dYR1PPvEi+ovmv7ddEGiMk71K
         fekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782745710; x=1783350510;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnLlIWAqKGkYvHzL3qLHQR1QHqWY2RRH9mZcPadrEj8=;
        b=L/EJHDK6V4hZpszkvUT84ReEO7mVnDY5K3GPjfe7aQe5N4qgxsNYI6dxVLgYtMP0uZ
         5KvS6+vkb537c5XaxSoeSm9C3zEAAbp9kdsFnb/mvgLTLXEituaWakh/LDQPz8FBq0av
         Ff3TLuowKVB5KowSHSCbno+5C4YqNpgpGNq0dJ966GCdiHWiGkSqSTBEE2023M/0YGVp
         D54Cjumfv++Od9m8HEQ4Yvses2748DI2h3/vUvL0ff+UMBmfNIlMxPbej6GcAQ8TX+1e
         1NyNniJcdFlihM/yhTdWyDQdhENznxcMePjtbHoXLBRqxcxLE/Enuten+V5sBCLH/rYE
         GcRw==
X-Forwarded-Encrypted: i=1; AHgh+Rrx0vhRRpoGFwTz4AkglaUfihqa2Tdg8mGTntYS9+zBdOA4VWhWh7T5MpIkX4EGiLWdLsyyHdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdET7mhhp7qNdff8VwYvVzjuT8aqW6wTSeDujia/6+qkXQ9DpQ
	GDPCzfYUxUmfX3I+z5hJe2WMmuuVHnVfmntBhKJwAYeCc9SwRzM8709wrnNypzHMIGY4Y9Kqf3M
	Xy9R5eTvl8fY0sHJykRxmKnxrKM+lj9jQDGONRRhlYozVy/PNdgU41HwQmQ==
X-Gm-Gg: AfdE7cnuDGobMSjGWPbEr9obrarNvPphoU1iEbdCsXPiyC1VYV5vkdFFlI8QLP5fwe+
	cc6iuWWx4mi/Ow3ZmUjHBuSTLHk/MI44IfF8txa1v4sh8CfY6Q2dPtmKmigbN8V4jA3oyyppx+R
	gZs8bK9UqgrnB/WZEdV18h9mQh/4xjJXbD2Mqrg9S6xmdTTofR2Z8GNe7AuVqNTnrFpJ4bsibYY
	/bNbwJhgAPgqQoeIj1QV/b0dSSb8IdVbws/lOaNOEmIagvLNnSo6pPc9yeCSZ7N6fXvuuZFOsdh
	86ms3Rrxg3CRKw78lX7se3Qo2pO6FyVlgKJA1uKOGOPYa+SowAeUigjiOaUcyA09+sOqf3ORpe8
	sMgmfcTTlgsCukm2dosu4La3cf7jqCyWUhtBdFg==
X-Received: by 2002:a05:6402:d0e:b0:697:f70f:8238 with SMTP id 4fb4d7f45d1cf-698774b8165mr465890a12.4.1782745710468;
        Mon, 29 Jun 2026 08:08:30 -0700 (PDT)
X-Received: by 2002:a05:6402:d0e:b0:697:f70f:8238 with SMTP id 4fb4d7f45d1cf-698774b8165mr465847a12.4.1782745709965;
        Mon, 29 Jun 2026 08:08:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69848e5ebc0sm3512223a12.3.2026.06.29.08.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:08:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 639C280A267; Mon, 29 Jun 2026 17:08:27 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@kernel.org>, Avinash Duduskar
 <avinash.duduskar@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 29 Jun 2026 17:08:27 +0200
Message-ID: <87se65bd04.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.40 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302689-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,iogearbox.net];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 408CB6DC8CC

David Ahern <dsahern@kernel.org> writes:

> On 6/23/26 9:05 PM, Avinash Duduskar wrote:
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 89b36de5fdbb..e00f0392e728 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -3532,6 +3532,29 @@ union bpf_attr {
>>   *			Use the mark present in *params*->mark for the fib lookup.
>>   *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
>>   *			as it only has meaning for full lookups.
>> + *		**BPF_FIB_LOOKUP_VLAN**
>
> This flag should not be needed. Patches for vlan support were never
> submitted (I have them in some old branch). Since the vlan params are
> initialized to 0, no new flag should be needed. Besides, these are
> output parameters.

There's no enforcement from the kernel side of the parameters being
zero, though? So we do need the flag for feature detection; unless we
expect applications to do that out of band? But then we'd need a
mechanism to do that which could be... the presence of the flag in the
ENUM (and thus in BTF)? :)

-Toke


