Return-Path: <netdev+bounces-126799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 006879728E6
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6A1284DBC
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 05:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD6214F122;
	Tue, 10 Sep 2024 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAfSCdH6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC434F218
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 05:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725946301; cv=none; b=PrhwZeQVXRgjb86AwaqOFnBWmBpTdQXCuD/fgbl+435YrbqIUihRaXO5KGnpr8JztAawWWZS7CggqOkOUi7XZ5FZDoJEgHIZpNtz+QJoXai++v3f0JQnSO3tIzcphC7PGdKBRgbr9lYQs4+dd+l5tlOW+pD7w/Xij6RrkTUvuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725946301; c=relaxed/simple;
	bh=0t2XN8yFeMWl2W0ikx6hr3Qwaw1PVCd6xjcL9RM30o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkENvr1Vw2cdstAnngtHfDFAwychuB6nTuMQNoxQaZmDKqL8/oxJl2ceFs8ZUK/FwvwtblNRLXpF1FQmvKKzyzkuoIwj+KF/a1Z0s7f9uc2MnqjaRPDKvhAdmwbmpF55OjNiZ+vyUxE7CktG7jhtaP1vLz+tTmHauutlwBsYHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SAfSCdH6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so4628805e9.3
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 22:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725946298; x=1726551098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NSXhvCl16DZ/rmbi3wdBfcfScBaADNaAPOPgeZq3EY0=;
        b=SAfSCdH6f9kGBMft4LO919PSCxYOf25lKir+ttwKLZwMOBEMffS1RHymDXqZ1IT/r+
         W3Lmf6PMKR1btYuNnpr/QNhPD48U5vMdgkXThkEN1F5q1lLXXq4Mu+fmMULcvf51M4zo
         A4/fZ4J4CnX+IaWSR7/k6tp4OkHDddquSVbrrjiTwvcsJbpzp7K1f8JnVZqiEs5zFE4u
         amVDrEKQg9kUmI4C2dVDxgH2XHsUUfmMIKpQ7U5DLIv0oyNMsJXEWmxAAPWs5H2RWamW
         MGP9BbpMxtOZrAivWs/TiJ9U10Z3ajWDqhtzgwna/QR8puYm1YL09K6Z3LqBGjAakZrz
         uNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725946298; x=1726551098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSXhvCl16DZ/rmbi3wdBfcfScBaADNaAPOPgeZq3EY0=;
        b=h9a3Hla7r6AoO2czKEs2mA34A8y9FWBZKw17AbedMQ6dkLwhhkvSU2+VtiWRd0KX92
         XGZMB9+BCtu5Qf6LPsxiDWXEDJpF7MpwlWG0MPTI33KEBvxeo9c+gZ84W0hT/or1gVDL
         CMJdoUiaSBim24KQmC42X8soMB5/grmbMHUQxdA0bHs/PJ8GyEr2qTMubuE6Y/Ug4xaF
         cew+tRd73hYNYEWzkptuAPoy4PNUTrx/ypqrihZMQszHW5Rjc+JbZKYLDKA6vredbgwL
         Mraq65tJlq66xyZS5RNcHolaLovJJpTyY8LJZ5/ntL9HCq9F+DCyHNP+RKGnO6IEXU6L
         kJTw==
X-Forwarded-Encrypted: i=1; AJvYcCVY79tLWl+M/5vTeqElX2DUoSegxN6GnFwoZTZVEVrxh6KPjjl7pU/c6/k6jADOWkcOiOyfDCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxSRvnmk5P9y4d3wloykb+h6Ij+feBWZ6Mkoc2J+ink4VUqJPP
	Fdtg9OOx58PW9ul+rZUsQFWrF8bKaQQpViOy1H90DcHuUEowHQv2O44CvbGcOxU=
X-Google-Smtp-Source: AGHT+IGYWzwfZPnGWpfi6i3OG+ZkS7oXQpDEWRDtxtwYN1kihDAmeIPQ52fuv7lbpUI2Ko7ETdftUA==
X-Received: by 2002:a7b:ce88:0:b0:42c:b5a6:69bd with SMTP id 5b1f17b1804b1-42cb5a66a1bmr61041855e9.30.1725946297354;
        Mon, 09 Sep 2024 22:31:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb32318sm96324655e9.17.2024.09.09.22.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:31:36 -0700 (PDT)
Date: Tue, 10 Sep 2024 08:31:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ftgmac100: Fix potential NULL dereference
 in error handling
Message-ID: <aa2cbf22-ae6d-4adf-be5a-b3ea566d4489@stanley.mountain>
References: <3f196da5-2c1a-4f94-9ced-35d302c1a2b9@stanley.mountain>
 <SEYPR06MB51342F3EC5D457CC512937259D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51342F3EC5D457CC512937259D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Fri, Sep 06, 2024 at 06:06:14AM +0000, Jacky Chou wrote:
> Hello,
> 
> > 
> > We might not have a phy so we need to check for NULL before calling
> > phy_stop(netdev->phydev) or it could lead to an Oops.
> > 
> > Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/net/ethernet/faraday/ftgmac100.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> > b/drivers/net/ethernet/faraday/ftgmac100.c
> > index f3cc14cc757d..0e873e6f60d6 100644
> > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > @@ -1565,7 +1565,8 @@ static int ftgmac100_open(struct net_device
> > *netdev)
> >  	return 0;
> > 
> >  err_ncsi:
> > -	phy_stop(netdev->phydev);
> > +	if (netdev->phydev)
> > +		phy_stop(netdev->phydev);
> When using " use-ncsi" property, the driver will register a fixed-link phy device and 
> bind to netdev at probe stage.
> 
> if (np && of_get_property(np, "use-ncsi", NULL)) {
> 
> 		......
> 
> 		phydev = fixed_phy_register(PHY_POLL, &ncsi_phy_status, NULL);
> 		err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
> 					 PHY_INTERFACE_MODE_MII);

This is another bug.  There needs to be error checking in case fixed_phy_register()
fails, other wise it crashes when we call phy_connect_direct().  For example,
if the probe() ordering is unlucky fixed_phy_register() can return -EPROBE_DEFER
so it's not even unusual error cases, which can lead to a crash but just normal
stuff.

> 		if (err) {
> 			dev_err(&pdev->dev, "Connecting PHY failed\n");
> 			goto err_phy_connect;
> 		}
> } else if (np && of_phy_is_fixed_link(np)) {
> 
> Therefore, it does not need to check if the point is NULL in this error handling.
> Thanks.

It's really unsafe to assume that we will never add more gotos to the
ftgmac100_open() function.  If you insist, I could remove the Fixes tag...  Let
me know.


regards,
dan carpenter


