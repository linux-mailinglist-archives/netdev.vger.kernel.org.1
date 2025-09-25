Return-Path: <netdev+bounces-226207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA11FB9E0E4
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF9A1BC4738
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9925B270EBB;
	Thu, 25 Sep 2025 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hio2s4IJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CA26F2BB
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788861; cv=none; b=Az5ohDKpzP5KAF1Dmp/fxPRnjDq5u9s+MVW/MZlIg7Si7WKdxj9hdFs0HO7oIsU5E3p1Eh0rT05gn2LUibruG6Tuj0Ctehnrz6LC5jLGnSuoJ+/y8aEHzuSQGFCavRikMq/M76QTZpjITBAoUaYgbaOt/ciXAAo7YncsDqoB7y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788861; c=relaxed/simple;
	bh=N+ZG5coI1WP7SFYVU4P7vwHDI9bQ31UxS737qp7yfGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvmflor6YYsMvu5pbTZk1/UGkmQMia/4hEhpA+Wp8Kthbn3iu3VhXYEguO8T+Qp1Pex4Un1K6u5tM86F9wpvWM/4gVI2Ze0I45BOzvOiYrWL8uWvFeERhAnd20Cq0WwpfNpgt/+NYgaxjb0KBzfUcuWrXbZ+SqxC1KkyhHIOdno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hio2s4IJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758788858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqKsFhpLjz5a+T557IYC+7TN8m5k6heErnY27DMOm5c=;
	b=Hio2s4IJ3EIbpAYxwbRfUgStlFU6ytYztiRB6MwQNcWI8/eRJCuGPTfYw37fCohNWHAXxA
	WhbehhjtNVIp6KJGPJI0h7PAUuZPSI+ZXdHT24HoxfvCsv/90EExdwvdSVmxZraS4ajdYY
	c46uWk9vXCF1embS1jE88/+CrSdR9r0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-2FT3PDPkMeuNSlLG7uDJfQ-1; Thu, 25 Sep 2025 04:27:36 -0400
X-MC-Unique: 2FT3PDPkMeuNSlLG7uDJfQ-1
X-Mimecast-MFC-AGG-ID: 2FT3PDPkMeuNSlLG7uDJfQ_1758788856
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f3787688b0so326458f8f.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 01:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758788855; x=1759393655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqKsFhpLjz5a+T557IYC+7TN8m5k6heErnY27DMOm5c=;
        b=v5BzjxNaGiqc/aKK63hTy4nzfVkFEoGQxexeh0opxAWQl/pBfTo6DhP8rL4A6ISdh9
         UFXKwKS6VQEBQLMQYW+UuX7XQHtLZgUiYgWxieWUGQHT6tL67WXMkjZAGEBSWZl4JLAC
         tFiN6T7RL8aYugb7ryQr46SQOxlX4eToSEvaTR6iS7J//pAPsCNKzxYOJ2OjDJE1Z7nS
         6Dg17gcu3BBXscD8/AswQzA7vMcwWWeZhlO+mW4T6ZzElyci0zbnzY6YZ9LeZ7DzP/AJ
         LGHOeaZJL3GNPmVSqlHUHtSUBnFW4Wfey55S8MlAlMR40WHq/71Ivbrx2GVnP34CX92Q
         wOwA==
X-Forwarded-Encrypted: i=1; AJvYcCXmrciB8whMSNn+Pr25v3Rr9oZDV30eLMBUWQu5WLL0ME/QVy4htIkLC5SoiO6pgIUh5N6Ks/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU81BS7eICHHnilUh+anXVgGfA3txXEw71B4QE287OXg4IAou+
	Nnw2lbs1BaCy84i+9Am4u+yI4z1KNkpthuWCyvQRxEmwKshUNNg2U5XeInQhC3Ua8piVSz9xyHA
	Jynd64v1O2KsTRc0A9aopY86PUL99G8sddLnMoMCtjYNvLx6VDKzpyUZjyw==
X-Gm-Gg: ASbGnct24NH1nFd2osCMuTcXXEWUKD5vW/qV5+AZKzifyXuvmrr7y/VqMMif07ydFko
	A8vykhHWWeUF7IQfaH14/bpPCeRZK8twgG2VGI41OnboOs2T8hK9dySYkIe0PO0kZ+Dv68xbzLm
	HzIUTH+gSbuy9C5dgC/PPtMqLSkBGzZUmAUDCeSJsZ8lNeg82OFsjOz1AZa7jgGU/crC0hy9UGq
	wmmjDlZFcor7nxan5h+meLKRxfednF+NtVuS58plHwiTRPbvnrSZ9pTijw9fEUDMuuYr7JXMUqY
	JZj39GJQfBD61z48axjbE2YFuvVIbgIQsQlzik0sOn1nfc4w90hOF3O52ngilNB7W2tG30TIulg
	/DPyNZVAVvwzZ
X-Received: by 2002:a05:6000:2285:b0:3de:78c8:120e with SMTP id ffacd0b85a97d-40e468e7392mr2235016f8f.6.1758788855455;
        Thu, 25 Sep 2025 01:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCjeaejlFM7FhJpo/MQ/rP5fNB+0HqsfCa6D7Uoem98sO42vPd1fAJXHhAttEqszrTyfh6FA==
X-Received: by 2002:a05:6000:2285:b0:3de:78c8:120e with SMTP id ffacd0b85a97d-40e468e7392mr2234988f8f.6.1758788854950;
        Thu, 25 Sep 2025 01:27:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac582sm69482765e9.9.2025.09.25.01.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:27:34 -0700 (PDT)
Message-ID: <495324a7-cc5e-4658-a4ec-47e3e5ba96f8@redhat.com>
Date: Thu, 25 Sep 2025 10:27:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] lantiq_gswip fixes
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20250918072142.894692-1-vladimir.oltean@nxp.com>
 <20250919165008.247549ab@kernel.org>
 <20250918072142.894692-1-vladimir.oltean@nxp.com>
 <20250919165008.247549ab@kernel.org> <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
 <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
 <20250922110717.7n743dmxrcrokf4k@skbuf> <20250922113452.07844cd2@kernel.org>
 <aNNxC7-b3hduosIh@pidgin.makrotopia.org>
 <b2257603-382c-4624-9192-2860208162c9@redhat.com>
 <20250925081452.7u7hvvgac62xavk5@skbuf>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250925081452.7u7hvvgac62xavk5@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 10:14 AM, Vladimir Oltean wrote:
> On Thu, Sep 25, 2025 at 09:35:54AM +0200, Paolo Abeni wrote:
>> On 9/24/25 6:18 AM, Daniel Golle wrote:
>>> On Mon, Sep 22, 2025 at 11:34:52AM -0700, Jakub Kicinski wrote:
>>>> On Mon, 22 Sep 2025 14:07:17 +0300 Vladimir Oltean wrote:
>>>>> - I don't think your local_termination.sh exercises the bug fixed by
>>>>>   patch "[1/2] net: dsa: lantiq_gswip: move gswip_add_single_port_br()
>>>>>   call to port_setup()". The port has to be initially down before
>>>>>   joining a bridge, and be brought up afterwards. This can be tested
>>>>>   manually. In local_termination.sh, although bridge_create() runs
>>>>>   "ip link set $h2 up" after "ip link set $h2 master br0", $h2 was
>>>>>   already up due to "simple_if_init $h2".
>>>>
>>>> Waiting for more testing..
>>>
>>> I've added printk statements to illustrate the function calls to
>>> gswip_port_enable() and gswip_port_setup(), and tested both the current
>>> 'net' without (before.txt) and with (after.txt) patch
>>> "net: dsa: lantiq_gswip: move gswip_add_single_port_br() call to port_setup()"
>>> applied. This makes it obvious that gswip_port_enable() calls
>>> gswip_add_single_port_br() even though the port is at this point
>>> already a member of another bridge.
>>
>> Out of sheer ignorance is not clear to me why gswip_port_enable() is
>> apparently invoked only once while gswip_port_setup() is apparently
>> invoked for each dsa port.
> 
> All ports have to be set up during probing, but only the ports in use
> (in the "after" log, these are the CPU port and one user port) need to
> be enabled. The user port has a netdev, so it is enabled on ndo_open().
> The CPU port doesn't have a netdev, it is always enabled.

Understood, thanks!

> So since I got my testing results which I'm now satisfied with, they
> don't actually need reposting. If you can pick them up for the "net"
> pull request and they're merged back into "net-next" later today, it
> should be even better than reposting them for "net-next" - which may
> require some avoidable rework such as dropping the "Fixes" tags.

Side note; generally speaking it's not needed to scrub the fixes tag
when reposting patches for net-next: we can have fixes landing to
net-next (i.e. invasive ones) and we need the correct Fixes: tag there,
as stable teams will still (try to/want to) pick them up at due time.

Some times the fixes tag is removed on net-next repost because it's
agreed that the change in question is more a refactor/improvement than a
fix.
I think patch 1/2 here belongs more to the first category above than the
second.

In any case, given there is consensous for this landing on 'net' I'll
pick it.

Paolo





