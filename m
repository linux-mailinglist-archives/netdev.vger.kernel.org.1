Return-Path: <netdev+bounces-202800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC90AEF08F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AF21BC3BF8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A878426A095;
	Tue,  1 Jul 2025 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXjPbFAp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1EB267B98
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357452; cv=none; b=rGeWp0k/EC1umFwHNU6tvuTbYx2LTy8MXm2XIBIj4fqIgcKJiEbP32DZDAGOM92aO79ZNNNvVoij1kdzw+VY89n/Fvw2lDrFiQgayDNWB2CsVY2DZiQBHVLhIeK1QyE9s8CSzrr106LR3Mo6oQmi/aWNwFuXpMh1QA54LsBjUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357452; c=relaxed/simple;
	bh=Ai0ZdyCkBW4P/dlKXeTGNa7zBThv3hnYZ4e3mI+ljQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sqn1XbMjXiYQxFxbVkVwAlekimvOBKnis7lE7tgeY12ZcDrHpuHc7WVcY2qMwkR0RtZ3HDXAh6f3kbbm+/F+KKsWsPRBV41arfkuHoEfGEjNKWQHJiUA3xs0i3PYXcr9fVju6AEMvpQ7QbuKXZ3/AtYr2CwG9dFJLDykvFnQwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXjPbFAp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751357449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAqeVupWS6I/KQNI1FlEHR4MLjl2U9bDCimmR0JRiiA=;
	b=VXjPbFApLlmvOQXYj3NG4QdV1zADwcOiLab8N/4R1tkT2MGGaR0hgmCp19rrjPStd2LB56
	VKHlIp4mn907QiXC3olttrD6ftxdiF6hnFiBBZ32ykbDe06jFaGSQsuTkNS5OQ6kUqXRLF
	RaSp3DHhODyJeiDtLbzj+IFnN2NBs3A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-sJsKWCbvMCekCGz5BzFtJg-1; Tue, 01 Jul 2025 04:10:48 -0400
X-MC-Unique: sJsKWCbvMCekCGz5BzFtJg-1
X-Mimecast-MFC-AGG-ID: sJsKWCbvMCekCGz5BzFtJg_1751357447
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so274260f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 01:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751357447; x=1751962247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAqeVupWS6I/KQNI1FlEHR4MLjl2U9bDCimmR0JRiiA=;
        b=u03kuPZgQe56YSqhrwlpb4YwgrDKgVW7HVG+pCZ2R89WMpA3iVSFzhVZC7Qk656ng7
         S1BJ1mY5U+OMsPaLNgUTj5gTo0VENw2Yqwh4ZIdY5O14mIrDhI/a2SPHrc7i0L0GX6hc
         3RO/8wrtCeSvR0zLoDec2QBqfwTORoBowElG84Wrq7x4ix85tmHKXbXLZF4m0Wz4mWPK
         h+hqiiJ6rPRTeLafn+5F1YUd/sW25wPepjQx3XbuejdKF+dwqVCYZzfgmMmcfLubpvtq
         hYAYAlN7h+zd8cuEKQWP+7ysucNIxyGt5+yq4REif+AkaETRk+pvTB53Kaj/uNEl3yRZ
         HX7w==
X-Forwarded-Encrypted: i=1; AJvYcCXx81uQr67m52mXQ6Ufp6+eapo4d+j171O4JTZEi+Y4uq7KahcTlE/84g7bZQYwzk6CSDWymsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy39TNYsCwZIhK/YPqRyNROiolh2wVPdIfqL09GKCFXg631xq21
	Tv7F1cfJG6ubD8EVuVP+6e5CUxUH1dWRdE4HHZoJjvjyr7vr3nKp3rf1mUvIyYnttMjFNVBhGk4
	yxxDvV3vkzhmoxFHkCVkF4UUa2RC5/yqMMX+LW2lPEUjKhIcrw3NPHPvsMg==
X-Gm-Gg: ASbGnctFEDl1cx6HJjdLhpiOXp5XOA1EPfrFvPdzvIrC7gXSDCAikdbG0VArphAdQv3
	vQczaDsK8vW7cRabT2vXXybc5kRA5OPHILv9zOUes4NQU0jAs67F7n1Zabcs3buw1VMJ9Qv+G09
	4R1nvDfF6En4pIdCaR3O6tlaMfja0i6uc59xRWT9+3YoKukO6l5mFzhFw9cAnSomi1UPyklPLDW
	+VLft4r6kmP/ZST/NTJvi/pynMJ02a97lD4af5960EA0rPa0UTGEyMS7eo/2qGR8Sw0ds7zpplb
	kPMug/0TDbrr4mjvweijB7mjr1YktVUV+CD4Ldn7g76NODVEi3hKkW6hnG/zJCY3DqlUoQ==
X-Received: by 2002:a05:6000:652:b0:3a4:d0fe:42b2 with SMTP id ffacd0b85a97d-3a8fdb2a48amr11268677f8f.19.1751357446973;
        Tue, 01 Jul 2025 01:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx6UqjSEdXQoTmkruINaxIN0faimhQXh3dmFyrDiVEZmXp+ezv4u3owvO0Rm2F0PetPqhFPw==
X-Received: by 2002:a05:6000:652:b0:3a4:d0fe:42b2 with SMTP id ffacd0b85a97d-3a8fdb2a48amr11268643f8f.19.1751357446457;
        Tue, 01 Jul 2025 01:10:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e76e1sm12744073f8f.16.2025.07.01.01.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 01:10:45 -0700 (PDT)
Message-ID: <ee862e2c-d268-4530-b3a1-a565640638ff@redhat.com>
Date: Tue, 1 Jul 2025 10:10:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bonding: don't force LACPDU tx to ~333 ms boundaries
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
 Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Carlos Bilbao <carlos.bilbao@kernel.org>,
 Tonghao Zhang <tonghao@bamaicloud.com>
References: <20250625-fix-lacpdu-jitter-v1-1-4d0ee627e1ba@kernel.org>
 <2545704.1750869056@famine> <aFwrOs73E03Ifr-i@do-x1carbon>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aFwrOs73E03Ifr-i@do-x1carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 7:00 PM, Seth Forshee (DigitalOcean) wrote:
> On Wed, Jun 25, 2025 at 09:30:56AM -0700, Jay Vosburgh wrote:
>> Seth Forshee (DigitalOcean) <sforshee@kernel.org> wrote:
>>
>>> The timer which ensures that no more than 3 LACPDUs are transmitted in
>>> a second rearms itself every 333ms regardless of whether an LACPDU is
>>> transmitted when the timer expires. This causes LACPDU tx to be delayed
>>> until the next expiration of the timer, which effectively aligns LACPDUs
>>> to ~333ms boundaries. This results in a variable amount of jitter in the
>>> timing of periodic LACPDUs.
>>
>> 	To be clear, the "3 per second" limitation that all of this
>> should to conform to is from IEEE 802.1AX-2014, 6.4.16 Transmit machine:
>>
>> 	"When the LACP_Enabled variable is TRUE and the NTT (6.4.7)
>> 	variable is TRUE, the Transmit machine shall ensure that a
>> 	properly formatted LACPDU (6.4.2) is transmitted [i.e., issue a
>> 	CtrlMuxN:M_UNITDATA.Request(LACPDU) service primitive], subject
>> 	to the restriction that no more than three LACPDUs may be
>> 	transmitted in any Fast_Periodic_Time interval. If NTT is set to
>> 	TRUE when this limit is in force, the transmission shall be
>> 	delayed until such a time as the restriction is no longer in
>> 	force. The NTT variable shall be set to FALSE when the Transmit
>> 	machine has transmitted a LACPDU."
>>
>> 	The current implementation conforms to this as you describe: by
>> aligning transmission to 1/3 second boundaries, no more than 3 can ever
>> be sent in one second.
>>
>> 	If, hypothetically, the state machine were to transition, or a
>> user updates port settings (either of which would set NTT each time)
>> more than 3 times in a second, would your patched code obey this
>> restriction?
> 
> As long as the transition doesn't reset sm_tx_timer_counter to something
> smaller than ad_ticks_per_sec/AD_MAX_TX_IN_SECOND, which nothing does
> currently (and if it did it would be at risk of sending more than 3 in a
> second already). The timer is reset on each tx, so no two consecutive
> LACPDUs can be sent less than 300ms apart, therefore no more than 3 can
> be per second. If a state machine transition sets NTT within 300ms of
> the previous tx, it will not send another until the timer expires.

@Jay, I believe the above statement is correct. What I'm missing?

Side note: I'm wondering if this should be considered a fix, and thus
requiring targeting the 'net' tree and a 'fixes' tag.

/P


