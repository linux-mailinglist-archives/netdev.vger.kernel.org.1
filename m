Return-Path: <netdev+bounces-172417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B7A54856
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1891188FD60
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D8D1A76BC;
	Thu,  6 Mar 2025 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeFH/08g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D785204698
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258050; cv=none; b=B86+6EdioPEg1f+dfcyGnU60eBuzmS81dm7K31F9gb6cjbh7DFNwW8Oz2GA1Ou94sD5805QpTWW/+Cjy6GPbh8CmgO+VvjJes3MeVw5/rdFtt89WIogJqQjDv/9tNEqNNh2ehcMkri0Q7/jF8y07T3OufD8GOr+aKiOHuS0ElgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258050; c=relaxed/simple;
	bh=ZeRw7Ajeju4Ra7AoF300wbpqRFfKh4bBlkQEykUHr/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ro8S7dlhV+UkJUcuV6xvASm6QvWbz9FJcWqno6OSfZ2vg3vm4vo+M4Hr9OXYSO43mxHD9EUNTcdO2wC11w6Pk6Nf5Yd9d4Afa5GU/U4u83PJPjEFxQ+PG25zrhSi3wq/qiuPF2mXm0Sa+/7x81vSDiInRXxdqs9/cmeytOSTNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeFH/08g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741258047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjRt78Dq2s+uI5+AwqEfT+jWVL8f1Spro5dG2E/jNI0=;
	b=IeFH/08gtjAKpCpow7v1kV/ANTrlMRm2Y9Em1g4hzpp9pvUsjmzIWbgXaaLRgwMpfju0RW
	AeG3kLlRj65XoQo87SI83LZqJupjOBnCoFLjrRQJM+jZtdbcoMZ7JmJb/oSfSDAa83PpbE
	CrOZzDdQ0sbrKSzBhdtTRK3PGrbYsw4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-cmHrci8tO4mOyCmpLI7MoA-1; Thu, 06 Mar 2025 05:47:26 -0500
X-MC-Unique: cmHrci8tO4mOyCmpLI7MoA-1
X-Mimecast-MFC-AGG-ID: cmHrci8tO4mOyCmpLI7MoA_1741258045
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bca561111so1976865e9.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 02:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258045; x=1741862845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjRt78Dq2s+uI5+AwqEfT+jWVL8f1Spro5dG2E/jNI0=;
        b=k01vDVyWG0tSkFKktLvpmpzYeirbvDtcMmAimbiqxBRw88aN924tSCHN12E4YeKykL
         EdbGxATihUozb10LAaTeUMxTMRiCImmwORU8RilwV6D000iYme4EjJUBu3cmhlAkO5qx
         U0ujF0YEmAkuJeMBeOG1fZ5qKZIYaMbVrV92NyEHWx2uLJzqJcE9vCF1k72PEgqlQHyV
         PR3vJw3NXzOhIWzCdIv2DrofC8oXbRNyZEV5N46M8ObSWYnLqpUTx7reiCjX8sT0djjN
         PdrnNlElxYMeAtRy8ge28gMUu/cdL/Bknwzkt62eJcEwXGwxwUWAmdIuLlHsmcDyMIkh
         zSaw==
X-Forwarded-Encrypted: i=1; AJvYcCVSnPXUOSqzE2SysyPn5/RqdCPpUo7f4DmO8NP2ZNEqV0t/mN+zs3Bz3LqZPGMlNZhXsKxkOXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP+H5FQr6VO/FwmYLPkBY3tfS1c7vclMlpAe1HlkUWdkROOlcb
	/EWJQQRYAl+PVv7H/Geh4zzOWVGiTlRyxhdkBqozO2FH83WrtkJwsk8ynZa8AGw3wVUhrPQkZ0g
	OFFDd2RZguCub/oAhOviPFx1n3Aj6+AHcG4BR2lkYjq6Y1q2MocdBEA==
X-Gm-Gg: ASbGncsNl1yxdSu0VHEz6HvGsb+oEYGC1jD8P8zA6D/DYegokO7GnZl32/qlNb5l+sk
	xYZGEvJafRpCwuDEbRRcd+h1+GXeo/mAkl5zxkUppS9xO8LxxRJS9jHE1wQfEGC4Cw0b/lIMOor
	IukjG3Vu4Hpjc71N9XdWuKSN4x8vGpq9gjnN8Kg0itWYWmfJQRglE9eisln2/k/hZX3dxPseL+9
	fwfMlgr/Ty9kXzKdgletj2NW8dRLJRuPCOP+W8FZKu9oD4BA5V/rcY5fL4CEdMgv/uqtZ5Y6NkM
	bXMnBnkCueqAZKrSpLPOxVVEC7X72npBsdcDBKuZYFIjBg==
X-Received: by 2002:a05:600c:474b:b0:43b:caac:5934 with SMTP id 5b1f17b1804b1-43bd2940d7fmr64405905e9.10.1741258045152;
        Thu, 06 Mar 2025 02:47:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMjHLrijI3JnQ9/rTJXDsThbCAGg6S1g+aRd1hhWjvbEr7MYhP077xwT5HmEDiJR4B8678IQ==
X-Received: by 2002:a05:600c:474b:b0:43b:caac:5934 with SMTP id 5b1f17b1804b1-43bd2940d7fmr64405645e9.10.1741258044718;
        Thu, 06 Mar 2025 02:47:24 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42920a5sm46021545e9.11.2025.03.06.02.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:47:24 -0800 (PST)
Message-ID: <5d0b952a-ec07-4ebf-8228-a424fc0de4cd@redhat.com>
Date: Thu, 6 Mar 2025 11:47:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 02/13] net: phy: Use an internal, searchable
 storage for the linkmodes
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
 <20250303090321.805785-3-maxime.chevallier@bootlin.com>
 <738bd67c-8688-4902-805f-4e35e6aaed4a@redhat.com>
 <20250306095726.04125e5f@fedora.home>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250306095726.04125e5f@fedora.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 9:57 AM, Maxime Chevallier wrote:
> On Thu, 6 Mar 2025 09:30:11 +0100
> Paolo Abeni <pabeni@redhat.com> wrote:
>> On 3/3/25 10:03 AM, Maxime Chevallier wrote:
[...]
>>> +/**
>>> + * phy_caps_init() - Initializes the link_caps array from the link_mode_params.
>>> + */
>>> +void phy_caps_init(void)
>>> +{
>>> +	const struct link_mode_info *linkmode;
>>> +	int i, capa;
>>> +
>>> +	/* Fill the caps array from net/ethtool/common.c */
>>> +	for (i = 0; i < __ETHTOOL_LINK_MODE_MASK_NBITS; i++) {
>>> +		linkmode = &link_mode_params[i];
>>> +		capa = speed_duplex_to_capa(linkmode->speed, linkmode->duplex);
>>> +
>>> +		if (capa < 0)
>>> +			continue;  
>>
>> Or even error-out here.
> 
> Good point yes indeed. Russell raised the point for the need of keeping
> this in sync with new SPEED_XXX definitions, I'll add a check that
> errors out.
> 
> I hope that's OK though, as higher speeds are introduced and used by
> NICs that usually don't use phylib at all, so there's a good chance
> that the developper introducing the new speed won't have CONFIG_PHYLIB
> enabled.
> 
> Is that still good ?

I think so. New linkmodes should be added on net-next. Booting the
kernel with phylib support on any device should catch the error. I think
even the CI should catch this.

Thanks,

Paolo


