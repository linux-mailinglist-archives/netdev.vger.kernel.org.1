Return-Path: <netdev+bounces-120087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078769583E3
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E242856AC
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBCC189F32;
	Tue, 20 Aug 2024 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EO9J5iV8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72818B462
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148928; cv=none; b=NTS32PBHDU4bnPoW7avrKddvq50G9zLK24PMs88q5G2fnCxqGp0RmZtl8yjaoBXox0OZEN4rS0rkDlc03ESwcXa/aphCWnoW2EMVomCnrSlItarTlYR+nL6MuJyr49H8jMaqImoeE0HLEHjvxHACAEDcJIfvdQZYzyslQmV4QMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148928; c=relaxed/simple;
	bh=MRYIGSOSbqWcGCpS7eeweY5sPDyQjSsVn9evAIxkLXE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aKEb421EBuIhyzLm/ozQthtdgRX2X+snOiNIHlh++8LIF6nRYn0Ime1tVExHM+fV0oweRkK3uigCzjVZV0PGhkwki1M1v7edUJxpG0mF9wBWZXPpA0K2sHaTIh2TXzxW3Ez7pL/cKQSvmjIoRpdB1ePCQwH8DpQcEKJmQme9gq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EO9J5iV8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724148925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOG9ybdUE74HfT0xY/KZ29V4lJHlpnppytRZwc0Rs94=;
	b=EO9J5iV86/nTO6+9i5w3X+wa0cmbeLFE+A9jDVKGdSD4BcglGw6E0wXKOOjbDKNwdVu6KG
	yzjTL4mTm3RZmuFQDUGfpcs5zkKPEKz7BIBF+wJQcDZwkguAR8SApdK1+qfpsqgN4FqtEs
	dbju8O1MqlRHGmF6gSU2EGbU4iCBSiQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-3nd6l-ucP6KRgjCYe43F6g-1; Tue, 20 Aug 2024 06:15:22 -0400
X-MC-Unique: 3nd6l-ucP6KRgjCYe43F6g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428086c2187so10004665e9.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 03:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724148921; x=1724753721;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOG9ybdUE74HfT0xY/KZ29V4lJHlpnppytRZwc0Rs94=;
        b=C8HsOFhy8/+/UI56KIb5v0qGbf+0VBKzefG/m4de488V6mYhV5vdpWpLQ1XaTn3tOn
         7T50wzxU/Od0IAEkygx3IOmLj0F/Kj7LSEzQh9GM9MhVYbHnbaQucqaLfioM57A04a+i
         Ip2yOqClGZ2uJX92NnkKYCUCTc1Tgcm/ljjKQoyIfjryBe3Zm7FsaACb4NECB37dOpfL
         VatQq6F0wt2yGEkcE+m2DC9qrzFkF+kcVl1Dbb1DvZOIcg04nlUco7KQVS7UC/U9u51N
         DAIzM1Bzky3V9/MzQApamsh9zd07vHYCnR+CqVkjbyXVQR4Atf+FFpwGk4b5mIpCLmRe
         x+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL9UoYsxO7Vce9PiRsoIhO5cqDSy+liMV7KXeh6muHNcmkueY4St9VOZRH3s6c+X9TRvYzlFKDFKAkC1Wb8pZWmX1gmjyo
X-Gm-Message-State: AOJu0YwYLBPmpaJerNO2aHsMfRd80fy9uK8hZjF0fx6QdEx19Er/mN0Y
	0bGCos/GknPp6GwRiFbDd5BJBLUo7kTcjmbHvutdy8UZvyFBKmxu8vvno+nSrpsG+Yt1fwGLPew
	Q4RnbwFo4x+8eLsavUaehmUxKFkMaelLQpHWMT1TfOR8+aMIgD8rw3w==
X-Received: by 2002:a05:6000:400f:b0:36d:1d66:554f with SMTP id ffacd0b85a97d-371943282f6mr5858751f8f.3.1724148921612;
        Tue, 20 Aug 2024 03:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEYIGr0mleZL/s18kcq9OFPn2+MExIhTUkOVRIv8PYk+G6iWCJWI1P+1g+0WfYxZmzwoWWIw==
X-Received: by 2002:a05:6000:400f:b0:36d:1d66:554f with SMTP id ffacd0b85a97d-371943282f6mr5858737f8f.3.1724148921161;
        Tue, 20 Aug 2024 03:15:21 -0700 (PDT)
Received: from [192.168.1.25] ([145.224.103.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a2e2sm12752383f8f.16.2024.08.20.03.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 03:15:20 -0700 (PDT)
Message-ID: <584ce622-2acf-4b6f-94e0-17ed38a491b6@redhat.com>
Date: Tue, 20 Aug 2024 12:15:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
From: Paolo Abeni <pabeni@redhat.com>
To: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815022014.55275-1-Tristram.Ha@microchip.com>
 <20240815022014.55275-3-Tristram.Ha@microchip.com>
 <9bd573ff-af83-4f93-a591-aab541d9faac@redhat.com>
Content-Language: en-US
In-Reply-To: <9bd573ff-af83-4f93-a591-aab541d9faac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/20/24 12:08, Paolo Abeni wrote:
> On 8/15/24 04:20, Tristram.Ha@microchip.com wrote:
>> From: Tristram Ha <tristram.ha@microchip.com>
>>
>> KSZ8895/KSZ8864 is a switch family between KSZ8863/73 and KSZ8795, so it
>> shares some registers and functions in those switches already
>> implemented in the KSZ DSA driver.
>>
>> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> 
> I usually wait for an explicit ack from the DSA crew on this kind of
> patches, but this one and it really looks really unlikely to indroduce
> any regression for the already supported chips and it's lingering since
> a bit, so I'm applying it now.

Unfortunatelly does not apply cleanly anymore since commit
fd250fed1f8856c37caa7b9a5e6015ad6f5011e5.

Please rebase and re-send.

Thanks,

Paolo


