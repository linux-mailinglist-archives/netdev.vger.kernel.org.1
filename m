Return-Path: <netdev+bounces-231119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D67BF56A9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E379846153C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458D6329C40;
	Tue, 21 Oct 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDF4SbQR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1AF1684B0
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037649; cv=none; b=tZByAJtSUHnpY9RuQ3Eh7tvMF8XHBbHfhU6owelhaYCCb1mkbgaxByT6BkcVkyMQjoA9zhKKlixzoL1bU9GMjlrzykIIrIokj+XODoV+nuzQViIe3QX7lMVaZARqWaun8UfpqUpFAZjnJE7bjJzY78ika13/iOuFDID1Afl1v5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037649; c=relaxed/simple;
	bh=tUqEp6FRotyZoHUqJl+M1N4DLR56pVmELzujGzEYun0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STZXhPnfCQLC4SmoTdTicWQWToJ053C4Mo2fSpU2ub4R5eouWlatxx5nRvNnx7C0hiY5YK4Q9Ipn5jlzDb90f6sAPcg8DEzQ3ZGhbSw+2g2lM69ON/iUNekSaJbz3/oXQgh3uVTIzkZFuAKePihysiQqA0E0CLt/sVmAfvHLeJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDF4SbQR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761037646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vxuYfXKfr3imHgkQvW2ygYGzwCXEJYL5J80r//u9SeE=;
	b=WDF4SbQRlQdN9VfTLyNd/ONOmKm8t8q1gD5kYRUtFkunH8I/Jt5dgmS9kE6Fs/aj0KTihs
	0y4YqYPkWcgeN6MMZDR4a55RD+kO5XNA6fmzz7q5RlIlvuZkgeKLEiU9qokTS+243Uf1dV
	ZRFkuNTblNyJhCt9M2Jk6X9Ckr9Tb+Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-CTnmi9t7PnSWyIC7eaR0SQ-1; Tue, 21 Oct 2025 05:07:24 -0400
X-MC-Unique: CTnmi9t7PnSWyIC7eaR0SQ-1
X-Mimecast-MFC-AGG-ID: CTnmi9t7PnSWyIC7eaR0SQ_1761037643
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so3193028f8f.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 02:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761037643; x=1761642443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vxuYfXKfr3imHgkQvW2ygYGzwCXEJYL5J80r//u9SeE=;
        b=MvPAkXBSp/zMonzG4W6pEguijnP9rfSEB3peDtdH/AyTTCg2Rc3xuYbp8WqA2yvPbA
         VwzQBFwUMoWJXJtAYNlGta84/RoVt2zPZLPj6Z0lbgRGRxXLIIgjsPsfH3fngA7rkhXd
         OBgpEW8h2X4Eh5Nx5fQu3TSJYVTy5ighMQG7JVB1XfOvT2a6NEKTwogQpC0Lr+tF9Em9
         Y5QWQMsjxOofjFvK710SBe1dObXX88tDWrO5tQAXrEgmZbfeN5d2RXPBK36pgD0641x1
         vk5YOK+CZFx9ka6cUfO1Rr0tngeyNb6ma0izD7E6lNBOFoYubT68XoKhuLnCVHUwEMG4
         rYKw==
X-Forwarded-Encrypted: i=1; AJvYcCWWOq2i1EqcB69rcjP2HYcpKUWvL/8M8lD1P84Xe0YMTE3M1BC7HK6cx9MK8VCeZnPzgeSTGM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqxNGkDFRBvFK7YWZBpj/OTLi1fCC7UryFUTRF9jfou934m91x
	rKSADh4RN/gqNb4E/7OELgKEL1BcZv3C4fcCZoamSr5Y0HfUXdz+v22HjMkGgVzlB/kkh/4u3//
	oxeml3Ck9AxcrdROs891qs7wY48rUxWjdvdjUttDCEqXfIWmYOrf1FhXGIg==
X-Gm-Gg: ASbGncuXENl7PVLWlA3dAsdfNGkUZaZwkwR4Nwmsv9i0sPRuf2yWWjKr2zFJw+1kYh2
	5JMoI+GZHs6EM57Kce2uB7S07YRBOxw5GaXuJ1yWYT4Q7USLdhdVkyiU2Ec7ghwnQm/EXQob9J0
	TBCbB575NzI6NBeIzlLcvoOHhJyFZfzd+3DmxHoijWCDsDXyndw93eHQsuvDaI6l4bXQRwaOLJC
	I0OGc6OAJJuFjaQ0Zkiwx1tyRWciCRjerRWmhpPQDH+brgjB/J7xe90xN/jvwAHzThFcNPU7GuH
	itTER2xJHJiGCq/CEVt1MHuwAn4D0eWEzUGCJcezPkEdXnjYdsrRiXF4Sm9nxgK/oht5Du4vWDY
	zNV7fq5XoKkVKDwUZ0MXFzs/gNvbnQ8Jt4choL7DcbZGCF8k=
X-Received: by 2002:a5d:64e7:0:b0:3e7:428f:d33 with SMTP id ffacd0b85a97d-42704bc0e86mr14305327f8f.16.1761037643463;
        Tue, 21 Oct 2025 02:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Gy9jf6dORCTbvPabRPFqLZ9AU3h3AuGcVYPrbC7L1U5/N9elmMWZ2CnLRn1z2Vj5o0vp+A==
X-Received: by 2002:a5d:64e7:0:b0:3e7:428f:d33 with SMTP id ffacd0b85a97d-42704bc0e86mr14305293f8f.16.1761037643038;
        Tue, 21 Oct 2025 02:07:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a96asm19525120f8f.31.2025.10.21.02.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:07:22 -0700 (PDT)
Message-ID: <09b90c94-4b55-4b9f-a23b-e2bd920545bf@redhat.com>
Date: Tue, 21 Oct 2025 11:07:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
To: Jakub Kicinski <kuba@kernel.org>, andrew@lunn.ch
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 richardcochran@gmail.com, vladimir.oltean@nxp.com,
 vadim.fedorenko@linux.dev, rmk+kernel@armlinux.org.uk,
 christophe.jaillet@wanadoo.fr, rosenp@gmail.com,
 steen.hegelund@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
 <20251017064819.3048793-3-horatiu.vultur@microchip.com>
 <20251020165346.276cd17e@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020165346.276cd17e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 1:53 AM, Jakub Kicinski wrote:
> On Fri, 17 Oct 2025 08:48:19 +0200 Horatiu Vultur wrote:
>> For VSC8574 and VSC8572, the PTP initialization is incomplete. It is
>> missing the first part but it makes the second part. Meaning that the
>> ptp_clock_register() is never called.
>>
>> There is no crash without the first part when enabling PTP but this is
>> unexpected because some PHys have PTP functionality exposed by the
>> driver and some don't even though they share the same PTP clock PTP.
> 
> I'm tempted to queue this to net-next, sounds like a "never worked 
> in an obvious way" case.  I'd appreciate a second opinion.. Andrew?

FTR, I agree with the above, as (out of sheer ignorance) I think/fear
the first patch can potentially cause regressions.

/P


