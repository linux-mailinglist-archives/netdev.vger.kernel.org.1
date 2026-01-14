Return-Path: <netdev+bounces-249821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E49D1E9CF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2FD6305D7E9
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1BA399A5B;
	Wed, 14 Jan 2026 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUUEgg/z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S25VXouS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18C399A4C
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391408; cv=none; b=Ap819kiE6+CGpok5ABpB8SglktrNg7e0x4Z/fXxq5Uyw53DCLD6q0mjYiuZKQhw74sddwGaQ1edRneLJ0Wqd9dxM+EA2uGqTtZomGX4O81bOUaMLDVqeyvcWVWGzkWuTtPuK5RrrIozjsivHqV+UFSi4yYRi/OFh9Ol45if/2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391408; c=relaxed/simple;
	bh=UtKOf3/Ud2MKlYgnqMe/64gZ7wIz9Cjsm2A2iZSp4m4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IuyO2CdfVPa8PD0xEc9yowgL+f1WECOaNBWqNVHj6RyQBFkRhX91zTxrD8tnaLJ51rvFFUUFvAJm99rpYKaScS12HaGujuZxUzajXxzfpRn5kfqsZN3tBVib4JuWOOXjoOmHzMMb5WSbRel8FkKR8pS/zZqmYrA13NDIUqR9O/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUUEgg/z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S25VXouS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768391405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q8uX03BZl5AjAdWG8Y9fY1QPxmLXeoAmQaAzEsbqKH8=;
	b=iUUEgg/zhY7lVYWa8TG5pnqce7WyhCvJz+54/nQ/KslAkye3pL5WaJI9tSz7fHbQC4Zoya
	C5kB3+FTB/mJg1cPqwiGaqK/JNAh5+DXlgg8lXgzmRgTFAC+TsWQMdrA1tjbriVso2pvQL
	txv8u7yoJQhtlEfe0aOt3sJ3p63VZFg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-YOv8EBC9OC6_Y1n6Fu53Dw-1; Wed, 14 Jan 2026 06:50:02 -0500
X-MC-Unique: YOv8EBC9OC6_Y1n6Fu53Dw-1
X-Mimecast-MFC-AGG-ID: YOv8EBC9OC6_Y1n6Fu53Dw_1768391401
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-653f94a664eso369511a12.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768391401; x=1768996201; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q8uX03BZl5AjAdWG8Y9fY1QPxmLXeoAmQaAzEsbqKH8=;
        b=S25VXouSyxBbwa293SNB/yOE5a2zByfoZcGbBWXRtwh006CQX0OCpY3sI2m5AmHV2T
         IO1wjOwVUKng+845UMeyHO6ZMFNOyfYf4Oqhzp7V8rKuLb89vMfXfRMKAd0+BCumSvQG
         n/cosn7kK5vXEIToASao05HijQlFXipA/Gcz7pMUItiSeE0K1uO9CNT06jfMZvegSlyH
         mUtHhCNQCbgL5u19Mh7I295ufbpKqIkKNBHI6xTzTDHNzuNHvIA3X1VCMiOS/hj5BGob
         lCGbjhvLeNHMtc6ckjzlwRv5k9XfRVHDEnPew2cQkp2C4cnvNNhVMTNVJeuRYnV/Pz2Y
         Ezcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768391401; x=1768996201;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8uX03BZl5AjAdWG8Y9fY1QPxmLXeoAmQaAzEsbqKH8=;
        b=fBt+GFPdQodYlGZHQWgeZNe3M37DqYDKRQ2e78q6Swoe0pBzUyVJyfQP4pNDRNTg9V
         65PqF9v+8r+kAxDaXaKT4b0oJin6ySu1hq9mMnnpjscjCCvnUCq0WJXbeMdQwA7gLkbs
         lKDH4eWSEEuuzMbHkxhBmQWTEkEFRTtj6DIkMoQz8Orne9IjY8gok2o6YE057eVrWrIK
         hyBOcZEbAKzAOR2WC5bjvDpiigNwe+AXr/q48BgOR3CUdOBvCDC+gjqT74rrNfwccIyg
         jxQoGm2ehIbxZt7ixy8BAbsQow6zSV6GxY57X5vpUrARqLN6xn/cApMiOdWWBwUK8ajE
         yf2A==
X-Forwarded-Encrypted: i=1; AJvYcCWP/FYx0bMEvfHQt90QbzZ0w55JHMaCZWZlUSDcV+mXOOuo/5XTc+1grUime/4I5IxZxcNqz6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd6zkE5Hgd/xIBdkomlVq/6j7ZtYHnoySijc2d2o/+FnJ87Phy
	qh9olJtyguzv8I4a34VJFIg97xLzUFXyPQuUNfQg7h4PqYcRgX+x1VSLERKscynWnx1fzhO007i
	crzud/QR/0WRq4J00xzw1c0C73Xtpfa+FmatLUoFhvH9isHwhy1SKY882cw==
X-Gm-Gg: AY/fxX4cuGRDlZ9gEooTWl6xLnVCZl/0dmk5lkkDGLsI2uz8dyY1WGWi/HV+/TpUMU7
	utfcROPWGxyZd8EfAt/AJLO94OWTa7nFlRRHi2BdoXc0BBYn0cP7Vf6LNL09/HP1gf3vwHC1LZ1
	YiXZSzcqcyxzjUBZV+agj/Kbxqor6x3iVsBr8x7CwEsK+i+iK8r4gGkvh/cAZdomJSuoJ8siayy
	ZEmjMB7b5qPJmsIEo0Y5q1VJhtdUrRG7TQfqrM7AxF+cQc0l9bnYM0YhpiHy4hbcIaKZ745pCyl
	0Vu9xNKHHzn9oWLC3hweSvLHq5wWXYK6J13WsMIO7dtloa2QEGGNZl14ZyokZS0WOh4ixPNECqo
	SoDigWW0eKBS8oPD9XyA77sE3QJQ9yIh8hA==
X-Received: by 2002:a17:907:94c4:b0:b87:2d0f:d417 with SMTP id a640c23a62f3a-b8760fe0baamr179682166b.14.1768391401375;
        Wed, 14 Jan 2026 03:50:01 -0800 (PST)
X-Received: by 2002:a17:907:94c4:b0:b87:2d0f:d417 with SMTP id a640c23a62f3a-b8760fe0baamr179679266b.14.1768391400849;
        Wed, 14 Jan 2026 03:50:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd007fsm1294372966b.31.2026.01.14.03.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:50:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CA9A8408B76; Wed, 14 Jan 2026 12:49:57 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Michael
 Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com, Jesse Brandeburg
 <jbrandeburg@cloudflare.com>, Willem Ferguson <wferguson@cloudflare.com>,
 Arthur Fabre <arthur@arthurfabre.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/10] Call skb_metadata_set
 when skb->data points past metadata
In-Reply-To: <87wm1luusg.fsf@cloudflare.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260112190856.3ff91f8d@kernel.org>
 <36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
 <bd29d196-5854-4a0c-a78c-e4869a59b91f@kernel.org>
 <87wm1luusg.fsf@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Jan 2026 12:49:57 +0100
Message-ID: <878qe01kii.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Sitnicki via Intel-wired-lan <intel-wired-lan@osuosl.org> writes:

> On Tue, Jan 13, 2026 at 07:52 PM +01, Jesper Dangaard Brouer wrote:
>> *BUT* this patchset isn't doing that. To me it looks like a cleanup
>> patchset that simply makes it consistent when skb_metadata_set() called.
>> Selling it as a pre-requirement for doing copy later seems fishy.
>  
> Fair point on the framing. The interface cleanup is useful on its own -
> I should have presented it that way rather than tying it to future work.
>
>> Instead of blindly copying XDP data_meta area into a single SKB
>> extension.  What if we make it the responsibility of the TC-ingress BPF-
>> hook to understand the data_meta format and via (kfunc) helpers
>> transfer/create the SKB extension that it deems relevant.
>> Would this be an acceptable approach that makes it easier to propagate
>> metadata deeper in netstack?
>
> I think you and Jakub are actually proposing the same thing.
>  
> If we can access a buffer tied to an skb extension from BPF, this could
> act as skb-local storage and solves the problem (with some operational
> overhead to set up TC on ingress).
>  
> I'd also like to get Alexei's take on this. We had a discussion before
> about not wanting to maintain two different storage areas for skb
> metadata.
>  
> That was one of two reasons why we abandoned Arthur's patches and why I
> tried to make the existing headroom-backed metadata area work.
>  
> But perhaps I misunderstood the earlier discussion. Alexei's point may
> have been that we don't want another *headroom-backed* metadata area
> accessible from XDP, because we already have that.
>  
> Looks like we have two options on the table:
>  
> Option A) Headroom-backed metadata
>   - Use existing skb metadata area
>   - Patch skb_push/pull call sites to preserve it
>  
> Option B) Extension-backed metadata
>   - Store metadata in skb extension from BPF
>   - TC BPF copies/extracts what it needs from headroom-metadata
>  
> Or is there an Option C I'm missing?

Not sure if it's really an option C, but would it be possible to
consolidate them using verifier tricks? I.e., the data_meta field in the
__sk_buff struct is really a virtual pointer that the verifier rewrites
to loading an actual pointer from struct bpf_skb_data_end in skb->cb. So
in principle this could be loaded from an skb extension instead with the
BPF programs being none the wiser.

There's the additional wrinkle that the end of the data_meta pointer is
compared to the 'data' start pointer to check for overflow, which
wouldn't work anymore. Not sure if there's a way to make the verifier
rewrite those checks in a compatible way, or if this is even a path we
want to go down. But it would be a pretty neat way to make the whole
thing transparent and backwards compatible, I think :)

Other than that, I like the extention-backed metadata idea!

-Toke


