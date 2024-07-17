Return-Path: <netdev+bounces-111875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEAB933D99
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 15:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0671F23462
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937BC180A98;
	Wed, 17 Jul 2024 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtPjIMXf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773A1802CD
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222903; cv=none; b=IoUbnwiegSQIg2VJ6+gBlcI2HkWBKaxbQiuW9WwSK5gNSCoxS21LLbPU/3vb+NYID24M6eW2GcnBwXHdFnL5Zvz/gsMFs7Zk03mBuPKW882W8TWHfO2mOZeiIZmII2fs62WIU4Lfmy1xg7WrOWWcAgTAXp4pJIjpNKWGCZUH0Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222903; c=relaxed/simple;
	bh=i5fDdDHEtX7vNR12mFEKIETqZ0WT4Yxwoz5sgAv+nGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OqrDQiuD2Cx71cEUsV78p7p+yU91GoqFDEtDySm/CqBnfpiIHX0y4ebi2/Szwnin/ik23Y2RzpMPGRIcn5wpCzoBR2etPLHxbfqXIm60L9l4Nu9U/91FqY5SuiQvzGwfC+qjA2tDil6PpTWKPqL6cVVWDwxwsWxdRo7ElxZtdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtPjIMXf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721222898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ItohwBK9euwv/uwdzmdFu/crsWLVAK5HqaVyEtkiNe8=;
	b=TtPjIMXfPyHqLY1XFxRcVeUz3fQ6+jmkEZ3byhnATOYbpumN1x5SZIFNIPmMhD6ZqQX3E9
	8gjp5DtQtmbCTl/xuw6PCovp8CrXHygnUPSKKJkEFATbl41Ng3qmd5u+CYl7BDHiSouklf
	qFnklcLI+0shXONx+HgMMQeD6kBBI2U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-3mzbL4OmOjmWQjUIMSOW7w-1; Wed, 17 Jul 2024 09:28:14 -0400
X-MC-Unique: 3mzbL4OmOjmWQjUIMSOW7w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-426d316a96cso49116535e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 06:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721222892; x=1721827692;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItohwBK9euwv/uwdzmdFu/crsWLVAK5HqaVyEtkiNe8=;
        b=MI6xtYKP/Fc8penLAkEJ5XX5dfPFCNi3oNlZzWU9OveBYyb8LCLntsHlnsv+ZvB465
         lPWNqCSeOEfCCkVefj/j0uCDKIJU5Qdn2eS+rnSc+/LAbgnltO9rGqfb/4Rg31eRaUtw
         QoKpW3qgqp4MmGxBnDMKr/ide7JjtwGuDyZsivAk1RSgTgjUn4gM+UId+fzYIAlDCQts
         UcsM9QaiUeQ64t1AKXAj7HdAag7//dmWSNlr5z1zF25ig79N/GMH03jrnjgsXZv1sHYz
         7ocqxLmkp7AU2IKpM8zaetxjBh8V1G3F/VpMY9ycDHS/FdRqdL+mAK3rWHePLXashcls
         vUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYDKFo7H+oumyKh+9a/WJynPJjM0FgFP0g2p0Kw4MntpsqLKePp8y4M1XZANS3cDfrFfJCEAD/LXZAq8OJLYkstytlLOtT
X-Gm-Message-State: AOJu0YyXLHhBvxEbKst3ezqaqLDk/OG6+MLa5qFiSPntqw1Cye53SfUp
	LjngfwaTF0H10rWSMNDXkaMIpLF3GUFbs/wANYzH+wKtbV4FyQRNtZt/HVSLJzdQL2tGHHdKG8U
	3c8bMUOgNY0sZGtREfSE2EUs02NsQFGBIpaimQA1Bu364eK3WkPYZdw==
X-Received: by 2002:a05:6000:d90:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36831948efamr1354440f8f.7.1721222892505;
        Wed, 17 Jul 2024 06:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpTaAUfRVNU5Xu+qR1JE/9Bc1YiuNYvppU3YdvKcMCaYdPaRWowG53BU48+Swh1yPrb+brsQ==
X-Received: by 2002:a05:6000:d90:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36831948efamr1354427f8f.7.1721222892139;
        Wed, 17 Jul 2024 06:28:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db04731sm11642192f8f.112.2024.07.17.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 06:28:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 42675145D491; Wed, 17 Jul 2024 15:28:11 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Michal Switala
 <michal.switala@infogain.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, revest@google.com,
 syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com,
 alexei.starovoitov@gmail.com
Subject: Re: [PATCH] bpf: Ensure BPF programs testing skb context
 initialization
In-Reply-To: <250854fc-ce22-4866-95f9-d61f6653af64@linux.dev>
References: <CAADnVQJPzya3VkAajv02yMEnQLWtXKsHuzjZ1vQ6R19N_BZkTQ@mail.gmail.com>
 <20240715181339.2489649-1-michal.switala@infogain.com>
 <250854fc-ce22-4866-95f9-d61f6653af64@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 17 Jul 2024 15:28:11 +0200
Message-ID: <87y160407o.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 7/15/24 11:13 AM, Michal Switala wrote:
>
>  >> Reported-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
>  >> Closes: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
>  >> Link: https://lore.kernel.org/all/000000000000b95d41061cbf302a@google.com/
>  >
>  > Something doesn't add up.
>  > This syzbot report is about:
>  >
>  > dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
>  > __xdp_do_redirect_frame net/core/filter.c:4397 [inline]
>  > bpf_prog_test_run_xdp
>  >
>  > why you're fixing bpf_prog_test_run_skb ?
>
>
> [ Please keep the relevant email context in the reply ]
>
>
>> The reproducer calls the methods bpf_prog_test_run_xdp and
>> bpf_prog_test_run_skb. Both lead to the invocation of dev_map_enqueue, in the
>
> The syzbot report is triggering from the bpf_prog_test_run_xdp. I agree with 
> Alexei that fixing the bpf_prog_test_run_skb does not make sense. At least I 
> don't see how dev_map_enqueue can be used from bpf_prog_test_run_skb.

Me neither.

> It looks very similar to 
> https://lore.kernel.org/bpf/000000000000f6531b061494e696@google.com/. It has 
> been fixed in commit 5bcf0dcbf906 ("xdp: use flags field to disambiguate 
> broadcast redirect")
>
> I tried the C repro. I can reproduce in the bpf tree also which should have the 
> fix. I cannot reproduce in the bpf-next though.
>
> Cc Toke who knows more details here.

Hmm, yeah, it does look kinda similar. Do you mean that the C repro from
this new report triggers the crash for you on the current -bpf tree?

-Toke


