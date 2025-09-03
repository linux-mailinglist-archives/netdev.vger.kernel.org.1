Return-Path: <netdev+bounces-219517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A549B41B1C
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045D6566141
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C65261B75;
	Wed,  3 Sep 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cB7dbrNy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3D2E7BB6
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893957; cv=none; b=Lf0IQ+/yBtB9jYl1u/vi0q/88IaLChp7RLwDo+13jG2tFBlNdTVntrOfV2sZ04vsKFW9QpqqbjDUxTLbjewaeuce0pM5cz3xpVoGO6rpXrhnRsyfEoPE5TBt4gnjGhCDjzTzB3ePT3+gq6/GRjeuT2ydzicu5VVRtJf1nH/dLsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893957; c=relaxed/simple;
	bh=kq1Wau0wY9DLA41QIV4x2j+j+ZrFWzY6e0XFo5MjlPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGnfdL6CYl8XeWmowiPbqh+N9KFpB2YASqQL6n3QBcT33M61agJ5tSO5v7I3TQPTTAAX78AfrrdXo8VQ5WN+U5Vx+pHp3B11vwcF2REnxJiBjr0vUOQ6UbYIqNOxiau5e3UH+TeBfAwmMj+tntyai85292Gwv+L+l2eX9h+0SH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cB7dbrNy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756893954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EA9HHU3PvtBg+lD4L5AqD1cu5f34Hf0u2RaEvtIhKfU=;
	b=cB7dbrNydeFFH5jSARZJyBP1Yfylcnq5IF708CvXpAOts7A3rJC9/BAtFHqF4QIgL8SLAK
	+2a+RNOEmTP1suiTHqF+cX7JcldUoc7IjQc+3Ln4U/B4wM0rXg9Rp75f5OP5yhzi8Mcs2d
	659Mi5+rbEUg6SCsXft9a3mqnGXaCgo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-nEuhNML6P1aDMVIUdrE6_Q-1; Wed, 03 Sep 2025 06:05:53 -0400
X-MC-Unique: nEuhNML6P1aDMVIUdrE6_Q-1
X-Mimecast-MFC-AGG-ID: nEuhNML6P1aDMVIUdrE6_Q_1756893952
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3dc3f943e6eso525157f8f.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 03:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756893951; x=1757498751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EA9HHU3PvtBg+lD4L5AqD1cu5f34Hf0u2RaEvtIhKfU=;
        b=qlUMegRHKxwhgfVAVBhjndqxxMBeS7SzFLGWn+qRywqT0J5UUfQPx2O5t+2I2enDB/
         yg4epywI5izkltgRcAXj+IgJ+LkQLvGKn5q70w9wFkV4boC6Yy5rNdj8eINZkyJup4LN
         d71An6yn5kXx2YZbTnSOLB1lAAnzn2o2ZHwxG9bmlwAWpCLXlg06yl/BIK26PZJlhxCv
         qDoDHOBn1Hs4eWx6+LyZCebMi0Amt3Os9KxgotGH50eUojqh03uUBWeRH8XY7vxVXT4N
         vPJ4bgy+CclE0Wb1w5ZZRu6/8Gi8OGmzaTF/c1Mv1hc0by6+vcsqULxP2TTUpp1p1Epq
         Blkw==
X-Forwarded-Encrypted: i=1; AJvYcCWSsasXHqBwQ1lgG+V3M24BoDciLLfCkBU/td5Y5/9Xpsa/QttRu071dAw6fh5xNUhgjg3ZGJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ooncMFtnM8lIRsOx31IIe2GNp0A/5/xC78hJSQHu/2VvxjYu
	n1gNIQcXr7KKScQvm1cCSQ3pBJdBrLyFZ8t2mMN1ZBpDPLPXmY9cKiUK0EJJ7obE8/tANbPIMLu
	uKseAXSihjTqtDEy9InJztQXFQ1NsowHkPeD2LZI5IXvakG/e1IQPU0LdyIcmMh5/JS33/3A=
X-Gm-Gg: ASbGncu35r5Cd4noAQHsHt/Czuc1Ktz1BmQHI1q8AdcX95IWa566ZJtqJqMZ5DvOMkk
	vNVB0W0MkVfldz99bFb2Ndnz33dcv6KKCTXCvCsFrVbLTbXB/gitQCDchZHAE2HJKjJDjPsqd0V
	CjYDK6urec9NnGcpIgl8aLHPXQPpaDIkN+rFJF0yYuvT81El4kxFc3l090rOA8YR4H+fCAG18oZ
	24hImO/AQ9CYhn8DL4uMMZ9hdG2BeKZ8n8iiIxCTqBvE2cayyEfT5vN+o9t+s6ccuWGXdXZeeN/
	glfSMYnUZzOwzY6lvuXxIp+eXeCEXXfdNePss1BphaM=
X-Received: by 2002:a05:6000:26c4:b0:3c9:b8b7:ea4e with SMTP id ffacd0b85a97d-3d1dddf0bb6mr11319805f8f.19.1756893951611;
        Wed, 03 Sep 2025 03:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVOXoPZ7BPX/XFKABihtdsW//N0+PzKwU75BmJnyEGwill00FaomBFArdepVzs0O6QDYnCrA==
X-Received: by 2002:a05:6000:26c4:b0:3c9:b8b7:ea4e with SMTP id ffacd0b85a97d-3d1dddf0bb6mr11319779f8f.19.1756893951165;
        Wed, 03 Sep 2025 03:05:51 -0700 (PDT)
Received: from [192.168.68.125] ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3da13041bcasm6733988f8f.35.2025.09.03.03.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 03:05:50 -0700 (PDT)
Message-ID: <22e2c955-61b7-4a1e-ab91-21cd1906a604@redhat.com>
Date: Wed, 3 Sep 2025 13:05:48 +0300
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
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <IA3PR11MB8986F453579349C3518B312CE501A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hello Aleksandr,

Thank you for your review.

On 9/3/25 12:07 PM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: mheib@redhat.com <mheib@redhat.com>
>> Sent: Wednesday, September 3, 2025 9:58 AM
>> To: intel-wired-lan@lists.osuosl.org
>> Cc: przemyslawx.patynowski@intel.com; jiri@resnulli.us;
>> netdev@vger.kernel.org; horms@kernel.org; Keller, Jacob E
>> <jacob.e.keller@intel.com>; Loktionov, Aleksandr
>> <aleksandr.loktionov@intel.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Mohammad Heib <mheib@redhat.com>
>> Subject: [PATCH net-next,2/2] i40e: support generic devlink param
>> "max_mac_per_vf"
>>
>> From: Mohammad Heib <mheib@redhat.com>
>>
>> Add support for the new generic devlink runtime parameter
>> "max_mac_per_vf", which controls the maximum number of MAC addresses a
>> trusted VF can use.
> 
> 
> Good day Mohammad,
> 
> Thanks for working on this and for the clear explanation in the commit message.
> 
> I have a couple of questions and thoughts:
> 
> 1) Scope of the parameter
>      The name max_mac_per_vf is a bit ambiguous. From the description,
>      it seems to apply only to trusted VFs, but the name does not make that obvious.
>      Would it make sense to either:
> 	- Make the name reflect that (e.g., max_mac_per_trusted_vf), or
> 	- Introduce two separate parameters for trusted and untrusted VFs if both cases need to be handled differently?
I agree that the name could be a bit confusing. Since this is a generic 
devlink parameter, different devices may handle trusted and untrusted 
VFs differently.
For i40e specifically, the device does treat trusted VFs differently 
from untrusted ones, and this is documented in devlink/i40e.rst.
However, I chose a more general name to avoid creating a separate 
devlink parameter for untrusted VFs, which likely wouldn’t be used.
On reflection, I should update the patch number 1 to remove the 
**trusted VF** wording from the description to avoid implying that the 
parameter only applies to trusted VFs.
> 
> 2)Problem statement
>      It would help to better understand the underlying problem this parameter is solving.
>      Is the goal to enforce a global cap for all VFs, or to provide operators with a way
>      to fine-tune per-VF limits? From my perspective, the most important part is
>      clearly stating the problem and the use case.
> 
My main goal here is to enforce a global cap for all VFs.
There was a long discussion [1] about this, and one of the ideas raised 
was to create fine-tuned per-VF limits using devlink resources instead 
of a parameter
However, currently in i40e, we only create a devlink port per PF and no 
devlink ports per VF.
Implementing the resource-per-VF approach would therefore require some 
extra work.
so i decided to go with this global cap for now.
[1] - 
https://patchwork.kernel.org/project/netdevbpf/patch/20250805134042.2604897-2-dhill@redhat.com/
> 3)Granularity
>      If the intent is to give operators flexibility, a single global parameter might not be enough.
>      For example, limiting the number of MAC filters per specific VF (or having different limits for trusted vs. untrusted)
>      could be a real-world requirement. This patch doesn't seem to address that scenario.
> 
> Could you share more details about the use case and whether per-VF granularity was considered?
> 
> Thanks again for the work on this. Looking forward to your thoughts.
> 
> Best regards,
> Aleksandr
> 
please see - 
https://patchwork.kernel.org/project/netdevbpf/patch/20250805134042.2604897-2-dhill@redhat.com/
>>
>> By default (value 0), the driver enforces its internally calculated
>> per-VF MAC filter limit. A non-zero value acts as a strict cap,
>> overriding the internal calculation.
>>
>> Please note that the configured value is only a theoretical maximum
>> and a hardware limits may still apply.
>>
>> - Previous discussion about this change:
>>    https://lore.kernel.org/netdev/20250805134042.2604897-1-
>> dhill@redhat.com
>>    https://lore.kernel.org/netdev/20250823094952.182181-1-
>> mheib@redhat.com
>>
>> Signed-off-by: Mohammad Heib <mheib@redhat.com>
>> ---
> 
> ...
> 
>> --
>> 2.50.1
> 
  Thank you,


