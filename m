Return-Path: <netdev+bounces-243672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB51CA54F3
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 21:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF6C7317869A
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 20:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E2135E525;
	Thu,  4 Dec 2025 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N62e52w7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783F35CBCD
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878855; cv=none; b=nb4+ES+HQaDG/JNey77zpGQwGcbzW2NH4TaRHUQfglET9vfh4UbHys3//C2qiUVWiOcjVRBSoj+zuq4uwSyZ2d3lh78Gq6Qn/cpbRbgnS5NUsuys/NZLdxyp1QyyCOJO3GiCfiK/bcSHWzkTtpH9uFwWrmJs41Cr8ffM8BSYSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878855; c=relaxed/simple;
	bh=t9dWGhzFN9RsOEfXcG7dxUErpgknpFW7IobkU4qVlBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHTvXg6Vy1C+CaM1cUKyPIbFha8tvtgERP2CcBKFcsyUganVLYzxWH813l4AVRAo4f2HcIEyFsXVcUUlO3L78CNiOURiw3fFKPoxA1d9y+ez1dN8Ue2AvA8sgrLLZcc1QLIL/xslITb8RbuOcDs5fNquYyHKGk3g+vivgNs2Ga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N62e52w7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29ba9249e9dso18502585ad.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 12:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764878854; x=1765483654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwQDJvoYGc3nz2GzVMDge8eRjx46D+CfeX3mSjr8SeE=;
        b=N62e52w7nqEmdnMJG6OiIt5p9OqhHolPDi1no5b7NSSIJdFmcjWdzSnitjS07UCRPw
         SA+9nHA6jhM7THjX5+ErqQLZ0vdhFQnR8wSMrytxY9OVe8K0p8vH5qW3pYgdsSFcPnry
         wnTIcNPwX5IJkJtbZh5KNkRt/tl1NaX1bVRoJihIlnM7FsuQ4CMCEwWA76N0rOUmT1ma
         99xeZVXzEU1yuaaPYbjxbMH457PXUVHIA89Y5i1U8S8a4lDN3vPDKqvCErVXcck27NEM
         ZfDMuID7PauRhnq2oj3FxtPG9bnitXYF2fFL2W4GMljLxhtbfkFICWhDPse2zpnhL+k+
         CaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878854; x=1765483654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vwQDJvoYGc3nz2GzVMDge8eRjx46D+CfeX3mSjr8SeE=;
        b=UhPpBZMdBa9Ex5bhgb8RnOrLpYTD9Yb0WrNrwzUfGV0EJ2sFH10UyvMSnFOgq+A3PF
         3+i3e3vY4zSocKoeIJbpsPhlsPqJ79S2QbJhckRC5vHGagK17xZZnPzJCUYQuE6Bj7PV
         ACs0AHRsMZhOU/SOBcEhotsdCtr4iqN0yiWH05JSDMA6/+kcrW7sRUI+NMzgHw/Oi2WV
         k9W1IS03W641DY27miHglProWG/pwA2843lbyrXtasbDEbRZDTMve8h75Wk7nTOmwYBi
         JmXHvycYquAfidUEVIn/vGttQsSbxQ1+cZGJhAtXm8utoq2sLViKkr++phZCa3tNIUnj
         I0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXAePgy4y5OMUfdIL89L1+wT0i5X9n8YoU46m7epH9AeO58cbvA/RSZo8UTM+QAtK6N2ngWXLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeqO2oZrokKPtBcUwzaF1p8ptXcTJxbcothmdUXBND0A4NDEvH
	8Nye+EvsyEjXE7NsOjcTBInqOWDu/Av2QO9mQqKSpAg9UhpHiN/k31da
X-Gm-Gg: ASbGnctSXryJ+2TMh1h860H5KW2hC8nGeYLkTj33hc7pK5ZDE7a/2gGRhRIxKdZTE3R
	ENam5ies3EVtCb3+Z/Ajc15KgCMxKi7TQsjNz09NYALSET9cebhCAfc2vmNnLhCw8NRcf/hXWgA
	qoolFvgv7sjR2eFFdhEPfh73qN4PtVO7BcgzqSuK8XHv3Y2OQKJKzdcvrWnpU8/ltAI86C0Wa+9
	NACqNX2vKccqxaqXX9N9CXjDg2DXYNKLE3ouWfYMn+poFsy2Cgv5/YnSjw4FWVSa7GfPDKB/+Nd
	s7PnQbSWKEYZjq+uFKg9TF3dozG6CnoBEZs/m4qX94fsjLaS9cvlGHB0PeumHGFUelDr96dZ8Ys
	/2TkZSRRyQxJdQyfILyFO+4YPuLaZ/lMckdIQZJAfYOGRQNrIn3e0/crXqoLqoTbPRITaSe5EFa
	yx9kpEOLSW5ok2n3D07yD2gx0=
X-Google-Smtp-Source: AGHT+IG9RhYAdYFpkikbhLyKLRnmTqvWGyuDRO7QxR1lVaPfukVM+lNdimabKudFcB5i2SDvSqWrXw==
X-Received: by 2002:a17:902:e807:b0:299:d5a5:3f7b with SMTP id d9443c01a7336-29d684764b1mr90997395ad.53.1764878853433;
        Thu, 04 Dec 2025 12:07:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f006sm27567195ad.50.2025.12.04.12.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:07:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 12:07:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, wine-devel@winehq.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 00/13] selftests: Fix problems seen when building with
 -Werror
Message-ID: <0b4dd065-4f96-48e8-a44c-24d891c68a68@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204082754.66daa1c3@kernel.org>
 <536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>
 <202512041201.EBE3BF03F5@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202512041201.EBE3BF03F5@keescook>

On Thu, Dec 04, 2025 at 12:03:29PM -0800, Kees Cook wrote:
> On Thu, Dec 04, 2025 at 09:16:16AM -0800, Guenter Roeck wrote:
> > On Thu, Dec 04, 2025 at 08:27:54AM -0800, Jakub Kicinski wrote:
> > > On Thu,  4 Dec 2025 08:17:14 -0800 Guenter Roeck wrote:
> > > > This series fixes build errors observed when trying to build selftests
> > > > with -Werror.
> > > 
> > > If your intention is to make -Werror the default please stop.
> > > Defaulting WERROR to enabled is one of the silliest things we have done
> > > in recent past.
> > > 
> > 
> > No, that is not the idea, and not the intention.
> > 
> > The Google infrastructure builds the kernel, including selftests, with
> > -Werror enabled. This triggers a number of build errors when trying to
> > build selftests with the 6.18 kernel. That means I have three options:
> > 1) Disable -Werror in selftest builds and accept that some real problems
> >    will slip through. Not really a good option, and not acceptable.
> > 2) Fix the problems in the upstream kernel and backport.
> 
> The series fixes build warnings that appear regardless of -Werror,
> yes? That on its face is an improvement, so maybe just adjust the
> Subject/changelogs?
> 
Yes, I'll do that.

Thanks,
Guenter

