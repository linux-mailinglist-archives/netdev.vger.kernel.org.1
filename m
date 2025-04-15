Return-Path: <netdev+bounces-182835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626ADA8A077
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07ECE3BDADB
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE901A0BF1;
	Tue, 15 Apr 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivzIkLds"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144B198E9B
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725546; cv=none; b=fOY598pYv39k0VEiM1vx0gM/sSn4WIRbB9j/FoMsnzHvOB1Tsl8qpVnIGaeetCUemIbL+41pMRM1OVkxZotdFEbfhCo6/HdDhhAJuMSj86ZUdOr1G2M0Kv8qRf7zJGRKFZ+BOpU/aecoaVCPcNxRFvayAuDh5D4bcVsQWUePdf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725546; c=relaxed/simple;
	bh=nxUusHFVgbT0cCGUxQJKF9V1tHwl0L1IBH6pv31xkek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMRrDTFBpVSKxs4RkQIjoTDGAWp5rE7bE8ASQHQcqqe6TBWJM2/4IkjZ2xzCQFEvH5O68Bz9WLEEltRf37Si3dZzp56xi5S6Z8U5W3KDRzRnQ7o+maB/lGoiiA0bncg/mcMqtrgYRx2FgeCz2VxBcYoHDl1uWtX8xw8RzYAEjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivzIkLds; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744725543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgCkyC5ZQWrqR3oKOHgeYhoCgPaLXmgaX/imY5ueuRY=;
	b=ivzIkLdsrrK5xKp+SuPbQYEnCLwcvd2INFEweGOfxUEEU47/A3plNn0ab11PGG1WPnoJPF
	gIR0LcyKG2dXSzg5VLqvKOWrqVz7+AlZck55NoZONKvbSksSESruxM1nkJNOXRSMx3wcI6
	GOzjfD+v35o9bRTFVIn8ojzsmpI1ko0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-bmGU3IsbNUmJIeZmw7AC-A-1; Tue, 15 Apr 2025 09:59:02 -0400
X-MC-Unique: bmGU3IsbNUmJIeZmw7AC-A-1
X-Mimecast-MFC-AGG-ID: bmGU3IsbNUmJIeZmw7AC-A_1744725541
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eed325461so33960955e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 06:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744725540; x=1745330340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgCkyC5ZQWrqR3oKOHgeYhoCgPaLXmgaX/imY5ueuRY=;
        b=ZoCB3kzkzZeP0TjMhJezODlsmTD3vLHee685IrxalIRITg+vqLZ5BhLfrLm1/JJrqf
         8SxJldYws26Rs1atpGGP+5S06HYbP/5cwOp6qLuLvCx8+yoDIYbbcyyOtOVsODG8D2b4
         hladNAgfq5dYCeJPGCGC3s9acM07RPj2/83Nt/WULhNZ1BRam+XE2U9EqOH6U6LrE4NC
         K0o+CknVaLqJzPrqw1dvj4gKu4v6/EyWgHIoPpYFXToF7AKREQ3hvBZOcOHt4xKWt0Pn
         ZwfmX4Y6XNckMEh5FUfpZhuqbXUz/XIyx2pqU70gYEyNKjbLP5ccbt0nxjs+bvsqrG0d
         /7+w==
X-Forwarded-Encrypted: i=1; AJvYcCVyo8FU1TZQXFMo+d3BVMRYxkz4kNIUfcAeZjn26+Lx0nQZDRupJFZemfiU0meWIauYl1NFYog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4DJNds8RU4c3MxzuJI7viueOjuCIsoMNZ9aUHxlz6XeSw3XLA
	hw4MoNSgE5es5w5baNCsb/hyiAMLPC8MAUwDGPUzMVLXu5k1w3P9FFb78R4FpHgT35/kfGBLWnu
	LEgcDOJmgBgOabzg3TDIcivtAqcU21VH+g+2K+Be06mRucNUC4SPHjFBHz39gXg==
X-Gm-Gg: ASbGncsjYg6Ofs6+6jxtlH1eYWNC/c8QtRb65AlLAhZGzPQ+XLdkyTOY1+oOAlPZyiP
	JLOrNduA9SdpbsL8u/AUsnaUQ3fyOWXBLJeCnBcHp/+Qhxe61ufpq723hGbs32CDylc1lnlKigf
	mNzFsFz6o+yLFQveUsh/orb1sWxa2BPx2TfYhcVa0Hva9Q7J7wTjIHzzBSsrUx9VHXffU8b6Q97
	TfAj0aOh+aNwO8bSCkmUEbm+Wz1+UHC1yVWPT/YyYen81314kqAEqbYz3hvVk0Urm7BPE+25FHq
	dEgqh2JoNHFhSSHYp57h+Ok9CgHwXqH0PbtfF2w=
X-Received: by 2002:a5d:584f:0:b0:390:e853:85bd with SMTP id ffacd0b85a97d-39eaaecaa9dmr14428470f8f.48.1744725540521;
        Tue, 15 Apr 2025 06:59:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsaAM2fMC6KGceDNgfXO2q38L6bzCX3r79OVAsL0rxDNAq9h1OxKAsZyr6HdL1lEpxO0q2Fg==
X-Received: by 2002:a5d:584f:0:b0:390:e853:85bd with SMTP id ffacd0b85a97d-39eaaecaa9dmr14428458f8f.48.1744725540237;
        Tue, 15 Apr 2025 06:59:00 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f206332d9sm210354085e9.13.2025.04.15.06.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 06:58:59 -0700 (PDT)
Message-ID: <773e2881-c9e8-4cd8-a3ef-711a203a449d@redhat.com>
Date: Tue, 15 Apr 2025 15:58:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] bonding: Adding limmited support for ARP
 monitoring with ovs.
To: David J Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com
References: <20250411174906.21022-1-wilder@us.ibm.com>
 <20250411174906.21022-2-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250411174906.21022-2-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 7:48 PM, David J Wilder wrote:
> Adding limited support for the ARP Monitoring feature when ovs is
> configured above the bond. When no vlan tags are used in the configuration
> or when the tag is added between the bond interface and the ovs bridge arp
> monitoring will function correctly. The use of tags between the ovs bridge
> and the routed interface are not supported.
> 
> For example:
> 1) bond0 -> ovs-br -> ovs-port (x.x.x.x) is supported
> 2) bond0 -> bond0.100 -> ovs-br -> ovs-port (x.x.x.x) is supported.
> 3) bond0 -> ovs-br -> ovs-port -> ovs-port.100 (x.x.x.x) is not supported.
> 
> Configurations #1 and #2 were tested and verified to function corectly.
> In the second configuration the correct vlan tags were seen in the arp.

If you are adding support for new setup types, you should additionally
implement some test-cases to cover them.

Cheers,

Paolo


