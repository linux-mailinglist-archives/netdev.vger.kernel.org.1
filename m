Return-Path: <netdev+bounces-109505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F29289F7
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A5281A32
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A497152517;
	Fri,  5 Jul 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnKA0UsL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC961509A5
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186952; cv=none; b=kU57Bhq+tv/gRHjeJxzxcnBb05WKrkqh7lUu29fYeUWbCEmRq6Mu3oPAsceKV9uk7+NxvdNn4DeZaL4anlX0kCce4OkAshg4Slne9Bj1r5kDHWIE3+gR1dVkKhU7kD12WfJjuLZG6g9aQNync1oNC+BeNJ9j7JuGNjk0nxw6GKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186952; c=relaxed/simple;
	bh=xAiLtazfBXSZFhUCuJv5iLA8GUS2Erahe3O/6nbCjGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn27ZoeX89tl5J885NxkXuFtDMLoamuf1W/2DOKjpjEg/zf5/5K+atT0r1g1Y1SpGWPuQgMd4QyY6GAJcYlOP9qGxcsWpHGWDoqBvoWuubEwjQIyOWomqFpDhhCKh2xqez0Pbbqnti8Xcmk5SYgrrGLnp7jZI09riPBchZEYVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnKA0UsL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720186950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lNWQiXa5WTonO6VnFXHoZW4uvs/niJejriJYafDuJeE=;
	b=VnKA0UsLYl90AjSDr7XJmZ9VkigKSJw69UxouLefUJnuflxVj6PV+c7By2oD8sSva0wBRR
	1A0KG82DMOA2ekgIif8ZvEN8vahAMsW70BQZhVMd5VwJxsoOM6nIX0R5ooJkmY0A0XPpDq
	kjHwMCtk2hUfHtxLscmYUDo4sFXy2x8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-Qe_M726ZMUWbx7sotNy5WQ-1; Fri, 05 Jul 2024 09:42:25 -0400
X-MC-Unique: Qe_M726ZMUWbx7sotNy5WQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79efed0e796so25756185a.1
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 06:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720186945; x=1720791745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNWQiXa5WTonO6VnFXHoZW4uvs/niJejriJYafDuJeE=;
        b=AquAI6Jmk4BQgVMq6pfv0EDAdFBzVPLuTEuK863pnDsXnBspgZf0bsJMUyGqQWqDw3
         xFXpfdBjgXGbavdx3yvq6l2Y8tRpz12mCjhAyFNXavHA2rXhFC+6SUnlUZNY7a1U6Gee
         vYCmoBOm5YsfYiWOSHwmuohBvv1+1Mi34UDlPignvM3Ad30C+ISbKJjThrHUoHMNsQhF
         H5eJHOuWc1xmGqqBHTdHI8gKu1ixfLVHoWRVo10yKaFkVcWqWFM2fliskmP6aV0pnVBT
         hO1vxDDDDXZrylVqH8ixzxmkvcnaBZjLNght2hyfe4wi7TG85HWGTEDGntL4+hesylNx
         4rcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyEJQCf+IdXwA068C/7I5xmieE7HzfeSyg9tGzWnkbIYlRpSKS2rF9ccBma6grrewQhE1GlshbYaPd4V33+rje38gmxYFR
X-Gm-Message-State: AOJu0YwmpL063ePRhkJGAexNB1VEuwFS1KCNsCa1Nh6+NKep6dRKYhqo
	PjRfoTOJAVnZlJSpuhjUAkCGMb24Tgt3sZXcj3SeUAWiocFxG5o/6WFJ5Qqsamq+pCIn5VUKOsU
	uehPN7owipgy1uz7mOuASUFStSWy3tKoxrNvHwioizpBpGwz/P5Emhg==
X-Received: by 2002:a05:620a:13d2:b0:79d:7e5a:d044 with SMTP id af79cd13be357-79eef4c0f06mr737797285a.28.1720186944974;
        Fri, 05 Jul 2024 06:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzRoLCo4GeRRFCdesL0t0J6Xc2rhP3ZGCRDtPGGaxotQxYNzT1wzmgDzK5ccFskQ+43Nbdxg==
X-Received: by 2002:a05:620a:13d2:b0:79d:7e5a:d044 with SMTP id af79cd13be357-79eef4c0f06mr737789985a.28.1720186944583;
        Fri, 05 Jul 2024 06:42:24 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69299b81sm773174785a.71.2024.07.05.06.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:42:24 -0700 (PDT)
Date: Fri, 5 Jul 2024 08:42:19 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org, 
	konrad.dybcio@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	djakov@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	jassisinghbrar@gmail.com, herbert@gondor.apana.org.au, davem@davemloft.net, 
	manivannan.sadhasivam@linaro.org, will@kernel.org, joro@8bytes.org, conor@kernel.org, 
	tglx@linutronix.de, amitk@kernel.org, thara.gopinath@gmail.com, 
	linus.walleij@linaro.org, wim@linux-watchdog.org, linux@roeck-us.net, rafael@kernel.org, 
	viresh.kumar@linaro.org, vkoul@kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, robimarko@gmail.com, 
	bartosz.golaszewski@linaro.org, kishon@kernel.org, quic_wcheng@quicinc.com, 
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, agross@kernel.org, 
	gregkh@linuxfoundation.org, quic_tdas@quicinc.com, robin.murphy@arm.com, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	quic_rjendra@quicinc.com, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	otto.pflueger@abscue.de, luca@z3ntu.xyz, neil.armstrong@linaro.org, abel.vesa@linaro.org, 
	bhupesh.sharma@linaro.org, alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, 
	joabreu@synopsys.com, netdev@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com, 
	bhelgaas@google.com, krzysztof.kozlowski@linaro.org, u.kleine-koenig@pengutronix.de, 
	dmitry.baryshkov@linaro.org, quic_cang@quicinc.com, danila@jiaxyga.com, 
	quic_nitirawa@quicinc.com, mantas@8devices.com, athierry@redhat.com, 
	quic_kbajaj@quicinc.com, quic_bjorande@quicinc.com, quic_msarkar@quicinc.com, 
	quic_devipriy@quicinc.com, quic_tsoni@quicinc.com, quic_rgottimu@quicinc.com, 
	quic_shashim@quicinc.com, quic_kaushalk@quicinc.com, quic_tingweiz@quicinc.com, 
	quic_aiquny@quicinc.com, srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, kernel@quicinc.com
Subject: Re: [PATCH 29/47] dt-bindings: net: qcom,ethqos: add description for
 qcs9100
Message-ID: <gt35pxlulfowpbca3sb6nf5ble4lhq3kolmjyc275vtdcmeixx@gkctewz6tbwv>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
 <20240703025850.2172008-30-quic_tengfan@quicinc.com>
 <u5ekupjqvgoehkl76pv7ljyqqzbnnyh6ci2dilfxfkcdvdy3dp@ehdujhkul7ow>
 <f4162b7f-d957-4dd6-90a0-f65c1cbc213a@quicinc.com>
 <add1bdda-2321-4c47-91ef-299f99385bc8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <add1bdda-2321-4c47-91ef-299f99385bc8@lunn.ch>

On Thu, Jul 04, 2024 at 06:03:14PM GMT, Andrew Lunn wrote:
> On Thu, Jul 04, 2024 at 09:13:59AM +0800, Tengfei Fan wrote:
> > 
> > 
> > On 7/3/2024 11:09 PM, Andrew Halaney wrote:
> > > On Wed, Jul 03, 2024 at 10:58:32AM GMT, Tengfei Fan wrote:
> > > > Add the compatible for the MAC controller on qcs9100 platforms. This MAC
> > > > works with a single interrupt so add minItems to the interrupts property.
> > > > The fourth clock's name is different here so change it. Enable relevant
> > > > PHY properties. Add the relevant compatibles to the binding document for
> > > > snps,dwmac as well.
> > > 
> > > This description doesn't match what was done in this patch, its what
> > > Bart did when he made changes to add the sa8775 changes. Please consider
> > > using a blurb indicating that this is the same SoC as sa8775p, just with
> > > different firmware strategies or something along those lines?
> > 
> > I will update this commit message as you suggested.
> 
> Hi Andrew, Tengfei
> 
> Please trim emails when replying to just the needed context.
> 

Sorry, I'm always a little guilty of this. In this case I didn't trim
since the patch was small and trimming the diff out would then make it
tough to see how my comment about the description relates to the body of
the patch. But I'll try and trim when appropriate. Just replying here to
explain myself as this isn't the first time I've been suggested to trim
more aggressively and I don't want folks to think I'm completely ignoring them.

Thanks,
Andrew


