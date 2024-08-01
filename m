Return-Path: <netdev+bounces-114995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C22F944DCE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F2B2893E3
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210011A4870;
	Thu,  1 Aug 2024 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2lQZtyg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8616E1A3BC7;
	Thu,  1 Aug 2024 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521882; cv=none; b=EtXGpwuaxBllVAJKJw86JNGiZ7TuVDDfamdTdtI1A0O47PKpVwqbhZUqSZgYn8T+tljjYFdOqBlc+yNU4Ya/y9SY3jeO/Sdwwwr86dJ32qD+zhQDonk9bJ+YsOryOG/c5M1JY89c6K/5B7DH6vp5R/9dGmHnvZEoJc0/yMHk26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521882; c=relaxed/simple;
	bh=ZQdGR/lTp1NTsfZAb9/FFybF+DPr7n4rNP95bNdQLUM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=J7I7VU1zaYTRQ2qA6HItI7jPbo9kXxzZzlRd4YDZiDkatk3hUo2/AMv2sVHylOa3P1X0G7pFyVxhriL0luw7RHoTM/snbTzmpK6qZ9WsViA2SJCzUh+LLFL2E2eVzTkCgH5HSVDc1MZFeXQPW2nTMQzFIP+mzj9SXpcd02w4hdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2lQZtyg; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1e24f3c0dso429977085a.1;
        Thu, 01 Aug 2024 07:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722521879; x=1723126679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQdGR/lTp1NTsfZAb9/FFybF+DPr7n4rNP95bNdQLUM=;
        b=G2lQZtygcam9XH6qY54vA/krpt8edsR7vEc0Y8u+LfHKno38bCPDIuPoFLs28wG3ZC
         MHXcrALMskj1lziNCgMKVLwqgESVy6T27Jai9ShD7QBd7RBazuiKOIKlPfJ/1tZVsJA1
         G2My3m3n0TiJtcP94/hk09mIdzmakF97qx6ROWcSE8w1vet8ftOliYMMuoX70SgrAPSh
         Q4WRhCfCNQfPXYA3t4EYeGHQu9LQngPr5yZEYr+Ayvw4FA5DFcbZ4n5cFS9tcuth8xIf
         NmntfhmI2XBRy8YRO+XRzW/Iq/oQu9L5YDqXSUae/TzLdfehsdwVv0JRrUPhctfaFXRq
         4e4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722521879; x=1723126679;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZQdGR/lTp1NTsfZAb9/FFybF+DPr7n4rNP95bNdQLUM=;
        b=wtc8/2bWKt4xHSHACfYlAbbayLJ0M6YIdzUdPC4dcLtbfkXTQA7Cf2EUEA1wDGI9QC
         9gMh8VVhNxwdnVJ55xebfZBD8SBl8klZtWao6Qdh7u10YD19/CTzalkZ6lbl47R/Oh2k
         kwUyG1YFgqlkMwb7qTHCQrmNaeQ2VEWHYCIGfQLGKbFsYXRicC4CAILSM1dZU2VOisMC
         h7ZZK/BLPMTilhXIce0z9hdNFHg1GWtPE5/CODaGEumA/C5gbIQ1F3De58O8vUwmBis1
         sPdZj1D0NKJoKV8zumkOW5YbWsieXPUbc0PXbxJi0xV+hhr1gxhoXkbf86OXU3ZELKGP
         ZYDw==
X-Forwarded-Encrypted: i=1; AJvYcCUx5BZ8JBJqk3e4313FJ1i7EYOOFh2hfeYnYUcBIZgTJXvEuCFqPp3ptrxMrM0mxgDLQXhXhXSkEEKFRd6atv/vYmwFYcHSUZ2lW/aK
X-Gm-Message-State: AOJu0YxeQR5yfCJryjO3MQtLTnSjr7jCRLxA2rRouc5fS+dDwjxhsDAl
	CXGcmCUUcHF46Zi1hqWVPJO9IfXJbH+Y5bxQoJdVXpx1nv2gRFDVwLm5RA==
X-Google-Smtp-Source: AGHT+IFeczolI9BeIauW0gRVCzJaAtBNGLFBIF4rH/8rWqyeMDE6K60RXLfs2OFapNgvayIHrDg1CA==
X-Received: by 2002:a05:620a:17a4:b0:79e:fcba:967e with SMTP id af79cd13be357-7a34eec9fb7mr19919085a.13.1722521879208;
        Thu, 01 Aug 2024 07:17:59 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1dcc43dacsm770161785a.126.2024.08.01.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:17:58 -0700 (PDT)
Date: Thu, 01 Aug 2024 10:17:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Randy Li <ayaka@soulik.info>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org
Message-ID: <66ab99162673_246b0d29496@willemb.c.googlers.com.notmuch>
In-Reply-To: <343bab39-65c5-4f02-934b-84b6ceed1c20@soulik.info>
References: <20240731111940.8383-1-ayaka@soulik.info>
 <66aa463e6bcdf_20b4e4294ea@willemb.c.googlers.com.notmuch>
 <bd69202f-c0da-4f46-9a6c-2375d82a2579@soulik.info>
 <66aab3614bbab_21c08c29492@willemb.c.googlers.com.notmuch>
 <3d8b1691-6be5-4fe5-aa3f-58fd3cfda80a@soulik.info>
 <66ab87ca67229_2441da294a5@willemb.c.googlers.com.notmuch>
 <343bab39-65c5-4f02-934b-84b6ceed1c20@soulik.info>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue
 index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Randy Li wrote:
> =

> On 2024/8/1 21:04, Willem de Bruijn wrote:
> > Randy Li wrote:
> >> On 2024/8/1 05:57, Willem de Bruijn wrote:
> >>> nits:
> >>>
> >>> - INDX->INDEX. It's correct in the code
> >>> - prefix networking patches with the target tree: PATCH net-next
> >> I see.
> >>> Randy Li wrote:
> >>>> On 2024/7/31 22:12, Willem de Bruijn wrote:
> >>>>> Randy Li wrote:
> >>>>>> We need the queue index in qdisc mapping rule. There is no way t=
o
> >>>>>> fetch that.
> >>>>> In which command exactly?
> >>>> That is for sch_multiq, here is an example
> >>>>
> >>>> tc qdisc add dev=C2=A0 tun0 root handle 1: multiq
> >>>>
> >>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip d=
st
> >>>> 172.16.10.1 action skbedit queue_mapping 0
> >>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip d=
st
> >>>> 172.16.10.20 action skbedit queue_mapping 1
> >>>>
> >>>> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip d=
st
> >>>> 172.16.10.10 action skbedit queue_mapping 2
> >>> If using an IFF_MULTI_QUEUE tun device, packets are automatically
> >>> load balanced across the multiple queues, in tun_select_queue.
> >>>
> >>> If you want more explicit queue selection than by rxhash, tun
> >>> supports TUNSETSTEERINGEBPF.
> >> I know this eBPF thing. But I am newbie to eBPF as well I didn't fig=
ure
> >> out how to config eBPF dynamically.
> > Lack of experience with an existing interface is insufficient reason
> > to introduce another interface, of course.
> =

> tc(8) was old interfaces but doesn't have the sufficient info here to =

> complete its work.

tc is maintained.

> I think eBPF didn't work in all the platforms? JIT doesn't sound like a=
 =

> good solution for embeded platform.
> =

> Some VPS providers doesn't offer new enough kernel supporting eBPF is =

> another problem here, it is far more easy that just patching an old =

> kernel with this.

We don't add duplicative features because they are easier to
cherry-pick to old kernels.

> Anyway, I would learn into it while I would still send out the v2 of =

> this patch. I would figure out whether eBPF could solve all the problem=
 =

> here.

Most importantly, why do you need a fixed mapping of IP address to
queue? Can you explain why relying on the standard rx_hash based
mapping is not sufficient for your workload?

