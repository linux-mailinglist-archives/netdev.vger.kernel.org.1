Return-Path: <netdev+bounces-205086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4138CAFD265
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFBD18949D2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C04E2DD5EF;
	Tue,  8 Jul 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKl9JPb3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B022E337A
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993006; cv=none; b=T8LKS/8x3dpqk2Ck5LYv/8AQIIPJ+PBlMuvBWXwlTRP6bLZzTYIe8g5pCSxS8M0PWRBQAmliAn42qAoJd2MBoRLlcZv5hVRNKs9ofaLXdEB/xVv5YBeSuzmT8yBajzdHQq0AjKztNpwODuClepSFznCDcKMy5n4CtCg4/cqSddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993006; c=relaxed/simple;
	bh=zQQQOEa5mGNWa7KTGLmTSEf3V/CaEx2+ad3NkwQOBVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlz1/qDv0HU0Goocvt5+DzsWoEovaFdRK5wGRVJSS+VqLTLRu3cmHlZZ1ERxfe4wbiduEFkmLnZPazTEXFio+wW4/av0RqjYJ2OPjv7iZCA6wFg/qZ6svlznRQq7r24Q25sohO+orRVkexg5/N2K0YPLBZJJAmSaauMRvbUgGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKl9JPb3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751993003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRu3ITxR3iyfhxILJrwVnHOIYgR/CWymufaJy1Cpzno=;
	b=SKl9JPb39uEDA2I3EKz7zSgU4JGx2mhgPxKg2Lr4Z01pQE5MZ9mJMjuLFlnTsTC6/X/z3X
	utLmi9hLMBYP5uTHzve8rVM+rDzgtqnLy1YCO2qLkloc6hexXds3JbpYKc8UYrom6+O+ir
	cGPNmaum0Wo1XVifa+HS/7X9SRHwyJE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-QG8CUyTINseUCNcCiLCNnA-1; Tue, 08 Jul 2025 12:43:22 -0400
X-MC-Unique: QG8CUyTINseUCNcCiLCNnA-1
X-Mimecast-MFC-AGG-ID: QG8CUyTINseUCNcCiLCNnA_1751993001
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso26387365e9.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 09:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993000; x=1752597800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRu3ITxR3iyfhxILJrwVnHOIYgR/CWymufaJy1Cpzno=;
        b=DFVWwYwnyvJHaTsJvStNrc6KuYoGRSD+G7hxhu57BK3jZmlfPHE/DSZk58Wr8xNp/X
         QgZMq+net40TDB9PgNITta0qHYXct9EslD/WWnppDgbp6xbSdGe4BPY+5KvP150JRAYp
         m9ov9X8Qcv+QtlR6xrvKfz4x+TJbkPQsO7EMA11H3i6fMDO+SXe0XQYT/gDTg+iJ+R8O
         EeZ7Y8d9NlcfT7k33Fc7FRU/5N73JJT28GeybZGYlHk9XfnVZ16Yp4Ko/tmlrkEjMa0Z
         Vo5Q7n3oSOH6Khx5RnGGMA2YUWIor1xtqdP06qwSsPwT5NgC7P0yYVYXs7zBNj8Ku7nT
         kU5w==
X-Gm-Message-State: AOJu0Yy5mOnU3jb+/kh7mIFsX8ebJi0X8fH1/jH9vGbX3XCX6Lxy8occ
	GuDwo9ypT6kP6gxdNYPozwpO/b9v9+1UTLms9JD5FOgmQGVWg+PNCYNr0bVvqwP1MGJQvYr5Tkx
	v+ZCJGEmJUmBgXd7vOBpN/LwSy+fu1aBERagl19PcGMfzHwSfgNNpdothl5mQscp9pg==
X-Gm-Gg: ASbGnctZdfYEQIL4jkfa9sVWWN7KqQ0RTyL161ZCfOeWlkeWkjz9mNG0Jusvj5nzl9S
	CW2Lwm9eGFEKLxuWzPfKDkLCS9UiXGD21m3tdYlU251hHE1o7jLQEZOEPHZIPV3Pu/t00+bdj6d
	Lg5VTjkftwI31PSfJtX1pDX871qYubmDpmzITmpVxWFbip3ruPviFDvk26tQDVxA+KTraxnkA+H
	K5O6hohd6V31DXE4Tf2wRzwjnjCaP8EFwsumY1bWBmiQ7OSupfgtBDzktX5y/f3R5pNn6TbiEAq
	vtedTGL6AHv665NA5IupoIaQStHqqotDG/YOzcEY1w7cWcN16vjFvuHZWCTc/VBIhyCcZw==
X-Received: by 2002:a05:6000:2087:b0:3a4:ee3f:8e1e with SMTP id ffacd0b85a97d-3b4964e5281mr14417953f8f.39.1751993000357;
        Tue, 08 Jul 2025 09:43:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoaIacReEb0vPyg2KsNrIYN4x3Ccy8WpA/YPm0UdY/EajOw0cVDGdH65ySWm0a4fAJVxH+hQ==
X-Received: by 2002:a05:6000:2087:b0:3a4:ee3f:8e1e with SMTP id ffacd0b85a97d-3b4964e5281mr14417934f8f.39.1751992999900;
        Tue, 08 Jul 2025 09:43:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b472446fddsm13597522f8f.66.2025.07.08.09.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:43:19 -0700 (PDT)
Message-ID: <27d6b80a-3153-4523-9ccf-0471a85cb245@redhat.com>
Date: Tue, 8 Jul 2025 18:43:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 0/9] virtio: introduce GSO over UDP tunnel
To: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org
References: <cover.1751874094.git.pabeni@redhat.com>
 <20250708105816-mutt-send-email-mst@kernel.org>
 <20250708082404.21d1fe61@kernel.org>
 <20250708120014-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250708120014-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 6:00 PM, Michael S. Tsirkin wrote:
> On Tue, Jul 08, 2025 at 08:24:04AM -0700, Jakub Kicinski wrote:
>> On Tue, 8 Jul 2025 11:01:30 -0400 Michael S. Tsirkin wrote:
>>>> git@github.com:pabeni/linux-devel.git virtio_udp_tunnel_07_07_2025
>>>>
>>>> The first 5 patches in this series, that is, the virtio features
>>>> extension bits are also available at [2]:
>>>>
>>>> git@github.com:pabeni/linux-devel.git virtio_features_extension_07_07_2025
>>>>
>>>> Ideally the virtio features extension bit should go via the virtio tree
>>>> and the virtio_net/tun patches via the net-next tree. The latter have
>>>> a dependency in the first and will cause conflicts if merged via the
>>>> virtio tree, both when applied and at merge window time - inside Linus
>>>> tree.
>>>>
>>>> To avoid such conflicts and duplicate commits I think the net-next
>>>> could pull from [1], while the virtio tree could pull from [2].  
>>>
>>> Or I could just merge all of this in my tree, if that's ok
>>> with others?
>>
>> No strong preference here. My first choice would be a branch based
>> on v6.16-rc5 so we can all pull in and resolve the conflicts that
>> already exist. But I haven't looked how bad the conflicts would 
>> be for virtio if we did that. On net-next side they look manageable.
> 
> OK, let's do it the way Paolo wants then.

I actually messed a bit with my proposal, as I forgot I need to use a
common ancestor for the branches I shared.

git@github.com:pabeni/linux-devel.git virtio_features_extension_07_07_2025

is based on current net-next and pulling from such tag will take a lot
of unwanted stuff into the vhost tree.

@Michael: AFAICS the current vhost devel tree is based on top of
v6.15-rc7, am I correct?

/P


