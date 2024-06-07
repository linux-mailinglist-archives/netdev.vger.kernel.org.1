Return-Path: <netdev+bounces-101662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 169678FFC54
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897C128C4F3
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 06:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D0C154C05;
	Fri,  7 Jun 2024 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VinJrf7K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C854154C12
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742368; cv=none; b=WfI127gXIOG6tf+v4SwfnKwjsNdPaNgcdF7I1/Sifvi+dJs9mv75TUrXp/DNgV3HypaNJHk7TbumgpI3HfzI42ZCc51ZNIMvbf+qA//WFb5JyeR93QpOnHsLLnWj+m87otab2LCAdYL7L5n+q8AzKGJSjYKiMsO7uItyGgjzm0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742368; c=relaxed/simple;
	bh=BYMSRWUUkSA6XkO04VeTg8T/5G3D0T8FakYVcOs2tdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYF394aKkiAgtGiULSqU7KtGijIz/BEx5QTWWOLoPcK7GiQf9SF2T9OHYZwRXbMxyZP0NK+1UX5DL+fNV4r/zOjOooy2YzItpzPh5U7iNJY24pJ1t7HXMvvvE+1wjFYbvRGYXInAQld9p2okg7BIdDOzZAzSDCoe7jwqO0ToWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VinJrf7K; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso15938051fa.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 23:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717742364; x=1718347164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=piMDbhmCQk0OBuwRv35GHgfcS+SZ43/YLuGchRk/pqo=;
        b=VinJrf7K7gvV8bUxP4G7psnxuRMLWLMiQvH0/MscOI7mhJqmOQD4J6/1a17Jfb9vhf
         qB5yin7NPjisIrOsgQ8RqZp0RxOsixLOdjIJiwRqzZ+sqA4T4Ts09OtNzGEdyC3S+bvc
         yAV3nA+4Kwa1wj0hiRQ91DR69Ujn9mQLmQ3oBx89ynJf9TF+dFo8AO5goyHsH9dRVtkm
         l50RAUBM9n09t8XU/h7YNyXBkiVZfjMFxwM+MJSux/Wj+OR7JlG3gIpGEfTUHOJGSuxG
         rESIy/210k2dyjMCGMrN2TlYHjU3Bgp+LJbh8i7rD8HfonpohI8YHFyMp9HQHkCv38Mt
         qJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742364; x=1718347164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piMDbhmCQk0OBuwRv35GHgfcS+SZ43/YLuGchRk/pqo=;
        b=lFNsPxeAFbmSUDBvf2DdJvAnqCaqAyZ0RJMOWt9ebA47GVd3rfeJua5WQJfKhtbxQG
         ljsZNl430oSC3zUjhmxqzoMWF8X7VgIVuyl0WWXR99Tw8cbZ+wNXqWnAfrHEpDDTxVcD
         wBYYNw63IurJv3TsSJ/k6OPSwJKtvYaRd3lEvnrf+TnqGPr4dCHs94gubToQTeRp70Kg
         JJN81RiDTqAFXnrO961ai2hmcdQtgotTrodpCeGndYYP4hMNaZyg3T4A5A7Q4mK/wdGK
         DTl8e7EncQDfV1PmJjQZtLerANNhk66ufub1xxbAMeqHQbOKxkSBIPY//5ETk8QbzMHF
         E0pw==
X-Forwarded-Encrypted: i=1; AJvYcCXR3FMFZT3SxBlg6607yXjg81ivgAunPdf0OGpWS9d2zs+IpzgpuyZlDXvpCeYS0tky4zOB4yVVLC+Ea/ImgU6PoanhqPrs
X-Gm-Message-State: AOJu0YyIslEQyvLJ5/HyPgVnmF843MrTpqeNRkirUlumEStEzUOs1/HQ
	Nw7qSGZFTROb1Y4hpgFQkFZVT0DrDolItFp+R3LkOLYZycYMUgaPrCD2eqgWf2U=
X-Google-Smtp-Source: AGHT+IHkk2ZJMtE5Pt8tmFrEu5Kp9C6ZkZfrS8jDBp7qq+8A8hsD2w14r5KVEh3oPlmsh+AFrHfDhQ==
X-Received: by 2002:a2e:a589:0:b0:2e7:1bb6:2e8b with SMTP id 38308e7fff4ca-2eadce713c9mr11276921fa.35.1717742363811;
        Thu, 06 Jun 2024 23:39:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e67fsm44152205e9.2.2024.06.06.23.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 23:39:23 -0700 (PDT)
Date: Fri, 7 Jun 2024 08:39:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
References: <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>

Fri, Jun 07, 2024 at 08:25:19AM CEST, jasowang@redhat.com wrote:
>On Thu, Jun 6, 2024 at 9:45 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
>> >On Thu, Jun 6, 2024 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> >>
>> >> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
>> >> > > If the codes of orphan mode don't have an impact when you enable
>> >> > > napi_tx mode, please keep it if you can.
>> >> >
>> >> > For example, it complicates BQL implementation.
>> >> >
>> >> > Thanks
>> >>
>> >> I very much doubt sending interrupts to a VM can
>> >> *on all benchmarks* compete with not sending interrupts.
>> >
>> >It should not differ too much from the physical NIC. We can have one
>> >more round of benchmarks to see the difference.
>> >
>> >But if NAPI mode needs to win all of the benchmarks in order to get
>> >rid of orphan, that would be very difficult. Considering various bugs
>> >will be fixed by dropping skb_orphan(), it would be sufficient if most
>> >of the benchmark doesn't show obvious differences.
>> >
>> >Looking at git history, there're commits that removes skb_orphan(), for example:
>> >
>> >commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
>> >Author: Eric Dumazet <edumazet@google.com>
>> >Date:   Fri Sep 28 07:53:26 2012 +0000
>> >
>> >    mlx4: dont orphan skbs in mlx4_en_xmit()
>> >
>> >    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
>> >    completions) we no longer need to orphan skbs in mlx4_en_xmit()
>> >    since skb wont stay a long time in TX ring before their release.
>> >
>> >    Orphaning skbs in ndo_start_xmit() should be avoided as much as
>> >    possible, since it breaks TCP Small Queue or other flow control
>> >    mechanisms (per socket limits)
>> >
>> >    Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
>> >    Cc: Or Gerlitz <ogerlitz@mellanox.com>
>> >    Signed-off-by: David S. Miller <davem@davemloft.net>
>> >
>> >>
>> >> So yea, it's great if napi and hardware are advanced enough
>> >> that the default can be changed, since this way virtio
>> >> is closer to a regular nic and more or standard
>> >> infrastructure can be used.
>> >>
>> >> But dropping it will go against *no breaking userspace* rule.
>> >> Complicated? Tough.
>> >
>> >I don't know what kind of userspace is broken by this. Or why it is
>> >not broken since the day we enable NAPI mode by default.
>>
>> There is a module option that explicitly allows user to set
>> napi_tx=false
>> or
>> napi_weight=0
>>
>> So if you remove this option or ignore it, both breaks the user
>> expectation.
>
>We can keep them, but I wonder what's the expectation of the user
>here? The only thing so far I can imagine is the performance
>difference.

True.

>
>> I personally would vote for this breakage. To carry ancient
>> things like this one forever does not make sense to me.
>
>Exactly.
>
>> While at it,
>> let's remove all virtio net module params. Thoughts?
>
>I tend to
>
>1) drop the orphan mode, but we can have some benchmarks first

Any idea which? That would be really tricky to find the ones where
orphan mode makes difference I assume.


>2) keep the module parameters

and ignore them, correct? Perhaps a warning would be good.


>
>Thanks
>
>>
>>
>>
>> >
>> >Thanks
>> >
>> >>
>> >> --
>> >> MST
>> >>
>> >
>>
>

