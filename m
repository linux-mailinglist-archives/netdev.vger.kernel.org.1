Return-Path: <netdev+bounces-246415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B404CEBA04
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 10:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 150113028DA1
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063AE30FC37;
	Wed, 31 Dec 2025 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXKzx1Nm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhcaKaMI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF311EEA5F
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767171997; cv=none; b=hrnRDFSKblz9r9shXA2/PBRDHsGf68YKZ5/f6bKp4C2h/FOMoIxaRolMwPNPx/PB2ezbpWxPXfdBojyDqdVKxdHlxDoSZkHmGwyl7YsaAVtgnCQgD+NvtM7D7pM+mjmM17HG4/kZPI4gFO5J57NYATCA8uxctP/PidxJ8udJdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767171997; c=relaxed/simple;
	bh=QUwlMDVJdq+AO1eB0FPeqUElozkHlV/v+Io0D1DDZNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OL69hqj1sQtX5NXkGons0q9efUy7jgHFC2Za3hrNoqg+vCM7E53Z0xdmDcknW17tEDcJttOrY0KnjtkNu0PDnUI4LS0qu/Ng9c0IoUGzSAcqgUjq/QAegE3uXawdEdHtoSVEIL0Stcf2LUGbceSmo75JKqLg7SdlQLSBHkMjSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXKzx1Nm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhcaKaMI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767171995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MalXOipz/CuIx0bAeR4P5zozzBVCxAWxoP4epSm8Wo=;
	b=BXKzx1NmpIGPGULAuLEink1lZKZz+MftxGTnCfjddSFYCGb4ldyyTeG7gJ3AY3oRMLAWlA
	SLVjIDqdVp5E4oPzReZxXxo8mO48s7Azzv+W+8pFrR3dYnb34E6ZuoZXKa6RiqCKxJDkyQ
	FlR474wrC1s+ioUTK+H6D9SvEqERR3I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-2fY7RtwFOQuKJwmpgEYbeg-1; Wed, 31 Dec 2025 04:06:33 -0500
X-MC-Unique: 2fY7RtwFOQuKJwmpgEYbeg-1
X-Mimecast-MFC-AGG-ID: 2fY7RtwFOQuKJwmpgEYbeg_1767171993
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47a83800743so57773075e9.0
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 01:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767171993; x=1767776793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MalXOipz/CuIx0bAeR4P5zozzBVCxAWxoP4epSm8Wo=;
        b=ZhcaKaMIzW/rBlaRe0ePsGtLl872CLj2GFxuKLISCNEuP4qZ/CiJ9QfmnBCCpt6Nna
         e3H9P1XPwk4PnaE435UZ/2irScjflM25XWh/xe7aner5PGd60zmcsHXZYB83QcOldSQo
         YaXr3dJooGZNU16z0BGgpHfnycMXxM+rV+zYB98hrsURQFXgDklbxZmoGienpi4wRx/2
         kDC/O2B1pjkPwoqkd9hmKwD+hzWU/wiXgHhzTHG1Lmq8AjPALw6hLwUeSo80vDQYLWQX
         d7PaijY675h4yIzBeau9XXHH6wrmjCUP3984BozaeQs7ObUCeXPaTZljKUr5Ns6naWMi
         sF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767171993; x=1767776793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MalXOipz/CuIx0bAeR4P5zozzBVCxAWxoP4epSm8Wo=;
        b=prjSO4nESfvqKB8aN+qVeZkJ0BRTmX01YfFxGs62o7C5AQxVSoj0rVcDzUwYeE3xKv
         zbAUbep+NZG6s7cR7ksuVrYlop5t4s441uY5yDW3tMW65vnCsHrYGQx40oT8gdtbwlKj
         ePjgGTyMzfwg+Lnj36X8U5zYUqnKt1LHlK3AZybVWVp9luO0NVwef9UZp91yxp3bR8ZO
         bnny6HML2iiSCmKl6Qg0v2PusPuMCgpwjoDfS+sVarzUVEwRav3pvjqOJGRy3SvNP2fF
         PDIB5/6OVU60GEdgHHqiBSjhxUf9Shf7vLpJlt4byuB6fWs3njS4+dBvFXJFOqy7Mvku
         rmpw==
X-Gm-Message-State: AOJu0YyQaZDZlJBLNDSCNYF8c0vlpKZA5Sa9nsogrCQyHRssInMjAjxO
	FKpRC4m4bF4kETTVKn8cX8Hq9mhNaAetcMwtWyV47DN9c00VcrxTc4escZNEkiYkFrWDc+ebWPm
	rn8CXXnIc2oLz572SJSRVJ8rqOl1QyyOPwR4kW7R/IQYoq7EohJtPdlv3hg==
X-Gm-Gg: AY/fxX5b6nkCQSBWhaMjATJkKAY8pR3Of1jPQYO5ATA7UAbG/GRQ40x/NbBitcbUBMj
	lin3wX4ZPqJtU7ZCMfhcgcYYUgHZI9THnfRn3aBH6YTCMyPfufx+2LAISoMacUDmMbQff5l9J37
	NcV2y9L0CqaQDj7gtXeMcp8/tVyzLx4wTPeDpGbVKBnilHUr93/dcCplK6kKwRauoGAtU3YlwV0
	gjpXOx2vnGHU3SbOCfr6SFiOHXeo09lmy7WRvvR6NGy6qVvU8veN3AweYdECnUFdZQhRO9QzH05
	XxYoHCxsI+/XFnrF4G+wUklUSPY+OWCaaWKNQtcl+RN0z5Ll3o6t/8bHUsmLSywNyyAqdnV00F+
	Z3hvuRaulqbOa
X-Received: by 2002:a05:600c:c04b:10b0:47d:333d:99c with SMTP id 5b1f17b1804b1-47d333d09b9mr248393755e9.18.1767171992633;
        Wed, 31 Dec 2025 01:06:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6VxaZ0lW+Fv/9y//CLF5sXKC4bzgP6Kr4lwAL7PJDsWxrGCRFASFoIdj9UdL1Fzv93TAJww==
X-Received: by 2002:a05:600c:c04b:10b0:47d:333d:99c with SMTP id 5b1f17b1804b1-47d333d09b9mr248393415e9.18.1767171992145;
        Wed, 31 Dec 2025 01:06:32 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a0fb9asm283511255e9.2.2025.12.31.01.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 01:06:31 -0800 (PST)
Message-ID: <75e23b2c-67bf-41c8-8970-627d22af3147@redhat.com>
Date: Wed, 31 Dec 2025 10:06:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3 0/8] net: wwan: add NMEA port type support
To: Slark Xiao <slark_xiao@163.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Muhammad Nuzaihan <zaihan@unrealasia.net>, Qiang Yu
 <quic_qianyu@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Johan Hovold <johan@kernel.org>, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, loic.poulain@oss.qualcomm.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 mani@kernel.org, kuba@kernel.org
References: <20251231065109.43378-1-slark_xiao@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251231065109.43378-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/31/25 7:51 AM, Slark Xiao wrote:
> The series introduces a long discussed NMEA port type support for the
> WWAN subsystem. There are two goals. From the WWAN driver perspective,
> NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.). From
> user space software perspective, the exported chardev belongs to the
> GNSS class what makes it easy to distinguish desired port and the WWAN
> device common to both NMEA and control (AT, MBIM, etc.) ports makes it
> easy to locate a control port for the GNSS receiver activation.
> 
> Done by exporting the NMEA port via the GNSS subsystem with the WWAN
> core acting as proxy between the WWAN modem driver and the GNSS
> subsystem.
> 
> The series starts from a cleanup patch. Then two patches prepares the
> WWAN core for the proxy style operation. Followed by a patch introding a
> new WWNA port type, integration with the GNSS subsystem and demux. The
> series ends with a couple of patches that introduce emulated EMEA port
> to the WWAN HW simulator.
> 
> The series is the product of the discussion with Loic about the pros and
> cons of possible models and implementation. Also Muhammad and Slark did
> a great job defining the problem, sharing the code and pushing me to
> finish the implementation. Many thanks.
> 
> Comments are welcomed.
> 
> Changes since V1:
> Uniformly use put_device() to release port memory. This made code less
> weird and way more clear. Thank you, Loic, for noticing and the fix
> discussion!
> 
> Changes since V2:
> Add supplement of Loic and Slark about some fix
> 
> CC: Slark Xiao <slark_xiao@163.com>
> CC: Muhammad Nuzaihan <zaihan@unrealasia.net>
> CC: Qiang Yu <quic_qianyu@quicinc.com>
> CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> CC: Johan Hovold <johan@kernel.org>
> CC: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Uhm... I thingh I already shared the following with you ?!?

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


