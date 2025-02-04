Return-Path: <netdev+bounces-162458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE676A26FA0
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7292E164AA4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7447D20B816;
	Tue,  4 Feb 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT06qCi2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5920AF9A
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666566; cv=none; b=lkgz3kI6twGIiOfa8WoeSJMXFGELTumy9CwED3hFxXJShbMgyIhAVcgSCmoJRdPx28gHRFNCtEanZXcGNZIR0EDvt+jH4jfRMGHDOZ8Hf1OqJdrQR1otkv46DYGQo0XTwbGkoB1L/y8dId4SSn1ri81lxTIaJ661FaWxdPa9Apw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666566; c=relaxed/simple;
	bh=4beXukFVHQs5nCd6JCJWPrisRK6PKYiJfHKwE1xknk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDjfjv6JxZoEW+LN4Gg7NciJTrhSAb4xuo64O1ORpy39IYg3Nk21LDAmadQmootSzFBUJPkT+yDQBYPJR7IcK+fdjwrZjBR8EgN5gRIYiUX5jQztvs8LNdS8VPhqbNh2/qqV3RkUQWcSdGLugnxVpTZEWxi70n6jHeBGgdpuAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AT06qCi2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738666563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4beXukFVHQs5nCd6JCJWPrisRK6PKYiJfHKwE1xknk4=;
	b=AT06qCi2gZiOducUGs9CSP/IR2wJKtfgLxjXpv2maBeIbY5en3Xl2SANrWK1KsBCU9yAjS
	py8edua9TltOmUzrU/G6P2lRa/tq2Xh4ecfJNsIaws4iQ1VknFPSwAVKgWh5c7ieFVoGNj
	j3jvYCEhfYg6zWe0q96y8+IUCczZrFg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-RrfUpO_MPQGskWJEppSZmQ-1; Tue, 04 Feb 2025 05:56:00 -0500
X-MC-Unique: RrfUpO_MPQGskWJEppSZmQ-1
X-Mimecast-MFC-AGG-ID: RrfUpO_MPQGskWJEppSZmQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361fc2b2d6so28258445e9.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 02:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738666559; x=1739271359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4beXukFVHQs5nCd6JCJWPrisRK6PKYiJfHKwE1xknk4=;
        b=ZzvbZ+TEMy4laYNX/DbUQTEooRdSKrNtpNNq+gfj0CElkYqfmZLGVpGupraQ6lBmCJ
         ndi9KYKf5HM2PUMQfXcBfOM0jqAYyqVkc5HVxLKEhPx76sJCG7cTUPXUzKFUknUU/YCI
         QvpQIssYKg8g0dKwzDZl6dhqAx/aBebWU78AR8KOS9kbFPI+TZbUZU0J2RcfSyBt3Hvb
         vvgUgzqx/aDAiPLdbX6MDPDyO6ZFkmPa2rIFkOP67CmKsRto2Hjf/N9nj66GOdmUbIul
         9QAqnaTzCmg8xcPpFY5JSW0vYP2jF+F/G+U2O0ZdcfiBb0gRWDnG41vXWZrZoKEr+m7X
         4nHA==
X-Forwarded-Encrypted: i=1; AJvYcCWkNEmeoxCQTkVNS0G8xGUac6qD9+mI02Q7/SPXwawUZ8NeTPInoU1tkpn0GKK/aJfRIaX1j88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSj+y1Yy309WgDdA64N7pDhb7am6j+AUNi8+FwBrfUfqAT5po
	qGV+umR/89BdEGzBXofO6Xwfxqrv2D2xZKOo8KYtlEMBBV5P/52xWyMlfgblr7UzpedYaaRCudU
	BVVAMtHOTVUc4eCAsQaprlI738ZQ+ZmdLCzray/o0E/sy25eJ/L4t6y+EKYoidg==
X-Gm-Gg: ASbGncsUcAX3sGUqwUHaeoKyXwlCMy3SpHMRVbzHriICoWwMjeGj0bhr41VncAbwmnT
	4jpa979GdqcHY9SA/whMpqG6pIFSJm3/OfADfTWJbQslRNN/XxGyzZRZuNg1ZZitTJkFQah2BtS
	faIIuy5/MCLa0u7SKxtCYikVXtWGKSePDhoCzo92l5s7ypuF1AWgtY8TiyhvU0zJ8gcokVVMAd3
	1+0mLaXU2C8SJQ9z9Arhh8FHPp3ChYS+LuDPBSEmQ5VKBJAsvGYCFplPDYtaT2fFWQRdN8qrSbr
	muMwmjvboRJc1GxtUl7dmhsS8+50QCu1S6M=
X-Received: by 2002:a05:600c:a04:b0:436:e3ea:4447 with SMTP id 5b1f17b1804b1-438dc436a08mr231815305e9.30.1738666558940;
        Tue, 04 Feb 2025 02:55:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPKWXjdX96lQCIbHeahFyYNkKOqGVKxcOxbbsF5GMJwC3hZR+QmB4vaH/E0IBr/11HWe+7+Q==
X-Received: by 2002:a05:600c:a04:b0:436:e3ea:4447 with SMTP id 5b1f17b1804b1-438dc436a08mr231815125e9.30.1738666558603;
        Tue, 04 Feb 2025 02:55:58 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc26cefsm220335895e9.13.2025.02.04.02.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 02:55:58 -0800 (PST)
Message-ID: <835481c6-0ac1-47a7-84b2-fa5a135186c2@redhat.com>
Date: Tue, 4 Feb 2025 11:55:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/10] net: pktgen: enable 'param=value'
 parsing
To: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>
References: <20250203170201.1661703-1-ps.report@gmx.net>
 <20250203170201.1661703-3-ps.report@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250203170201.1661703-3-ps.report@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 6:01 PM, Peter Seiderer wrote:
> Enable additional to 'parm value' the 'param=value' parsing

It could be language bias on my side, by I find the above statement hard
to parse. Could you please rephrase it?

IMHO something alike:

"""
Enable more flexible parameters syntax, allowing "param=value" in
addition to the already supported "param value" pattern.
"""

Thanks,

Paolo


