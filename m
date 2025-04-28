Return-Path: <netdev+bounces-186559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59780A9FA96
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D093B9ED6
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0171D5170;
	Mon, 28 Apr 2025 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6+aSzML"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EA2126BF7;
	Mon, 28 Apr 2025 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872108; cv=none; b=rz3MYkCCBHV3xpbQ7UgM+d+kXzuBXBvBKc51GXEsOoRbKHdYnHUI0paZ8Ctx7BOGWTPvjdVfTICejutPRU1EJ81Py6PZI9tc07D1VlhlyoYVZz8tEglTi3Lkb9Y2pqaOallqVoO1KKLG+2H1UV3Pzj+Wv2SB87I46N5C5kW4Rz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872108; c=relaxed/simple;
	bh=X+EfhgSy1MTmbxKsIVhxrBGgfdUSpDfNsHKEJJydRo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlpHoYBWJzFEd+DZmiRIH9YcyPFWzowrUcEVC1SgzSaeETnhC7vYe2BHoWoOqcp24SsUjxxvmtmpluYuF/5SO86bwsCQFFiE5VsXK7YSFGTqNY/4/ZtqRVHWoWQhUDKlJcbR3bvm4wQONFUjmhJhXR49REw30dLfVtSVxfb8L1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6+aSzML; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso50819085e9.1;
        Mon, 28 Apr 2025 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745872105; x=1746476905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Xat3Y6+uOBE9o/w4DSpAiTsSK7rPDJomjg6+GqkngQ=;
        b=M6+aSzMLU2xdDTZCIePQBMDo1qi7h++xjaqGlvmLhauwgWFKIwiWH4LnnpTdT6h7UW
         NHvvL5IDAN4whhQFnbEp86GzL5dnKmdt7Y9gY4ElzBkGKO8VMIB1QJe5LasniaXXJBxr
         1rK2Ob0rbSTgruy20ijrpUPWkhabNHrqZMEINQZT1lzefwqms0broOIB8oAtRfrEaJzC
         mf++rAyOBTiYZtrNgmwQUDYndqt/OvpDiWjE7G5IclrzwT+xTPHCkMXKMqWzM72SI3vC
         Skn90PMzy9SbbsMPRawY/QtQfEkFYiiFaorE1DtpQXVXy7tZlfMDUwcTE5R85BKZEB2P
         LnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745872105; x=1746476905;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Xat3Y6+uOBE9o/w4DSpAiTsSK7rPDJomjg6+GqkngQ=;
        b=Za4TExjdLQczr9kU5acsDCN8UskYWbORyMbYwuFOXIZ+23kppNqg2x9Bm/T9TuYcyC
         WkwR8FzyuAydDVwUotHQOq+ZqGYGa+nw8ZtB35R1kunaHVUHBHKulg9w77t1PC8URVXS
         9t8wptzhLCh5u1bJf1c990QmrD+Mvj3wKJsZsWvKNsQhPIssTpPHaMc2nich3ofUjIRv
         4QZhSoMxe32H1++VvIliQcLMeN7ipb2mz4hryhr6JydG+Z2Z4+XCtKYQS+CNLlF6cmDj
         YvLIXAcXQf3IHfvryrIZirBJa+hiISk7hS9z4Dr5BfN75y+2qb8hzkbjS3C1fr2gNHsX
         y4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXDD47CsHKRKwmRm20OdKZa4MgJxAADp81wmwuloKMBuwSuaRY0XEKiPPRmnJ4c9TDAG7aLxGr2@vger.kernel.org, AJvYcCXZAmZ9TLKQ0XtNcTfWu+P7hkyatqd7GDXTu003NpAQ2YCULeWeJ7/n5HNCXTbGw2r7C8MGOfApZps3@vger.kernel.org
X-Gm-Message-State: AOJu0YwQob1ha8ZlA2CD00dNuXlW2/TtslexfdylO7ZwuXLZuEaXVWUa
	DZNfDCM7gbPwSK8rZmfUld3oopnl2Z0k5FY0ov8zSC2AigQab/ws
X-Gm-Gg: ASbGncvmGhLxKYaCcQ+MDuiY+q7Op2Ufp/PatdXuZRxEvDqzVrrFDlCF4e698FvqnuS
	4qP5YJmEydabdknYbcoHnXunO5XzvSF6t3PZyJUe3Gi2ZDvyhJgUgHmFrogwa2vpA2uTwykLiWM
	P51JdUNyWWFitOuIJmSr/3sKkh089nkJVFPdsBMIiRdwHBQQHWgOEm0DWn32su1F1VkJcV1zwOA
	2zfaBYqRthH5kYlWv9L2VsXNx4pxvdX2vQcmHb/DI9FIuckiRUvAYDzHU83KKjtC/VB1PWAlZ9Q
	ZCs6DeUHuEBCsIUdpgTn+0D5O4oQZSYNVJ8PrEcDPonENHHuP+Eb+eubySror9LEB5oFqRwin/x
	O5QkwdymhFCA7wTfnrKIaxvUhsD1XsplfDQRbH63IE5e8GPgSH+bH8Yy0PkRQTJd3KCSdlpZlte
	eDlK2Q50hsfTv6YUXD6VmRdyIFAMpVSJ9z
X-Google-Smtp-Source: AGHT+IGvmXhgWRzk/gbnauhohpsqP4OLqe9SuEjZa/M4TwZyf9yi4vemHgCZ2iRmLJC1V4z4yokNTA==
X-Received: by 2002:a05:600c:ccc:b0:43c:fb95:c752 with SMTP id 5b1f17b1804b1-440ab76a757mr103740135e9.3.1745872105244;
        Mon, 28 Apr 2025 13:28:25 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b032:6e00:a05d:150b:7829:9fc1? (dynamic-2a02-3100-b032-6e00-a05d-150b-7829-9fc1.310.pool.telefonica.de. [2a02:3100:b032:6e00:a05d:150b:7829:9fc1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-440a536a1ddsm135389845e9.30.2025.04.28.13.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 13:28:24 -0700 (PDT)
Message-ID: <656734d5-cf55-4ccb-8704-2f87a06fd042@gmail.com>
Date: Mon, 28 Apr 2025 22:29:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-phy: remove
 eee-broken flags which have never had a user
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <ee9a647e-562d-4a66-9f9b-434fed05090d@gmail.com>
 <aacd2344-d842-4d10-9ec8-a9d1d11ae8ed@gmail.com>
 <20250428-alluring-duck-of-security-0affaa@kuoka>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250428-alluring-duck-of-security-0affaa@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.04.2025 09:42, Krzysztof Kozlowski wrote:
> On Tue, Apr 15, 2025 at 09:55:55PM GMT, Heiner Kallweit wrote:
>> These flags have never had a user, so remove support for them.
> 
> They have no in-kernel user, but what about all out of tree users in
> kernel and other projects using bindings?
> 
I doubt there's any user outside the kernel. But it's hard to prove
that something does not exist. For my understanding:
What would be the needed proof to consider removal of these
flag bindings safe?

> Best regards,
> Krzysztof
> 
Heiner

