Return-Path: <netdev+bounces-118977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73386953C5F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFB11F255AD
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B553D1420DD;
	Thu, 15 Aug 2024 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRek2K+q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4028A7BB15
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756124; cv=none; b=Dm0tBzQUhH2xRL7wKRO9DsP1yCfhnfVmnW7PJsVo9D/pdx1aT2NxdeSyJwysCuI1x0wk6+f3s1lUdcwJoi0SLs1+STN9AON69HyACfOFSS1ap8LjbQsuLqiq/XXJo3rQA+gsPUrvnk+FH5UeKqEqeacoiRkhZuO9kvvFhiwWgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756124; c=relaxed/simple;
	bh=GR0FP0Lbj7Bn+lqzD4mL5WXT/EhT9LYrDsw9dyf2o3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXD97HYPf99C4XavANY5J3WesRNZaQ55A17LiiNYxdxw7LAmU9QoSeR+vnakYJW8/OpljPlCYnW7pA4+fyYNt40uAZWAJ1hHpp3IlTs3EYASkalIe5ubT3HMzZ14+/11cSPGM7TdA+Cr2JMQlKmWvcZtie/o7Omk4+238U0E2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRek2K+q; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-26110765976so205867fac.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723756122; x=1724360922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GR0FP0Lbj7Bn+lqzD4mL5WXT/EhT9LYrDsw9dyf2o3M=;
        b=hRek2K+qtsfPVu0Kp+wN0lBPr6DFi8LOJO161v5qF2BEQ+iJM2Agd2zU9mm3bg8iup
         hvKDsFj0g+QucRwYq99KiIvY3k/ygexYTnj8OCZ92NLnQYMZ54cXwKhCR0p9CHWzy5fg
         t4grI97bcHaDzbRSX26KnjR1CBUMKYSYmnonB/VhDN/8zRzaku0Fm0yYLIvQuw0vjx1p
         supwi6MQHfcUbWiedxyQSyqe5PN9A95Ae2q3i6J6+wcW6BcUdoqwAXxisvpRjICOP8r8
         65nxdrmOR8fDN/+Ujy1fMdhbuCjgHVHFQevSwDPn/FptIJMB+32ksAKA4jVmmLZaBi09
         ypgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723756122; x=1724360922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR0FP0Lbj7Bn+lqzD4mL5WXT/EhT9LYrDsw9dyf2o3M=;
        b=Zs+fse9JhYXW6+R6EqnxoAaz1SnzONl/7DWCkuvgSXXEz5kbNpcz+Gr8mIwimnrOxG
         +R/sIVOSiYxyVid3a4TgKCxAb8qhhd+ZQJkAJxLwTruy9RtGvZmd3vCKrpPhGBw4WOW8
         TZaGtX2Ptpk5L5xzYgzkL+sFsuBv5wyGP2ZsxKvW6nwAPLf7kgBHfRgy2TrntHbwvxTr
         zc/LigE1ZKgRGfAl+jeFxXzlLkVioHeA1d6BI/Q2fzsaI6ksR2rEIzF1GtKY3l7xzjfX
         vb/Lgfx64Bbm/4UIc+ey5qA85e0DdSw4HNt60pFLN9r1RHDv+mPOH6BxIit3ALfLz4fI
         3lnw==
X-Forwarded-Encrypted: i=1; AJvYcCUZsJd1T/AjldjjeD7he2ZT8k+jQICm8zxq9Lhcu43oyUYDTXHF3AontKoIP15RAWEur7HsiG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFbHw5w8L6bFJ1U9Ue3BVXKJFoNmeSoKxBn9VaRaAdiOtSQ+Qq
	bQLtqOrJjBNJmG48AG4DEQgSMVLWwdJg6gu0JMKIqDISy1VBx+g5
X-Google-Smtp-Source: AGHT+IGmZjhZbSQ+q5XVcFgpEhPE2vK7gfm1Yg6kZOkQW66+OhPJGAyqFrkyWa4jvKDdX1Eyx7Rb3A==
X-Received: by 2002:a05:6870:7b4b:b0:25e:14d9:da27 with SMTP id 586e51a60fabf-2701c0a0273mr578198fac.0.1723756122292;
        Thu, 15 Aug 2024 14:08:42 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-270049f6ae3sm544363fac.48.2024.08.15.14.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:08:41 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:08:39 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <Zr5uV8uLYRQo5qfX@hoboy.vegasvil.org>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
 <166cb090-8dab-46a9-90a0-ff51553ef483@machnikowski.net>
 <Zr17vLsheLjXKm3Y@hoboy.vegasvil.org>
 <1ed179d2-cedc-40d3-95ea-70c80ef25d91@machnikowski.net>
 <21ce3aec-7fd0-4901-bdb0-d782637510d1@lunn.ch>
 <e148e28d-e0d2-4465-962d-7b09a7477910@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e148e28d-e0d2-4465-962d-7b09a7477910@machnikowski.net>

On Thu, Aug 15, 2024 at 05:00:24PM +0200, Maciek Machnikowski wrote:

> Think about a Time Card
> (https://opencomputeproject.github.io/Time-Appliance-Project/docs/time-card/introduction).

No, I won't think about that!

You need to present the technical details in the form of patches.

Hand-wavey hints don't cut it.

Thanks,
Richard

