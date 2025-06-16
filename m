Return-Path: <netdev+bounces-198111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801D8ADB457
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACD037A2E55
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F961FDE31;
	Mon, 16 Jun 2025 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GC/7SC/h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF082BF01A
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085049; cv=none; b=IIpoOmoPit00d2DhrjlYyzulJIJShEZlDNic9oou6f6gU1euRcAzfpstk+gJl3Zf//CmhwVdtRH6zRX/p4Qllj9aem7G1gZ4PhCjUruxyUHoHOoK9Iny4p4RKvZpvYm3swcQO3flEDZKZaEGaUeAG/XeeMRe0K++GbsypwJGqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085049; c=relaxed/simple;
	bh=r68hXWthixsq/vDA3Hw9WQcEEMiaWp7Jjs1bli+3bxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1vTvXe2gBn+30Na7QKidNO4aeaNogBq3weZi+hXXYg0OBslby2X6SSs20caUM2YwXa8d+CrvHnLBjSMFq0mYC4Ir0cviiv7B14YGpkHVBsz1ytNL44bODp3cTsYaxf1NX9FkT59TuNoDWi/vQBl6W8wzLnmXy52Iq6yEBS4I68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GC/7SC/h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750085046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHScNwCnpUccenhhbVCr+OS7r5DauzlWu2oujCOrqh8=;
	b=GC/7SC/hAGrMYEQq/UN7KsOVD+7cBwPfRgJ0k6gX10X/jtROIC2w99rW86c9CPHSMYcacs
	1vQIH7S5Dyk83G6HsZW0IAgtcMjdOH6P8VFu8QF0wrYfYVTSKPeMNJSRBBSu6RGZltTv4r
	xYZI3uMHRpjolwR2Vo+EKSWkjbP31l0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-o7HqxjQGPNabvfjNDJgq5g-1; Mon, 16 Jun 2025 10:44:05 -0400
X-MC-Unique: o7HqxjQGPNabvfjNDJgq5g-1
X-Mimecast-MFC-AGG-ID: o7HqxjQGPNabvfjNDJgq5g_1750085044
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-60724177b2eso3980484a12.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 07:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750085044; x=1750689844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHScNwCnpUccenhhbVCr+OS7r5DauzlWu2oujCOrqh8=;
        b=O9KifjrfcOkw9EKMFq4bCTavgSiRhk73L0J6lDDvrNC6Aowp//1J7JhcejqSDfr+0W
         pPTo4+QUX3fRsNFeTCUNTuBIOT3Wn+GxpuuenA4LfbH2N2rTSqSfi4FNMYrFD7jb7Z1r
         WSgvgr93dcBQrjiVcshvYkmb3x0rL2p7DB6O9afj2SCC65xjCeyiDr3vX52OUTsyJzPm
         wSzHrbFBlbvJ7WDCx5PgF8OJfBpdqT1O+FEtcP/e8htvDCa3oJDHr6JMvwLJkHrkkXRY
         j/xEul4c2vpX/IaV1kK3EmxgyrhP5MYIto+N+JjdzXC5MrLNDNX58xz+cXdcESUO7jza
         pcaQ==
X-Gm-Message-State: AOJu0YzBrVUTT1lhnFQLmVwoPb1Xikx/SwjmheZSCLvl38bAMlOPED48
	g6rdKOkISPOwhygNM3b+Tpkypu0+B/ppgT5izF55DSxENd0KNSWbAPPkugbgtxTchxLE4HPHpgQ
	yVR9gkdoytWn0M5XrQyfhc4A4pnlW9YasGFgrkHQTzUwssdY/GjgseCeWEmDbI2aWwy67
X-Gm-Gg: ASbGncs993R1Vf/qKUmXSZip5KNnw5S+ob2py4aTqhbUq/IDCb3eXkUjhH7WTJ7zjcf
	1/5X9FcNpCnRcjRPur1ZTsGxxGBVyviVfOm8/1P906EZngkM98Jm5eSZrm2DFsaZjvn+TS6pSZ1
	HtCIoUFdbYRKW3l0aDot563Om6K1ZZ8O3vOZoIZrWTP+pNUqPj6Wr6aEhzawEoWKfvGgr8RMLbn
	qjA6AiibCBWTxzh3IcuYooHKhFa984G7o+mjcuDQc0jfe/1UlgCOJ5BJUWDArDuTm3s0IbUFXER
	3O1rusQC64X6N5Sc4RgFBt+H5tbbNw==
X-Received: by 2002:aa7:d406:0:b0:609:7e19:f10f with SMTP id 4fb4d7f45d1cf-6097e19f78amr693298a12.0.1750085044027;
        Mon, 16 Jun 2025 07:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaoCPnLfQ6eFAqS/MPkDjxALZlUd+QrlFVaRN2i3HD5MNBB3kzvbXOVkYzhIX3OQvHwiGLBw==
X-Received: by 2002:aa7:d406:0:b0:609:7e19:f10f with SMTP id 4fb4d7f45d1cf-6097e19f78amr693271a12.0.1750085043604;
        Mon, 16 Jun 2025 07:44:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10::f39? ([2a0d:3344:2448:cb10::f39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48dd68fsm6369079a12.22.2025.06.16.07.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 07:44:03 -0700 (PDT)
Message-ID: <219613ac-2228-49ea-ba8a-23f54e760634@redhat.com>
Date: Mon, 16 Jun 2025 16:44:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 6/8] virtio_net: enable gso over UDP tunnel
 support.
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <d10b01bd14473ad95fb8d7f83ab1cd7c40c2a10e.1749210083.git.pabeni@redhat.com>
 <CACGkMEtP5PoxS+=veyQimHB+Mui2+71tpJUYg5UcQCw9BR8yrg@mail.gmail.com>
 <91fcc95c-8527-4b4c-9c19-6a8dfea010ac@redhat.com>
 <CACGkMEvTvYsECf8MOtTd7c1-YskUP-3rbec=qHTUuDgNLjPs6w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEvTvYsECf8MOtTd7c1-YskUP-3rbec=qHTUuDgNLjPs6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/16/25 5:20 AM, Jason Wang wrote:
> On Thu, Jun 12, 2025 at 6:18 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 6/12/25 6:05 AM, Jason Wang wrote:
>>> I wonder why virtio_net_chk_data_valid() is not part of the
>>> virtio_net_hdr_tnl_to_skb().
>>
>> It can't be part of virtio_net_hdr_tnl_to_skb(), as hdr to skb
>> conversion is actually not symmetric with respect to the checksum - only
>> the driver handles DATA_VALID.
>>
>> Tun must not call virtio_net_chk_data_valid()  (or whatever different
>> name will use).
> 
> Note that we've already dealt with this via introducing a boolean
> has_data_valid:
> 
> static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>                                           struct virtio_net_hdr *hdr,
>                                           bool little_endian,
>                                           bool has_data_valid,
>                                           int vlan_hlen)
> 

I'll keep the csum offload function separated, to avoid adding even more
argument to the common helper.

/P


