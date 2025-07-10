Return-Path: <netdev+bounces-205791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C046B002FD
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 15:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE391C41E37
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC1F2DA74A;
	Thu, 10 Jul 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZL3Anwk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841982D979A
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153106; cv=none; b=MJ97uV+YTNesREiueBaxWyJNwkFjUjY99wLtSD4MuDhoSuE4GdqW74VczspK26UcRA8mHuTI9I44+2VB5WZrr7BJPPex+R55+lDYAVg7TLmfCAXFQ6ueSKEg+OF8TPgJRbH4V1iBWIdLgzkUbHENvSM920o8/YDrGyb45NQzKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153106; c=relaxed/simple;
	bh=Iiea9t5x3kjnX+xENFLY7HpPQMuYYdsyW/bgyV/bz0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwAgtvivR2IR9u9qZC2lLTsM5R7CPbDLgpj5xKmtPFKVCTzAXyou6KCcjfTLEh69UOuZt0IuT8yq07IQWjSFYbAfqUwNyBB9JhsMQYx2dgHqGvltUjvMvc1PuIvIuRJwiscmjcDMkWrntucXKnDqO6Eq+pf1ZOriE0Bwq//UgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZL3Anwk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752153102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETlJFlO+CzrUz2FuFvJ9e728NgJmwVRGWH0k5Mr9prY=;
	b=ZZL3AnwkcM7roFKxhmJPpUZ0B7iJJlafRvVJ5eXzA28wXawVtpHklRn2UBKhgijvHEOeoF
	PYRhR0AE/s00Lrwv44dNF6q0d5ewMkCrp3RKc/klAyvzZAHUj9S6ib4y+/zB9WW5VeDFbT
	BdIu2LkVdOyskfzpumVahL+pABMw0Y4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-ZRMi8rjoNbigg8XqcXG39g-1; Thu, 10 Jul 2025 09:11:41 -0400
X-MC-Unique: ZRMi8rjoNbigg8XqcXG39g-1
X-Mimecast-MFC-AGG-ID: ZRMi8rjoNbigg8XqcXG39g_1752153100
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45311704cdbso6496195e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 06:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752153100; x=1752757900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETlJFlO+CzrUz2FuFvJ9e728NgJmwVRGWH0k5Mr9prY=;
        b=Myc+k9Q5Ca4EppHN6Iw+l9lj+gln8gstjelDX3Ldl7cUPm4KKRUz6u1cSx4LSzvHmM
         XsKnIu11gy9G3KvPcojcktScMc+hHOhSKUvdDH4OWxM3MDTCVUY3rLPdDJRgpc+9a2Tq
         Dkb5n/ARN8g4qBOuRMzASWt54MgMm0kjIYNdzE0GbQqR6YhTwscEiuorW2w5C1V9P4r9
         hRiWHQb1fK3f6Dl+kOJgwuw+si3MYm3hUaaSs06YQa8acPg4XkAuLNVoHOcDyxhnkqU9
         Xnx2maDO6BeNBU5ARXkn/PueXuEDSiKwv2fASIJUVvs6N6bQbhhT5lafBxA/P4jqCLI0
         nn7A==
X-Forwarded-Encrypted: i=1; AJvYcCWxC24dmViHD301IqdV/1sYvnZutOkDaQ8cwfKgXeHmUn37ODkGNT2LhDNLJdYz/bBbiuvML1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkoGWSSSSsCZC0lt87buSXU3zxE4DsyiN/jyatoOvwClOcsubD
	26K4PsDexRVD7U2/h+g6Pv4eTr/0X+RaLBvwRBGWEKkMUYv/zgthGNe0lNUS5zrEW+zas8dDEYq
	HRp8iyPC0FH0F4uVWDbtMXCtU3b4p2wbfsN0UaC1PqL5st3y3UjLB99Cbnfrm8paopg==
X-Gm-Gg: ASbGncu4e5em6LkNcKn10RwmPgws72RbRp9QKiRF3mNK+mJBhVMcUv+kmYhWXCbL1qV
	s4NL1OoVZiPdK2VTD9/BSuAJPpo+ihF4kn+d2xBXjHeA3UP9HzCgTmM8bsozxHnjvEQnlhjxhYd
	v7YrZ/NrYFYZlMK55+TET4Pp+i/QmLy+CC6zFCS8sJ1chNDERf3vkTzhpoT3E0Ci2CGTipzeFaT
	cJhxKQ6x1zx+a2KI7Z/ZNDWId/d9Hno5umkSAaPlsaIxO0yT/PShPDQ4gXLtKJVbRFrpihOqGNK
	a+sogGo0mKBIB8BbZQjpNkcG055rsSOA19P8JJpZHG+MnZZgsiD/ZVBNqLoEfHMM1juq8g==
X-Received: by 2002:a05:600c:4f47:b0:43d:aed:f7d0 with SMTP id 5b1f17b1804b1-454dd2efdaamr19766355e9.28.1752153099619;
        Thu, 10 Jul 2025 06:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF1ZpgfSTR11mwv1AOnDNuhaLvwqaP9AOUkt/tw3gz9xvMPGeQpqux7MyiVPuC8LvG2a9Dcw==
X-Received: by 2002:a05:600c:4f47:b0:43d:aed:f7d0 with SMTP id 5b1f17b1804b1-454dd2efdaamr19765775e9.28.1752153099070;
        Thu, 10 Jul 2025 06:11:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1ee1sm1828361f8f.23.2025.07.10.06.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 06:11:38 -0700 (PDT)
Message-ID: <505fa40f-ba51-4f6e-9517-af3e7596a1cb@redhat.com>
Date: Thu, 10 Jul 2025 15:11:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-netdev v2 2/2] PCI: hv: Switch to
 msi_create_parent_irq_domain()
To: "open list:Hyper-V/Azure CORE AND DRIVERS"
 <linux-hyperv@vger.kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Michael Kelley <mhklinux@outlook.com>,
 Nam Cao <namcao@linutronix.de>, Simon Horman <horms@kernel.org>,
 Marc Zyngier <maz@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1751875853.git.namcao@linutronix.de>
 <7b99cca47b41dacc9a82b96093935eab07cac43a.1751875853.git.namcao@linutronix.de>
 <SN6PR02MB41577987DB4DA08E86403738D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <SN6PR02MB41577987DB4DA08E86403738D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 8:49 PM, Michael Kelley wrote:
> From: Nam Cao <namcao@linutronix.de> Sent: Monday, July 7, 2025 1:20 AM
>>
>> Move away from the legacy MSI domain setup, switch to use
>> msi_create_parent_irq_domain().
>>
>> While doing the conversion, I noticed that hv_compose_msi_msg() is doing
>> more than it is supposed to (composing message). This function also
>> allocates and populates struct tran_int_desc, which should be done in
>> hv_pcie_domain_alloc() instead. It works, but it is not the correct design.
>> However, I have no hardware to test such change, therefore I leave a TODO
>> note.
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
> 
> [Adding linux-hyperv@vger.kernel.org so that the Linux on Hyper-V folks
> have visibility.]

I think this series could go via netdev, to simplify the later merge,
but it would be better to have explicit ack from Hyper-V people.

Adding more Microsoft folks.

/P


