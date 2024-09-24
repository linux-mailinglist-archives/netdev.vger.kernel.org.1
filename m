Return-Path: <netdev+bounces-129458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B000098405D
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E625284CC9
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B546149E0E;
	Tue, 24 Sep 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Co1EI1jQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA422315
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166247; cv=none; b=URXnZc1nXKgwsjcfrHSxnP+kSgRb6f2OIrjGSCf0YCMeoU0jWc4HP0SnWsjTdyZbIbEIUhkSwkXnZbqcQViHGokZON4q3kZF0F08LDyYAm19NxnPKv9nj79ZAQrMKkpJi8vvfHf7bQpTNxdK8RssRox00IruSx1KC4rvakn6bdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166247; c=relaxed/simple;
	bh=noUuA7q9ZMrbUSgv4bUHKB/guoHWr5rT9yLXd28anuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m23VtQFz0PrNZBxfUSs95nKwXOSIeco34DhdjC16Ef/zp53Oyd1TGH4A0oRwNPApIbyb7bRfAooGw0+tYvQ5ZymvgCe+CZy8qFgn3nNFcBoiWNrsTspU5eX+A4i57pGUCDybpnxbHYBv30qDRram9v/6r55lSn5NLnr1G2MNhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Co1EI1jQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727166244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIlitERiNgGwslbrPYwxy5NrLq+eSBfNViybd5BntQc=;
	b=Co1EI1jQb3AeRPWyRJJHtCJw98rgzsgLDtbxYHTjFaHSlvy3pX9YlQr9Jy68N9RIGpa+zy
	suLNa3g5f49vz/HJZKBczgrzElRgP91kDm/KHPnyQLZW0Sh9OvdNV0Og/yWXhy/XSkF9OY
	xfxC4LNfo7QpBnORPkN+XCQZDIwUgV4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-0HTJyeiOMQeEWywC-cbpQA-1; Tue, 24 Sep 2024 04:24:01 -0400
X-MC-Unique: 0HTJyeiOMQeEWywC-cbpQA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-378929f1a4eso2644168f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 01:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727166240; x=1727771040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIlitERiNgGwslbrPYwxy5NrLq+eSBfNViybd5BntQc=;
        b=a3/pplv+SF3R/8r2BC7ZVMY8AzwZOnklft+/z1gQHo0/OY+GqkAgJkq5bQfrj+cx9d
         5oiCh4el/M7Km76X0CL8NFE59CX7+fbwBeX2ABmP4SVV5iknasLW9ykC57KGuuuHu/oK
         QJaLvdkGRfWKUtsCgP4Q4b/5IEAmjAbCpeGyz2616Joh/xzrvVA+a3vJOgfYbUgXNX1V
         O5ZCVYqX9Eib+/8EaZDec6t69B1paYNI6Sqz0KVLcpeUCQMXUerkr/ChBQUFUVpbMhGg
         srlUvX+iqM4cWXVj8fBliddW9AIt1Hglqe4WWVOUQ1ta+asdalVEhhUvKu2Rgz5rrD6a
         7GiA==
X-Forwarded-Encrypted: i=1; AJvYcCVf7Lcv9/jMrN6uGYN05Dj8R7fbWz7JuzMEDdgYhcRouWjzCEkdoIhS9M6lvSzQAyPj2QiG/fA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7x8ZMXI5hxiDG6SU2td7v2isyc+MfL5DttFpkUI7sJLY2LrjF
	70CFj5MJvmHfKij+7jXc7guyzN1xmaanhd3jiYBslGHPU/+iq4oIk728yp8OebTcz61L3gfNdSp
	8PJl//CSkOlCxObec+YfAQ0TW4Pojhw0XWb3Y1HHtZEwe8sxRooXsdA==
X-Received: by 2002:a5d:698c:0:b0:373:b87:55d8 with SMTP id ffacd0b85a97d-37a4312aa5amr8379691f8f.3.1727166239848;
        Tue, 24 Sep 2024 01:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYsA6jF2e/jufGHPqKrqKZ5nhlCVNl3Cd0imiRfRdAMylHxVAdBz51O+T14N/+Ke0nUY4Iaw==
X-Received: by 2002:a5d:698c:0:b0:373:b87:55d8 with SMTP id ffacd0b85a97d-37a4312aa5amr8379677f8f.3.1727166239413;
        Tue, 24 Sep 2024 01:23:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e902b67adsm14190415e9.34.2024.09.24.01.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 01:23:58 -0700 (PDT)
Message-ID: <80a295b9-8528-4f37-981c-29dc07d3053f@redhat.com>
Date: Tue, 24 Sep 2024 10:23:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: sockmap: avoid race between
 sock_map_destroy() and sk_psock_put()
To: Dmitry Antipov <dmantipov@yandex.ru>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com
References: <20240910114354.14283-1-dmantipov@yandex.ru>
 <1940b2ab-2678-45cf-bac8-9e8858a7b2ee@redhat.com>
 <b9ff79ae-e42b-4f9c-b32f-a86b1e48f0cd@yandex.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b9ff79ae-e42b-4f9c-b32f-a86b1e48f0cd@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 11:26, Dmitry Antipov wrote:
> On 9/19/24 11:51 AM, Paolo Abeni wrote:
> 
>> I think there is still Cong question pending: why this could not/ should not be addressed instead in the RDS code.
> 
> Hm. Except 'rds_tcp_accept_xxx()' functions, the rest of the backtrace
> is contributed by generic TCP and IP things.

AFAICS most of RDS is build on top of TCP, most RDS-specific bugs will 
show a lot tcp/ip in their backtrace.

i.e. with mptcp we had quite a few bugs with a 'tcp mostily' or 'tcp 
only' backtrace and root caused in the mptcp code.

> I've tried to debug this
> issue starting from the closest innards and seems found an issue within
> sockmap code.
> Anyway, I'm strongly disagree with "unless otherwise proven,
> there are a lot of bugs everywhere except the subsystem I'm responsible
> to" bias, assuming that a bit more friendly and cooperative efforts
> should give us the better results.

I guess that the main point in Cong's feedback is that a sockmap update 
is not supposed to race with sock_map_destroy() (???) @Cong, @John, 
@JakubS: any comments on that?

Cheers,

Paolo


