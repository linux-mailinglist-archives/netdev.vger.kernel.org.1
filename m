Return-Path: <netdev+bounces-174907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD24A6136D
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 15:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC65716B7B7
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BEB200BA1;
	Fri, 14 Mar 2025 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBo66oLu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE31FF7C1
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961628; cv=none; b=FvSHQ0Rd0gj+wzcZ6tFv2DxnZwWj3ao8nJ8mhSe9Zs6ESb5dV2roLt/jfr+SCPbiCfkQA2LiDkICopl6R/nycxX9WY5Hd0FL25gNOX4J7pSzOcK9BuGw93LxIQzk0plxVxcCmXOpwdMSeZPBW5xryeLXTJRWcaWbLUcOggg3T+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961628; c=relaxed/simple;
	bh=mk2+2k1ELJwBCRIZGkoyTA/79KQbp3fpLYK5mnZjnG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyfLdNn2HUDVwZtxC5zgyOyNT89U1pl6jfZWW7rKNwGP00XNrRUl2eJRPOkCwq3VrXlJMzgTvFRGQIbjkyxaH0zHFS/3veYn9CyMmRtddKTAkGYrBR8obT95m3UlUJXyZZgQAUtBOfyNewUst2BrC1K7cWhlj6ZBK/aAeqDmNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LBo66oLu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0782d787so20237515e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741961625; x=1742566425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYq3c7KhKNqSHmEVEZ28/KTuD9FZ4JaaVkED/xu2RAg=;
        b=LBo66oLuyI3Ds2gncRJfrF+MxcEXFvqE2VV+kBbXtuS+LLyc+bxsCewaRctVsJ1WCz
         1VSuY5JeKoale7svGUKEs9aeJiLFPJe3qJDrWEGOjrAG/L974Y4yGJpAAiStx5SAxh5m
         SWXEBBYG5abVt47xCMlhLsMfRMWvbKxojlKF67GdVshsGuNdbhXfz3tdGhS+uYRQvCjq
         Z7NQqK7XzfeOJHOzhgTXqq/NipAoJdVoW4sMG+gw43ZrfoneIlzMuD54WS0HYvzMD5eO
         dAqJdS4AuVulfIKZhiliwn+ygV8NWKMAyUE+0EWEl0AXUmteFrwJSDv3jyt2rNLgvU9J
         RguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961625; x=1742566425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYq3c7KhKNqSHmEVEZ28/KTuD9FZ4JaaVkED/xu2RAg=;
        b=SnVWvJH46l0rh4VfnDHkyQ8fM7zfocOv677K/qLYFcmwNWaHLTKGMhov0SEkqJJ2EU
         1YAcAyjIdCBrStQVkJOitG9OuYVOlKsTBjY1ASJ/UpwGYMf4IxX8b873De2PH679uRPm
         sYpu/AnQ2cyFv8G4FlPLtvBypPfWC/PEfTyIKK3KR2NoAmC+ISYwWFN8k282UNs/OvUc
         i3f7Fp6HCXLgv6RhhYhWcxFtuI4y63+8qB0bnSwT9dRC7SZ41s+y9GyIiQqiBHbRvoZD
         ttwQAF9vPVLc4rPOgwZ0iDFw1/XsR1axtQgxkgC5cjvmjVJgIw2V4/kJzYRbhQCwN6sS
         5NsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXduEsDt9DSQxEL+Rj5hybgk+CY7Ub6prmkIHKiK0YWMB7/1RlACp7vNyU3csfgiQYRPGaf8xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC1BQGts9e90piKzfPlnvwv5UGWSDQth7JoGI+ap7LkxSKn/lt
	n/5bzubguYC3lw2QQKQg8o9y//1nlMcaUD8vQXraEK0mFGkl6kevsqrhX2s96xw=
X-Gm-Gg: ASbGncv/B8GYoPkBlVfM/hwfsj1yIFBfX1CMIIpuZOu88TmdeI2IVDY7j6Tst7AP/eD
	N8v13HjmK+CDSNewALA81L/NoFPFKDD/0VQyC103E2VkwDoWMHWcQA6C8Pka/fZCpLmsWNcqfV8
	ZscrW89qfgRi8cBsA60c0JZd3MQOojNbJY0qnofqlAdFBbTnz9iAV33OCTVG9PehuA1Z4d9rEGZ
	5vpW3dIl3qZROx8kczGSmyAeGP0O1dWx2EC0dTmeSIaHpimjqHhXzYE14Cy7wgLx+9HWuq4MOfy
	alnCZSAvmlq6do8QYvQBgAY3UxAh9C7uSKmxK4sFUEA6KjjlSA==
X-Google-Smtp-Source: AGHT+IGEX2/cQG90IizVxN/vlEX3UnjfxUF4nKsr5qwiAh5H4NrKs4XpNUQPzVrswwefuWQFlHcfAg==
X-Received: by 2002:a7b:c5d4:0:b0:43d:22d9:4b8e with SMTP id 5b1f17b1804b1-43d22d94bb6mr16830105e9.10.1741961625010;
        Fri, 14 Mar 2025 07:13:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb3189absm5773887f8f.71.2025.03.14.07.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:13:44 -0700 (PDT)
Date: Fri, 14 Mar 2025 17:13:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pierre@stackhpc.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
	christophe.leroy@csgroup.eu, arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2 0/3] fix xa_alloc_cyclic() return checks
Message-ID: <1bf42e57-e2d3-465a-9b5f-da219e23f825@stanley.mountain>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
 <c2d160cd-b128-47ea-be0c-9775aa6ea0cc@stanley.mountain>
 <122bc3a2-2150-4661-8d08-2082e0e7a9d7@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <122bc3a2-2150-4661-8d08-2082e0e7a9d7@intel.com>

On Fri, Mar 14, 2025 at 01:52:58PM +0100, Przemek Kitszel wrote:
> On 3/14/25 11:23, Dan Carpenter wrote:
> > On Wed, Mar 12, 2025 at 10:52:48AM +0100, Michal Swiatkowski wrote:
> > > Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
> > > from xa_alloc_cyclic() in scheduler code [1]. The same is done in few
> > > other places.
> > > 
> > > v1 --> v2: [2]
> > >   * add fixes tags
> > >   * fix also the same usage in dpll and phy
> > > 
> > > [1] https://lore.kernel.org/netdev/20250213223610.320278-1-pierre@stackhpc.com/
> > > [2] https://lore.kernel.org/netdev/20250214132453.4108-1-michal.swiatkowski@linux.intel.com/
> > > 
> > > Michal Swiatkowski (3):
> > >    devlink: fix xa_alloc_cyclic() error handling
> > >    dpll: fix xa_alloc_cyclic() error handling
> > >    phy: fix xa_alloc_cyclic() error handling
> > 
> > Maybe there should be a wrapper around xa_alloc_cyclic() for people who
> > don't care about the 1 return?
> 
> What about changing init flags instead, and add a new one for this
> purpose?, say:
> XA_FLAGS_ALLOC_RET0

Right now I have a static checker rule for passing 1 to ERR_PTR().
It's not specific to this function but it catches the bugs here.  If we
added a XA_FLAGS_ALLOC_RET0 then I'd have to silence the checker rule for
xa_alloc_cyclic().

I was also thinking about creating another more specific rule for just this
function to warn about when callers which treat 1 and negative error
codes the same, but that wouldn't be possible.

On the other hand, people who pass XA_FLAGS_ALLOC_RET0 probably will
understand what it means and not introduce bugs so static analysis becomes
less important in that case.

regards,
dan carpenter


