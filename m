Return-Path: <netdev+bounces-219682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD2CB42975
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8C316281B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423932D6E6D;
	Wed,  3 Sep 2025 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXOsfBrZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869492D47F2
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926339; cv=none; b=NYcqwqIPKu57/ewDvTFM6Y72QlzLFUPofQ5gA/vTLdafar8MPAe0mTDqnLzl0ioay6H0N5AENStqNXsKrNH2F2hIDuzvUYfxXzWY3iq7+BQWahcwz7FGufvgqhQmEFWHSEAlfQzn8DZ49RwMLiBnFVKANm8aKCpNUOVlIdRix2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926339; c=relaxed/simple;
	bh=L0qjocOJiWq3l+u8Q7St5a+0s7x+ymc+4SuFBdkKODg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6i3m+F5nAw0fOItwyj9ihjiglu8Fnh9f0JfdYiThGD/bW/jhwEUxvshbzMvAX/WIL1Fca9ZyvFMhpIwCOgA/mvT2dAwn1rKsH61xaNILUHiIQP3gFnR9f/WLHzaS/V2UJ6kdDAOJ1A6GNPJUCQYdvnT5phUd/ygaIw4Bp45s+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXOsfBrZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756926336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjRz5MOW8ct7GDEG18BGj5gmASR3PPkdkMv5XX1JQhU=;
	b=hXOsfBrZlyEHvqDZmJXJ5ZpJP0DYRcImrcMyKcE5i4L8xbA/oM9dH/pmXF/RkLC9SsvIrZ
	kQlk2yqBp3e1c07XZP+R8cmyf4HH8SyVAyEb6uKojB0Njf464qXGHSTp8JQVrrAllGN0wm
	GLR+4QzW/aJhYj7UmjUoehEvvCdoWJM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-7l-9VOICN3WeL0c8VOEQpw-1; Wed, 03 Sep 2025 15:05:31 -0400
X-MC-Unique: 7l-9VOICN3WeL0c8VOEQpw-1
X-Mimecast-MFC-AGG-ID: 7l-9VOICN3WeL0c8VOEQpw_1756926330
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45d6c770066so1571635e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 12:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926330; x=1757531130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjRz5MOW8ct7GDEG18BGj5gmASR3PPkdkMv5XX1JQhU=;
        b=fuMdEk6pVAPQfqt+Ep1D4scA4nGuRurbOpxQUYrecu+KN+PIQ0iSRpQbYNgKuHyiUe
         HdlymmjOsslbTU2a2Sh9ZwQ62TuVMH+z/bp/E1r8M3xZeZblD7nTAR4PS6pLQgmcYv2i
         WcytFQ5yD2O/Gmq41yMNwpJ7vROHJ97S3EtqtZoycBSSYHHfPxS01JISBst00r7MMXjv
         Gs9Ikt/CUIBR4uJkqKVfM9ng4erNLS6Ru+aW6y8hcdlK7WYo0oomQxdVO6WzBX8LWp3x
         TIcSFZJqBdevbhnZkdAv+Pz9VSE7DKRNZIv7Ya26UnjE3+Fa5vsF7Ejf9Kk1RKMVDhE8
         gGHA==
X-Forwarded-Encrypted: i=1; AJvYcCUzFSrnBJtFo+d6v7fNePZR3t0z/xpQwEM9EI+RguzXLmd4B6giLG3kvRSi9CBCOoqRZQpslcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4to5VWisDA8mzXdTbSeSkUsGh/IVOGuLA3iO6IRaznBrDZygc
	twOpiyBJ2Q687YDTBf0NbZ2w8aGbJs43jGDvwWAd10NcmqmaaxuT3u5t7FDuOsANBe3b0cyfgR/
	YL1Rz6yXkcs+vLH9BO+F7hYJi88LbJig2UNWoJoyp70KmSTyDZdBLiK3lYw==
X-Gm-Gg: ASbGncvOiL2Z+t+U7PC+NBDv/T1FOyDnizh3HM1D3LV8Z80fzvfEUximDVCIQHuXVAV
	d03sJiy1OeDVlZ0nz4bLEGmTbuz6SuWBEXmvF2BMlGCl3JOc+Hal2Fnozvn4zBsXBJ7+Pnp5OBx
	mSI/8YfRE9IKi7xJTFVQ98oSk9RPWT72cgVnRqWF9GAnXZiEa2ce8ZYdcIrLm+C9OqQk12J3AvE
	evBmbZyl+Un4klDOfY9hQy+/4ZCG+KliKdIEZpj7UTfAOd0+cRGPn/tTMF1iHiLJKkrc+BYicCY
	kuoOYMZkJPcs/6/8omNSF/Q1Zjevy4d9OCwpfp9oK9zOVYkNbEd5jOX8DnnyH/Tihy39aR10MJo
	u80gtIN1+tg==
X-Received: by 2002:a05:600c:c491:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-45cb50381admr39043825e9.10.1756926330112;
        Wed, 03 Sep 2025 12:05:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdcMupkCf8a3M3P6r1URmhAbTAW0e0csf3HNKNqZoo69cmt/7+rxjLiAOY5LCXGFAzjSkOTg==
X-Received: by 2002:a05:600c:c491:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-45cb50381admr39043605e9.10.1756926329658;
        Wed, 03 Sep 2025 12:05:29 -0700 (PDT)
Received: from ?IPV6:2001:4df4:5814:7700:7fb2:f956:4fb9:7689? ([2001:4df4:5814:7700:7fb2:f956:4fb9:7689])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf3458a67esm24636831f8f.62.2025.09.03.12.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 12:05:29 -0700 (PDT)
Message-ID: <3280699a-7cd3-407f-8875-8186de967d15@redhat.com>
Date: Wed, 3 Sep 2025 22:05:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,2/2] i40e: support generic devlink param
 "max_mac_per_vf"
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "przemyslawx.patynowski@intel.com" <przemyslawx.patynowski@intel.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "horms@kernel.org" <horms@kernel.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
References: <20250903075810.17149-1-mheib@redhat.com>
 <20250903075810.17149-2-mheib@redhat.com>
 <IA3PR11MB8986F453579349C3518B312CE501A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <3b950579-9ed9-4bcc-9809-441c2141615f@redhat.com>
 <IA3PR11MB89868F663B2835ECCBA899E0E501A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <IA3PR11MB89868F663B2835ECCBA899E0E501A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Aleksandr,

Thanks again for your review.
I’ve updated the documentation and commit message in v2 to address your 
feedback.

Appreciate your time!
On 9/3/25 3:35 PM, Loktionov, Aleksandr wrote:
> *From:*mohammad heib <mheib@redhat.com>
> *Sent:* Wednesday, September 3, 2025 12:01 PM
> *To:* Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; intel-wired- 
> lan@lists.osuosl.org
> *Cc:* przemyslawx.patynowski@intel.com; jiri@resnulli.us; 
> netdev@vger.kernel.org; horms@kernel.org; Keller, Jacob E 
> <jacob.e.keller@intel.com>; Nguyen, Anthony L 
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw 
> <przemyslaw.kitszel@intel.com>
> *Subject:* Re: [PATCH net-next,2/2] i40e: support generic devlink param 
> "max_mac_per_vf"
> 
> Hello Aleksandr,
> 
> Thank you for your review.
> 
> On 9/3/25 12:07 PM, Loktionov, Aleksandr wrote:
> 
>         -----Original Message-----
> 
>         From:mheib@redhat.com <mailto:mheib@redhat.com> <mheib@redhat.com> <mailto:mheib@redhat.com>
> 
>         Sent: Wednesday, September 3, 2025 9:58 AM
> 
>         To:intel-wired-lan@lists.osuosl.org <mailto:intel-wired-lan@lists.osuosl.org>
> 
>         Cc:przemyslawx.patynowski@intel.com <mailto:przemyslawx.patynowski@intel.com>;jiri@resnulli.us <mailto:jiri@resnulli.us>;
> 
>         netdev@vger.kernel.org <mailto:netdev@vger.kernel.org>;horms@kernel.org <mailto:horms@kernel.org>; Keller, Jacob E
> 
>         <jacob.e.keller@intel.com> <mailto:jacob.e.keller@intel.com>; Loktionov, Aleksandr
> 
>         <aleksandr.loktionov@intel.com> <mailto:aleksandr.loktionov@intel.com>; Nguyen, Anthony L
> 
>         <anthony.l.nguyen@intel.com> <mailto:anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> 
>         <przemyslaw.kitszel@intel.com> <mailto:przemyslaw.kitszel@intel.com>; Mohammad Heib<mheib@redhat.com> <mailto:mheib@redhat.com>
> 
>         Subject: [PATCH net-next,2/2] i40e: support generic devlink param
> 
>         "max_mac_per_vf"
> 
>         From: Mohammad Heib<mheib@redhat.com> <mailto:mheib@redhat.com>
> 
>         Add support for the new generic devlink runtime parameter
> 
>         "max_mac_per_vf", which controls the maximum number of MAC addresses a
> 
>         trusted VF can use.
> 
>     Good day Mohammad,
> 
>     Thanks for working on this and for the clear explanation in the commit message.
> 
>     I have a couple of questions and thoughts:
> 
>     1) Scope of the parameter
> 
>          The name max_mac_per_vf is a bit ambiguous. From the description,
> 
>          it seems to apply only to trusted VFs, but the name does not make that obvious.
> 
>          Would it make sense to either:
> 
>       - Make the name reflect that (e.g., max_mac_per_trusted_vf), or
> 
>       - Introduce two separate parameters for trusted and untrusted VFs if both cases need to be handled differently?
> 
> I agree that the name could be a bit confusing. Since this is a generic 
> devlink parameter, different devices may handle trusted and untrusted 
> VFs differently.
> For i40e specifically, the device does treat trusted VFs differently 
> from untrusted ones, and this is documented in devlink/i40e.rst.
> However, I chose a more general name to avoid creating a separate 
> devlink parameter for untrusted VFs, which likely wouldn’t be used.
> On reflection, I should update the patch number 1 to remove the 
> **trusted VF** wording from the description to avoid implying that the 
> parameter only applies to trusted VFs.
> 
>     I believe the community generally aims for solutions that work
>     consistently across different hardware. If this parameter behaves
>     differently on i40e compared to mlx5 (or other drivers), it might be
>     helpful to mention that explicitly in the documentation or commit
>     message.
> 
>     2)Problem statement
> 
>          It would help to better understand the underlying problem this parameter is solving.
> 
>          Is the goal to enforce a global cap for all VFs, or to provide operators with a way
> 
>          to fine-tune per-VF limits? From my perspective, the most important part is
> 
>          clearly stating the problem and the use case.
> 
> My main goal here is to enforce a global cap for all VFs.
> There was a long discussion [1] about this, and one of the ideas raised 
> was to create fine-tuned per-VF limits using devlink resources instead 
> of a parameter
> However, currently in i40e, we only create a devlink port per PF and no 
> devlink ports per VF.
> Implementing the resource-per-VF approach would therefore require some 
> extra work.
> so i decided to go with this global cap for now.
> [1] - https://patchwork.kernel.org/project/netdevbpf/ 
> patch/20250805134042.2604897-2-dhill@redhat.com/ <https:// 
> patchwork.kernel.org/project/netdevbpf/patch/20250805134042.2604897-2- 
> dhill@redhat.com/>
> 
> Thank, you Mohammad
> 
> The https://patchwork.kernel.org/project/netdevbpf/ 
> patch/20250805134042.2604897-2-dhill@redhat.com/ <https:// 
> patchwork.kernel.org/project/netdevbpf/patch/20250805134042.2604897-2- 
> dhill@redhat.com/> explains many things.
> 
> It might be helpful to include a brief description of the problem being 
> solved directly in the commit message. This gives reviewers the 
> necessary context and makes it easier to understand the motivation 
> behind the change.
> 
>     …
> 


