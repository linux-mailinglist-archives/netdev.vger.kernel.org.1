Return-Path: <netdev+bounces-226112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A6EB9C5AE
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AED1B228C1
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 22:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AFC291864;
	Wed, 24 Sep 2025 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFlQdmEP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E32566DD
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752824; cv=none; b=RWWu0NCP7jwuiGIKHoMkCMg2NrAIzvQCTIrLgu1VYu+KP/5BcVABAFQLhFBLwpGvw/PneX633wks8GlRlipuRutQ4zCscjdSkEBPeUAoW91x47OcTufCWonZ9l7YyZWfy+A/nesYJQ/gT58QoQA9jJPh/+6DvI6U9+86c18iwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752824; c=relaxed/simple;
	bh=VBgnju5e4OGNDrwtbMk9Nb6KcJuq+2o3nUneOsF+4fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUpc6hBP9NOo5IkLuWXDGIswCC1xqt2lUtCPoHZcnBjwar5/5YKuP02PHtDTwiaGSDFdK8vbGGf9hV6aJKzkF25rhLMToYt/SJlEnrmQ9pPvpZMpyEUOtFCP2wuxFU2ZYTio1GmBUiyUotZbXf2fH9QdPLetv06NT/6u/LucX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFlQdmEP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46b303f755aso2354615e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 15:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758752821; x=1759357621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAAiZ98FjXDGSsUxI+RC9o7W9RElQFrnGJPJA6Tg5jI=;
        b=FFlQdmEP3zBA0Ig3cLBs7dzAnj+LRMDffmWFS9e+1++lQOQ8gaQ/JmInO4DYdvMdWF
         l75JBo+adWKZGyG3yeU0iPBcknHBorfn+QB+xrt3JQkArTFB3LTaKZ/+9A00tLHlF2Dt
         uEaaga4oiwyA/S+QerDBQyfNMm85MTD1LAeR6m/rkD3Fy4oG8aGrfvSAHCqMNSVX3Mxk
         fWC253OvXLA2RwVW7/wYfXdNDgf1Iup5Om4QSEs+hNPkJMBxFk2Z2l3vsVLLHYyHkOSB
         KqBKr4dbDSVdHaHH605UiEmx5IZ2JUqwdJBDnsleQI6jQWdLE+jpUFV6FHyNrY43o595
         Gnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758752821; x=1759357621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAAiZ98FjXDGSsUxI+RC9o7W9RElQFrnGJPJA6Tg5jI=;
        b=R+0V5ccunTk5QP0I+iPt7CbNw2XzygG+8CLpszQK1KS6bMJPaEM7nSjeu6A0HKVb4p
         vWHgjsMz9UPxcBW3aAmkaFKEwa3jVA9ZedRFxIf2HV9RnKrsWgmtlDYubTHFQHLo0lRL
         on5iSTCD5YnE918elhO4wT/6qUTFjXXvqWxFEbURZweODzrx0+2olIYH/S2ypSsRWNIb
         wE5ls5L6t9sB8QnD14gHrtkoLdzzFiUPl2ab0xsO1JEtYSpJbiouJ1KzPGXjY/lOEDEf
         vdSfeVeb/yPj8O2vWa74NUz+X+fgaL3kTjsRpNg8gIhDqNoRvAhnFDyZA8ksT7X+1xPz
         4Uhg==
X-Forwarded-Encrypted: i=1; AJvYcCW4C5D4cc8C3jlo5UeBZQzFcG2DAPwNVXWOCRgEyoSlHjCZM7CXStnfANxCypQ2IhHmwE8tjXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/NBf2UhA3eQAivVKyPMj7xw8YnygcNuYeZi+q32Il4c7aJ0JC
	95Qk7APJo68YtR0KMHxhavA4qdc8VAzzbNODL9y27La6gT9rW7eS0HoV
X-Gm-Gg: ASbGncsc9YI+HlSoUYBTbKy9M6Ljrm2m2TjWsS5bFrYFzYxV9KHaqoXfjqSioxL4KV2
	YwjMoOx8lInBNSCEeZSo/bDsHnUOLF7pd8AN+IAX7kDGFv4XAsEyiLd74DaEzcBEBXnqAFVspL5
	B+GvMzQJd+yt/mGeazQYvNnujIbFhm/go5Cg3sImmHnaQrkw9DgHC3OOHqT1/REh2LPyviVDRXK
	4amOeJswloCYElAp25sCGiiroQ/bew5h9+lRzdaSSqCUBv6D9V7KDaROso5WoB2pSDgPl4HfkaH
	Z3fY7uJ90UFT/u5CuwUMFiY7M8X0i4JawiXJECjd/gk8fgC5h2dVbtRgcB20/VB7svOEatQuqy8
	3ii/DYvMMRqOUIqbPiG4=
X-Google-Smtp-Source: AGHT+IG6jyPPpkk8a3aExxGzaFJF8Lv9aP1QB30cWerzfjmW8E0fi6FRCuWa4wt/CAF/bg53qAh34g==
X-Received: by 2002:a05:600c:4187:b0:45b:6b57:5308 with SMTP id 5b1f17b1804b1-46e329a82efmr8699815e9.7.1758752820646;
        Wed, 24 Sep 2025 15:27:00 -0700 (PDT)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33be21casm2735405e9.2.2025.09.24.15.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:26:59 -0700 (PDT)
Date: Wed, 24 Sep 2025 23:26:58 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <dafma6drqvct4wlzcujoysnvjnk6c4ptib4tdtuqt73fcuc5op@efjjn5ajqwts>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>
 <4evp3lo4rg7lh2qs6gunocnk5xlx6iayruhb6eoolmah6qu3fp@bwwr3sf5tnno>
 <aukchuzsfvztulvy4ibpfsw7srpbqm635e24azpcvnlgpmqxjm@e4mm3xoyvnu7>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aukchuzsfvztulvy4ibpfsw7srpbqm635e24azpcvnlgpmqxjm@e4mm3xoyvnu7>

Hi Breno,

On Wed, Sep 24, 2025 at 01:26:16AM -0700, Breno Leitao wrote:
> The other option is to always populate the mac during netpoll setup and
> then always resume based on mac. This seems a more precise resume.
>
> In this case, if the device goes to DEACTIVATED, then np.dev_mac will be
> populated, and you only compare it to check if you want to resume it.

This sounds good to me. I've done some initial testing patching __netpoll_setup
to always set np->dev_mac, changing maybe_resume_target to simply compare the
mac as you suggested and seems like this approach works. 

I'll do more testing and analysis to see if I see any issue with the approach. 
If all goes well, I can include these changes in v3. I'll report back in case I
find any problems.

