Return-Path: <netdev+bounces-160563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3488A1A379
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 12:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3098D16C93F
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E2A20E33A;
	Thu, 23 Jan 2025 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTdyP6IN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C420E00E
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632536; cv=none; b=rHjBAjI5et+DaCkbQeyN71+KkzMhttOl4rxXnDhRVv534Am9leXN03KLigp1kYQhQiGNKP1bAxlq/WZEIKVUtYlD3BoGbE4hY+JglxzbKn/sjquP1W0wdXeBSa8b2XoAt5pldR2iXxrZBHn5TDoYHBb0Mi+312lvdkMFskCatwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632536; c=relaxed/simple;
	bh=3hD5KkiZ/PU6Yq0A+2rypE1iZ9K3OtDxiv1y5lERebg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEzRfDMdg4ajhlr/Xm7UaO1+cQOC7JpiI1ecvZ2jkqFhIHS/JNLiSinxE06apY8SExlmhyD1NW5HMiDnUFhCYUm3KbGwQrJTuW5xObQTDvGLq0fGeJaRLP/1XASISl0njmJhGly5UACikeQW/DGuOgYGiMipxs/SL9tdJLnt2ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTdyP6IN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737632534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e9nvSveIZF/sDomswUgi7zxeNXYUEUomIWSIRFmLLO4=;
	b=WTdyP6INIBVuHohmGQshvIoQOfX9NDWK5no0/tVNAQEPQE4kZ3zGDBRzxL1KpmLJFb3wlW
	LLJ0Yyj0YlqfiDGTC5vxYjPIE42vxkOs+Z11r7U/wTnfgmv/73IyinW0Zf1ggdvVJNHayt
	ysqKFgyrtHFQIz6uxJySA9EtgD44lIk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-VcG5JpCAOj6kAZZCOZlx9A-1; Thu, 23 Jan 2025 06:42:12 -0500
X-MC-Unique: VcG5JpCAOj6kAZZCOZlx9A-1
X-Mimecast-MFC-AGG-ID: VcG5JpCAOj6kAZZCOZlx9A
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d6ee042eso595954f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 03:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632531; x=1738237331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9nvSveIZF/sDomswUgi7zxeNXYUEUomIWSIRFmLLO4=;
        b=OPvgp+Pa8lmKBdZSFFzEp1Ua5B0EOIF8Kocl7J/38p+aa1Fvc2u4vJvNbVD5xTcuj+
         7Okedp28FGhaDHui70ZglXeSreOlmEs+ZSxEtW2tnpV5p7dM2+ZS9vjTofhXZpxaM6Hk
         wvQ05+z+lLX2CZGENyHg57bHyCHWzdxfy3gEVfoR/uIMn0U1X3HMDDWNhovYvGQKgJOq
         An+RXdRYcZv1JB6ck6SBmYJYaKivgZbIUVd73UEOLF1LbkLUJQXDXTkwCeTHJ8fXK6Vd
         E0y7TKqv8YqaTUrhBmqoHInyrQX2bQ0ARNdnmjHu05Cexcfe87hCRUbjO1CFokWQbrmE
         rp5w==
X-Forwarded-Encrypted: i=1; AJvYcCU3eJTozRVxPZXlFMIpSCRX8WU7+cRB84/ppjjtoC+cIzPVRNcuoIyqkIOjB8J0p/y2aHthiX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM7EM12HKDL9c/cavaMCE0FKfo4c4Jm0HZo4ktzy1UuPoj+vJN
	bd/l57AtIE/6ArNnI910Kaw1rFg1NXr5QW+otqa8iE2kEl8ChX+fVaL/2ClVn2DB0OPLXOl7NIM
	zyZqGWwo2lVNdouyYH6+SAMYY4PQvrOXa1MMc5/OhWIZLQDD/s0QdyA==
X-Gm-Gg: ASbGncudxmJBpdFkbMX0N7NOgmmvPP8zZrpMnws3uUCpq00LFBda8FTliRS1n7gIBRu
	uQLaUeYw4LF1EgtZ5801BEhUcd1M649VyBzBa+0cLvBXlk5nzfQTLPT7JO+Kjrw8v85rQuCE9np
	WWpPltxxTcvNBB2hEWi9zdYoJ+WSpyFpjloBMjeBbdQX3aqS0PIWl2imgLu7mjqt48Rr1lK9SBV
	zp48BlFkp8xvEhdZD/pKQKisNa+mquTvbueDYKnYia7rc0j5aI4LtloxVNf3WEC894BSNGUvA==
X-Received: by 2002:a5d:47cf:0:b0:38c:1270:f96b with SMTP id ffacd0b85a97d-38c1270fbb5mr13452499f8f.45.1737632531283;
        Thu, 23 Jan 2025 03:42:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMIezSgtaAVjiqyPQwwGR6RaSM+npl7GLxoTQ+6iM3XcieYSbGEY5DSWv4eAsGEMRjBAV6LQ==
X-Received: by 2002:a5d:47cf:0:b0:38c:1270:f96b with SMTP id ffacd0b85a97d-38c1270fbb5mr13452476f8f.45.1737632530950;
        Thu, 23 Jan 2025 03:42:10 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32754f5sm19257540f8f.79.2025.01.23.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:42:10 -0800 (PST)
Date: Thu, 23 Jan 2025 12:42:08 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/6] vsock: Allow retrying on connect() failure
Message-ID: <nbwte2cebsfbmdzuthcber446ytqkz7zwophbgxfrgxxaeo2xp@22si4coigduk>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <20250121-vsock-transport-vs-autobind-v2-2-aad6069a4e8c@rbox.co>
 <sfqi47un2r7swyle27vnwdsp7d4o7kziuqkwb5rh2rfmc23c6y@ip2fseeevluc>
 <1b9e780c-033f-4801-ac8a-4ed6ba01656d@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1b9e780c-033f-4801-ac8a-4ed6ba01656d@rbox.co>

On Wed, Jan 22, 2025 at 10:06:51PM +0100, Michal Luczaj wrote:
>On 1/22/25 17:28, Luigi Leonardi wrote:
>> On Tue, Jan 21, 2025 at 03:44:03PM +0100, Michal Luczaj wrote:
>>> sk_err is set when a (connectible) connect() fails. Effectively, this makes
>>> an otherwise still healthy SS_UNCONNECTED socket impossible to use for any
>>> subsequent connection attempts.
>>>
>>> Clear sk_err upon trying to establish a connection.
>>>
>>> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 5 +++++
>>> 1 file changed, 5 insertions(+)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index cfe18bc8fdbe7ced073c6b3644d635fdbfa02610..075695173648d3a4ecbd04e908130efdbb393b41 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1523,6 +1523,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>> 		if (err < 0)
>>> 			goto out;
>>>
>>> +		/* sk_err might have been set as a result of an earlier
>>> +		 * (failed) connect attempt.
>>> +		 */
>>> +		sk->sk_err = 0;
>>
>> Just to understand: Why do you reset sk_error after calling to
>> transport->connect and not before?
>
>transport->connect() can fail. In such case, I thought, it would be better
>to keep the old value of sk_err. Otherwise we'd have an early failing
>vsock_connect() that clears sk_err.
That's a good point, transport->connect doesn't set sk_err if it fails.
Thanks for the clarification :)

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
>
>> My worry is that a transport might check this field and return an error.
>> IIUC with virtio-based transports this is not the case.
>
>Right, transport might check, but currently none of the transports do.
>


