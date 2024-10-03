Return-Path: <netdev+bounces-131747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB49298F6B4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5263D1F2257D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCD91AAE22;
	Thu,  3 Oct 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hjv8EIL/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ADA1A4F36;
	Thu,  3 Oct 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982264; cv=none; b=c7me6XCK9i4ZfTCqhSu1NmoMH96RIsZtbiplsIyDhu/MiXTOv5XbkAsPwtOpEjU6QeI+iYLjCIZSGla3UsGcnFOoyyUCPZyXp3sMCwiqxte0apnUPJwCZMEfA9aPvZO2KvRXU07yTSdtFPhedzYiJLxPYckbxBPj2+/8Qbnhx6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982264; c=relaxed/simple;
	bh=95h3/bTRg8PKeuo/I1qGeBlrCewe0f4o27NjXvQTMNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQjMCIkspst+JvFtbM8H4G1nQ0VYZoRxmWRXfL7fS9S28PqsqgJOMd0BftgUi9/84cglxEdH6O2y+6ldwqRIG2tVvgYCQNiq13BxT+5Bb12DXdGu73NJo1FlH/4uAfnt/DHTBh18wyFkQKttY9lZ6+3l5uSFr4vlW9PiLrKA/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hjv8EIL/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a99fd4ea26so110874985a.1;
        Thu, 03 Oct 2024 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727982262; x=1728587062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aPWVZ9h8Ykb7Ey6pieYHHbCq60X7ntHCLSFMkz5AWkw=;
        b=Hjv8EIL/w3gHWvP2KWoTVGl5GWIgXs4z4qdHRR7n6Bjp3HSpPHFnBRw8WnT6uhilc+
         8E7km5GeWwFwtHb09tRk6Nyd3jE9xfnMUfC0LuKDHOFsop6AWdr9fbBdDCbixmknE4HP
         mg7Nj62qmPFpMKN+SnH7po7kzI8lBsmKKnNqoO7k0IyiQPduCiM+CLs/BN/GMvfo0Jo3
         76IazYzfpFSy4dzvv44ynHcMmdyPecPAeMzx6yy5I7brcZDGmp+KM1dC3iDkp2OYbIGB
         8B0NWxobEGF6k8pRMFxOrkQY3zIEIpliw5ydFCjZTWQFymCyGOCpu6ZSNREWont8Eu/u
         cfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727982262; x=1728587062;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPWVZ9h8Ykb7Ey6pieYHHbCq60X7ntHCLSFMkz5AWkw=;
        b=uDLMrIRzZV6XC0iOzLGJxR/tfHNuHP15vUbnURB7y9901LSrezpeH9qrw+Zp7ZQ56e
         CxWb5W7+tm9IfwIv4u1hZBRrOf4efZxEGPgCZAzU0s6ygmSGs1Ll9xv4Vb2/cK6gH/AJ
         NLa66yBVIAaqAVSA8cPL3CmmEGwbmFLNJvQ9TqZULpk5IxiMPRiTGQK+TMlebQPrrpdI
         Wuj4jfc/zngu1KG/x6al2AU2ID/+kYSSisu33xQS2vqKp8Jo32TzwM8+It33o9mw8bCP
         UqqTdwp9i68sn34+oH83wRLbWRP218q37n8XkjBEJjU1fzrPpiBEOxEgFUuGEC0jahfr
         vn7w==
X-Forwarded-Encrypted: i=1; AJvYcCWZLZ6b3FmhVsgHtlg52p4BE5wLnoTWZ15QIyAG0jkvW19GU5B8UgNejt7X4Qbzc3mGPjuDVMz/2AwPJ/JQdZc=@vger.kernel.org, AJvYcCX1qDKQJTvbONnPYGWGukwt1XwtuY7Rp86qJhBfVSTZ8IYs8VhJ4T5X+nJ5Ynus9SB6N4RwmiIw@vger.kernel.org
X-Gm-Message-State: AOJu0YxTaCY4luKe9RyEnalB2P6oe06FdAsPbvvId/5Ha4pRWr7Dcv7R
	4O/aipfbXh/6FIVPRCiMarGGkhT7BmDohMHTOcNhCrEEO3KBCpmr
X-Google-Smtp-Source: AGHT+IHCo03EOF4oZLxl67aMAsd4dpPiswfSx6WN1zvrnrzDKC8Wder1rcB7FTdoEdoJBAMR15bJoQ==
X-Received: by 2002:a05:620a:24d4:b0:79f:14de:2a09 with SMTP id af79cd13be357-7ae6f421aebmr40148185a.8.1727982261956;
        Thu, 03 Oct 2024 12:04:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b39a797sm73015985a.46.2024.10.03.12.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 12:04:21 -0700 (PDT)
Message-ID: <a3892753-6a24-4056-89d1-01698bc50ecb@gmail.com>
Date: Thu, 3 Oct 2024 12:04:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: bcm84881: Fix some error handling paths
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org
References: <3e1755b0c40340d00e089d6adae5bca2f8c79e53.1727982168.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <3e1755b0c40340d00e089d6adae5bca2f8c79e53.1727982168.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 12:03, Christophe JAILLET wrote:
> If phy_read_mmd() fails, the error code stored in 'bmsr' should be returned
> instead of 'val' which is likely to be 0.
> 
> Fixes: 75f4d8d10e01 ("net: phy: add Broadcom BCM84881 PHY driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
--
Florian

