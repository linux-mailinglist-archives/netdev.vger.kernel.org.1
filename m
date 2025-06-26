Return-Path: <netdev+bounces-201467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB423AE9858
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4314C3A3C2F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D426828FFE3;
	Thu, 26 Jun 2025 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJAn7RwU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE728ECF5
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926678; cv=none; b=f4Gs1PzyACgm8R3EWhpsKcqIcreBY/mG1GW3yVao9p0V736DAhaLJFU525LnQ3G7/173+eAQI7ZV7yRP0zctn73EZAzuVub2ClCUBeYR4Y9jTSfNfmcDEvEv8xamCawwb+RfHFnBpDmBBoQb55vBMyNuPqNfFt0ihldZxztDMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926678; c=relaxed/simple;
	bh=jxjuQ9wgPEOgZ1M4BpcWDWVPCxKkyebFqlHE07IaLhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6oy0tLRW/vZNhTtnWKu/EQVGdFWogXtM5PisUVmj39mzktQP7ip8PCjD4Ku2qj0ZHIyLjvdlJtQ/ZqF3ywWshTxLshI9FIvAlOB87U3ETLToUX6pbDV/Y3aRpC71YQOhdb7x3sfjXgS5jijkdR1uSQIBo2QggqL2OYjgWDsXY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJAn7RwU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750926676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95+TH5zf3VfxYXqoppEfBpCyY5Bbh7o5fHE1mPx0EIk=;
	b=YJAn7RwUfNuUr+Q4C5U7IgRihaFyyy2Svr5Nlej20sTvlY5Pei+QDFNBp/6TVoNZEOGp/+
	3nvDgZ5pW7ixiAzE3wMOo0dgaBg3n4Y6dobluMuY3eKMWGb5JqYG1/76/c84yhdwU4FF8g
	U6l50pgmY5IYasK1lTJvonPd+jPCTDQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-mu7y1JQCMlSWXbyj8rl6kw-1; Thu, 26 Jun 2025 04:31:13 -0400
X-MC-Unique: mu7y1JQCMlSWXbyj8rl6kw-1
X-Mimecast-MFC-AGG-ID: mu7y1JQCMlSWXbyj8rl6kw_1750926673
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso3883675e9.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 01:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750926672; x=1751531472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95+TH5zf3VfxYXqoppEfBpCyY5Bbh7o5fHE1mPx0EIk=;
        b=Z7alWQtBe8xKOudHd4O7AIw79o3loAj94CxzMu52AgutiB5cmF3A63SZbh7iP84Itb
         Zrx4DtquLjCIcVrUuGcdXrmuiRsJzotvHAvgmIZd3s4XTVggSTeUlqPDGFbVWUFqLq16
         DEgwQWoLmlhBbeQEyvRgIhxqRubokmnSxfcd4Y/ZhZKC9ejtYw0hhAkdxS2IBNGQq10L
         ca+dguz5QkA6dpTu+9Z1dQAjAnJPOOnpdBmYsw2h7gPWZ+m+M0rAHnALBd0g4dIt0Sq5
         Ujz5HmkSb8BWH5l1Tp+bjk30YN4NAmYmVpwiYe40vIQz5EOfBVNWwyVWw5a996XpFVF+
         Mkdw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Ohv24yPX5wo92OxwuBUQA/5esgzgsZSi4xfDoD7lGVk7OZ1JSfGUNaleyRlK016KBrywu5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mAjKJ3BV+0q5ZYEhKFYocX/P+6EZgGN6DD5Lhp6u15RftA+/
	62tv+3s7Ok7C8ZpJVSs7qwdlkUNqdFPeBwB3USUrJ5KRueZpnlJ60NyTBVgR9TQKjDfjMR5elUN
	2ObJ49IudYyeYU+Vg5s5T2JlUylApazak27Cmr0AyMGzq0pulvIqhWcCIXHKNqaWyjmHp
X-Gm-Gg: ASbGncth8URmCEscVRRHz+cHLbI202lHHLV7VBRQ5AncVLG6llfBJ4deA2mPOgM91Ib
	/TGyHDPsMlKp4HgrYoHpaBlDnBhPk600ftZiCych2ST0qyIVgBOTwyYy+81Hp+Pfnc2VllTwX18
	fV76Xjo7VT/oL94Bz06VWjlhHLSTHUGj78WA6PhX/oUBWGWtDczuFRf7gSdypRjmJSxTt03AJNo
	Dot8qtsz46lEkjzIzOy64DJys2voTvkf/jqTt/HxFH29TtWtUZfYm+cTK/cr3ZK80fiMLtEvI57
	6hypPDTqA3H2cW9c/CzGus1YkrRRhcXbnvqJr6d/ikmlkTZQPgDvgopWbjP7R5UZh5xnpQ==
X-Received: by 2002:a05:600c:35c9:b0:453:79cb:7c86 with SMTP id 5b1f17b1804b1-4538896ba75mr26452185e9.3.1750926672263;
        Thu, 26 Jun 2025 01:31:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEkC6c3JzfgvdMBJsS8pD8FyDFy1HXtwXXY+jE56VYXru2VqYtKfWZqQhK2VhFj+bzWxrwqA==
X-Received: by 2002:a05:600c:35c9:b0:453:79cb:7c86 with SMTP id 5b1f17b1804b1-4538896ba75mr26451485e9.3.1750926671693;
        Thu, 26 Jun 2025 01:31:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c57d7sm44307735e9.40.2025.06.26.01.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 01:31:11 -0700 (PDT)
Message-ID: <a21e5d42-5718-4633-b812-be47ec6acf65@redhat.com>
Date: Thu, 26 Jun 2025 10:31:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] skbuff: Improve the sending efficiency of __skb_send_sock
To: Feng Yang <yangfeng59949@163.com>, stfomichev@gmail.com
Cc: aleksander.lobakin@intel.com, almasrymina@google.com,
 asml.silence@gmail.com, davem@davemloft.net, ebiggers@google.com,
 edumazet@google.com, horms@kernel.org, kerneljasonxing@gmail.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 willemb@google.com, yangfeng@kylinos.cn
References: <aFxBi55GlhVdHzE4@mini-arch>
 <20250626075020.95425-1-yangfeng59949@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250626075020.95425-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 9:50 AM, Feng Yang wrote:
> On Wed, 25 Jun 2025 11:35:55 -0700, Stanislav Fomichev <stfomichev@gmail.com> wrote:
>> On 06/23, Feng Yang wrote:
>>> From: Feng Yang <yangfeng@kylinos.cn>
>>>
>>> By aggregating skb data into a bvec array for transmission, when using sockmap to forward large packets,
>>> what previously required multiple transmissions now only needs a single transmission, which significantly enhances performance.
>>> For small packets, the performance remains comparable to the original level.
>>>
>>> When using sockmap for forwarding, the average latency for different packet sizes
>>> after sending 10,000 packets is as follows:
>>> size	old(us)		new(us)
>>> 512	56		55
>>> 1472	58		58
>>> 1600	106		79
>>> 3000	145		108
>>> 5000	182		123
>>>
>>> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
>>> ---
>>>  net/core/skbuff.c | 112 +++++++++++++++++++++-------------------------
>>>  1 file changed, 52 insertions(+), 60 deletions(-)
>>>
>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>> index 85fc82f72d26..664443fc9baf 100644
>>> --- a/net/core/skbuff.c
>>> +++ b/net/core/skbuff.c
>>> @@ -3235,84 +3235,75 @@ typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
>>>  static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
>>>  			   int len, sendmsg_func sendmsg, int flags)
>>>  {
>>> -	unsigned int orig_len = len;
>>>  	struct sk_buff *head = skb;
>>>  	unsigned short fragidx;
>>> -	int slen, ret;
>>> +	struct msghdr msg;
>>> +	struct bio_vec *bvec;
>>> +	int max_vecs, ret, slen;
>>> +	int bvec_count = 0;
>>> +	unsigned int copied = 0;
>>>  
>>> -do_frag_list:
>>> -
>>> -	/* Deal with head data */
>>> -	while (offset < skb_headlen(skb) && len) {
>>> -		struct kvec kv;
>>> -		struct msghdr msg;
>>> -
>>> -		slen = min_t(int, len, skb_headlen(skb) - offset);
>>> -		kv.iov_base = skb->data + offset;
>>> -		kv.iov_len = slen;
>>> -		memset(&msg, 0, sizeof(msg));
>>> -		msg.msg_flags = MSG_DONTWAIT | flags;
>>> -
>>> -		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
>>> -		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
>>> -				      sendmsg_unlocked, sk, &msg);
>>> -		if (ret <= 0)
>>> -			goto error;
>>> +	max_vecs = skb_shinfo(skb)->nr_frags + 1; // +1 for linear data
>>> +	if (skb_has_frag_list(skb)) {
>>> +		struct sk_buff *frag_skb = skb_shinfo(skb)->frag_list;
>>>  
>>> -		offset += ret;
>>> -		len -= ret;
>>> +		while (frag_skb) {
>>> +			max_vecs += skb_shinfo(frag_skb)->nr_frags + 1; // +1 for linear data
>>> +			frag_skb = frag_skb->next;
>>> +		}
>>>  	}
>>>  
>>> -	/* All the data was skb head? */
>>> -	if (!len)
>>> -		goto out;
>>> +	bvec = kcalloc(max_vecs, sizeof(struct bio_vec), GFP_KERNEL);
>>> +	if (!bvec)
>>> +		return -ENOMEM;
>>
>> Not sure allocating memory here is a good idea. From what I can tell
>> this function is used by non-sockmap callers as well..

Adding a per packet allocation and a free is IMHO a no-go for a patch
intended to improve performances.

> Alternatively, we can use struct bio_vec bvec[size] to avoid memory allocation.

If you mean using a fixed size bio vec allocated on the stack, that
could work...

> Even if the "size" is insufficient, the unsent portion will be transmitted in the next call to `__skb_send_sock`.

... but I think this part is not acceptable, the callers may/should
already assume that partial transmissions are due to errors.

Instead I think you should loop, batching bio_vec_size tx each loop.

Side note: the patch has a few style issues:
- it should not use // for comments
- variable declaration should respect the reverse christmas tree order

and possibly you could use this refactoring to avoid the use backward
goto statement.

Thanks,

Paolo


