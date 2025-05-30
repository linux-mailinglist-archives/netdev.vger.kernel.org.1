Return-Path: <netdev+bounces-194330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A848AC8A15
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 10:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49B99E56F4
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 08:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50AD2192EC;
	Fri, 30 May 2025 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T73pe/mw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377D1E3769
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748594591; cv=none; b=EzlVaz1qhJxViDkF7Ipe1oK8eGnOFrU+6mVQ+JWKlKidlmFgC/N4Tq/WAFmByDggUKpZ8sUS1dLn6u2l56MFy+5blADKlp8G9Qdv/TzCHFpHqlprW0Eh1TUgXAwKDl7KRGg3JdpPMGeKO8iJNWF4sPonOs5FQn4qFLlOqaJp35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748594591; c=relaxed/simple;
	bh=MKwAvRkB0szD5olv4VSMBRuJVZ7AzdCji8gMzT7LSHs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cXv1GjdmIV79slvJ0rL5RO58qHwBCBBB+jzWOrK26iqeFITeNkiU09b/GqjulBHRwCsXvE/CZJ7kywDYUx+qaelR8EMnSvX8gzaoQoKhCVm7l7F9lwS2xLvBpUBOWTzKgxPgK8Ppjk3bM6bJD9hfXxkozus4OmvBffDrgnXx0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T73pe/mw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748594588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCi0uOE+EdoP1uU+RIEl/GzhoqxTTK+kBvwaCYhM6sY=;
	b=T73pe/mwU0nnTr2l2sYFZS0DJpWAGTsNMt/Yv7ixI863OQGQtkdjG/XHo3Emu7EBIX9fGD
	YU6B7HCA73RTZY/J5lPCdBVtxsipYYB9klKvud4KMIn0SjrlSCe7Kfi33l/ktzEEVJlgTE
	IoZgL7zjyOsGR1fRbmt+pJFsm/Z7z1c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-Dc8psqxlOeixclVhykm7cA-1; Fri, 30 May 2025 04:43:07 -0400
X-MC-Unique: Dc8psqxlOeixclVhykm7cA-1
X-Mimecast-MFC-AGG-ID: Dc8psqxlOeixclVhykm7cA_1748594586
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so231344f8f.1
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 01:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748594586; x=1749199386;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCi0uOE+EdoP1uU+RIEl/GzhoqxTTK+kBvwaCYhM6sY=;
        b=LFAmFt4EZpagIYGUptPGS/N6sMS8Ktay+Yg6rjsBmNuDIVB/rq+HiZ2BhoJzWagiG+
         3ydBHT240jx4gI8FG40HG1QESrqvMMtJAJnghKXLfJ9YHcTo9bTIyQNUwqQETg0tUlrD
         YIEtmbXC5VLj3p47BHzkjqzF81YiBlMhh0GAJgb2b2SXkVgh842KHwLhd4s7nqK/KoDH
         b1ULwrp0m2+visBhsMHScBK9YaMydb97tvEMcgzPnwQ2a5oOwWKRlpVo4ysxu2/4Ua07
         ATBspiGYWiQaTIgnvuU0GPfWighs3kCsJ4rw3hctRbrywHkgXd1HNQVKx/R4640fWOt8
         cDkw==
X-Gm-Message-State: AOJu0YylieQNu2LMkxFLg5gds8we5ripoisuLuahzb0O7TDKyKtiCyWW
	4Pe5Xg1P8thSIDtZLo+X/s9tnTVj6OQMfhLV0hkRim4mXUGrAIySP9htfVC87lvzuxzS9akPE9Y
	W0IVpbUcYAYIpAifLbXXbAk/eoBqQ4kEwr4beHbvwpEbqn2twTuTR7XbciA==
X-Gm-Gg: ASbGnctIgYS/MVW8c0MCYXdwu/BdZdQrMOvA0wz+YuESu/LvViIVZ3vFMnoRjVI9h+R
	IXlvlumxHysUHoq2l06E4c9nkFFvLvaXg2VD7oUqrRYdrAbWmSQdkQHKQTK/5Nt/YCSI6JE6I/1
	9/cK+NazGLmNjLvjUTVQ1WTo6GhOUJVYowwvrBPP04oThzIdcbYaJJoQldqhAPtrbaXOnjpL8SS
	cvbUzJmlLAEFSpMQFycDZAGLQI4WS/zJeu0RmEK0DiqNTqTUhbSHEhfrgftJeX/yjqomfcDhw5E
	T4agaDFQS6FN1oOwofU=
X-Received: by 2002:a05:6000:40cb:b0:3a4:c909:ce16 with SMTP id ffacd0b85a97d-3a4f89e322dmr1135394f8f.49.1748594586163;
        Fri, 30 May 2025 01:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIXSk/dEq5O9CpOMLUx5yMGjgCDlmfjQwVrAMuHqELLU+2ccgQc5MSQLyuP3VhcgQy5XWCFw==
X-Received: by 2002:a05:6000:40cb:b0:3a4:c909:ce16 with SMTP id ffacd0b85a97d-3a4f89e322dmr1135375f8f.49.1748594585831;
        Fri, 30 May 2025 01:43:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2442:a310::f39? ([2a0d:3344:2442:a310::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009fbf7sm4139376f8f.83.2025.05.30.01.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 01:43:05 -0700 (PDT)
Message-ID: <37f16cf5-c785-4ad9-a8f4-3f9b3bf68052@redhat.com>
Date: Fri, 30 May 2025 10:43:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net: implement virtio helpers to handle UDP
 GSO tunneling.
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <6e001d160707e1cf87870acee5adc302f8cb39b6.1747822866.git.pabeni@redhat.com>
 <CACGkMEtkbx8VZ2HAuDUbO9LStzoM6JQVcmA+6e+jM1o=r9wKow@mail.gmail.com>
 <3c2290f1-827c-452d-a818-bd89f4cbbcba@redhat.com>
Content-Language: en-US
In-Reply-To: <3c2290f1-827c-452d-a818-bd89f4cbbcba@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/29/25 1:55 PM, Paolo Abeni wrote:
> On 5/26/25 6:40 AM, Jason Wang wrote:
>> On Wed, May 21, 2025 at 6:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>> +       skb->transport_header = outer_th + skb_headroom(skb);
>>> +       skb->encapsulation = 1;
>>> +       return 0;
>>> +}
>>> +
>>> +static inline int virtio_net_chk_data_valid(struct sk_buff *skb,
>>> +                                           struct virtio_net_hdr *hdr,
>>> +                                           bool tun_csum_negotiated)
>>
>> This is virtio_net.h so it's better to avoid using "tun". Btw, I
>> wonder why this needs to be called by the virtio-net instead of being
>> called by hdr_to_skb helpers.
> 
> I can squash into virtio_net_hdr_tnl_to_skb(), I kept them separated to
> avoid extra long argument lists, but we are dropping an argument from
> virtio_net_hdr_tnl_to_skb(), so should be ok.

I have to redact myself WRT the above. driver and device have different
csum-related offload support, as per specification (i.e. DATA_VALID),
and need different validation.

This helper is intended to be called only by the driver, will do the
wrong thing if used on the device side.

I'll try to clarify the usage in the next iteration.

/P


