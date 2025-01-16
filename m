Return-Path: <netdev+bounces-158827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 739E2A136B6
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54171885F70
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF871D86D6;
	Thu, 16 Jan 2025 09:36:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C0B1D63E8
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020161; cv=none; b=jsvzrbur26L7Q63jCzIEt0++RZBkwsvU8KYmy5c094tSpWhysdh+dKaayMH25N7nE23PTXh/O1q1dl3iJs/L6XAfkBYBL7oQufbCV7q2J0hSSNhwtArjY7SxDuBySOZGfP6MF2V7fvLWN/Zs9jAgWEDPSn/2aceHLCAMdiDTSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020161; c=relaxed/simple;
	bh=qNCrKkINH3eN8H0PdAAPZDPDSrVWUy/f5GPyB19BZmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8n6NTKC5ByOh3j2ZhjjTg5QdVkD3pmEqgdU3Mx6vTpYvFm1tMbhyhGgWMjHTZ8cpXBUWHGwroJyET+rn8tVHxSJVx3461p01vRoBdbJ3hyUPSmL6uBgJ0eZ6eXsI19Q5ZmzeWMj3uSvXa33UPWcBok3z6E97/BFc6lSW5AsaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaedd529ba1so114923766b.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 01:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737020158; x=1737624958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZw6tEH8ZaJV6zFkhXU9f3b/ffuWvIQ/M+PHpA7VL7s=;
        b=MvQzAFNravC3+jQNBNLaWuVH/ON89nAuajp4v9sIeaGe/cr0NDcLjUkC4j5j0El/oD
         iumsY0GvTpghJRl/j1wZLMtkAHEZiUtJC6lxsw3zh5zIcunqRqtYZjqa5j+BP0dMvUdl
         Vhdq5FnqTMOeVoe7d41/DFWlXLzlohNo/Dh8ztMX2zrFOoc16sECBB/TcyUPZmUBCZsF
         ryaNZXyIuhESufNLtIcsmcRwfOW8BsNKTQRn5fMGRdEyUVzS1plcdSKUBIoqORKdrrAz
         iCQpAXEzJOjpgbEEdaExksDzuSPdwHxGwVSgFXaSuyp22/PbKP3sitmawHKotE9/Ydde
         h8yA==
X-Forwarded-Encrypted: i=1; AJvYcCWWVHXXUkfVK3PR4npBewtcxwz8nDgscB82nIn3GPa9IMpmtK3Tp7ZY8u8t2LWHozgx966ao+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuAJsgKtAP8Z15WbnkdNpnZw2W4zqjp7dvZ/GccvWhTn1XxAvM
	bbPU4IHrsk4T2QvbVQPZBSLCwSVHFeC57WprfrgY65zlc0R+GDueLrogFA==
X-Gm-Gg: ASbGncvxu7RYCdWsefRJJEYF3wHvEzm6UUOBOeHwQecveK/s8OiEID4ANlL+e8GA9Ls
	HG5oMbvAX21ueaLZN8mb2PmqjJ++jXzVqswp2TZBN2motCVn1QGBLaRGJO3dlxFtCEE2BDe/qdJ
	eUPeSldUsmg66NcELBUXVNuIfbLC7KoUboQaBJmvUvs9nVS4d0STt7btOcT5ST2Csk1yYMAPv/K
	mEtYja9YL8S1YJ04jES2PIFDOqcPuPhxDW2iRBjtyxTyI4=
X-Google-Smtp-Source: AGHT+IFVPMOtw4kf6s6wse3Ocg01Zwg4InWz3KmGzO4AJAmV3tsR3Sd9pL6Mu+jlBDY5BDZY/a4Thg==
X-Received: by 2002:a05:6402:35ca:b0:5d0:d818:559d with SMTP id 4fb4d7f45d1cf-5d972e0b955mr633223a12.11.1737020158123;
        Thu, 16 Jan 2025 01:35:58 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9064070sm883891366b.37.2025.01.16.01.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 01:35:57 -0800 (PST)
Date: Thu, 16 Jan 2025 01:35:55 -0800
From: Breno Leitao <leitao@debian.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Herbert Xu <herbert@gondor.apana.org.au>, Tejun Heo <tj@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [linux-next:master] [rhashtable]  e1d3422c95:
 xfstests.generic.417.fail
Message-ID: <20250116-expert-stimulating-chicken-e1ef07@leitao>
References: <202501161047.39c960cb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501161047.39c960cb-lkp@intel.com>

On Thu, Jan 16, 2025 at 01:15:21PM +0800, kernel test robot wrote:
> 
> hi, Breno Leitao,
> 
> FYI. we noticed this commit is in linux-next/master. now we noticed some
> xfstests tests failed randomly while pass on parent.
> 
> xfstests.generic.417 seems have higher rate to fail.
> we also noticed a "Corruption of in-memory data" while running this case.

Thanks for the report. This is a real issue and there is a fix under
review now:

https://lore.kernel.org/all/Z4XWx5X0doetOJni@gondor.apana.org.au/


--breno

