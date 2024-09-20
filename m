Return-Path: <netdev+bounces-129027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E097CFE7
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 04:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109A71F245FB
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 02:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFEFB669;
	Fri, 20 Sep 2024 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="k/JvZkw1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CC263B9
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726799507; cv=none; b=R+PZ39jXvM8+CGgAb4EJIgRc/0LAGS8BVX1Y+2xKKi1cA5SplRPnNdj+T/yKxZQkKNMrEN2aO7mFAbqQnPCMmd9Ki6iyYuBDX3iNI6UMhAG8wSR9L2VLGzYA13i/UiW2gGp91y6DxFYaCjFbeWkSPrXXZFHq0Z5tuhxUDxi9M+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726799507; c=relaxed/simple;
	bh=H1NqMj29AMFWKAVphzO96tbokAiE/KtRfYVoP1vmjqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/ERzrwzrbVXY/ZTRBFII5Ifuw+m1uJBvWVprb8WwdFShYeVju6qO71P4Gi8r68JB2NIrLTluHF7sIXCqHegdU6L26iqzCLw/JMNawAQtnKgGBygLXv3RK9jKm9goX+jouaWXnBcQ7/QO1FfOTji6Ra3NkVgY9MDBzyGz7wmxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=k/JvZkw1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d88690837eso1386536a91.2
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 19:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1726799504; x=1727404304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBTasaN10o+Fy5OaJtFMavsppxxyIj8O1zMam/DrzDw=;
        b=k/JvZkw18ctdlgUtn5oqlF3EnDEi8h47uLwvraP8DWI6Iza95hhY3wsWi1+xlkO+1Q
         sW4K4FL1bVHqbFh7k4sgjVMu+jW2wm8ZrP+PuLNLKskx6ceaE5LQTlwCtbo8JnP4XLOW
         E3K3Mx7aX/fiJhYxySkkbVc7CAiURIFrgsNd2lXGobk9jx/XDty62jf1Q8YgEudrYI3t
         UjMUhvm4iOFWmE/dxGANW/3NngKsOm8Y0sJTN69Bj9BCNtqGuwxhzKRCKlu04jqHs1rP
         vzEDQ/AM8078ADTemJRZeTBE2FkcFM3+hrgoKVd5ZGP3KXHkvwwFXAJtwkDk1gq6tmrI
         9tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726799504; x=1727404304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBTasaN10o+Fy5OaJtFMavsppxxyIj8O1zMam/DrzDw=;
        b=Mc6j6ZrDmVk6fW6lMrSjQdjVQNcb9ejFjY6LMhyZoEUBIlGHAG7J9jUe6SQcF2kZpT
         wNWGWBFFqjeo68PfFLUnP7Q54HXxR+yv8DD1q/x0PbH4Io/id/kHi7l5ooJ0c1MxOQ6N
         /MBbjJGBtjL0rOS2Wa9OEv03NNZTHfaDkGPHoABjC1EvySHVqgvx1Tcwv/f8B9xVupmA
         K3LjuB+RBEO6Zy/+EZw4ggDNxuKtr7ZuKt0vJ2xKnEGh52eYjkiNVspOnPOZhcrHPdLo
         qyfhM9v+VtaTRz2awDAGrBofnJLnKYjSRDOueHuYB15942N1nS5b+svrvQqHdNGcbsuW
         5WZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTjvE9bYjNG3djYcReeZAXQXDlkPeMbkOUx1Zw753RzDQ8Xkya0MksKKJH3ZqCPI4kKCBFuo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05kTRRFFU6IRVBqDFj908xs3sWjQONNlCHyYsAqP/+GRvpsB+
	cRdFVDelCTUCh6HYDCQHKmmxBGCoeNVV119szFXmUAPPhzvRaaV2w9Sih/hjdiQc92eXfuujVQO
	f
X-Google-Smtp-Source: AGHT+IHt7unEBTaCNeR3c4TccJ0i8GyjD2bKGaUsNAiVHfvxsrlCLdrta7tp640RWtZxP9zhKWoqWw==
X-Received: by 2002:a17:90b:2547:b0:2d3:c0e5:cbac with SMTP id 98e67ed59e1d1-2dd7f37e8ddmr1979054a91.7.1726799504274;
        Thu, 19 Sep 2024 19:31:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f4193acsm625580a91.0.2024.09.19.19.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 19:31:44 -0700 (PDT)
Date: Thu, 19 Sep 2024 19:31:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "dsahern@kernel.org" <dsahern@kernel.org>
Subject: Re: Submitted a patch, got error "Patch does not apply to
 net-next-0"
Message-ID: <20240919193141.1f60423e@hermes.local>
In-Reply-To: <SJ0PR84MB208867DD3FAFA15BE65A5640D8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB208883688BD13CC7AA8F880ED8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
	<2a39433c-3448-4375-9d69-6067e833d988@gmail.com>
	<PH0PR84MB2073021945EE35CCD20FAF33D8632@PH0PR84MB2073.NAMPRD84.PROD.OUTLOOK.COM>
	<3efb28df-e8e2-48e2-b80d-583ade67eefb@gmail.com>
	<SJ0PR84MB208867DD3FAFA15BE65A5640D8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 22:53:04 +0000
"Muggeridge, Matt" <matt.muggeridge2@hpe.com> wrote:

> > > I'm happy to be guided on this. Would you like to see it submitted to
> > > net as a bugfix, or net-next as new functionality?  
> > However this is something I'd leave to the net maintainers to decide.  
> 
> Dave Miller and David Ahern are listed as maintainers.
> 
> To the two Daves, would you prefer to see this submitted to net-next or net?
> 
> Kind regards,
> Matt.

net-next is closed now (until after Linux Plumber's Conference).
It will reopen when after Linus merges and release -rc1.
In the meantime, figure out your mail client issues.

