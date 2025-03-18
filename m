Return-Path: <netdev+bounces-175623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2C1A66EAD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC8D7A3E7F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179272054F1;
	Tue, 18 Mar 2025 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNAoOac+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B40204F79
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287383; cv=none; b=Nj53u3MtyAelzdRAAgKTCFHPg4NWvXR0jEDOHhVienyw7ahCz9tQIwaa5Ta9FFYgPz7nDDLJ64NlSV9kYgEYnMA5q3Cqw+rnNKYbPLjwZAue/6gSZ7QOgd5uJQi48hGj2uRCMtBpmttMnAAXsWEyqj4X0tB8HVyRhgPWr/IiE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287383; c=relaxed/simple;
	bh=aVuqaNznx/5mZdLJC0vjrOwYEAxdll74BF6plXLxd1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUoNFP+qYOAHrNk7xJxQ5x2N0uqtxYxvv0f//zpy+Tf1mgpORchX5AAg8QMgvC7mqkPySv7gVYAGYZWU52O2EAzZb3xrnIUdM/y3wGmtsiC2dndWNLR6Lai3gNWQRWA/42nC/KS7Jw9VQJF7WN0qSCfQkIR9nZH/lvynwB5j80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNAoOac+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742287380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+9EOSMwZ0yperbosZq+EsQ8tvp7eSF9vKmD44NR3ec=;
	b=ZNAoOac+ui15git0iI76lBEcpnJE0gLehfb1wWXOnKt2YSqc2lbkcsDkZnIalOyF49SFJb
	NjcfA0SWQKKlpcpibjcP8+CaLXfL2+pC1o/7rL8+oud7n7nAZX0l/fE762uc+Yq0XvLrEG
	vR30CKGN1oS3MRU2jyPvGOIS+rn/W0k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-2Gsh4nmPNjSUJQe28f_Qhg-1; Tue, 18 Mar 2025 04:42:58 -0400
X-MC-Unique: 2Gsh4nmPNjSUJQe28f_Qhg-1
X-Mimecast-MFC-AGG-ID: 2Gsh4nmPNjSUJQe28f_Qhg_1742287377
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf446681cso16935505e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 01:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742287377; x=1742892177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+9EOSMwZ0yperbosZq+EsQ8tvp7eSF9vKmD44NR3ec=;
        b=uwmQLkqt8CwQAOjG+9ImXDUifX3Y/1ZPJrRMdcWiyGKZ7eLQVHGWXsF1qCSt6goDyr
         opImQQe1AGFmp75vqjpCDvFpxmRqw94AlcAn6COKV/QVIEgul3GZs94quqrExBqqCv6K
         +rjnPmxqodL6ZKKUy8vGt5UbHSpmlmOLW6JnmY+VG20o2TbrVFg3q7OiiXg9kBit0y0q
         FHDMwrapSVSAab2WS8fSdDNqCBXR/c25bfsg8oQv+DLj/Ro0wQkk0eHgl2B+C+uvjv2v
         AKbgwco8XY1H19QLMFy9M/rSCdRGTI8jr/sPNNEk30nDtjSYE3UOZza1RxCOf7IJaQop
         uuug==
X-Forwarded-Encrypted: i=1; AJvYcCUkFGoj8T+H52hBXbohlV2UJR6uqAnaK6qaMWrKU7lPOc6Mvar1GDgT/mdBnlxUrJaP7m4vdjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2z3pujvWeSJI57dMiz0M1EI+ONju5Z6O8NY9LXMKZ2I92UNTe
	slbmE5VWpt9DSeuI7FeoKs5FDfi8C7uTbhwnH5sUVpafZImdzsgxUgdtt0Omf/Mp7zQG3/ug76Q
	pysHSH/vAcMU42hCEMdSN6ywNXMhuuy+y8PDmkT8JIrGLnThKB4P2wQ==
X-Gm-Gg: ASbGncsUmUZkeX6yI6hvzxKKV7IRIIyQwF2eG5H7rM8ppUfmGUTFBA1drQ1/8VeXPSO
	GOS/sr3HCdOlBb75GYB2YVvolaqG70XiVBJOhKzc/z7lySQCSKUe2t65gnrjb9l/m6BJllbUc0E
	prkDKAX3V1YIz9WsnQqv6p2KND6MlR77RwbRzENTn/LEkyeBMaglKGyCEQatCGK3ViLKCbs5RWh
	68r85rtb4n0GJkTVZB0BkDGARRCvCt+KwzYwgCRMho0HvszEDdqymboyWxCcZ8/RwMQgP8RBxIC
	kbKm24wpNjY+DzN1EmbYDPmINBayamLpFLJmkuOZB8KZOw==
X-Received: by 2002:a05:600c:1d84:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-43d3b9d2769mr10024145e9.23.1742287376839;
        Tue, 18 Mar 2025 01:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHILQIoNqyHItwOTFUtVNmBDSJea3jYt34PUTdt08Ok/vxBredo4KmYrx3e6SVCEbItbB4gdw==
X-Received: by 2002:a05:600c:1d84:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-43d3b9d2769mr10023915e9.23.1742287376480;
        Tue, 18 Mar 2025 01:42:56 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb62ccsm128436605e9.7.2025.03.18.01.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 01:42:55 -0700 (PDT)
Message-ID: <cb9294c1-1d3c-4fe0-bf84-63a2fed1e96e@redhat.com>
Date: Tue, 18 Mar 2025 09:42:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 6/9] net: enable driver support for netmem TX
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
 asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-7-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250308214045.1160445-7-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 10:40 PM, Mina Almasry wrote:
> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index 6327e689e8a8..8c0334851b45 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -10,6 +10,7 @@ Type                                Name                        fastpath_tx_acce
>  =================================== =========================== =================== =================== ===================================================================================
>  unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
>  unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
> +unsigned long:1			    netmem_tx:1;	        read_mostly

Minor nit, but since a rebase is needed... pleas use only spaces to
indent/align the above fields.

Thanks!

Paolo


