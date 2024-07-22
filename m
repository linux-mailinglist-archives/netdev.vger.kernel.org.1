Return-Path: <netdev+bounces-112360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 731719388EB
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 08:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D29F281576
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 06:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F1F182BD;
	Mon, 22 Jul 2024 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="XeyWHW71"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2E517C8D
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721629708; cv=none; b=afumM2XS7yIp85GJf3N9qb7IPdX99rnrjCNVvxYmSrVc0wj+Dx3Dz8I/PwnZL61JPxbDaH1RWPlf76jvwzas+L9grT5fl+D0NZVb1vH6hcO/9/bM5fVvwQSl6s/sN3m4dkq3Ev6krvyAwoypQap1682yDhLic5/6ocSvvSQJksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721629708; c=relaxed/simple;
	bh=4XkX+SLERJ3C2lk4QFpJNk87dpDMDh55k5tzuaQw2AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBt0vzg/UK1CqOEjE06WtRSDKX4MbQxw9fhnpaETeOYLPIz2ro9NN2YGrxMFJQcpAjKldR8Sc9xxtOL1U8P4yH4SFCJop5U4iq2r703MEVLyDFEzD+dOV4n+ekLYIA5ow1DHaQm+uCnCoT9nnlTd53OvgK9q/Jejqg8dETSkPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=XeyWHW71; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb09dc1dafso1882022a91.2
        for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 23:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1721629705; x=1722234505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/FxuHdczmYlC1OMZsN1ms04otV8i+GBz2pvbAjTD28=;
        b=XeyWHW71gmQou9cGK4xkdNPSuRcNeArv08KsuqrR50kNzysoK8yE6HwJXr7Ps/yUmq
         qgH1WveMVml042fvbkxpO3RECPbGG4FgGssQs76nSlrgKJIKhp+x3Gp30tL4bCV1uaoc
         Fugkj7cBzOii3duPM/ptyquHQLVULYT7Ekjkmi+ZTEfZ3t3qgFo1kXzU69wduSHGign7
         wDlkp8DH5nC3mjLDCh/QUSXML+XQBQpd6067Bvpf0Q/ZL9uqniVtfSl/mDt4s8Q2Zn/R
         xzEqBSQRjQsWfD1jxyzWF3A34d27zWOYwW+lgoDdzVLXpdjJLIsMtx1As6CXjLlpYDnR
         k5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721629705; x=1722234505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/FxuHdczmYlC1OMZsN1ms04otV8i+GBz2pvbAjTD28=;
        b=PnCLvD8N4E3/b8Rpq5EINIWlv0TCxRkLPIp1ofn0WRGgiHwg08JYR2jmwzlqMY58uD
         1mb6UVFzYJUZOtEhkPn2ri5fXkH7/qu2XNG5TfLP7KBV0lKf5A2B1CG3/MG7Owbf3zQh
         EHUVZ97TXUf7WM+55bLXNq+0GynHSBUx/t+zU83AHR6/fyTRhl/VvkgWYDQX//s2LDhx
         H+lRHsCMScx+KArYbIQ15cHowSWjtgBAy1Kj3VvPx0z+gNc0TfFL5JA/PPLp3uUYYM1L
         1pTpJKxzUIQ93QgHDK03JmPENNeubbiE1Uax6yKfwxdHIVXivA/a04uJrzbBGna0JLei
         yvbA==
X-Forwarded-Encrypted: i=1; AJvYcCVhNbHvY7fthGhQhqez/SuAn4/9WfgxMT458xuHwDd+5OgdwpgtLAYzy1SEh/G2FjJUSUUO7KRcgTdUXR++Vq0KPyVYiWCZ
X-Gm-Message-State: AOJu0Yy7PUbmqTNfQEhOxQYANI/w7B9IsAOGiYtuqAx4nG2rkDH61VUn
	e3QOuswP5NaHZnKs0/ALoyw1PKmPypRtuXsuA1pkLrSLA+ahNJjN9gxJC/uvPYU=
X-Google-Smtp-Source: AGHT+IFyjMfaXyrK9LA59QSbSw8r6Php6n8Y2T8MJkhVqT4P6/2sX2R8U9/bYlxkzkw95f3c9Gx4aA==
X-Received: by 2002:a17:90a:db82:b0:2c9:5cd0:bedc with SMTP id 98e67ed59e1d1-2cd2741d316mr2452653a91.15.1721629704989;
        Sun, 21 Jul 2024 23:28:24 -0700 (PDT)
Received: from [192.168.1.13] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb773411a4sm7224360a91.26.2024.07.21.23.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 23:28:24 -0700 (PDT)
Message-ID: <900054ae-be78-4d5e-aa5a-cb3ad91599e5@davidwei.uk>
Date: Sun, 21 Jul 2024 23:28:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] bonding: Remove support for use_carrier
Content-Language: en-GB
To: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org
Cc: Andy Gospodarek <andy@greyhouse.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>
References: <2730097.1721581672@famine>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <2730097.1721581672@famine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-21 10:07, Jay Vosburgh wrote:
> 	Remove the implementation of use_carrier, the link monitoring
> method that utilizes ethtool or ioctl to determine the link state of an
> interface in a bond.  The ability to set or query the use_carrier option
> remains, but bonding now always behaves as if use_carrier=1, which
> relies on netif_carrier_ok() to determine the link state of interfaces.
> 
> 	To avoid acquiring RTNL many times per second, bonding inspects
> link state under RCU, but not under RTNL.  However, ethtool
> implementations in drivers may sleep, and therefore this strategy is
> unsuitable for use with calls into driver ethtool functions.
> 
> 	The use_carrier option was introduced in 2003, to provide
> backwards compatibility for network device drivers that did not support
> the then-new netif_carrier_ok/on/off system.  Device drivers are now
> expected to support netif_carrier_*, and the use_carrier backwards
> compatibility logic is no longer necessary.
> 
> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid/
> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>
> 
> ---
> 
> 	I've done some sniff testing and this seems to behave as
> expected, except that writing 0 to the sysfs use_carrier fails.  Netlink
> permits setting use_carrier to any value but always returns 1; sysfs and
> netlink should behave consistently.

Net-next is closed until 28 July. Please resubmit then.

