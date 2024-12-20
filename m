Return-Path: <netdev+bounces-153840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D569F9CDB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF24C188BE8F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B8C21C184;
	Fri, 20 Dec 2024 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQy9+6DL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732C1A3BAD
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734735280; cv=none; b=cnnoGugKzMS2F5AIWY/4c3eKvty5KAdX2MRlb07YPGixPYKqzP7lQ6M7z/aol1GYHZfanRZ0bMF5xF8tXovgAZOhAL2/69/RxUj7/9Rv342Xc2ozewfQEbwuTCU774ry43Q1zMC+i/3Qw/ATT5+duLx0watfE7jAVGKXs9KBK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734735280; c=relaxed/simple;
	bh=IjjvALVcqMuvIe6V0hliOkd6lmkSIgK5vtCxBwgz1Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJXYdXGsq6vbbN9LO3YkC399GUuVBOrpPviPB/OYrWI2HcceRh0fhZBX7Funn17JwfkiLmibMSFpR1Nkh5WoS2kz13elbmmZP55tRhhQQjC4s8Ui9G8NuOFqq371ki8vrTK1qg5H02c4bjJfsxivxB41sZk4tAjQx3qbx/OTp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQy9+6DL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43637977fa4so2116625e9.3
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 14:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734735277; x=1735340077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eDFiR0cfDkBroxJYCJFWsUbUK3M5Jdy38yY9Re3wBmc=;
        b=cQy9+6DL7U/wm0o7hiKjCXNW1MWQZkzzp6V9pk/AWadRPdnTMjOQZ8k2RLZ6lj5Rzy
         2MnvttJz2F07B3rwuKILIMsEC0pGF/MW/+aR6U7KAF6jQcnvkfWuYze3thKrf77UmWfT
         awyDZiN92DxmJxUeJW5EHfG+GCr1Q64h5ci4vbe3bzDY04HPxocQKVTSSrgxFobnMP+7
         gzw33KdCj51cnNUCCK3hbC9855s/RR8NaJHpbeKZBQpd3CR5D0l0sHIS+CVwyTo97EAs
         lvH9LwQ+/vIwkyc4zMEiLRl3KwMRmEFYfaiEpY++KNj5jOZxDPCVaKtWAiCKkku79PSg
         QPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734735277; x=1735340077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDFiR0cfDkBroxJYCJFWsUbUK3M5Jdy38yY9Re3wBmc=;
        b=T4f/e3kBi+EQPWuyh49xqC1uSDMsAdx5QibXCfCvVPhovti96F8qnCnj42b21QiZFQ
         dVNhLi10YtZY0/jNBdkcFd6V8OtsHFUFiTVyZ+rmw4ZDNc1nK++DVAeVJyCfxIz7ve0x
         GDwLDvga7KQUImaMXwZmo8Yf4+uj9VRkhMUik0MciUYp9MYKP1vSIQePafLePlbMnoJx
         rjEoHby1505uEHcSSosYYEsVHidGIpQwqImyHaFR1b+DmzkR9t0Ju+2lCt2CVv3nE95p
         wdSL3ZXWPskfAgW/nHXk9AVJTE2wcJR35tCjjyXUltZzstlpMJZhTjCDN7Z3IhKN01w+
         LEdw==
X-Gm-Message-State: AOJu0Yy1YICbrZ7YO2tBBIUco+M5hIRj2bU1+3Rh7FdHC/a2Oj1nH5+e
	HAfhcu6zrWnIHYQ5Yg4zSwPQcClH+083AJgvLeGpReuSmiBwsRWC
X-Gm-Gg: ASbGncu4mi2Bv1TiiLeDxdXqD5OsgXXUMYygUX8h3RkHOmrfaT6Ys9ecZcI6Yi7dMhG
	/MgnYIV9cIewFIpEMNoBNyX7+Y2nWSLzN6tR+pk+AfFnCJUYsnuUPjlOj9jgVoiEJORVcapBcdn
	bHF3y8huj3/jXUROHpR95pamLFZV0vxp37s/+bzg7Fp4AcHezD4HAk3ybw27Wzl8GJiZZM5CN9d
	Qml/qwrpTnrJkIH4gtN/vuYxj3OO4sVlRBN+njJ4KFX
X-Google-Smtp-Source: AGHT+IHYVKSjVA5vs9ods3+EYfXfkE2aLwdrwpT2bmx9iamJlMNTwnGRRPszPuQVsHnLaek4JzWOyA==
X-Received: by 2002:a05:600c:34d2:b0:434:9cb7:7321 with SMTP id 5b1f17b1804b1-436685472c8mr17264745e9.1.1734735276757;
        Fri, 20 Dec 2024 14:54:36 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm57246455e9.24.2024.12.20.14.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 14:54:35 -0800 (PST)
Date: Sat, 21 Dec 2024 00:54:32 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luke Howard Bentata <lukeh@padl.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Kieran Tyrrell <kieran@sienda.com>,
	Max Hunter <max@huntershome.org>
Subject: Re: net: dsa: mv88e6xxx architecture
Message-ID: <20241220225432.jsgw35gq3ejp57va@skbuf>
References: <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <20241220121010.kkvmb2z2dooef5it@skbuf>
 <7E1DC313-33DE-4AA8-AD52-56316C07ABC4@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7E1DC313-33DE-4AA8-AD52-56316C07ABC4@padl.com>

On Sat, Dec 21, 2024 at 08:43:50AM +1100, Luke Howard Bentata wrote:
> Hi Vladimir,
> 
> > I think we need an AVB primer. What identifies an AVB stream? Should the
> > kernel have a database of them? What actions need to be taken for AVB
> > streams different than for best effort traffic? Is it about scheduling
> > priority, or about resource reservations, or? Does the custom behavior
> > pertain only to AVB streams or is it a more widely useful mechanism?
> 
> The catch is what to do with frames that share a priority with an AVB
> class but are not negotiated by SRP. These frames could crowd out
> frames from AVB streams. Marvell’s solution is a flag in the ATU which
> indicates that the DA was added by SRP.

Can you please state in a vendor-agnostic way what does the switch do
with that information, how does it treat those streams specially?

