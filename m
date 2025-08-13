Return-Path: <netdev+bounces-213275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E491B2450A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B83072224B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7CC27280E;
	Wed, 13 Aug 2025 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYJzJ6ay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB920E023
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076222; cv=none; b=KqtjJaPKvPTeb7yiN4acxagaa6LlWTn7BsBDnxCFOEiMJUUrE8w3T6uhXjMwGoexYE3bcB6I9Kd+mCznbFnXYMD9EsbFf+g48BNkWKAQiLBiOWze3GUieUm2t3XTkMXaIZRf27bo9zaf4blBEhPhNGzbDdgvsNiydY/v+80riBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076222; c=relaxed/simple;
	bh=IsQxFe5j1TdKP3sVa1JaDTksAwgJ1BwdHBh8OlbS/KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TngeFg+9MkuKgdPWGfrcdNuRisu9wyXIZEkgPlMzma5bny/S1iNXJxiuIwwrJx+PN3ZdkE05M6DZfMo8ECcdxgl/htDsjjwXAKXrf2U9tlMKpj4xyysaR0GkXF8MVW7xCD8pKGDQF4lHl6iHYtw/pW6PYgl6vDWkrEsagQcR7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYJzJ6ay; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b78127c5d1so4168357f8f.3
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 02:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755076219; x=1755681019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPjVIASm1GkOCEb3O2Hb4OqTyh7yl5zez7YxpcGCaIg=;
        b=hYJzJ6ayolbVpZaiIIfDO1exIzxFm+CijcxkviZDiLAEfhViW5WT4qkny5gG5u5bL2
         mIJbrlPsoFPdbWL756CLGhV3/yCV73uszghtWfBDrAqm9yCzcAA6gat1K2RKFBOqdJsl
         nJb2iCrcfelDrc4yZFuUB0Z1qJdrvNuLFbwgGK5FZ2hwNHr/6PQsyavRbKTJKpoOKRTp
         GPNi5LLGfD0/8i7FmWwVyOFHN3QXljC6k05H99B9gx/FkSTtkB3/ntCPTdUTneWTl66i
         LbmPNWEFVDXXG8Ijz6n5HY2Dd9HIpKUT4ooPuNQdz9OPvLlMmUTdOqfcaxzegl0M9y7s
         ocDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755076219; x=1755681019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPjVIASm1GkOCEb3O2Hb4OqTyh7yl5zez7YxpcGCaIg=;
        b=HuPyIX9lDTKcodyZriAKRIHjGcZH849pikN+5kmgLlW4tmpeDPhsT990NqjKqMB+6J
         8hsC+Cle6mYUx2ba++2K5TkLkMs5MaP1ZLN7xygYk695u17+AqwY3dzoRT8iDCH94UaA
         Lg5rxNHGzbi44XzXQEX4gBms/DGB93g76EUZ7jYplk68V8gL/AADFzcXpLRa1iyknkI/
         i2emzoFBEB+pEMIaYkTErXJYkYjzzibIFnOQRGyYsPriiMCzrw9ttGYeHNDkFMfNf+dg
         BJBjY9zACkCxCwYoidRmhVY0Wj6qlH1IfgNPdwb37TLOL2jUrtPO+hR0g/oPTvdiw+aj
         2P2Q==
X-Gm-Message-State: AOJu0YzCgoBf5WsFShR0b5ySQeMo2AqMcDu2puTqOXaNPYAK7vtaNd0U
	mTp8wwAzgJ1d5aEpdtAZe0nAW1mIbdrCw3coLhjcXUX4vxecfQMEM6to
X-Gm-Gg: ASbGncstzU+9o9M0NBq9d6Vajc7FoHCrEFv0EgRZT+oT0DCfpRj3ett5Y7vieBgu/Ja
	hYZyUX3FalWa/9ZhnWp1ncBW7ypT5Uli00dCDUAXLWf2FtWiqkcWccYVtptbFQJ3lAue3Mv8ZlM
	FhBV439k0FdI5O04R5BAvWoB1gPBmfNfxmA3offZnO7Z0rpwr5TW73b/gYIB2hS9DbSif8i5Ond
	CJrEB+h+EERRhVbeOR2Cx30x6h2VVJs62Y8OTXiNDfJELxH+T55mAg6T18OKNM5c7tsVMjGjDib
	YLA6Js+n39hTE06etNEw6JLt94g/cHlD9/fPn5tPsiJYY8bAgEsncm1H0Tt5JQC5WFZl2Kcn+pH
	trVnVhcWy2jljovyPs9lg8s3mxkMrmW03ToDNXp5ZBYu1pw==
X-Google-Smtp-Source: AGHT+IF4LL+TrycB+PQuQ3Dvpsk9jiNWu/4JlbkgHBUAXQFITG20vxIXFwAGwMdPmYZP68o/NhDh2w==
X-Received: by 2002:a5d:64e9:0:b0:3b7:907d:41c with SMTP id ffacd0b85a97d-3b917ea6117mr1843160f8f.35.1755076218703;
        Wed, 13 Aug 2025 02:10:18 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::26f? ([2620:10d:c092:600::1:f676])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abedesm47454790f8f.3.2025.08.13.02.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 02:10:18 -0700 (PDT)
Message-ID: <35ca9ed2-8cce-4dc8-bd15-2cda0b2d2ec5@gmail.com>
Date: Wed, 13 Aug 2025 10:11:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v1 5/6] net: page_pool: convert refcounting helpers
 to nmdesc
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Byungchul Park <byungchul@sk.com>
References: <cover.1754929026.git.asml.silence@gmail.com>
 <7be7a705b9bac445e40c35cd227a4d5486d95dc9.1754929026.git.asml.silence@gmail.com>
 <CAHS8izOMhPLOGgxxWdQgx-FgAmbsUj=j7fEAZBRo1=Z4W=zYFg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izOMhPLOGgxxWdQgx-FgAmbsUj=j7fEAZBRo1=Z4W=zYFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/25 01:14, Mina Almasry wrote:
> On Mon, Aug 11, 2025 at 9:28 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
...>> -static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
>> +static inline long page_pool_unref_nmdesc(struct netmem_desc *desc, long nr)
>>   {
>> -       atomic_long_t *pp_ref_count = netmem_get_pp_ref_count_ref(netmem);
>> +       atomic_long_t *pp_ref_count = &desc->pp_ref_count;
> 
> nit: I think we can also kill the pp_ref_count local var and use
> desc->pp_ref_count directly.

I stopped there to save the churn, I'd rather have it on top and outside
of cross tree branches. But I agree in general, and there is more that
we can do as well.

...>>   static inline bool page_pool_unref_and_test(netmem_ref netmem)
>> diff --git a/net/core/devmem.c b/net/core/devmem.c
>> index 24c591ab38ae..e084dad11506 100644
>> --- a/net/core/devmem.c
>> +++ b/net/core/devmem.c
>> @@ -440,14 +440,9 @@ void mp_dmabuf_devmem_destroy(struct page_pool *pool)
>>
>>   bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
>>   {
>> -       long refcount = atomic_long_read(netmem_get_pp_ref_count_ref(netmem));
>> -
>>          if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
>>                  return false;
>>
>> -       if (WARN_ON_ONCE(refcount != 1))
>> -               return false;
>> -
> 
> Rest of the patch looks good to me, but this comes across as a
> completely unrelated clean up/change or something? Lets keep the
> WARN_ON_ONCE?
I was killing netmem_get_pp_ref_count_ref(), which is why it's here.
It checks an assumption that's guaranteed by page pools and shared
with non-mp pools, so not like devmem needs it, and it'd not catch
any recycling problems either. Regardless, I can leave the warning.

-- 
Pavel Begunkov


