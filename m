Return-Path: <netdev+bounces-142980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B4A9C0D58
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B605EB221B7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37D221731D;
	Thu,  7 Nov 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz7aNxOS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59893217310;
	Thu,  7 Nov 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002053; cv=none; b=f2ttkHo1JtWV0JgKT1ZHpif1H51KWtffoc9I4+v107jdwWhfoCwLtwug/YmwDx6BvnMW7q9TzGVZcikwTd/Cbn3wWMDRWjswHXNnvFXvKNrzkgYFR0+XNtMPwmZYZKcn+s7g9ahrhHU9kSGcG8Ooq5D47xz8yft6L2qaJ63Mk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002053; c=relaxed/simple;
	bh=fK+IXeDAZs8TzhVYEtb8gUv4ycDhO2FdpNpJv3cJBBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPJEM3AZSELOCrVIIKP0zkHvFmfeB0aFT46AWG5R+4dP4fXSVeFvQBJ9iuuSz1JRB/pZjgLXpsfWZSInTm+CwjVrOgVH4pYAoSboJSt0kEVHPqiS3XXGS2Gj7hsu5jfN/1Bp7VYbKOst5W8l9xqwIJ4VRc47tZTPV5yf5si1abA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz7aNxOS; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71809fe188cso743013a34.0;
        Thu, 07 Nov 2024 09:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731002051; x=1731606851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IMXXbzX/ngEOrXlpSpu4Xani728oKkuAIfb3cs+OThU=;
        b=bz7aNxOSQxgm0HOkfLUSxP+OnDLvc5dTzEu6zMUJj2PMSwPOtj48/ViMxTenDOwlDL
         1DsZKjKPnJd/OJ7YCd1eTr+kxaBoSL3xK0nEV+AveyOWAdi/SEAY/Q+6Ly43CpSYrBZl
         rL2ha7HrZ8iSP7VhAQ+P0X3gNR6/yXDS3TWvMbgA/9teR+28W6oTLKhUUH67eQQMPA+e
         Md58DRr+H6fA82tRIUc7lfMUPkEELmZesJCLdDDikb3BSOPhMYf0Wea+ziWwRtQ1KIud
         4J3VLAyC0yKuiacu27TnP/MI1sNJ63S21cQ+M5pyYsVeqzj5YE0DAgQxWLQiWdwnf5el
         zssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731002051; x=1731606851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMXXbzX/ngEOrXlpSpu4Xani728oKkuAIfb3cs+OThU=;
        b=N2Ux1WkjWtOenURa8HQ7x6cQRNwv1zSiOUOrfVfzgOB2gnNslvb1u8cQlSc/fXIKsm
         Grj40iBv6ZCMcNCjv+72Y7MFB3UeqyZSl3n/RNsYPvnfgqffSIyflxNUEOVY46m0q9io
         7XPx/6MBpPPpbpL+KLQKvSsa06QoP5TmavTVXSZFv7lZVuYI+vaaTSuMElu7vBKEF3F3
         eQrH3D3O3l0m4f/arRQic/uyVBOdqfxsS/32lMY/REROkJVqtr0dWtMsR/O/MGctyNhu
         B14KBygnb9I9vLVT0fe7ExwVth1TPdQLT/WWVyLrV6/FBJWMAQ6iunHeBMbYMkloB9/Z
         UKkg==
X-Forwarded-Encrypted: i=1; AJvYcCUoXcN8g96LATLlj0TLF5Ff5+heTGX0BGO7YrJPq+1urJrN3Gx+CYbevb2VnUFsYZRe9QMHFbso@vger.kernel.org, AJvYcCVPZ+r63jmb3w/zylN9S2M2jMYLLyxZSFK19bFJL5GJ2wxAcSJWKWVHXiS3rbu4YpBv4dJwvoWxGaGMkuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYPCCNRMfqgHsIOlerRAcGT6G3qiYUEQ/FqkHRotJIMDeixBlK
	44Jwz7Amv9gC4IWKdAlbsc/CNnekczfNxdD9xFOWaQKV172MZF4k
X-Google-Smtp-Source: AGHT+IHUaby3ekpiBk0MqL38wJNS3HxAKjFKkS+Z7fITxx11LELPRNGVP6twkqT8l1QJorHtDi64xw==
X-Received: by 2002:a05:6830:6f07:b0:718:10ce:c6a7 with SMTP id 46e09a7af769-71a19bfc3f8mr947180a34.30.1731002051307;
        Thu, 07 Nov 2024 09:54:11 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a1080ecccsm352876a34.18.2024.11.07.09.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:54:10 -0800 (PST)
Date: Thu, 7 Nov 2024 09:54:08 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 1/2] ptp: add control over HW timestamp latch
 point
Message-ID: <Zyz-wPkx7IokVl_J@hoboy.vegasvil.org>
References: <20241106010756.1588973-1-arkadiusz.kubalewski@intel.com>
 <20241106010756.1588973-2-arkadiusz.kubalewski@intel.com>
 <20241105180457.01c54f15@kernel.org>
 <MN2PR11MB466441745C8C1D64835C51739B5C2@MN2PR11MB4664.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR11MB466441745C8C1D64835C51739B5C2@MN2PR11MB4664.namprd11.prod.outlook.com>

On Thu, Nov 07, 2024 at 09:01:41AM +0000, Kubalewski, Arkadiusz wrote:
> >From: Jakub Kicinski <kuba@kernel.org>
> >Sent: Wednesday, November 6, 2024 3:05 AM
> >Richard has the final say but IMO packet timestamping config does not
> >belong to the PHC, rather ndo_hwtstamp_set.

Right, PHC means the hardware clock.  That is distinct from the time
stamping settings.  These belong to the network device, and are
contolled by using the SIOCSHWTSTAMP ioctl.

> Ok, thank you for feedback.
> 
> Richard do you agree with Kuba?

IMO, setting the time stamp point should be with an ioctl in a way
similar way to SIOCSHWTSTAMP.

Thanks,
Richard

