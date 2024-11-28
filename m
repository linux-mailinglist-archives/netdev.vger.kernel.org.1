Return-Path: <netdev+bounces-147724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE109DB71F
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 13:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C5C163A08
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 12:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AE019004B;
	Thu, 28 Nov 2024 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYjIVQpK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0C2CCC0
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732795703; cv=none; b=mATsJ1gsfZe9d5PvCUrYzpyeUuplx7FNNKidKY8O0KdjJSizHPIkMktBfiz+Nb5+bHj1IlpBNvjHjPPuMHgsyatzM9diXfWAclWvrrABbR3XnlL/ATMeQXHsIFBUV86yb09Z1k8qwLElIOxe9bLBA5UKxMdmZTCi5KBm6Nc5vj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732795703; c=relaxed/simple;
	bh=8LGQyM5AqDmOL8NpYqNyjsRpxEfRvMUZce2z+surDkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4GlVXqjCGP9i0tlFeXIY7Yjj0MujM2jqR29FakPmRk+rx9USudGceDb5F9OeOjak7udK/7orx79MXQ2msUDGDCkOET6QdLML83wFHKXhDN077TO0+slNxp9aW2jwpTXmFNRTWdH2f8Pp3xtO7+v5KnqNqtU9PgTuCV9sSR6lY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYjIVQpK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732795700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+A2A4Rt5ieD9ZkqE0p7CEIEyAzE272HyF0E/VCkylME=;
	b=CYjIVQpKoEEEEmyZ3Z6z31fb2NsKrfAtXDa+BoXUKi27S6p8olbvHRFTQZogqSzmIoVS4z
	2Tgh4h+PURaP7r36b6C/5PnleJqjZNiN3UytNH2rL1FjDIe8f73k6qv+yEtUVmmBM+2hGp
	gPit+DYFO9yQ/g0z2lyxm4IqToqbQn8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-gtwfSDcQNs2hIIpnE5E9hg-1; Thu, 28 Nov 2024 07:08:19 -0500
X-MC-Unique: gtwfSDcQNs2hIIpnE5E9hg-1
X-Mimecast-MFC-AGG-ID: gtwfSDcQNs2hIIpnE5E9hg
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6eec33c5c50so14092987b3.1
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 04:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732795699; x=1733400499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+A2A4Rt5ieD9ZkqE0p7CEIEyAzE272HyF0E/VCkylME=;
        b=sIeyDLbWHPSpnbXI4fcFnMPG/tOXUO293ls4AFPyi4MwVrTkPK1XfnrirtDmtjkXNw
         FYbZSBF1EIYzx6jAxVpaHQPkD4KXT+vIodJZZGI/a0JCs1gm3mJ6l2tdiwijpmqqdpqJ
         0KmNbQy3gwDPlBVRBteyeK6c0HKEdQDLehZ8MhwYsgw1+xo0aTi6pgTohGr24Fm0KP7w
         6FEq9SCOWxFXM2lhj+ygXg9E+qeF0AemTivF+RR7tH/P5QuZBMB0506JY1W8PWVsRItO
         MLDW/fyTfbYY0YFfE8dzSVA80+GFUe+/5yiTATxDmJLpDirMGi1PK0orVOk0QgDqZZT+
         uXvw==
X-Forwarded-Encrypted: i=1; AJvYcCXuVmeOc2E7BOay2uYr6K6wTSEMKFnyhTkR/m1sUHG9WTDcjyanUfrG5j7ziVNLLtxwDttQYh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzstdoN7rG9kDzfRk9PHoEyuzwKfo2gVWxmG0MX4yDfWG6dYFNI
	1Rgd/cxTvPMtdRpXdy+N7H7oEir1YTFrLhhCsnvboTtd4L95fKNRF28IO2ogBDhwLmI5taWBl8C
	HeQpxOkNR+jD36/DU7OLOkutJY5MGe6/HaQcUTMZWVBUqCwwIVphfQg==
X-Gm-Gg: ASbGnctE6X/qOgV6Ie7fSlllyZX2QeMDFUlj7taEqs8nmAiLn3Zz2S4Fm/MbIa+OFLd
	/M3ws48avJFMnbKLh7tg6LALbz6pV1J/WaeLgckkbYp++bGu1WfvhcED5zSPC1X/9eO9cvneDDG
	e0dCEYUio75Iq1csHaWHCO2+8bLV3nMC/5OJ1XLJ9oiu8QsnZDyoI04wAWm59V1mAWb+FoEG/sA
	elBBZAfuOj9vijl4vs/3vMR7WlvBFfNSqIi3/pHZIbKRq7BOSDviCFrKGCGEiA5X5/6qfK5O5Wz
X-Received: by 2002:a05:690c:d1f:b0:6e5:9d3c:f9d3 with SMTP id 00721157ae682-6ef3729e910mr79179867b3.41.1732795698968;
        Thu, 28 Nov 2024 04:08:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDc6KdA0WeHu/hlqzrCjnK78CxQVqVleXDlG3kGktlOf55x5mTsk0qD/f9tuIVI9vz2i/0kQ==
X-Received: by 2002:a05:690c:d1f:b0:6e5:9d3c:f9d3 with SMTP id 00721157ae682-6ef3729e910mr79179607b3.41.1732795698681;
        Thu, 28 Nov 2024 04:08:18 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d875163a01sm5882586d6.23.2024.11.28.04.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 04:08:18 -0800 (PST)
Message-ID: <b7bbca8a-23af-4f1d-8112-8ad94d3fa870@redhat.com>
Date: Thu, 28 Nov 2024 13:08:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: phy: fix phy_ethtool_set_eee() incorrectly
 enabling LPI
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
References: <E1tErSe-005RhB-2R@rmk-PC.armlinux.org.uk>
 <bedf2521-dcbf-4b5b-8482-9436a54a614f@redhat.com>
 <Z0hQQONGxPM04EVl@shell.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z0hQQONGxPM04EVl@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 12:13, Russell King (Oracle) wrote:
> On Thu, Nov 28, 2024 at 09:44:37AM +0100, Paolo Abeni wrote:
>> AFAICS this patch has no kconfig implication, so my local build should
>> be a safe-enough test, but please wait for the pre-reqs being merged for
>> future submissions.
> 
> I guess there's no way to tell the CI tests that another patch is
> required? It would be useful if something like a message-id could
> indicate to the CI tests that the patch in that message-id is
> required.

Not yet. I guess the main road-blocker is the limited time avail for
such developments (mostly Jakub's spare time). Feel free to contribute
to such feature to the CI infra (https://github.com/linux-netdev/nipa),
if time and will allow.

Thanks,

Paolo


