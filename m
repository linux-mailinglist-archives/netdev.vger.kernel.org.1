Return-Path: <netdev+bounces-256223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF7YLzfFgWnZJgMAu9opvQ
	(envelope-from <netdev+bounces-256223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:51:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65953D71E4
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D18453002325
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2D8395243;
	Tue,  3 Feb 2026 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RN907+dU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nx4qLE23"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B130FF1E
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112302; cv=none; b=mgLd2tGivFbUG+8dexc+3MlP5myXB4WMLnLlTJ4kXTYLlPA0DPyFZ7Qzw1c0MX6XGJdFG5EP4dQn3iWTIBBXwIhtF0mU9RFI7IO14d5cIvhG5bXqpV6MPfspaKMXRy3iTo4v5GfpcbdU4CeQXWlwxz3YoUJbqAko7sZo/PNzaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112302; c=relaxed/simple;
	bh=Na9VmUAYi2xL9rYBi8+/z8bfRDKtXlBlY2JPK8OYIfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ls8HgI3uQH3BYbxkBcCDzPVHk501ByUNAoZkTnV7H+io33riQRaVofi57Z/2teZZZraDa1f91tLIHCAYv529znQcUKaF5PIPlugdCgtGqk+GdI2dyJ397y7C5Nqgoti2lHDWffQ5Aaz+ZZXN/08UuCGHGLmF3OT7JtqkZ6L0+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RN907+dU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nx4qLE23; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770112300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMxAdkWWjfm1De2c23l/RXOovfET1zRzYX6ivHDml3o=;
	b=RN907+dU7cGIklzHdRivVh53fVdyZY/2kt/1yp9RwKBbfLzB87NI1KqzkERLpCebITIyeJ
	VI2LTIpuKjvjChQ7IVUSNH3TAxK3T51vC1IOhuFt+iECNzrhKhsG/gi2D1N1VC9T0r51w2
	AcVEWvLF/GAPv32R023YaYlYELW3qAc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-8u5Ka4tLP4udwxO6t2PU3g-1; Tue, 03 Feb 2026 04:51:39 -0500
X-MC-Unique: 8u5Ka4tLP4udwxO6t2PU3g-1
X-Mimecast-MFC-AGG-ID: 8u5Ka4tLP4udwxO6t2PU3g_1770112298
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-482eec44485so24630355e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 01:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770112298; x=1770717098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMxAdkWWjfm1De2c23l/RXOovfET1zRzYX6ivHDml3o=;
        b=nx4qLE23ZRGmE9BviOuXslTq4/1gDJvTMjFKozyw0UJn82bs5lqH4MBbj7vw6RJ9d8
         ua9c+ROpx7jsNrWJhkppTz8fYMjpPYxIvoG569xF7zp86jhis0/CMYibU2eygeC12WV6
         1BV0OyPsme0A+WmZhuCy5Vlq7jfPP6sGDTq1MYCNFzeWAp35kmWl+MSCAoejleYlYq64
         gFsIRQGCjQyBNPSe96NgJqeYZs54YrA1DORJNI2ZtfWJNy1cafDkN26Yj5AvF39twZxg
         bT1NpzGAO9NUm8NvDtTVO0nUB/6qnAZP0vCy5JmHsqeFXg0bvt+pMe/hags19Y3TsA0w
         BGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112298; x=1770717098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMxAdkWWjfm1De2c23l/RXOovfET1zRzYX6ivHDml3o=;
        b=Jwzq2JEEJXeWhmbVMCyTkJtBDbSczd4z/ElgYE6pGDw8myf6Qv+tVzBgTjAoTtEIK2
         K90qwExZj3cf6bNemifsXXm0ZUV3akYN4ufPnTRvaF+MtJdWf5vzayaTzjuzwhF27cu9
         TORRW5Qmx4Jwx1BDj1LIvJcxzJb/4+Lk4jjpcE9Q/70XQZL2n+ye8ewSwhdfvBYvWzM8
         sELpU0p0WEtp/wtbWVy+d01O4LJLAvDVMZt2XDz4kEL3ErooLG1HtTpCFuBYdzFh5WRY
         UANpjRiu6yFMpsIS/Ha5AZdgtkwke4qWFZzqGKL7AvuYNl/aJqtsTfupfYGPNbihTVXy
         /2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUg2dzGOu0QXN0/nyBXPEKpiDCi/AxrfT87AI3mRIEmJwH3Hb+w5LV0IjCCcmf3OXw/ye2lB4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4bzwcJrtnE871IU2gXm+ZydzFm+LQxnVSIzV3zT/PtHueXOA
	OeXzQklAHPlo4zhgTrgguThqzxlPVvQ+9I7So87jj4eCVGYz7HKZkRDESulwz35BouNGEy6cztm
	m9ronqgoVNVBHZjCYPeQl2+1QuG+GjE+kxBJRRfBUy1Ng5Zq83ECoK/nJJA==
X-Gm-Gg: AZuq6aL9OV4+9D5Yuq+NEQoCoy6gdLHkHhFqXmyL1bJcHYs4ZFJYM3czzQRlaJksAFE
	DwZzzU7XS3QjqIpEqHmfGzNzmZYFXaSaH+2anrvKRfMefqu/YKUyqLGIcIx3H7XjgXsaYQJr+4C
	dJ3gapFctEhhyX/I/DsM0ZCnfmUUkgtlMGDIT1G39NLock/YQ4LQzcBbiCzV9eM51BGQXZPXlK8
	O3RUTw8D0uyJcn+gYh0aN0VMC5qy98Wnk6lgEmTmi/sAvWqXKQvKQfZtOBlv4aZEUiNeEtQaTnN
	K/2KaFBmldR0xBi1ZfJ5QNNeq7/lLHrbw+24NuJrDkYwB16KvBXVLLEZ6++FrK5hE4lvuONzl+O
	TfE8WWfShx3o=
X-Received: by 2002:a05:600c:6092:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-482db45441fmr204624385e9.12.1770112297803;
        Tue, 03 Feb 2026 01:51:37 -0800 (PST)
X-Received: by 2002:a05:600c:6092:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-482db45441fmr204624095e9.12.1770112297398;
        Tue, 03 Feb 2026 01:51:37 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e04d168bsm114343095e9.6.2026.02.03.01.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 01:51:36 -0800 (PST)
Message-ID: <4a029386-a03d-41d0-aaf6-0d5e7a6af389@redhat.com>
Date: Tue, 3 Feb 2026 10:51:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/12] BIG TCP without HBH in IPv6
To: Alice Mikityanska <alice.projects@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 netdev@vger.kernel.org, Alice Mikityanska <alice@isovalent.com>
References: <20260203085942.2477583-1-alice.projects@fastmail.im>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260203085942.2477583-1-alice.projects@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256223-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,isovalent.com:email]
X-Rspamd-Queue-Id: 65953D71E4
X-Rspamd-Action: no action

On 2/3/26 9:59 AM, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> Resubmitting to add one more patch for bng_en. No other changes in code.
> 
> This series is part 1 of "BIG TCP for UDP tunnels". Due to the number of
> patches, I'm splitting it into two logical parts:
> 
> * Remove hop-by-hop header for BIG TCP IPv6 to align with BIG TCP IPv4.
> * Fix up things that prevent BIG TCP from working with UDP tunnels.
> 
> The current BIG TCP IPv6 code inserts a hop-by-hop extension header with
> 32-bit length of the packet. When the packet is encapsulated, and either
> the outer or the inner protocol is IPv6, or both are IPv6, there will be
> 1 or 2 HBH headers that need to be dealt with. The issues that arise:
> 
> 1. The drivers don't strip it, and they'd all need to know the structure
> of each tunnel protocol in order to strip it correctly, also taking into
> account all combinations of IPv4/IPv6 inner/outer protocols.
> 
> 2. Even if (1) is implemented, it would be an additional performance
> penalty per aggregated packet.
> 
> 3. The skb_gso_validate_network_len check is skipped in
> ip6_finish_output_gso when IP6SKB_FAKEJUMBO is set, but it seems that it
> would make sense to do the actual validation, just taking into account
> the length of the HBH header. When the support for tunnels is added, it
> becomes trickier, because there may be one or two HBH headers, depending
> on whether it's IPv6 in IPv6 or not.
> 
> At the same time, having an HBH header to store the 32-bit length is not
> strictly necessary, as BIG TCP IPv4 doesn't do anything like this and
> just restores the length from skb->len. The same thing can be done for
> BIG TCP IPv6. Removing HBH from BIG TCP would allow to simplify the
> implementation significantly, and align it with BIG TCP IPv4, which has
> been a long-standing goal.
> 
> v1: https://lore.kernel.org/netdev/20250923134742.1399800-1-maxtram95@gmail.com/
> 
> v2: https://lore.kernel.org/netdev/20260113212655.116122-1-alice.kernel@fastmail.im/
> 
> v2 changes:
> 
> Split the series into two parts. Address the review comments in part 2
> (details follow with part 2).
> 
> v3: https://lore.kernel.org/netdev/20260202192338.2373930-1-alice.projects@fastmail.im/
> 
> v3 changes:
> 
> No code changes. Added Paolo's ACK. Tcpdump patches have been merged and
> unblocked the series:
> 
> https://github.com/the-tcpdump-group/tcpdump/pull/1329
> 
> v4 changes:
> 
> Added one more patch for bng_en, because it started using
> ipv6_hopopt_jumbo_remove in the meanwhile. Added Eric's Reviewed-by.

It's a pity you resubmitted before the 24h grace period without any
request to do so. That usually causes a request to wait for 1w before
the next revision.

Moreover the current one does not apply cleanly to net-next.

Still I think it would be for the better to be able to include this
series in the upcoming the merge window, and I guess I'm not alone with
such hope.

So please wait at least 48h (be accurate about the time) before the next
revision.

Thanks,

Paolo

p.s. this is my (very lenient) take, other maintainers could ask for a
different/longer pause.


