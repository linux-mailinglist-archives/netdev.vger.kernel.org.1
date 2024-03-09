Return-Path: <netdev+bounces-78978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B82877270
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 18:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82FE28204B
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2E21F951;
	Sat,  9 Mar 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="N+UqRr8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E0FC1F
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710004922; cv=none; b=QVczAkp8ahgxWF1tnO7lquc6YRmL1qy4M20H+0NXwHtvRLX7QS6loiVH3angv2oj2+stPUlgo5JhmOlEOqRoR4l4F0yGPfBcWG3txiK3/ynXs9hpughrLRac7MHzHMzL+1+rhTd3S2H9PZmEv92ihLv9R2nBC1C1wMo9QQ6cMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710004922; c=relaxed/simple;
	bh=2iKqjPi9/pvDuj+nC+nH4Q3036jozFugmn3vumt5LFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxBD+Og7FLGJQA4vxL5K3tLfId5WL8L6HVw1SmVFeiOCtsoCrv60F7AvZ8Ml8jV6W6yXRrFeUivbF1oX/UUAfRp0x5taDv+rYXaNewV8n93WOlB88mw69dCz9Z3JL17kQ/B2OVBWn+AH00E86xycNqjGztOUaX7i7PXUOR7f4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=N+UqRr8v; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3662e41370fso9927525ab.2
        for <netdev@vger.kernel.org>; Sat, 09 Mar 2024 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710004920; x=1710609720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILqFYsfHKHu04rlU2UARkf7qdQN18GXWGXI5rIL/RL0=;
        b=N+UqRr8vg/FeBVlP05ibP32KztsyXVbgTeZvRFLjU44ZdmoOxOXX6Qv84O7OjEUnHK
         kOfdKK901aBY0ViA/AhDdG0Pp1S7qqAiVxwwhGAcDPsazTT8AH3DU08vJ/9sSylKy5gu
         BRwaNjxdSRcdPU5wTTw67hLPpHjChxRgCVL4oANfpyJ3tJsinLbb3ZjULBsu8W2fTORh
         IlJg4WwkEbBiI/T/rtESgSrfYKcIFlFQ0a4nCUj4+XeNIN9JGvRhhqzILCpaKxwH8ziz
         6vXhDROdS9wNWf5unhKbuwGGUEoN59WmP2ZhgT4HAZ6bLZmEkhsHU03q1Zd18B+VUp+3
         YbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710004920; x=1710609720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILqFYsfHKHu04rlU2UARkf7qdQN18GXWGXI5rIL/RL0=;
        b=wLCiCar7KDkkZgJPfZSQ0nZl8Wp5t1KdJHgQO8KjGCQNsUsuV2AE9awznHRhtPKsho
         zRHRhZdA8g/ulHx19EMj4ZsAX6zsbSUQJWfIgNCHFdtOEQOQ0q6S18UFdJuRpFzmNFxV
         otj6rszMVMubSnD6GYphlmwGxme6+80DCcE3sCUGPvEF1dZTjmw/TkQszW25c9TGajPM
         dbN+cVJjQFlJztSrnhBhw8BRBvo+qzy3CZ9kDRpb6OBOARhAdkvt9xBiq/CeLhBfr83x
         thHs67SnB5iamZ/T7ReJqJ1uTmKvKEMGvqCpOxRn/Aa5tAUPUD55940g6Xn43gMiMhlV
         2xEA==
X-Forwarded-Encrypted: i=1; AJvYcCVBvTEh5NRHYGK+uJTeVgX9sGZrE7eCjcGToBtUK6UAMXpi//89oJC5gnLMmajJowN7FUf3pMm5UUiC0kuSBJR10x8wJxKD
X-Gm-Message-State: AOJu0YysfrECr7KugqHJQMzcmHJQ4m0P7Lt1YUD7cblfABHo0gxB6M7w
	Ql1gmSaDVSo1/3CoOebfUzHWuZneIKgz+Jlr8j0uBpUvKeBzLEsOCn0FCYtVhKg=
X-Google-Smtp-Source: AGHT+IFKfBoHberjmbwTmpfOyS1gGVEpyvzIbTrrq2UeY7/I7cucAPjaxbmoqlp1xPLoc+7V4JUwig==
X-Received: by 2002:a05:6e02:1748:b0:365:1555:9fe1 with SMTP id y8-20020a056e02174800b0036515559fe1mr3005288ill.1.1710004920230;
        Sat, 09 Mar 2024 09:22:00 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id x26-20020aa784da000000b006e04c3b3b5asm1511049pfn.175.2024.03.09.09.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 09:22:00 -0800 (PST)
Date: Sat, 9 Mar 2024 09:21:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@kernel.org>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 <mlxsw@nvidia.com>
Subject: Re: [PATCH iproute2-next 1/4] libnetlink: Add rta_getattr_uint()
Message-ID: <20240309092158.5a8191dc@hermes.local>
In-Reply-To: <20240308194334.52236cef@kernel.org>
References: <cover.1709934897.git.petrm@nvidia.com>
	<501f27b908eed65e94b569e88ee8a6396db71932.1709934897.git.petrm@nvidia.com>
	<20240308145859.6017bd7f@hermes.local>
	<20240308194334.52236cef@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 19:43:34 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 8 Mar 2024 14:58:59 -0800 Stephen Hemminger wrote:
> > > +static inline __u64 rta_getattr_uint(const struct rtattr *rta)
> > > +{
> > > +	if (RTA_PAYLOAD(rta) == sizeof(__u32))
> > > +		return rta_getattr_u32(rta);
> > > +	return rta_getattr_u64(rta);    
> > 
> > Don't understand the use case here.
> > The kernel always sends the same payload size for the same attribute.  
> 
> Please see commit 374d345d9b5e13380c in the kernel.

Ok, but maybe go further and handle u16 and u8

