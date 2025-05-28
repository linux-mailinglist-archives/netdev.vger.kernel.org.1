Return-Path: <netdev+bounces-193886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BD0AC62DD
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67CD16DE1A
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B89F244678;
	Wed, 28 May 2025 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiUg8Ccb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0302F2F
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416920; cv=none; b=qTVal1fvhQYcnAX+1KLHTgPaB/Zdpu8CkjeV4SUrImtjKPyN8WdPF9PcLCnH5McZzeXYQnROlSbkuKvwQcy08L1sZttTWBk48+rNam6quhmd4toOBU1//LbJzhybpu1hEEniK0qxYQGhGl8N/wgepLHIhnQR2mOlJq4zJgqq4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416920; c=relaxed/simple;
	bh=o/EBQDrxGdj6WNmlZP1Kd/pL9W3EBdRR95FbKd6mj0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwLBZZ9dQ4+7QoqBFwtJuw5f68/q3nf+LNuQHSBvl0nG6BZU5VPRc31R1PcQos9dMAIpFrBAPN4mA4WpzrqClXncIGDv1FZ6k/iVfx/KEJkHBGJW3NzkQhK9xuvH66pPjPKQpLBl6fkPbBKirG7pdNpVsLamk9FRDr9L1/jBLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NiUg8Ccb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748416917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WaGWCYscG2gJE/9BxI7p6wq8i7SRMLbgQxHuw11S4oM=;
	b=NiUg8CcbHtgALsAJUuqjuVNa+MhLeAZtGQjsw22FF3adqkghro1XeX37yuL6Or71TuPkBz
	J0yHk6O4TWJKL+68Qx4GSe+O8ISt6mgUKpHKhbwWkcjE8UxH6WU/nKtnzxX4D/hEn1D31i
	Z2AcVkIeREHeFBjfBsGAV31tABlZE1I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-cMivORwzMM27Pqq6ot9dxg-1; Wed, 28 May 2025 03:21:56 -0400
X-MC-Unique: cMivORwzMM27Pqq6ot9dxg-1
X-Mimecast-MFC-AGG-ID: cMivORwzMM27Pqq6ot9dxg_1748416915
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d734da1a3so23430165e9.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 00:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748416915; x=1749021715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WaGWCYscG2gJE/9BxI7p6wq8i7SRMLbgQxHuw11S4oM=;
        b=fY8eIpjR+6W/JOC7uR5lz93c2+gWiA3JTd1+xocP3ryIl63hVqJ7a71izwij9+kBUh
         srd5wYBxKMIJCZ+Yb0h86eVq3LuClVnW6Pg4tgjLDMK/NY6ZGD5AhwXClTVgmDzz07Ia
         +XQVGzSGAblqRGCL0T6C+sw6Zx9qTWfosN03ptvDefFHpv59df2L+3rs2udeF07Zv5dc
         iR6nxToDl8nUqjnfG7VFE3WxpXw3OT6fE/bpBxU125iKFpquUSlta2aV9zhX2ZLjgQ33
         M1k1mfNu5MY2XpoSv5aJhhDkN9WWJxCArC8oq+vqT8MuUVfA/FHBPUORgumGZmUSlcKv
         S/gA==
X-Gm-Message-State: AOJu0Yz3PXVX71vDJJGjwhsvWP1Irj+90RZzMoqAU7k6DtpBL/iUkT6C
	s0sr0aLGVmjHZhKPF7SaJyDZ56v6Nrg2OUdT4PcgiFr2enHtJnqyz4UsJL5b1lVNcjgyKQz+kao
	Z0eETi7P4mDI3FmjWGbMwuWRveRvU36QM6pjJ9B/cZA4nO588D7ouaKZSAA==
X-Gm-Gg: ASbGncugVMDeHcJxiarUjonSVAUkcZDTn4A9zTam/6aDqVsI+xQK0oLy5J/eFrolv7o
	lKaFXojbjPaEntiX4hpwDRVCgsCzZbjJq1GuaDdpUoAE653njG8sV9L3i48P1Xjh3MQW2Q9ewpD
	tZvdK0gcnAWx90srFL1SE34UliLvik8yKT9lF8G5M6AWypYwoI81t4gR9caa6oknEvpS6he95zb
	JQ+zcqQT892A8KAnNfV3fpSlcJ8yeSa8W2LC0/QhBNOyog3ngaPXRwlR8YK485fipv5VHt7/l1I
	vze/0oUxNomq0spkH5PNffaIELiUhuOUOkW7BW5kxl6MiJEzmdHPOJZC5WE=
X-Received: by 2002:a05:600c:5011:b0:43d:fa58:8378 with SMTP id 5b1f17b1804b1-44c94c2afbbmr135543565e9.33.1748416915212;
        Wed, 28 May 2025 00:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9fCAeAfcUeAKLwTnP6W7JttQB6exfEvg0cHvk7Qq1JvXftAAhGkUc468XOpjRQE7kLJI4xQ==
X-Received: by 2002:a05:600c:5011:b0:43d:fa58:8378 with SMTP id 5b1f17b1804b1-44c94c2afbbmr135543155e9.33.1748416914639;
        Wed, 28 May 2025 00:21:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4507253b902sm8490115e9.1.2025.05.28.00.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:21:54 -0700 (PDT)
Message-ID: <0a23a584-0aac-4c6a-bca4-3e220607cae6@redhat.com>
Date: Wed, 28 May 2025 09:21:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/3] dpll: add all inputs phase offset monitor
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jiri@resnulli.us, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksandr.loktionov@intel.com,
 milena.olech@intel.com, corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org
References: <20250523154224.1510987-1-arkadiusz.kubalewski@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250523154224.1510987-1-arkadiusz.kubalewski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 5:42 PM, Arkadiusz Kubalewski wrote:
> Add dpll device level feature: phase offset monitor.
> 
> Phase offset measurement is typically performed against the current active
> source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
> the capability to monitor phase offsets across all available inputs.
> The attribute and current feature state shall be included in the response
> message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL devices.
> In such cases, users can also control the feature using the
> ``DPLL_CMD_DEVICE_SET`` command by setting the ``enum dpll_feature_state``
> values for the attribute.
> 
> Implement feature support in ice driver for dpll-enabled devices.
> 
> Verify capability:
> $ ./tools/net/ynl/pyynl/cli.py \
>  --spec Documentation/netlink/specs/dpll.yaml \
>  --dump device-get
> [{'clock-id': 4658613174691613800,
>   'id': 0,
>   'lock-status': 'locked-ho-acq',
>   'mode': 'automatic',
>   'mode-supported': ['automatic'],
>   'module-name': 'ice',
>   'type': 'eec'},
>  {'clock-id': 4658613174691613800,
>   'id': 1,
>   'lock-status': 'locked-ho-acq',
>   'mode': 'automatic',
>   'mode-supported': ['automatic'],
>   'module-name': 'ice',
>   'phase-offset-monitor': 'disable',
>   'type': 'pps'}]
> 
> Enable the feature:
> $ ./tools/net/ynl/pyynl/cli.py \
>  --spec Documentation/netlink/specs/dpll.yaml \
>  --do device-set --json '{"id":1, "phase-offset-monitor":"enable"}'
> 
> Verify feature is enabled:
> $ ./tools/net/ynl/pyynl/cli.py \
>  --spec Documentation/netlink/specs/dpll.yaml \
>  --dump device-get
> [
>  [...]
>  {'capabilities': {'all-inputs-phase-offset-monitor'},
>   'clock-id': 4658613174691613800,
>   'id': 1,
>  [...]
>   'phase-offset-monitor': 'enable',
>  [...]]

I'm sorry, even if this has been posted (just) before the merge window,
I think an uAPI extension this late is a bit too dangerous, please
repost when net-next reopen after the merge window.

Thanks,

Paolo


