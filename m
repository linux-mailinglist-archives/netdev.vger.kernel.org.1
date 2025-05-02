Return-Path: <netdev+bounces-187466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89E7AA7424
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 15:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3754C032D
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348A414286;
	Fri,  2 May 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPqrrk2Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFE2BCF5
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193694; cv=none; b=IKScwcJsZiaWMo6VvcMNbvTAnXLp62B3xzVbMMLybPP35+lGF8jLdL7O7A+R3DrIt7AzkMkTwdGCrHDwkIohs6xtQ+PONDjOGqqrA4I6k3iRD7kwJWXDf9OwCY4D+LzJGyeixoIJ4wkFw5iW3XozKnjhBVc19h+gzvfn5g8Ym+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193694; c=relaxed/simple;
	bh=RxD2GiH44A6aAvae0Om5nB4ykO13/M4F+cC2dWGeoy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=li5167Nwhik5llnB2jSkdNYJRoYHdNgl3hHF74jtW3aDLrWzcXQ1onKddG3L4PWW9/QiYDGLfOpqTKo0Sl+Aa4/nj3bE1PBPWIaQuoW42UJNa8E1efVwZKtod7efFP+1MtCvYZhAlVX/uWSBkM/ELD+vZvIE+cQ1quFrsHq9Ebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPqrrk2Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746193691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rIHUlHPNuws4ahhkJX3gHKx/A6sb43ud+djezBxLvdc=;
	b=hPqrrk2YlXXAythGToYrhJJx4Rbp238MM5FSNWpfVbNm9Hh9sG1k48mdJUEvwEebvsZsdP
	UOB0JlGOzHCT+z49INCfoRpbClBAT0DYq3TQgVklF7/libOVBrSGYAmiax7dy9vudYWDaZ
	g/XI127x/bHnrLcQBeDubo3YfnkGQ2w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-PbvwGHvGN6WVN9TK_oukag-1; Fri, 02 May 2025 09:48:10 -0400
X-MC-Unique: PbvwGHvGN6WVN9TK_oukag-1
X-Mimecast-MFC-AGG-ID: PbvwGHvGN6WVN9TK_oukag_1746193689
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43947a0919aso13171105e9.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 06:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746193689; x=1746798489;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rIHUlHPNuws4ahhkJX3gHKx/A6sb43ud+djezBxLvdc=;
        b=KwEgUv0PIaeXlzqHc69vzeCgOhDDaGIfVcsKmrHk/Jvf/4Ula+qRY1L4mGbhkKfJmU
         Mvb78el52GDfzZUjtMADkBd+KbztEa0rfD8vLPEjKFl5i0T68KOwfWi5jCvVwMjFGjtF
         mbbW7Dau819nooQA7y8ctr+7LAhMdJSrO/2Qk+jaWVSKue7fuk9B37TMMJF1pPlmdvaC
         gj22Z4MYlvHOuvV4w8pr2N+Y7HfMLW0utaFS9Aqrqe/4xkolNFp2+12Uz0qqNvTcEiPn
         olcL81OzdjtXdg13fcdcNo2FZkPL6JfOt3CNIiT9dNPXS5hulEbmphAAWB3XWdATa18J
         QS+A==
X-Forwarded-Encrypted: i=1; AJvYcCXg7l137zeVV3ngzetrUGWlqhXRyW/nR8ospfJUAc4mDoTdYjjWPq/OxBWEySg2W7VNauiRP8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVJME90OAMf2ilDqzivzTw3rh4kObaJWV13SG6VQKRY9AFC7K
	JHeGkW0fvqZ+aFwseSz4of9vLctpF71oBQdz7K15Mif8s17LFI5a7BZ0beln6+E/F/ReiGS8kv8
	si7ebMZtZ/sOA1IaUspgZrVbKvXOo/UB2I6TUGdljvC7VENiknnp0Hw==
X-Gm-Gg: ASbGncsX19oH13LaicoE4B6tFhrXPa22vTv+is0nCpytGuS+NMMJsiz1g1pmq4x3avR
	9oclPs5xVUvHl1k+VEiABWSryC5H23YSNByj5iM1zirD/QzkTQ7NeoasCVFCou2/fR/pUdPudqw
	mFGLxz5XuPU1at03mO0SVeHWSy0HQtOoCGW6elTxFFkmrsHE0xw2EzUEvdGbMa+icDYdo+Qszeh
	HpVfhDRCFOsAdITuifzSSpAAC6TitOs9fc7Dt6dSDh98eKwAU5q0bHH9jgPmf4TMgzxaAvABxDE
	sOf9S8zMvGoseIyCl91GQG/b3ATUkdAEvpJ2agC6FfqvdPN+SssP1E6MgwjP7XBjNi1V8EZeN7f
	74OjFq0iDH+984QHGFT7xBn04H2xw/0IWBKD/LTg=
X-Received: by 2002:a05:600c:3103:b0:43c:fc0c:7f33 with SMTP id 5b1f17b1804b1-441bbe98f12mr23243545e9.2.1746193688993;
        Fri, 02 May 2025 06:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXpwkAUKwiM2ytRsJRXLfeiMeDMYCqb6On7IWucupuTGME4yUAKPd2AEYNmNttv68VW1aWHQ==
X-Received: by 2002:a05:600c:3103:b0:43c:fc0c:7f33 with SMTP id 5b1f17b1804b1-441bbe98f12mr23243315e9.2.1746193688662;
        Fri, 02 May 2025 06:48:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:d600:afc5:4312:176f:3fb0? (p200300cbc713d600afc54312176f3fb0.dip0.t-ipconnect.de. [2003:cb:c713:d600:afc5:4312:176f:3fb0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aed5e8sm90516285e9.16.2025.05.02.06.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 06:48:07 -0700 (PDT)
Message-ID: <63d93fc8-874f-4620-8df3-160cb24edc0c@redhat.com>
Date: Fri, 2 May 2025 15:48:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MSG_ZEROCOPY and the O_DIRECT vs fork() race
To: David Howells <dhowells@redhat.com>, Andrew Lunn <andrew@lunn.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 willy@infradead.org, netdev@vger.kernel.org, linux-mm@kvack.org
References: <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
 <1015189.1746187621@warthog.procyon.org.uk>
 <1021352.1746193306@warthog.procyon.org.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1021352.1746193306@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.05.25 15:41, David Howells wrote:
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
>>> I'm looking into making the sendmsg() code properly handle the 'DIO vs
>>> fork' issue (where pages need pinning rather than refs taken) and also
>>> getting rid of the taking of refs entirely as the page refcount is going
>>> to go away in the relatively near future.
>>
>> Sorry, new to this conversation, and i don't know what you mean by DIO
>> vs fork.
> 
> As I understand it, there's a race between O_DIRECT I/O and fork whereby if
> you, say, start a DIO read operation on a page and then fork, the target page
> gets attached to child and a copy made for the parent (because the refcount is
> elevated by the I/O) - and so only the child sees the result.  This is made
> more interesting by such as AIO where the parent gets the completion
> notification, but not the data.
> 
> Further, a DIO write is then alterable by the child if the DMA has not yet
> happened.
> 
> One of the things mm/gup.c does is to work around this issue...  However, I
> don't think that MSG_ZEROCOPY handles this - and so zerocopy sendmsg is, I
> think, subject to the same race.

If it's using FOLL_PIN it works. If not, it's still to be fixed.

-- 
Cheers,

David / dhildenb


