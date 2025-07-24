Return-Path: <netdev+bounces-209866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE523B111DE
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 21:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB497AA4AA8
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 19:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FE72EE267;
	Thu, 24 Jul 2025 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KFUNw6Qr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1B213E94
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753386210; cv=none; b=Mn0rWwYLkM7qP8bKlTxxiQr31PiMNwu6KS1By0je5kY3OubIPQ/aHAZZ3SV/nB4AxyNtOYmXWN5s9EXxXkV66LXmAkbLA+O786fHxWaFFYrymQ3FUssuJBaST95rG3cqxvy7zERI+O/2g/dDqcNqc1vKjSW5rWlkxTkXfdYjfgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753386210; c=relaxed/simple;
	bh=IBYYG31UT16+uHWCzegCuJoyUxs4w93TQog9yuOlMK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g9uocxXFNJjxyT7pZv5dUe4dpRXO6FJM+41VgOCOLl4ubwatxL6w9VKEx3p53Bt6fejxD3YwnxwYSa9bPKmJUpcQJdrOU/VDIpW8z7FLf57/G+2dpv5SippqWU2BqSdMSjdIgvZi7MVYkKYTmJG0vBLBST8F0EYaX0iwZv6bAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KFUNw6Qr; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-710bbd7a9e2so13711777b3.0
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753386207; x=1753991007; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r3PFVhfgq47lCZetMS+0wcoDuFutGTPFjQ9Nhoukkk0=;
        b=KFUNw6Qr9iR08Ha2hlCaTJP4fPCLnkv5ko54WhyeyIiA2pP38HxaKkxKdQQWE6Yw+n
         N+iZELhRb869jyfksFMfQAoUQ6+BUigdt7g/TfEPg+Oy0pzYgSiEq99+jJxWKr+jguAf
         +PuL1mj+iHgG9xJsH7y1CI6UcF2gvlwt/lgcMzrLqmP+I5d6+oZKibe8FCCs9dU9e/tz
         pQrtOoGOpYllG+5ZTVNlScSxnqNoUnxgZIUZ796g72XWfCiGhKunz5TNlwx24FCPCeQu
         iABDDBUpVHssQnpbGssTyqjH6gl3+D5pTWdOTf7eIxiVibgJNhVTWzr3DCsak0T7rDci
         8LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753386207; x=1753991007;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3PFVhfgq47lCZetMS+0wcoDuFutGTPFjQ9Nhoukkk0=;
        b=ln7w0MIJaCHIJ5rZ5Cdn1BKNP8POWnOfNVRUTdv+jnM4ZEJ2XTs1rQlDoOol5xVOvR
         nzcrdVQH2cj0lJO3JKlQiuGWpM0PYdGzXTJ8VFXIkB28rtv/7W1SCBO6uOrY8p2f/D8z
         Jg7hvhKFLNMrq2UlG++uHDOKZ1tF5QUTDOoEkdh6NoMjx+tyh4OQRHWH12fYJsg6heOZ
         JBxBqOWMp6QJl1/BXNGQsJqH2i70DoR+dxJjFEvv0pEL+57odvpMH/rRRiMq7nWsIKrm
         wWFVWejjIHqIZ5s4iLOq6Grx12Tynz+5RsWon6W7z0Ir1kHbVAtJETM5AQOAJ5ONisCY
         0GOg==
X-Forwarded-Encrypted: i=1; AJvYcCVHF8fxGrktcjG2Z2HtQqP0H8XxHC3AfBHes64Th3MeWl15LllFREK+jtfrR8Kd0F1BNfX6v6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7FXgS+hPzaXNWjcA+f5ve1+bPl9/XPy+KhPbaUv3mm4Vet8ls
	ZbQMSldCGQLzLzu+M6lQtcZJa2CZ79WA2U2SyXimMb43sg7NqxkI1XGcne35CiMepj0=
X-Gm-Gg: ASbGncsIl3Jqk0ncm4W18nGhPMRTNCnXcNZsYK3MqaxUhPuHRw+hxMNKymLOnU00dp5
	I5MmHEFWT4fem8EtiT9FL2MBQlEVXLf4UgK0KipVrPnX0XAD/cC3CiLh/fm0dXFaFgALuKldrqI
	nNBazTI2G3DvSgbG7U3VAOpj+Bvhefh2IqAPiVGqmddXfbWajR/uu4Fvn0E7RDAOqUHYMyFUUuc
	UzdYYyhz0RsVv3g7+PATt1uFUXJPBPcJQMSvpifvcmc13O3asJ0KC4iD4ZPK007gpopEMeQkHb1
	HOdhawNYJ6eM0XQLPN8ux8lNqjmu7wG2T1Jmc4+nXvjVtTk0eQDaIjy7tlCifD1pLo80kcduEV8
	MzhjjPxrwCdgtbjw=
X-Google-Smtp-Source: AGHT+IGfuHEiPstTElt0iBTpfr9wbCggas01pKeXH35hn0yOBojJbtmBuREYaL06maVPnASaQAphAw==
X-Received: by 2002:a05:690c:6602:b0:70e:2168:7344 with SMTP id 00721157ae682-719b41eda51mr97024727b3.23.1753386207254;
        Thu, 24 Jul 2025 12:43:27 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:5f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719cb91e739sm5232497b3.56.2025.07.24.12.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:43:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,  bpf@vger.kernel.org,  Alexei
 Starovoitov <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,
  Arthur Fabre <arthur@arthurfabre.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Eduard Zingerman <eddyz87@gmail.com>,  Eric
 Dumazet <edumazet@google.com>,  Jesper Dangaard Brouer <hawk@kernel.org>,
  Jesse Brandeburg <jbrandeburg@cloudflare.com>,  Joanne Koong
 <joannelkoong@gmail.com>,  Lorenzo Bianconi <lorenzo@kernel.org>,  Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,  Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Enable read/write access to skb
 metadata through a dynptr
In-Reply-To: <0190e181-c592-454a-a99b-5ec361ce84e9@linux.dev> (Martin KaFai
	Lau's message of "Thu, 24 Jul 2025 08:52:04 -0700")
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
	<20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
	<20250723173038.45cbaf01@kernel.org> <87tt31x0sb.fsf@cloudflare.com>
	<0190e181-c592-454a-a99b-5ec361ce84e9@linux.dev>
Date: Thu, 24 Jul 2025 21:43:22 +0200
Message-ID: <87jz3xwf1h.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24, 2025 at 08:52 AM -07, Martin KaFai Lau wrote:
> On 7/24/25 4:53 AM, Jakub Sitnicki wrote:
>> In this series we maintain the status quo. Access metadata dynptr is
>> limited to TC BPF hook only, so we provide the same guarntees as the
>> existing __sk_buff->data_meta.
>
> The verifier tracks if the __sk_buff->data_meta is written in
> "seen_direct_write". tc_cls_act_prologue is called and that should have
> triggered skb_metadata_clear for a clone skb. Meaning, for a clone skb, I think
> __sk_buff->data_meta is read-only.
>
> bpf_dynptr_from_skb_meta can set the DYNPTR_RDONLY_BIT if the skb is a clone.

Oh that it clever. TIL. So if we end up calling:

tc_cls_act_prologue
  bpf_skb_pull_data
    bpf_try_make_writable(skb, skb_headlen(skb))
      __bpf_try_make_writable
        skb_ensure_writable
          pskb_expand_head
            skb_metadata_clear
              skb_metadata_set(skb, 0)
                skb_shinfo(skb)->meta_len = 0;

... then the metadata is not so much read-only but inaccessible for the
clone. The dynptr will reflect this state, so all seems right.

Let me see if I can capture that in a test, though.

BTW. I've wondered why pskb_expand_head doesn't just copy the metadata,
but left dealing with it till the next step. If it did, we could just
operate on a copy.


