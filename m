Return-Path: <netdev+bounces-269439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOEKJfLwu2nkqQIAu9opvQ
	(envelope-from <netdev+bounces-269439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:49:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5ED2CB594
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21EE9312D30C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB83CFF5A;
	Thu, 19 Mar 2026 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4kIXGwd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQDjJHc+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEE3BE15D
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924249; cv=none; b=QJDh+gqxImJFcmpEjmygdC68h4kwrOiOuM7tq5gSuhOkNElvvgMXLFXg62Bz8d+TCN7ml/tszBvVySKZuVFRjkxwCCk+7EXVRcP7iOwcrZ1gbeJ6DA+B51nH5nvmJ7Novv00LLQfRqJO++SUwimJFVdNdtcS4o4uExMUysVLgAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924249; c=relaxed/simple;
	bh=Hqvg7xhMst5DndB/D8ak/6M3aygYH5XzQLjkv0TtWuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DN4tlJVBYzPlBUQTS6DvSii+3EEZKRuPyKlwaGjOwmCQMDMPmLRdp8V1f7zq5WbbiGyumSsAEbaD0eqRi4V9Wz/EulB8K2SMNwiW7cHM6mYDY6Vy8XQMVNh8zdHEhXnvPaz5pz0qN8SPOGLUhMhYTHB6irac5lqqn0dU9Hj1ooM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4kIXGwd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQDjJHc+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773924247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nY70eJF99QytEX7DipnKVmL+suwwJ5IWXmC9xLflxuQ=;
	b=F4kIXGwdIkqEwIMKU8P0n6K+XIz5Q0TioG92rvGup3yzkqWKeCuiI62XPcLiwRnjAlc9Ts
	XfOIch+bvTM+r+Drg3H/MPW3IRV8t4F/xu8vERwpzeMcfmhY6KthjdMbe87SDl0m6XWAjq
	S5XeObgCIQYKIu8RFtdTxLMhV5O+WfQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-1AsHxA6hNi6kehn7_NeRXw-1; Thu, 19 Mar 2026 08:44:04 -0400
X-MC-Unique: 1AsHxA6hNi6kehn7_NeRXw-1
X-Mimecast-MFC-AGG-ID: 1AsHxA6hNi6kehn7_NeRXw_1773924243
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4852ccff333so8016975e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773924243; x=1774529043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nY70eJF99QytEX7DipnKVmL+suwwJ5IWXmC9xLflxuQ=;
        b=jQDjJHc+55/UIshziBfu7CGJyvhuW7F9H28OHJJkmH4fYoEAg/WyW3kn3YI6i0zqJI
         k7ue/a1Bx9NSONyxi2nKJnpEBjjFqZ+XGA3YQx2gECqyfL/t/vRCfeU4oCXWpguePAPH
         AQ4Ec03MrBng40P0tc8H/ehVXWbobnqNwkjLZcqWDZfr/KoEYfGiPScztIOuvHMNJple
         JXi4jDtvpB68A9tXXfkvS5iG5I0a7OHOXUcKkg9L5g/ettQDDzHv3IJnYtkioAWVdNbY
         8w78Gjvj/rzliR9cTOx2anhhZ7VcU2FdPs8kosVb7BpDYFYOAQurS6GwrcYb+yjj4aww
         Nb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773924243; x=1774529043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nY70eJF99QytEX7DipnKVmL+suwwJ5IWXmC9xLflxuQ=;
        b=hBS1x2G83C/tqsUO/rHHsuhHetciRGwOnpsgHByNQ1vxlZptQB9ixGGB5k961dsqa9
         GCLImk01sasD1nyg5VwUlEAKpvM5iaVj36nJLcu15joER+7fNLu4pNre1sE5+6gPWXzc
         AFchE+wPAaJdtoy0twwEUCQ/c5itlTIHrlWmnJglzxokzhtlGyHHCOLlX1glVpEO8/fW
         JfiNG8I2aSRnEcl9IDMBwj96NEZRgBnhfTsAq3slDrIFBQa8rimUV2gfXY0j8VZJ5rTf
         bRzuJkM1FrmbwQ1LIds8yEcPVAPl1k/FM7Lq4UaiNVyt2NfQgrCHyVLBifDczFaLWmzn
         t7Fw==
X-Gm-Message-State: AOJu0YwQeOQfdhvaofi0u0DGBdivSHtb8g6HFcoJQipjDi2Jbt1shW8R
	RdNSmFg4c721BTHaEqdq/vJy3BH5jLW5ovY7u8QWBNXYQ1mxucz0ezwolCslws9k+hM8iy97RKU
	nJ5lx8Aqc03b0Fi6MdwJyFCjQ/XsMrqTK5wrpnuhdIxMQ1spQEZz8rQaATw==
X-Gm-Gg: ATEYQzxx2UvSdnZZbfN/94yFpetMHFiaojVAxQKAhzhfdVuckNfN/E/K9ab1Tdjh9cM
	+o2KnBzQGtkr4otT5Kzgr3H8EOOZPQh3a0Qx/rfcTQdotc9gdtvWK2AwKVT8ilv4tPvw93ALX8q
	T+8+FTAZDXcdt+C5VWKLSZtmbK4Nt4f7WzFvKL29O4WAY6rIHGcOO4pcoMqW1FmWplkB6eKp3ih
	s7rpV06zdmmDkhXxEbIY2+k6k/K6ZlujBwAHUj5NPA2e9X3F2Hzk6j0/MHPaaYo3s0fDbc9ma5r
	fEs89lYEFYfNYSi7ZzCCu7CjngmQM67OKhfauNkExg7iHhlzHNeJYPei5N7BKcHenCuCu3We4f5
	JNumSzZcGcgIiW0KOf5VXu4txM1zPjAWOU33EjVhG5AkgJ3opDH+9HjZD
X-Received: by 2002:a05:600c:1e8c:b0:485:3d43:7c9a with SMTP id 5b1f17b1804b1-486f456fe06mr122764055e9.25.1773924243035;
        Thu, 19 Mar 2026 05:44:03 -0700 (PDT)
X-Received: by 2002:a05:600c:1e8c:b0:485:3d43:7c9a with SMTP id 5b1f17b1804b1-486f456fe06mr122763715e9.25.1773924242570;
        Thu, 19 Mar 2026 05:44:02 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518495aasm15971859f8f.3.2026.03.19.05.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 05:44:01 -0700 (PDT)
Message-ID: <258f99ac-bd34-4d14-8271-1266b9aba6f8@redhat.com>
Date: Thu, 19 Mar 2026 13:44:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/ipv6: mcast: fix circular locking dependency
 in __ipv6_dev_mc_inc()
To: Jakub Kicinski <kuba@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Josef Bacik <josef@toxicpanda.com>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+afbcf622635e98bf40d2@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Taehee Yoo <ap420073@gmail.com>, linux-kernel@vger.kernel.org,
 nbd@other.debian.org
References: <20260317111208.62667-1-jiayuan.chen@linux.dev>
 <20260318181536.47ed9fd1@kernel.org>
 <f877e139-2da9-49d9-93bf-9b4155d687a7@linux.dev>
 <20260318202649.004d33fd@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260318202649.004d33fd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,syzkaller.appspotmail.com,davemloft.net,kernel.org,google.com,gmail.com,other.debian.org];
	TAGGED_FROM(0.00)[bounces-269439-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev,afbcf622635e98bf40d2];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA5ED2CB594
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adding Josef.

On 3/19/26 4:26 AM, Jakub Kicinski wrote:
> On Thu, 19 Mar 2026 11:04:24 +0800 Jiayuan Chen wrote:
>>>> Split mca_alloc() into mca_alloc() + mca_init(): mca_alloc() does the
>>>> GFP_KERNEL allocation before mc_lock, mca_init() initializes under
>>>> mc_lock. If the address already exists, the pre-allocated memory is
>>>> simply freed. Also move inet6_ifmcaddr_notify() outside mc_lock since
>>>> it also does GFP_KERNEL allocation.  
>>> Moving the allocation seems fine, but also having to move the
>>> notification, potentially letting the notification go out of order
>>> makes me wonder if we aren't better off adding helpers for taking this
>>> lock which also call memalloc_noio_{save,restore} ?  
>> Yeah, using memalloc_noio helpers is simpler. I checked and there
>> are about 18 places taking mc_lock, so having a common mc_lock()/mc_unlock()
>> wrapper that does the noio save/restore covers them all (if necessary).
>>
>> The only thing that feels a bit odd is using memalloc_noio in the networking
>> subsystem. It makes sense in block/fs to protect itself from recursion.
> 
> Totally agree that it feels a bit odd that we have to worry about IO,
> but unless we can figure out a way to prevent nbd sockets from getting
> here all our solutions are dealing with noio in networking code :(
> IMHO it's better to acknowledge this with the explicit memalloc_noio 
> so future developers don't break things again with a mis-placed
> allocation.

I think a problem here is that the nbd socket is still exposed to
user-space, while in use by the block device. I fear that the more
syzkaller will learn new tricks, the more we will have to had strange
noio all around the networking code.

I *think* we could prevent this kind of races with something alike the
following:
- nbd sets a DOIO sk flag on the sockets it uses.
- the socket layer prevents socketopts()/ioctl() entirely on DOIO sk

I'm not sure if that could break nbd users, but allowing the user-space
to mess with the socket used for backing a block device looks very
dangerous.

/P


