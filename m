Return-Path: <netdev+bounces-169368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF4A43928
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B245816087E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308A926773B;
	Tue, 25 Feb 2025 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbtKSI2x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809CA26772D
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474735; cv=none; b=smKBzQ/3UJGcfxsv2m/xLRkMzxCJ8W3drCvo29xQHOic9qDhCkbajbO0IfwYSUPtbpn9UbDPBXHNPbP2b5zfZnKExa7uCcxJpPoWhrQWLWRZ/clRB9glS9c9mclS/udqMC7i/yM0Cc4Y3UNe39P2FGBX9uDQZmTqMGTgcMaNjls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474735; c=relaxed/simple;
	bh=I/ncJfEJtEiSeoSCR2blElAGuBHz/yWCQD1ugBNnzD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5ijr/Ml67tjHO/F6/bb3iQhwnLdIuMEvazJK/9LFYxXB4YwxfiKKlyiqs97l0lJVtk3kw7M4cvQSQ8XRmMVKrjZK3OAGWuZ62K3IHlsz8Z9SYYKySeJ/MeqtNL5s6kR2P8x0tCQfMy5RQsb6GTr4FwlFejGA6lmSitStrCeyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbtKSI2x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740474732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlIg0iX5rLeI1/17Pjh/O9LHmXIOARF0OAc7AU9Migc=;
	b=MbtKSI2xQNk/V1HxCMrVWJ9W7oqf4wvFgsYbF8OazDcVU6pyNMi/2jqPPNz0/SsREasNM5
	2CQzIeZeU4+JqekhMKe9HZY7fCY0H76HShxF6FEHyao3CktoE7HxmC1GE4twD0Dhmojre6
	x3aQju7X6k6E0V1mI3l93z5gTLdyiL4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-B9op4tKOPYC05GXGaqtyXA-1; Tue, 25 Feb 2025 04:12:10 -0500
X-MC-Unique: B9op4tKOPYC05GXGaqtyXA-1
X-Mimecast-MFC-AGG-ID: B9op4tKOPYC05GXGaqtyXA_1740474729
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f455a8e43so2014112f8f.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 01:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474729; x=1741079529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlIg0iX5rLeI1/17Pjh/O9LHmXIOARF0OAc7AU9Migc=;
        b=iOGl8WKid9o9HbaLu3zfz6SF0gTSJ4JIuUBWfONFcuC8PsTMbPYXbGRJRHanpukhR0
         YigbI/xkPxc6XIatuNe29Rk1YRN6kYLQy7VDRrpOqJ/Ob170u5LMDftVLPsKtR10M6ly
         EL/jlP+8IakAT8Ol8t/2BFEm1VIHdhHDA9lOB9hj6rxV8kVIs8ZNux97iz9zGHBUrOfw
         iHDx8WZtnfxJ6E3VtJjyqSCjL+xaFRD1IILhcTsgy6XMI8gpkfGKI6b5EqWgbaBZMEB9
         oMe08ZJNPqNhPEhwPk8VAx0htZlLRhEeQFSS7L5l5VLNoHEIsnPrKojGUIoqdz+yVXLh
         5CXg==
X-Forwarded-Encrypted: i=1; AJvYcCU47lMK7cNGO+BkqQW1sTQ4NLhZkRsQ1i098zpRJYNIIyGLwSvl33JZV6ADBVwL/3DjobbkETs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyllrbAEnWiUDDIhxclrmiCK32eG6Cdh7Dd4JtxMB4cBIkn0RM4
	ANkQTEnSCjvLoQLqx8xqLlAj9EuDjJEL50KJM98Fg2hbw40Dpq3v7PwZntZDw5pn6Ar8//5+Qzt
	jSEmwwduJ8qmrt4HM4VfeTOnqVdNw/23FCkSx6hSVnbOHH1nEcq+zzg==
X-Gm-Gg: ASbGncugFrdbrNFatrhDHlJoGX6ajIe4QWIuxP1x3jpd8FnfU5NXC2Wa0XOLRYXxLO6
	q404DcjqSnNavYvDQE2RVKpQBaMAwcF6GNHzOtZ84W+KGOmVX0F9d6i9VMbFwPQQovnKa+46wMQ
	icZ/+gagvhhlvlfyGImIGlyzun5/HlwFuYABKwOzrzWps/yEwZcri3mI6nnDwvADy3Wg7RHdX1l
	uIeVE9lpaS8w1cC5x20MO3MZz2DQQk4NVMWs8PrSG4v8uvI7ZCiVZXSmVNYXCCr67+i0kbeqQLs
	lNBkhXE7u169E/TgSN3DpJ8zvcLfwS2K/y9vKPnxF9M=
X-Received: by 2002:a05:6000:1548:b0:38d:daf3:be60 with SMTP id ffacd0b85a97d-390cc63ccf0mr2071739f8f.48.1740474729252;
        Tue, 25 Feb 2025 01:12:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEolJkbGKjJj6h9uEQW/S7a4oRbKctMUQh95C2XKh9ehqDL16AcT96CB9ug5umxMfHDYCtt4w==
X-Received: by 2002:a05:6000:1548:b0:38d:daf3:be60 with SMTP id ffacd0b85a97d-390cc63ccf0mr2071706f8f.48.1740474728801;
        Tue, 25 Feb 2025 01:12:08 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866dc4sm1624406f8f.11.2025.02.25.01.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 01:12:08 -0800 (PST)
Message-ID: <910cae0c-3d45-4cd3-b38a-49ab805a231e@redhat.com>
Date: Tue, 25 Feb 2025 10:12:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] net: phy: add getters for public members of
 struct phy_package_shared
To: Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Richard Cochran <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
References: <c02c50ab-da01-4cfa-af72-4bed109fa8e2@gmail.com>
 <b505ed6a-533d-42ad-82d0-93315ce27e7f@gmail.com>
 <20250224180152.6e0d3a8b@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250224180152.6e0d3a8b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 3:01 AM, Jakub Kicinski wrote:
> On Wed, 19 Feb 2025 22:04:47 +0100 Heiner Kallweit wrote:
>> +struct device_node *phy_package_shared_get_node(struct phy_device *phydev);
>> +void *phy_package_shared_get_priv(struct phy_device *phydev);
> 
> A bit sad that none of the users can fit in a line with this naming.
> Isn't "shared" implied by "package" here ?
> How would you feel about phy_package_get_priv() ?

FWIW I personally agree the latter would be a better name.

@Heiner: could you please give that naming schema a shot here?

/P


