Return-Path: <netdev+bounces-267048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOoeCX+0smmYOwAAu9opvQ
	(envelope-from <netdev+bounces-267048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:41:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C49271EF6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7270303C034
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712132F6900;
	Thu, 12 Mar 2026 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfXGuCJY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOeU5bZY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318923C4F2
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319194; cv=none; b=OaV8BA3lBLYUbhcVpkSBbbll7uSX09HzxfIzkRv5tfVQlRMK2GxL6I4+VGK7fHl8ZbniuSu3eMUI6IzSlXxh3zVxb2loX8jXU+S/t/xP6qN0uWOav5LzWgb/qojmn5tDksfzRv2N0w1BM9Q3xxOIqsF+agL/jOGWpQD9mY782qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319194; c=relaxed/simple;
	bh=yJE7TmVpzak2737yOceLZuLfEbjJw0atog4/kCv+aYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVdGcw43X/xSS5WQXZRa/P9rps4pndbsazDEF+Qeroa151rDwmXteyGxVH3CppDKX/nRe97I6mKF50BnHw1eVxF6XwCNyHGkePhKqnT7RkEWsjoSbuN7zEXI45nHyE2ebPWblANDX30I5w+yZ9873usXhfI+SvOCfpsTxtSKAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfXGuCJY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOeU5bZY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773319192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwq1D47F5ROQxQyd90bopM9phl1aU+B811r3GRsAdNI=;
	b=IfXGuCJYX/HxL7q6TYk68MKTcnprtAEkUrTGUahYRKCAPC9NEA1txHInyJO8B/xai2NBQ6
	zz/JE7HbgXz54xINR/6BYfUAhWqyoibcA4iNfxtCAWCJCeXoQk9d9HQe+0pFlGADJ5AwDV
	zuMEeSEedWPUnXzD6k+F+0ecye+mgos=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-XMlF-0lfMLa5VUfl6XKdgA-1; Thu, 12 Mar 2026 08:39:50 -0400
X-MC-Unique: XMlF-0lfMLa5VUfl6XKdgA-1
X-Mimecast-MFC-AGG-ID: XMlF-0lfMLa5VUfl6XKdgA_1773319190
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4853b0af42aso12483185e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773319189; x=1773923989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwq1D47F5ROQxQyd90bopM9phl1aU+B811r3GRsAdNI=;
        b=VOeU5bZYXPCDZwaK4Rda7h7K3CTo5cxKcjQFXVGYsmr4pe95rgVM1dBankFdWfFwsD
         V4YoB8gtSxX/CPA8a4hVRkzKe3XUarj8SBrg2oCk+3CX6WdgWLrdfqyanfTWuNLH5EL+
         bL0IR0NNOjKk7EIVDRHK9ezCvkt0i+BtwGlRJPeObCqPSLQ3F3Fuh3fdw+mR8w1NIjbI
         uVAl+VMZA2ly9Vy8qOHXHHm1mhcbaNuYZ9BWmbVsZcshlWW4LIpEE0V8zxRgzux03rwY
         Lp9Ec3msev/1NS5XAtua0EyBMUUC3jmkA3hFsz5m+8xSBY9wDjMT8pUx4aa2JTA+U+FM
         mWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773319189; x=1773923989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwq1D47F5ROQxQyd90bopM9phl1aU+B811r3GRsAdNI=;
        b=uzUJAgVsNd/GfJvQW2BHmsI3P8Geb9f8kxjSdkly0waWBqYubyABSJxgyM/yBJZ9Lx
         3HPrhsr+lOsmKbkJXzM0ZIbweW24/h1YRwqDgnfagJM+/qjRWlFhp0k4VVITQgIpWf1W
         B6ksar2R5jhHdahgtRKpNbZri25IK8maVVEMqiEgVUv1HNG4dyBah3uNBRllOJrx1K8k
         EZv/THaGxduBRJ2cbdyN+neC4QBuZYC0TcgaPwViniKTXb4egmIjVDmS9tjxzAKd2zIO
         RF5ZD0+e1orbL7jmfzNvyLbMZuLNfAu2aQo/DK9Yubi8TB7Gb9ph6DmjLD+zUvRWviV2
         7cfA==
X-Gm-Message-State: AOJu0Yyiv83JnrF9cD0SB2V/7ZEz7K07oLU8bjdTu3EE3LOObV8F7x5A
	o60BbUqY+Y7zIe2t400B42wmcbbGgdGrTBNPJEmJhYA2m/HeSNs5J/hCGPOpHhKcx9nHCRX0P1F
	/3oOuZsjlM/vZkkcXjysIYLy0uCtiXJAtI9DrzeDAzuCw6qyfzZDG7Zlvig==
X-Gm-Gg: ATEYQzxdKEGrgGKabfAHdP7RDsgvRYj95Ni74VT1WZqM0DfgLEpmUDRo4Z+WZ5LpzRR
	+5TOHeeul2YS8FVcRZSItOGopIMjApXa/24UkzY30ElUTpXpHSOLCyB3OgYty1EQ+ZaJyoT4Cya
	mOwWy4sMylCYS+afRl1teXbYH7BpBaZ3FUPT8pGiSFGs0aFuvClDsEuTD4kwlbVd+ZZfqgjkhmk
	NodIvkOTDZ268yxn55YOhAm/jVPAYcf4O38CHVqko9AE+2+K1NDjJh3nARLU+y8bh2+wjkjQN5C
	B3q0BSZkaRwgH/vqZNRzlmTf+/r3/ZNo34cPq2k/mVlJf9y9wawsarf1SA6Sju1VS7my+jPaasA
	dOqw9hyFHkA4bb7EEEv6xV/73WYQhD6uRhjdd3jTWq5WuzoJNn6iy+hM=
X-Received: by 2002:a05:600c:a44:b0:485:4100:1eee with SMTP id 5b1f17b1804b1-4854b10c539mr102303895e9.24.1773319189479;
        Thu, 12 Mar 2026 05:39:49 -0700 (PDT)
X-Received: by 2002:a05:600c:a44:b0:485:4100:1eee with SMTP id 5b1f17b1804b1-4854b10c539mr102303525e9.24.1773319189051;
        Thu, 12 Mar 2026 05:39:49 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0caccasm97722845e9.6.2026.03.12.05.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 05:39:48 -0700 (PDT)
Message-ID: <a544e971-a22e-47f0-b085-70ea743a4dc9@redhat.com>
Date: Thu, 12 Mar 2026 13:39:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] xsk: remove doubled defines
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 kuba@kernel.org, horms@kernel.org
References: <20260310134327.422540-1-maciej.fijalkowski@intel.com>
 <abCOYwySxuQnkq_k@mini-arch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <abCOYwySxuQnkq_k@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-267048-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83C49271EF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 10:34 PM, Stanislav Fomichev wrote:
> On 03/10, Maciej Fijalkowski wrote:
>> Seems we have been carrying around doubled defines for unaligned mode
>> logic. Remove one of them.
>>
>> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> ---
>>  include/net/xsk_buff_pool.h | 7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
>> index 0b1abdb99c9e..ccb3b350001f 100644
>> --- a/include/net/xsk_buff_pool.h
>> +++ b/include/net/xsk_buff_pool.h
>> @@ -174,13 +174,6 @@ static inline void xp_dma_sync_for_device(struct xsk_buff_pool *pool,
>>  	dma_sync_single_for_device(pool->dev, dma, size, DMA_BIDIRECTIONAL);
>>  }
>>  
>> -/* Masks for xdp_umem_page flags.
>> - * The low 12-bits of the addr will be 0 since this is the page address, so we
>> - * can use them for flags.
>> - */
>> -#define XSK_NEXT_PG_CONTIG_SHIFT 0
>> -#define XSK_NEXT_PG_CONTIG_MASK BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
>> -
>>  static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
>>  						 u64 addr, u32 len)
>>  {
>> -- 
>> 2.43.0
>>
> 
> All consumers seem to be in net/xdp/xsk_buff_pool.c, 

AFAICS there are users in xsk_buff_pool.h, too:

$ git grep XSK_NEXT_PG_CONTIG_MASK include/
include/net/xsk_buff_pool.h:#define XSK_NEXT_PG_CONTIG_MASK
BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
include/net/xsk_buff_pool.h:    xskb->frame_dma = (dma_pages[addr >>
PAGE_SHIFT] & ~XSK_NEXT_PG_CONTIG_MASK) +
include/net/xsk_buff_pool.h:#define XSK_NEXT_PG_CONTIG_MASK
BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
include/net/xsk_buff_pool.h:           !(pool->dma_pages[addr >>
PAGE_SHIFT] & XSK_NEXT_PG_CONTIG_MASK);

> so why not remove the defines from xsk.h instead?

Indeed it looks like the macro definition is duplicated multiple times.
@Maciej: could you please drop all the unneeded dups?

Thanks,

Paolo


