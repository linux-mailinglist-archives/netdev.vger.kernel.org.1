Return-Path: <netdev+bounces-156653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8696A07402
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74821883673
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D721638B;
	Thu,  9 Jan 2025 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciyO+jNc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8FC20551B
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736420373; cv=none; b=rPKuClz8fRd2gaS78Ldcg/1xLITm5J8SuCL6s5ocpad+Zvmc5P17wlj1KK0bhBhhrSxZIiX9D8xMFZ99xsqGPmiUbBPpJWBIgdaIv71UVVBbIkzcsT9pCgacr+tzlpX/TwqGwj7VCXsqtt/x8ndWlMe1Xxmwk4U5xlp/6NeLQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736420373; c=relaxed/simple;
	bh=QO+8EwbJGvqBWCSEp/iekR/lW1wlFfO62fQHJbRasd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsUkivOkXpNVMDYjdtLua7SX4KiMVbxEhUmUrUJePFfZqwFOXG96u2bSWKHHNBOgKYBTEBHVZoB5bBJa046JYYNhLLDPP95stDm8KseZfwoWQdvv+h8PmI/sA5iHtUOpMLqJYoFqfC7839DouoQgaxMU3P/Ac5OGjAzQ7wIj27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciyO+jNc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736420370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wK0FqgoNCI706ZNDwKuUWEFrZzy/qpwSQvIl8nfU3ZQ=;
	b=ciyO+jNcjCiuYI6wlr1eBe3KP/g/EVlqC2ry8qgHh3aF78KUGvwkpJ52/O3KMEU6UUAbxW
	Vz2+B9+7o+S2cwB3y4j2plv8O7s+rroxo5wC2QzsvlhmxpChVUieH8SAkQHL+N8Z8baMGG
	b/W/HJqu291VBlSDbm5qS3X3h8JcXmU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-kpXF8TDZPcSQ3KOdP_fZZQ-1; Thu, 09 Jan 2025 05:59:28 -0500
X-MC-Unique: kpXF8TDZPcSQ3KOdP_fZZQ-1
X-Mimecast-MFC-AGG-ID: kpXF8TDZPcSQ3KOdP_fZZQ
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8860ab00dso13405406d6.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 02:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736420368; x=1737025168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wK0FqgoNCI706ZNDwKuUWEFrZzy/qpwSQvIl8nfU3ZQ=;
        b=ic3h/MDMF4Lmit7GwCcbcarh2mkvB4aG0RdBxWobPW/B56bPnX06XFa00l1fF7kzqy
         t8MaK2DQZkGw3r3NHAZCqAUrPqPNG8yAuoJN0QRVe9hCc7LIE3Ej5m4r0smMxVsMStQC
         vfwyhu/MuJD8PVhy5ZKHc4luV2B/ynWyPDpz7uLPN2lKWQLz1wgjg6/yuDw7B3tvnwNq
         G5zQh9P9CTXlySJ0og2E6bOmpoBBimxjCBdppSspC+TxqBoMMosHt0K5P5k4iKnMSAGb
         tFpYN/s1Uylrwn15xTurGQNN5uFKNRBeUaCKFfWClUzsWYBtaMX21GUu0jum2M9My/sa
         5oiA==
X-Forwarded-Encrypted: i=1; AJvYcCVlOxEVLkwdLEX35ihrfxFbP7de3QJ/08e5yml5FFt2vqNg9iZ90Lq42FCxpJDq3VNPu6irKd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYy2fRMhbgij1DP0auiSlnK+r41g6+9gmuCwO4HjrzOzBoZ7sv
	mqsLDT0NDvPx9eniUhOA+zpRCCABLqd2N6EZUHp6JlTIaQGGU0OGEMQzYswIY+Gbb5WtL3HI18J
	brIRD776qZblRWTn2Dl6MXHLV9WJIPj8JbNhjP5jfgQ7VpKtMTan1nQ==
X-Gm-Gg: ASbGncvjDD1+YGBFoJ4aVkWgb0EpETDSgUvtQKNV3sjszpV2RmIvD+vkbi38B5/Quqn
	uHHp0SGtzmNvfGbtM1+ham65EFfEVD4SxFjbsS/O8IpIPBr9o1ACSDUiGyppXJEVIk1tuOlGVo+
	YsdxsGXvXb5n+714cARxjEi2chHTuNUoIxEmrF/gqWoM8Mszh9NsEdOArawiTnNw7c0VME3y+Nv
	B4y1BQxwH64VD/qQ6uus1uMJYVQHoCRUxoTHrcsowHmi8jaUiuxFPKZd8WbtZaLdBy9BktDCLe1
	TTCsPt00
X-Received: by 2002:a05:6214:29e5:b0:6d4:257a:8e with SMTP id 6a1803df08f44-6df9b1f6e24mr96948836d6.4.1736420368263;
        Thu, 09 Jan 2025 02:59:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8mmSRaTNnwp1OnK5Lb74v5ufYLk0h2ejCS+7l3gscGwPpNOuj4xG12KpfdG1Ge1VDxg5Avw==
X-Received: by 2002:a05:6214:29e5:b0:6d4:257a:8e with SMTP id 6a1803df08f44-6df9b1f6e24mr96948636d6.4.1736420367943;
        Thu, 09 Jan 2025 02:59:27 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfab306ae1sm872096d6.111.2025.01.09.02.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 02:59:27 -0800 (PST)
Message-ID: <4abb5ce6-394e-47dd-ad02-ed75a8aa42e1@redhat.com>
Date: Thu, 9 Jan 2025 11:59:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] mctp i3c: fix MCTP I3C driver multi-thread issue
To: Leo Yang <leo.yang.sy0@gmail.com>, jk@codeconstruct.com.au,
 matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Leo Yang <Leo-Yang@quantatw.com>
References: <20250107031529.3296094-1-Leo-Yang@quantatw.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250107031529.3296094-1-Leo-Yang@quantatw.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/7/25 4:15 AM, Leo Yang wrote:
> We found a timeout problem with the pldm command on our system.  The
> reason is that the MCTP-I3C driver has a race condition when receiving
> multiple-packet messages in multi-thread, resulting in a wrong packet
> order problem.
> 
> We identified this problem by adding a debug message to the
> mctp_i3c_read function.
> 
> According to the MCTP spec, a multiple-packet message must be composed
> in sequence, and if there is a wrong sequence, the whole message will be
> discarded and wait for the next SOM.
> For example, SOM → Pkt Seq #2 → Pkt Seq #1 → Pkt Seq #3 → EOM.
> 
> Therefore, we try to solve this problem by adding a mutex to the
> mctp_i3c_read function.  Before the modification, when a command
> requesting a multiple-packet message response is sent consecutively, an
> error usually occurs within 100 loops.  After the mutex, it can go
> through 40000 loops without any error, and it seems to run well.
> 
> But I'm a little worried about the performance of mutex in high load
> situation (as spec seems to allow different endpoints to respond at the
> same time), do you think this is a feasible solution?

For the record, I'm taking the liberty of dropping the above paragraph
from the changelog, as the question IMHO should have been placed after
the --- separator, has been already replied and repost just for this
change would consume more time from everyone.

Cheers,

Paolo


