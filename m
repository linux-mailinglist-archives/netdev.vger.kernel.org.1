Return-Path: <netdev+bounces-127478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E3A9758AA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4557B28514B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517891B141B;
	Wed, 11 Sep 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIOi7aSe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424D1AE035
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073092; cv=none; b=htMEbX3SpHYoSZAUCtspKFgu1kueND2uuTDV+7GFfhomtPrEwdKYopPMoXk9U/xQJgmJMYHpxk4lTRwjeoEm5wlZtT0WvgPysS752axWnCdiVsSi2igrp6d/llE8kCKGZZiSebKP/+cdEXEDZbMF8lNzl9plgBt+wlsfVKJubus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073092; c=relaxed/simple;
	bh=1nXds3ZP4p3jZUi2dsZQP+ReMsx100WA8hDf2B/ubZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfbqzWeut4iP9pRENlR2GU3XQriufggvojjc3zrDqGav/ZRp4NXzrZhf1D6hDuhht2zDMvNAyJll2JcWNSwAPJ9TC6680Pl9k+Bi1hc61NgB/AcYz1Z0L1eEjNYUrDHKJjK4W9Crvuvlas3k7qM1bYnNTzbiLefecCMWq36VY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIOi7aSe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726073088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvxdIsxfAzYBcE3ejxiUV1BcDIxlqNJLApqpadVPCTc=;
	b=fIOi7aSej5iGaXjeLlnIUXgcp7t7lpTM9bcQdeVr3jP2bvLDZGBkBgJ90+eJDgCyhyOXkv
	woO4h4zACvW21726wt4PpSyWF1h4B3y224OS93hksUmPAgPEDEoWVhL//Aq1TzJ0OIJA2Z
	xHQL7Rtn4E2tQdK1P1VrhlJVU6oixZA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-NRt_hwqpMQ6kNI4i9gDpBg-1; Wed, 11 Sep 2024 12:44:47 -0400
X-MC-Unique: NRt_hwqpMQ6kNI4i9gDpBg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8d2e6a6989so1632866b.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726073086; x=1726677886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvxdIsxfAzYBcE3ejxiUV1BcDIxlqNJLApqpadVPCTc=;
        b=WpF7PMhPakSmg9uHOcnprH+KBe/wkQ7RBodK1XZa0JpwUtxgG2Z+UIXPh3JVUyLk+r
         4jxUYOp2lNvPwqaNQpnIfCrWy5/Xz+YuD7GT38CK3EM/B/+3q8pA9qjrxY2eR+otcaeb
         2XiXzwf77etc2m33re5qAqLUABi0m/dLohH5brc7Euvdu5mpNS60NH3/OplBNAifxgHO
         VPaqD84LWxj/zHSiApbYdjZ/w/l7wtLiYYf8vpXwxm3tuh+iEgkGuAffCdMo6Ceelab0
         8ASmgGoDkb3IhFisFMxuP3zYbO4Ta/h4v+fzLCvdvOafivTTyln6SPl94VBxmjy9Qrww
         PjzA==
X-Forwarded-Encrypted: i=1; AJvYcCVWP9jkQXj0pGimf9SJt7sM2lXuJgYHl00DhKTveaOmhbGFlyYYqSOPT0M717nEzbNd6rYABoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCX4cv6Wt0AS3BQZgEsktfaQMI60hfwojX11/l9MLKFSuXBOrI
	sG0YYuzRVI1YtPAOAgwszFLy/iTO1fyWyLiNrXD2zxaxr/p0g0F8sNPZl+PR8BPuxlJcuyLPsb2
	kiocMZ3KYcsPV3TSklNpn1GqgOyHEFYtW1N7mlV9iFu+BE4PAlw7zuw==
X-Received: by 2002:a17:906:d7da:b0:a86:812a:d2ca with SMTP id a640c23a62f3a-a9029504e84mr8785866b.25.1726073085910;
        Wed, 11 Sep 2024 09:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFktpKzCa0aKc4C7BgocbZxtL8LJuk2wMgcJlorDEqUL7HtqzMbLcy98KSTxOWnzNfmiPcTLQ==
X-Received: by 2002:a17:906:d7da:b0:a86:812a:d2ca with SMTP id a640c23a62f3a-a9029504e84mr8781066b.25.1726073085204;
        Wed, 11 Sep 2024 09:44:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d40e8csm633247166b.196.2024.09.11.09.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:44:44 -0700 (PDT)
Message-ID: <8af6253d-83aa-403a-a383-8fb5f5ee0d78@redhat.com>
Date: Wed, 11 Sep 2024 18:44:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.11] minmax: reduce egregious min/max macro
 expansion
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Richard Narron <richard@aaazen.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Arnd Bergmann <arnd@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-mm@kvack.org, stable@vger.kernel.org
References: <20240911153457.1005227-1-lorenzo.stoakes@oracle.com>
 <181dec64-5906-4cdd-bb29-40bc7c02d63e@redhat.com>
 <3f622e05-9843-4763-9191-c980feb831d2@lucifer.local>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3f622e05-9843-4763-9191-c980feb831d2@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/11/24 6:37 PM, Lorenzo Stoakes wrote:
> On Wed, Sep 11, 2024 at 06:24:54PM GMT, Hans de Goede wrote:
>> Hi Lorenzo,
>>
>> On 9/11/24 5:34 PM, Lorenzo Stoakes wrote:
>>> Avoid nested min()/max() which results in egregious macro expansion.
>>>
>>> This issue was introduced by commit 867046cc7027 ("minmax: relax check to
>>> allow comparison between unsigned arguments and signed constants") [2].
>>>
>>> Work has been done to address the issue of egregious min()/max() macro
>>> expansion in commit 22f546873149 ("minmax: improve macro expansion and type
>>> checking") and related, however it appears that some issues remain on more
>>> tightly constrained systems.
>>>
>>> Adjust a few known-bad cases of deeply nested macros to avoid doing so to
>>> mitigate this. Porting the patch first proposed in [1] to Linus's tree.
>>>
>>> Running an allmodconfig build using the methodology described in [2] we
>>> observe a 35 MiB reduction in generated code.
>>>
>>> The difference is much more significant prior to recent minmax fixes which
>>> were not backported. As per [1] prior these the reduction is more like 200
>>> MiB.
>>>
>>> This resolves an issue with slackware 15.0 32-bit compilation as reported
>>> by Richard Narron.
>>>
>>> Presumably the min/max fixups would be difficult to backport, this patch
>>> should be easier and fix's Richard's problem in 5.15.
>>>
>>> [0]:https://lore.kernel.org/all/b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com/
>>> [1]:https://lore.kernel.org/lkml/5882b96e-1287-4390-8174-3316d39038ef@lucifer.local/
>>> [2]:https://lore.kernel.org/linux-mm/36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local/
>>>
>>> Reported-by: Richard Narron <richard@aaazen.com>
>>> Closes: https://lore.kernel.org/all/4a5321bd-b1f-1832-f0c-cea8694dc5aa@aaazen.com/
>>> Fixes: 867046cc7027 ("minmax: relax check to allow comparison between unsigned arguments and signed constants")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>
>> Thank you for your patch.
>>
>> I must say that I'm not a fan of that this is patching 3 totally
>> unrelated files here in a single patch.
>>
>> This is e.g. going to be a problem if we need to revert one of
>> the changes because of regressions...
>>
>> So I would prefer this to be split into 3 patches.
> 
> Well, I was doing this as a favour to Richard between other work so put
> this together quickly, but you're right this is going to be a pain to
> backport/revert if issues so absolutely - will do.
> 
> Since this is a hotfix I'm going to risk annoying people and shoot out
> a v2 on same day as v1. Sorry in advance.
> 
>>
>> One review comment for the atomisp bits inline / below.
>>
>>> ---
>>>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  2 +-
>>>  .../staging/media/atomisp/pci/sh_css_frac.h   | 26 ++++++++++++++-----
>>>  include/linux/skbuff.h                        |  6 ++++-
>>>  3 files changed, 25 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
>>> index e809f91c08fb..8b431f90efc3 100644
>>> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
>>> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
>>> @@ -23,7 +23,7 @@
>>>  /* The PacketOffset field is measured in units of 32 bytes and is 3 bits wide,
>>>   * so the maximum offset is 7 * 32 = 224
>>>   */
>>> -#define MVPP2_SKB_HEADROOM	min(max(XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)
>>> +#define MVPP2_SKB_HEADROOM	clamp_t(int, XDP_PACKET_HEADROOM, NET_SKB_PAD, 224)
>>>
>>>  #define MVPP2_XDP_PASS		0
>>>  #define MVPP2_XDP_DROPPED	BIT(0)
>>> diff --git a/drivers/staging/media/atomisp/pci/sh_css_frac.h b/drivers/staging/media/atomisp/pci/sh_css_frac.h
>>> index b90b5b330dfa..a973394c5bc0 100644
>>> --- a/drivers/staging/media/atomisp/pci/sh_css_frac.h
>>> +++ b/drivers/staging/media/atomisp/pci/sh_css_frac.h
>>> @@ -32,12 +32,24 @@
>>>  #define uISP_VAL_MAX		      ((unsigned int)((1 << uISP_REG_BIT) - 1))
>>>
>>>  /* a:fraction bits for 16bit precision, b:fraction bits for ISP precision */
>>> -#define sDIGIT_FITTING(v, a, b) \
>>> -	min_t(int, max_t(int, (((v) >> sSHIFT) >> max(sFRACTION_BITS_FITTING(a) - (b), 0)), \
>>> -	  sISP_VAL_MIN), sISP_VAL_MAX)
>>> -#define uDIGIT_FITTING(v, a, b) \
>>> -	min((unsigned int)max((unsigned)(((v) >> uSHIFT) \
>>> -	>> max((int)(uFRACTION_BITS_FITTING(a) - (b)), 0)), \
>>> -	  uISP_VAL_MIN), uISP_VAL_MAX)
>>> +static inline int sDIGIT_FITTING(short v, int a, int b)
>>> +{
>>
>> drivers/staging/media/atomisp/pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a.host.c
>>
>> calls this with ia_css_3a_config.af_fir1_coef / .af_fir2_coef
>> as first argument those are of the ia_css_s0_15 type which is:
>>
>> /* Signed fixed point value, 0 integer bits, 15 fractional bits */
>> typedef s32 ia_css_s0_15;
>>
>> please replace the "short v" with "int v"
> 
> Yeah I think you're right, it's odd, because it seems that the shift value
> and the comments implies that this is a short, but perhaps it's more so
> that values are shifted as to obtain 16 bits of precision.
> 
>>
>> I think that you can then also replace clamp_t() with clamp()
> 
> The use of clamp_t() is to avoid egregious macro expansion in
> clamp(). After the series improving min/max the clamp() is probably
> equivalent. But in 5.15 it will likely not be. So this is, in line with the
> purpose of this change, I believe necesasry.

Ok fair enough.

Regards,

Hans


