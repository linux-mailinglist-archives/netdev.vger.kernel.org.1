Return-Path: <netdev+bounces-229140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC29BD8796
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23A8D3406FF
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DDA270ED2;
	Tue, 14 Oct 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2S+ZuhG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B9E1EEA5F
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434683; cv=none; b=m/vwf2o9F+Ht4/x8Y+GDycdA6BfgdjEYHeF3UPLfpAb7UM3AFxtaYHXN731PDV+pgCOkAcyszJpg7xTovpSTKPyHs0s9nP7sw4A6kp689N9PRPkVkyzyF9zLEf5DQXArxkaD7yg7JsqxZTMX8KU6RFUBCyv3MElBs7TvcbEam88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434683; c=relaxed/simple;
	bh=dernyl74aD5YqjyvSOkEQtGQHBp1SlBcegnOJ97Xly0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8AH7aGAagypSjvsfcU3j7kD1H5bJ/vTbXFtmi3++m+zBYajPZAZAwCE7Ukdd+gvdVdjBVz187yFsx8NgFFiZhI1+ye9PkGHRkKDqm6K4uhNvDkAZ7DCp5/X3JcjdggDamzoE/ttBl9hHYaNbn0+ixq1WmEf57GN2js4uWjDjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2S+ZuhG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760434681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DrPjnAGR9goykWCCfeiRdOQDYXP+/j8gBbfRd7YtlM=;
	b=D2S+ZuhGVydO8EBKbebD9Y9x8s8DPGtByBEpzXE+z6mS/fYrgmhO8aFLR2bZX4kOYsNKiE
	3JnP0q7J6649GTMwi0dQnOIwkHFN1b5p304M1FCxUy03ciZ9g+4oP2rBEeUXYcdfwjJLLu
	bx5XYQxQwEMYzIB78ZWxADefXsm1Gs8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-nWBQ4cIXMB-a7Uojn0keLg-1; Tue, 14 Oct 2025 05:37:59 -0400
X-MC-Unique: nWBQ4cIXMB-a7Uojn0keLg-1
X-Mimecast-MFC-AGG-ID: nWBQ4cIXMB-a7Uojn0keLg_1760434679
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3af78819so26235225e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434678; x=1761039478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DrPjnAGR9goykWCCfeiRdOQDYXP+/j8gBbfRd7YtlM=;
        b=otyFJ1WVX+htjAQkj5A6WAgDfEqncUeq5V3Q0+WVh+bY3IjCpHjxc2pylFHBEtrw9f
         KXpFY6KVTzK2WAiosLIbb266/jAkoFv7IiKJPvE2vb1RXwMj9+Q59hnWe+/+R13fMp5n
         IZpdN7V7HQJRV2Uc4iNPE3b931nlRw3RT9S301NvlTqKt0NJKylLzEvYhY0RyTzD41Cg
         zZLM51Hzfl9Gr9EbTvWVhG0DOeU99yjvh9R6NvT17TbVreQm7H1cq8QMRMr8odWn5pAa
         kyLu3FYwZr8kagndM1kMoi1sampuLhnCBVJ/mWwdk62BzIkvHfdxITwpntvigWxxo09K
         EuJA==
X-Forwarded-Encrypted: i=1; AJvYcCVFBqkT10+O9RWQJQTMNcs5OVbJpLxRDMaUkhvd4FuVeTlLmGVT9xoarG5uGXims1wr7CYs0Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYNltocoA1Hop9a1buvg4tE+r44F10Nd3LvGOD6tkxPGjuDJu
	I6O0bhRJWn1kWfrb3AJePnWtxDESOZUvbmZ3azxknYCjowP9WtOdaSC3EVF4SB5PqzGl+uovg9d
	/sLQb64YJ7MHNuoNQ7LPoqJ2IK8AuO4eXiICUju13GRjTPyTPtUnBx2R5Zg==
X-Gm-Gg: ASbGncutz/3yv5vMZ2eEoXqechj3jUF73ngqNReMJ/c9CJHtscNkhXXBoRMt67J/0r7
	KUYHRNUz1QcGZGlT36q2E5+Txxgmwjxv2CXxU1v6mNaeSie5v51F3Z71vJFAHRohBSKScaxYyvS
	BA5xXz9BnM6lVT4dsTBEslI3RCd9S/Bvkirr1DMHColatnyraYx8iMwcy2BIopSAV94F+LV+bgo
	wD51NWSwOsaCqFe6tBDo1dhGVsL3LuSrU/5r6vl8ERBWkwoafdmEeiL0PZojC+Hb8XzoMUdcv7M
	NFT05Y08YIpznZIrCW/+STxt3ypf8QrZxpcVPRgECdLziwGGUBdXQrb2+MXrGjKmNm0MZPYUBNH
	5QyXq/sGuHJFY
X-Received: by 2002:a05:600c:6208:b0:46e:367f:293e with SMTP id 5b1f17b1804b1-46fa9b08fa7mr169970795e9.25.1760434678539;
        Tue, 14 Oct 2025 02:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIjtY/2JzPq2TtnvNrd1PZTvWSHxFxLE1mRnUkQAcekXuZy2N8a1gocnTXUTVTYF8lnLD3tA==
X-Received: by 2002:a05:600c:6208:b0:46e:367f:293e with SMTP id 5b1f17b1804b1-46fa9b08fa7mr169970505e9.25.1760434678110;
        Tue, 14 Oct 2025 02:37:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5825aasm22335227f8f.14.2025.10.14.02.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:37:57 -0700 (PDT)
Message-ID: <ffa599b8-2a9c-4c25-a65f-ed79cee4fa21@redhat.com>
Date: Tue, 14 Oct 2025 11:37:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established
 flows
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20251013145926.833198-1-edumazet@google.com>
 <3b20bfde-1a99-4018-a8d9-bb7323b33285@redhat.com>
 <CANn89iKu7jjnjc1QdUrvbetti2AGhKe0VR+srecrpJ2s-hfkKA@mail.gmail.com>
 <CANn89iL8YKZZQZSmg5WqrYVtyd2PanNXzTZ2Z0cObpv9_XSmoQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iL8YKZZQZSmg5WqrYVtyd2PanNXzTZ2Z0cObpv9_XSmoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/14/25 10:54 AM, Eric Dumazet wrote:
> On Tue, Oct 14, 2025 at 1:29 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Tue, Oct 14, 2025 at 1:22 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>
>>> On 10/13/25 4:59 PM, Eric Dumazet wrote:
>>>> Some applications uses TCP_TX_DELAY socket option after TCP flow
>>>> is established.
>>>>
>>>> Some metrics need to be updated, otherwise TCP might take time to
>>>> adapt to the new (emulated) RTT.
>>>>
>>>> This patch adjusts tp->srtt_us, tp->rtt_min, icsk_rto
>>>> and sk->sk_pacing_rate.
>>>>
>>>> This is best effort, and for instance icsk_rto is reset
>>>> without taking backoff into account.
>>>>
>>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>>
>>> The CI is consistently reporting pktdrill failures on top of this patch:
>>>
>>> # selftests: net/packetdrill: tcp_user_timeout_user-timeout-probe.pkt
>>> # TAP version 13
>>> # 1..2
>>> # tcp_user_timeout_user-timeout-probe.pkt:35: error in Python code
>>> # Traceback (most recent call last):
>>> #   File "/tmp/code_T7S7S4", line 202, in <module>
>>> #     assert tcpi_probes == 6, tcpi_probes; \
>>> # AssertionError: 0
>>> # tcp_user_timeout_user-timeout-probe.pkt: error executing code:
>>> 'python3' returned non-zero status 1
>>>
>>> To be accurate, the patches batch under tests also includes:
>>>
>>> https://patchwork.kernel.org/project/netdevbpf/list/?series=1010780
>>>
>>> but the latter looks even more unlikely to cause the reported issues?!?
> 
> Not sure, look at the packetdrill test "`tc qdisc delete dev tun0 root
> 2>/dev/null ; tc qdisc add dev tun0 root pfifo limit 0`"
> 
> After "net: dev_queue_xmit() llist adoption" __dev_xmit_skb() might
> return NET_XMIT_SUCCESS instead of NET_XMIT_DROP
> 
> __tcp_transmit_skb() has some code to detect NET_XMIT_DROP
> immediately, instead of relying on a timer.
> 
> I can fix the 'single packet' case, but not the case of many packets
> being sent in //

What about using a nf rule to drop all the 'tun0' egress packet, instead
of a qdisc?

In any case I think the pending patches should be ok.

/P


