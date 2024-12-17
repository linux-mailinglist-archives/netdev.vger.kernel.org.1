Return-Path: <netdev+bounces-152602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888519F4C75
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B03188F0E8
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A81F3D45;
	Tue, 17 Dec 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhV7AlBI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746A16ABC6
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442131; cv=none; b=UHgNQvyGh2SSbLVHQIN401giMMe8beCubRYKJaJqbraiZVeZM/fnfQBxNLwjSBnrQpcHzq8Nk5KPIRlDyT9fJZ3+4b50J+gMywZAoq1VyvFpGSMas9CqcYaqWcqts6IGJseRn9McZq9SwMnSzaujwY4be52/JPEdmhMyRk/wtng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442131; c=relaxed/simple;
	bh=YWhUUe8D1P3L8U2stLcOlVoMOUfmEGkLilRRdNtlKDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXnD9CBIuaTcHWFqPqQjY+fvadfNdoE6bXWiLDsqb04TCcwmAQ44CZ1Tha6HhcEn30WgDHhrvSeyR4sB0lf5UUUwt9ybRyjUhDwD0wj/dbTirVVNez6+DDCUnuR+GYvTUJNM4nFr8VfJlCvFpd0YCHBrY88AajcWOXNtaCC/I34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhV7AlBI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436203f1203so4802095e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 05:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734442128; x=1735046928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUDenbDX1h9iAt0PlQfUTXKl10guHO6KftpFnMZ6hpg=;
        b=XhV7AlBIb/Qo2HHrhT5kis3yPNPtXxj7Xu3T/CMQ+js90r2WIRdlTnzKID7hwM8wOV
         zhfcH1SXZaFrJZ4JGs0nKtIir1O1tiRhRF0PI8liNSTBY+K6yHkcG7fDxFKWYR5IJ/CL
         HwuuVgWU+4BZ3GSGadXcHEfF/pu4t347aPlhUWABRqDly1XRePAxWsRKfbtRmwwZe3X2
         rhxohy3SFYJSgUdv5UzFZn4q3lOnWCK2QM8doqOq7P6YG6/f9RQnM4nKZPi4iWgYdll4
         azegCGtbEHTsiNHvD0tq9YXgdh/DDXB/UBDBToReDV6neXZnwkULykpBtQASgK0O6Zmj
         KmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734442128; x=1735046928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUDenbDX1h9iAt0PlQfUTXKl10guHO6KftpFnMZ6hpg=;
        b=mYtyw0Z1RdsS1/XIrYFhF0rIFj3gWvK0smqj72vwQskP2Et8YJWv4X/rj1neBuwcph
         KeSsSZhm/T4nck5AiaW5IuuVr4Rcq+1u50W+fzVn8+wjT9MgK0Sq0fEibUEMbfic/jCB
         P5wYY6oh4Gx+3e2KKFkqdrK04/I1luhTwoWudO5Zd5qLY6ePVkBbFinKMsY7cqvhuoQW
         8EowVITEPCoN3r8zeoZWGLNcvoG4wGqG4+7NT2AETxfPyesteGunvoNFZa64DPoKhcVX
         cmnAqvpUdfLp184jzy6sdkfQfD/DzwUq+mcBhF6EmDvR26b28UbzX4jYXPHoBDsQkFyv
         RTWg==
X-Forwarded-Encrypted: i=1; AJvYcCWrxPCmWfPOua0pHxMqXoyAStRfjem3pMkruTPEttmYcoY2rpL69i34Q6mmb3rhcdjKmD39wVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK74cH/aeVZqE0i4CpHVZr4Jw1OuCp25dlUqyrA66zc0my1Nqe
	+7hsPrx0bC/rVzUbVFXixBHUw7SWgPyug0FZMS8sCnZZKh1ybOFe0ZrzFb7x
X-Gm-Gg: ASbGnctv+fzfzM1cC7/i+t1rVM00pLEKN/ce6z2tx0U7ZZ6hEbfFFFP/aI0M+UkavpD
	QIloGlwpsEV9JAW69kTQ9of0kFG2sNWh1IkbJCca4cD1zE1MOZlJtrt6ySE21Qjf1/6UzpfqB/n
	ijWmmQdrcsYsyvNeJS6gpeXgLmCFY4RNaeIxcUmLw7TQEfkN89mpAxWZUB08WXoBTmYh7hZR6+H
	e2obsYjzA+NTVnLERwnvU9dmawvxXZKKM3TPEK9ywyq
X-Google-Smtp-Source: AGHT+IF/DRs/Nwdl9JsVoCGwTnoF3EeClrKMhoBi+6fRalm1al8cf070gAnDWkBIZFbygt9EqboVfw==
X-Received: by 2002:a05:600c:4f0b:b0:434:941c:9df2 with SMTP id 5b1f17b1804b1-4362aab44b3mr58489965e9.8.1734442127700;
        Tue, 17 Dec 2024 05:28:47 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362b6526sm116364255e9.27.2024.12.17.05.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:28:47 -0800 (PST)
Date: Tue, 17 Dec 2024 15:28:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <20241217132844.xapgmkjkxbdguj7h@skbuf>
References: <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
 <f8e74e29-f4b0-4e38-8701-a4364d68230f@lunn.ch>
 <Z2FGjeyawnhABnRb@pengutronix.de>
 <Z2FGjeyawnhABnRb@pengutronix.de>
 <20241217115448.tyophzmiudpxuxbz@skbuf>
 <Z2FtFR6Ll6c-XPTX@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2FtFR6Ll6c-XPTX@pengutronix.de>

On Tue, Dec 17, 2024 at 01:22:45PM +0100, Oleksij Rempel wrote:
> I'm still thinking about best way to classify DSA user port traffic.
> Will it be enough to set classid on user port?
> 
> tc filter add dev lan0 protocol all flower skip_hw \
>     action classid 1:1
> tc filter add dev lan1 protocol all flower skip_hw \
>     action classid 1:2
> 
> And then process it on the conduit port:
> # Add HTB Qdisc on the conduit interface
> tc qdisc add dev conduit0 root handle 1: htb default 1
> 
> # Define rate-limiting classes
> tc class add dev conduit0 parent 1: classid 1:1 htb rate 100mbit burst 5k
> tc class add dev conduit0 parent 1: classid 1:2 htb rate 100mbit burst 5k
> 
> Or the classid will not be transferred between devices and i'll need to
> use something like skbedit?

I don't know, if you find out, let us know.

