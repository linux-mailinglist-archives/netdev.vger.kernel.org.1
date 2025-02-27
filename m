Return-Path: <netdev+bounces-170183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3C1A47A53
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B78F3ABD8F
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF81F21ABB4;
	Thu, 27 Feb 2025 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+4KxdbD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D81487D5
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652267; cv=none; b=DZmUGJP6RoH3zxaTEsBPb7Bhng2Z7S6YRMZCnaCuEbqBy6h1xgSr45yiq9aSfx28Nvxw86/5TaCVE9P7C3yWJC8jeBWewVo1BwglZuDWPC8myp3S07GlxkFNsFO9DAiZ5vbvyTXmHXOUNiQXj8BsZ40SyCNGtu/IEpfnIAN+hpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652267; c=relaxed/simple;
	bh=+v3xkJS3XMAxcs9N3Ws2L/B6PJdrpS8kXHjrtO6boDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aj45EJAX2/hycDlbHkH1ZOkiNQpYC0cOH9s6jiw47PspdSY9jHNjoKRtO/CSuJDFmbjBX80rEM482VIDfiMpiMRhu7kJPn/JjT8xXJGHSmybqWK9DjgPEXndPZbs6AcBWJNWq7LQM/RGPVII+vobuZ4ylRObi3VUwJzgIF1JGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+4KxdbD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740652260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOkzrL8YRVS4cEWE0UGROaO1cYbN8EnDQwWGMEJe0oQ=;
	b=V+4KxdbD6nJrDeXTRcHvLHymz7PPYEl0S4QJnCKIBNNIp19VRqrPoZgmZJxH16QuEYX6x4
	nkcsCts1ZrqgjBtVvV/Gi41RyG1JOzJ1jilsYhCZ+lvREiThn1QHKT17jmuDa9K39h5Mq0
	wXa6LEG2RAXQSnUJxLZUXEFRJtGgYSw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-i8NF383cNSiaY6nMBS2K4A-1; Thu, 27 Feb 2025 05:30:54 -0500
X-MC-Unique: i8NF383cNSiaY6nMBS2K4A-1
X-Mimecast-MFC-AGG-ID: i8NF383cNSiaY6nMBS2K4A_1740652251
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4398ed35b10so4111745e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652251; x=1741257051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOkzrL8YRVS4cEWE0UGROaO1cYbN8EnDQwWGMEJe0oQ=;
        b=VngGrxDmEXRAyvWo9unRJPQ+jJzwAhEPrQJOcdcBh31hWiJwBc8DRAo+QrTU959OrL
         98j2gMtX/zQr5vggBph6krgO7jSqcCZMU512e71i8FKHeytKcS7T4/dTQ+Yf2uJzP7YS
         uK1SP2M7IHVlYYvwbRpsaoMKYyFaJEG8/UJQ670sMKhh7mPKmOo4s9GQst6tNBLTBTdv
         ZT7vPuuBZho8N8HcSV8UyUqogFze7cIpTsLJDN4uvRuGsuKvRWPRtoCgZLinZVw0AX5n
         V1Ao38OKZLIFzcC5Rsd+5BLkQYk2k1Siwu3+k6EtaIy2SGs0VSCwVIw9+6ghNzQRcUDJ
         m9wQ==
X-Gm-Message-State: AOJu0YyuAJEaYfAoSBIy8UtejAhc2E9ayRIwSMqV8LLWk6iKcf2kyMXm
	hktiga5P/VAS88znXxZv2uC849O35SiayKZjE9B81vopR0jR04J9HXTxDcIAusr2SW2O3km2Ubq
	W/7lf3AqaxDL7mK1G7GO6Vg7igXjO69npp2kgUqkk5d2h/aSlr+viKg==
X-Gm-Gg: ASbGncv3rnGsr32HVTV/JpcYvIfi1HL4OBF62FxD+kW6fq4PxaYMFSuW2tZpRGiBxQs
	mT3z5RPehCwVVv7VLyYvg7RsHY4JRpXrNIg9he0j36q9vAcaJN/xU0V9DOOxQOwNs8HYv3bZOOM
	qiwnyT+OV6aGkGQbtcwveL9iqYAZ9YUUJUt98dSGa3ydkIgTYXBWS1IJkuR7cIfhoWeGS0BFQP2
	WNifJqIFYmupBJdaeZxcOEcg2rpNw8dPIMQ7GN9oXbbjnm1H5Ut3WC5EMQRBBI0M6nUPJ3yT6y1
	UOEg4dj4k1Y1uIEVkvGAAY8bcclYLu+EgZ0WvQSckwbB4w==
X-Received: by 2002:a05:600c:3c95:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-439aebc2d5fmr171656765e9.21.1740652250891;
        Thu, 27 Feb 2025 02:30:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK6bHmySSujITFjcBPGuRs0PAR8EgMcRUkrPAM/8iUIqIbQEdpe+j6f1uiQXRHE5zW+7ZneA==
X-Received: by 2002:a05:600c:3c95:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-439aebc2d5fmr171656515e9.21.1740652250529;
        Thu, 27 Feb 2025 02:30:50 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47965f3sm1585669f8f.9.2025.02.27.02.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:30:50 -0800 (PST)
Message-ID: <e71aecb0-9636-42d7-a9fb-2ff9df817cd7@redhat.com>
Date: Thu, 27 Feb 2025 11:30:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ipv6: fix TCP GSO segmentation with NAT
To: Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
References: <20250224112046.52304-1-nbd@nbd.name>
 <CANn89iLi-NC=4jbNfFW7DELtHS2_JNAHiwRs7GbfZP2E9rGqXA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLi-NC=4jbNfFW7DELtHS2_JNAHiwRs7GbfZP2E9rGqXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/24/25 2:00 PM, Eric Dumazet wrote:
> On Mon, Feb 24, 2025 at 12:21 PM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> When updating the source/destination address, the TCP/UDP checksum needs to
>> be updated as well.
>>
>> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/ipv6/tcpv6_offload.c | 20 ++++++++++++++++----
>>  1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
>> index a45bf17cb2a1..5d0fcdbf57a1 100644
>> --- a/net/ipv6/tcpv6_offload.c
>> +++ b/net/ipv6/tcpv6_offload.c
>> @@ -113,24 +113,36 @@ static struct sk_buff *__tcpv6_gso_segment_list_csum(struct sk_buff *segs)
>>         struct sk_buff *seg;
>>         struct tcphdr *th2;
>>         struct ipv6hdr *iph2;
>> +       bool addr_equal;
>>
>>         seg = segs;
>>         th = tcp_hdr(seg);
>>         iph = ipv6_hdr(seg);
>>         th2 = tcp_hdr(seg->next);
>>         iph2 = ipv6_hdr(seg->next);
>> +       addr_equal = ipv6_addr_equal(&iph->saddr, &iph2->saddr) &&
>> +                    ipv6_addr_equal(&iph->daddr, &iph2->daddr);
>>
>>         if (!(*(const u32 *)&th->source ^ *(const u32 *)&th2->source) &&
>> -           ipv6_addr_equal(&iph->saddr, &iph2->saddr) &&
>> -           ipv6_addr_equal(&iph->daddr, &iph2->daddr))
>> +           addr_equal)
>>                 return segs;
>>
>>         while ((seg = seg->next)) {
>>                 th2 = tcp_hdr(seg);
>>                 iph2 = ipv6_hdr(seg);
>>
>> -               iph2->saddr = iph->saddr;
>> -               iph2->daddr = iph->daddr;
>> +               if (!addr_equal) {
>> +                       inet_proto_csum_replace16(&th2->check, seg,
>> +                                                 iph2->saddr.s6_addr32,
>> +                                                 iph->saddr.s6_addr32,
>> +                                                 true);
>> +                       inet_proto_csum_replace16(&th2->check, seg,
>> +                                                 iph2->daddr.s6_addr32,
>> +                                                 iph->daddr.s6_addr32,
>> +                                                 true);
>> +                       iph2->saddr = iph->saddr;
>> +                       iph2->daddr = iph->daddr;
>> +               }
>>                 __tcpv6_gso_segment_csum(seg, &th2->source, th->source);
>>                 __tcpv6_gso_segment_csum(seg, &th2->dest, th->dest);
> 
> Good catch !
> 
> I note that __tcpv4_gso_segment_csum() does the needed csum changes
> for both ports and address components.
> 
> Have you considered using the same logic for IPv6, to keep
> __tcpv6_gso_segment_list_csum()
> and __tcpv4_gso_segment_list_csum() similar ?

I agree with Eric, I think we should try to keep ipv4 and ipv6 code and
behavior similar, where/when it makes sense (like here).

@Felix, could you please update the patch accordingly?

Thanks,

Paolo


