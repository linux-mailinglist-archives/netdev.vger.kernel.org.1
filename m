Return-Path: <netdev+bounces-118103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1B5950841
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A1BB21BCE
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C920819EEA4;
	Tue, 13 Aug 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpldYlGb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95C19E81D
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560868; cv=none; b=fKuhmTBCX6mJO7taNFlR1X3FDWYq4dhy4CczhskXuPc5qhtqh8Kt4l2NcHDLW4DJfe9HK+ShjTZOazRerlwGL4cvTXmPLEe38LtCyCEFXyl/IadAsSgNS0cZnG0GabOsHPyL7H9lQQyD0fV3Wd1LLgVTM6ynY0sekEm3J6WKIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560868; c=relaxed/simple;
	bh=n6cl//mqacbow4XK6MKXBt50goulzRZkvMufWgu2XC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BlRuYptLYe59pCn7QXv0YPGIIZQBPT5i3xRD7yeT40wqLFA0kkcHH2H7YkY/hnWGOwKWtHcKMSHgSAI0u3P3ONHzLgZt6EQmWMwlFWVg4cbAeYOltfgUj2hQNhwoEQZ4FqyNXeTvU4qmsEb6w9oNC2KcwrTawVjU4mM0mvOg5eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpldYlGb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723560866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E6wxMvH5Stej7Yv5ATmISJ/l6opYMRxwGMga9kMqk9k=;
	b=RpldYlGbyjF7veiEvVhDDdCoAjMGDo4PUONiNJNVt3BOzM1OnqB95ii2nT+ZcBF1NX/438
	LOtgWCqyEea+eFOprgzUSpFFzYyet3ReDEJlITIEZKGlTg/HepLIsL/LTfr7nwHJP2sgK3
	yUyzQMnSy+uONpjaKT+ZqWUsHrgqE7w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-9a3n7EpcOoeZTeqhJ7dpww-1; Tue, 13 Aug 2024 10:54:25 -0400
X-MC-Unique: 9a3n7EpcOoeZTeqhJ7dpww-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428e48612acso64082935e9.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 07:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560864; x=1724165664;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6wxMvH5Stej7Yv5ATmISJ/l6opYMRxwGMga9kMqk9k=;
        b=pd5nEm6BPyGedW98w4sF65SAiUcR7Ky6AOtxuw7CbZAEhnPz/IsvEfqzpeNX9Wqa6k
         EUcbewIBcGEYzpCovmQFwFdn0gEGdZq8VlzhieKuOaPcBINQRO9a6h4bvgzYi9e+F38e
         gFj41d1aZh+8Zmc15tPfdoGme6MVMyFcSnGZwqNpqbHVBsNyEA9BeybztX7FNwnXJTLD
         YXQs2VdY99g+cjZxjnbke8HbWt9r8jYJQ1vVEiUO66mc1p4986kN8an5sNTmH/u7WSKy
         kVDPOHpgoRawbCmwQmRotdwC8cmUMRQ4C2i1Z+xpnfmGgu0vffK5Q/Ev0PU4E3sRf/gZ
         f1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv4aFLCDOLtDm88ItvTJglyDoqIlMeOnvhP5PR5+5s8va1CUxYPl4RuntWr/qIZb9boLf05P42tg9N8vGNCEp4KYdOJe2Y
X-Gm-Message-State: AOJu0YzHDRiTucce9gNouTs4gfL8JxjbV2Gurh924v2vZiIKKyvtzVTC
	HcwplxRSbO2ANDQsQyDW2hEwv3277Zgw0FsR6p3Koj158YG0E4hNOKj4V2nR/Cf41YV34tfctNH
	1fdlaQdaHRRejakyklJlPo0sHFx8OH5AC60vyT1p/KrGTPOq7ramoAg==
X-Received: by 2002:a5d:5284:0:b0:368:6606:bd01 with SMTP id ffacd0b85a97d-3716cd250c5mr2570176f8f.55.1723560863598;
        Tue, 13 Aug 2024 07:54:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoo4XWM+a6cr4sdY3abB/BPFL+oExtFb9xuFkxORKiSBgHvfqk12YWOOxnIo0yrvk1Sh4ZIA==
X-Received: by 2002:a5d:5284:0:b0:368:6606:bd01 with SMTP id ffacd0b85a97d-3716cd250c5mr2570152f8f.55.1723560862967;
        Tue, 13 Aug 2024 07:54:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c938045sm10651120f8f.43.2024.08.13.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:54:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9123D14ADF45; Tue, 13 Aug 2024 16:54:21 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo.bianconi@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Larysa Zaremba <larysa.zaremba@intel.com>, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, John Fastabend <john.fastabend@gmail.com>,
 Yajun Deng <yajun.deng@linux.dev>, Willem de Bruijn <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch
 to GRO from netif_receive_skb_list()
In-Reply-To: <e0616dcc-1007-4faf-8825-6bf536799cbf@intel.com>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <e0616dcc-1007-4faf-8825-6bf536799cbf@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 13 Aug 2024 16:54:21 +0200
Message-ID: <874j7oean6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Thu, 8 Aug 2024 13:57:00 +0200
>
>> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>> Date: Thu, 8 Aug 2024 06:54:06 +0200
>> 
>>>> Hi Alexander,
>>>>
>>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
>>>>> cpumap has its own BH context based on kthread. It has a sane batch
>>>>> size of 8 frames per one cycle.
>>>>> GRO can be used on its own, adjust cpumap calls to the
>>>>> upper stack to use GRO API instead of netif_receive_skb_list() which
>>>>> processes skbs by batches, but doesn't involve GRO layer at all.
>>>>> It is most beneficial when a NIC which frame come from is XDP
>>>>> generic metadata-enabled, but in plenty of tests GRO performs better
>>>>> than listed receiving even given that it has to calculate full frame
>>>>> checksums on CPU.
>>>>> As GRO passes the skbs to the upper stack in the batches of
>>>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
>>>>> device where the frame comes from, it is enough to disable GRO
>>>>> netdev feature on it to completely restore the original behaviour:
>>>>> untouched frames will be being bulked and passed to the upper stack
>>>>> by 8, as it was with netif_receive_skb_list().
>>>>>
>>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>>>> ---
>>>>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>>>>  1 file changed, 38 insertions(+), 5 deletions(-)
>>>>>
>>>>
>>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>>>> cpumap is still missing this.
>> 
>> The only concern for having GRO in cpumap without metadata from the NIC
>> descriptor was that when the checksum status is missing, GRO calculates
>> the checksum on CPU, which is not really fast.
>> But I remember sometimes GRO was faster despite that.
>> 
>>>>
>>>> I have a production use case for this now. We want to do some intelligent
>>>> RX steering and I think GRO would help over list-ified receive in some cases.
>>>> We would prefer steer in HW (and thus get existing GRO support) but not all
>>>> our NICs support it. So we need a software fallback.
>>>>
>>>> Are you still interested in merging the cpumap + GRO patches?
>> 
>> For sure I can revive this part. I was planning to get back to this
>> branch and pick patches which were not related to XDP hints and send
>> them separately.
>> 
>>>
>>> Hi Daniel and Alex,
>>>
>>> Recently I worked on a PoC to add GRO support to cpumap codebase:
>>> - https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016da5a2dd9ac302deaf38b3e
>>>   Here I added GRO support to cpumap through gro-cells.
>>> - https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa72401c7414c9a8a0775ef41a55
>>>   Here I added GRO support to cpumap trough napi-threaded APIs (with a some
>>>   changes to them).
>> 
>> Hmm, when I was testing it, adding a whole NAPI to cpumap was sorta
>> overkill, that's why I separated GRO structure from &napi_struct.
>> 
>> Let me maybe find some free time, I would then test all 3 solutions
>> (mine, gro_cells, threaded NAPI) and pick/send the best?
>> 
>>>
>>> Please note I have not run any performance tests so far, just verified it does
>>> not crash (I was planning to resume this work soon). Please let me know if it
>>> works for you.
>
> I did tests on both threaded NAPI for cpumap and my old implementation
> with a traffic generator and I have the following (in Kpps):
>
>             direct Rx    direct GRO    cpumap    cpumap GRO
> baseline    2900         5800          2700      2700 (N/A)
> threaded                               2300      4000
> old GRO                                2300      4000
>
> IOW,
>
> 1. There are no differences in perf between Lorenzo's threaded NAPI
>    GRO implementation and my old implementation, but Lorenzo's is also
>    a very nice cleanup as it switches cpumap to threaded NAPI completely
>    and the final diffstat even removes more lines than adds, while mine
>    adds a bunch of lines and refactors a couple hundred, so I'd go with
>    his variant.
>
> 2. After switching to NAPI, the performance without GRO decreases (2.3
>    Mpps vs 2.7 Mpps), but after enabling GRO the perf increases hugely
>    (4 Mpps vs 2.7 Mpps) even though the CPU needs to compute checksums
>    manually.

One question for this: IIUC, the benefit of GRO varies with the traffic
mix, depending on how much the GRO logic can actually aggregate. So did
you test the pathological case as well (spraying packets over so many
flows that there is basically no aggregation taking place)? Just to make
sure we don't accidentally screw up performance in that case while
optimising for the aggregating case :)

-Toke


