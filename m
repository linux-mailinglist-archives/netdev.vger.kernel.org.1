Return-Path: <netdev+bounces-200955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5397BAE7880
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8BF7A754B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EBA1FC0EF;
	Wed, 25 Jun 2025 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1XFzLcU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322A1FC7CA
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836300; cv=none; b=WemftiKl+AOVYO3E2Lde4VTHlkHvVoc1j7ItkTnEk8V5+IF09JmbX6o4X0AZ0MLdDyvJojmhAK3rkB0nqXQoREmEs14AfRk4QlWeFCf/PNiXSYx5P2ziIveCufurMmVL7hDWT/vQOQ8/9NLHsYVWU4Ozvqa6ojO0LJJJapz1pT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836300; c=relaxed/simple;
	bh=ce1UdDUU7h2aNFOM8myKE4XHFYi78SBsoNdAnOZm/JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXj2Llj+TdAkcVEpGlOMRyWRXC1nUM4WBbG6eRKNYusHEpANBizyBak07xs2bhhgtGCSrtxorOna8Q+op4t9KUkk2tPP61KOGpids0khW0UVkRkzzFZrk0b/T6zRYwM2bytufVNf4o/2IZQ1S+O4q5wprHBLqpPLpx3A1A/moBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1XFzLcU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750836297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gb1EG5rVAzkyLlYvRtxAnYGAwdctzybaq8suJ9itpCc=;
	b=A1XFzLcUty0EhSD8xZ1wo+WVApg46u6CDZsIMtB1rB0MVriFmWry2m3Y0PX/mVxOVqjL2n
	HeoaLY6qQ14jQp8L8+hJOZBS+EXc0GLxB0hNsaE1Gr1fWRFaJwooRnOtz0YPz+DCYb17PI
	KdoZJ1rji5VNLSTqkALHSpNi8eB/pQc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-OQsyoS6GPci4fPzplQLlZQ-1; Wed, 25 Jun 2025 03:24:55 -0400
X-MC-Unique: OQsyoS6GPci4fPzplQLlZQ-1
X-Mimecast-MFC-AGG-ID: OQsyoS6GPci4fPzplQLlZQ_1750836294
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a6da94a532so2290522f8f.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 00:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750836294; x=1751441094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gb1EG5rVAzkyLlYvRtxAnYGAwdctzybaq8suJ9itpCc=;
        b=a0u7QmdWrDtz6NrrUlF4kgXjdMgk6QOl3oCKGqec4mqp8qcks9MrYZqnLC3Koy5AIi
         OJOyiprz9LEcDwC97S3EQh2uhbpSlIBgpGuf3jsYJWmJRypnpW5We4zbmF+c4dUmZqg1
         5TZCBLYr8A2tyZvKq92mLWhkPuETx4TrXvLN+lbErwBjICbSXv/2CTotk3cq+xDKWFqJ
         1ECvOWKukO5WSRILidvxYASK5gn58szYr8dvJW364tx/VGW4Cg4AGjc9iTV35u0iQM0H
         jrfQsTQ8x9g6imC3xKIesUnrIm3LePStuaLgTyECqHaHZv5mFrQqnsYXU6SQvpVhk9PC
         sChQ==
X-Gm-Message-State: AOJu0Yz3CGTzR6frieNmhHvCXiozOVWK2+mhF6ChuTVJaaYtEUcjNIei
	f86t4kHYI5VPbcdm4J4iuOm/uHIaLGMBBM/a7K5E5iiz+HT6eVHbi5CCDyM1NGris2ZixPtVXAH
	l2FJhilcPZt7sA/AOGAEc4lGgInsBaa/VaFZlr7YjRtbHt/3G2BOZFx3U6Q==
X-Gm-Gg: ASbGncuh1c9FQh3LWlrQEXIqtThuFPKHZiN6F9TrbjHsX07RK4CfbzhUko+EvDVscF2
	hByTXYVySE7RCREZQo6WCIcte4qdyX2ygXeGUOykytA2yXtT4gMEpj8FG0aZANbQn2iZJONL4mZ
	appxbWKIbIG9xJbu7qtrbx+gMfAY2XbQJ8hKglxCWp4Fj/8w37RrRo7/rvqYQ8+x/790SKapyIo
	DYfi87gxWlytBGx1j/hlU5gv7NCjiJd1cJV5QHGvExM1jZ66VD/IERJ4eHldLSA0DC6G9ejUtJR
	pkRT9g4d+Ut/+BjZ7TvEFRFRGDbYii1SMk+OrS2lKhcBlAvLkcqSXQLGKmdBI/QxV4E7ww==
X-Received: by 2002:a05:6000:4815:b0:3a4:dc42:a0ac with SMTP id ffacd0b85a97d-3a6ed64e5ddmr1223629f8f.49.1750836294091;
        Wed, 25 Jun 2025 00:24:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA5cKazsGi7+isNP4cFmVJmrA4j/6038eVM8NMzh2KqkWk8sKK482rCdusN3KvxTYpOH6e0g==
X-Received: by 2002:a05:6000:4815:b0:3a4:dc42:a0ac with SMTP id ffacd0b85a97d-3a6ed64e5ddmr1223598f8f.49.1750836293687;
        Wed, 25 Jun 2025 00:24:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc86:3510:2b4a:1654:ed63:3802? ([2a0d:3341:cc86:3510:2b4a:1654:ed63:3802])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805e828sm3894469f8f.32.2025.06.25.00.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 00:24:53 -0700 (PDT)
Message-ID: <81a216e8-e675-4564-84bb-039e0851a8ec@redhat.com>
Date: Wed, 25 Jun 2025 09:24:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patches in the bluetooth tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250625111648.54026af1@canb.auug.org.au>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250625111648.54026af1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/25/25 3:16 AM, Stephen Rothwell wrote:
> The following commits are also in the net tree as different commits
> (but the same patches):
> 
>   4500d2e8da07 ("Bluetooth: hci_core: Fix use-after-free in vhci_flush()")
>   6c31dab4ff1e ("driver: bluetooth: hci_qca:fix unable to load the BT driver")
>   d5c2d5e0f1d3 ("Bluetooth: L2CAP: Fix L2CAP MTU negotiation")
>   866fd57640ce ("Bluetooth: btintel_pcie: Fix potential race condition in firmware download")
> 
> These are commits
> 
>   1d6123102e9f ("Bluetooth: hci_core: Fix use-after-free in vhci_flush()")
>   db0ff7e15923 ("driver: bluetooth: hci_qca:fix unable to load the BT driver")
>   042bb9603c44 ("Bluetooth: L2CAP: Fix L2CAP MTU negotiation")
>   89a33de31494 ("Bluetooth: btintel_pcie: Fix potential race condition in firmware download")
> 
> in the net tree.

I think it's an artifact of the BT tree being rebased. I pulled from:

git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
tags/for-net-2025-06-23

It looks like the first set of commits is no more reachable in the bt
tree, so the 'net' ones should be the "correct" commits set. @Luiz:
could you please confirm?

Thanks,

Paolo



