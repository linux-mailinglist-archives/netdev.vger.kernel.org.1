Return-Path: <netdev+bounces-213384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A83B24D02
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3335A6F09
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451D02F83DA;
	Wed, 13 Aug 2025 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFDX/a+d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4692F83CE;
	Wed, 13 Aug 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097862; cv=none; b=eHFcwqpJMyX70oS25PkA+FM7pFxLdCBYx6yH0XnS5EDsxEUbtMQc40iRzDVQTTyQgzIWDDxTJUkZ8bifMAtBkl9mlNVOWbIbL2F9932zE5TP9sim5de4R3ABVZSVYAXRR+y40F+DQzSmbx3skAqWY0Z/RILgrqmDhQU17fIZHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097862; c=relaxed/simple;
	bh=T6PzKvaBAl0sHZEaG3KoN6oMA14iGxTj6iDN3n4qYLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZwMBbnWxqt6DwK+MSGtqknjXHihX+RFAe7gUHsQHygOHevhjB8hWWT9RqPT5KtWrOjbw1RydmafyS7LGnW7GmXDSS1zwyJrr5FrYl9y97VUehxGlDS18azzAB9XsfW9PEVmawFyssA/921D3K7+0oL3uu+iqiEjcerUvGVM+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFDX/a+d; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso42215695e9.0;
        Wed, 13 Aug 2025 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755097859; x=1755702659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtkdMyfCRuB76+xm3xhp5E1FXNlPLjI/VnBHA/rmI6o=;
        b=YFDX/a+dfPy3Xoadz4AIHt7GGo44b15R0Q2TGKE19IYXnrY6gXfWxqS+l6nCeyId8h
         y9QDMW1wxPX2FNcvSw+ajoJEYfs452ufhHYpLRqclH5K5NR9ZQZEyfbCNYB8ZEItX4u2
         ZBcBt1h81E21uB2u0wsX4qEj4G2xjINmd/T3wIjNX4tFWgnp7IfZaRZZQqXlMCpePqp6
         vK2PjgqBOedQ6RVQ77ZNt0EuHZUsJvKC0B33LHnIHiUxmJjJBbq/yNJ1/eDCglsfR3f6
         XfWSDCH13qlrPKnnn+Js4hN2yfrpzQF1MUgLJ91XMvlFEkH3tGpE47YEvqZwGDcq+9kR
         zCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097859; x=1755702659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MtkdMyfCRuB76+xm3xhp5E1FXNlPLjI/VnBHA/rmI6o=;
        b=mFbPCJ4thnhEOn+ehCoa0qhCAvc2SOSJ4ROKulYkCMviaiHuEBkRTSyKnDErb5ZZFj
         /3be9Nejn4YGH3z8lWBEwEPeXFY2idJXWrmaxI/EBCMyB4o8CZtzng7NcNZ8O92aIG73
         PagBYyRivNYpbtKHVquDAe/hz0IW5xyT/kIm4Yug3YDLn29vs6fvNf0LV2QJgIgHcxVF
         fjlq9PlboSF0eF9KHyToZH6RPe5yg2YZA4bDxB6ASc+TcCjJxFLMh1JQuKPI1d7XHJ0P
         qlLbmUh2UBoEiX6wYHFuJXOUA7Y51+FRUQFpaBXh7Uk3Cq/SW+MGaaEu0vYes12cf7ry
         FyKw==
X-Forwarded-Encrypted: i=1; AJvYcCUd5aasDZTngKoB9WSr4w8OCLnmc6QQgdMDQM5dIjFbr/hb3wUcTAQqaQrKUKt0YOCUy6bWkqbjV9E4jcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLj5FJFZAmw4xz8iNbY8oKHXkkBSTvjhZNP+Fot5aeCv6rwwJL
	21zA1nsRiLUKeDNAN2MHKV6XwzRn0eUNQ7etICevINEwEcv+bDW4566b
X-Gm-Gg: ASbGncu8Owc0A9fnrvtjYev0DbGkBlWw7o1oKtKBPH8T5OTl1pnwjGv7DpIpIfofsx4
	5OgINtgQ/jw9gyCKd9py5CGq8KhpWAvUYeMhANomz5DO5dKwWqvEFMJFb6xML7XRVfp4aiPrwun
	Jmz/A5BB6/rK/KKDDOdRVHsI+IUm3ytynJep5UAqgekFxU2xFE2ECj6tzecqcT1CFp1Y9RL5ltX
	dDQ70Txa4I9RijsNNphAyFvJ9PIOSA+SKsuX9aerSMJFTwRIUsqKWb3F+yYL/G6w7SM9oPOeYRa
	20fA+p/73xYc5fwDuU4Y2EHaAm67bTBLGsLS7YsKrviMDEY4A0L25GRIe8ubUHoiOiUzf82UbJX
	8u9rZoCykvfBigFJRUJoU+YHaLtdaQoG10g==
X-Google-Smtp-Source: AGHT+IFu8pB0HNWtETpfIY/dDfhQOFqj/eMkPZiy+OnD3O/j4DscXl3QcbkORKE4i+tlfHJU7dx+zw==
X-Received: by 2002:a05:600c:1d1b:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-45a165afbd0mr38146465e9.10.1755097858519;
        Wed, 13 Aug 2025 08:10:58 -0700 (PDT)
Received: from localhost ([45.10.155.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a590187sm5343425e9.25.2025.08.13.08.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:10:58 -0700 (PDT)
Message-ID: <d6e37117-4409-4ca5-ace6-7af1c9fc0cd9@gmail.com>
Date: Wed, 13 Aug 2025 17:10:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 1/5] net: udp: add freebind option to
 udp_sock_create
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, dsahern@kernel.org,
 shuah@kernel.org, daniel@iogearbox.net, jacob.e.keller@intel.com,
 razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
 martin.lau@kernel.org, linux-kernel@vger.kernel.org
References: <20250812125155.3808-1-richardbgobert@gmail.com>
 <20250812125155.3808-2-richardbgobert@gmail.com> <aJxaIeUT8wWZRw22@shredder>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <aJxaIeUT8wWZRw22@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ido Schimmel wrote:
> On Tue, Aug 12, 2025 at 02:51:51PM +0200, Richard Gobert wrote:
>> udp_sock_create creates a UDP socket and binds it according to
>> udp_port_cfg.
>>
>> Add a freebind option to udp_port_cfg that allows a socket to be bound
>> as though IP_FREEBIND is set.
>>
>> This change is required for binding vxlan sockets to their local address
>> when the outgoing interface is down.
> 
> It's not necessarily the outgoing interface, but rather the interface to
> which the address is assigned.
> 
> Anyway, I'm not sure this change is actually necessary. It was only
> added in v4 because back then the default behavior was changed to bind
> the VXLAN socket to the local address and existing selftests do not
> necessarily configure the address before putting the VXLAN device up.
> 
> Given that in this version binding the VXLAN socket to the local address
> is opt-in, it seems legitimate to prevent user space from putting the
> VXLAN device up if the new option is enabled and the local address is
> not present. It can also be documented in the man page so that users are
> not surprised.

Sounds good, will change in v6.

