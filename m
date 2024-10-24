Return-Path: <netdev+bounces-138712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0A19AE9BE
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA087280F9D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985221F5824;
	Thu, 24 Oct 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f21OhYz0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23B51EBA0D
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782271; cv=none; b=RycP0q4GBg1QXNBtA+4XLH0/p2Dpt/sUG298CAheOPveHMsYf7G6SRHtMBuQxvQElNv6iKk/kHtsut5oImyFsoRaYc3RFHqd3hjmSjHrAwEuHidV1thOuGNUfd8YgbFfVL3OeSGVcKJ9MqXYTcVTPFpYdYOnwoxNJxxgoYcOFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782271; c=relaxed/simple;
	bh=gVY0G67miwqx2BkcKLWPrJDyOIUFUKhCFj7HLBOnq8M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ACMbdpQZu18KHg0CPYlrM3TOuq1fy4fDRMICvjsF7+qKrphYmiG/s9uWFWpzomIP1EGiGQ4g/PwMricLwAf9BmZGtogFK3nnpFyAdJMpYrQO3EG3BRP15v5yzfWEyp2JunbwMd8382Axbok40By0QUekP7ck+zKusdRgd3rFCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f21OhYz0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729782268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVY0G67miwqx2BkcKLWPrJDyOIUFUKhCFj7HLBOnq8M=;
	b=f21OhYz0cuJ1ii9gc+wReXz1/pEzTVeqpyjxovxxWKRAn6NgX+CyiVGUNCGK2dxKc7zlF+
	EdrlkXl1g30e0DgO3grsl3T3oke14mPQTwdAXzASUA/nbqu67PIphh08dpWxF2cv7YQVvb
	/0RDNjbYeFll/i7pYD4eu2VtapnHCck=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-QXm1vKweOUeCPrtUXv14ww-1; Thu, 24 Oct 2024 11:04:23 -0400
X-MC-Unique: QXm1vKweOUeCPrtUXv14ww-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d95264eb4so558521f8f.2
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782262; x=1730387062;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVY0G67miwqx2BkcKLWPrJDyOIUFUKhCFj7HLBOnq8M=;
        b=BfwLeaBM0NomQ/lk5A44UwPYXVpPsOZy2aOIGkFqwHnaBWByNT8E2NBOOta2ERrfSN
         9fwnSJ15IwkuTGbDHa9t734hcC2oytck27XDpITDzrZtRmeCEy/A3P2XOHPY2t2sOBaZ
         60HFjNmcsWu1cAtQcU6443DYM9hzadnJZEu5tjjkGk8bGnKgakQUXcodzURp4EZ/DDD4
         4tcqV8LgdeyjfTFckXKnRRHtqF92E7jDXp6PlIdP1/2tl410p4m45ERaISPGDYncyU7V
         s3Q6CQJI+3W1XJKGcRtWZu7pFai7pTloj3zx71+tAFjkhnEsdDp0WpnQpQBUKLcVk+GH
         AKDw==
X-Forwarded-Encrypted: i=1; AJvYcCW2O1suMtcOJlQcQptoxWRQ6tDUpqI7TjVmeXWJnuY4alf/HXEI+/1pEsxx5zSmape4U6nYLhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzlIQQnIL2378XGEX5Seh4Wp2YmUlXvxxdQkj9YuZOqDGSIqf
	3yfUNem80wHw3VFKIc4QXinET9kuGXWA11Esd4G5XqPl+84KNIb1wtYdMM63dYJKd1dRkmyRucT
	1mNheF6pPnYGGxwby5Asx/dtiJyaFD3ZoVzftttJoNA5jlvcBdvR29Q==
X-Received: by 2002:a05:600c:1e04:b0:431:5c17:d575 with SMTP id 5b1f17b1804b1-4318413eaf7mr49391035e9.11.1729782262392;
        Thu, 24 Oct 2024 08:04:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEup5emfqJAziewFEMpqqZpqld4FxCYvCJsegqkMVL+TKP38UhuZ4nvxCjoDdnnu+B2YT3hww==
X-Received: by 2002:a05:600c:1e04:b0:431:5c17:d575 with SMTP id 5b1f17b1804b1-4318413eaf7mr49390475e9.11.1729782261878;
        Thu, 24 Oct 2024 08:04:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317dde7b70sm72342435e9.1.2024.10.24.08.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 08:04:20 -0700 (PDT)
Message-ID: <d797a175-2e75-472d-ad53-9904bcce7fe7@redhat.com>
Date: Thu, 24 Oct 2024 17:04:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/3] ipv4/udp: Add 4-tuple hash for connected
 socket
From: Paolo Abeni <pabeni@redhat.com>
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241018114535.35712-1-lulie@linux.alibaba.com>
 <20241018114535.35712-4-lulie@linux.alibaba.com>
 <b232a642-2f0d-4bac-9bcf-50d653ea875d@redhat.com>
Content-Language: en-US
In-Reply-To: <b232a642-2f0d-4bac-9bcf-50d653ea875d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/24 17:01, Paolo Abeni wrote:
> The udp4_rehash4() call above is in atomic context and could end-up
> calling synchronize_rcu() which is a blocking function. You must avoid that.

I almost forgot: please include in this commit message or in the cover
letter, the performance figures for unconnected sockets before and after
this series and for a stress test with a lot of connected sockets,
before and after this series.

Thanks,

Paolo


