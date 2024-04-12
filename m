Return-Path: <netdev+bounces-87477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A258A33EF
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 18:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B594D284DFC
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E904148853;
	Fri, 12 Apr 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="K7Q7bh+l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB784A35
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939893; cv=none; b=tWDoPJOEWpgEmCj65Ifk6FWRvajSJk2YaPvao8m0vCp+3+P4yp0O7km2fYMIA40LP5aMOEXMQT/ID0cvghaRKfn7Cv1ZxSA27CZEvqw13Zq1ZZuhXW+SzyH3W+skfA6LigQIA599TU6kSspnxIAdB8HGt22OOfnI3yx1Xy7awoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939893; c=relaxed/simple;
	bh=G9XqW+QycbHyCPm0+NFx5lKZ7k3ZNa1BZPp4vXYgWAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ukan+Zh8bvfW2FaS0l53Ja9ihQMEFwo/gTiE3aTSvttda1J5cqM/A9buC1e1n3VtAo/L3U1kDrFQ251ZRFYEBPPWaRTaejfmlndYgbfuUJjUkopa4Ta5aKw8UUksJ+Jt3EhU8bTVb//Eta4VoYeor+eBDi4+75pK0ljjcNGgo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=K7Q7bh+l; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so975719b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1712939890; x=1713544690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKvTpczOdj42CzNl9HXPWDiwW2dLEU1dD71hAVWX+aM=;
        b=K7Q7bh+lFvXdxd+avMt5YpRj8WwD30YvjBKJiLiLg6iHO4vbeQjZxurAvzZ79RJDh4
         Y6GeleIb8y8vPzUp/wOPtUxeglAvsIHuMQCsaoEmz/ksrqJct8fCx1xWlXy8DRSP9/50
         WULXn+F24BXIoWH0WOVUrh9YV6ZJDsd1dL14k6AErwpv6SFsLCzj7Duz5p2DjBn64b3p
         vFGTo2Ke2H8tZAVz+oogyqdXVeHS3zwMi+T/V3eUoDCuuSFXVaJTQzmA7CNZj2/6Na1W
         upcuWyPfvcxenmo7VAa38JtAh5irA53VViRRNroCI7T70k0BCTqkysZO4WLruWmSyLDX
         azOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712939890; x=1713544690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKvTpczOdj42CzNl9HXPWDiwW2dLEU1dD71hAVWX+aM=;
        b=TI92OL7J6ihqTodtMj/bayii++1oS6Z9hh6D3QcsbYtAEnYiD3G8VOWn9l4Wkybr5k
         iQvWfOlYAyKMvlkzZ0NOgU7PCbFYMGre7QAdXIv6raZhypKKuf5FPU7UKN1jVeo5y+bK
         9e0+u6vUL6DT08aKROiFlfb8RoKMNjHZZM+il8/KE/1LI3BI+uvbeJUdNjAjVix333Ds
         nO99osVDS87cL+kJRM+D58bVtBj2BjHcSZsVH+CPE5Jd8xzQh1HaLOYTKaCKkO9VSotn
         b2AJy5OMF6Y0Vp8DEVd32YMiS+WFQe8gYD5UHWReVsLq3VePCNiqlwXpbnevhJH7HdS3
         AOEA==
X-Forwarded-Encrypted: i=1; AJvYcCVsszqcV2Ys6rkotQOrT4rzuN8NI2ttzshjR9jjbaNWtXe1c98o7Nu6TJFFvNubm9MBBnej9pbeV2pRwC8bKZKA+sbbLSNC
X-Gm-Message-State: AOJu0YwzxQ+YVPM59X2i3gKXiCnXk5NIbLvNPV1jqXASWZJD0bRRi6Qt
	+9h0ixbG1TlFsvNRPJubar/lsWn+EjFWHwukZjP6RUFjKzaPqrsP9eEY1Th1wrPJNRGhXsGarC2
	V
X-Google-Smtp-Source: AGHT+IESh9CiEG0VDMRw3t2vYtf07plsJFSnpnmSOtII22LhTmjTLuwrTeHpB7psRixR/HTgC/mnaA==
X-Received: by 2002:a05:6a20:2445:b0:1a7:9cf6:3285 with SMTP id t5-20020a056a20244500b001a79cf63285mr4275399pzc.50.1712939890494;
        Fri, 12 Apr 2024 09:38:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ge7-20020a056a00838700b006e567c81d14sm3047527pfb.43.2024.04.12.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 09:38:10 -0700 (PDT)
Date: Fri, 12 Apr 2024 09:38:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: constify net_class
Message-ID: <20240412093800.4d2521eb@hermes.local>
In-Reply-To: <1d59986e-8ac0-4b9c-9006-ad1f41784a08@gmail.com>
References: <1d59986e-8ac0-4b9c-9006-ad1f41784a08@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 12:17:57 +0200
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> AFAICS all users of net_class take a const struct class * argument.
> Therefore fully constify net_class.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

PS: net_class_attr can be const as well?

