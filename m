Return-Path: <netdev+bounces-180757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FD2A82557
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C20E4C5BE1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2252C264F8F;
	Wed,  9 Apr 2025 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGI45NR1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF3265613
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203086; cv=none; b=aJg7jXeOYhbw6Q9vG7WcFBbdUg1z9paJ4PHd6hG7hwkiAREvICjXhHaP4uW3Oe+/NA4oFMZIrBm/+1hnTRG4yt/XLyrRq1z6ykqgQ1EwvTFQH07qkxfzdGb3ZiRBrL9RSisD06p8V46CJm6kl6fUacCIqysiOi1yPh8mZywZOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203086; c=relaxed/simple;
	bh=lt8foCrNENTzlLGwzw3Ao8LQrCe9mCrRdH07Skz0aQ0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=J/P5TEH0xi8ZiCY1sPfmhAua3BAzVN/Tg6n1mSP2cIy8UjblsyJtgNoSToUAH2TLwvUJ8iLNaObNYzCfjr0F7MKMT4r41TrXswCZid2+HcuMA/w5HPw1j2r80n2f0nvVAGtWJaC3be78P5Sxfgsug5+ZBlZSEtvIcazU8pWuATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGI45NR1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edb40f357so39512185e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203083; x=1744807883; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9CuCBbmIrf30BOOKbrBsC5yCKhZWgZPYBMaGL3IajWg=;
        b=cGI45NR18K/6ZVWlcpdwX4Oc70k9ATMOXrQR03dQ5iJQgT7bI2B5O8mlvvycv3Kn5N
         nyo1X0VTqn83G6c2QPdiy666hfCt2CJ0I5Uou4mq7ewmj7WL2K+8C6gCCideRK6yK1mx
         spPkdWKjBOb3Iwphi9MazJzukTIv+/WXqoE+I56fM2ruIh6In90K9eZtRXXSDF8pcnJR
         P2ekn0qlsSdx9tMKJyHff38HNupyTIhKXcFxiBBZZYcVp7/DZ2sWB4AkmXQE27gIXh7l
         hZWVDgo5MVFbnFbRVztUTMP6qu6wmqvkA1TBhlbEG+/egZNorW9d3Mgq2gvIxcXjOUZ7
         l3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203083; x=1744807883;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CuCBbmIrf30BOOKbrBsC5yCKhZWgZPYBMaGL3IajWg=;
        b=THeYYkHoSmtXRadzeNwJiGGrCGuUO22kOyh4e9m8PuIa8c+47CUGvG2ySGGhLQJKXr
         I8UFANTLjMOWTQoJ7MyJdF9dKkDmAYIaSeVymihEdfXhehI4/HMdTrp67a0hMEp5xiVu
         7N/FzpSYIrUXnF0tWLuBvr54caUJFm1VvJv85VsGmFcEAwsrlW2WOa423sRzR7qLA+Ek
         8IAUg8mtcEriKiwjLEJzl0I7C017V+9eYvbd2JSw4rOPrO+4uH+q5UUFRBRgNRSGcREI
         qD+cEC4CjHJdBmsp0NWD4xo+iyxCJ8AyMiDPzqXmus1wYvLJFPX7vH3Zwe/FoCiJUidp
         hfrA==
X-Forwarded-Encrypted: i=1; AJvYcCU1gJihtPWTS54wwvKwVdY+5bFLNCdoWwPYGFrOnBsjr4cub18863Gtvz9m6CsxNQtrIab0M68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8hazSuM1l9of505HWpaTAzDsczOZyPsnuRoKOsyksS9oUN3GL
	fqVtWyokrIwNPSyNaU8k7rEXJjdADLjVxO7M8voQXSjDfU0fl5Kc
X-Gm-Gg: ASbGnctnSQ022sSxeeqjsambQZc2GiT6xnkRmZzQFRz1wInsKojHvohubGf65OQ+5tO
	091yPOcn/I3w22ORxLDUP2+uxPVXbhwT4mFnWQrog/WzbNF6pn/WrbhmQGDfKm86ugt2UWQJqu3
	V+TKAsE//zFYd+po1ZgRg5a3swwMD66kmxwrE3t7XEaFBDuF4G5IevWAhpISx/4scaLgcuFfLWJ
	Q6h6ucG4U0Xa8cKSvyP2Vd4svU4m5oaDj2XbVDg43F049X08hE8uhnqvQ8xceliOMbACdCS23Zl
	4f5F/C+8j4qynZ3ghj+iYFTJv9WIXUpJHz+bEIczb0k+JHY3XAXVtQ==
X-Google-Smtp-Source: AGHT+IFbt5IXLUulkQzj1Zy5O+hlqjZ5ZrsxRmwbeSjb6aPoz6U0fX0wbM0NLv2YiHN8LVkYQUXGVg==
X-Received: by 2002:a05:600c:3d9b:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-43f1eca7d70mr29282095e9.10.1744203082713;
        Wed, 09 Apr 2025 05:51:22 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2c7c:6d5e:c9f5:9db1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc8esm19045415e9.30.2025.04.09.05.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:22 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  yuyanghuang@google.com,  sdf@fomichev.me,
  gnault@redhat.com,  nicolas.dichtel@6wind.com,  petrm@nvidia.com
Subject: Re: [PATCH net-next 12/13] tools: ynl: generate code for rt-addr
 and add a sample
In-Reply-To: <20250409000400.492371-13-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 8 Apr 2025 17:03:59 -0700")
Date: Wed, 09 Apr 2025 13:50:29 +0100
Message-ID: <m2tt6x1otm.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-13-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> YNL C can now generate code for simple classic netlink families.
> Include rt-addr in the Makefile for generation and add a sample.
>
>   $ ./tools/net/ynl/samples/rt-addr
>               lo: 127.0.0.1
>        wlp0s20f3: 192.168.1.101
>               lo: ::
>        wlp0s20f3: fe80::6385:be6:746e:8116
>             vpn0: fe80::3597:d353:b5a7:66dd
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

