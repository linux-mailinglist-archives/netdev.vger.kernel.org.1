Return-Path: <netdev+bounces-261401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ9yKlZroGk3jgQAu9opvQ
	(envelope-from <netdev+bounces-261401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:48:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D6D1A912F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BFD231BC67E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7BF3EFD36;
	Thu, 26 Feb 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju3bCLU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1883EFD10
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119894; cv=none; b=FNztiwtFcMh1G8gqo2LHs7yOEQLYkjYeZwuPT06aMrbsj6jrteUYjA9YMEuNm1/XX4ADLWbrTxj1L9oMCn1BLL87zlFPDN1CQ99m6F9WzPbXrz+PqoZj94utIqmNsXvALTOU4NM1KmQzNGNjj8O4EqdbRwnQc9a4IDpASHzn/1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119894; c=relaxed/simple;
	bh=BVB6qOyRBxMNYsiHGWpKXsOom98dxP4uy87qhLCgd08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xi9crRc3Ys4/7Ld6lBdTa51dCu9WCGnwLzo9iN9thjXjmeK4WFKOdLv9v4KEwzvCKrR1oYk1SspRGTbAC87OdigGjwpw+YpgH715vtS+CU4e10/D5GcIIAOrHQGKRfWrVaHAXw+fxFIJ5GJapbFaAICI4gRrMV6dZWVQ5Z9eqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju3bCLU+; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6774d63d2e0so424859eaf.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 07:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772119892; x=1772724692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7zyMJZ8Es71niz9QrP8bV/oTWJNPw8YbTwYsxXMHZJQ=;
        b=ju3bCLU+YzVnVYICJp/WV4fI3yJBB39rUW/NKiMHnJeAbaD6jmm5mw7/Pj/UGJFVrE
         lcua978ix3xc8IclPbdRhOn//H0wib7mHsQcEZZMyGB1Omc4lvCtI8Bu8ycBWTffm+tu
         R33cYw4fQy65MMVUT+aAd1qUwsDhg3lJaAS1B+wJRmh5qsyAW0A3Rr0GXGFYCSc7Z+Xp
         Qp0ApXRzDGPpZalfWKB8xdPe2Y/26XlV15uRxuY7DOYucFvVdjn7xW79LxbTh8IpyfzE
         1aM1+TDFhGFP65h2IANavyn8ku0nqnnt075A8nqhDx1vtZ3Z8DuVKUOiu9Ef8CjpM9Pt
         qbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119892; x=1772724692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zyMJZ8Es71niz9QrP8bV/oTWJNPw8YbTwYsxXMHZJQ=;
        b=mVigBf0zu9jl0Og1zuyyerl9XMQsurP2WDK9i7l1Cz9bl/ar8iDIlq1IjjJv67x28Q
         eUqgxe4Fd7HnLR5obfVq/UIPQwYaTDb53gHfACRfjoXPFMzmil2gUGvHvOYTnw2ToUCj
         lfW/yYmWYJsF+XOyvLMFzd9U9U0WZ1rqdIbQvNln3ielWS0YfTFtN2Il2UNGV3XzeOkA
         f0VdlVfVLtEOheyKz6dVHqX8VU1+KFYK9BVxgyePiYTW37qsEPLPbZL33piNhPvok8Aj
         4pfHdyhHRh6SHqPGGjYOrHayXCFD79ZYMFz2Tp6wIAESxMCOVbksUkiGffFap07RK4ml
         iW/g==
X-Forwarded-Encrypted: i=1; AJvYcCU9rlJJSUsN0yQ9NE9YkvsPAq6m9i8IIcEGTmkBEb7ijVORqsLO5j3n6oRU1GtTPlgvfKTGPtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4k+fGaw96ocI+YCR8br0CQ0U+87KKt9ZANl2ah3lAtJmi2L4
	1LmviQkU/d3B23018mdpQl9vVacZmVb+bzs0gZBC/6TMqe/Kyohjg5Xh
X-Gm-Gg: ATEYQzx/+M5s+ld2c6rJHkn995X6NwWXHjZ/JNuWXBUto15wDIia+AvA6itDd/6QgKz
	TcqGVJDzp4cDk3yADFyAQUiq9diWbj6Mf+1wnAo9bve5/OeGCL3ieAZyMtGcP4xc6WZnkZgxyrG
	yAyymIIN7YACigN0SDYe+li/mYHJJKVApl+GNlflnCxWNRQBmp+JdwT7xSj7URzUxKTEGIj8HF+
	n5khYrC3JbEwzLRoVO+i167eRNFkGi9ro/90ThxsjsMZO7AKp93LHMmfkGdaAH+z3Uat/8LnQZ3
	6rYbPBk6vo/Gu1wnvy8X+gRRVEfgucSJKj2doKiphQpLgcMBZJISGQsGnV6p4eJGSkSWt7ea0VM
	tc//RRwr/LHQ/63jgdGBguWqQNDlhwyfB/JqZJlxToOkIiBxU5TCWdjyu+wYFnXFuQcpsyhRyTG
	DsAmcDF6miFmz2xCBBEZpzVdGCOXwNU5Rz7awfxcIvdsNx5YUYTLQPg4ybtRpI1I9rzOnkZLQyB
	9DT4ybgjgDmilkZ0Q==
X-Received: by 2002:a4a:e903:0:b0:679:dd71:db87 with SMTP id 006d021491bc7-679ef7faeb5mr2335897eaf.7.1772119891882;
        Thu, 26 Feb 2026 07:31:31 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:481e:870c:b200:7ebe? ([2601:282:1e02:1040:481e:870c:b200:7ebe])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-679f2be9ab7sm1672515eaf.4.2026.02.26.07.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 07:31:31 -0800 (PST)
Message-ID: <b100157c-7486-41f5-83b1-b394b181da27@gmail.com>
Date: Thu, 26 Feb 2026 08:31:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 6/9] bpf: fib_lookup: Honor oif in IPv6
 output route lookups
Content-Language: en-US
To: bot+bpf-ci@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260226080003.524935-7-idosch@nvidia.com>
 <9923d7a71f5623f84db40fa20cf3fb4e8625fc5f2661c4584dfa9237c2d98bcb@mail.kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <9923d7a71f5623f84db40fa20cf3fb4e8625fc5f2661c4584dfa9237c2d98bcb@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,nvidia.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261401-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44D6D1A912F
X-Rspamd-Action: no action

On 2/26/26 1:41 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 0d5d5a17acb2..e92552b139b1 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -6255,6 +6255,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>>  	if (flags & BPF_FIB_LOOKUP_OUTPUT) {
>>  		fl6.flowi6_iif = 1;
>>  		oif = fl6.flowi6_oif = params->ifindex;
>> +		strict = RT6_LOOKUP_F_IFACE;
>>  	} else {
> 
> The fix itself looks correct. Since this addresses a bug that has been
> present since the original bpf_fib_lookup helper was introduced, should
> this carry a Fixes tag?
> 
> Fixes: 87f5fc7e48dd ("bpf: Provide helper to do forwarding lookups in kernel FIB table")

+1. I would consider this a bug fix.

