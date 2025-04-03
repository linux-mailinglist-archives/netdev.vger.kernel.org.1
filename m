Return-Path: <netdev+bounces-178985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A105A79D73
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 09:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6DA7A518D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD7F23F419;
	Thu,  3 Apr 2025 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsQefNoq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD4DDA9
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666882; cv=none; b=D1sRGjPDG355KjQ9+LVfQnwgqjc3qSXurXM9FoAtqclC31voZLJU5M43o8yONJ3bNibcZut1mpW5L2Z+aZ+Nl1yoehJAg0uSuQQ93IqsWr/NwsfH4ubPlUPdeB1zw3IlL4N4+BSXSrGLMF4PtKya7pLbnRH2d9nbIAWtvDSqXLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666882; c=relaxed/simple;
	bh=gf6i0CVAAzE10h7dA00ZSf1pRHDUOoM/SpLiNoBF0BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEFsq1ZaaYWsftOU0DOM21JHx1N067BIWUJGgiH01z6Z9eh9Dk9NHLGhJO4u5yW8V5hD5bYNQCC/bAn65ufzXXxdP2bbBbRxzwszniXAVyHNECVuLT3hCgUTaCuYt+mXBRz4dnqVkhVvBvSfAne+FJDHdfXP653vfAgDimjdZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsQefNoq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743666879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mz1m2Mglph/2wgaShkIRZ/HYGAaWZeLEqP3Em69Ffko=;
	b=RsQefNoqWVQmriIDr5uFtMp+hfViELQrXalHmc+ycUuyTvm+erchVxGmDs5H4ZBbPrLnPT
	EbmBjfVYocxRKKjQn4CnlPYOxDwu73OuoklO2KlufFIr+IhHBwrh3utHrCYbbNhjvlQ5uT
	489aLcOVhAEchmnMOqRJrJaSccTditk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-KbYLsNAANAezoRjyjt4jlg-1; Thu, 03 Apr 2025 03:54:38 -0400
X-MC-Unique: KbYLsNAANAezoRjyjt4jlg-1
X-Mimecast-MFC-AGG-ID: KbYLsNAANAezoRjyjt4jlg_1743666877
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913d8d7c3eso342167f8f.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 00:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743666877; x=1744271677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mz1m2Mglph/2wgaShkIRZ/HYGAaWZeLEqP3Em69Ffko=;
        b=OEMYZ8Db1zG4brVUCi7/p3Q4b5B3pw/XzK4Uaog4AsfzOdV3chCktyvlcJ01aNni8X
         Yl1vwtTyjdyqFgNEfZX4fQAvR8S9AldHM/ivbgp2vpC4ria++R/O0eDsBQ5jZx6rzoCy
         Yaro0diWWr8F+46k6rbxv4fhvmTIMMWTzCpOEFXdezZygs+57l5vG8tuROynq+79y3tc
         BGJNGvOahy/wpsawUE6HEcL2QzavQeQ0GU3LkzfLbzU2H/bifQbwMAOMOxNgt9ojOKuS
         FOEiqjc10k67QE+aIUiDHOkHpEr7Up5mkrkQV5etRlLlWej/ZDd2xHAMwU3CqiPYMEcr
         NIeA==
X-Forwarded-Encrypted: i=1; AJvYcCUDtHBS6PrgLv2dv9aMUFMAKovk7Sex1dLo7uKSwN9CY01499TQPjR/iXOh03SiI2CaUQqRKwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+CU4WXL4+Roi5fsNaNchp6T1G8s9eJ48V1fgOYFefE2MnVV1Q
	X0wXusse+vGqoQqB7BVhuFbUnZQXeDiZM2KCJiuqkKd4izcBOyl8JMmnYiLqIYqTTLHJibQjEJJ
	czrjoA4PtxC0e9hkk1yAQeTBQwMPFKfhQCpqW8jXT4+VVMzjL7ITYGA==
X-Gm-Gg: ASbGncs59w1b9SHsReH3SsUfkxeQdjJ4pFius2HhvZiwcnVA9sdtd29EdMPZXxIstFS
	GrreubjQpvrpA1ugFTrBWuCvxy6USo6AZ9OsttoFMo6wEvsRDV0/GkL0tHaUwxCMEFRjBoRI2+c
	7gpZvHR6FLtx72VTxooUATOv+Ossr64pOvLRPCzYLMJWAdKjTZvfURbooSjiYd8FirHLNmFpaI9
	mvVzYnTeZkhYFev0zjSOQ2lM5XnGeRHF2Y3UL99Bi65waJGdbzVhlSwwgqWnoHQ60KbGyiaH/19
	0xwu/G6nMFNcSB1CEcXhc6phXLAMYVPspxRHjj31cbORoA==
X-Received: by 2002:a5d:588a:0:b0:391:3fa7:bf77 with SMTP id ffacd0b85a97d-39c120e3519mr15921203f8f.31.1743666877172;
        Thu, 03 Apr 2025 00:54:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1And0QrQEVjir4GMSk2Lsi+httiSOnojJoqQ368wxmdq0Sn4aBnwA8LOogIOGQwQQEQgNOw==
X-Received: by 2002:a5d:588a:0:b0:391:3fa7:bf77 with SMTP id ffacd0b85a97d-39c120e3519mr15921182f8f.31.1743666876820;
        Thu, 03 Apr 2025 00:54:36 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096964sm1069807f8f.15.2025.04.03.00.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 00:54:36 -0700 (PDT)
Message-ID: <58ad78a8-f84c-4249-b95c-e74d3edf1149@redhat.com>
Date: Thu, 3 Apr 2025 09:54:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Discuss]ipv6: send ns packet while dad
To: gaoxingwang <gaoxingwang1@huawei.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
 yoshfuji@linux-ipv6.org, David Ahern <dsahern@kernel.org>
Cc: kuba@kernel.org, yanan@huawei.com
References: <20250402121205.305919-1-gaoxingwang1@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250402121205.305919-1-gaoxingwang1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding David,

On 4/2/25 2:12 PM, gaoxingwang wrote:
> I have an RFC-related question when using ipv6.
> 
> Configure an IPv6 address on network adapter A. The IP address is being used for DAD and is unavailable.
> In this case, the application sends an NS packet to resolve the tentative IP address. The target address
> in the multicast packet contains the tentative IP address, and the source address is set to the link-local address.
> Is this allowed to be sent? Does it contradict the following description in the RFC 4862?
> (https://datatracker.ietf.org/doc/html/rfc4862#section-5.4)
> 
>> Other packets addressed to the
>> tentative address should be silently discarded.  Note that the "other
>> packets" include Neighbor Solicitation and Advertisement messages
>> that have the tentative (i.e., unicast) address as the IP destination
>> address and contain the tentative address in the Target Address field.
> 
> Or is this description just for receiving packets?

Yes, AFAICT the above paragraph refers to incoming packets targeting the
tentative address. Outgoing NS packet must include the tentative address
in the target field, otherwise DaD can't work.

> The actual problem I encountered was that when proxy ND was enabled
> on the switch, the reply ND packet would cause the dad to fail. 

I think more details on the problematic scenario could help. Who is
sending the ND reply? who is performing DaD? possibly a diagram could help.

thanks,

Paolo


