Return-Path: <netdev+bounces-193418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2579AC3E34
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 12:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2283B7472
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D39C1F5847;
	Mon, 26 May 2025 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nsp1y1tK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EEE1F4C85
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748257050; cv=none; b=ZMkTk+EecQJGXOMNfg0Gue9OOwOmNAn95hDFXNM4todxiYgyuVQqw93/JRHFrDiQWWivUnaZ045he2DSx5ReNn/n4Ll7h2RYS8m0KdnLbV1YD9NqU7U3bXr4/GVnClGYGlj8Iofpcr7AmY7ZjqdkkniFlddyF/Xs3x0bkG2c1eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748257050; c=relaxed/simple;
	bh=eFpL1xPGcaWudeYz70mekm/B14kslh/U3obPhF+j+3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9KuXntHyIiSbtTrbgGFpvqIpF++3kAqY/yOd3zhJyaCwU/FJMm3McpqPMLju0k/oY1i8uxR8vrUbWk3wlPjkQWbk6jXEzje66PRcIFNGgbr865MMl+gnJpETHd1Y6yzxx4kggzzusdq97wDBXYtf6Dil1OmHoI/b7PrXkouKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nsp1y1tK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748257047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wolvzxp1hV/cuZJiudij5Q9BWWv9/aEQB/GlRzt4c5o=;
	b=Nsp1y1tKbyg8DY00mw80OJ4bTECtZ4WFy7ZhIiF/zio00O2jG2zULx2m+Oy+ug+xVhBSgp
	yeYx/7bU/eRB/e1xnuVWNezNDuEE9XOsFNHMIWkjTor65mWt8Css3qqhBklJnG5J3SXvIL
	axBpqrOdssyGVtMMcFEY1qhLni39BtI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-6LVkVJYiOnGCH1QCSYuTKw-1; Mon, 26 May 2025 06:57:25 -0400
X-MC-Unique: 6LVkVJYiOnGCH1QCSYuTKw-1
X-Mimecast-MFC-AGG-ID: 6LVkVJYiOnGCH1QCSYuTKw_1748257045
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4dcfc375aso295001f8f.2
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 03:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748257044; x=1748861844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wolvzxp1hV/cuZJiudij5Q9BWWv9/aEQB/GlRzt4c5o=;
        b=rn6642T2zznRJzzSvA/4dqeykstpapbXIHToEuCf6vOfxzc/GFw4zv2OngzCeYM7j/
         LOYAiz5lBkVkavyxLZqYUfPvYfKlrdYNLnahiHgdmchY+CangDiK/ngwTIum4cOvttEp
         Cv8af9IZ7k01fnia+0fqdoYG2SPj45dF/u2s9LftK5Ws+ucblFGunB3K3WEVNtV4CGrj
         Z8YMUTVLUSrimY+YnBtrbYvePymXpCK/OonBOfo2jo8stK1K0jzvOLLz9Ic4j16Ybm2r
         FGVQRHM959vNNkiFYJ8PdSPXiu2dWgKJjDwndJ76/S04ZTiWbx/IQr+leIRo9yIeqAtL
         6A2w==
X-Gm-Message-State: AOJu0YwIKBVt1wqK7tzl4UOohT6I05vBmeMeJQG25b4kUDacG33QgJyn
	YAC77wA6Mm+ctsE8TWt+ckkLoPkMb7Ynez1l6jj+zyS9sA2mOzXeRlTVVaTvaEuANAYfEQLT5NK
	fzeh9PtlhdFuO6coa1xmnVbidP3JapBjk3JGsrb5gwbguyX4TmwThP9d02Q==
X-Gm-Gg: ASbGncv7JcO9nQbpeyG30nFcFcvNjOBWcsgk/x/Cf+DservDHTdIzTIJ/rDhE+PeAVD
	TVkPXlEluB2nrbU10LGc7fOlH52NhN7a8w+dQtaDVxoRDqIgMbs2FUVzp9Qa7tZg4denVnDcj+0
	+ZFJUsMGBANTGLORypQLgSW64SUCYhB7SqScugRu3gFyLwj/erzwC+QXmN/+1yFjBAIbyG9Tciu
	B+jj91oVKHXI5JGRsnb3b6jcCh+kYj7/RgDC5SUPUTZuEvh8cTWsk1hNIb8fhYlyhfoK6S5M7Uz
	h1OrIjYXAyUW5zUAnUA=
X-Received: by 2002:a05:6000:178d:b0:3a3:727d:10e8 with SMTP id ffacd0b85a97d-3a4cb4c5530mr5508886f8f.50.1748257044558;
        Mon, 26 May 2025 03:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9/rvEp+P8g+UZuIM7v4A3z1WaMgSDx8Hk4OtjRKhoZRKBGG0Gl0z6NDsaVk73gmpPT4s6xw==
X-Received: by 2002:a05:6000:178d:b0:3a3:727d:10e8 with SMTP id ffacd0b85a97d-3a4cb4c5530mr5508871f8f.50.1748257044159;
        Mon, 26 May 2025 03:57:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d6f9d350sm3580008f8f.73.2025.05.26.03.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 03:57:23 -0700 (PDT)
Message-ID: <df320160-88d4-44fc-92f8-dd7a9efb8569@redhat.com>
Date: Mon, 26 May 2025 12:57:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] vhost-net: allow configuring extended
 features
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <b1d716304a883a4e93178957defee2c560f5b3d4.1747822866.git.pabeni@redhat.com>
 <CACGkMEuzWGQB=kQeX-bA8jVn=5Sj_MP_Q2zbMS=tvKGYrNmWLw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEuzWGQB=kQeX-bA8jVn=5Sj_MP_Q2zbMS=tvKGYrNmWLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/25 2:47 AM, Jason Wang wrote:
> On Wed, May 21, 2025 at 6:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> Use the extended feature type for 'acked_features' and implement
>> two new ioctls operation to get and set the extended features.
>>
>> Note that the legacy ioctls implicitly truncate the negotiated
>> features to the lower 64 bits range.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  drivers/vhost/net.c        | 26 +++++++++++++++++++++++++-
>>  drivers/vhost/vhost.h      |  2 +-
>>  include/uapi/linux/vhost.h |  8 ++++++++
>>  3 files changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index 7cbfc7d718b3f..b894685dded3e 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -77,6 +77,10 @@ enum {
>>                          (1ULL << VIRTIO_F_RING_RESET)
>>  };
>>
>> +#ifdef VIRTIO_HAS_EXTENDED_FEATURES
>> +#define VHOST_NET_FEATURES_EX VHOST_NET_FEATURES
>> +#endif
>> +
>>  enum {
>>         VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
>>  };
>> @@ -1614,7 +1618,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
>>         return err;
>>  }
>>
>> -static int vhost_net_set_features(struct vhost_net *n, u64 features)
>> +static int vhost_net_set_features(struct vhost_net *n, virtio_features_t features)
>>  {
>>         size_t vhost_hlen, sock_hlen, hdr_len;
>>         int i;
>> @@ -1704,6 +1708,26 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>>                 if (features & ~VHOST_NET_FEATURES)
>>                         return -EOPNOTSUPP;
>>                 return vhost_net_set_features(n, features);
>> +#ifdef VIRTIO_HAS_EXTENDED_FEATURES
> 
> Vhost doesn't depend on virtio. But this invents a dependency, and I
> don't understand why we need to do that.

What do you mean with "dependency" here? vhost has already a build
dependency vs virtio, including several virtio headers. It has also a
logical dependency, using several virtio features.

Do you mean a build dependency? this change does not introduce such a thing.

/P


