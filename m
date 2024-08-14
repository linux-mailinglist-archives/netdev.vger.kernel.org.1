Return-Path: <netdev+bounces-118574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B531A95217F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA301C214F6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1611BD002;
	Wed, 14 Aug 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHtaCiie"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F1566A
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657674; cv=none; b=QTbcM9vHn6tnBc5VZIBEch7Qmu8X9qaqeIoYPZztm+WAhT4NEJHiK65mXSHm+jfiIotYvXwy6sEJScnbRAsckz/jRtXACl/nhvLKunzWiHBZNeMCxZ4SBRx7hC+OX+NjD3pRCpcsvUFWKGYvvT6rGzz/9wicwbkNXYX8YS9AleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657674; c=relaxed/simple;
	bh=qhS0TqD+75CRO9AwYlI6p0+5/ub1eeWzTyS4hNZl2WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knDvze4gmgz1rgLgpnljUV8TgVijni01RCXuInKeDzpFUezVuJkjV1fan1IWsmCKmQ2Vgdl5kmzEmXLxaGwxqhiEPaol+yF8UpqiNAkCymQMUdY/hl+/D6UPmUdHeJneg2hcNWi/g3P+vWdknA/gj8hHpTEcms8rPn6uOqRQgdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHtaCiie; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723657671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhS0TqD+75CRO9AwYlI6p0+5/ub1eeWzTyS4hNZl2WM=;
	b=LHtaCiiep3KVA7BDnsT7AHczIVceMPvQNQcwA+e4Zuzvw0L8fHuIYxZ2qRUnd6TtZpnOtP
	Nr31P4SzBmOQ6a4x7fv39gj+w6LwXNHbCooA75cv5Z2lmV5YAG24cEp23MWe+OeFTBqRTb
	8gEpFJr56jAcrbqSGjszaBh3Nv6RMqI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-GXLSxX3rNRu-hUouz9JmWw-1; Wed, 14 Aug 2024 13:47:50 -0400
X-MC-Unique: GXLSxX3rNRu-hUouz9JmWw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1de8a2adbso7404085a.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723657670; x=1724262470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhS0TqD+75CRO9AwYlI6p0+5/ub1eeWzTyS4hNZl2WM=;
        b=ieG6OJJ6JVdzDI4HnOrw3otZCp4RK+frxBg+Dy9IsIKdDBV9kvadaK3cBz/xib8H97
         /ECCB+/wVSjqMtIowLCxIJTPgEudu5dN3I5VRKsGGfpVElwZ+fofnWEIufC/W2JjERdD
         DCCQJkIxG/8Lfa8pnHJbUcEby9/o6EJPnkiuOCrE1A6THwpU3bjxMohI/A9ljHAb3u7J
         IQrwz2g+mSxOuG1qE1sV/QUfr72qdHQjw17OkaZvS+HDhN17ASshSZMsIGS2Lm8fy5Uu
         x+gm6Zaaz4/izNqlNcxFqQOpW9RJsLingAJae+zbemqUBAcJntFqQeyyHiivIPnDauM/
         +kqg==
X-Gm-Message-State: AOJu0YxSix31Y9Fs6cnQjAbTHkY8TNm5GOzLT2n7WNx6q/qpojTEExbf
	HQWDGJXzqer83pOUVpQ7c9aSSZ51V0EKxhDF4wd0dvjAlB0tBOzzbxnza0hEpzsYqZl5OVYSLQ9
	EDIOiaZDjTLl6f41AcHs5kYka4weLfDSyn5l0miFt8WIhYuPG/R7Vyg==
X-Received: by 2002:a05:620a:4111:b0:7a3:505f:6300 with SMTP id af79cd13be357-7a4ee32de75mr453872785a.16.1723657669831;
        Wed, 14 Aug 2024 10:47:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERTCK65VyvjKl0easkVsCto4qY4UR88NsyjMTni1T+veDbHrITmXlkPznf9b4C4iskWi7iQw==
X-Received: by 2002:a05:620a:4111:b0:7a3:505f:6300 with SMTP id af79cd13be357-7a4ee32de75mr453870685a.16.1723657669467;
        Wed, 14 Aug 2024 10:47:49 -0700 (PDT)
Received: from [10.0.0.174] ([24.225.235.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d644dfsm461922585a.22.2024.08.14.10.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:47:49 -0700 (PDT)
Message-ID: <0bad03cf-fbd5-4fc6-9e8d-1bd877bff855@redhat.com>
Date: Wed, 14 Aug 2024 13:47:47 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net] tcp: add SO_PEEK_OFF socket option tor TCPv6
To: Jason Xing <kerneljasonxing@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com,
 dgibson@redhat.com, eric.dumazet@gmail.com
References: <20240720140914.2772902-1-jmaloy@redhat.com>
 <CANn89iJmdGdAN1OZEfoM2LNVOewkYDuPXObRoNWhGyn93P=8OQ@mail.gmail.com>
 <CAL+tcoBQPspUNJ2QDxy=m2iut+gZJBPEkRg6yA83TsjnL==S_A@mail.gmail.com>
Content-Language: en-US
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <CAL+tcoBQPspUNJ2QDxy=m2iut+gZJBPEkRg6yA83TsjnL==S_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024-07-21 12:13, Jason Xing wrote:
> On Sun, Jul 21, 2024 at 11:23 PM Eric Dumazet <edumazet@google.com> wrote:
>> On Sat, Jul 20, 2024 at 7:09 AM <jmaloy@redhat.com> wrote:
>>> From: Jon Maloy <jmaloy@redhat.com>
>>>
>>> When we added the SO_PEEK_OFF socket option to TCP we forgot
>>> to add it even for TCP on IPv6.
>>>
>>> We do that here.
>>>
>>> Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
>>>
>>> Signed-off-by: Jon Maloy <jmaloy@redhat.com>
>> Reviewed-by: Eric Dumazet <edumazet@google.com>
>>
>> It would be nice to add a selftest for SO_PEEK_OFF for TCP and UDP,
>> any volunteers ?
> If Jon doesn't have much time, I volunteer :) :p
>
> Thanks,
> Jason
I have been offline for a few weeks, so I didn't see this until now.
You are totally welcome ;-)
///jon


