Return-Path: <netdev+bounces-200732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DA5AE69D2
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2FF4E1DD5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9254C2E6D11;
	Tue, 24 Jun 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjdD0TwB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B804A2E62AC
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776225; cv=none; b=Wm+ife5uXxZm3W1irer49YKoh78pR7OIxc3S7izsTZvOEgMolUtjUXWdCbzp6WR4rnMNesftH26XxvMMoWTJQaJNqmtE7gTzBOOnKjRSyt892zy6MxranbUMrttIF9BCVkx2b2FfiM93t7YcmDo24NYKVFhvNCcPQ0KngV9BerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776225; c=relaxed/simple;
	bh=6r0las+/Ii+bobt18cWF8Yd39NfjYX1RuGTPL5F1ass=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qAoFcZ86OLYERJrnk96PRFFS/fa0VBTFSghm+2+ezNntplnTaoIbCCgRdDWrz4xG0Ewp/A67ylYuJlIWkPgYr9JejX2pr81bsb+h8VyVi4A+96/kB8jFl3H+ZiGoFoo0SKT6GxaLEGTG7b9O8ezjTQN19JAmKVb0uLFoXxQYy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjdD0TwB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750776221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsJFD8Xb7TNUkeNMyUpPYkjT7yFBNxg0JTSP55Zxpfs=;
	b=ZjdD0TwBv/waf+Gcdpg3c+OylPCGLvIFmQHybQ+nKl7cpZLZaW174ZXTrLBu5jYaZT0U6M
	LCcBOh9UAFAWg1VLYzb9V9TRtOXQZprUQx8iVLI6Pod6vC5SmJ+6mxUzQU+uvYqMnWH+4q
	547paOflWZbNsAVOiIaFiSQw3WjJdHQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-ItJo26GjO2GmIjtRbXdorA-1; Tue, 24 Jun 2025 10:43:40 -0400
X-MC-Unique: ItJo26GjO2GmIjtRbXdorA-1
X-Mimecast-MFC-AGG-ID: ItJo26GjO2GmIjtRbXdorA_1750776219
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-553b70a3592so2629970e87.2
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 07:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750776219; x=1751381019;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsJFD8Xb7TNUkeNMyUpPYkjT7yFBNxg0JTSP55Zxpfs=;
        b=e+DXVffEu4/MITQvSg4tD2E+hUcpM40lH47IOaGvqGRd0CZ1iS+jmD65bT2NE5+VlG
         65MoLt1TaaB/65C82+oeLadIgARxNqd6folppGHAWGm+ydYCQxwk/3g1lb5HivcOTUWf
         16xvMMlAJsqNOHVxapPIhdP9eany6Mwt5P6lZa2XQ1m6LMd6ZNhTJqdaNrYWT7t901yn
         /PwuMiXcDISBOuPJxKG9nbUiBAqGnFmxEcG2rN/JdxvP+43+GsPxkLPRchlhn6/QM/Ht
         5PFxlCPs+mBIGrfYWQoHkQMtPM3jmMfAl9Js0EPiK6r9lsxeOOkRkgSPVfj88aNIadP+
         SNAg==
X-Forwarded-Encrypted: i=1; AJvYcCVAKejOEk2tvYIV9gNPQFUdNG0if6NGbaEZ4ba47fomAmLuNAVbxZmd44XWPacgdnOuKE2PznM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4BtN3u2OzB3NAU+ymBPdFfa9YnMM9ngJS01tFUNi2cfihGCd
	sH83CqHFcsurkqbR/ICkbXGxJvcL4dFWbH5Xt86phzPoslo0thV01aAFG4/+nwExtRBtJSnBER5
	ILTghX/6wpIJsgS6XzKT1zWvB+ZyCztxUIKciXs5m/NMkIG1pKYic+Oh4OQ==
X-Gm-Gg: ASbGncufoMrK59v1bNs7wwB7gUitbxWE+fQa6xsKaNDgfq6LU9T0phh4Mp4bZVpiS7o
	QtOjIhlKETH1xvQgP+PJnc5ihIe30DKHJQa+hmJMXF4GKNOOyXBcOtQIvK91XFdKKHnDC3ccj/W
	pselu9v2m9e+gASZ2OSwmePgXZxWBVM1xack0M39RrmqhxQrijp4yyUJ0hcQtutLJNqIS+Cx/tP
	hRZAgJh4Bam2cPpRvZPzRqF9w4SIQ41A4NwhIXExWaDxwAZXzSjWAX930guNhtzyjkS4RR13JqG
	tc86w6n2eQVCJEcyTEpnLSfCvoUpMXrrXox4WF3OPF/EBUw=
X-Received: by 2002:ac2:51d5:0:b0:553:349c:646c with SMTP id 2adb3069b0e04-553e3bf2109mr4783121e87.27.1750776218739;
        Tue, 24 Jun 2025 07:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0aXMGFpRJQr9IDGvwiXOXGJUpblWAgU5bfHFxKSwW7q7amMW/E+3VuHA5u82kZnQnHCkEPw==
X-Received: by 2002:ac2:51d5:0:b0:553:349c:646c with SMTP id 2adb3069b0e04-553e3bf2109mr4783111e87.27.1750776218257;
        Tue, 24 Jun 2025 07:43:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41cdf64sm1839877e87.234.2025.06.24.07.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:43:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 178B01B37786; Tue, 24 Jun 2025 16:43:36 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, jackmanb@google.com, "jesper@cloudflare.com"
 <jesper@cloudflare.com>
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
In-Reply-To: <42E9BEA8-9B02-440F-94BF-74393827B01E@nvidia.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
 <20250623101622.GB3199@system.software.com>
 <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
 <a8d40a05-db4c-400f-839b-3c6159a1feab@redhat.com>
 <42E9BEA8-9B02-440F-94BF-74393827B01E@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 24 Jun 2025 16:43:36 +0200
Message-ID: <87o6udfbdz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zi Yan <ziy@nvidia.com> writes:

> On 23 Jun 2025, at 10:58, David Hildenbrand wrote:
>
>> On 23.06.25 13:13, Zi Yan wrote:
>>> On 23 Jun 2025, at 6:16, Byungchul Park wrote:
>>>
>>>> On Mon, Jun 23, 2025 at 11:16:43AM +0200, David Hildenbrand wrote:
>>>>> On 20.06.25 06:12, Byungchul Park wrote:
>>>>>> To simplify struct page, the effort to separate its own descriptor f=
rom
>>>>>> struct page is required and the work for page pool is on going.
>>>>>>
>>>>>> To achieve that, all the code should avoid directly accessing page p=
ool
>>>>>> members of struct page.
>>>>>>
>>>>>> Access ->pp_magic through struct netmem_desc instead of directly
>>>>>> accessing it through struct page in page_pool_page_is_pp().  Plus, m=
ove
>>>>>> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_de=
sc
>>>>>> without header dependency issue.
>>>>>>
>>>>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>>>>> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>>>>> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
>>>>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>>>>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>>>>>> ---
>>>>>>    include/linux/mm.h   | 12 ------------
>>>>>>    include/net/netmem.h | 14 ++++++++++++++
>>>>>>    mm/page_alloc.c      |  1 +
>>>>>>    3 files changed, 15 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>> index 0ef2ba0c667a..0b7f7f998085 100644
>>>>>> --- a/include/linux/mm.h
>>>>>> +++ b/include/linux/mm.h
>>>>>> @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task=
_struct *t, unsigned long status);
>>>>>>     */
>>>>>>    #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>>>>
>>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>>>> -{
>>>>>> -     return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>>>>>> -}
>>>>>> -#else
>>>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>>>> -{
>>>>>> -     return false;
>>>>>> -}
>>>>>> -#endif
>>>>>> -
>>>>>>    #endif /* _LINUX_MM_H */
>>>>>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>>>>>> index d49ed49d250b..3d1b1dfc9ba5 100644
>>>>>> --- a/include/net/netmem.h
>>>>>> +++ b/include/net/netmem.h
>>>>>> @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_co=
unt);
>>>>>>     */
>>>>>>    static_assert(sizeof(struct netmem_desc) <=3D offsetof(struct pag=
e, _refcount));
>>>>>>
>>>>>> +#ifdef CONFIG_PAGE_POOL
>>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>>> +{
>>>>>> +     struct netmem_desc *desc =3D (struct netmem_desc *)page;
>>>>>> +
>>>>>> +     return (desc->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>>>>>> +}
>>>>>> +#else
>>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>>> +{
>>>>>> +     return false;
>>>>>> +}
>>>>>> +#endif
>>>>>
>>>>> I wonder how helpful this cleanup is long-term.
>>>>>
>>>>> page_pool_page_is_pp() is only called from mm/page_alloc.c, right?
>>>>
>>>> Yes.
>>>>
>>>>> There, we want to make sure that no pagepool page is ever returned to
>>>>> the buddy.
>>>>>
>>>>> How reasonable is this sanity check to have long-term? Wouldn't we be
>>>>> able to check that on some higher-level freeing path?
>>>>>
>>>>> The reason I am commenting is that once we decouple "struct page" from
>>>>> "struct netmem_desc", we'd have to lookup here the corresponding "str=
uct
>>>>> netmem_desc".
>>>>>
>>>>> ... but at that point here (when we free the actual pages), the "stru=
ct
>>>>> netmem_desc" would likely already have been freed separately (remembe=
r:
>>>>> it will be dynamically allocated).
>>>>>
>>>>> With that in mind:
>>>>>
>>>>> 1) Is there a higher level "struct netmem_desc" freeing path where we
>>>>> could check that instead, so we don't have to cast from pages to
>>>>> netmem_desc at all.
>>>>
>>>> I also thought it's too paranoiac.  However, I thought it's other issue
>>>> than this work.  That's why I left the API as is for now, it can be go=
ne
>>>> once we get convinced the check is unnecessary in deep buddy.  Wrong?
>>>>
>>>>> 2) How valuable are these sanity checks deep in the buddy?
>>>>
>>>> That was also what I felt weird on.
>>>
>>> It seems very useful when I asked last time[1]:
>>>
>>> |> We have actually used this at Cloudflare to catch some page_pool bug=
s.
>>
>> My question is rather, whether there is some higher-level freeing path f=
or netmem_desc where we could check that instead (IOW, earlier).
>>
>> Or is it really arbitrary put_page() (IOW, we assume that many possible =
references can be held)?
>
> +Toke, who I talked about this last time.
>
> Maybe he can shed some light on it.

As others have pointed out, basically, AFAIU: Yes, pages are *supposed*
to go through a common freeing path where this check could reside, but
we've had bugs where they ended up leaking anyway, which is why this
check in MM was added in the first place.

I don't recall the specifics of *what* the bug was; +Jesper who maybe does?

-Toke


