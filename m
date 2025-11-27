Return-Path: <netdev+bounces-242197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B19EC8D539
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00983AEB51
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 08:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E6321428;
	Thu, 27 Nov 2025 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDTLN+os";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="luWlKylI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F11CEAA3
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764231864; cv=none; b=eD2DI+Ca6vBAV6GPdKTnsTLQwWTmVhG2oTHKE1XCXFOV0edNw6WeTJvDYReBNtF7+UkxGDuCfGiVUF0twdRrASaxVu4YCNejurV1Kj5vePcxCCOc+56qSKSa4YOXVLxk3utvXm8hKu6n2XT8Qzw0V5pVeN+WAY6zJvd7tmeiwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764231864; c=relaxed/simple;
	bh=dnQSLqfX0zGavAQraHWIWlX32/F12Xpr0C/EiVk4nsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVuRZM29kYygI8FB1sYhinefnGvQxOr3QRCxVCKlxNtyYm0akYr8ic9j2XyEwnbh+ziNG8oWm1R1JZIqqpOErvSqlg+GyA2lLhQXmXpKE/3UFud5pVVbHxDMpSv4raLhCIPwYgmu55zgDd9j1Vajv4XnkcXe0OWMS0wUGaMmJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDTLN+os; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=luWlKylI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764231859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oh9tIL6xVGFoq0wzCwtNFdsSlYysZSo3HuXen4Lsmus=;
	b=HDTLN+osaWUi6726v9/J9NIzor9kF6bn7W+k0onY0WILlWiF9A7XoDLfUWjjd9ygc5jpyV
	8P3EtZc3Risk0Flz3UQuttr3dggBQWrrKq7ublZ2YnkKBzO6yXCQWKlNrRYKcTQiwZLgOK
	yHa/xblQ6eVUi1PzYol2yoiwdgqCKPo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-1KFW3VVOOv-lUZsaKVD7Mg-1; Thu, 27 Nov 2025 03:24:18 -0500
X-MC-Unique: 1KFW3VVOOv-lUZsaKVD7Mg-1
X-Mimecast-MFC-AGG-ID: 1KFW3VVOOv-lUZsaKVD7Mg_1764231857
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2ad2a58cso272537f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 00:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764231857; x=1764836657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oh9tIL6xVGFoq0wzCwtNFdsSlYysZSo3HuXen4Lsmus=;
        b=luWlKylI9WKW20ZhASOshpvYV2cKLc8t1JeULR9wQI5CUiECbdudj7w4V7k1DjeaEC
         tFhar3iIcPCxIRD7Ny2MYWsirPqw6xIK3o6OlWMOjAxogCeCLH8Nl/MEh7dBJuAXS5U/
         ywwDitcAP2kncJhMUWTi8BdSNxW1EISNmEnHhj08pUXr3IZ/w5d8s3WpK69t9x0f3fwi
         yE7blrcgiQRDqStGFr/TRS0laSWAJrDn1xz+CPF4UIorI6nBObQ3FWQgFnvuvrJNplRo
         H27yiN6ObtNqUDyPtvXfzRUNLatk4+/8M6GVmGAbj+U+IYsFVLNcyD+0/3bu4xUo5sed
         oS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764231857; x=1764836657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oh9tIL6xVGFoq0wzCwtNFdsSlYysZSo3HuXen4Lsmus=;
        b=gSSNLjZyIGNTcawYPZoq8SevKPByaTKsQMI88ohyJuPEsHPSfNapspWtoPA17Tcuir
         yLb3rQdtLBf07fQFWu0/cNQ4WzO6DO4Kcd8RkNysPJo2BrSDpikKp1Xhm/RWEVdatC0w
         EDfqDeotZZMG9+hk3hP2P71plkmnHuPjDRUGyCkPirNFUKG3bTRWBpv5FHCSlFLsyWjZ
         C30jcI9cOAS0+FE72WovBVJbL2hnQbeUJTOrDb8i8dl7GRq0+yfxwO1aDZkG7FzsFX0V
         kEAesUmQVd0a7232YDCg0I5ytlm5i+sFsBqG5teyGovQsz5a9yP5XnlovWNMRlppX4z2
         7ptg==
X-Forwarded-Encrypted: i=1; AJvYcCWRSR6GH725XYF0qst0F1xXsKKTXbcLPuU1YlJ5nmREk02J9Z3+U3UgJvbWORuyltpZDZG7QXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKu/XqTwFQbMlQpfxrOyXvLZGm8LQpuSzSlBaJDLlSVKMzRYE8
	MGQtrRYvdHTvtvQgNlhG7ric8S57lwiXbvc/Emc0NVVN6j5OX1wFwSh57YVXqBBnI8hszHa685Z
	8y0KQUgZMIFJtpMEkdDh9qxJBnFcLxOV59Z8mQ2eh/1Zas95B+v6LPkk17A==
X-Gm-Gg: ASbGncsAhkUdPaQIlT9J99RfG0R0L8CXUXMVAYL4UMBDU7nDYeH5b1loIXHNRAHrrEO
	2Fw/NmlqCLzrUAOVezD/D8Xe3g/8P9pVWKaUb8rEaCS9hwtDow9hpcH8mopCJBtqBKNFqLyC6cS
	5c+pOzVVG8g7QN/udvtgupy++8xwThenXBXUQHv6dztMSqSfWYtPLSvFxru9AkzCfWc8uJ5cDgU
	s6U+JJaS8ZwnfAIJljqIzbMSeY4BOnBHRLHh1rAboDfrkQB1y3aryZODYhNR3e5stg/Lo88QYQY
	MZDH/mMuWvX2T6T/Am8dLV5/dGky6ZSqFa/CPGlCwKH7C4d64qtQ3vWZCTE5OGH7aVz5UTioNlc
	7Gbx728a0jtLZaQ==
X-Received: by 2002:a05:6000:601:b0:42b:4219:269 with SMTP id ffacd0b85a97d-42cc1d0cf4amr22389284f8f.41.1764231856895;
        Thu, 27 Nov 2025 00:24:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAOizx0rWwPYosIKVqg+o1AjQe2dAxiQeCyuhdEDI/AZ/ORHXtIrnYoAB5FiiWxhXFn0qHKA==
X-Received: by 2002:a05:6000:601:b0:42b:4219:269 with SMTP id ffacd0b85a97d-42cc1d0cf4amr22389246f8f.41.1764231856484;
        Thu, 27 Nov 2025 00:24:16 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a6fesm2280190f8f.20.2025.11.27.00.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 00:24:16 -0800 (PST)
Message-ID: <8e3dc2e5-cf5f-483a-9119-8b1ac958e425@redhat.com>
Date: Thu, 27 Nov 2025 09:24:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] ipvlan: Support MACNAT mode
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xiao Liang <shaw.leon@gmail.com>,
 Guillaume Nault <gnault@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Julian Vetter <julian@outer-limits.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Etienne Champetier <champetier.etienne@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: andrey.bokhanko@huawei.com, "David S. Miller" <davem@davemloft.net>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
 <20251120174949.3827500-2-skorodumov.dmitry@huawei.com>
 <3d5ef6e5-cfcc-4994-a8d2-857821b79ed8@redhat.com>
 <25e65682-9df4-4257-94cd-be97f0a49867@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <25e65682-9df4-4257-94cd-be97f0a49867@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 9:13 AM, Dmitry Skorodumov wrote:
> On 25.11.2025 15:58, Paolo Abeni wrote:
>> On 11/20/25 6:49 PM, Dmitry Skorodumov wrote:
>>> @@ -597,6 +690,9 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
>>>  	port = ipvlan_port_get_rtnl(phy_dev);
>>>  	ipvlan->port = port;
>>>  
>>> +	if (data && data[IFLA_IPVLAN_FLAGS])
>>> +		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
>> This looks like a change of behavior that could potentially break the
>> user-space.
>> Hm... What am I missing? The intention was to know "mode" a bit earlier
> and generate MAC as random for macnat-mode.. it's supposed to be just
> a simple line move a bit upper in the code

I misread the code, and I wrongly thought that the new location was
before `port->flags` initialization, but it's not the case.

The comment removal did not help. Please preserve the comment above the
relevant statement/assignment.

Thanks,

Paolo


