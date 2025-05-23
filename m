Return-Path: <netdev+bounces-192952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A0BAC1D3D
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 08:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0720B16A3E2
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 06:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B821A0BF3;
	Fri, 23 May 2025 06:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhQBtjga"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE42DCBE6
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747982674; cv=none; b=QX6U61nAGpVpHFezfDIf5rFvh6fCpPOh0y3kcSXidClYi9epBMWVG/RpKcp2sWkNDPlZxnCB2t77N4O6UFZJNPy9RR94QKcRUXbvqB1Ecy7t6QWnJ54km9+NjZ5kJHr4rnFx/vRErUZ3qaReHLmAHLgeZFZF/nuckRuMg0txObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747982674; c=relaxed/simple;
	bh=oBV0g+D+d6h5B3VPhqjoIAfO7l+1aNlpFkImDt+ZWXs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EmyeNnDuX6XG7gcHVwCtrZeeZ5JKS/7F+V5foNtVnq+P/E8lOSiQt2H+clvKL2YIb++vXaDnoqMU4+SqD7/PP+gHXWP5fg+7my0HWtjgSIQ1oPiYyMBNjFMqa/tW7Z5ZoN/6eZKEGsDSoAv0H4AFnj0pcwsCmaOSWEC4eu8RAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HhQBtjga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747982671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4j4cbDgO+PUpzCvr0aZe7Jcbdoqz1szMaQged0/RO8=;
	b=HhQBtjga07B+pXXyfaZypl5n07KqeYehXhDMqYn0QKKG3RMjlioTi0tXd3ipNT2py0gU5/
	Cz13moMAbjrVPWGOPuNzmdYKJXThXm+oW+8VcK9yneZJwIthZ9o0KmVwhfJ8CZUBRYlzh5
	1jFku4LMoXxE0//u4HzEUg/OGX86Ibc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-MVsFDo0bPSS3dqj2loRKGg-1; Fri, 23 May 2025 02:44:29 -0400
X-MC-Unique: MVsFDo0bPSS3dqj2loRKGg-1
X-Mimecast-MFC-AGG-ID: MVsFDo0bPSS3dqj2loRKGg_1747982668
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso2866469f8f.2
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747982668; x=1748587468;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4j4cbDgO+PUpzCvr0aZe7Jcbdoqz1szMaQged0/RO8=;
        b=XSirYkLwRWbP/UxtrH8/O2iQk/N/wYJqeC9eX1MisiPsnOGMZkGAmrzBPZxu+3isSj
         V5zPw/ZFaKq3gws5jNfcMulX4FGpcZoLZ9+mYGa4mTCl4FTJpMsntjmzKKJb/SDzU4rh
         FlJ4aI+I2G3epwF/9cR/ZWya4J8auqfe1D+iGrZ+McRxMfp7FNuvCKcsW1HpE/Y//UFC
         55OpeT7UdpA015keCo+uwnQ4YKwyBlQBCli9hkkSXK5gf3PCMEn/R+DRZnks1s0FN9As
         wvZhJ+wmlIG/sQ+SjLPUrBq86hkel4+axK5pQIMm+o3VVpHE4friUAxdvFU2iZYxMgHs
         FofA==
X-Forwarded-Encrypted: i=1; AJvYcCWHeIjpnff8G6qrNKp1Pfw5D0fA408aPnNDKh9gilsmimapW0EBnha6UmARjJPPwO1W9hEH2jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+EkKkNSmFGu5jqnOemsBoVnjabhhzhebyiU1HV5cJCCkteL8A
	TGn9CAbCMIH/u/OWeIgtTVbGp5US5VQCHlZnOhUYr0C5KNUtnexju1paBJN1WbxmBOQgmTVIkID
	yh73s/n7F6CPjB7S/yIjhyh3qWt0kEl+6X1sZG5aB9+OiW1i0EtS7m+8ZpQ==
X-Gm-Gg: ASbGncuJ1QwO3spbUWx8Azz8ffPUCEIVtR/hdXJcoG/uOX4TfdC3uTlkyd+xKdZebNj
	0ddjPzqtCbFy+msKVZkC6L1teVDSBzKCj5sIBtKxSJZGZERomx9JLYydXN4hkon+69nNBNVZeUx
	i92CW55zh3XUKspvPS927gh2l+1IeG8IPGZn2QSCuqXwD7S0nbkyV0Hx2YeioxGjLnxXt+F2zt8
	vd5b00Z7Gzph1Shz9zqkB7HJlLnz74cah2bJH2uLOZOMbDLtgWGro3SK5N3/udUMeqfKRN9Twsy
	RxHi7+H3smmy+lm+mXM=
X-Received: by 2002:a05:6000:1acb:b0:3a1:fd29:b892 with SMTP id ffacd0b85a97d-3a3600dba35mr27008407f8f.49.1747982668359;
        Thu, 22 May 2025 23:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB2XMFQSaUesRZe18t4Y5EzTIFh9CEYuHjktDXqAqDomhpe6JxIJSWPTeVZQk7cFeTPuv7sQ==
X-Received: by 2002:a05:6000:1acb:b0:3a1:fd29:b892 with SMTP id ffacd0b85a97d-3a3600dba35mr27008370f8f.49.1747982667978;
        Thu, 22 May 2025 23:44:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb7fsm126057795e9.26.2025.05.22.23.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 23:44:27 -0700 (PDT)
Message-ID: <0824bc9f-ac6d-4fe9-9c1b-b0523959741e@redhat.com>
Date: Fri, 23 May 2025 08:44:26 +0200
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
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <6e001d160707e1cf87870acee5adc302f8cb39b6.1747822866.git.pabeni@redhat.com>
 <682fa555b2bcc_13d837294a8@willemb.c.googlers.com.notmuch>
 <2ccf883f-17f0-4eda-a851-f640fd2b6e14@redhat.com>
Content-Language: en-US
In-Reply-To: <2ccf883f-17f0-4eda-a851-f640fd2b6e14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 8:09 AM, Paolo Abeni wrote:
> On 5/23/25 12:29 AM, Willem de Bruijn wrote:
>> Paolo Abeni wrote:
>>> +	/* No UDP fragments over UDP tunnel. */
>>
>> What are udp fragments and why is TCP with ECN not supported?
> 
> "udp fragments" is the syncopated form of "UDP datagrams carryed by IP
> fragments". I'll use UFO to be clearer ;)
> 
> The ECN part is cargo cult on my side from my original implementation
> which dates back to ... a lot of time ago. A quick recheck makes me
> think I could drop it. I'll have a better look and either document the
> choice or drop the check in the next revision.

Let me quote the relevant code:

>>> +	gso_inner_type = hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN |
>>> +					   gso_tunnel_type);
>>> +	if (!gso_inner_type || gso_inner_type == VIRTIO_NET_HDR_GSO_UDP)
>>> +		return -EINVAL;

Actually GSO_ECN is allowed. What is _not_ allowed is the GSO_ECN
offload without a paired plain GSO. The intention here is to ensure that
the GSO over UDP tunnel packets actually includes/requires an inner GSO
offload. I'll update the comment accordingly.

Thanks,

Paolo


