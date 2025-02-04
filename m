Return-Path: <netdev+bounces-162427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C309A26DA2
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E6616437D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 08:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3EA206F33;
	Tue,  4 Feb 2025 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoNJ699N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D92206F25
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738659032; cv=none; b=oJ2ihsHeh7mULIscE7fHdK6raFitbclAUdfdIWSHQ18d6Qo2aCDibgo22MGENdaeJUDLfXCpveVb83vJwW+afjsc9Rx6+0oClWXOU+94/ZwEBSTERm+ML8ybWLpLHeSjZZBdi7TSIudMnGCY625AD5cBBu4nlgzo1KFCo0VFsYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738659032; c=relaxed/simple;
	bh=jgvVPlfXUEAKaQyZrjA7TsK+YgKqxZGhAZT8/h8jrKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pf5zsk1cdOxydFB5EcaWQW744xorKgoorOZUqfedONYnjJ2sfahSHPrUb7LLq4PDRZlnJ4yNRKwYaJmzwUt2kYUFwW4sqLUhELZw9BvdEoSrGLLXT2Tnt0/Xy4rOWtbEwNGZgAsCnx4CqFIhb7g9GhHW5zJl36/zL5hS91oySZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RoNJ699N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738659028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9qSL7NML3EuPhQpp+mef2GPR5n5qsRvGZBkWAGX7H4=;
	b=RoNJ699NbUFz5+mZAvD1k/wpkuC0/w5N8aPEQ6dsroytIO8TmqRN6HkAFMi9pnpRtcQCvl
	RpJqXGJSmPsdpliMs4cBztiacwgfpqYULxMkSuJscaHzfXGlG177Me+Zx8DcWa22P9HonP
	gKn9c1pyif7fO0TO5DdcomJ5/x38hMM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-B-BhhOSwMgSLCUdFVO0Rdg-1; Tue, 04 Feb 2025 03:50:27 -0500
X-MC-Unique: B-BhhOSwMgSLCUdFVO0Rdg-1
X-Mimecast-MFC-AGG-ID: B-BhhOSwMgSLCUdFVO0Rdg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361ac8b25fso273715e9.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 00:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738659026; x=1739263826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9qSL7NML3EuPhQpp+mef2GPR5n5qsRvGZBkWAGX7H4=;
        b=j0wgXcVEGBLZyIdxTlR9w6X3yesGz00DieJZHwRudhLt6KEQSl+tUsK0uChtseNry4
         VHavgS1K8OAbrEC1W+P/EAIDFwGZVbABWohP1J/AbMxvAJDhsxJM/MIjmfLgkWkOjdl8
         12juiaQSEOHrIf44vJuBzFOR1CgXQ4BambpBK+jYg/1OqzLT95ra+gf+qJJXoz6U9dHV
         LfM1iTQrthOSBJfSQ7o8siaehQ6ymUeaVfomKnKkM4umZDoMtX1jBssx/WcWpMo3ryR0
         3fCVCQQD5nw8Ox7A0WLwE7JWtGGr1Z7TkS0GsAJIrKfOKbhEpfUsNtOA8w2fpin9APxD
         FBLg==
X-Gm-Message-State: AOJu0Yy4jzMc7ieJGcL/JIWeOIcopzx3FxsYeGmuhlmSH8GHncZd4P3S
	pTubUmQg15RKwj7iZL+IBp04LFNbCTaoqSYARDoMHqcmLz0E06/Dfz9DukZU9L3jNmXZZvyWh1y
	/Vv/0dgnG9ArLhN+UyGqfMQNq3F5ubNpPJMj4bdbFjI+gz5KyeZXblA==
X-Gm-Gg: ASbGncsBJhmyaV3XlUGYaDcCvRmbkJAhRX9TbRFFtt5j1KsiOcQJAGwh+u+DW5rKW3l
	YKMDgSkDRx3XoD6zoZep/lOml8AwLDxeDHBNxs0sMmI07QFmBrK5EO6ij/xxjxxLsDvsTBTkLFT
	s6i35WWYEMK8VxZqf8fg5YY09nh2OKLFZuRiCCqe/iCd3N2mMVGUDJNe0JtoUXVvuE0cVMCHasr
	yhpsD5uSi5DdgTKN1OLt8o5qjkQYtfZoP1AssMRt1SYZcFOuUiysvIuK1LaAvcZ6jKT2ajyU5jr
	K3A4sL6CllWdZ2zbyQJ0XiuauL7RfLtnmd4=
X-Received: by 2002:a05:600c:4e01:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-438dc3a3e77mr213802985e9.3.1738659026020;
        Tue, 04 Feb 2025 00:50:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7SLQ1sK3vW3NXrtreUu9kV0H6fv+SAMXCCiDkFW3k5TO3AN47pYDXfvJPk2ktnhV2Ks0ceQ==
X-Received: by 2002:a05:600c:4e01:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-438dc3a3e77mr213802825e9.3.1738659025696;
        Tue, 04 Feb 2025 00:50:25 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc1315esm213997235e9.6.2025.02.04.00.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 00:50:25 -0800 (PST)
Message-ID: <52365045-c771-412a-9232-70e80e26c34f@redhat.com>
Date: Tue, 4 Feb 2025 09:50:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-9-ouster@cs.stanford.edu>
 <530c3a8c-fa5b-4fbe-9200-6e62353ebeaf@redhat.com>
 <CAGXJAmya3xU69ghKO10SZz4sh48CyBgBsF7AaV1OOCRyVPr0Nw@mail.gmail.com>
 <991b5ad9-57cf-4e1d-8e01-9d0639fa4e49@redhat.com>
 <CAGXJAmxfkmKg4NqHd9eU94Y2hCd4F9WJ2sOyCU1pPnppVhju=A@mail.gmail.com>
 <7b05dc31-e00f-497e-945f-2964ff00969f@redhat.com>
 <CAGXJAmyNPhA-6L0jv8AT9_xaxM81k+8nD5H+wtj=UN84PB_KnA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmyNPhA-6L0jv8AT9_xaxM81k+8nD5H+wtj=UN84PB_KnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/4/25 12:33 AM, John Ousterhout wrote:
> On Mon, Feb 3, 2025 at 1:12 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> I don't see where/how the SO_HOMA_RCVBUF max value is somehow bounded?!?
>> It looks like the user-space could pick an arbitrary large value for it.
> 
> That's right; is there anything to be gained by limiting it? This is
> simply mmapped memory in the user address space. Aren't applications
> allowed to allocate as much memory as they like? If so, why shouldn't
> they be able to use that memory for incoming buffers if they choose?

If unprivileged applications could use unlimited amount of kernel
memory, they could hurt the whole system stability, possibly causing
functional issue of core kernel due to ENOMEM.

The we always try to bound/put limits on amount of kernel memory
user-space application can use.

>> SO_RCVBUF and SO_SNDBUF are expected to apply to any kind of socket,
>> see man 7 sockets. Exceptions should be at least documented, but we need
>> some way to limit memory usage in both directions.
> 
> The expectations around these limits are based on an unstated (and
> probably unconscious) assumption of a TCP-like streaming protocol.

Actually TCP can use it's own, separated, limits, see:
net.ipv4.tcp_rmem, net.ipv4.tcp_wmem:

https://elixir.bootlin.com/linux/v6.13.1/source/Documentation/networking/ip-sysctl.rst#L719
https://elixir.bootlin.com/linux/v6.13.1/source/Documentation/networking/ip-sysctl.rst#L719

> RPCs are different. For example, there is no one value of rmem_default
> or rmem_max that will work for both TCP and Homa. On my system, these
> values are both around 200 KB, which seems fine for TCP, but that's
> not even enough for a single full-size RPC in Homa, and Homa apps need
> to have several active RPCs at a time. Thus it doesn't make sense to
> use SO_RCVBUF and SO_SNDBUF for both Homa and TCP; their needs are too
> different.

Specific, per protocols limits are allowed, but should be there and
documented.

>> Fine tuning controls and sysctls could land later, but the basic
>> constraints should IMHO be there from the beginning.
> 
> OK. I think that SO_HOMA_RCVBUF takes care of RX buffer space. 

We need some way to allow the admin to bound the SO_HOMA_RCVBUF max value.

> For TX, what's the simplest scheme that you would be comfortable with? For
> example, if I cap the number of outstanding RPCs per socket, will that
> be enough for now?

Usually the bounds are expressed in bytes. How complex would be adding
wmem accounting?

/P


