Return-Path: <netdev+bounces-112970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5F793C0D7
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 13:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255781C20F04
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E31974F4;
	Thu, 25 Jul 2024 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8383JDg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40416F84F
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721907049; cv=none; b=tHvZAXKvGzTx/gBfzIbZefwr47kl5ffUiRBBLGn/rg0CqDWVf4xExTz+SQWdoksS4+zbIDveds0u08KNnI81041xOa+R2cNeEgrQrCq8XzfGTXWPkeFzuwl0sixoRHvRKRZFBZyq/HfmsS1XbJOKt171+1qAT+0D/+yNKfpmb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721907049; c=relaxed/simple;
	bh=mR8vNdleb+LIR+96e34GVS7txk+ZqSRloiT1WSuirHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIW9PvdhQkBApIOVq4dy0V9rrtnwZJl2ENMlp2SgmShhSMNmiSBJtL6RAm8zbTcHR8x29rf+0FJFoJbilBGAzplo3sFADspbNW+2GbthHr8zQe+6eswXOwVxZHW9XSxENC2QKfIe11KyvW6ADoaMMdchaDEWBYPqgorMG+xT4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8383JDg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721907046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TCYiaLw1eFFyX7ygdBtaBpbIQ73qHwI5agyqkVKBk8=;
	b=S8383JDgQnpkUJg6TRHbu2dkrqA6lrM8Rm62xJQo1oa17sVoA2cEtg2vn6u4luOm2rzxG7
	SV5D7E6nW8O8gG0sFjQZ6ham9+qKn9Cdn5PzEjntWgjVq7KKbXfR4jF5l4vR3cmLFLG+IB
	NefI0gXJ6KczUKugiLQdB6raZM9EhiQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-xHUnqrhmOLe3MIEkFIWuqw-1; Thu, 25 Jul 2024 07:30:45 -0400
X-MC-Unique: xHUnqrhmOLe3MIEkFIWuqw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428087d1ddfso440555e9.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 04:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721907044; x=1722511844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TCYiaLw1eFFyX7ygdBtaBpbIQ73qHwI5agyqkVKBk8=;
        b=J5AXLmfT76PrVJULrPagBGBf/KY64SuNzpbMFiRnfTzZORql0OdZIznLuUkmECS+4p
         TvgTUaY5iHnp4YX+MeiS+M7GSdIbovxIUds8oi/6JOBLEP5eN4PCCpgVpQhPtJDPQ8r2
         VUzZmr/fOBKCrjYAhik+KUyDwfbGGvqCmxtT++Ldv5C1JFJA6kscLSdtKpVhujc1GYxj
         Fi7H9H0DNU893Oi/heYH0xswGhm0F1q8ChxB6SBw7RgIMNq39AIAVjMF1Qy8SC7Y8rIa
         aHgvhWvMNrVajZ8QlG8dCYgh81WewfRnzwp8tRndJ5du7Eb4XJHWpf8HK7j8EG4uUnTL
         PYcg==
X-Gm-Message-State: AOJu0YwhMOkdxS/mijI9fvQZLFByb4a5NE2f+ES5/tVFHooNKeJqatMI
	kd3IsYc32aeMKK0VLjGejS1GwpMNGf7Tb0Zx3MjaZxo71XflZIiNl3Ne/+PGYzRKHlPZTMPQn6n
	4dOjUjb3rLaqpe5OiyEfzQVeG9aOt80GPQYECX7wA114cpnTRkNGFzA==
X-Received: by 2002:a05:600c:3b21:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-428057706aemr8868765e9.3.1721907043965;
        Thu, 25 Jul 2024 04:30:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6PofD2noFLqZYZq0rkL2/SPm5eXrfUGdYQwYz7YaFmV1r13660mbRRGEiRWbzSYigfJ0Ikg==
X-Received: by 2002:a05:600c:3b21:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-428057706aemr8868695e9.3.1721907043567;
        Thu, 25 Jul 2024 04:30:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b231:be10::f71? ([2a0d:3341:b231:be10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc624sm1829687f8f.57.2024.07.25.04.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 04:30:43 -0700 (PDT)
Message-ID: <8c823f84-73a3-4f36-b387-3576ca7123d3@redhat.com>
Date: Thu, 25 Jul 2024 13:30:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] ethtool: rss: small fixes to spec and GET
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com
References: <20240724234249.2621109-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240724234249.2621109-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 01:42, Jakub Kicinski wrote:
> Two small fixes to the ethtool RSS_GET over Netlink.
> Spec is a bit inaccurate and responses miss an identifier.
> 
> Jakub Kicinski (2):
>    netlink: specs: correct the spec of ethtool
>    ethtool: rss: echo the context number back
> 
>   Documentation/netlink/specs/ethtool.yaml     | 2 +-
>   Documentation/networking/ethtool-netlink.rst | 1 +
>   net/ethtool/rss.c                            | 8 +++++++-
>   3 files changed, 9 insertions(+), 2 deletions(-)

Acked-by: Paolo Abeni <pabeni@redhat.com>


