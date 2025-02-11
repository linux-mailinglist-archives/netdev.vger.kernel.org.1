Return-Path: <netdev+bounces-165134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D326DA309D1
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56AD162ABF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B45A1F940A;
	Tue, 11 Feb 2025 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZTNGrui"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FA81F942D
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272771; cv=none; b=t4yzcz825eTT6xeC6hh3X6ftQUfvICVmRFZ27reTc7ODj76hHBO33dKxwRXbPuxinGkcuU+wQG/JDWdlRaNfwYe2RoE+qltG/oIrC8gS3yR+XM/NfsMtkAY/4/N2OLNLtD39ifN9dnUZv1TxG4NsudhLMfNSoNWn1kvTG/aWlo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272771; c=relaxed/simple;
	bh=A6kDijY1CxU3jwpKODbbC8vCmkKQJjjacTCdiLn75Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4IsDHTdgHTUQXqYk7SLbgTTCeEVnVtvKVxjWlgEEoLirKCdSoBwVlpmuuw1jnrlLOb1FDEvIA0OH27XB71kjc5DYSmv9Tg4mykh3qDPuyk/aJ8PxuiFK17XfCIIeF1gW6nqUnAXWNuSoOsmQkIbSQNzr/y/lLNdgelYSnbDLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZTNGrui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739272769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKKlOAHFJNzqARLCniSKjEWDKr2MGQlvqNtXg2rOPEI=;
	b=DZTNGruizautB6a7PHPwXoJQ8Jz5A0PLuL6uG05O9qaPQ71pTlaBw1yNWX8KBTeP3RZ0Ys
	0gMFEo/NUgsqT4McL2+4RE9ftJWoviw8WNsRV+xmFzweQS/epn+Rp0XwQm4dVYj9bNTqO1
	8SN3sgPPn8CXt5bS/iKV4Lm03xwPSAg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-ofJrBm1zPGCONi-x4PYRhg-1; Tue, 11 Feb 2025 06:19:27 -0500
X-MC-Unique: ofJrBm1zPGCONi-x4PYRhg-1
X-Mimecast-MFC-AGG-ID: ofJrBm1zPGCONi-x4PYRhg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394040fea1so11639645e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 03:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272767; x=1739877567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKKlOAHFJNzqARLCniSKjEWDKr2MGQlvqNtXg2rOPEI=;
        b=VkHOIud4Z17HMhQmsIc+n7++NPyho2AGxoPuHZw/1oBG0Q9WfuShOsEBwKxr3ipXI3
         2iDQWvdUZsHdi1PQn8vtiSialolFFpFFjEmFoffjjhS5r1wtOOETg4bonGSG3iTMK89b
         JSeJCi2YDLKoYPZ1VlqOqZuNjLB+rwl9W6gF4R3iJFpmhtK8jDOT4shCH9K9rsy7EKLa
         ojXt8ktm9VGSEJEC0Anm26lRVIU6tn6+T9VcJVUA9JQgw68Hua3p7925z5i9MvoA5NGH
         UfGJc8NhkizoYCewCTkP29Tg7JoffJlBD0VDCJZpaTHXd5yieZN9ogoOhl2CEBd7hlbz
         HKYw==
X-Forwarded-Encrypted: i=1; AJvYcCWFMUXUoS1/cH30nG1EoF/JuIQSMXkPhx/0sH/mBCNhg4bI7bEFNtQotY8h9lUHrznwGaTQUxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Z3ZXqaguptEc7OpoIq486Jv4aVOQDx68DFIfV8c3MY60Ce/c
	5jTbeCtIc1HylBVkHnTGxbPd+P1YqOO1TFI591B/ka+qNviybXtgZ1ZSgbSOtSxUzkq/QpLtsNN
	0AXGo3UXR+cMYlmqyCmf8PUQQpuxOmVKDR22yAHqLx3Y8n3txB4CikQ==
X-Gm-Gg: ASbGncuLNZWpspf6SycWZQH9NxuRlU8JgyGbBuQXuy/jK++ObSlwNjMMmFo8VA0Wh3K
	cH7Z5qY6aLr5IzUlfEkUA++dQklT5X2rIT+AyVjXYlZYYrprJnkQ5e2UOlBVm1/lvdBVpmFOdgk
	0OK/cx0Wxu390lmlyo7xd9Gu2nBjskeObcygHkw8yCSF/coWZhTVCjO4n74D0tdqLdo54uTcQK+
	I7S0Czve36V41aA6Zl1c4uzmnLH67eY0MbK8GOwmlPxaHOV32SQX72WRd1/WLit/jUWjg2jYxgl
	tSAamrhQ7gq9KIeKAqxnjrSHBDK8ElmQRmA=
X-Received: by 2002:a7b:cd17:0:b0:439:33ac:ba49 with SMTP id 5b1f17b1804b1-4394ceaf87fmr25597365e9.1.1739272766793;
        Tue, 11 Feb 2025 03:19:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJz9n+AsvlWqCu6BA+8Vdyt20fjJ6R8Eet6qzeh2S/tTdd/2jLdGSZwJRO0O1iAJUykgpigQ==
X-Received: by 2002:a7b:cd17:0:b0:439:33ac:ba49 with SMTP id 5b1f17b1804b1-4394ceaf87fmr25597135e9.1.1739272766384;
        Tue, 11 Feb 2025 03:19:26 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394f3b8846sm9865315e9.1.2025.02.11.03.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 03:19:26 -0800 (PST)
Message-ID: <72634e76-7bb2-48d5-ab21-9d5e86adee9c@redhat.com>
Date: Tue, 11 Feb 2025 12:19:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests: net: Add support for testing
 SO_RCVMARK and SO_RCVPRIORITY
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, edumazet@google.com, kuba@kernel.org,
 willemb@google.com, idosch@idosch.org, horms@kernel.org,
 davem@davemloft.net, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250210192216.37756-1-annaemesenyiri@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250210192216.37756-1-annaemesenyiri@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 8:22 PM, Anna Emese Nyiri wrote:
> Introduce tests to verify the correct functionality of the SO_RCVMARK and 
> SO_RCVPRIORITY socket options.
> 
> Key changes include:
> 
> - so_rcv_listener.c: Implements a receiver application to test the correct 
> behavior of the SO_RCVMARK and SO_RCVPRIORITY options.
> - test_so_rcv.sh: Provides a shell script to automate testing for these options.
> - Makefile: Integrates test_so_rcv.sh into the kernel selftests.
> 
> v2:
> 
> - Add the C part to TEST_GEN_PROGS and .gitignore.
> - Modify buffer space and add IPv6 testing option
> in so_rcv_listener.c.
> - Add IPv6 testing, remove unnecessary comment,
> add kselftest exit codes, run both binaries in a namespace,
> and add sleep in test_so_rcv.sh.
> The sleep was added to ensure that the listener process has
> enough time to start before the sender attempts to connect.
> - Rebased on net-next.
> 
> v1:
> 
> https://lore.kernel.org/netdev/20250129143601.16035-2-annaemesenyiri@gmail.com/

Unfortunately the added self-test does not run successfully in the CI:

https://netdev-3.bots.linux.dev/vmksft-net/results/987742/117-so-rcv-listener/stdout

Please have a look at:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

to test the change locally in a CI-like way.

Cheers,

Paolo


