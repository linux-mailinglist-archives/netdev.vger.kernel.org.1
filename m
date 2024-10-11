Return-Path: <netdev+bounces-134516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CA2999F30
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BE5B21A1A
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DE520B210;
	Fri, 11 Oct 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jM4Fy5/m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62F208C4
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636030; cv=none; b=KHOrfz/5SA7ZvQqAfO+xzIkn0EbzBiBDTYghdmnn6h2pSPfUpC80vZirviqEx9NIWk4AKhKqZwbiImqj1xwkSjQDD9Td4kHw82xkHz6CeG46D/WOlPAH+l+i1e5LT6mQ6WGgmte5Jp89e/OTmKM/nUsmuDE1giroKK/1d7lp3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636030; c=relaxed/simple;
	bh=BYzqfj+nqykqzZcx9YWW3ICcnNZWCRkYBkbU9Dq53Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edm/X16nwU4+7pVwnL7cnsBUEe7uBydGWknJpt4w+QmD/wZlwclNygiB93U78Y/b6I6pU6KMxkJ6VFEyyYtm9QgDyuuMJ8o+b2PKZ/fr7IZ8+bj036d83FwMrg8KhqlXZOmzJjWUVeGoapyaYlyMCJt5d+s9Pc4ZK7NkLXH+6ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jM4Fy5/m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728636027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWrJLHT9xuKB8ajCY4RtFhjfAoKg+wmBe1wyIb2nX+g=;
	b=jM4Fy5/mjIbMX6uztBb4LfvwBiKF+fTkHetu1NZYqZLTCUMhL38vEGClMfYnT4+ynFmkLQ
	R8rYQ2DGwSfJZwaq7psveYemBO1/qFL/2XvKlekor4tp5GBALvecUrO7myzfE/LoWnZBKl
	ljAIy3oMbs45tDEzuU9bUkXzAIZIVq0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-C3ZvYMeGNjqhznhYOvupAA-1; Fri, 11 Oct 2024 04:40:25 -0400
X-MC-Unique: C3ZvYMeGNjqhznhYOvupAA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a342e7e49cso21906115ab.0
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 01:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728636024; x=1729240824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWrJLHT9xuKB8ajCY4RtFhjfAoKg+wmBe1wyIb2nX+g=;
        b=wXXxjMl0JORAhGMUO+knmFdbsgdKWhDOoSO9IVVrOfB+aSHoiaE9bhFGn/ivbF0tcc
         5aAVUA/gYYgDLXftiFKE3LmLunlAhjmoaDiuWAJ6sFXO9DGzVbfrPzLLUT4KcJknU92Q
         AK97ACYfbqn1EM0KBkTgY+52RpXtsAtrIAaGN9HOPAHpRAP0HFb5IBG82rtOgWjlLYtk
         pSJLn3SNpy8M+cyUHrdFa3GP1o2lSWzm21hZcxoQ/Xz2pLiG5aTt0bJUCqltwXzp9cnz
         MBct+t7Y14LkTqn/MHplb1kt3i21rPMGUVbYjU56dgokstoRySJQSTeiosIm7fahyA5H
         /jcA==
X-Forwarded-Encrypted: i=1; AJvYcCUE2qyQDHQXk7EELp8ZtD6Lqpndt2mqHBUYAzoVqXHDvb1Ft3SCK+/g5JWki6FpBM9qwHn9JHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcoMzjsAILh1yowdYRjkFtBie69HwZbEZ2ONrSBd437Bp/jlM0
	IxgBHnnSAj5AYaSdr2UjQoBWV+q3iCgFuT6u28YhXlaCdSVDfD32hTZNU+NhhaXL9zqny9ZvLYp
	iM9Z5tlOottJ0PE1c+10rnWlCmw1V9zttcEto2KEhSMFSJSKSpEdsOA==
X-Received: by 2002:a05:6e02:1526:b0:3a0:979d:843 with SMTP id e9e14a558f8ab-3a3b5faadafmr12313285ab.9.1728636024548;
        Fri, 11 Oct 2024 01:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS6Ve9onGmJnas3m76tH/TZBslmvBdhGx+K87bNYzu3z8d684w4p942qqdciHUKtSyIioLAg==
X-Received: by 2002:a05:6e02:1526:b0:3a0:979d:843 with SMTP id e9e14a558f8ab-3a3b5faadafmr12313045ab.9.1728636024129;
        Fri, 11 Oct 2024 01:40:24 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.139.72])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afdb35e0sm6334505ab.24.2024.10.11.01.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:40:23 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:40:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Robert Eshleman ." <bobby.eshleman@bytedance.com>
Cc: Michal Luczaj <mhal@rbox.co>, bobby.eshleman@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [External] Re: [PATCH bpf 2/4] vsock: Update rx_bytes on
 read_skb()
Message-ID: <cjhxc6sgmufeemnhgsv4prrf5uionxtgadsgwbxajwsljhqwao@3k4nrd2ivvtl>
References: <20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co>
 <20241009-vsock-fixes-for-redir-v1-2-e455416f6d78@rbox.co>
 <mwemnay5bb7ft5zvlrh5emdtkilqvkj42xnxnatnh3hmmtkhce@fqe64sbx6b2z>
 <CALa-AnBQAhpBn2cPG4wW9c-dMq0JXAbkd4NSJL+Vtv=r=+hn2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALa-AnBQAhpBn2cPG4wW9c-dMq0JXAbkd4NSJL+Vtv=r=+hn2w@mail.gmail.com>

On Thu, Oct 10, 2024 at 05:09:17PM GMT, Robert Eshleman . wrote:
>On Thu, Oct 10, 2024 at 1:49 AM Stefano Garzarella <sgarzare@redhat.com>
>wrote:
>
>>
>> The modification looks good to me, but now that I'm looking at it
>> better, I don't understand why we don't also call
>> virtio_transport_send_credit_update().
>>
>> This is to inform the peer that we've freed up space and it has more
>> credit.
>>
>> @Bobby do you remember?
>>
>>
>I do not remember, but I do think it seems wrong not to.

Yeah, @Michal can you also add that call?

For now just call it, without the optimization we did for stream 
packets, in the future I'll try to unify the paths.

Thanks,
Stefano

>
>
>> I think we should try to unify the receiving path used through BPF or
>> not (not for this series of course).
>>
>> Thanks,
>> Stefano
>>


