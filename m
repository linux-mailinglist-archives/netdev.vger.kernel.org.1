Return-Path: <netdev+bounces-119809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901AE9570F5
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E31ACB2442D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBFA184535;
	Mon, 19 Aug 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzuNYRRt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB9617AE00
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086357; cv=none; b=PRJezCK/sxg+Ec/bahe/9IrYEwqy1iA0kVJ2EO2q+rDGQkLlWwFnWCLg2vR03jZVPybf48qWWgC47GcDYAL3KRJyVGGKJn+xY5S86jtymqKzd5o7t1An94q2rxLU4aP9767Aw+Vso/roGmvDmMxz4FC0RX813ujYKDs6aduTSkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086357; c=relaxed/simple;
	bh=yBIp/uyXdjItnvYUdGXqtrWwXnipen7bm/jhlfg1KOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFxyUsxGmwo+AmBMgoRH4fWJPd7v5nmqjjHYWGru3ArFwEytNKb2YCMkGHuZOhsSlFvV55nBlvjM5emrkqz8o6UrhEk5LbJ0q1JGPdQNUYnHbaPLjJA/1P7oVAyUUvknYcJrCi0nbbckCLSBP2tHBJ9iFaQfl/Cl5VhBA556loI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzuNYRRt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5ZJ+zHUAwVjPsin6t65gSemCQuYECTWoaTxjFkXFVI=;
	b=YzuNYRRtaodh0BT1U3IXmWWhYZnEfB2Ny4VGMbNDvsegJ7OYAu5C+o8OC+XuIIQf30nY7r
	DEWMRwcBdBICnsRaOeszro3/k0i4lt62VN6xsxVPUXbnugn1UtyGvWA78FTMMBZC+CMyBM
	p8ZGj38jTaf4AGxIDb3Gvo78YI8EoDA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-PXiMQn-zM7CZXr7xk3fS8A-1; Mon, 19 Aug 2024 12:52:27 -0400
X-MC-Unique: PXiMQn-zM7CZXr7xk3fS8A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4281e72db54so1154875e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086346; x=1724691146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5ZJ+zHUAwVjPsin6t65gSemCQuYECTWoaTxjFkXFVI=;
        b=drmVNvwmkr8Bom3fi4fGatDBufEI8QGr+Dm3AegF5V4nv4042TTmH/g9lOTE0QK+H7
         BYErcTqOV1s8cIaK8RWkWgBOYLCxDJ+aCV0iNGmc/b1uEFGhM/1NzlKlbB/Dn1yTKLgN
         ZJ5nT+wHBeK8io7ux1HzesGurMAl2DwvNBCyGlg1ZQJSyoUHr+sH3nFqHpGgCokVmSKq
         XAhysZpllzzOSxgFKL6hHBfe+v+6m5WZTIjYZytUdpzXtHpWhj2ajM0bEUVLH9RUT+Sq
         CJPO9ifJSCeTogbtZ1zcbRcSQjsSqwIqU3SgtZ62nYVeTK7z9UHl7vuGqAMJD3ij8ZT3
         2u5A==
X-Gm-Message-State: AOJu0YyqsHzAvsWOKuR/KpHvp/y+AqNg/kgn0sssUKFwezCPtHx4sjna
	jTDe08Uef5VMjTBF43OQIynRuGQNNmTC3blOURMFympc+Esf1ZOi44hU2tyyhOW4p+wCdvWZNIV
	7v4XWJh2F8h5vAmE3jXN2oJ8m15ACEz6VemLLkrQ1dGLl5RkiJeKASQ==
X-Received: by 2002:a05:6000:184c:b0:367:9cf7:6df8 with SMTP id ffacd0b85a97d-37194310b71mr4472457f8f.2.1724086345659;
        Mon, 19 Aug 2024 09:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSA/KZd61HI/hUMzx5ptRkuJRtzSjk7OiAxRf3T0J61Z71lLDWxv+JC1gl0J4OuHnezpTa5Q==
X-Received: by 2002:a05:6000:184c:b0:367:9cf7:6df8 with SMTP id ffacd0b85a97d-37194310b71mr4472441f8f.2.1724086345113;
        Mon, 19 Aug 2024 09:52:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b7c:b910::f71? ([2a0d:3344:1b7c:b910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a347sm11025967f8f.60.2024.08.19.09.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:52:24 -0700 (PDT)
Message-ID: <47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
Date: Mon, 19 Aug 2024 18:52:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>
References: <cover.1722357745.git.pabeni@redhat.com>
 <7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
 <ZquQyd6OTh8Hytql@nanopsycho.orion>
 <b75dfc17-303a-4b91-bd16-5580feefe177@redhat.com>
 <ZrxsvRzijiSv0Ji8@nanopsycho.orion>
 <f320213f-7b1a-4a7b-9e0c-94168ca187db@redhat.com>
 <Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
 <4cb6fe12-a561-47a4-9046-bb54ad1f4d4e@redhat.com>
 <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 13:53, Jiri Pirko wrote:
> Mon, Aug 19, 2024 at 11:33:28AM CEST, pabeni@redhat.com wrote:
>> Isn't the whole point of devlink to configure objects that are directly
>> related to any network device? Would be somewhat awkward accessing devlink
>> port going through some net_device?
> 
> I'm not sure why you are asking that. I didn't suggest anything like
> that. On contrary, as your API is netdev centric, I suggested to
> disconnect from netdev to the shapers could be used not only with them.

ndo_shaper_ops are basically net_device ndo. Any implementation of them 
will operate 'trough some net_device'.

I'm still not sure which one of the following you mean:

1) the shaper NL interface must be able to manage devlink (rate) 
objects. The core will lookup the devlink obj and use devlink_ops to do 
the change.

2) the shaper NL interface must be able to manage devlink (rate) 
objects, the core will use ndo_shaper_ops to do the actual change.

3) something else?

In my previous reply, I assumed you wanted option 2). If so, which kind 
of object should implement the ndo_shaper_ops callbacks? net_device? 
devlink? other?

> This is what I understood was a plan from very beginning. 

Originally the scope was much more limited than what defined here. Jakub 
asked to implement an interface capable to unify the network device 
shaping/rate related callbacks.

In a previous revision, I stretched that to cover objects "above" the 
network device level (e.g. PF/VF/SFs groups), but then I left them out 
because:

- it caused several inconsistencies (among other thing we can't use the 
'shaper cache' there and Jakub wants the cache in place).
- we already have devlink for that.

>> We could define additional scopes for each of such objects and use the id to
>> discriminate the specific port or node within the relevant devlink.
> 
> But you still want to use some netdevice as a handle IIUC, is that
> right?

The revision of the series that I hope to share soon still used 
net_device ndos. Shapers are identified within the network device by an 
handle.

Cheers,

Paolo


