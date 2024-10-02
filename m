Return-Path: <netdev+bounces-131406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD82898E738
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDBA1C251B2
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33D819EEA1;
	Wed,  2 Oct 2024 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd9Trrqe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195A194A6C
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912620; cv=none; b=PNOEuwCNva26ihzBq8IOvBs/FsiOm1vJwNZtVD9JwT4TdAd65VK0ra5HwVjf4PsazrB9hUeF8iBjQUOilJcYfK5w4c2Kkcda4qLE9s5oEiJHACKL8dFSDaNx8rqHh+Y112RO3aFoxWDkCfr5nWiykXk00lFHfj2eoMJ5Lys1Yms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912620; c=relaxed/simple;
	bh=sqJzFJ54/2go2HKnjUAfiX31MiVnQG+QvtyZBlVX0Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kaye9L2iAaY4fBU3dqUIfQ1L7QPqdptwzA99o4laHd+JCCWaNFuAMBx1c0xlSQtUGyQbGPgIxdE6ykab9SfurM3+pZjTSCRGpEFBzhkHRyN2QZUuxxzCQJK04SPws2L2vxLuyuV44hUZg4BLu+wvsSlSUq5S1t8snpsuBen+HVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd9Trrqe; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fad784e304so4201241fa.2
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 16:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727912617; x=1728517417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnZ6IwF/C3++VtFHyrIQYmghfA5xDJeKUO+7mIqPveY=;
        b=dd9TrrqeAyjsBt7VEtcfqSYiP6P2uS66ty8xczUBou+z+Gm3YGTmSZAaRvEyrzaOd5
         xw2sOpfCt1UcL/JVCMaOMrtcJlMSkC1eb+qMYaaPQnnlW7CkF6kH/KEkruXy/l81jQri
         qukWgBQirvuHFIjdcu0vG6+GzybuPRa1q3wzp56NRgZqVAHWyVv8hrB6eZ4fgRrRrfoO
         BmzIqYriIv46xUAmcOLTbOrU+u86NFlmCCaWl5uvXd9FeYT4WdLtYMyh7qW9RI55+YKP
         bA+H8kGGLa6hy3+33Vftl0LvfNO+F4C+NsOJaBdVsNWV1EwwWAh0yfMZAc3udJ1LWSTP
         eByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912617; x=1728517417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnZ6IwF/C3++VtFHyrIQYmghfA5xDJeKUO+7mIqPveY=;
        b=QDE+PTN2AF4iCZVUhK/rHSbjZ7rp+mj5N5KFNksmw3A2IvZAcBBfyQ9xYUKafg9pc+
         wFYD8jqtSIBQO9WfthIVSkfeAKLYAkJK79nKm7qjx3czaSDVDmzbbmhygcPvsNMXkCqV
         IvFXxxVxatrWAMQn8m4KzY77G+REMT+YjRBjlvjL28FR1/e3caScWsLOL7VE14wX2ZaD
         rQOmhUB9UkYe6rnDG8SP5gCrsP3FFEYBDAc4KnJLFgoy5a97AY0Y5utTvdYI8M9QLYvz
         fQb95jEWdlDyCK0FqBlIQVpGfl2f+cMvZsi/YDtY/9iZi38tw7PofpaKJsxCvQhap1Ks
         aeJA==
X-Forwarded-Encrypted: i=1; AJvYcCWD3bCKNZlnoDFXiKqC+KRB74bF6t++gRIydIDzPh3kjPXXS9dgRlEm9cvU5TvRE7BU5hRVkco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxumXJQ8rZUdQtSvojlbSDXrFGQDxnuvauOFl49PdQIxZLCCgZU
	GC71rStwaYMYSIjdObWfsWggWqh/7JKK/TUuy75IZQ7DqsghjANL
X-Google-Smtp-Source: AGHT+IFlhPtoXyWwwkC4XoQdBs124sv8hczhDcjgycjM3CLHUAqSnF2DitEc8Uys/qoWEBuYT6cd7Q==
X-Received: by 2002:a2e:a9a3:0:b0:2fa:cf82:a1b2 with SMTP id 38308e7fff4ca-2fae107dc8cmr34805691fa.31.1727912616682;
        Wed, 02 Oct 2024 16:43:36 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faecc9900dsm270151fa.112.2024.10.02.16.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 16:43:35 -0700 (PDT)
Date: Thu, 3 Oct 2024 02:43:32 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Message-ID: <zghybnunit6o3wq3kpb237onag2lycilwg5abl5elxxkke4myq@c72lnzkozeun>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
 <E1svfMA-005ZI3-Va@rmk-PC.armlinux.org.uk>
 <fp2h6mc2346egjtcshek4jvykzklu55cbzly3sj3zxhy6sfblj@waakp6lr6u5t>
 <ZvxxJWCTD4PgoMwb@shell.armlinux.org.uk>
 <68bc05c2-6904-4d33-866f-c828dde43dff@lunn.ch>
 <pm7v7x2ttdkjygakcjjbjae764ezagf4jujn26xnk7driykbu3@hfh4lwpfuowk>
 <84c6ed98-a11a-42bf-96c0-9b1e52055d3f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84c6ed98-a11a-42bf-96c0-9b1e52055d3f@lunn.ch>

On Thu, Oct 03, 2024 at 01:12:58AM GMT, Andrew Lunn wrote:
> > But if my reasoning haven't been persuasive enough anyway, then fine by
> > me. I'll just add a new patch (as described in 2.1y) to my series.
> > But please be ready that it will look as a reversion of the Russell'
> > patches 2.1 and 2.3.
> 
> Note what Russell said in patch 0/X:
> 
> > First, sorry for the bland series subject - this is the first in a
> > number of cleanup series to the XPCS driver.
> 

> I suspect you need to wait until all the series have landed before
> your patches can be applied on top.

Of course I have no intention to needlessly over-complicate the
review/maintenance process by submitting a new series interfering with
the already sent work. That's what I mentioned on the RFC-stage of
this series a few days ago:
https://lore.kernel.org/netdev/mykeabksgikgk6otbub2i3ksfettbozuhqy3gt5vyezmemvttg@cpjn5bcfiwei/

But for the reason that I've already done some improvements too, why
not to use some of them to simplify the Russell' and further changes
if they concern the same functionality?.. That's why I originally
suggested my patch as a pre-requisite change.

Anyway the Russell' patch set in general looks good to me. I have no
more comments other than regarding the soft-reset change I described in
my previous message.

-Serge(y)

> 
> 	Andrew

