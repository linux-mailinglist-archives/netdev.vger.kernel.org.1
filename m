Return-Path: <netdev+bounces-223912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64BB7E032
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94EEA1B248BE
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38142328576;
	Wed, 17 Sep 2025 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpfObiaw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5330BF5C
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099860; cv=none; b=skTWRBLuftS4sik1u8rE5O+tEdxBHFot6ZQf3VpIRdoOrmhM9cHDxfo/xnGW4G2FR/jU0E5FxgtaX/4hqrLfAraDTmLj9mXclpqqteOHDyhq3rncrbXSR8V+341j4H5oHEV8eIwCsrtXc40NfKez5/lWVvr0YTsaIVf9pFxmzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099860; c=relaxed/simple;
	bh=ZknuNHFq0tyeptFvJcnnsXRV6fSiqoXd5zwMcfSSKD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9UthoJQBVzG2w12jd54BOlQ+SW/INXp1RcHODOvLs9uS8ieLTydzwYBTM5S9bynvkfnIjwGIwxJoeyTaKLgPpljU+Mz0Vcfg7l4BzClkMS80oeiQFuIN9hnBuk7UdWjTjvkkerrHz8Z/RVS6bB7SMl8+AxZvaIfnN1gQF48eJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpfObiaw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758099857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x5npCVbmbW8kT6qQZFnkl4JniL63oW0fDP/nvQRcCcY=;
	b=OpfObiaw+QIOayctcet9ueFl1jBG2/jl4t9jb719btYLhvvAzFEDyw+CtwyDupyfDIeiP4
	A1M+XeOfbsaXNfQ4I/lSvgcqzQRyLrOw+gpPyDktpsZh7uS/P/Ky1Wn8keG9bC/WyK7W5X
	c6kkXNyisAfmlgyC8Gta5or64vhcMC4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-D1v2HvirPSq6MCENfmJpFg-1; Wed, 17 Sep 2025 05:04:16 -0400
X-MC-Unique: D1v2HvirPSq6MCENfmJpFg-1
X-Mimecast-MFC-AGG-ID: D1v2HvirPSq6MCENfmJpFg_1758099855
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ec7be07a24so926877f8f.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758099855; x=1758704655;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5npCVbmbW8kT6qQZFnkl4JniL63oW0fDP/nvQRcCcY=;
        b=FL4GwWJxRjBwP8sxidzt54fkSH37LEFs5zAc22rrJ0JyQdwdEjoIWEoYfWOmIcNe5V
         ty1ZOh4W25egKBxqDvbJiYjpicvymiZQbK+26JP4+YERw96B5d7RCUZWg8/zIJFLc7Eh
         7iuJiQ4XNzDsGRlV/5PX9WD7+dPYag0s7emxBc6RJwCbMqnPdS0Z1ZqEmoDjxTFMvt30
         58PF8MeoFxqZwN6KQaThai9Iv0mHpt5286/FRZ9w7o0eRmAgiY5KDXtZmL97qLH2EpOD
         N+TlYtnYaesvBcOB1RFIvqLTtWWVPHMrHonzHdwZBSGtA7+qCtR1nRcWOjZb+uaOTpXJ
         X+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+xlpC1DUpoJcX7jfclSGBozpQDIneEAxmxhuimdy2Z9UXjZQl+TT16BZIw+qhNqesoB/jrUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySz1VPpft7T7a4USo6nAXzQZ6ky3FkqS2aeBcN0ESQbbgSPPnG
	k+im5I7yDFnppmutRnsC+S1eYJFyYFwb7nJIiV6IJuLghQYzu9gYotVqQ7bfQkNIl9aWRN3QBH6
	77lOlMHDE3YH3AQsEfhjWNc+vHeFRUzqNyL2iXvsxAtIxtLQQHocZJuxY3Q==
X-Gm-Gg: ASbGncs3i7p1pVOpQKGI3V9PmCZM2KeITBbZgC2UkmpyY+7ClSNmfGWlpNODZSUrkJV
	cUtq1tSt0dvKZnM09kKNksP1f34uH7g69YYDUHAHVXtEpJgHPlyOqfyvXRHMfOYkwLe6eDFbEXG
	Yk9QfB+BhkAI8whlfj4sZaruFqKPvsA2tgAgDZ+ah32FCHWJzQ3q5VcoOVWbxwVjUTarEE+jlXU
	FzTjceOQ2Q+bxFe16WpRUA7If7Wdyae6BObYqhJnLgnQ44doQpAA7LWEAL6FM27zer7rLXeUj7n
	/aP4+clWzkVjYFvmV3FADuVWiklAxciNxlJQsAIM0exowoeQNxG3NKwAwXwFzOZ5e7X00Hc4pKD
	99XrNtOOyl0zTkYz1SunmjmgtEYZjEv6fFFFWmR26ERh3E0vrg31zmDbmVdMUTScr
X-Received: by 2002:a5d:588b:0:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-3ecdf9bec6cmr1252288f8f.10.1758099854799;
        Wed, 17 Sep 2025 02:04:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdI4OELMUMHMlRwzj6+l/2Y9hePxscl3Z5Y6ewrNZjZAKUiJVhUKBuG0aAn+4uFmb0FpMAtQ==
X-Received: by 2002:a5d:588b:0:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-3ecdf9bec6cmr1252248f8f.10.1758099854160;
        Wed, 17 Sep 2025 02:04:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613a072a38sm30431035e9.24.2025.09.17.02.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 02:04:13 -0700 (PDT)
Message-ID: <4551b48c-eba5-42a3-aa53-74d412a126b9@redhat.com>
Date: Wed, 17 Sep 2025 11:04:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [sound?] kernel BUG in filemap_fault (2)
To: Jan Kara <jack@suse.cz>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 syzbot <syzbot+263f159eb37a1c4c67a4@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, chaitanyas.prakash@arm.com, davem@davemloft.net,
 edumazet@google.com, hdanton@sina.com, horms@kernel.org, kuba@kernel.org,
 kuniyu@google.com, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
 willemb@google.com
References: <68c69e17.050a0220.3c6139.04e1.GAE@google.com>
 <80840307-942d-4e7b-849d-2ca9bb4bbefa@arm.com>
 <lqzgi7abe2onda3faavn5ays6gdw4syiu32hmrfaibrh6cmozs@pjf3llvnnefk>
 <7e338491-0c6b-4b65-93b7-df0af8b2fd87@redhat.com>
 <s5pl5yhhxyz7dn4r2v6c4ll53ejboe5xa5226ytgg7kjirgmh5@tofyas4lp4uy>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <s5pl5yhhxyz7dn4r2v6c4ll53ejboe5xa5226ytgg7kjirgmh5@tofyas4lp4uy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> 	if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
>> 		goto out_retry;
>>
>> 	/* Did it get truncated? */
>> 	if (unlikely(folio->mapping != mapping)) {
>> 		folio_unlock(folio);
>> 		folio_put(folio);
>> 		goto retry_find;
>> 	}
>> 	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
>>
>>
>> I would assume that if !folio_contains(folio, index), either the folio got
>> split in the meantime (filemap_get_folio() returned with a raised reference,
>> though) or that file pagecache contained something wrong.
> 
> Right.
> 
>> In __filemap_get_folio() we perform the same checks after locking the folio
>> (with FGP_LOCK), and weird enough it didn't trigger yet there.
> 
> But we don't call __filemap_get_folio() with FGP_LOCK from filemap_fault().

Yes. I should have clarified that we haven't seen the VM_BUG_ON_FOLIO() 
trigger on other callpaths that set FGP_LOCK, because I would think the 
very same problem could happen there as well.

> The folio locking is handled by lock_folio_maybe_drop_mmap() as you
> mentioned. So this is the first time we do the assert after getting the
> folio AFAICT. So some race with folio split looks plausible. Checking the
> reproducer it does play with mmap(2) and madvise(MADV_REMOVE) over the
> mapped range so the page fault may be racing with
> truncate_inode_partial_folio()->try_folio_split(). But I don't see the race
> there now...

__filemap_get_folio() will grab a reference and verify that the xarray 
didn't change. So having a concurrent split succeed would be weird, 
because freezing the refcount should fail. Of course, some refcounting 
inconsistency could trigger something weird like that.

I can spot that we are also manually calling 
__filemap_get_folio(FGP_CREAT|FGP_FOR_MMAP) on the else path if 
filemap_get_folio() failed, maybe that's the problematic bit (and maybe 
that's where readahead logic makes a difference).

-- 
Cheers

David / dhildenb


