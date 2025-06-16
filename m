Return-Path: <netdev+bounces-198028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBAEADADA4
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C20160F5B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2733294A11;
	Mon, 16 Jun 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7dUwk83"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6872882D6
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070615; cv=none; b=DF95bbLe5LZ3soq5S/VaakCwvMHs/d+CI3MNRkxaQuBE4q5SXWzjm7I47EYHiOgUIJNlgl3UZQZClj8TLowimt83KgQNGexMKoT61AmrXz/3aztewL0zsuj/qgds3wiICDPWyf8XfYIUEy2Q2OOdRfzPsbllvom0zXEdLMMTBFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070615; c=relaxed/simple;
	bh=Tdiy+EpukQ4K3ojfL8KK5TUoQ+OGMtcXjNL++iAWyM0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ITIjRYhucKZIHuwBFh+KgvUvBgqTRxeslQ01kvR8Jofx3Z5HWZEuxWOu0JzQZwBDRUGa2c7oV20rUl0kF2Zdo1qDTNky+7gqIdGlRanWrIjcaYljgrQnR5QShN0/OlJULOFA/ZwEB3+KiMYGweLhGR0wWrpuZgBAV8m6CB66RB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7dUwk83; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750070612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqwgF3KIsJC/zzmpNahbXeh9cQDjOZhKbBNAvsADPbY=;
	b=F7dUwk83vv8+gDDLCCvlunkDO6DubU3ZNZdjFv0W7jw5WG1vQof/ji80L5ABeCsS24phqv
	FYu4fSNdzPiBRt1YzdNyxx82pNhKt7cfJQUwZtCIiLpb6ItI/9phAxKLgY6BJbd3UYE5bR
	lBsFPr+k50b3Lbv67EbqQfuxyN5X1zQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-tFakp0hXPa20jvphuaQ3Gw-1; Mon, 16 Jun 2025 06:43:31 -0400
X-MC-Unique: tFakp0hXPa20jvphuaQ3Gw-1
X-Mimecast-MFC-AGG-ID: tFakp0hXPa20jvphuaQ3Gw_1750070610
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so2003656f8f.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 03:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750070610; x=1750675410;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqwgF3KIsJC/zzmpNahbXeh9cQDjOZhKbBNAvsADPbY=;
        b=ZD4ifkNVME5erhP8Eu7UHqPSw6wq2c44ZuEygaEPQDMwSU7PX6DUZeUzOJiHjzy9gR
         QCJoIH9NVdQiFBNuNwOAv/mnpHDuGVod52sLFGtMogiCCtcvosoBiaNjhuttTtX4F3WA
         tu4U5DSADbPvzP2VhfAqZDseP/zs3jJqsANBu2JIzpi1PrP2y6z/J1zsUxLuXAmXR5PV
         iXfB/K0s/zs5kTuLOcH1JrcPWAODImTzwFIFz69Mj7hes/q1UibtZAnIjTBxid4s76qO
         8+DI9dpCGfFDIlSsZWwX07iWXoV+p6DpOsZNUQhkU1Iunpc2IlwpVwC1UzIda3bEIjN8
         6r4A==
X-Gm-Message-State: AOJu0Yy9Uq+PXtaVdmSmVGpV/amzXrqlza4LJuC5ob9YhJpwUZ3eIBHS
	/rjd9dDm8UMwrrUenywXUReiwzxxUaPRW0X62HpoLB6oMhcOH1slreN8g0pnlBaYmXS4wribRi/
	QJv2iPvEoHRvjlrlvS39XijJID7GeSW2Gb9SXoUcUU08Nqju9IwWGWvn07A==
X-Gm-Gg: ASbGncuhehxKo1tKe5qEEHtbAcl9YWiOeHnR+Wp57zjHaW1Si+QhpWErrZmgLaAzJef
	jixGC4fBk9kXaJZai4xOIFXXagKLC0zdjs0JtmFOst0rzCv6c512mExXwprl+1r7caPeCbOUhRn
	inAA2vHMvtqsxSeoUT1cnXRT8z/OpkbUwoexXPXTcwNAoDLyWfB/aOsN1uKWHn7wpKZMy8LQOoS
	PK0x5FGbW164ldc4PyfpehHfhCH1arwbW0gwqyMp+qsIBX64GjuIbtkkTjh6R6QmNG8qaLxI5Wm
	wUpu1fUY7OjCwDkGduQiF6SrbdFsOQ==
X-Received: by 2002:a05:6000:2308:b0:3a4:f939:b53 with SMTP id ffacd0b85a97d-3a5723a3ae0mr6597137f8f.38.1750070609906;
        Mon, 16 Jun 2025 03:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+U+PYctwPchAhXuqHC+kpjT9FCttdoDpAxFzqZR1Y8R0jgDBTgF8HzcUGugArzCSccbPbrw==
X-Received: by 2002:a05:6000:2308:b0:3a4:f939:b53 with SMTP id ffacd0b85a97d-3a5723a3ae0mr6597114f8f.38.1750070609391;
        Mon, 16 Jun 2025 03:43:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10::f39? ([2a0d:3344:2448:cb10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54aeasm10914307f8f.14.2025.06.16.03.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 03:43:28 -0700 (PDT)
Message-ID: <a1a4b28d-2bc2-4968-9e79-18ced60f8cb0@redhat.com>
Date: Mon, 16 Jun 2025 12:43:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 7/8] tun: enable gso over UDP tunnel support.
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <a38c6a4618962237dde1c4077120a3a9d231e2c0.1749210083.git.pabeni@redhat.com>
 <CACGkMEtExmmfmtd0+6YwgjuiWR-T5RvfcnHEbmH=ewqNXHPHYA@mail.gmail.com>
 <b7099b02-f0d4-492c-a15b-2a93a097d3f5@redhat.com>
 <CACGkMEsuRSOY3xe9=9ONMM3ZBGdyz=5cbTZ0sUp38cYrgtE07w@mail.gmail.com>
 <1f0933e0-ab58-41b8-832b-5336618be8b3@redhat.com>
Content-Language: en-US
In-Reply-To: <1f0933e0-ab58-41b8-832b-5336618be8b3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 12:17 PM, Paolo Abeni wrote:
> Anyhow I now see that keeping the UDP GSO related fields offset constant
> regardless of VIRTIO_NET_F_HASH_REPORT would remove some ambiguity from
> the relevant control path.
> 
> I think/hope we are still on time to update the specification clarifying
> that, but I'm hesitant to take that path due to the additional
> (hopefully small) overhead for the data path - and process overhead TBH.
> 
> On the flip (positive) side such action will decouple more this series
> from the HASH_REPORT support.

Whoops, I did not noticed:

https://lore.kernel.org/virtio-comment/20250401195655.486230-1-kshankar@marvell.com/
(virtio-spec commit 8d76f64d2198b34046fbedc3c835a6f75336a440 and
specifically:

"""
When calculating the size of \field{struct virtio_net_hdr}, the driver
MUST consider all the fields inclusive up to \field{padding_reserved_2}
// ...
i.e. 24 bytes if VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO is negotiated or up to
\field{padding_reserved}
"""

that is, UDP related fields are always in a fixed position, regardless
of VIRTIO_NET_F_HASH_REPORT (and other previous discussion not captured
in the spec clearly enough).

TL;DR: please scratch my previous comment above, I'll update the patches
accordingly (fixed UDP GSO field offset).

/P


