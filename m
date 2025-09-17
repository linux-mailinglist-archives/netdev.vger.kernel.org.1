Return-Path: <netdev+bounces-223898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7025B7E43F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B13C1B25358
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677DC30149C;
	Wed, 17 Sep 2025 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2XCsfAV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED8B1F5820
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095847; cv=none; b=OPXDl/O590u49WZz254BDamqtugmAmAs9+yqDNlFn+UU0HPdsM2IuNYrW2PpUEVid8UBKJYHftl5iV539j1PpbSu2NQ9iAxLpfnh+cwURXOG4Gmyf6qdFT+8GkBMmDb7jfQ4X6bvUtBKhnegdn4ITVuV2lup0EecczIohND8sTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095847; c=relaxed/simple;
	bh=7cjsHAs6KihPquo/vuD2/3FbmYO2y4zQ9Q9gpKGQuRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nf4t6K1Hmd1HVckL+t31nA17YHTknNTRkvjaXR/cFXk1NZOsP6h8LcvbNHH4di/5T3DTXpNc8GrVKaOErAnR4khpRLDZtAzU/WRvFLojojkFwr6hCTqVAPCvuF/Neg8VBtINXngcW9J2RGSoG3ApA6NE57FazRhlqmrQkzs/Uu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2XCsfAV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758095844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9PzBAtZ6dCpqAcibyTZBdx2ih4FIqPQpEwny2ET0cgw=;
	b=e2XCsfAVFnYbVjRYNnN5n0JmaUmWIHMSCj3x/wCraIerTbLvdjOn2yWGVCNB6uBLtV50cv
	UHblyaMIAEY3CjuDt4NeKjoa9S+cG8Y08DhXErECfI82WPY1ztAiSB03pFUHALrFxViGs6
	p7d+yPsJccq4pZVtTVkZm4ezbGiSlGI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-odM2zSp4O7WHdkth4XMS2A-1; Wed, 17 Sep 2025 03:57:23 -0400
X-MC-Unique: odM2zSp4O7WHdkth4XMS2A-1
X-Mimecast-MFC-AGG-ID: odM2zSp4O7WHdkth4XMS2A_1758095842
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3eb2c65e0d6so1591295f8f.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095842; x=1758700642;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PzBAtZ6dCpqAcibyTZBdx2ih4FIqPQpEwny2ET0cgw=;
        b=FzoQMzNSLr4Chiya/bA3PRB0azi1DCBfZ88ARqKdtX3d28WR9fe4vr4Qh8JhLDD1/G
         TfodkN2TwWyzb+UqNf7mOw4aQbwkKLhmtT1lxVzHIZ0JLGoRHXywnx7JoNa1BIhfuDlY
         KK2xDxtvsazvTg0ZsJN1c7cp2ZeqjVuYk8nfcQcGuhi4phad3rVCzGaKhgfB+9Ml8Wpx
         uKqUIZI8b/KSO0hz4OXWSqlIcsQ7PTY+KmvQ1HzwOHeaCr99KgimALWZY/c2ZSei6HLL
         M8H8v7zhbQ1vizmURWp/cvnA7/3pxFkNtFQoSr229+xGosaRisOUuLHFtIv1vfcIevT1
         HY/w==
X-Forwarded-Encrypted: i=1; AJvYcCUy3UNQwck3AJjZIjwGWLmYFph8mAsQskNeYUlxtbXnffiYZ2FXe02rqeS87BI5BsE68fUUJuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDwPCUUSgVTCNpzOwzb1KMjtecWM3HPwXv9sEJMh2rxIxkYtT
	k+gWKHbsMxiFD7giEdqJv+haJ/hGHL2n5PkXkDTl0GvZMX3/TUH6M/E4UilPOXFOCM+pIDxBOtk
	Jwo0+o3F4r9ukdhhRMkq6ohE2pPOLqNIzK0+t3VDCvSco1CdCgy+hU+lLBQ==
X-Gm-Gg: ASbGncvvEQy8TYlLtfNLTyd502oXWsW53gywuGoBDjJHCG6Ni3wExGV/KfzKaA08l/w
	QpGY2gvGyDSRBXJVKKJLTinkb6aHBRHRP1+DLXFwqVvqbT0S0aFArmq4IuZBK+pIX5Tqv5tSmnn
	neIECOC0eNGl77i1EB8PQxpJaB5FBoYOFbXN3xYNuA/haOLRgagosCuEuoDl1ijXKhkDafOa1ac
	LvXFLCq8lAzYRf89Y9OOWmbmAoRS3j9w00r9eAjlANGbCX5zGLGoIz0Pl+QKJ4P1xLhDa3qiC7E
	hKj5sJmE37rftd7nsrppPJKMsKaUHsR5uCeeBfvo+gBDyBekEwCN8ip7uLu+FtDNhfHUW+ZO1ty
	NLJiNoHfQ9gCQOpTYhYL+tPXPU5CgDvGPJ4cOM4WNHUYZ8e18HMGgp7QUF7++Hwyo
X-Received: by 2002:a05:6000:40c8:b0:3d2:9cbf:5b73 with SMTP id ffacd0b85a97d-3ecdf9b5961mr874642f8f.6.1758095841895;
        Wed, 17 Sep 2025 00:57:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1fuIiFC5t7bfIvFNwsccdu8uwKOxCMzstpj7QWFZNvkLHIrE8zhNFdLVe+xbAw0R9o3KnJw==
X-Received: by 2002:a05:6000:40c8:b0:3d2:9cbf:5b73 with SMTP id ffacd0b85a97d-3ecdf9b5961mr874608f8f.6.1758095841400;
        Wed, 17 Sep 2025 00:57:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32642813sm31271485e9.10.2025.09.17.00.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 00:57:20 -0700 (PDT)
Message-ID: <7e338491-0c6b-4b65-93b7-df0af8b2fd87@redhat.com>
Date: Wed, 17 Sep 2025 09:57:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [sound?] kernel BUG in filemap_fault (2)
To: Jan Kara <jack@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>
Cc: syzbot <syzbot+263f159eb37a1c4c67a4@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, chaitanyas.prakash@arm.com, davem@davemloft.net,
 edumazet@google.com, hdanton@sina.com, horms@kernel.org, kuba@kernel.org,
 kuniyu@google.com, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
 willemb@google.com
References: <68c69e17.050a0220.3c6139.04e1.GAE@google.com>
 <80840307-942d-4e7b-849d-2ca9bb4bbefa@arm.com>
 <lqzgi7abe2onda3faavn5ays6gdw4syiu32hmrfaibrh6cmozs@pjf3llvnnefk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <lqzgi7abe2onda3faavn5ays6gdw4syiu32hmrfaibrh6cmozs@pjf3llvnnefk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.09.25 15:05, Jan Kara wrote:
> On Tue 16-09-25 13:50:08, Ryan Roberts wrote:
>> On 14/09/2025 11:51, syzbot wrote:
>>> syzbot suspects this issue was fixed by commit:
>>>
>>> commit bdb86f6b87633cc020f8225ae09d336da7826724
>>> Author: Ryan Roberts <ryan.roberts@arm.com>
>>> Date:   Mon Jun 9 09:27:23 2025 +0000
>>>
>>>      mm/readahead: honour new_order in page_cache_ra_order()
>>
>> I'm not sure what original bug you are claiming this is fixing? Perhaps this?
>>
>> https://lore.kernel.org/linux-mm/6852b77e.a70a0220.79d0a.0214.GAE@google.com/
> 
> I think it was:
> 
> https://lore.kernel.org/all/684ffc59.a00a0220.279073.0037.GAE@google.com/
> 
> at least that's what the syzbot email replies to... And it doesn't make a
> lot of sense but it isn't totally off either. So I'd just let the syzbot
> bug autoclose after some timeout.

Hm, in the issue we ran into was:

	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);

in filemap_fault().

Now, that sounds rather bad, especially given that it was reported upstream.

So likely we should figure out what happened and see if it really fixed 
it and if so, why it fixed it (stable backports etc)?

Could be that Ryans patch is just making the problem harder to 
reproduce, of course (what I assume right now).


Essentially we do a

	folio = filemap_get_folio(mapping, index);

followed by

	if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
		goto out_retry;

	/* Did it get truncated? */
	if (unlikely(folio->mapping != mapping)) {
		folio_unlock(folio);
		folio_put(folio);
		goto retry_find;
	}
	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);


I would assume that if !folio_contains(folio, index), either the folio 
got split in the meantime (filemap_get_folio() returned with a raised 
reference, though) or that file pagecache contained something wrong.


In __filemap_get_folio() we perform the same checks after locking the 
folio (with FGP_LOCK), and weird enough it didn't trigger yet there.

-- 
Cheers

David / dhildenb


