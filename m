Return-Path: <netdev+bounces-146631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C52D9D4AE5
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 11:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4127B20356
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDBA1CB515;
	Thu, 21 Nov 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcLanNHG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE211C7299
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184919; cv=none; b=iQJelx4Y8+TOKAl+SWztQEperYVXSsNpsaHub79JDZQ7GFr9pVYNbm5b6yQWR5GWI99gWjMN2L5ag6ZJTLz/dp1mlU/NM5ttFe5wiwKtzyxCcPuRXvhQcS2rPHr9mWbW3gxs/GBLbq9GhlABhYQiRnLpgEjMaHugdQzkNvXIupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184919; c=relaxed/simple;
	bh=sKzohGaYqI7jAfKfMkPF4Mb7mwMdcuQHHA0ja+FhXVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGEGrx5B0/UncX6b+LJQ4OC3j7In3QEW1hG3GDF3yAqECmAPsYDXA8ZwWetw9Pos9T4UzMc3wYuHvqqBzeRQrREnAWZsUvjVKGQJYBPrKATh6CRWi+QxLKKDodvMa7R3rZiXE0xu/fJCf8Hn+Mu2Iz2beY79Ul5VObr61J3Jxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OcLanNHG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732184916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKzohGaYqI7jAfKfMkPF4Mb7mwMdcuQHHA0ja+FhXVI=;
	b=OcLanNHGy6Fv80WRM3xvdFlONfK4BToATp2/cCEmKkX/JxK5oXHrU4TU0NWBZgEDyjWQQy
	HhptP/efyX2mh+pj2GuvZYoEFl4mXc3VXNmwnLQioISgHBiNqxoiidTa6VkXfSTAmU3TDS
	1HkH3uHpMAJJX/hJYDSe+uUw6BDbpUc=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-wOoEsxYIN8KK6ZQdOWTC4g-1; Thu, 21 Nov 2024 05:28:34 -0500
X-MC-Unique: wOoEsxYIN8KK6ZQdOWTC4g-1
X-Mimecast-MFC-AGG-ID: wOoEsxYIN8KK6ZQdOWTC4g
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-85707b002aaso416921241.2
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 02:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184913; x=1732789713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKzohGaYqI7jAfKfMkPF4Mb7mwMdcuQHHA0ja+FhXVI=;
        b=aop3ctxQzAYKa8EQBq4JOgDPJmPyEdPowXXKTZT86LE6+CI/kfhGhhDp0vvSUycDXv
         Ehw8O9AEOIox6A2Hc7M7Tz22+4reUoT/MAoKCTZxQVSBoCI4ip3z/6u4OszJbKK7RmWV
         3XpBI+QHXrF9EhxPMBahAn8BVppJzFDgrX9J/nqcl7sud/ussAYUeHV/7abWyDGcuNqw
         Ie1D6SXKy0zyN/O+6KJB8Ctwn20kdgBs5DtkWM8G9wt4845Es3ICkUXZQazrgFLXtr25
         wbckGbnB4j0iVcY1G+F+Mw1HMJc1XSGWTj7rqvjnEYkIJWPVPCzYPgG/qZK3FZeiN48e
         EqFg==
X-Forwarded-Encrypted: i=1; AJvYcCWMAFea0U415vo0klNWqNGN3azfhBq5mTxXDZE3PGQ/ddm7TBPp2VTvZXIn0ZcSzPANAgJFl2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbM3jsS6qyvw4j7wfS8uJ8Vl84JXwoRNUC5GMKKHeUmZ6hnAf/
	ylmtApRw27QhCbKPiYKgGDqjucfK9isU/qr9GupTTdqB8MbyHqDJIodamMGYLiSTKeC7JoVE6WL
	1K1fRTfySjvhAAkpGWBmqNNwF4A52DeTwit5yBkqiaOuDZbk5VMLgOg==
X-Gm-Gg: ASbGncudoUDMlEb/1izvqC9DTQ0dC3bLRlDjkALvrrwx6sGibOj0/TaFpSb2UR8hhzN
	Vatuuk3YVvOwSGOSILfIIaDeuiRXEG3wi0mWSl20Z/EFbihsFTqYLyuor4+AhYg7LBWAx8j0QSL
	j13eRAnhGTou+4ubbP9w2hYALq0a/6lrCywpRP50i1isK9Gy1iajM2sg8DjuQXhPi1x/MvQw58h
	rLFHZKXdnmEycyc4gsVZuclN72ga7GOAkkoQL58Bs6Y2oDgmPuiraVd7gGhhjJiJg7/Tukz7Q==
X-Received: by 2002:a05:6102:3e07:b0:498:ef8d:8368 with SMTP id ada2fe7eead31-4adaf4bb33fmr7794357137.13.1732184913240;
        Thu, 21 Nov 2024 02:28:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvNgLLYktvPtaJaBpniqt/2h5wYTqtk6DE591nq3WhjRfvS6UaO9CP9BTTqW5PKVBbtxtxGg==
X-Received: by 2002:a05:6102:3e07:b0:498:ef8d:8368 with SMTP id ada2fe7eead31-4adaf4bb33fmr7794340137.13.1732184912953;
        Thu, 21 Nov 2024 02:28:32 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646ab21517sm20273601cf.82.2024.11.21.02.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 02:28:32 -0800 (PST)
Message-ID: <4f621a9d-f527-4148-831b-aad577a6e097@redhat.com>
Date: Thu, 21 Nov 2024 11:28:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA
 before any reads
To: Dullfire <dullfire@yahoo.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mostafa Saleh <smostafa@google.com>,
 Marc Zyngier <maz@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241117234843.19236-1-dullfire@yahoo.com>
 <20241117234843.19236-2-dullfire@yahoo.com>
 <a292cdfe-e319-4bbd-bcc0-a74c16db9053@redhat.com>
 <07726755-f9e7-4c01-9a3f-1762e90734af@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <07726755-f9e7-4c01-9a3f-1762e90734af@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 10:22, Dullfire wrote:
> On 11/21/24 02:55, Paolo Abeni wrote:
>> On 11/18/24 00:48, dullfire@yahoo.com wrote:
>>> From: Jonathan Currier <dullfire@yahoo.com>
>>>
>>> Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
>>> introduces a readl() from ENTRY_VECTOR_CTRL before the writel() to
>>> ENTRY_DATA. This is correct, however some hardware, like the Sun Neptune
>>> chips, the niu module, will cause an error and/or fatal trap if any MSIX
>>> table entry is read before the corresponding ENTRY_DATA field is written
>>> to. This patch adds an optional early writel() in msix_prepare_msi_desc().
>> Why the issue can't be addressed into the relevant device driver? It
>> looks like an H/W bug, a driver specific fix looks IMHO more fitting.
>
> I considered this approach, and thus asked about it in the mailing lists here:
> https://lore.kernel.org/sparclinux/7de14cca-e2fa-49f7-b83e-5f8322cc9e56@yahoo.com/T/

I forgot about such thread, thank you for the reminder. Since the more
hackish code is IRQ specific, if Thomas is fine with that, I'll not oppose.

>> A cross subsystem series, like this one, gives some extra complication
>> to maintainers.

The niu driver is not exactly under very active development, I guess the
whole series could go via the IRQ subsystem, if Thomas agrees.

Cheers,

Paolo


