Return-Path: <netdev+bounces-191022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C8EAB9B3C
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2514A04F01
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE98238C24;
	Fri, 16 May 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlkxVyry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D123A578
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395562; cv=none; b=Hlu09eih1sWmQU2Dx+NxHBt0xgaG+KS/dXRBCDv8/EJE0bemKcut2lcyfQ2CsH/kjR2BC1rs+7GerIh5+pY1RlNHQiU7OyCSTb57WG8ZSGj7MbYzoc8LjAP+GNzn6xC7/XBJ4geeof59KTPKOMaamwjniXBztYGvjd+CYb+lVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395562; c=relaxed/simple;
	bh=mrZhxwTes/zr2255+4FScEP89XdzPfhAYu5tn/yMR6A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=VlzyuQxiXYcp/5pv40XEGvoE2DJZ0f3LPJnvpbjH64o4HYJpEgegingC2p0izn304xQnnXD4uzLaFR/SM7W5xTMJEyBMQczy1zPG2hJ4PZHMuZKpsYR/SVvsE5fTj1kID2EtCBt2y1kyLO1aimooyfY5lYrFTzHP7SyXy8uTXoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlkxVyry; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf680d351so18315375e9.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747395558; x=1748000358; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+3sTOxwG+tkC52XmiVm/dlJT8ZqhvYaNjexp4f6Ve0=;
        b=WlkxVyryLqRIzYt3hfTE9mJf3Yw3mLLmlCYZfyFinYrdJZceZJMXeg0Trpxt67jI1z
         N5GO+ELA5u3HEjpmvnI9s7t23XeKPVS5uX2ZbWU4njCQ2mWadD2xmysIoXOlmpbHljBl
         hFHqRUOAyZ7VoyqA18Fpfh7eJ2tzxVo1kpihLwLsgPER84BYLTpppPuJjiNr0Qi6Or4K
         lRFOUPbtUmxpgM+/9l4ckitZArMSvbO7y19VCjFndAestanEDVzDAvEDeVYNvBaWQVhY
         J20wTUCEbsyE/9q2DWoTNKgKDR3sEHC2zcsf4sIV4zNuI6oemlX6DS+q4nqLzn7FWVu+
         0/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747395558; x=1748000358;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+3sTOxwG+tkC52XmiVm/dlJT8ZqhvYaNjexp4f6Ve0=;
        b=nUob5UASf2ZQouo3jaeteNb0kbJMBeMm0mIiNudDdnHwXlvVVJljpNszlw3LBHIm8r
         pmqTG2FR7VDVrv2vZNDxL9JhUFR7rNzVQ9o2g/Q2bhUj8oM3ynAUd8e4A1NjEGAsHMOF
         Q9oa6f6BJCGmqJB9PRIrFbIlpILovKtSePCyCCFiLxuFaNhxc28VW8st9R0aoij13LiU
         nrHkhWpUIvfleZyIzOVWY97TpzBFNdgfvbCF/T9bBS1c8ma6HvDpFOlT5dKb+nYwZ5SR
         YpMtTaS3kizlG7xKtqp8Ghe2DnEBO6JmrQqdwgh7WC+EYCv9Aq83ixV57WdmIA/enuXk
         2i1A==
X-Forwarded-Encrypted: i=1; AJvYcCUcD4B4d/QYStkwzFgQcPwqGKI1iNHItnW9fFIo67hknci9WFoZ12lMfL3pFqzxwiD2LadyQYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7OgIg6LGGl0uw3EDkQCwdGKZIVWc3UVLEYA/XFX+v0oLpI/QH
	gc4n+HRV0HVnhl6EDiGoQQV4antKYZPzuO7n5cRiRjuCzhTEJ+hNri4b
X-Gm-Gg: ASbGncuMoFA9EjxuFeTSThowMbSMnquvOnGLv/DaPeDyqzdcbd20Ghx4UctOZ1LBTI3
	dfKzx/HCkiUZDxRfv5cvYEoK7tz30JnfrwjQrLy7wYvtLrAFs29fLWjW5aGybWJJlbgL0ij8evE
	IHnNYCuHiHhpQVC3hMyCyeGwMML9zPlcipE8jEvVn1WQ/CqAEjUaYt7fAwMeZfm8Oz0YDXreiCi
	MDq2bW06BUtaQNo7+MClP7COwDqCpqWpgLM519toS07hGgwnehZQVZWly9iNxz9WyJR8AAkeXjd
	8P5YZfm87QH535DB8+6CRsqhbpyhz46C5NGei5STK+jKHH8nJkhsvPoPO5OgRNI4
X-Google-Smtp-Source: AGHT+IGXGuwm64KJXvu/vLoKOW0/YxzeyO8qm6f+kOO8ZiPVlAU3vUdxA56wd9ViOrG6Zse1cMfwgQ==
X-Received: by 2002:a05:600c:4506:b0:43d:fa5f:7d30 with SMTP id 5b1f17b1804b1-442fd9a2be1mr24077435e9.16.1747395557603;
        Fri, 16 May 2025 04:39:17 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:fc98:7863:72c2:6bab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ff81ade8sm18427405e9.21.2025.05.16.04.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 04:39:17 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  nicolas.dichtel@6wind.com,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 6/9] tools: ynl-gen: submsg: support parsing
 and rendering sub-messages
In-Reply-To: <20250515231650.1325372-7-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 15 May 2025 16:16:47 -0700")
Date: Fri, 16 May 2025 11:43:11 +0100
Message-ID: <m2plg8n8e8.fsf@gmail.com>
References: <20250515231650.1325372-1-kuba@kernel.org>
	<20250515231650.1325372-7-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Adjust parsing and rendering appropriately to make sub-messages work.
> Rendering is pretty trivial, as the submsg -> netlink conversion looks
> like rendering a nest in which only one attr was set. Only trick
> is that we use the enum value of the sub-message rather than the nest
> as the type, and effectively skip one layer of nesting. A real double
> nested struct would look like this:
>
>   [SELECTOR]
>   [SUBMSG]
>     [NEST]
>       [MSG1-ATTR]
>
> A submsg "is" the nest so by skipping I mean:
>
>   [SELECTOR]
>   [SUBMSG]
>     [MSG1-ATTR]
>
> There is no extra validation in YNL if caller has set the selector
> matching the submsg type (e.g. link type = "macvlan" but the nest
> attrs are set to carry "veth"). Let the kernel handle that.
>
> Parsing side is a little more specialized as we need to render and
> insert a new kind of function which switches between what to parse
> based on the selector. But code isn't too complicated.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

