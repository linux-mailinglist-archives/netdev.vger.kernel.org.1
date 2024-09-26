Return-Path: <netdev+bounces-130030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9FD987A03
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 22:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4532835BB
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A0817DFF3;
	Thu, 26 Sep 2024 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/6Ib0Zv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE717C9E7
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727381655; cv=none; b=g4hNkERbxJHC+Kh5RC+tEyHXBgAHqyqknHzqvEW5SM+YsarB8N6VFyHzzQHlQVHiPjGG9QZd12yWt7WPKyVfrmOu/ijsPdBhwp7tg7hfIyh+7Hsq4qf3jJrfs6wHLOdTd8M4iXpeG7v77OXqAId923CLnoM/fiunudJyKItdc1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727381655; c=relaxed/simple;
	bh=SywJ6IY4/ZKra54DmIZi64FJeAqVuZ29u2cS0EvQAT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WILTPUXLO41Uwf056d5a23YKNumiCqIeYlCz4BbnkXHgjnMHuVU8VP5GOg4rX9RJ/IVxpY2jUhzz1wzb2VatZMWtsy9R5TUDtaPCj5Zwh2tyYIf5t09wfJGSMjg6/VTneBzgPz/u70AYToKyIcmV6fO4yOpgm/Ef+3bZ4eOxkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h/6Ib0Zv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so11657075e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727381652; x=1727986452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=adNp+ex0aTTFAqiWEedrw/mOZftL/ye5N6g7vAI0S0g=;
        b=h/6Ib0Zv1Qywp9YTBqrFaOk7L2Qcd9IMpfc5FotB22f+1oRgnYJ/j/DtPcdlSqup+3
         ygN71C1KgfZtMLp6bLNIlYG1Pb/Ds0gsGjyHKgCbxQj7d/Z+JgK+Uz0+FAE8OHpwm/p6
         sMojjiOsU+XvfNC7NLr2b/9ZudJVMTxUQ+ZqIeQUigo2f1jSpY4AanF7oyo69Bj+Q6tX
         cOBZoqzbXEl7FALaQ0MQn60KmdDenZMb+NggDpQuHmjKjLFGPkWY7/DchaYRJ9x+AgkL
         JOuTTiQ8pq+8EHhkO5lfGmSVtyNAx+W853wtoJm78bqELph437Kigw0N7uu2WHOHCV7a
         p00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727381652; x=1727986452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adNp+ex0aTTFAqiWEedrw/mOZftL/ye5N6g7vAI0S0g=;
        b=xF/MTpjjpUAwl89ttv6qZexyUYXJPg0g7Qt/Y8HL9H5JELzsbZt+Zt+G1iOqEsSPjD
         vMnSg/+rmugCiw5CQtLhadfmwC1HeRv61uTpAy7i0WrXqS1bGVkwvu4v5/ZrOTIh0BNY
         IldnWefvwpOn2hVhSjN/bIiXYeYvTNipeDzI1J+8BMmUst7oDbDvWqGosv3mXDDB4PWh
         +j1Iyzd4fGvF/+hvmVw6hW7kGJcQhY2OO8BVruSABAffC2QcF9zHYwhTmJKwrRXYvzwU
         E4zy7BXVGg6mjwlLvGXOVbCNkjgy1OqXRgE9xe10zxex/rbsSx1JwS8QlgLV4sKKV0D0
         9ifQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY6MJpBFnTxxAQnDtGqH1GvtNVJ9Oguwrh7INzN5TMvEGY4JCRRBOeTY3YmUcZNiOVU82QTcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTiceHHrvhg2KWNs8rRQTGa4/rBcfwvVUrlTDJVcm2b+oJRdkw
	TGhQpLorqbZEIhou6yQD+PrS7J1s74azRf/5fo92fP8Pmt9cXwLRCK8QTks+ekrDDRl212LxA5e
	w
X-Google-Smtp-Source: AGHT+IHAVUKzMTH3MGv+LwYbAamyJU3xln7iWwZfpcoO7AqGhQqz3MkJaGIrNcTuk0zibF2YaiT2bw==
X-Received: by 2002:a05:600c:3b04:b0:425:5ec3:570b with SMTP id 5b1f17b1804b1-42f58497da0mr3800515e9.35.1727381652444;
        Thu, 26 Sep 2024 13:14:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec19bsm8350185e9.26.2024.09.26.13.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 13:14:11 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:14:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Julien Panis <jpanis@baylibre.com>,
	Chintan Vankar <c-vankar@ti.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: Fix forever loop in
 cleanup code
Message-ID: <5ed2cd4e-cb50-4a21-93e2-8ba8d627f20a@stanley.mountain>
References: <ae659b4e-a306-48ca-ac3c-110d64af5981@stanley.mountain>
 <20240926155139.GG4029621@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926155139.GG4029621@kernel.org>

On Thu, Sep 26, 2024 at 04:51:39PM +0100, Simon Horman wrote:
> On Thu, Sep 26, 2024 at 12:50:45PM +0300, Dan Carpenter wrote:
> > This error handling has a typo.  It should i++ instead of i--.  In the
> > original code the error handling will loop until it crashes.
> > 
> > Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Hi Dan,
> 
> Unfortunately this patch didn't apply cleanly to net
> which throws our CI off. So, unfortunately, I think it needs to
> be rebased and reposted (after the 24h grace period).

It's not a matter of rebasing...  I guess I accidentally deleted a space
character at the start of the first line of the diff?  Weird.

Anyway, I'll resend.

regards,
dan carpenter


