Return-Path: <netdev+bounces-228411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D05BBC9FD6
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 18:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A742B1A63EBA
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FDA2E8E11;
	Thu,  9 Oct 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miU5UIJT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353D2206AC
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025422; cv=none; b=SbPW+HFt+d8Je0zvEPYK01CQ0IPcREFAwEF1SlMYXoJEI0Zc4J4m05XqsZOVrs7ANU+x24rBPUtGAVJ4BNrpkFq4ZEM/AqovU3ysaft6UylgSoxERLak/TbdR7nPVLWaGGyQCYE6rJE5vle9Zab4iqUDyoQ6DxKkEKWqDd5z6xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025422; c=relaxed/simple;
	bh=fEPjMABZJqK2RV7aPLAwmCyreoCKrgnuKQ175KZEw7s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=SiXLH6QNiIGZYauDv85jFt3r/GhaABmXHudQoTVk7R8SppTdagZOWb5jSjYyZVOtv8LyH/TUCylmHj1eJTCz1i0WzAWxEwYGDrSxhZZUkpXdIn1d/v6WNvvNGXLWidwDfUfFjaBzwYdG5Nmerx+ugmkLq2mtnVapLlbiwyjQCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miU5UIJT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so746382a12.3
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025419; x=1760630219; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgo3KudljITGQSuGvHmW5cffvohs9TZ6aTPtPKYUDQo=;
        b=miU5UIJTb62u6fi7DEk4gYEdJb68gKcH2l3HvT/cV2qBeAo4YdBA8byWePEXY8N7Ev
         pure7uVMLefE7qeO5MxlENEEN6SxD6V+XDmrICyoplzgWcfOLAFssCMTI1OYFQl1fWft
         p8dBPIX2cTW0y+vcYqD4tAfNMg6qyOPx1k+fxjL18nELU7c6G2UxWTAoJmS74noFo+Oa
         Swgllip9u8wXjuPN6ygj1r89rHyAZww1ZCyv1I5zNh3i3aOy7EGoxfPTbtaD+ba206Cg
         CfprQxYExXoDRBQEY+4G/mvNE793vZvbo2tzMjVol0WO8AM/1my9aitoti6vx6pgDIwH
         RAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025419; x=1760630219;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qgo3KudljITGQSuGvHmW5cffvohs9TZ6aTPtPKYUDQo=;
        b=rFJf78TPgG7EnP+Ug+C36HTiGm1JvvK+Ic4nqLDsAy0ySi4Gsppb4VPQdoIlR7Bhwg
         VQNTn7SJFIU7M+4V3pNN5D5SrOwi6IFm2fZKSSC9OBAw1XvwRkDpx0KunhchPWkvef7X
         wsOQdDQ3LrifQwcbP5BG9DgOfbC+uTbPmqNMQ6jqAChvByHHoFxaWNKJaZvGeX3cd7Pu
         n/q/GQe/QNp5iOOSMAWvXHCSp0Gxf2Nt6QIwYM259gYkptVCfeRNNphJ0MKgV7yYEd4d
         /6c5K+VqYhT7BV4ZS0uyADvo2dcYPzt/B/KF3nj6rwngWftYNPhu9wrdC9lUD00AMMLw
         OAFw==
X-Forwarded-Encrypted: i=1; AJvYcCUJp6pi/iQofn8xZxv9IqH1+vRkX31A3HCLwBLwSa2QK2hPTwXDig5IkC2/rpWbTAg8Lo6Qfqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwhOaFTj804koUKiGuhACzB5GeLiygHNY9Ky8TBQ5jw37Zmme8
	AqWSWWIGfMx5epHCJgK+L5uRKBoUyL1Tmoan9BNFANvCFIJDheZR9j8W
X-Gm-Gg: ASbGncsKC7Jeaplvjmj+nol3sX9y0Gl832+Ni9RpCEaeymtbKXHlQ37yW5vpS/4nz8M
	NzlQdkJviskB8zsLGVENtDKzLBpfyRMENYXcMg2eOSRdkSBbxhQY47Z9YmGC/decFtzZOAkP8B/
	LKjFnHk3IZ0fWLrtHDQTXgxl41RPz1/XDtCc8qaCicMgZ6sl4wzWU+LrniHt8SIN6tTBgzYNei6
	igFtCTBZ5PB8TrP4bbi4dxoPazkYyTNKeT+3rQ1uh/W0gEruzco3lgn1htsPwprFDJPLyUR9afR
	iKHxCxUsbeK2aLd9hfp4BlQI6TPWICUuJJAuj/KnQZjulpoQaAdWD//dlykSVInjeqMs2+RGpGu
	ELMv+v11TSQyCdz9IXMkv4M1GQnRmUmCqcMGVuLuWwLA=
X-Google-Smtp-Source: AGHT+IEFf2RnfqrbKgLS8ZhhKtvMKGc2UMdAzovJyGrgaoGsX6xngdyLDG8NWdEBK5j0gpEaPZA0hw==
X-Received: by 2002:a17:903:3c25:b0:26c:3e5d:43b6 with SMTP id d9443c01a7336-290273ef107mr101385425ad.32.1760025418779;
        Thu, 09 Oct 2025 08:56:58 -0700 (PDT)
Received: from localhost ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f0712fsm32711735ad.71.2025.10.09.08.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 08:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Oct 2025 00:56:55 +0900
Message-Id: <DDDWXTRCYVDA.33VBJ38T4QBXH@gmail.com>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
Subject: Re: [PATCH net] net: dlink: handle dma_map_single() failure
 properly
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20251002152638.1165-1-yyyynoom@gmail.com>
 <20251003094424.GF2878334@horms.kernel.org>
 <DDA4Y2GRUHD4.1DFHX01NOJYCB@gmail.com>
 <20251008091346.GO3060232@horms.kernel.org>
In-Reply-To: <20251008091346.GO3060232@horms.kernel.org>

> Sorry for the slow response, I've been ill for the past few days.
No worries. I hope you're feeling better now.
>
> I did also consider the option above. That is handling the
> errors in the loop. And I can see some merit in that approach,
> e.g. reduced scope of variables.
>
> But I think the more idiomatic approach is to handle them 'here'.
> That is, at the end of the function. So I would lean towards
> that option.
Not only with `goto`, but there are also issues such as replacing  `printk(=
)`
with `netdev_info()`. So for now, I'll send the patch that fix `alloc_list(=
)`
correctly.

