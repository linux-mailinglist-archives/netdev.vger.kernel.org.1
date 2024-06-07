Return-Path: <netdev+bounces-101758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444FB8FFFED
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFAB1C211A3
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA713C69E;
	Fri,  7 Jun 2024 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="w7Df8UwP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4005DDD9
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754266; cv=none; b=u05j1xDB7qvySQCa0dAH1k7bHjp8OBF7LYgxZzMnGqGq/G3qbVAAVeMa+kdH87+q/HA04DiXf+3GtTTZMD1XorFmGA3tiWFv4Kj5899sO3mzzgjHDX6Yy5cCMe15STQwM2IM3S4ZmiQC6oUpge2uCe4taA/v110Tqmz473hd1LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754266; c=relaxed/simple;
	bh=/YVauGNkxfZmCtpgAS2qjdG1HQlwrBhQuUEQVIVA5E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OER1nnvQncwS+Y0ZCdCO77i1aOOBguTNxbub00dXkGUSo495WiDwB/XJNcySbxf8n2R3mznCnbTB0tmF92SKRXkh2xY01SoMcwgdsrEVsz+qiCYg4YN1yN13r9Z8L87pRcr9FfFVdvPUqcvnonJEfsFBjXT5VvV24m0zzhvuNs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=w7Df8UwP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so1665235e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717754261; x=1718359061; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lX/OsBtlFYO6Y1jhc0Js+/gWtM87drYmKWJU/1wy0xg=;
        b=w7Df8UwPBsBMkAzuO38C4eSaWOjLVTg9D/Lrlg9stMsKXEoHRj46/TsbfvzaxT7PDu
         BbJZsPmKpwAjECBmd4BJBGpqS32iC+lNbXXqDJ2lRpFr0/zB/jicDk3P43+4RXOL1ol8
         34aDXlaEOxNdqeO7Ho1VJonXVYvP6q5ZvGmCV3kpXpMXXX5WO/d6NpCXAH26KaJksE7a
         S7zU88mdF4f5wGZ9XodysV7vWfUnbN+iDeI/Epo7PybQ7CjLUyIZ/IsET0nZItV29HCG
         +aipwlY5iOphSEzuUNeKNz0ua26KGEKo2guhgnP9bKpcaYtomdkP+QwZB6rVtmH2mZT8
         f3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717754261; x=1718359061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lX/OsBtlFYO6Y1jhc0Js+/gWtM87drYmKWJU/1wy0xg=;
        b=XoCI3AYlpcw2TDRp1xSKlr/aglbZfTOz/3l4rkjA1i73zF929gjZtpyul9aDPQdiPp
         1Llx4j/bWX0JlyKSNOk/t+pNfSzAoK0b/9sX9gSt2t7IfVsdczQA/x5NmrLQtaa5U8jY
         niyLTkzvz9VvSz7vGo+f8Tnql1mIWAnudK5yW6Dj7HEGTth6QMim60mb7/VJIWxUpjEq
         Xr+OjSp1dHbJGM7cAeg1cm2w4xY/HAk6y1UnUaIVEtbPH27cC/aZ56eM6RUQVC62fwop
         q+Kxj4O27TTbD3W5mmKEuQ1z5sw4rK20cQY/ioZbr+UQY8OtZfvV1pgj+pmtNJs2TiFg
         cj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwmuX6dTyUQksk8WFuCVGhgGbZfAToSXayfW4y3WtH3jBIYLK/jdAV5eqhsqfFN0QU0g/zoeVbpePxpEwkIEwaKxHCRdNQ
X-Gm-Message-State: AOJu0YxpWksRfX8xGHWGItx/+UNbQ3X+7QoO8AitzKARodM4b/lxmF6s
	vr7gtkiRBQUFHq82/V4WSGRFXk23lebJJi0G4HreLsEerWyuElbRZGR88VwWaCY=
X-Google-Smtp-Source: AGHT+IGiT+DP9lfy1eyklkV6A+U2eSaMxY6fdfTimXtGyCadSjz3weq17UsEuiihRR50xbG06KxRiQ==
X-Received: by 2002:a05:600c:524e:b0:421:4754:c49a with SMTP id 5b1f17b1804b1-42164a20cd0mr21493755e9.31.1717754260933;
        Fri, 07 Jun 2024 02:57:40 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215811d992sm79620645e9.26.2024.06.07.02.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:57:40 -0700 (PDT)
Date: Fri, 7 Jun 2024 11:57:37 +0200
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
Message-ID: <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
References: <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
 <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>

Fri, Jun 07, 2024 at 08:47:43AM CEST, jasowang@redhat.com wrote:
>On Fri, Jun 7, 2024 at 2:39 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Jun 07, 2024 at 08:25:19AM CEST, jasowang@redhat.com wrote:
>> >On Thu, Jun 6, 2024 at 9:45 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
>> >> >On Thu, Jun 6, 2024 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> >>
>> >> >> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
>> >> >> > > If the codes of orphan mode don't have an impact when you enable
>> >> >> > > napi_tx mode, please keep it if you can.
>> >> >> >
>> >> >> > For example, it complicates BQL implementation.
>> >> >> >
>> >> >> > Thanks
>> >> >>
>> >> >> I very much doubt sending interrupts to a VM can
>> >> >> *on all benchmarks* compete with not sending interrupts.
>> >> >
>> >> >It should not differ too much from the physical NIC. We can have one
>> >> >more round of benchmarks to see the difference.
>> >> >
>> >> >But if NAPI mode needs to win all of the benchmarks in order to get
>> >> >rid of orphan, that would be very difficult. Considering various bugs
>> >> >will be fixed by dropping skb_orphan(), it would be sufficient if most
>> >> >of the benchmark doesn't show obvious differences.
>> >> >
>> >> >Looking at git history, there're commits that removes skb_orphan(), for example:
>> >> >
>> >> >commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
>> >> >Author: Eric Dumazet <edumazet@google.com>
>> >> >Date:   Fri Sep 28 07:53:26 2012 +0000
>> >> >
>> >> >    mlx4: dont orphan skbs in mlx4_en_xmit()
>> >> >
>> >> >    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
>> >> >    completions) we no longer need to orphan skbs in mlx4_en_xmit()
>> >> >    since skb wont stay a long time in TX ring before their release.
>> >> >
>> >> >    Orphaning skbs in ndo_start_xmit() should be avoided as much as
>> >> >    possible, since it breaks TCP Small Queue or other flow control
>> >> >    mechanisms (per socket limits)
>> >> >
>> >> >    Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >> >    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
>> >> >    Cc: Or Gerlitz <ogerlitz@mellanox.com>
>> >> >    Signed-off-by: David S. Miller <davem@davemloft.net>
>> >> >
>> >> >>
>> >> >> So yea, it's great if napi and hardware are advanced enough
>> >> >> that the default can be changed, since this way virtio
>> >> >> is closer to a regular nic and more or standard
>> >> >> infrastructure can be used.
>> >> >>
>> >> >> But dropping it will go against *no breaking userspace* rule.
>> >> >> Complicated? Tough.
>> >> >
>> >> >I don't know what kind of userspace is broken by this. Or why it is
>> >> >not broken since the day we enable NAPI mode by default.
>> >>
>> >> There is a module option that explicitly allows user to set
>> >> napi_tx=false
>> >> or
>> >> napi_weight=0
>> >>
>> >> So if you remove this option or ignore it, both breaks the user
>> >> expectation.
>> >
>> >We can keep them, but I wonder what's the expectation of the user
>> >here? The only thing so far I can imagine is the performance
>> >difference.
>>
>> True.
>>
>> >
>> >> I personally would vote for this breakage. To carry ancient
>> >> things like this one forever does not make sense to me.
>> >
>> >Exactly.
>> >
>> >> While at it,
>> >> let's remove all virtio net module params. Thoughts?
>> >
>> >I tend to
>> >
>> >1) drop the orphan mode, but we can have some benchmarks first
>>
>> Any idea which? That would be really tricky to find the ones where
>> orphan mode makes difference I assume.
>
>True. Personally, I would like to just drop orphan mode. But I'm not
>sure others are happy with this.

How about to do it other way around. I will take a stab at sending patch
removing it. If anyone is against and has solid data to prove orphan
mode is needed, let them provide those.


>
>Thanks
>
>>
>>
>> >2) keep the module parameters
>>
>> and ignore them, correct? Perhaps a warning would be good.
>>
>>
>> >
>> >Thanks
>> >
>> >>
>> >>
>> >>
>> >> >
>> >> >Thanks
>> >> >
>> >> >>
>> >> >> --
>> >> >> MST
>> >> >>
>> >> >
>> >>
>> >
>>
>

