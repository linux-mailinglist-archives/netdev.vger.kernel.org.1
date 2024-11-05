Return-Path: <netdev+bounces-141859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73889BC8C6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390881F23C54
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866B1CFEA8;
	Tue,  5 Nov 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbK0VwdV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB641C3025
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797927; cv=none; b=kED01a5LHyuzrBrf0aOKNqDCTFxzvZjUx7QWu5FwcNE+U1dOkjIeE437ycfZejhq7281VoSwXowAKxnPtIYV7+mMIsHbnI2qRaQGx/b8X8fU5h33MUa+uungJ5ptjY2CugvzuDJimcgrpOm6XZWbwYODsb3b5VvrxMsiHmSqXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797927; c=relaxed/simple;
	bh=7qxoYeh0UNTIQAvpcHLzqALNi2h3AYcCDoYkGPVhrps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+9cCTCyCwYJASWsJiVYpI40njFcq5hHszqzCu7L0xeA+2b1l9JI4LO/TqC5OWOhyccHlCPCmo0LECKkVtrSqu/4KSGkGVsSYBP0DtUnnirh6S07uS/9Zu/9ggSeXOZYcSKL6IoBmX4ZZCKsMYo6xCnmXskmERnjxUI6fubbgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbK0VwdV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730797923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPboAr9Vrbfot/ZtNUHg+u5qHvWpgmD4jh6l9COaVZY=;
	b=bbK0VwdVFH45NFzIZRSu7+U+YGIIlLNAuCUEyyA1wRqTdc6ODfoQz4aHT++10dcYZwUd2D
	QqZeSuKUkdKLA1cXpoDbThWZ3c47rG5q5ToSFe2CNgmSx5566zKQW+SjeNufb4z+Fw4W2q
	RmA8wqa6GibKTZ3s/la8W379tXtZnH8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-hEFAJLJCOiSDDBxX-w0MjA-1; Tue, 05 Nov 2024 04:12:02 -0500
X-MC-Unique: hEFAJLJCOiSDDBxX-w0MjA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-431604a3b47so33006935e9.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730797921; x=1731402721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPboAr9Vrbfot/ZtNUHg+u5qHvWpgmD4jh6l9COaVZY=;
        b=Hypx35T79nEgcdAaIgZnZ9dLIUJHM0qG+NUzFEMW8GHKU6SiBQLDGdsGHVrRrEKqEz
         mgEf6Ge6ienPFmRzdQ6KgKFg2DB/VRfwuEf/YES14CGS9a0YI+29Pn3bANS9h4wgoIfE
         IR5pXsjaxv8MCvoiAOC0TX0d/WzPT170/+oU6oMRUiSXzActS1WGYMjd+ckGRTV5n88w
         Xrtv+UPAnGoOhz6+MTp/qtE0uPBgy8wUBKksGsf285S2MdmM1dHPootDvrqp13/227pW
         xT6+zuif/ltNOhkA0mzOg2UQFodduXQvGy0YyuBPsaooNAWjpYLFf8hnXKVVy/kYWrTc
         X7lg==
X-Forwarded-Encrypted: i=1; AJvYcCX8S/P+xj+Z98mvorz+Wfw7pSeSZayJHBSQ/nKlmPQ3XZ/J3PiS2inO9TLtF82grRUgxffVhmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVOvLTGgd+TxE0OJ/wMtWkDfHYnMTrhjBdWonhqueGQ7QEiJUx
	4/OLueUlBuKucF513c0+mxN37D2GVss1NNQEAUf27DhLiG8vdkjPK40HKLIy5NLaoo/VH7Hz8X/
	9nkeeun6QvlTqzwvP7SicMxBzxl0y8rlySmMg4lNJCi+RFJxmOd3FZg==
X-Received: by 2002:a05:600c:5249:b0:431:6052:48c3 with SMTP id 5b1f17b1804b1-4319acacd6amr331592535e9.16.1730797921067;
        Tue, 05 Nov 2024 01:12:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfEmxPafpgpApl5hDQwr9QfRtM5jAmJU2SuJZkjt4o3ri5KW8DZmqElmalUu2LjqH1BonBkQ==
X-Received: by 2002:a05:600c:5249:b0:431:6052:48c3 with SMTP id 5b1f17b1804b1-4319acacd6amr331592255e9.16.1730797920687;
        Tue, 05 Nov 2024 01:12:00 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4991sm15606801f8f.29.2024.11.05.01.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 01:12:00 -0800 (PST)
Message-ID: <7426480f-6443-497f-8d37-b11f8f22069e@redhat.com>
Date: Tue, 5 Nov 2024 10:11:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] net: Shift responsibility for FDB
 notifications to drivers
To: Petr Machata <petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Andy Roulin <aroulin@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1729786087.git.petrm@nvidia.com>
 <20241029121807.1a00ae7d@kernel.org> <87ldxzky77.fsf@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <87ldxzky77.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/24 12:43, Petr Machata wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
>> On Thu, 24 Oct 2024 18:57:35 +0200 Petr Machata wrote:
>>> Besides this approach, we considered just passing a boolean back from the
>>> driver, which would indicate whether the notification was done. But the
>>> approach presented here seems cleaner.
>>
>> Oops, I missed the v2, same question:
>>
>>   What about adding a bit to the ops struct to indicate that 
>>   the driver will generate the notification? Seems smaller in 
>>   terms of LoC and shifts the responsibility of doing extra
>>   work towards more complex users.
>>
>> https://lore.kernel.org/all/20241029121619.1a710601@kernel.org/
> 
> Sorry for only responding now, I was out of office last week.
> 
> The reason I went with outright responsibility shift is that the
> alternatives are more complex.
> 
> For the flag in particular, first there's no place to set the flag
> currently, we'd need a field in struct net_device_ops. But mainly, then
> you have a code that needs to corrently handle both states of the flag,
> and new-style drivers need to remember to set the flag, which is done in
> a different place from the fdb_add/del themselves. It might be fewer
> LOCs, but it's a harder to understand system.
> 
> Responsibility shift is easy. "Thou shalt notify." Done, easy to
> understand, easy to document. When cut'n'pasting, you won't miss it.
> 
> Let me know what you think.

I think that keeping as much action/responsibilities as possible in the
core code is in general a better option - at very least to avoid
duplicate code.

I don't think that the C&P is a very good argument, as I would argue
against C&P without understanding of the underlying code. Still I agree
that keeping all the relevant info together is better, and a separate
flag would be not so straight-forward.

What about using the return value of fbd_add/fdb_del to tell the core
that the driver did the notification? a positive value means 'already
notified', a negative one error, zero 'please notify.

Cheers,

Paolo


