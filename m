Return-Path: <netdev+bounces-142550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65D09BF968
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95E71C20FF7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CE620C313;
	Wed,  6 Nov 2024 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ6X3DYH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8118FDD0;
	Wed,  6 Nov 2024 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730933031; cv=none; b=oAGz3vW2Xyd0nq0sAjvd0BhC3r0hY29FYpVUT3uQwUfhpWnWpa6mkZ1X9/EY56REtAJLtWVmSs2w7thnnwZocvrLED4oyZzjOT8LvJvxfqDOG2nyhO9KKAN4FiDGObMwg2UBxYtfxasw2CJ6gzzq/gkNUaI5cyOHHaRpEtv29WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730933031; c=relaxed/simple;
	bh=FBTvWNE2TeX/KQa5Fyv0OYNFJwcY1QIXJEey9FxLavw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbLWvZmJaB5VeR27LE3D5mPNdNwcKSU7YaKK4zP6gt/nzm81IlX13rEl0DHmZ0g4Kem5PEw4nVIeD7zhntIq53+0Rvsy/7kEZTTNWhnrygPEudnWzWAcH/5bKMZ3YGsYBnWt2VWrp33CDFFpSAN9X2dLAX0mzMzaIPNLeBp0qvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ6X3DYH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so39049266b.0;
        Wed, 06 Nov 2024 14:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730933028; x=1731537828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NOc3O+ElkTxjtl4bxgDHpwSjBIXenEJh1lp/Lx9rnaM=;
        b=NZ6X3DYHp9lOIW5YvGByDrCbRfN3DbL6/xEC4gd6Q2JnzYOebKEkCGcRmqipGllKS0
         x2m6Vr3d2V6RmT4QWJ2ylJFnIxZcUMPpiT+0qFnoxtlzh0oZ/EMuhxbY/Hl9NnxdacFx
         ZrxwbfRsVdd2k+2nh/PSy4lzYbHNDx5wxO1Bg/78sMKGBQpiAhlMHvDLfFRGrZKi9yng
         RKHXgF/vW4yC0ZsQGdisZqMfntfKuJ7UQp1UWjVcq/xWeRabHy0ceGHIfFWL55QtIpMA
         GOIU1Uq2GlC1CJd2L7BfBNpkVFVBQpBt/dSjClNoXqJgk7zJlzXFq2BTY746sIQaFPCo
         Mv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730933028; x=1731537828;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOc3O+ElkTxjtl4bxgDHpwSjBIXenEJh1lp/Lx9rnaM=;
        b=rmG9S3TkIDzY77De1dGnLX9p3Q2XHE7YwxWkvGMnMdjBToJy4qedW4Y8K8v0dI9ehH
         wpDOF27C9lVDZw5voIoBwhOGj5qF0yxbegaag+8P7PozvhyTOTC/J3rmt1DBYde+wpqs
         NQNl7zkOG4iFe6Y3hF5+ciIc1LMJJLl+m8MOvhwKaquDSyq/UYoPpU26mlCK+M5l+aNL
         XjEsTnU1LMYnnfj9X47vD7X3nQcTjtg/Fx4bw6oa4Ki6SftQZC5Tq3t/I/+PZKWvjFJK
         KryCDNmkiPUH0OFXvIUnSlTNp9pHHIAVQaJtGdhK7MfbxyJn+hupVQgHG6wTHKWtjnlL
         skLA==
X-Forwarded-Encrypted: i=1; AJvYcCVmYSpG5A0qaIgOsiBj8Pqr1gqXQRRFQXk/0bFmeu52rGEvvFgV6ygVSfhS1FGB8suLe4/+45md@vger.kernel.org, AJvYcCXUVW0Y50ZwAuYYXI1jS4O0DijoBLQW4UDgfT8zU2Ba/FQndrmgIiso7gztKMBRxa5NVrvE7MOPS1eXKXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2/Rz+oaDURdtoGHmDK3pX3sskZtrMYzA3CVamojdRE1q7zrJ
	38Lt3ir9QoD+naLnOKo8HNmBPXByIAFJuyr3FhfM9aLeWMD4qgV+r7br7Q==
X-Google-Smtp-Source: AGHT+IHkb0ZZh2sAXYDFiQNOYtirEWZWulBBy5CvWRLH29l/x4UIo8Rx4Mw9id5FtLvg1uqkxkfitQ==
X-Received: by 2002:a17:907:72d6:b0:a9a:14fc:9868 with SMTP id a640c23a62f3a-a9e5089b6b2mr2162650566b.4.1730933027885;
        Wed, 06 Nov 2024 14:43:47 -0800 (PST)
Received: from ?IPV6:2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6? (dynamic-2a02-3100-a488-4700-cc12-ac39-a3b8-6ff6.310.pool.telefonica.de. [2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9eb1813b1asm339283766b.194.2024.11.06.14.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 14:43:46 -0800 (PST)
Message-ID: <0328420b-6031-4595-ab5d-fe6dc7ffd42c@gmail.com>
Date: Wed, 6 Nov 2024 23:43:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: aquantia: Add mdix config and
 reporting
To: Paul Davey <paul.davey@alliedtelesis.co.nz>, Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241106222057.3965379-1-paul.davey@alliedtelesis.co.nz>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20241106222057.3965379-1-paul.davey@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.11.2024 23:20, Paul Davey wrote:
> Add support for configuring MDI-X state of PHY.
> Add reporting of resolved MDI-X state in status information.
> 
I wonder how relevant this is nowadays. Is there any PHY out there w/o auto MDI-X?
What would be a use case for manually dealing with MDI, and who would do what based
on the MDI-X status information?

> Tested on AQR113C.
> 
> Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
> ---
> v2:
>  - Renamed aqr_set_polarity to aqr_set_mdix
>  - Guard MDI-X state reporting on genphy_c45_aneg_done
>  - Link to v1: https://lore.kernel.org/netdev/20241017015407.256737-1-paul.davey@alliedtelesis.co.nz/
> ---
[...]

