Return-Path: <netdev+bounces-105808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EEB912EBD
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 22:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B828F283411
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631017BB12;
	Fri, 21 Jun 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PP5DBmEu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13617B512
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002697; cv=none; b=dAnRfzgFF9I2xzzGFTuFkiusoNu4U4gW6q7t0eyR/+L8aEYH7AHQyFWoJEvRskLjvj1+v/OxNfvaCiAwYAtan/tFA3bIQrxNVP/zBQMMKet0dmfyPftGtNm2Ndzmg5FIB9o7nS9cKkl/xcO2sOEHy32eXR1Kks3Y3Dyx5t56Q10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002697; c=relaxed/simple;
	bh=EVjOk2Qvik+pOzl2DFM0KDrYTyxssV7z+Gs7LWahwhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdB+EFryewRyRh4Xkn3OOu9bHAQcPAr0Vao8MConD4V085+3H5HhpWJXNdhkFivM8xL34gR2Vtm7afjCoD+SGpfMeqiVDg6jqTv/m/oK3+YpAcdw16jkVDKHUsYPtOhCB6z0e/ZbuJ1gP4y5poAP3elWn3HcNs9215Z4zLvWeOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PP5DBmEu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719002695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBRyGrjkPd5CIS4XoIva4gQOV3Q+VtL43fiauuhlKtM=;
	b=PP5DBmEud1E2RLh4VfHLdt/IYIVsU4fLmdotvL/wQ/0fSwdpPtbAKfltakEIxRxPHiAJcc
	mlIJScrZQrbdUVccbuqmP1p9l7LQBys7zBOzE8btaffEAWM7uJ6nh33lLbwMaxQBnqa92P
	lTmfEv8Dcj5AuPxHiTuQmHUyMCG5dU0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-6x6jwN6tPASccGnC_TkOoQ-1; Fri, 21 Jun 2024 16:44:54 -0400
X-MC-Unique: 6x6jwN6tPASccGnC_TkOoQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b51db044edso16452746d6.2
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 13:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719002693; x=1719607493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBRyGrjkPd5CIS4XoIva4gQOV3Q+VtL43fiauuhlKtM=;
        b=Dxt17kSVS+lQYgBFky19Pd0ZcCICqs/MfA34bu2iVESRQONiKFdtOpyd0Tbz94BArY
         zAt0qSgjVMnMS4CXddjZ3UW0mnfMHpCquNGmDQm58Ko2sCFwLqmD751t2CJXbeftp1MM
         k8FI8aNTDYF2uNLiu935qRprcHqixreBkDdRkB0R6/53h+cIyVuNussDC9Pn2bSiHgTh
         Lvclw53L5ZNqkJxdr894lwRhxzZGDVaXwjt3VSWXBkJjNvJ4FaBc1wvJ6i2JdU3aKx7i
         +Tt4UZI1Q46lzoOL3q7ISfYwH5oeVw7ZQkWxAqfPpYl3HxYUWD0kL54BhVUuI9qufIhD
         0SpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqLdmvKHMvzC3lbhczqLSdJm7KtLio93CCm4pIAJIByPKhmL7jZI+KpbshFuzZCB2WHpv9UVleQNlaYtSz2SrvaJ8EA6/E
X-Gm-Message-State: AOJu0YxxyKUXqVkJNJoDR/6bI9HUL17X4iL2PS34gYSb/gBPHn+PmInL
	XfB4zOe+UkHJ/dZa8ySWG5DFHmoWd8A47Ea4vpII7oPEGEnqTEdJggaADxnQ8t5rZeTCw9Bkbg3
	9kgEwQQUHWAnTfmUYaDldoCcwzgGnNX5vHciJzJP7zGNgzaXLxHH3bg==
X-Received: by 2002:ad4:4e2a:0:b0:6b2:cdaf:300e with SMTP id 6a1803df08f44-6b501e03d2cmr96084146d6.1.1719002693500;
        Fri, 21 Jun 2024 13:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpK5D9TDm/aP5jldornZZLwHdWh2EXn0K0pkw6eEyjdSKLkGZH9gNAROZfr7QzFOXxvhc+rQ==
X-Received: by 2002:ad4:4e2a:0:b0:6b2:cdaf:300e with SMTP id 6a1803df08f44-6b501e03d2cmr96083876d6.1.1719002693102;
        Fri, 21 Jun 2024 13:44:53 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef30d47sm12047126d6.83.2024.06.21.13.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:44:52 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:44:50 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sagar Cheluvegowda <quic_scheluve@quicinc.com>, 
	Vinod Koul <vkoul@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, kernel@quicinc.com, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] net: stmmac: Add interconnect support in qcom-ethqos
 driver
Message-ID: <ymg2rf4vlp6kcsb6fbass3rntaxfz4ox4hbhcn56engfqcboqr@kp47u5rk3mvk>
References: <20240619-icc_bw_voting_from_ethqos-v1-0-6112948b825e@quicinc.com>
 <20240619-icc_bw_voting_from_ethqos-v1-1-6112948b825e@quicinc.com>
 <159700cc-f46c-4f70-82aa-972ba6e904ca@lunn.ch>
 <b075e5a8-ca75-49cc-84d6-84e28bc38eee@quicinc.com>
 <b5096113-de85-485e-a226-a8112b3d5490@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5096113-de85-485e-a226-a8112b3d5490@lunn.ch>

On Fri, Jun 21, 2024 at 10:01:39PM GMT, Andrew Lunn wrote:
> > > This all looks pretty generic. Any reason why this is just in the
> > > Qualcomm device, and not at a higher level so it could be used for all
> > > stmmac devices if the needed properties are found in DT?
> > > 
> > >        Andrew
> > ICC is a software framework to access the NOC bus topology of the
> > system, all though "axi" and "ahb" buses seem generic but the 
> > topologies of these NOC's are specific to the vendors of synopsys chipset hence
> > this framework might not be applicable to all the vendors of stmmac driver.
> 
> There are however a number of SoCs using synopsys IP. Am i right in
> says they could all make use of this? Do we really want them to one by
> one copy/paste what you have here to other vendor specific parts of
> stmmac?
> 
> This code looks in DT. If there are no properties in DT, it does
> nothing. So in general it should be safe, right?

That logic makes sense to me, and thinking about it more you request a
"path" between two "endpoints" in the network, and that's pretty
generic. Sort of like the clocks, etc, and then let the provider figure
out the gory SoC specific details.

i.e., for example I see the UFS driver uses the paths "ufs-ddr" and
"cpu-ufs", and thinking about it generically for this IP that's probably
the same thing going on here (and lends weight to Krzysztof's request to
use names similar to other interconnect users).

That being said, grepping around I don't see users outside of platform
driver bits (i.e. I was hoping to see drivers/pci/controller/dwc/ doing
some shared usage, but that's not the case). Given what you said I'm
of the opinion now this should be done in stmmac_platform.c
and described for all stmmac users since it feels like a property of the
IP itself similar to the clocks required, etc. The interconnect framework handles
when they're not described in the dts gracefully so it shouldn't break any
other SoCs that don't describe interconnects currently.

Thanks,
Andrew


