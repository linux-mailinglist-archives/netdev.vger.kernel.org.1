Return-Path: <netdev+bounces-112950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7835E93BFBF
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3001D1F21C02
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FC0198A3D;
	Thu, 25 Jul 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJmMHmHP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C0F339A0
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902417; cv=none; b=e5B93L2yyxE7kQsUvbip6D7+mVPkXNeuWPC1JmW73UoRGzwONGYVKYWN8wGwcWHldI0/JM2wjjkFfkLUOP1uNHgaumM41Wl6bi7mGVqApqZXhHzNH208eAazsXXJnLo4fEVqLOX7k3dpUXrnrWFv8+PNMOSnK/quxrejDfFK7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902417; c=relaxed/simple;
	bh=kZS/Vvw0CIg2NcQXfwPmF0/EJyNJWFZHLp6wP/n4+b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccyFFphR1XHYhQHOckOdGwtY4xXISSQypq47dowo4qy9SAooyLO4vQU/55frMAs9kugmAcOLxOLxMpUWHDTLU5UnYUcDeSzweSV/GOo5onapvU7LhC4YE1s6QHKSH/MJRNA/Yim5u39O7wGJ6PQfcjrPhA95OlAu3Em52xbA0pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJmMHmHP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721902414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h82meJUmBOJNnBSpKMpoM4unVVcCuigUwzLl+zEwfNE=;
	b=PJmMHmHPn4g13k2UHWNQ+lRgndpMt8TrckvP8VxgSytwLPS0SYbXEKLCh+Bz5ah6STocQ1
	+fglivr8TqspeO6tpk3LEyUsxju8nZ9VzzSjfdiishSsnA0C8ZruaqCmaHq+3DuybM7BvO
	yXwRae6cF28sJ7/FcdTKIYkZOG9CJNs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-vEBHXAg2NDa-nZj6aIrnAg-1; Thu, 25 Jul 2024 06:13:33 -0400
X-MC-Unique: vEBHXAg2NDa-nZj6aIrnAg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f01b609ac9so1744951fa.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 03:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721902411; x=1722507211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h82meJUmBOJNnBSpKMpoM4unVVcCuigUwzLl+zEwfNE=;
        b=oDXBu6RIiy5Bbl2tbSTO2gvIvsBKALqi/wqLGp7h6wvaXo6K4ZZ7f5PstkTlM8i/2c
         kR1SqjAeTHFycHzUJ4ho9MPGo0E2k/+aEd7A+Yn5xf9wnbvvTOWILRtg97jEimLGyyfb
         ThZFiiT+CVGtUnM9jZC/qI05DS0AvcRxkddybDV6W8WIR3VENi77ZkJPmIAtbwtYJjYN
         zDVuDaEeGX4yhMbN7jpUhIfF7RHzGWJeHwYdpLfM23bw4lNJbOKXAdtKrZxC7KgbgQdW
         pvVXMxp2rL78jKGlW8PWat+MbXnyC2YRA8hjWPV2NboxWSvAHfmnXEZJhdBuNJVJho83
         yB8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4PlpVVQ9NY+PKe3dcs+mj68Fby0ST9vdRtKgBgbUvoMeXVmv4PLGvf7Hsl6kVNwwo/8Z4ZEdg3IfIbJQdlMBcgjTJFW8I
X-Gm-Message-State: AOJu0Yx3ucZKlP+yCNKXN07bD3m8gh0pObBxY0lkgUD65penpTR/YsHk
	XxV/y6SS6tEb2pxzaoD5LAnaYctwGgV9HU14GsHTFb0xj2F3yfD21kJrjJAgSrgVAUE5WBE5qpq
	+jAHRaAZV8VLGENjhKasTeMIjtCg5CDTGZhdZSrCvKQpEUIODeALMDW7HDw+H5w==
X-Received: by 2002:a2e:a99a:0:b0:2ef:17df:62f9 with SMTP id 38308e7fff4ca-2f03c7dd359mr9051961fa.7.1721902411552;
        Thu, 25 Jul 2024 03:13:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWT8OHz5tTVwJV2gJIOLxmAVqK0y9pYW/gbJyo8BSSqXPWh33MRJYqYTSBxb/OEwPjVXWsoQ==
X-Received: by 2002:a2e:a99a:0:b0:2ef:17df:62f9 with SMTP id 38308e7fff4ca-2f03c7dd359mr9051831fa.7.1721902411113;
        Thu, 25 Jul 2024 03:13:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b231:be10::f71? ([2a0d:3341:b231:be10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9372a5asm70020375e9.15.2024.07.25.03.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 03:13:30 -0700 (PDT)
Message-ID: <d2014eb3-2cea-474a-8f04-a4251fd956c9@redhat.com>
Date: Thu, 25 Jul 2024 12:13:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] macvlan: Return error on
 register_netdevice_notifier() failure
To: Eric Dumazet <edumazet@google.com>, Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240724135622.1797145-1-syoshida@redhat.com>
 <CANn89iKOWNa28NkQhhey=U_9NgOaymRvzuewb_1=vJ65HX1VgQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iKOWNa28NkQhhey=U_9NgOaymRvzuewb_1=vJ65HX1VgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/25/24 11:44, Eric Dumazet wrote:
> On Wed, Jul 24, 2024 at 3:56 PM Shigeru Yoshida <syoshida@redhat.com> wrote:
>>
>> register_netdevice_notifier() may fail, but macvlan_init_module() does
>> not handle the failure.  Handle the failure by returning an error.
> 
> How could this fail exactly ? Please provide details, because I do not
> think it can.

Yup, it looks like the registration can't fail for macvlan.

It's better to avoid adding unneeded checks, to reduce noise on the 
tree, keep stable backport easy, etc.

Thanks,

Paolo


