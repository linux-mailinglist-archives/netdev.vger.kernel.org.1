Return-Path: <netdev+bounces-126580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCACB971E83
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DA2284830
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7479874C14;
	Mon,  9 Sep 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRRSv5Dc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D221BC40;
	Mon,  9 Sep 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897447; cv=none; b=fquhGmO5iIc6a1OxDZkaXHGZ5AclUwsyr9FB8szViq4jqD+P9aF1oWU1VDZKds+dja4aEsNAgfqJRYgVwt8mVMkQT6LpkdLCgM4nPM/IX6if+Ewxvj/94b1QJYqTYqp/xoi68qZKjrcyYzu0PKZo+H8z8sO6UcBHNvbCh4i1aZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897447; c=relaxed/simple;
	bh=H1sjtXc+t9r3ckpErk77WVSgx4PwTM35otrFLNcZjaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKrex/+95EUq6teULk/hYSwjxXTv9jkjsmXo9zdtI+6K5H5jQUYsLOm0jL5fquLIV/Qu4sNq9H06BjaLhjTcfZNeNLFMB8doVEvwVaTMh2jzMZDhSzX+SFPu1dLLNeb04NoicRVMjOMvpuvmFMOGm7kRFolo5WS563Wo0rCjlwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRRSv5Dc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e11e4186so2313991b3a.2;
        Mon, 09 Sep 2024 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725897445; x=1726502245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EKGnAwAl1VxdDD+2IVKiBA2uPRz4vWDckNOYf5JpxDI=;
        b=mRRSv5DcYJvLnG47p9++oYqqoB44d/IxzVu4MMM26oxr2Cj8xJJkpqcyyo78FtcAb8
         0hsjcb1Z2H//nf/yxZ4fWeGfQtGFQ9kyvj1ewuhXIHeXsMuq0Q85S8JFtsCfRnVfUiL7
         p/xsvbhVyxhXPEoZKJhExM0QDDL85tCBMgtvVdrbl4ymynYO6L31DYZlXf0NeEQDf2Dw
         BJN1j4DBiClghGOpFdQZluFO1BEA/9dD30AgUl5p3KeoJzTRcDv0XblSRgCo/OKiE3ym
         i56HT6AyqXjCWbdpvje69SYOvkmE9Q88CyBttqxwS2lpVml8ggrHTUH3vvddyknRfuNC
         JnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725897445; x=1726502245;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKGnAwAl1VxdDD+2IVKiBA2uPRz4vWDckNOYf5JpxDI=;
        b=gY2noTGRtUJwV1OIDB0Q5Dk0RsJKTtcWXmfhpWUPsl8YkJ3vMMJO1FflsRlNjJRyAw
         30VlJ1ZmgZfapctuzqPaeIIMM9LrgWohfUhOMT76jHepB1UyxZWXeJBp3rIgyJJICv8/
         h7ZqtDkZAYRf/60yS7LEVL69W1ZIszwDFH+D+pAUBaHQcNMM7RXtq2vx9K5mYXYOyAI1
         +i+2JTkEINIH+sjnBaLNGdruOwdmLlhT7E7GN9jV2A/HUxAi2mJ/yoZNyJ2e1q8dGayq
         +ZOQBGxeL+qlfiaorJE/vGZ2HN+UkRqhZ0MB6ZOkaOg2dDlvzAC9vIgjnhWAoMbZCupf
         1G/g==
X-Forwarded-Encrypted: i=1; AJvYcCWJFV8eRgJmy1b9PPLYDg4T9rcotGacav5VZ1rsn8DlaJwLOlI+Ujs05AdElY0DzClTaYl2bCSM3PbFxhY=@vger.kernel.org, AJvYcCWqSEu8Xkad2KSLdwjZZN4JMT9H5gqBq2NRYhbfjQ4MLFmE8mCOvE0/ZU49fhYZ8I11YGjymplX@vger.kernel.org
X-Gm-Message-State: AOJu0YyQSE3xXKq+2+G63UO0Ky4oiATA/Ie0et5JKyKmEaO2srkJNSTq
	X3rcZl/3b9iLcJj6uK4o8qRsaqYrYhdszd8LewBdMhgoUuh+MRR+
X-Google-Smtp-Source: AGHT+IE6Tbvr8ecli0WctVfiVIJkovPmaIkWf6mEy2vU/mF1ZY/l+beFk3qQqPN06MW2C+gVX51a8Q==
X-Received: by 2002:a05:6a00:3c85:b0:718:d740:b870 with SMTP id d2e1a72fcca58-718e3352956mr10794962b3a.2.1725897445178;
        Mon, 09 Sep 2024 08:57:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8256d0631sm4104539a12.69.2024.09.09.08.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 08:57:24 -0700 (PDT)
Message-ID: <d40fd694-e14f-4f82-969b-be9d51eb3fbd@gmail.com>
Date: Mon, 9 Sep 2024 08:57:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/1] net: dsa: microchip: update tag_ksz masks
 for KSZ9477 family
To: vtpieter@gmail.com, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240909134301.75448-1-vtpieter@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240909134301.75448-1-vtpieter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/24 06:42, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Remove magic number 7 by introducing a GENMASK macro instead.
> Remove magic number 0x80 by using the BIT macro instead.
> 
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

