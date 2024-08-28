Return-Path: <netdev+bounces-122868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C355F962E79
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 19:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0A2284D80
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88A51A7068;
	Wed, 28 Aug 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="YrieHuyL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620719F470
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866094; cv=none; b=ReFjCyxw8mP1pcy/0EKGiKC16yRArzFq9hIgmjUpTiKl6S62NqShH8EdbkWHY+QT+D+Dj8b6/sta49YZQgdySF7ZIxV8hq2GLE1UV80qLKfmjE+ql/OhZkJv43i4xD9lnNjc0FPC3z8nkC5v3ejmykHhBrdE+PMzKzwAup+yALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866094; c=relaxed/simple;
	bh=HypgDgtB4ct/OuJkz4CzqDuTTpFOG82yJbB3Gp9Nl3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYWjZQpPBtqVAAGviRqftWlVoRI4+8UDcKS040qRqPrnI/cHNgWQoAOXAw4S94EOpR12HBge07mv7weGbQ2PG7l+Hep7TYFbDWoM1Az7K3X6Hne5KEUMEOadE3iUaOqchOMzlNpNvpHwrao2l9CH10sp7ZsF/Y5UqlEVLIwdssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=YrieHuyL; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6d0e7dfab60so16348717b3.3
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724866092; x=1725470892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCPXRj4O3bcsketV9hnxl4fQbKxvadzaMLv4xTGbmvw=;
        b=YrieHuyLcaRqzVQYQoFYLCTswDKpIhgqW+kiyQ4rLa3Xa5DyiG5ftqU35tnxwzWHqV
         zl1BAx2Gv8ZgHhewgd14S5s1wtRw4q/H15nm/Y1mRq0Wt8eT5qG09aYYBwTjtuF8Rd9T
         EXMGNqv8w7Y+M36LSZJxoaNng7qxlLKZ6n5N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724866092; x=1725470892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCPXRj4O3bcsketV9hnxl4fQbKxvadzaMLv4xTGbmvw=;
        b=mybAZnJS5e4ua/tcG5uTkrwkynF5GS86OdVIE23LpHkiCz3bL5cYQOFO/B5kaq5kfB
         i87/iAeU/jh3vzuTTKVmCeELWGJa4zoLJC60HW8EDOFi4kxbR31qsIfDzou9kxtlUGyu
         hDchixWUs1oiAHCrmQwyW7zAyzvq+OoADJvyWGyY2MgwqKn7BVZFWXhbSnKS4wIjiqub
         gGq0zcuzgG+LYJMp5tof/sUAoo0y9x4uLbZKcFcA/m/psUsvjEk+C8SAuHVlr9El3v9J
         BmIWyPkfVIfWgJr0GPBIq2fRprUqeuE8fesmOeGkNrNXN9TIXAlb8dDPe7+Z2iUwsQRZ
         gRYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz8HUut+s/c9qu32gW+FbBg1vnYLXZT0c8bFe6AbiPsW33SoBNSSZZcg3YLf7hwhQubVZ2Xwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJc6WzVGfEFQ99tQ2/Zhquvnb8JdIf7PTbXH0baNER9WNmdqal
	HopAFsasA8YjKyOCX16BmeKqssElJnIYZuftlwVFib6sGZ5kdsLtDDiHxQKUgXh1riBQqCCVEgP
	KynRqFg==
X-Google-Smtp-Source: AGHT+IFPC41Qak2gZ0YGJ2D7BiYZJ3IUJn9Ef3OAyW792KU6hAe4yKyakK/6d00Omzjp9FW2G84t4Q==
X-Received: by 2002:a05:690c:6512:b0:64a:4728:ef8 with SMTP id 00721157ae682-6d277f51e62mr651667b3.44.1724866092130;
        Wed, 28 Aug 2024 10:28:12 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:b4f6:16b8:9118:2c1a? ([2603:8080:7400:36da:b4f6:16b8:9118:2c1a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39de41cb8sm24217897b3.116.2024.08.28.10.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 10:28:11 -0700 (PDT)
Message-ID: <41a2a533-549e-4f45-9d8d-68b5ef484b05@digitalocean.com>
Date: Wed, 28 Aug 2024 12:28:09 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Why is set_config not supported in mlx5_vnet?
To: Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com,
 sashal@kernel.org, yuehaibing@huawei.com, steven.sistare@oracle.com
References: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
 <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com>
 <fd8ad1d9-81a0-4155-abf5-627ef08afa9e@lunn.ch>
 <24dbecec-d114-4150-87df-33dfbacaec54@nvidia.com>
 <CACGkMEsKSUs77biUTF14vENM+AfrLUOHMVe4nitd9CQ-obXuCA@mail.gmail.com>
 <f7479a55-9eee-4dec-8e09-ca01fa933112@nvidia.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <f7479a55-9eee-4dec-8e09-ca01fa933112@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 8/27/24 11:54 AM, Dragos Tatulea wrote:
>
> On 27.08.24 04:03, Jason Wang wrote:
>> On Tue, Aug 27, 2024 at 12:11 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>
>>> On 26.08.24 16:24, Andrew Lunn wrote:
>>>> On Mon, Aug 26, 2024 at 11:06:09AM +0200, Dragos Tatulea wrote:
>>>>>
>>>>> On 23.08.24 18:54, Carlos Bilbao wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I'm debugging my vDPA setup, and when using ioctl to retrieve the
>>>>>> configuration, I noticed that it's running in half duplex mode:
>>>>>>
>>>>>> Configuration data (24 bytes):
>>>>>>   MAC address: (Mac address)
>>>>>>   Status: 0x0001
>>>>>>   Max virtqueue pairs: 8
>>>>>>   MTU: 1500
>>>>>>   Speed: 0 Mb
>>>>>>   Duplex: Half Duplex
>>>>>>   RSS max key size: 0
>>>>>>   RSS max indirection table length: 0
>>>>>>   Supported hash types: 0x00000000
>>>>>>
>>>>>> I believe this might be contributing to the underperformance of vDPA.
>>>>> mlx5_vdpa vDPA devicess currently do not support the VIRTIO_NET_F_SPEED_DUPLEX
>>>>> feature which reports speed and duplex. You can check the state on the
>>>>> PF.
>>>> Then it should probably report DUPLEX_UNKNOWN.
>>>>
>>>> The speed of 0 also suggests SPEED_UNKNOWN is not being returned. So
>>>> this just looks buggy in general.
>>>>
>>> The virtio spec doesn't mention what those values should be when
>>> VIRTIO_NET_F_SPEED_DUPLEX is not supported.
>>>
>>> Jason, should vdpa_dev_net_config_fill() initialize the speed/duplex
>>> fields to SPEED/DUPLEX_UNKNOWN instead of 0?
>> Spec said
>>
>> """
>> The following two fields, speed and duplex, only exist if
>> VIRTIO_NET_F_SPEED_DUPLEX is set.
>> """
>>
>> So my understanding is that it is undefined behaviour, and those
>> fields seems useless before feature negotiation. For safety, it might
>> be better to initialize them as UNKOWN.
>>
> After a closer look my statement doesn't make sense: the device will copy
> the virtio_net_config bytes on top.
>
> The solution is to initialize these fields to UNKNOWN in the driver. Will send
> a patch to fix this.


With Dragos' permission, I'm sending a first draft of this now.


>
> Thanks,
> Dragos


Thanks, Carlos


