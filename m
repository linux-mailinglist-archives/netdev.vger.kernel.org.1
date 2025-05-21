Return-Path: <netdev+bounces-192282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBA4ABF356
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A1C1BC38E5
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF731263F3D;
	Wed, 21 May 2025 11:50:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E025DD0B;
	Wed, 21 May 2025 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828217; cv=none; b=iXHQjnDcocsY3/ULqJPvXMBRJGB/N8LftGncseKRmQ1dKngySALEQRaIb5RjoVdGuGbcX2nt7FByA2s9jm+14rWyJaNCeoTLmM/cmh+wKYNLbRvKta0dwAoxzxPl5LK/tn+yGqd8FEFEF1kQ9WiIVB02QD5F3qgkQ0igpw8tLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828217; c=relaxed/simple;
	bh=KQ6KNVj2k0zk0HRFNi1X7cccXc4810Guc+cYqMDOVaM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pj3/95nHAnCss3+kbX540WlZDxPYlB6DVq5r8Qi3hlpJ/1/Dn511+zVyLLEnIe3t4FOG/vtaouROgz+2B+RiYR3qV/ZAxqYAi0iO6CPG+CMeA6Qw3CtMH9ZVItj41dXOI6GJNX3v/X+DqvMJ/ulEdbM5Z+e/pfmXrpVmOso648M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ad5a11c2942so230431866b.3;
        Wed, 21 May 2025 04:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747828214; x=1748433014;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68yZYWcO/qu80qejGYRGHVKWN9JIRBjd6V2d+NgZs/w=;
        b=YOQw8rFfHZbcS9e9oneXxiHzbFWiWWzdySRIm+D6qGcX6lFD8tWAfw38HzW6fz8l8u
         AS1czEzO/BnW3IwO9nz5y7iezzlqyGpqruIlnWNo3faRLkGNJ40f2WSCSMtny6TnYwxd
         7lIUsqDFiJCGMjl7ecTtOxir4RT12IR+KPDvqsXjitcQ2wz55K9tr0u0pmUPKsF5Vqb7
         qS3oZlZSAH5G3gi7QfwdlMjEKkh4KpmDH5wV+Ha0B/SjTZhGW4EHvrXrWw2onc7O6KDZ
         cAxJBuvZaddn+Odf0DMgwUhCuoYbWGJRiFG4gaXxV9Rstl6De6Hr5TpuXlPG77qfKfbz
         d0eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOMIqQY8rn3JSOaFSJOltYrqdUkYnFqBDdl+Ih2+rIxhcrytCxCaizbqfQ0STKmWvO80YPGN30G5De/kQ=@vger.kernel.org, AJvYcCXOZMEBcqBlYYiSkFBbzkg2E2t+Y8cy1eGMJsJ5Ug9EiJBpzs0cc1Evdyi8Uu79XNrTpnAgZZEc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3F8YmkQ/wBN5jY4wT5p+O0G0RksJI4R1kMcaYqwQx4s6N0fkW
	KFu6PtQ1bSN5jm6AGZ7Ej7tFZTH3wE44ZWSg4w1FKqsAdHWSXdaM1pYf
X-Gm-Gg: ASbGncvaHUnHnb7jqtFT+k4KP4JmCW2F+Lag4P+QN/g1cmLf0cVVCFRpvwvtxKq72Rg
	kRWOKdVCrer67XtKnqV+TNZUDqo1yAFt3nNUjVRFfxqctdKEUb2RFe+Bo77QZvORg/jW6j/FESj
	6whhZMXT8ookOdpyxLPzgun+LwnkIjHQS4grHsJ0oir0lemV7diIAfBgW+4ex7N8G79BI6LcgjI
	KuLmn0b2shtT97s04mYmhuyQelC9usrXOtZGW15VmCbz6PXpFuslkNFbE/1wB1Ug/Q/7SLYGbgp
	spYzQt+ZDzDS97EaU3IkQo/6AJLYa0LwjyzI9KIsbTOomZqxWcWs+mVf+QhM8fBlJA6qPS+tB3k
	S9x1y4UDNgko/247fZ7xKjGA/iEJ9
X-Google-Smtp-Source: AGHT+IHBUvB0qd4Wdk0rjsDkKoU4zvzjmirXj42bjWO1X/28+O/mKC+TdX+hxPGZdlD3zurJzCgbWQ==
X-Received: by 2002:a17:907:94ce:b0:ad4:f517:ca3 with SMTP id a640c23a62f3a-ad536bde67bmr1909702866b.20.1747828213665;
        Wed, 21 May 2025 04:50:13 -0700 (PDT)
Received: from [192.168.88.252] (194-212-251-179.customers.tmcz.cz. [194.212.251.179])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d443a0fsm897036966b.97.2025.05.21.04.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 04:50:13 -0700 (PDT)
Message-ID: <a492bec9-8eaf-4884-bb4b-c8487d84de73@ovn.org>
Date: Wed, 21 May 2025 13:50:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ovs-dev@openvswitch.org" <ovs-dev@openvswitch.org>,
 "aconole@redhat.com" <aconole@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dev@openvswitch.org" <dev@openvswitch.org>
Subject: Re: [PATCH] net: openvswitch: Fix the dead loop of MPLS parse
To: Faicker Mo <faicker.mo@zenlayer.com>, Eelco Chaudron <echaudro@redhat.com>
References: <FA285FD8-1F28-4682-A717-570E2B528EFB@zenlayer.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <FA285FD8-1F28-4682-A717-570E2B528EFB@zenlayer.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/21/25 6:10 AM, Faicker Mo wrote:
> 
> ﻿On 2025/5/20, 18:38, "Ilya Maximets" <i.maximets@ovn.org <mailto:i.maximets@ovn.org>> wrote:
>> The idea of not failing the parsing is to allow forwarding the packet
>> based on parsed ethernet header.  So, we shouldn't fail here.
>> We're also keeping num_labels_mask at zero in this case, so it'll be
>> an MPLS packet with zero labels and it should not be parsed further,
>> but can still be forwarded.
> 
> num_labels_mask should keep the first max MPLS_LABEL_DEPTH labels.

If the packet is not properly formatted (doesn't have BOS bit set anywhere),
then it should be fine to treat it as packet without MPLS headers.

> This is a MPLS packet with max MPLS_LABEL_DEPTH labels to continue forwarding.
> 
>> But also, there is another overflow here that is actually causing an
>> infinite loop - the label_count * MPLS_HLEN easily overflows u8, so
>> the check_header() a few lines above doesn't work properly starting
>> at 32 labels and doesn't break the loop. We need to switch the
>> label_count back to size_t or other sufficiently large type to avoid
>> this overflow and make the parsing end naturally when we hit the end
>> of the packet.
> 
> No overflow with check_header()?

Yes, if we change the type from u8 to size_t, then check_header() will
fail once we get to the end of the packet.  And that will end the loop.

> 
>> With the type change we may still consider returning early, though it's
>> not clear what the value we should aim for in this case. And we need to
>> figure out what the skb_inner_network_header() should be in this case.
> 
> We may parse until the packet end to set the inner network header?set to 0 if fail.

I think, for now we can just parse til the end of a packet.  The inner
header pointer will also point somewhere to the end of a packet in this
case and so there should be no way to actually perform MPLS GSO.  No need
to set it to zero.  We may consider setting it to zero in the future,
if necessary.

So, AFAIU, we just need to change the type in this function and that
should resolve the infinite loop issue, because check_header() will
eventually fail.

> 
>> One other thing,
> 
>> For some reason the patch was not delivered to lore.kernel.org
>> and is not available in netdev+bpf patchwork and not in lkml.org.
>> Both of our replies are available in list archives.  The original
>> email is available only via mail-archive, but it is ovs-dev and
>> not the netdev list:
>>  https://www.mail-archive.com/ovs-dev@openvswitch.org/msg94895.html>7C0d27725cb11d49f0b479a26ae758f26d%7C1%7C0%7C638833450887452972%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=1DXkGXqyAYVUf9BxH45MGy4BGSNozuUQwrU0IP8t%2FLI%3D&reserved=0
>> Same for v2.
> 
>> Is kernel.org blocking the sender somehow?  Does anyone know?
> 
> Sorry. This is my outlook web problem with html after the plain text body.

Yeah, you need to find a different mail client, since your patches are
not delivered to netdev@, and that's the actual place you want them to
be delivered to.

Best regards, Ilya Maximets.

