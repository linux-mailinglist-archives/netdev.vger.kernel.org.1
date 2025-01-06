Return-Path: <netdev+bounces-155623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26070A032BA
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B622161AA8
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4841DAC95;
	Mon,  6 Jan 2025 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRCytpTZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0E1E0B7F
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202701; cv=none; b=GvRMIFORGLPvdHrtivy75B2RjsQtt1piQMTMWcjUTrrcZl0ol/28xvDresvHsIQynVG5o99dY4bgZEkTuSwANwmLLDTfzUjkbVD2o6+BjX05SweR2ftHwwGatpGUrMMDmyqDw+j0WSs5pWqogtdUkpsusOy5csnh0h/k5uNbKBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202701; c=relaxed/simple;
	bh=TLUxO1Z3djfMhK5Hh2hKLkd38SIF3GHy7Hl3PHIMp9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/c1YZJRmCmZq/WT3m8QDb69Hfm/MhfC+d9IUc8ttHEfxnaBeTda9/bG5HsQS/ZJnvjOZFAQRL3zRo10G9+V9gb8TGQrchrU0UbFsnLpxrdDmbk0lJ68QeSVzVK2rIu0EO9ECrqSPEKU8p3/DuK9VfHb+GOv0ixUXrPXSEJrrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRCytpTZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so22741894a12.3
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 14:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736202698; x=1736807498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DLCZAQLYt8ZEV66Hkdgt91OAJYAQrsFNRI0xY4Koxsk=;
        b=XRCytpTZZUgC3cZVgO6VfiR4PbDC/7WrWcSTfdWtgTmMlqgJImjnAPSZcMSOtm2kFk
         jszBZnoYicv4v/UrHXeEqbOcJJ1vnSVKXievVEsVfv9segeuq/GNJAeXqZZwqvVTLyin
         SnyBk2U8xhf22omhnN9lkqnndL80wtlRKthQRjQW2V2BHh7Zt4yJ8icsjKCVZEQCbFIt
         Rw4fd+coiqfRUUbT8qoMRIUsUB3vAitrI0MML3WIfA2kmH4HM2sLS55MC1bCeG6iU7yt
         wOXAEChw4/VlWuPz33floGeM5iLDk8U2Rqllx3KTWF4qV63fQp4DAJCKqAznuoty1JEL
         AO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202698; x=1736807498;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLCZAQLYt8ZEV66Hkdgt91OAJYAQrsFNRI0xY4Koxsk=;
        b=KPs6uda0Hijs/D+zpWvmNvkwWXIJURsg/ptHanTcUUalLiEy9zXyNfMLjjOnOJ3MWW
         pdolEQs9Eg+dozUzcvCqIdluXRbAUGQVSzG0Eu4hY3fseugd8sWdSZ2Q9LKaSStvlGjV
         4Zq+ZH+HpMoPqx8b3JMXQW+z+HhJTm5MFJVQmybN9W0PxyeliqKkxbduoXGJRWRlH3Nq
         osCnFmHEro8LjvyqWpqMI3AK7hcoMNPGJxZhxDrnJFlQpuH4CUOyzWiij0nt6Bi+2VcS
         zbjwGUFp7qvRJmDWvMBANyDrhM9mMZO/4KCXvqYBs1VYwXaQ2FVpJYsuDMD7wXi9/FrE
         017w==
X-Forwarded-Encrypted: i=1; AJvYcCW7A163uwUefoksrdoCaXHSn5Q+HLtrXhKTMNcONo5uSKxD3HA7an/y5XfU48WmjIl8o9eqn2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhX8eMKNJLNJd1ruraXGNZ0HFEdPrpFmCDWrJC3yy+iNGs+fW
	UQPDzoupb9bVlOW8uO3OBOhSUo1xaqSdjvjaaxpZDCk3yKNY/DiL
X-Gm-Gg: ASbGnctX3bTmt/gU48oj4pPQl0XZhlOQgUAP51c8TNpFU+FGEmV0zhs4pwvwFhwuHBM
	cbNBXIkFSWwJxjZHJmXxAWuf+Iep/Y6OWq8RO7bvWBuGKhCCaf6BryXOV+2+GoEazazA1ZopumW
	sdx6Hn0QMQ2cRIqxqgeopyFx9a71u6M1kSnITmrM2avrm4fXft5famc8ZqitxFgbuLmZraejLSd
	dZYX9mMSNqnyzkospsf0W3upESr3XoXD/s/NEUPB2iANExXnWWeuXYOPcI+r1f1+UgK0xX2Hf+s
	U1Oh57/p+8RVnJYmDJrLGFFsRa0dL/K4gWVVRwqxNI9VnuhSWDLkY3QXPmzffEYzhVewazVNNNl
	+VkwbKeSK+sK94Tvp/8TaTVCefJ/xamaNgSYQGcIS
X-Google-Smtp-Source: AGHT+IEDb8zlhRIqjk5oIUlcBcE7CxMIc0JIOFC+aoIjiXA5RIWD0nV46nTwvGi2aVSwMNjSkkQH6w==
X-Received: by 2002:a05:6402:2802:b0:5d3:d7c1:31a4 with SMTP id 4fb4d7f45d1cf-5d81dd5e8famr62940819a12.7.1736202697449;
        Mon, 06 Jan 2025 14:31:37 -0800 (PST)
Received: from ?IPV6:2a02:3100:ad97:900:c87:b717:6cf:e370? (dynamic-2a02-3100-ad97-0900-0c87-b717-06cf-e370.310.pool.telefonica.de. [2a02:3100:ad97:900:c87:b717:6cf:e370])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fed718sm24389423a12.62.2025.01.06.14.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 14:31:36 -0800 (PST)
Message-ID: <088501b8-1c55-4d20-95b3-ed635865b470@gmail.com>
Date: Mon, 6 Jan 2025 23:31:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] r8169: add support for reading over-temp
 threshold
To: Andrew Lunn <andrew@lunn.ch>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
 <f3e07026-8219-4b36-b230-7f7ddd71c7ab@gmail.com>
 <4535017c-10a8-47e8-8a8e-67c5db62bb16@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <4535017c-10a8-47e8-8a8e-67c5db62bb16@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.01.2025 22:15, Andrew Lunn wrote:
> On Mon, Jan 06, 2025 at 07:05:13PM +0100, Heiner Kallweit wrote:
>> Add support for reading the over-temp threshold. If the chip temperature
>> exceeds this value, the chip will reduce the speed to 1Gbps (by disabling
>> 2.5G/5G advertisement and triggering a renegotiation).
> 
> I'm assuming here that the over-temp threshold always exists when the
> temp_in sensors exists? If so:
> 
Right

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> Does it reduce the speed in the same way as downshift? Can the user
> tell it has happened, other than networking is slower?
> 
It internally disables 2.5G/5G advertisement and triggers an autoneg.
So you get the usual message on console/dmesg indicating the new speed.
This internal action sets a register bit, and it can also trigger an interrupt.
So it should be possible to check in the link_change_notify() callback
whether an over-temp event occurred. The silent change of the advertisement
may also result in the phylib-cached advertisement being out-of-sync.
So we would have to re-sync it. But I didn't fully test this yet.

This patch only allows to read the over-temp threshold set as power-on default
or by the boot loader. It doesn't change the existing behavior.

>     Andrew

Heiner

