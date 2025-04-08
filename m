Return-Path: <netdev+bounces-180318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B67A80EE4
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1928A438A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5973E1DE3A9;
	Tue,  8 Apr 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA3xCb8o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FA1ADC7D
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123648; cv=none; b=F+TDQ6UUm1wxOZnOB9ruPlwCW9eh+FXmmjzliN+2r8JCobDxTNaFIkyHBWROuoLuA45RBZoCeBtS4GKrpvrBuw21hZva0z2zmKbUiPUk+TUnzVhUbzPFyvI0TTtINYZx9i2K3f8LltOvKrEiBVabBp81XBoeu8ykUY4Ep+nojy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123648; c=relaxed/simple;
	bh=TA5nnYqMlUT7SaPxApqGmruXbNooYP/dfmPXPDAcNww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cox1gJcug0coAOqe0CCQGscQbKkaoaz9AIkyCf1dOBecxfNpGc7E6SQg8koU3mPrBqR7Ji+nZrcwjhl9Mr6v4qKXu6mYAmtc/yVTOD2eBtdAT5BXzS8Ol6pXJ4xYqjUSQ4m9Krw6YtasM3WZ6kXyKM0U3NbF2Le0wKh1zMV33sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA3xCb8o; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so4605578b3a.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744123646; x=1744728446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnx56aJkwrNrA1lsOXnvwB9xf/3cmu0lM8cNGOkprEM=;
        b=lA3xCb8oFn2hJ0mZDruIwTqHqEqe7lf0XKyqUcWBoa4C1fhtdlUhN9HeRk1qq6+6C1
         Q6CLY3KdzlIXi/WC2qCXcrpdRUSBGBczGsb1Fbzi9++Yjf05SG6BOgABmSdgXAonfsS9
         TfFRzk4wLmX7Luyt5j/j75Pe3v5h2amFWkfSNQRJ41o7XT6Z1JKrgz2Ol0YMtcUXameI
         CmFrgNiSTTdGKYDjtrBWV8/e4cAOzJeVTC59STeguJtHZaSiX3RnGhsI7ZPRDlIZDaeu
         nDefUYm6UnVUHDrOsu+Hn7x71eVK5LcbHC3ubPK2CbtF0hZCt8CqsDa0uCroBZX6ce+N
         EeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744123646; x=1744728446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnx56aJkwrNrA1lsOXnvwB9xf/3cmu0lM8cNGOkprEM=;
        b=INHYmXCG1Qu8aQP44hFapOYml36GCYylrf5ebISwabsbo7nXyP/oxCxVb594aAjumH
         7RpocHDaUjEv8T/4T8mrnCJ6TVCMIE8bQFt/ko8CFNKcjYkHyugqzxOzX/IgiG3OJZcD
         KnFcfTR4V4VuLYlIplJ/sd1L0ZxhFzgYlWA+bwttvtOn7hOaFfoS4FxBzVWomjGCDOus
         fe9XeFtUQIwfXu5MGibgBd/a7z03JtDzsZbEhyFljaq4WtaaGQiWSHJ32wSvjK8BMOET
         aI7l5SAIua91aRz8df/YK39UjOfApVOjp+N4qFBvH8RbjAM00rEoTAW/ZH1tFHNN2Kzd
         iWZA==
X-Forwarded-Encrypted: i=1; AJvYcCUhzIblB5jTpJNddVuCn43G5WfYbpYnYILI7Gj2kby8xE7+0vUlr3ziM9dltEO0yVx6Duyzwtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDl7SDCVzDrXhMqGX6TdZcr/SsR0Q7kDrONQ8mVtz2IS+hGU1i
	uF3pmcFFRfvxsGgN7LyS+dGZ6uvjcGgJvWP7LQv/nCuYEP5Y5Jz2
X-Gm-Gg: ASbGncvMva3StidphwMCvoyPMAO2CRGhn8F/Cw3sP8c5kqjUUdC2oqvNMMY7cBh6rgp
	wcTpFeBApxXcCkUWIJlHnL+A5xsxjCvhifnPkT6NHtVjRwlSSsZDUrWhT4+BSWENkmUryVhkUd7
	JCax7Yp/NJmtE1pR7eGfg850cQulKmww+RPdkHZuoSL8DHJ3C3HjfOF/RMjRIUbs4AZfeRqbKrD
	1GE2yqDlOSCDfblSEXAIIDzSvV0ujuFDph+actRQOQfHmo6kfYMnYF6kCi5gL3wZBQwX7OMU0B4
	x6wGvhyO3fyKMIzoPCu4X/cPQi5g12NW0fsOmr1xX5+EWjHFT/RkoU1vJAJMKqSY
X-Google-Smtp-Source: AGHT+IHGqo5xpqx3rP8mGEP9mvaR4YXdhZNTuldXdbXL28E0SGInawsRZtAzzWbwgnicBe7kF2YBlg==
X-Received: by 2002:a05:6a00:178d:b0:736:a7ec:a366 with SMTP id d2e1a72fcca58-73b6aa42057mr14085519b3a.9.1744123645976;
        Tue, 08 Apr 2025 07:47:25 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc2cff95sm9074685a12.15.2025.04.08.07.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:47:25 -0700 (PDT)
Date: Tue, 8 Apr 2025 07:47:22 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "Arinzon, David" <darinzon@amazon.com>,
	David Woodhouse <dwmw2@infradead.org>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Allen, Neil" <shayagr@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Message-ID: <Z_U2-oTlrP6TPuOy@hoboy.vegasvil.org>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-6-darinzon@amazon.com>
 <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
 <55f9df6241d052a91dfde950af04c70969ea28b2.camel@infradead.org>
 <dc253b7be5082d5623ae8865d5d75eb3df788516.camel@infradead.org>
 <20250402092344.5a12a26a@kernel.org>
 <38966834-1267-4936-ae24-76289b3764d2@app.fastmail.com>
 <f37057d315c34b35b9acd93b5b2dcb41@amazon.com>
 <0294be1a-5530-435a-9717-983f61b94fcf@lunn.ch>
 <20250407092749.03937ada@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407092749.03937ada@kernel.org>

On Mon, Apr 07, 2025 at 09:27:49AM -0700, Jakub Kicinski wrote:

> 
> Historic parts are IOCTL-based, but extended functionality for PTP core
> and drivers is currently implemented using sysfs.

The intent was always to offer the same configuration possibilities
over ioctl and sysfs.  That way, the user can choose a light weight
scripting solution or integrate with a binary.

But overall I don't those interfaces are great for reporting
statistics.  netlink seems better.

Thanks,
Richard

