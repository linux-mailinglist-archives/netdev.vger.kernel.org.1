Return-Path: <netdev+bounces-194291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A447AC85F0
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 03:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E0716467C
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 01:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6597148850;
	Fri, 30 May 2025 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jRqFkbqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE3125D6
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748567551; cv=none; b=iIqMikOaaP0McF4c6bkMnzCGXZvb4dCxd6L2bHrSe8HDMEVuHSgyD5sNk+Zt7pM9GVNyMQWR+wwPMgKCmStbx2saNXDZk2/jWjdwcw+NbmmYZTcRihYsxPXWam/oOwjorJdGYcPTMB5gmFWBqkKieHr0cOs5A4yuyMvMvAs5KJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748567551; c=relaxed/simple;
	bh=clOYv3dnJ+TShXUkp1L3GsXOXqSgKF+RNbjkUtidq8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9fdD//NKw5uHfv9J3dzmbHBG67ZhKsoAoOCp9fn49mmgXmG0Lzk3NueSS3mFvapk6DibgD0vBi3GCfOGosdVz36cAlyh905/8uTW9pMRvuv3Te+j0ZKXjoiLrDa8GKLzyOjT8MypzhxDEc6FwUEVatq2BGCXNWnSqgv3RB8PI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jRqFkbqu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2301ac32320so15582035ad.1
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 18:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1748567548; x=1749172348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3JilLzV2DHootoqEMA3T8iks5XhI6tqHSdU2GxYNKU=;
        b=jRqFkbquJ3SUsLiMG/rDjtFsTef8mz2stufBWJAJaOIYFKtOrjAq0QTK6nW7lRb21d
         1WEzTmnFEOwaXHqPOGm58wFX58r0m3FZDCdPzoE3gWLmzS5NE8Iw71DlWaaSwq3Mncf3
         l+MZclYZ6hLUPFbO94tadaNApnZUkDERstRJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748567548; x=1749172348;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3JilLzV2DHootoqEMA3T8iks5XhI6tqHSdU2GxYNKU=;
        b=t3K/GuR9lbvMxKZbMqwUTYe8zWeLoNuroWCgN+mHT2vI29BMwQN6eCHg3Cg/t824xW
         IfqftdYH6vMDGVSiQ2yOIsjqIrHN8AWrEN/yJxhQ3//OSfPPFIlI/apSZFkqszvX+fYg
         lSlnB6ejuwaNz5y9nUY1xaOME4jcx+ZgkOnF7z6haCU/WNBSSw+73aBn9bxAHqJ0aDWw
         3Cz1okMZ854cZgSZGqYqHBnLbA29Bclf5XDI8vTyHSuM2nfwuZcW9n9OvObWWp5ppl0O
         0NuDhlrY+0r5AcxOD3L1Jn3IK1rmzi9pXNfvQZS8yO5RKRRR1gTQIgMvjOkJSqR7uOWd
         GvFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7pXkGAtXMzgdRxPnPQ8D3PuXbDMuLTa7uCb5QnWtBB0rh0ggnu1xOnH4YMc9FFXg0QKgFCak=@vger.kernel.org
X-Gm-Message-State: AOJu0YywcgF1EuIUrQlHKcGJvFa3/9Av86Yt3YYNE6m/5MSTILQQnx+X
	cnQuN0+oC2zOsVQDT9uaCAwRj9S8hBUA/CX/tUdxFq6GT2FdZXglj/6SzbQnSvgdN+WQUugJKcs
	xeTwYqd8=
X-Gm-Gg: ASbGncuYGv6pUJOwK58skp1QTYmDftrOks4WNO511kcBdhnYc+V1e960RTOjuhv0VBo
	ltiQtWI1mou2/e7CNaIqBKIsyaziYPgsKlryi4RDCBz1wxNOFIlhlMCay6derMpv62TdbIvStyw
	8Khe1sI55eZBkr1SQjkZ+grZCyWTEMtnPeejkgJc0HHUbpoFWlX4gimE7mssm43oY4CUYZiHtMM
	ivOfzTAgBOmRm0VZVoqHUDkwAx/AT/cy+/OfXieyWy4ZR7Znzq0oFPPigIT72ne4zP944YEWFSN
	0H7ctRiq2squgx5Pprok0ELPPXbf2n6ngc376VK53MYcw2F6ONVQFc9c14qL8//sSQ4IwEmldhT
	tCDbnr95RFgKhFnoMLA==
X-Google-Smtp-Source: AGHT+IEfiZxx6lbiiXFwfi8oNgiGKbU3wyp4lqiu0NJfRIwH51vrgcK/4RpBMyMXJ6wF+G+lYudcaw==
X-Received: by 2002:a17:902:f683:b0:234:ba37:87a5 with SMTP id d9443c01a7336-235290e65e2mr20475055ad.25.1748567548437;
        Thu, 29 May 2025 18:12:28 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bca137sm18118685ad.10.2025.05.29.18.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 18:12:28 -0700 (PDT)
Date: Thu, 29 May 2025 18:12:25 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, John <john.cs.hey@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Bug] "possible deadlock in rtnl_newlink" in Linux kernel v6.13
Message-ID: <aDkF-Q5K6RhIX5MD@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	John <john.cs.hey@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <CAP=Rh=OEsn4y_2LvkO3UtDWurKcGPnZ_NPSXK=FbgygNXL37Sw@mail.gmail.com>
 <c9b62eaa-e05e-4958-bbf5-73b1e3c46b33@intel.com>
 <aDjyua1-GYt8mNa1@LQ3V64L9R2>
 <20250529171640.54f1ecc6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529171640.54f1ecc6@kernel.org>

On Thu, May 29, 2025 at 05:16:40PM -0700, Jakub Kicinski wrote:
> On Thu, 29 May 2025 16:50:17 -0700 Joe Damato wrote:
> > @@ -1262,6 +1258,11 @@ static void e1000_remove(struct pci_dev *pdev)
> >         bool disable_dev;
> > 
> >         e1000_down_and_stop(adapter);
> > +
> > +       /* Only kill reset task if adapter is not resetting */
> > +       if (!test_bit(__E1000_RESETTING, &adapter->flags))
> > +               cancel_work_sync(&adapter->reset_task);
> > +
> >         e1000_release_manageability(adapter);
> > 
> >         unregister_netdev(netdev);
> 
> LGTM, FWIW.
> For extra points you can move it after the unregister_netdev(),
> the existing code cancels the work but netdev may still be up
> and kick it back in..

Good idea, thanks.

I'll post something to the list, but I don't have a reproducer to
test. I'm a noob with syzbot, but maybe there's a way to trigger it
to re-run with a posted patch?

