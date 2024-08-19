Return-Path: <netdev+bounces-119746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920EE956CF7
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481BB280E90
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0604816CD05;
	Mon, 19 Aug 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAqY/fwg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A565015CD75;
	Mon, 19 Aug 2024 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077016; cv=none; b=Rsa8AYhUgEL2D3m4onjAk614HKL0wp+yyuG8F7RGt9zHpEx1fGNwpNlhSFUiDJKjC5D3WEP5eVehuZe6NxgdT4Q0JniVNzssMTwJ03mgv7MdN0bpS1iECELxnimRNH5LKhLA5VXC7JJjRXrw7WaESx1Z9gvX5/g0RN6gTrqbeCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077016; c=relaxed/simple;
	bh=AA/hfK70E98KsXchvitxmx0gkl2ZJ4eDLhAuTpfDgfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfKzWU93Hg0fVSASDM0x9zUbgttcj/dDZEzQlxgFqvIJXReh7hFFxkg/bi+6ERcs8pOyqnjsbVW0/I1MBAkNq1TmhJ6b5S0ptsggEGn42kTJ1UlXTyy7u5Y5D03i75OudG/Er1Kx9Ift+tf/LivdbcOHlxP6482zcF+6NCnvZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAqY/fwg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201f2b7fe0dso27677175ad.1;
        Mon, 19 Aug 2024 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724077015; x=1724681815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a58r6lWkambk7NEcqnz5flteNzzYB5b2ebg8WLTX+qc=;
        b=SAqY/fwgWkOaMuT3eoznrT9y9OF06CYPlq2Vtn1fGgZifkwhO9fANG4xkBDwGqRITJ
         n/wAz4ccO6sf9TpErOt1DCFhzswyl7Z4/6c+lvZNvHP+cM0MAXnoOlCx8BT72K0FI2DB
         Ac7GMK2ijnth54sXjUmVSrX7elMpT/qgulEGGnAz6D1RhMHYdmm9TjvjUJc+ggN/syUz
         F6SCS4gJD0p9RJgviERXUl7apJA4ub2f0hleQlQIk0QvkeA02et4yohVGc9QPVa1/h4d
         jQL8uNmXFh6rpy080kV0/cOuzRnbtBHgNZvG6tS1ni5WL5T5ViqS+hmJ05Wtam9Y/xK1
         D2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724077015; x=1724681815;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a58r6lWkambk7NEcqnz5flteNzzYB5b2ebg8WLTX+qc=;
        b=vAlruwrWT5iHT2rbSGRxHccE0eNNqNLWDvBBgu0ok9dJvhAsepDKgqD5yKQXgLZaJG
         /0/toDbAO6AejsUbl/2duBrmjAjqKbI0k9zmHDtdzrbkIsCM08N2v26maMGbgtYmHUb/
         2dHCiMl4eIoyfoj8anGvCHnmZFJUn2p4puBmvgdtQiKgA2e0jM4PIE5sMgMZnNWOiTDF
         mmmGQS6oCSobeWx6BhZa6vlkMQlJH1Rz2XrGyBPOpmD7dCn3HTYhZljeUYUOnd20m0lh
         +hqjZ4COziCiVrnYiU/1Sr7BGbYykK/SaORvq8qS+4iMasZdIrxVIia12tEzIferoGOJ
         vihg==
X-Forwarded-Encrypted: i=1; AJvYcCVLBMHQ4j/j2j/HYuFd2CnxDbfvom45hJbVYCS+xOhiLfbwJRk1DXJuciKOdv2SmUypCdZw3F6rPNLfCbZlZNyJ/e0oC857362Gq9vM/4SWABazqrCUviQZDxJ54hwu6EsnHE43
X-Gm-Message-State: AOJu0Ywsun3XpxuAmIDgeB4XCko0MmOIbBN0MyUi+ahKqAY6NTy3qQZM
	If5/tK58S/P4Rt0M5aG4o1czbtSOW0FMBXjOdp+Db+t2789i9oc1
X-Google-Smtp-Source: AGHT+IF4y5HnGaFjhmZgelN6vCzqVYh4R69iDfjHPZXWINa4yPSk3bMoi2+v3SqfwovzcFPOvhGveQ==
X-Received: by 2002:a17:902:d4c6:b0:202:3324:68bd with SMTP id d9443c01a7336-20233246c73mr44822905ad.43.1724077014722;
        Mon, 19 Aug 2024 07:16:54 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:ba1:c9c2:a69c:6185:a41e? ([2600:8802:b00:ba1:c9c2:a69c:6185:a41e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fa526sm63090465ad.56.2024.08.19.07.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 07:16:52 -0700 (PDT)
Message-ID: <ed05bbff-2f87-4196-8f76-38bd501c3a35@gmail.com>
Date: Mon, 19 Aug 2024 07:16:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
To: Vladimir Oltean <olteanv@gmail.com>, Pieter <vtpieter@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240819101238.1570176-1-vtpieter@gmail.com>
 <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819104112.gi2egnjbf3b67scu@skbuf>
 <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
 <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch>
 <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>
 <9e5cc632-3058-46b2-8920-30c521eb1bbd@lunn.ch>
 <CAHvy4Aq=as=K48NZHt3Ek8Yg_AzyFdsmTe92b8SFobzUBM9JNA@mail.gmail.com>
 <20240819140536.f33prrex2n3ifi7i@skbuf>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240819140536.f33prrex2n3ifi7i@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/2024 7:05 AM, Vladimir Oltean wrote:
> On Mon, Aug 19, 2024 at 03:43:42PM +0200, Pieter wrote:
>> Right so I'm managing it but I don't care from which port the packets
>> originate, so I could disable the tagging in my case.
>>
>> My problem is that with tagging enabled, I cannot use the DSA conduit
>> interface as a regular one to open sockets etc.
> 
> Open the socket on the bridge interface then?

+1
-- 
Florian


