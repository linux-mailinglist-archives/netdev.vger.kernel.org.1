Return-Path: <netdev+bounces-202656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 196FBAEE856
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 22:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47107170D65
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 20:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EDC230BE4;
	Mon, 30 Jun 2025 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CXGIu1V0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453ED43AA8
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315691; cv=none; b=FykuJICB+0IrfMUuwvz0tpvCH5FbTY5/veHFYmS7QjEjb5oa+O4ESYnPtNH20i765a6dEsgePn/2gCor3mpFnrbmpA1U5N9pN9uPKJx10PodRQACo2+4Xg7VcCriMX1MYK1/K1K2TWwKL403B6BiB9CbcaUd7Qlgut6iFHPJb1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315691; c=relaxed/simple;
	bh=Pk8kkiBE39VcNtpHJXA+ySzpyn5CfQcFwZ1k9zEJxWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sjlv39NBAZdcHCDzGP+nXWVx2I6vta1nBPVME4KQNWwkBB5KFTC9ANxNU7Z6Vr5kGykBpDicR5zb5n9Gf3dlF8wDVEc0PenVtsX9avg+oC6OaTtDHhfpLH9ziMA7C0zMuwv8iY4ELe6rX7fA+go6wgqMaJRYTbxaKM8xEa6Bi0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CXGIu1V0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so8687560a12.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751315687; x=1751920487; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cc8wASdbWsQ0099rsQ7fOSRfIkggSfQmz2eC+r1JO7A=;
        b=CXGIu1V0MWRKPZLwjUdA9m1W1pmPOWSu9J3FTm2DdCAJ1/0S9kshL0NFf23zv6dEQM
         3VYklBJJzRmsBK60QqpZKNXHijYV2zcGqg1ygFCKATwzEX2yBSxnNOE/QT//EvL77ukY
         H8B01NCCUTmprXYCb/31PqD8qTGKrImI15BQ67YBb2SyDsdKtwNOMS//jXl6dxLZ/ZgW
         xE7Inz0z5uCIsqwOqZOmiLvgv0ii2pO8ycjt7CQJnka33pnXkjkY0ydqsW+RabkRSVXi
         iZiOXXqNRi4YhLYaSLE2db4lYOkIynztBBrUNuczO1k3G2NJO9NAyBakj8rE1W82ORWr
         YxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751315687; x=1751920487;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cc8wASdbWsQ0099rsQ7fOSRfIkggSfQmz2eC+r1JO7A=;
        b=GI3uxxMv/kp/QBI2PVgbPYNJKBgrfuC3hNqnW6Vy96S1edk4lx3g2UwoySXlOpMaYv
         hlBDT7W2eLi+GvYiUUVDwj+Fv0Su7FaLxddlauQQFsBondTkshK075LqCbGkjZoVoRuO
         OWOrOIy4GKF3IwPqf1reXk0Oz8ef1xIZ39EdI0jQicFRwPr/HlgC4SD2if1myjPk+o8l
         0YAU3nqdevekkX1O8wJ+4yiadRo8A/eMgawY0xWrBguS6HhWFfGVYazSm/ap7ybKfjs0
         JeyPX2fpfpO9qRJ5pA/nrl26YBA69IQnB83H2zsqjDGCa8sLWrHQk1xew9m4MaB7y0p/
         gtKw==
X-Forwarded-Encrypted: i=1; AJvYcCWQzSLK9nirfBqfcBVysp7xiMUdHYilohBxmOZKHWgtCgTmWlB1Snsthjc4r4Zx2ps56gdfRzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLq2P2QBN12xXxRDPmjQt4swBHWmrukVpJ0NL6qLoZFnQkYqy
	bKIGDdnWtheYlOelUlGZZg6k/PKLjGrii9dYKJGUvIArtTL8TiKt4tB3CZz4R8y7ihA=
X-Gm-Gg: ASbGncuzkEBwB7r3Lir9hYIKCuayCmYjkD0Mw3MAVNJp7Zb8QQtkQOYB/46yopxeTW9
	UoRP8Xls9yTmQOrtzLXxV+JTLmauEC1h+DSW5du28s8ZHWbGKTOTbaZAFzY1B9kzuTWU72Yhp+B
	EWyyl7rp1WsSfFQmdAAy+IJMG21+XZIyd+1wE+nBhIZafDzGoRTfw1dJi7BJweisakj4jIMh9R9
	klbHolmqHz93fk/99hxJfcgHGoNGLk0fxMm6rMALziby/O+NQXZ6IPEmNMIKzgVKt6oUw0J4F5t
	t2fn1oFOQnRuK0kbTewEc1bPwPN8xsAu0Eu6WCgdbSjY1PtstTOU5Q==
X-Google-Smtp-Source: AGHT+IEJxiHy+3+6u/TvSn2ligyBToRNoMl24c27b8vJx5lbaXmBByDK0msWHl62WthTNrll91mdeQ==
X-Received: by 2002:a05:6402:4302:b0:608:2e97:4399 with SMTP id 4fb4d7f45d1cf-60c88b382b9mr13548847a12.4.1751315687493;
        Mon, 30 Jun 2025 13:34:47 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8320b5aasm6228112a12.76.2025.06.30.13.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 13:34:46 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Arthur Fabre
 <arthur@arthurfabre.com>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Jesper Dangaard Brouer <hawk@kernel.org>,
  Jesse Brandeburg <jbrandeburg@cloudflare.com>,  Joanne Koong
 <joannelkoong@gmail.com>,  Lorenzo Bianconi <lorenzo@kernel.org>,  Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com,  Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next 03/13] bpf: Add new variant of skb dynptr for
 the metadata area
In-Reply-To: <aGK69qJ9tLVvarqh@mini-arch> (Stanislav Fomichev's message of
	"Mon, 30 Jun 2025 09:27:34 -0700")
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
	<20250630-skb-metadata-thru-dynptr-v1-3-f17da13625d8@cloudflare.com>
	<aGK69qJ9tLVvarqh@mini-arch>
Date: Mon, 30 Jun 2025 22:34:45 +0200
Message-ID: <87jz4tnf2y.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 30, 2025 at 09:27 AM -07, Stanislav Fomichev wrote:
> On 06/30, Jakub Sitnicki wrote:
>> Add a new flag for the bpf_dynptr_from_skb helper to let users to create
>> dynptrs to skb metadata area. Access paths are stubbed out. Implemented by
>> the following changes.
>> 
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  include/uapi/linux/bpf.h |  9 ++++++++
>>  net/core/filter.c        | 60 +++++++++++++++++++++++++++++++++++++++++-------
>>  2 files changed, 61 insertions(+), 8 deletions(-)
>> 
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 719ba230032f..ab5730d2fb29 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7591,4 +7591,13 @@ enum bpf_kfunc_flags {
>>  	BPF_F_PAD_ZEROS = (1ULL << 0),
>>  };
>>  
>> +/**
>> + * enum bpf_dynptr_from_skb_flags - Flags for bpf_dynptr_from_skb()
>> + *
>> + * @BPF_DYNPTR_F_SKB_METADATA: Create dynptr to the SKB metadata area
>> + */
>> +enum bpf_dynptr_from_skb_flags {
>> +	BPF_DYNPTR_F_SKB_METADATA = (1ULL << 0),
>> +};
>> +
>>  #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 1fee51b72220..3c2948517838 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -11967,12 +11967,27 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>  	return func;
>>  }
>>  
>> +enum skb_dynptr_offset {
>> +	SKB_DYNPTR_METADATA	= -1,
>
> nit: any reason not do make it 1? The offset is u32, so that -1 reads a bit
> intentional and I don't get the intention :-)

Since we're abusing the "offset" field to serve as an enum tag, I
figured seeing 0xffffffff in a memory dump will be an clear indication
that this is not an offset.

Also, metadata comes before payload, like -1 does before 0...

JK of course. No preference here. Went with my gut.

