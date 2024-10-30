Return-Path: <netdev+bounces-140212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AB79B58C9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647CBB2245F
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3643F19BA6;
	Wed, 30 Oct 2024 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6etfMYn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C36F126C0A;
	Wed, 30 Oct 2024 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249026; cv=none; b=bYJ6cM4Iek8gw8oXdns04kFv5fgK0/349ZFrZKFHvlRgbbCHdmU5m5rj5o6N8/I5MDUyUFUa7so4rtJ8HwK4kYtVtvW2ktZxJxIMSyIh765iQ84VdEoCGJAS/RETbD+u5D1HsW4fj9DfHvnvHsiK7+dLHVD3hx4UpshZfBQtSrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249026; c=relaxed/simple;
	bh=C6t5uYegxs7DG1qcLIM1YBlq/XLkFEwd87XZ8LbJPkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuKlp0/ljTlGFw8W2wyhCvY+PNBM9C0PGvCPBEzP1knRYlJu3UsLX2qIZ1Zdlk4eedobdouESbsfycv2RFKw2jjtw7d3xSJTdAYULXAuM4fnZahBIeFwvwMpRVsaanLX9/ia2cqmfZT8nuSIEFJyRBeD97pdeLEAuI1fDpGTc0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6etfMYn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c693b68f5so66124255ad.1;
        Tue, 29 Oct 2024 17:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730249023; x=1730853823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZ3S2WcB+zGxiJngz5Z329XPyYJE8uVordKNgTGUhwk=;
        b=m6etfMYnPPm7u9MVseekWgEWKCESXM/5O2ksm2nckfJL9o8TVXE9plwKbRyHLWL0R1
         /xOZA+xBGNETvB9QmVcZnLVDvrVmTWNbQt4CMnaPHlrKTJATmJJHJaQN2/qSna3H8zXn
         FiiXIhfhtTHII7kluelUTz22tmwjQK+Zt1WZuvMha78QICoLxeaZsCVcCOFQlEdRgcKN
         rchzlfvq9nKLN51YF+L2MR7LNePacyYsDIc85+syHcKgIk5Msht3GlF7T1c7PsUJPXoz
         LQY+XyGnX2p/ezZXIDOElqzgBc5xe88ow9JaFEpFQVOwVFxCZypttNYFNQUKfkB4BuF6
         77OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730249023; x=1730853823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ3S2WcB+zGxiJngz5Z329XPyYJE8uVordKNgTGUhwk=;
        b=rx3tczFR4gfOC0/xsq6Fps1ccWYpsQvNLzgq2bittRVECGAXD0sY4iyPW91GAmxnzd
         DT/nUnzzbSamjbtCr/xY58zR/t7rGCNp9VM39UyznJTYxXJNovKac+B+n9iHPLNGGVC9
         l87k13g5/kCoAp518Mmp+tMAQdkeNBPs8Sora17Km0lpGj86TJeJuCHJ/aFcdjRCx+mm
         723yl1KaQLpvHnsLtvd+IBXmqtUj9SlyiRJhMsl3w7H+XUMHs79mPu4TpKeduzT9xZU+
         B/mQpajBlUuCXNYZzhql48wZFwNmqyFIWko0rLZdOc4SeX2oAsVkF9G7utIhebIlSnhp
         juDA==
X-Forwarded-Encrypted: i=1; AJvYcCUCVz2w4QgRMrsiCuocsqOVmZN3t8FGNup5SeoAzVJZRJRMj6T+gEm1FaDii0f5G9e8agDNl+wPpESbEaGf@vger.kernel.org, AJvYcCVUrll3+lnxtPmPo/TfQOEsXeCl7PoW4lCZ5t5e0EMlNMMPudvlYthSOiTmr8F/Y8vAjL2lyo1TnANz@vger.kernel.org, AJvYcCW5rLFpUHZoRA+9q9wUj//8Wm2LaieAe9R+3POZSb/WSrF8DXxRD2NIW2ifrUy2NuO/COv3k80e@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFbfbsZp2lbKYdfZswpM0thMJVrx9w79mX356KmNiVffyp3a5
	2GM7oLx8FjfSZt4O0fXJM1Q9kh2SAUnupnCq2na3P/GKWkMj4jBG
X-Google-Smtp-Source: AGHT+IHHRyGyDkKcNwaxMn/2+7uQYnlMNqSGQQ6CzP4zXPjfAAfmUzV8DyN0d/uv99tZavi9Wq36BA==
X-Received: by 2002:a17:902:d2d2:b0:20b:6d71:4140 with SMTP id d9443c01a7336-210c6c7354cmr156629705ad.44.1730249023405;
        Tue, 29 Oct 2024 17:43:43 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02eee6sm72101525ad.219.2024.10.29.17.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:43:43 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:43:16 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: net: Add support for Sophgo SG2044
 dwmac
Message-ID: <kg4fvjertilaekjwuwxiojy25qsrwrmc3pxnpu35awg7klmlmw@3aar5yqe3olc>
References: <20241025011000.244350-1-inochiama@gmail.com>
 <20241025011000.244350-3-inochiama@gmail.com>
 <4avwff7m4puralnaoh6pat62nzpovre2usqkmp3q4r4bk5ujjf@j3jzr4p74v4a>
 <mwlbdxw7yh5cqqi5mnbhelf4ihqihup4zkzppkxm7ggsb5itbb@mcbyevoat76d>
 <8eeb1f7c-3198-45ac-be9a-c3d4e5174f1f@kernel.org>
 <gcur4pgotkwp6nd557ftkvlzh5xv3shxvvl3ofictlie2hlxua@f4zxljrgzvke>
 <e134b98f-5a57-4a37-b46b-8b4017f050a6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e134b98f-5a57-4a37-b46b-8b4017f050a6@kernel.org>

On Tue, Oct 29, 2024 at 02:27:20PM +0100, Krzysztof Kozlowski wrote:
> On 28/10/2024 08:16, Inochi Amaoto wrote:
> > On Mon, Oct 28, 2024 at 08:06:25AM +0100, Krzysztof Kozlowski wrote:
> >> On 28/10/2024 00:32, Inochi Amaoto wrote:
> >>> On Sun, Oct 27, 2024 at 09:38:00PM +0100, Krzysztof Kozlowski wrote:
> >>>> On Fri, Oct 25, 2024 at 09:09:58AM +0800, Inochi Amaoto wrote:
> >>>>> The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
> >>>>> with some extra clock.
> >>>>>
> >>>>> Add necessary compatible string for this device.
> >>>>>
> >>>>> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> >>>>> ---
> >>>>
> >>>> This should be squashed with a corrected previous patch 
> >>>
> >>> Good, I will.
> >>>
> >>>> (why do you need to select snps,dwmac-5.30a?), 
> >>>
> >>> The is because the driver use the fallback versioned compatible 
> >>> string to set up some common arguments. (This is what the patch
> >>
> >> Nope. Driver never relies on schema doing select. That's just incorrect.
> >>
> > 
> > Yeah, I make a mistake on understanding you. For me, I just followed
> > what others do. But there is a comment before this select.
> > 
> > """
> > Select every compatible, including the deprecated ones. This way, we
> > will be able to report a warning when we have that compatible, since
> > we will validate the node thanks to the select, but won't report it
> > as a valid value in the compatible property description
> > """
> > 
> > By reading this, I think there may be some historical reason? Maybe
> > someone can explain this.
> 
> I think this is left-over from older times before all specific
> compatibles were added here and in their bindings. This binding has been
> waiting for some cleanup for a while now, so this is fine.
> 
> I still think the patches should be merged, though.
> 
> Best regards,
> Krzysztof
> 

Thanks, I will squash this patch in the next version

Regards,
Inochi

