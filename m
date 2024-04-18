Return-Path: <netdev+bounces-89090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C84E8A96BE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E6D2849F0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D415B125;
	Thu, 18 Apr 2024 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIRjq8E8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE715B10E
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433998; cv=none; b=HBJInHA/gUaZelUEPiN8EiE8/pZEFq/AoB8xH69/aaSQGYb1w85+W2uVtNGZw2n3sLVbLKgYdV6jmnpDlp8CoX4hIi4RMYJSDRlbkiO/NTdA0AA3kxcgiG5d7dnvaLzM0yp7jwohmUGa7DS4UK+aIZmpijZFIsDVXB1SU6MTKjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433998; c=relaxed/simple;
	bh=IK8lThdqMCRKXRz9XShqHKqosaImCaFR4AHVL2cUI1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0iNwG6tvT6fmF1ZpK2NpquGy3xcHds4g6ZKgY0mNldbr460D/+MuXbAE4wvPRtzfQj6GcVNxJWz58p+3l3YYNeqZ6iL4lr3BFUO0v3NDisNKKqsRK54BTHXokM1cQDL+g2r5h54e4SAhAXL10YeM0PAFmd/ijSgr+jUijgR2AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIRjq8E8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516ef30b16eso750089e87.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713433995; x=1714038795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=icJ55vHdhanFHkhy6XLbPlsv5UwxrCBLamHQvXnmHjg=;
        b=QIRjq8E8sex1ZWu6tvOZ6+UzTjKth7/ZDRjB34AfEJM3wRiZl/MVwsSFKKXwh12NRe
         yzDdNR9o/Uoqo804um3T+hf06uNH2/nk5w9uhEwahb3aeahldeRbSDFZ7JozaWiAu/s5
         6QpD3DAFQS3nUwZt4y5X/1vxMwDXG9ps0sNrA3Qt+abGa+0qytD0fCuXQbr4ULzlaJjo
         aZ6CozFc4QqubBgs7p42O5A8SzH9Re95poTZQc/kqcZIxG5UmUWH/OmHMcGn6+OzjPX7
         aFp5fdjllnQZfc5KqEUmOzrPn09Xd3wiVVwj+3ZmleGX9tX1WsfDrxFJsQBfXs/OTdeV
         xZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433995; x=1714038795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icJ55vHdhanFHkhy6XLbPlsv5UwxrCBLamHQvXnmHjg=;
        b=LvKaEzWTSwnHRYfn5vFF1zMW7CCHMD/CXuzHf/LauMvn20p9ZGCUknNSujIpMy69kc
         Z5YPDzZzbvGCSKf7YrQUQinaQ89QItxP+IGdASOMqBNYCUJv3BEYj7OLad/TnBSPscg4
         R4lp6EkA44pUxJ4J+E9Pg/4V9fY4l9gDq892jGCXrqEueWrosPL79hOJkJxOwP/MiT3r
         8sBtxrDDeCoQzV0iNTmbjM4oW2nfGknzl+48LKIOrbfVmf3ZwyTWCsxniFVtlWMXWjF8
         tPznzlxLIjqMwFJdfc/zioGCGjcWmrhfF9LeRtXVRTQGyr3OpgqvTAKkT4ahBVUKUkPh
         KYQA==
X-Forwarded-Encrypted: i=1; AJvYcCUb8iup4i22kJ3fS+GP+NKC21feYDiX4sp1Lp3Obs80v9x98x3sGDjGgZpTflVR4ALctvT2hf4az+0Uu0ScxSeHK3THShhz
X-Gm-Message-State: AOJu0YxS5WBp5ItUoutUKOIDEsQivGn8biXLogfqHvYW4tgG1dw2wASX
	olwG6pQaoMnixJlrvuWSMg7QsT0XPLjcsSMhyVmz1PFVhdgemdKz
X-Google-Smtp-Source: AGHT+IEiIcgCeMEZKK3DnTrPmPzhD6r4FiSyYfqos77mHhafdih3NxBOHEE0jnrr5PAmoEqR6y/Cfg==
X-Received: by 2002:a19:5e0e:0:b0:519:b963:6591 with SMTP id s14-20020a195e0e000000b00519b9636591mr259719lfb.23.1713433994368;
        Thu, 18 Apr 2024 02:53:14 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id m22-20020a195216000000b005159d671616sm172373lfb.134.2024.04.18.02.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 02:53:14 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:53:12 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v11 1/6] net: stmmac: Move all PHYLINK MAC
 capabilities initializations to MAC-specific setup methods
Message-ID: <nfv3ejamjpi5zv7uzbxhqhce4myceicauoh5okjkxd3zpcewvg@ogkpkjh6detv>
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <df31e8bcf74b3b4ddb7ddf5a1c371390f16a2ad5.1712917541.git.siyanteng@loongson.cn>
 <zrrrivvodf7ovikm4lb7gcmkkff3umujjcrjfdlk5aglfnc6nf@vi7k5b4qjsv4>
 <83b0af5c-6906-44b5-b4fa-d7ed8fccaae4@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83b0af5c-6906-44b5-b4fa-d7ed8fccaae4@loongson.cn>

On Thu, Apr 18, 2024 at 01:02:28PM +0800, Yanteng Si wrote:
> 
> 在 2024/4/13 02:32, Serge Semin 写道:
> > Just submitted the series with this patch being properly split up and
> > described:
> > https://lore.kernel.org/netdev/20240412180340.7965-1-fancer.lancer@gmail.com/
> > 
> > You can drop this patch, copy my patchset into your repo and rebase
> > your series onto it. Thus for the time being, until my series is
> > reviewed and merged in, you'll be able to continue with your patchset
> > developments/reviews, but submitting only your portion of the patches.
> > 
> > Alternatively my series could be just merged into yours as a set of
> > the preparation patches, for instance, after it's fully reviewed.
> 
> Okay, I've seen your patch. I'll drop it.

The series has been partly merged in:
https://lore.kernel.org/netdev/20240412180340.7965-1-fancer.lancer@gmail.com/
You can pick the first three patches up into your repo to rebase your
work onto.

Two leftover patches I've just resubmitted:
https://lore.kernel.org/netdev/20240417140013.12575-1-fancer.lancer@gmail.com/

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 

