Return-Path: <netdev+bounces-161072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C0A1D2ED
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5B53A2630
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0341FBEB7;
	Mon, 27 Jan 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FILTYKv5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8991FC7CE
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968761; cv=none; b=ZqsK9kvitIbGbz+dSyzXQB103NHy1SXW2+y1ftw0JDzSm1wOM0H/RoJb2Ep+Lr0gWZj5kCDdCXgtwYxJRcoHCgfFNACyYq+IWPC5h4iIjU0YA6dtpDN3+PTRZ5AV/3NV3SbdqOIi00oLaKdxlZhE5LaOS3WbXMwMXjif/roNlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968761; c=relaxed/simple;
	bh=3Mg40a9y6ILFSBh5rdABVvSLra/weWS9hRvJdfJOloQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIMplp4hQRh/0RPLkdn/G0esqxvSt85leBHaQiHn+0MkHG1jbcutbrhywMvb+d6QLeeHh/rt8WwLDV5VPbflm4Hlrxt2Y5vlDbd2A/DBynGB+pgkIiyr6EeRWZLTcerk54/HBw887W/bAtt7VXdHB5HPOy/S250cx61+hhQI59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FILTYKv5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737968758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2QEDBkgSiMXPkIHqjlj2GPXIMWYEAL8JqA40jU2l2k=;
	b=FILTYKv5OAYZKBP08jSWoisGJAfc7xtamAv87fAkXcqCT4QbZ22hTuTyUDNwk5t0SHd7ky
	7R/qIiHf3D/ljQpB/4Fw+G4K0dc0FINwzIwc3V5ReE+9BulA53sPfSzYRbMJXGLNwRKx4q
	Nyw48XtJTccGz+teqmRBUCIaXPUx+hI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-xhVToFU1Os6y9g5uVyJkpw-1; Mon, 27 Jan 2025 04:05:57 -0500
X-MC-Unique: xhVToFU1Os6y9g5uVyJkpw-1
X-Mimecast-MFC-AGG-ID: xhVToFU1Os6y9g5uVyJkpw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43625ceae52so22470875e9.0
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 01:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737968756; x=1738573556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2QEDBkgSiMXPkIHqjlj2GPXIMWYEAL8JqA40jU2l2k=;
        b=vEc8QununhB5NkN6K6M8t6KwtpFprU2bCfUkjt22P3OTAHxPfxuw+ObJvO3T+5WEBd
         BC+d8hhp+Jq/K9QEq8OxagQSmAl8XDu85mRttkmQ8dQxl7DR+0QlAwZHoV1lDPQbgYZY
         NFmPqMkGSzgFy6t5CP1ub3r+OszoaY+ZQn49ihZ4N7pIBDVA3BiihzEhYZ3F78m6H5/Y
         /6EYGLBc8kU6gCBMOyGjy4puWRp6EImr84r0A9IaC5bb+xGrp/jT6ER79rRdK1gK4EFV
         3rfCSNKr3cU67k9KH3VT0FVd9sQVLwZLjGFWpfYQD9E0tkYmOYQpM/sKxouUej3JaUmn
         zErg==
X-Gm-Message-State: AOJu0Yz4/Tr0lUgNWwZ06kQTQY+fdKHh2oHM/Hj9ZWeqAh/zZspfT6Cx
	B/JEhIOP/4mxOy75EamrDZe0ipl5F2elnX2Mdc72+R5NN1WNI14Jb4soJu8SmQ+dXnWhiOsqau0
	CrO+ASczEeSrouvV9R4TRs9JISNzlvxWj2qcVSqnSQDWOsMxKPmLWrA==
X-Gm-Gg: ASbGnctLf7E8MNNZJIMLsUyiMlER1gSPf2mvOiJnJlUDNw3oMEHU/kOpT3/ce3kGgJn
	VFBVrOvW2iEkRM80Zy8UULv05fV8802peqz3U0CQv9vq0s3dAVtT4OLeSLD0HyKXU+10aIxbkKW
	vHS88KKcQhOak9Cggnj3HJJ6WU+FVIswuqw4QsUyDSzU1K+WuCyR2nHmXPV/1iNgvgPKp67IhFa
	7xkP9asJX98bLMzCHkMKkQGpKyI3+NQxcknKg28rUpFW8dbwH4IAS9UtpHkVUPHqyE5wqE5PTT+
	lgOYOFIsOcMMj2zRxBzdSYayleeZJMQFWUo=
X-Received: by 2002:a05:6000:178e:b0:38a:a043:eacc with SMTP id ffacd0b85a97d-38bf5655a55mr32746422f8f.1.1737968755957;
        Mon, 27 Jan 2025 01:05:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOL1zwgMwrLSxLekEpZ9FvjEOYYS7XyBMfD+/70R35V1FCe4hpnczb7DGpz93pfJm7Z3BpQg==
X-Received: by 2002:a05:6000:178e:b0:38a:a043:eacc with SMTP id ffacd0b85a97d-38bf5655a55mr32746399f8f.1.1737968755624;
        Mon, 27 Jan 2025 01:05:55 -0800 (PST)
Received: from [192.168.88.253] (146-241-95-172.dyn.eolo.it. [146.241.95.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a18918dsm10632551f8f.57.2025.01.27.01.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 01:05:55 -0800 (PST)
Message-ID: <a08e9235-7452-417c-a308-b062c4ce510d@redhat.com>
Date: Mon, 27 Jan 2025 10:05:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 03/12] net: homa: create shared Homa header
 files
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-4-ouster@cs.stanford.edu>
 <08c42b4a-6eed-4814-8bf8-fad40de6f2ed@redhat.com>
 <CAGXJAmzcifEeNthmE2J0epFYUhJYH=XxoJUSxQEqPCjkbhHdBw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmzcifEeNthmE2J0epFYUhJYH=XxoJUSxQEqPCjkbhHdBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/24/25 10:21 PM, John Ousterhout wrote:
> On Thu, Jan 23, 2025 at 3:01 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 1/15/25 7:59 PM, John Ousterhout wrote:
>> [...]
>>> +/**
>>> + * union sockaddr_in_union - Holds either an IPv4 or IPv6 address (smaller
>>> + * and easier to use than sockaddr_storage).
>>> + */
>>> +union sockaddr_in_union {
>>> +     /** @sa: Used to access as a generic sockaddr. */
>>> +     struct sockaddr sa;
>>> +
>>> +     /** @in4: Used to access as IPv4 socket. */
>>> +     struct sockaddr_in in4;
>>> +
>>> +     /** @in6: Used to access as IPv6 socket.  */
>>> +     struct sockaddr_in6 in6;
>>> +};
>>
>> There are other protocol using the same struct with a different name
>> (sctp) or  a very similar struct (mptcp). It would be nice to move this
>> in a shared header and allow re-use.
> 
> I would be happy to do this, but I suspect it should be done
> separately from this patch series. It's not obvious to me where such a
> definition should go; can you suggest an appropriate place for it?

Probably a new header file under include/net/. My choice for files name
are usually not quite good, but I would go for 'sockaddr_generic.h' or
'sockaddr_common.h'

/P


