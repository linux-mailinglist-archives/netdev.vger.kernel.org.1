Return-Path: <netdev+bounces-131814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E30D98FA32
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147A52829F4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40F21CC8AC;
	Thu,  3 Oct 2024 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejapJXlH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB11CCED6;
	Thu,  3 Oct 2024 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727996643; cv=none; b=QNRE8MD21x9WUqq2XWfMZhz77oJPRzjIdI2gNBzsGp7TCbhQ7Lj9UmBE2FlQeUz6t71TJeftsGlUoqv8aLJ1l6Om0hkLYsX10Tht0DswjeJDmPTwmdTlCG4TcwMsRlkbpeUQWYTIM5DZYoxEeJC8R7RPAjq6+fPcCTZj9jE15hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727996643; c=relaxed/simple;
	bh=/ZV1yl+wG7zT1y4IlAG+HSLEM/FBXFaYSgOI1p4BBTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss+CMt+5KBc3T16fzrhMMTMH8cLSmEmFsLgBpO51TnT+RwBEh20eg3t5HmOWS6zeh8zXkHqLoOt37eTjND+2kkDZY3jwcN5adDf6HhEDrjLx/qrF5RvepIEzltCOaXo3+cenDkF2RbBlIclBAh0MCLeYgfdD13qjtylV4Ui2jtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejapJXlH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb1e3b449so2121375e9.3;
        Thu, 03 Oct 2024 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727996640; x=1728601440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CyFHmbDf6829/sLt58Su4BESbrgT0QnRcIQ7BcAKpHM=;
        b=ejapJXlHumpGvN7Q9n4g1zDIfpP6c96j8JpQ2dKIJDtWwwPhIKTtdHMg9vX3UWP5x0
         LzYQFPvVuqnlZRXVDFI3pmMSE/WAw94yQQh3F6TSjNLt5NuwMVFBzm/eBqMSWz4Z34Nj
         QGB3hvwPt0+i2ljXRZ6td8uPKCBtuyw1haayeRS7kVhWK1LzjlCpnKTB+T0HyCWrJ/72
         8UqqJBNcD8ppCBGXMsIlAEUfxUvWJ4R/3TRckB/ochTI0aRRGAV4i2YRlqDE+MrvhYBt
         2zHliMG74dCQ+lUqIADjXgaA9ccRbeKXeDnmISQn1rEAF0BdDAp3/+g7yrhGdFHl6iT0
         Zg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727996640; x=1728601440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyFHmbDf6829/sLt58Su4BESbrgT0QnRcIQ7BcAKpHM=;
        b=R94DuQPjYe+3zn5SQK0PfUNcYmruPJzGpgD2EQZq0MrVrCadVOzsgUBeWK4UTayXPw
         /05t97dVXOOwPbdp2P0+9mDhqTjMIyhjjULPWKWcs0+p/KzjD55mxvFq1Y0BiL/H+VVh
         OtO0Tghy5vrylH4fUq32vsNGXLtF+mYaZNDeeCO+f0PLsVOBeU7n5CGxO+TQgrtReNxG
         fiCaVbV/mBhilZjf1F+/gO69yCxsWVy6SA8+eHzHVL04m1IOwuMbfeDmGQvivxtGwbxP
         1iQHF1zq00AUqhOUPY/L76Bm+tzaJprdEPA6q1BBrwy/sXiLsug1ke8vcQcDn69Ufqfs
         hALw==
X-Forwarded-Encrypted: i=1; AJvYcCUBIjeUbqF0Sdg0mqcTC+HYowBZ3huezEO2ANU1eoE7VgLCKjQgauAGvOleOw+Mow/NGk8FPkKn@vger.kernel.org, AJvYcCVYuQeh/88gtvEuRfrIggpETfqcEsy8dbwCEBQSTu2N9BWgVBijNqH1Eey3QT0/TAr4sjXqp9/+7XtJ5Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVt5JKt284EpQOX4hEkgqnkpr3XRsBG4VlXfRuOHqGD5JQrH/u
	4vtwXihNTQuizvhN9ec4n8r/KrKUZGxNr+fVqskWCWINa5/zteyT
X-Google-Smtp-Source: AGHT+IHtEg7OmcgdyH960h8MGHeAzll4OqzKkPH5RpqYhOrxBPkznsz8OclQMS37eMFUtwHXXqGsjA==
X-Received: by 2002:a05:600c:a05:b0:42c:df54:18f6 with SMTP id 5b1f17b1804b1-42f85aab26dmr1777225e9.3.1727996640116;
        Thu, 03 Oct 2024 16:04:00 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b2c816sm769935e9.39.2024.10.03.16.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 16:03:59 -0700 (PDT)
Date: Fri, 4 Oct 2024 02:03:57 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: Validate PHY LED OPs presence before
 registering
Message-ID: <20241003230357.z2czrn3pymhuywud@skbuf>
References: <20241003221250.5502-1-ansuelsmth@gmail.com>
 <20241003222400.q46szutlnxivzrup@skbuf>
 <66ff1bb3.7b0a0220.135f57.013e@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ff1bb3.7b0a0220.135f57.013e@mx.google.com>

On Fri, Oct 04, 2024 at 12:33:17AM +0200, Christian Marangi wrote:
> On Fri, Oct 04, 2024 at 01:24:00AM +0300, Vladimir Oltean wrote:
> > On Fri, Oct 04, 2024 at 12:12:48AM +0200, Christian Marangi wrote:
> > > Validate PHY LED OPs presence before registering and parsing them.
> > > Defining LED nodes for a PHY driver that actually doesn't supports them
> > > is wrong and should be reported.
> > 
> > What about the case where a PHY driver gets LED support in the future?
> > Shouldn't the current kernel driver work with future device trees which
> > define LEDs, and just ignore that node, rather than fail to probe?
> 
> Well this just skip leds node parse and return 0, so no fail to probe.
> This just adds an error. Maybe I should use warn instead?
> 
> (The original idea was to return -EINVAL but it was suggested by Daniel
> that this was too much and a print was much better)

Ok, the "exit" label returns 0, not a probe failure, but as you say,
there's still the warning message printed to dmesg. What's its intended
value, exactly?

What would you do if you were working on a board which wasn't supported
in mainline but instead you only had the DTB for it, and you had to run
a git bisect back to when the driver didn't support parsing the PHY LED
nodes? What would you do, edit the DTB to add/remove the node at each
bisect step, so that the kernel gets what it understands in the device
tree and nothing more?

Why would the kernel even act so weird about it and print warnings or
return errors in the first place? Nobody could possibly develop anything
new with patches like this, without introducing some sort of mishap in
past kernels. Is there some larger context around this patch which I'm
missing?

