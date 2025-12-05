Return-Path: <netdev+bounces-243828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 334CECA8411
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 16:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62533251F4E
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C0A3176E7;
	Fri,  5 Dec 2025 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4Z3wYGc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gmy/H3IK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2C3081C2
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948184; cv=none; b=Js/QP2UJZSTsIcooR45qWJtkITmED6OTxHNgg3iTzlFiH9b9Lxln4ULaA3J1DTkGcd2GeLQhmc3CJbooWblTdcp8YcIhRhfhk2brfYRb7bCGeI69pj2fYOyfE7yKziDaVcebynps38DrS7yJIt5s/815rHOI88u2+LsV0b7THLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948184; c=relaxed/simple;
	bh=+3D6ev1MJ2IsOJ/SUeGWoDuJog7WRUni4Gm6Z/yOR/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5D4iEanYCcl88ekBDsowLnc5kzlLc53jujm5E47SdYTDhxgSXiIwpe1eTREd2sqsuHc5j5N2QYOITtXcjRzmRCpbh2L2pgm69KtRpgJ4buPLISG4SRcFUBlFRKV73NCSxUpAXyn0H/GoDmYOngTsZui6ewqfB8ci30qUyrsuRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4Z3wYGc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gmy/H3IK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764948180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7uMfSGh3fxRB0AoRdr8ecqtqXqJiHlbsjb4C7/a5Mk=;
	b=h4Z3wYGceMB8zcg9NJZQ1k3ID4jctw7vw5T2dInwgtmdFJyhvOltWkEX7xM9R28ej1EzNX
	8i/X5bJBquUV9Z4VPVCzim8q7ZuYKN3+sp3DQ6MJcHI+xx19FWIOxaeejRsfPCGRdHCaOF
	NABc4bGfUS+POssKwdDLdhoFODQveCo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-w1w9YLWOOXqSWdVDaAwhow-1; Fri, 05 Dec 2025 10:22:59 -0500
X-MC-Unique: w1w9YLWOOXqSWdVDaAwhow-1
X-Mimecast-MFC-AGG-ID: w1w9YLWOOXqSWdVDaAwhow_1764948178
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42e2e3c3e1aso1188049f8f.1
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 07:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764948177; x=1765552977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7uMfSGh3fxRB0AoRdr8ecqtqXqJiHlbsjb4C7/a5Mk=;
        b=Gmy/H3IKQePvVnCsmkWNMKk/r4XkLarLjoBDdqHvSiBUbiC0oVv5kZBWAd7In0YqC0
         EGlbf4FrPh/zn5bs2aUrms/EhgfPA+tF2BsiHqrBgA+isaS69sQukqu2MV+Xb92/gfyK
         U86obsil/MOOsQ3iyZft9+XNIQbVyxVJ9ZIkMzvUi+aQBoW6GTzdJ/87iSH1Ypb9Rb2f
         ad8Y+dZstG2luPDNy6u2R/THBwiilYvHnxRursKYYB/OOE5NdxBbhddMoZ0xcPjacJkK
         xlXJmRVd4QyyjRhB2S29+OYXoWjXZLMkdl/hgn/G4mesMKX4y5xpmo/wDgogLeZoWwrP
         0wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764948177; x=1765552977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7uMfSGh3fxRB0AoRdr8ecqtqXqJiHlbsjb4C7/a5Mk=;
        b=Lq0ur/w1oi35sgwWDY9elk08qz7qV9FB2DIjMVU1I4z6O3477Eup6mqTwaJYBu3SrM
         0Gr5DLstbt9aWcWEMP8D21eqDzhnLy0Y0bS4GgV1cI8DTKSjvNvhUJC/U6+zJBB/Fef8
         qTV+djwy1HvxwQyTPmPl16zUq2miga0bUsZryWZKIRB4Vd+Vs5vKjpafIhqmBs/n76Rj
         zaV7rhCocmQTlvcJCuA7fyGdlkWyYDCVDQn67dVCRt4jxqSWaMuZzfBGZeV1SkClxZbx
         2urJu19dzv7LNJzw7C6diVFDDk9AnToQBcCwf+ujBg+lN3BSKh1qhMCDT79izx7kPOfb
         mYfw==
X-Gm-Message-State: AOJu0YxBYzqFWVmbPCRoAxLq0JmZ+VVILTo+3jLWfz4h5kZhSdx1ld5H
	rauvTJaJkgeu5N5lkP2KwJzQLSDGg3kg/BLzT+/l3NrxOvJLs4Dz7RNkQN+sW/SYtNviDcDRdiy
	dvBiUPqRbAYQlxd/EqThMa29fagm8vaTaqJJShqES4v9RDyF/0IRBKPAyGPFoX3jGeg==
X-Gm-Gg: ASbGncu7qMj8Ed6m7Ez2l4k8cX1HkOZ2wtgGln4Y2/V0hKxKvu9kOmgnRFXEIBhKWzf
	jeod72n2EBK0yekYyHPOOAvOGVdjYzKR3jV7ScVz6tm1iht3XeI4xhb/oNH1BI2NobpScFfm9j/
	h5E+zZ92oQoiUAlRzHWmEszxDJajM3FQdwlA3MmOaQx2DPe6GQ/0I8Arx1TpddoejRTJiKzJuF6
	kxG8yE+PAW9H3eOOlUbCesUPFvQsXsugbgdSJo4vWcUNVlV1NO2wObQlRaWJdKTsnTmftsbffKp
	xTsecitkQD1/gDeLmFKckVbX+ceeear6u/nF0fperYxZ56u6xEhqF5wlLbz1Pd05rOcV9zf7IKk
	nZe6QzBe0vZnkUA==
X-Received: by 2002:a05:6000:2306:b0:42b:43cc:982e with SMTP id ffacd0b85a97d-42f731a303fmr10179826f8f.36.1764948177581;
        Fri, 05 Dec 2025 07:22:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj9diORAq7XZHLatehhfzj1xvhd0abr+mYPS6g19g9qoe+WM2petSDHTC+zF1I/KenhhBTSw==
X-Received: by 2002:a05:6000:2306:b0:42b:43cc:982e with SMTP id ffacd0b85a97d-42f731a303fmr10179805f8f.36.1764948177178;
        Fri, 05 Dec 2025 07:22:57 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee71sm9139629f8f.15.2025.12.05.07.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 07:22:56 -0800 (PST)
Message-ID: <bb866d37-6e89-460f-a411-e9f26b0fa4e4@redhat.com>
Date: Fri, 5 Dec 2025 16:22:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] net: gro: avoid relaying on skb->transport_header
 at receive time
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>
References: <cover.1764943231.git.pabeni@redhat.com>
 <98a7e20010265e3ebf9d7e6d6dfb7339d5db7b99.1764943231.git.pabeni@redhat.com>
 <CANn89iL3hp4Of_U+Yc34OrwVnTwn5j4j=WTq-yckGVcpptxcUg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iL3hp4Of_U+Yc34OrwVnTwn5j4j=WTq-yckGVcpptxcUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/5/25 3:37 PM, Eric Dumazet wrote:
> On Fri, Dec 5, 2025 at 6:04 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> Currently {tcp,udp}_gro_receive relay on the gro network stage setting
> 
> rely :)
> 
>> the correct transport header offset for all the skbs held by the GRO
>> engine.
>>
>> Such assumption is not necessary, as the code can instead leverage the
>> offset already available for the currently processed skb. Add a couple
>> of helpers to for readabilty' sake.
>>
>> As skb->transport_header lays on a different cacheline wrt skb->data,
>> this should save a cacheline access for each packet aggregation.
>> Additionally this will make the next patch possible.
>>
>> Note that the compiler (gcc 15.2.1) does inline the tcp_gro_lookup()
>> call in tcp_gro_receive(), so the additional argument is only relevant
>> for the fraglist case.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  include/net/gro.h        | 26 ++++++++++++++++++++++++++
>>  include/net/tcp.h        |  3 ++-
>>  net/ipv4/tcp_offload.c   | 15 ++++++++-------
>>  net/ipv4/udp_offload.c   |  4 ++--
>>  net/ipv6/tcpv6_offload.c |  2 +-
>>  5 files changed, 39 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/net/gro.h b/include/net/gro.h
>> index b65f631c521d..fdb9285ab117 100644
>> --- a/include/net/gro.h
>> +++ b/include/net/gro.h
>> @@ -420,6 +420,18 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
>>                                 struct udphdr *uh, struct sock *sk);
>>  int udp_gro_complete(struct sk_buff *skb, int nhoff, udp_lookup_t lookup);
>>
>> +/* Return the skb hdr corresponding to the specified skb2 hdr.
>> + * skb2 is held in the gro engine, i.e. its headers are in the linear part.
>> + */
>> +static inline const void *
>> +skb_gro_header_from(const struct sk_buff *skb, const struct sk_buff *skb2,
>> +                   const void *hdr2)
>> +{
>> +       size_t offset = (unsigned char *)hdr2 - skb2->data;
>> +
>> +       return skb->data + offset;
>> +}
> 
> I would rather switch gro to pass an @offset instead of a header pointer ?
> 
> Rebuilding one header pointer from offset is fast : skb->data + offset
> ( offset : network header, transport header, ...)

I considered such option and opted for the above for a very small
reason: it produces a little more compact (C) code in the caller.

I'll switch to offset in next revisions.
> As a matter of fact, some GRO state variables could be onstack, instead
> of being stored in NAPI_GRO_CB()
Do you mean the network offsets? In any case, I hope we can keep such
work separate from this one?
> This would avoid some stalls because skb->cb[] has been cleared with
> memset() with long words, while GRO is using smaller fields.Whoops, I never considered store forwarding induced stalls. Something to
ponder about for me.

Many thanks!

Paolo


