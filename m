Return-Path: <netdev+bounces-128893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F0C97C58C
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 10:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F232842B2
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D831198A02;
	Thu, 19 Sep 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieG/aB9f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF6194C6F
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733151; cv=none; b=JFqASpQDkM5n2AXPmdkR94zBwNUGupzIF6THXYNTmeBWZzfnJVxR35MT6QSITFoHm8Lrn5uSAjGM4hlHDowKMLMUOhHfOiM/uk7VwbeeoM5QIvEpvuPgiYbfV60N5vHzQYDpsdePO+p7V9G/wgcpksYnIujUrqPHsHS4/Oaeoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733151; c=relaxed/simple;
	bh=D6orOs9XWZcSb2c958q3cTArR1KhoQmCev6MFYcT+hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3rw9kOEMJOd4rhPL6X53fP075A3JD/ZAVBJIXVZ+Z64ZYWRTqVS+RUgWbDG2a/wK1976y9g61pYVttNGBWwQeAKI9q0AvcNQN3QsATzB2RndVlFu4y6yGRo4rBZaAzEaVr7MDOLYBJOYSf+fWJlg3rye65e4crLKNG8V2kRgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieG/aB9f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726733147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZEA0msBMHgpwLmqmZ6+VgQjF1gCi6aA86BugJBjbeQ=;
	b=ieG/aB9fsYAahlW3spPvmMjS+wGu3ZsmOKrba+lGrFiKV003MNZOwq96x2ERaksa/4uYXT
	mo/UVXiRyMQ9mav54W+B5cVBP+Zaji01iRh3sLQ9zLweNmIX9OWP/oRxKZ39vzrw/b+7RB
	HBOcd0OGgDB0EzXnhGxoKOX/xlmg7XU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-OZeM8eMjNcaDb6C712huPQ-1; Thu, 19 Sep 2024 04:05:46 -0400
X-MC-Unique: OZeM8eMjNcaDb6C712huPQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cdeac2da6so4428045e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 01:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733145; x=1727337945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZEA0msBMHgpwLmqmZ6+VgQjF1gCi6aA86BugJBjbeQ=;
        b=uk+FrsZ5KdQXNG8afnLnOJSIKMmijHG2wh0GDAn9h7BVojqVltTm7p7x1uUxBmQ7O6
         BLfUK7F+YaxixLOLUuGKfLx2LCzgj+ZW9meCQisP/JDRtRebmfypg2RRs6hFd6ntEwyt
         npNG2MAqfbSfMGBb8nRBsekO2AB3Ezw+5e3wHOR3FKGEY7EAp3j9m0UrzDcnh3GCel4A
         KW44hjpndt93uGlp+tEZBS/WiZo9Y4yLKTaytdD3JTaiaCCSRmgjIV+WtaO3bQeS7ADb
         Pbg53IUIz10UuZt6ORWF8hyaYRTHp+6hH2JMWDJ1GPvO5JYcxgZheNEgTr9g8TwBffZx
         v+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOhlvsQXXLsj324wilY6dPRj0v0aiKYJ/degPylBuYABU5l2vVv5F6SlfMc7+xtIaUBA/9fWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpXAliWFAPRrHoKVNDFLrkHZYfcxVg3EITu+HQ+wqpFAUynsRj
	OZlmvvr3miuzIS26ZlzFN0GlRaBcWKC2B0xKsmr0LvL20+UYwSWndPAQmtAhDc3aFrgiJRnvYbC
	BuplC3bzqVnJ/3mjx0Z1yOUBJMoA2sDDbW4Agw2AVUgawOzIXB7kMmw==
X-Received: by 2002:a05:600c:1c8f:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-42cdb54077bmr242423365e9.16.1726733145310;
        Thu, 19 Sep 2024 01:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE928BYAUOD5B5pdo3lSpWnLvjkNA+3j8DdssqX65JtDEky2vLakwAopjnNk3X2+1VGPnqHTg==
X-Received: by 2002:a05:600c:1c8f:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-42cdb54077bmr242422995e9.16.1726733144861;
        Thu, 19 Sep 2024 01:05:44 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7543f3f4sm15139815e9.16.2024.09.19.01.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:05:44 -0700 (PDT)
Message-ID: <fa3b39c4-8509-49ca-91cf-1536059b79d5@redhat.com>
Date: Thu, 19 Sep 2024 10:05:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] usbnet: ipheth: prevent OoB reads of NDP16
To: Foster Snowhill <forst@pen.gy>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
 Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20240912211817.1707844-1-forst@pen.gy>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240912211817.1707844-1-forst@pen.gy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 23:18, Foster Snowhill wrote:
> In "NCM mode", the iOS device encapsulates RX (phone->computer) traffic
> in NCM Transfer Blocks (similarly to CDC NCM). However, unlike reverse
> tethering (handled by the `cdc_ncm` driver), regular tethering is not
> compliant with the CDC NCM spec, as the device is missing the necessary
> descriptors, and TX (computer->phone) traffic is not encapsulated
> at all. Thus `ipheth` implements a very limited subset of the spec with
> the sole purpose of parsing RX URBs.
> 
> In the first iteration of the NCM mode implementation, there were a few
> potential out of bounds reads when processing malformed URBs received
> from a connected device:
> 
> * Only the start of NDP16 (wNdpIndex) was checked to fit in the URB
>    buffer.
> * Datagram length check as part of DPEs could overflow.
> * DPEs could be read past the end of NDP16 and even end of URB buffer
>    if a trailer DPE wasn't encountered.
> 
> The above is not expected to happen in normal device operation.
> 
> To address the above issues for iOS devices in NCM mode, rely on
> and check for a specific fixed format of incoming URBs expected from
> an iOS device:
> 
> * 12-byte NTH16
> * 96-byte NDP16, allowing up to 22 DPEs (up to 21 datagrams + trailer)
> 
> On iOS, NDP16 directly follows NTH16, and its length is constant
> regardless of the DPE count.
> 
> Adapt the driver to use the fixed URB format. Set an upper bound for
> the DPE count based on the expected header size. Always expect a null
> trailer DPE.
> 
> The minimal URB length of 108 bytes (IPHETH_NCM_HEADER_SIZE) in NCM mode
> is already enforced in ipheth since introduction of NCM mode support.
> 
> Signed-off-by: Foster Snowhill <forst@pen.gy>
> Tested-by: Georgi Valkov <gvalkov@gmail.com>
> ---
> v2: No code changes. Update commit message to further clarify that
>      `ipheth` is not and does not aim to be a complete or spec-compliant
>      CDC NCM implementation.
> v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
> 
> This should perhaps go into "net" rather than "net-next"? I submitted
> the previous patch series to "net-next", but it got merged into "net"
> [1]. However it's quite late in the 6.11-rc cycle, so not sure.

This indeed looks like a fix. I suggest to post it for the net tree 
including a suitable fixes tag.

Additionally since it looks like the patch addressed several issues, it 
would be probably better to split it in a small series, each patch 
addressing a single issue - and each patch with it's own fixed tag.

Thanks,

Paolo


