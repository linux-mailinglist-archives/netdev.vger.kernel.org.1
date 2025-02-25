Return-Path: <netdev+bounces-169352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21D9A438F6
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C36916927E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EE5266B7E;
	Tue, 25 Feb 2025 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBZICcGt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC3266B73
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474336; cv=none; b=KhwrV1tYd5VjYxFHZ9W1gTC3Q2t3fhHriEvF8EF6jzrYAcN+KIOJ7kfrbcvON29YLsZipZ1Ccfzl/YlyHzRiz5ZeWBgc00NhPWkPi6dd4c+l1YT5LvoASkGj1Pmk2fw/CCx4Hu1zyTrMr4I5rd35uHvL9lsVAiSiYjB2SWemHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474336; c=relaxed/simple;
	bh=S591plOfEwfaOHN3Xnpi7xyHchggR3YCpZ+xHYAC31Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3s4iUlz+48cFvGjTQxdalGSfcTcdZOPRF7F8/MOC8z5Mf0p5pwghJ4b4QrLzE/pRUHN+J7htX8t8KuTx+oSJrdyh+5jJq/4LZpj1NHZmYrc4tCOyDXuzyqPugLIVhdnAO+PJd9NSXBPeAZe3Kno+iVBORI71VrQeK1BEqv3KkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBZICcGt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740474333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S591plOfEwfaOHN3Xnpi7xyHchggR3YCpZ+xHYAC31Y=;
	b=JBZICcGtgIaGT2NEayXsTfcbb9ZtlutP8JW/GpdJNce9O/ThZc4x+XuW9jxYBz3gryB8J1
	MoOt1MMVM1C1cwzpzFiXP8Il2QqJK7/WUCus26nkT28sdXEE8V7oHDsB1Hq0vH5wMvHO2E
	q9snZt+Ayh5ExzIv+AlghkzjVSzca8U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-Em9tJhWsPeW6T9MT3VAKKA-1; Tue, 25 Feb 2025 04:05:31 -0500
X-MC-Unique: Em9tJhWsPeW6T9MT3VAKKA-1
X-Mimecast-MFC-AGG-ID: Em9tJhWsPeW6T9MT3VAKKA_1740474330
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f2f438fb6so6519453f8f.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 01:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474330; x=1741079130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S591plOfEwfaOHN3Xnpi7xyHchggR3YCpZ+xHYAC31Y=;
        b=dqkh4YXgIFuE0XVHd7OJqvGxaUsXLJZNxV0ZeGj06k8BcEIi5g3mdMGHFBhGdiVe6q
         wLdkTbHFx50pA4kfcHA5HQgTYjOYVVnhf8T4B+rXGJSovVsy5PcAuks4LEir54BzAh5G
         /bjZx7RoTunW7lBsCNeT12wJBZ9fr1SgwszYa28GsqkEjXInr9GcymaYzAE82uhGsgkv
         1WfdTkb6OO6bnoNEf+6x2RIVFX2MmuuEsQxjyievpjdqHC7Iu1vTL6GEMOeMEGOEHy8a
         k2QJqCtGXVTknXJ57Ay56+9/LkVjHR4Sb2P8uBKpYFMexb6XCqPANG/P5mxd2CMOKgEl
         wa0g==
X-Forwarded-Encrypted: i=1; AJvYcCWD8w3zMgSUTP/eaV4RLiPptAccq91KCphYLqhMIwamuvvRab2THaVGs40pXMKlSP9bvJuCaSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXyVY0KcJB6ag6XULKUoMc6qgy4+DvW1s5ItGpwN007EtwPNQ
	lpwpQda9b+2gAXc6WORr64s6+kzGrJ+dNhKJp2dTEzV2AVbp5aAPVX7RkreFe6MVH54fev0Ir+u
	sSogCoVHHemfYwxt68RG4xbGQ4alGDV51uO9ohsUE4LYrQzhZ23nXRQ==
X-Gm-Gg: ASbGncvcaAk2HF+Kv5iV4EBdsi0rLgVb0xcoZOJHlWKDNPpGMOtQnDeEdbbMDpko9Rw
	AS1HdQeM5y+VR+Id27UPpnW2pzelECXOfPg919zGhKyg0FsPkmhj1kypma6jVotuG14fRk/UEaZ
	xKaGYY3sQKSjT7Yvngi0CpF/vmjEP2giJroR3hQmBMpkGkrvKYiUXGzI8c1EE80dOrBpXB3KNTN
	9zR6xVPoLk6JvBpeFwGykEYMEZLh+GPev/H6ZOpcX1oEsUnWSE0iOiSrsI2/JDEm4uCZvLEE85W
	1zkCOLAAK4654r/L7XD82DlTPU77bIM4Fu9jzlGpVDA=
X-Received: by 2002:a05:6000:1373:b0:38f:43c8:f766 with SMTP id ffacd0b85a97d-390cc60bb96mr1820192f8f.31.1740474329762;
        Tue, 25 Feb 2025 01:05:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2nbkYE5xIsvX6L4EeMqJ6/+oXvSP9U6WXPFvJdl0X9vmutLnfED9guiz2H/dEmk1Doe3+9w==
X-Received: by 2002:a05:6000:1373:b0:38f:43c8:f766 with SMTP id ffacd0b85a97d-390cc60bb96mr1820153f8f.31.1740474329454;
        Tue, 25 Feb 2025 01:05:29 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cc26sm1620849f8f.30.2025.02.25.01.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 01:05:29 -0800 (PST)
Message-ID: <0c50738e-2469-4404-8a9c-a5221c4412b7@redhat.com>
Date: Tue, 25 Feb 2025 10:05:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/8] net: phy: move PHY package related code from
 phy.h to phy_package.c
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Daniel Golle <daniel@makrotopia.org>,
 Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
 <SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Richard Cochran <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
References: <c02c50ab-da01-4cfa-af72-4bed109fa8e2@gmail.com>
 <ea0f203b-ee9a-4769-a27a-8dfa6a11ff01@gmail.com>
 <e8ced800-6ee3-4ee6-9b6c-228f04c15f41@lunn.ch>
 <944941ec-d897-4306-9cd8-e39de833749c@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <944941ec-d897-4306-9cd8-e39de833749c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 8:21 AM, Heiner Kallweit wrote:
> On 21.02.2025 02:56, Andrew Lunn wrote:
>> On Wed, Feb 19, 2025 at 10:03:50PM +0100, Heiner Kallweit wrote:
>>> Move PHY package related inline functions from phy.h to phy_package.c.
>>> While doing so remove locked versions phy_package_read() and
>>> phy_package_write() which have no user.
>>
>> What combination of builtin and modules have you tried? Code like this
>> is often in the header because we get linker errors in some
>> configurations. It might be worth checking the versions of the
>> original patches from Christian to see if there was such issues.
>>
> The PHY package functions are used by PHY drivers only, all of them
> have a Kconfig dependency on PHYLIB. I don't see a scenario where we
> could have the problem you're mentioning. But right, the PHY package
> function declarations are a candidate for a new header file not to
> be used outside drivers/net/phy.

IMHO it's easy that some corner case will pass unnoticed until some
build breakage is reported. I suggest to keep such functions in a
(private) header from the start.

Thanks,

Paolo


