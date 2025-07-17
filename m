Return-Path: <netdev+bounces-207824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8406BB08A83
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDD13A742D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CC3299A85;
	Thu, 17 Jul 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cz8Gx6Cl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E428B41E
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748128; cv=none; b=qqk7Rp1slASyKUVPWy+HBKnHVLZYqxQGwGW7H1Wu+aDodaFP7ydrHgfbuZQ936BNwuBHu+Fbw52bRw5AybzyV2z8qYFzikcjJpmiqz7XtmGockYLT7T4+W8wp6ThWsYBHYL1bavF+gVKLBrH6fqLMLnC4hkfW0DbTsRToyrnaqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748128; c=relaxed/simple;
	bh=jUdhsdYpTt1d6dMYdauSDmb89Vp8/6bJZpeXdUWuSsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6etl3YW8WOLGahFwtBsaPSJeNgX1K5e6lND6KThyfZQ+UIpSFKcepWfggrmmMGSbDsWQccOXdSyIIgmpU2RQAXXLrEDKafpDkKCbTI8izPbuUsKHsNww6hb98ZbD8aVRXmZHxFMuCTgX2Om0onu7XCauuUPrRI2iXuflbLkSyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cz8Gx6Cl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752748125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7gVITUafWmvL5PweD1Qd+07vmGN3UO2X3r0tdcxJLc=;
	b=Cz8Gx6Cl9V9sK7SkRDpvu+CcYk/ax/8+7C6G2igC2hk/LQwyXPA0JoakX5yE8iOnDs6NnG
	nXJhLawjsdLyYHXHnbvNmoHmsI37qmH0dxxNkWhmfnhiNcAF0/1VlZe+YjOWybusRdsvjS
	Z2kGDFIJbv4erKFCw+NG2WSMxFyzOvg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-kTXz9MKlM-eL23NjZwn_QQ-1; Thu, 17 Jul 2025 06:28:41 -0400
X-MC-Unique: kTXz9MKlM-eL23NjZwn_QQ-1
X-Mimecast-MFC-AGG-ID: kTXz9MKlM-eL23NjZwn_QQ_1752748120
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4560f28b2b1so2756865e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 03:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752748120; x=1753352920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7gVITUafWmvL5PweD1Qd+07vmGN3UO2X3r0tdcxJLc=;
        b=ShewvEGpqkAuG8puk8fzvyqffU8AAPHxG8gSjURBQ+c/b301YYtnLt0VJYAmzpX2Su
         FikUUWhoodR7dVEHQoxoG9+8hz12Prk7FP2lqmM01Xyp1qazT0mcHNLFx/chey184QbF
         43CzliUTjp7ME+1ZRbz+4Jbd3P8/L0dpcx+LdFiCn+zkVMMsEXykKuT3mqhk+kWK3pkY
         2o/h4s+//bRR6fTLmz3artHuY4SHSUGMt3ny4LKq8ue5uXwDuPxyrLOcCPyN95H1GjOQ
         xUeGupOj/AdKtpCpO2oaj0KASBqexXFzi5PicjL8zOObU+r6hQtRcHfNYheFvGxEkuN6
         yqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXuXH1g3lptNeHf84tUBa8mqsX2pXvwPwmNfWCOGxyGbwU6t3XXZEQBd5kDkbXPzCEcwlN+/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ANWyUFBNg3+cg6RzeKPThANSHI2wBKh29nfknW7MxM4QSkBx
	l4J0LiTe4O04DhGpOZk1qMpZmdC3J14CyyfkWCoq9zGrm93dr/avR7L/05WkmDgpE/K2YtSIobG
	mtzhjeo/ezFkOMT7GB2rpbqPmdndsdcF2h2XzId3AKh9PkVQfvQleM7ctMg==
X-Gm-Gg: ASbGncsi71PAJCRp9FAQWOoloIRn1w6kjrZllmLPt8Koo2U7KV1HOYBtdnehCnteicw
	iqQFkc8rUZ1EUXITLg8uOKIFlhXdTCik+Gu/+F7DNuFxHCmZPNBQCJ+bDSLpReAxKGtsbXNx7RF
	7bPmAUvQl0Hp6/6XL+BHEiwXemp+V/EWR/TihPp1dfklq+m1w5KcRjCoCtjq0PxZJnOiNzQfCa0
	c9tGUEbDQTRm6O1sYKuTcyFO+O8it5MaN4BxWLM7yOLGKBowdgpFzsARM1JsbkFSScremop2ZaO
	2gm3ozUh11cD7bqKusFKwsb9eQadpUVLqGhx02pv0ATtZ624Tl55oeg6eaN/gAi9WkHOlrnRSAb
	GldVkL08bHiA=
X-Received: by 2002:a05:600c:699a:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-45636ba6679mr19417555e9.10.1752748120042;
        Thu, 17 Jul 2025 03:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOgkOEHOyVE2SiI81qsIVA8HiJTkl922ofyx4dAQycRB8e33j49uQgyInv7ji80BkcgiT9JA==
X-Received: by 2002:a05:600c:699a:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-45636ba6679mr19417235e9.10.1752748119597;
        Thu, 17 Jul 2025 03:28:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd180fsm20192295f8f.2.2025.07.17.03.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:28:39 -0700 (PDT)
Message-ID: <245a03a1-a2a0-4975-a68b-c70d22d01d97@redhat.com>
Date: Thu, 17 Jul 2025 12:28:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,rdma-next 0/6][pull request] Add RDMA support for
 Intel IPU E2000 in idpf
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: tatyana.e.nikolova@intel.com, joshua.a.hay@intel.com,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, jgg@ziepe.ca,
 andrew+netdev@lunn.ch, leon@kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250714181002.2865694-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250714181002.2865694-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 8:09 PM, Tony Nguyen wrote:
> This is part two in adding RDMA support for idpf.
> This shared pull request targets both net-next and rdma-next branches
> and is based on tag v6.16-rc1.
> 
> IWL reviews:
> v3: https://lore.kernel.org/all/20250708210554.1662-1-tatyana.e.nikolova@intel.com/
> v2: https://lore.kernel.org/all/20250612220002.1120-1-tatyana.e.nikolova@intel.com/
> v1 (split from previous series):
>     https://lore.kernel.org/all/20250523170435.668-1-tatyana.e.nikolova@intel.com/
> 
> v3: https://lore.kernel.org/all/20250207194931.1569-1-tatyana.e.nikolova@intel.com/
> RFC v2: https://lore.kernel.org/all/20240824031924.421-1-tatyana.e.nikolova@intel.com/
> RFC: https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/
> 
> ----------------------------------------------------------------
> Tatyana Nikolova says:
> 
> This idpf patch series is the second part of the staged submission for
> introducing RDMA RoCEv2 support for the IPU E2000 line of products,
> referred to as GEN3.
> 
> To support RDMA GEN3 devices, the idpf driver uses common definitions
> of the IIDC interface and implements specific device functionality in
> iidc_rdma_idpf.h.
> 
> The IPU model can host one or more logical network endpoints called
> vPorts per PCI function that are flexibly associated with a physical
> port or an internal communication port.
> 
> Other features as it pertains to GEN3 devices include:
> * MMIO learning
> * RDMA capability negotiation
> * RDMA vectors discovery between idpf and control plane
> 
> These patches are split from the submission "Add RDMA support for Intel
> IPU E2000 (GEN3)" [1]. The patches have been tested on a range of hosts
> and platforms with a variety of general RDMA applications which include
> standalone verbs (rping, perftest, etc.), storage and HPC applications.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> [1] https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/
> 
> ----------------------------------------------------------------

I had some conflict while pulling; the automatic resolution looked
correct, but could you please have a look?

Thanks,

Paolo

Thanks


