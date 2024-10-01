Return-Path: <netdev+bounces-130772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7E198B7B9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9EA1C22694
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0A519C579;
	Tue,  1 Oct 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gg7/HPUi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19A19AD87
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773066; cv=none; b=CSsxy++GrjuUnutQe27yxrJVWmHZ4l3QAXyoLde0mc/TzwDAnkoFtVEiJnKwXv0Q2pFo1p2YK48HcpgdJfiAzcVV0vvh2hxDMYqgsiBgvtzkP78U9694VqrEPwJwS07inPrqPBsG0jIslVP0F0qq+EjE209evlsNO10Fkb4fxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773066; c=relaxed/simple;
	bh=0rWuWdHzo/SLyCRS5WAeT0wFgXi2wmzOHtxCvKR12LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bvUO0etmZqTIxBZo32sz9/5FqoyGxquYgvMO1VVqtIlNhTFOMsSKqVh3PyPz6EZf/q8dbD7vs/T2VY1jVUdUfZAtiAk0VBQG1UHHjcynRyhFs7tx3575R1eIelXjSlYDf5LGqSdgnKocThwtl7gPnAYujLitV3qAoeRR04/O41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gg7/HPUi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727773062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tel1LpaxCz4nYryVAUogU9yAyr5ZoGgY5gwFfwz2zgo=;
	b=Gg7/HPUi5sg/Rxm4dkXkYSalUKbqetOk9WqKZ4emyT42UP4vFDzTdo8utIh+lyTH3bl3Wm
	pt/K0CpuB4DaftwcaQgo+DzigkWhi1jI1RocZUp/Lob/RZZk5iIPFBkC78rcYT0oRf5U3C
	+DQyCf9CzeLSAgqbfxxAAGqBPy9HDi0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-j6IOyvKJPmaQTVe7D7fArw-1; Tue, 01 Oct 2024 04:57:41 -0400
X-MC-Unique: j6IOyvKJPmaQTVe7D7fArw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb6ed7f9dso53393515e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 01:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727773060; x=1728377860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tel1LpaxCz4nYryVAUogU9yAyr5ZoGgY5gwFfwz2zgo=;
        b=HVpzNywdGGLl+ixKq+jVnijksMu296GRErE9zKg4SBso6mfabbTbikpavc0xyZnxc7
         FwagRf2kFfIxKUZIXYDI1P42WkDEJshiOtWM72n68D83l2iezvO7e52tSMXdljwQRtqk
         7iyAMeizVVQnN4AE9IAG9UNZ2uH8So+KneAmAR8gysG98EcL2rSAOwuxUDc39XcuXMnl
         Jev/fk+vYAhYdTDTJX8AvW66Pc1/bn9I1zLK9kMT+03QouL39byzr68a1ZOPNrZCBPlz
         EY6CCCDweyAUquMwLVD3OczdzBAG47kCj5ja21BYhouN317TNhLU+o6ckPlcyzJqDzoJ
         4vMA==
X-Forwarded-Encrypted: i=1; AJvYcCUG2hLX1AudOH+tEClh/29kCojXlWy0aYf8NMKqkdszY8o+ioO9OlO3UuuGoxDvllaaPrx1L00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSpAmQVlkJ9tdXMqCUR1IKZmxRBK+N0WDbHihRqMb/8RIB40y
	OA157lDHip/ODQmO5fBVLhFEnsrguXI2+X3zkWl+2Hetl9rc0UMxy1XUmcWUZFmZD+TseKjbMMY
	yBLXGRLL7kCx6r3Q1VxLahT+Ksg6+3/2fCYXAO+V8258eAJJmWLv//A==
X-Received: by 2002:a05:600c:1da1:b0:426:62c5:4731 with SMTP id 5b1f17b1804b1-42f584a1821mr158033635e9.29.1727773060152;
        Tue, 01 Oct 2024 01:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDEVnOgFXLBwjP/N0/qO2QYcxJk+fhQ4Bc5AcBVgYNvDnnZR0OhDiecntFBnJOkLo5rnwIVw==
X-Received: by 2002:a05:600c:1da1:b0:426:62c5:4731 with SMTP id 5b1f17b1804b1-42f584a1821mr158033515e9.29.1727773059817;
        Tue, 01 Oct 2024 01:57:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c? ([2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969f1a76sm173796175e9.12.2024.10.01.01.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 01:57:39 -0700 (PDT)
Message-ID: <090742d5-e801-4c12-a49f-b3e06adde82d@redhat.com>
Date: Tue, 1 Oct 2024 10:57:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/1] net: ethernet: lantiq_etop: fix memory
 disclosure
To: Aleksander Jan Bajkowski <olek2@wp.pl>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 jacob.e.keller@intel.com, john@phrozen.org, ralf@linux-mips.org,
 ralph.hempel@lantiq.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923214949.231511-1-olek2@wp.pl>
 <20240923214949.231511-2-olek2@wp.pl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240923214949.231511-2-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/24 23:49, Aleksander Jan Bajkowski wrote:
> When applying padding, the buffer is not zeroed, which results in memory
> disclosure. The mentioned data is observed on the wire. This patch uses
> skb_put_padto() to pad Ethernet frames properly. The mentioned function
> zeroes the expanded buffer.
> 
> In case the packet cannot be padded it is silently dropped. Statistics
> are also not incremented. This driver does not support statistics in the
> old 32-bit format or the new 64-bit format. These will be added in the
> future. In its current form, the patch should be easily backported to
> stable versions.
> 
> Ethernet MACs on Amazon-SE and Danube cannot do padding of the packets
> in hardware, so software padding must be applied.
> 
> Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

For future submissions, please avoid adding the cover letter in case of 
a single patch.

Thanks,

Paolo


