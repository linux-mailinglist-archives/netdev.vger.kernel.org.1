Return-Path: <netdev+bounces-99422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C1A8D4D47
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C67F281564
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F79186E2B;
	Thu, 30 May 2024 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUAgkZaz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85AF186E26;
	Thu, 30 May 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077224; cv=none; b=NqQ/BYjrWACK/CSgviuiM2z7ZONCqyN/i91UPXh1+pILEuSwyvXYbGyKiY5r5YvI4ZmFd6VwpfaPRsm3ZKTb1C+JE3V4FVF0Idq0mc3naeIzZljGQdJe7Cs4bVugsIDsSDTwpgy/U8PIN0XplWzKpm4MyqiAG4PK0paH+Tm0+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077224; c=relaxed/simple;
	bh=x6es90Rm3xtGO8dDhmEZEJD8Kav3O2vb6Z6KMM1kzb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwzhTY9nourQDD27w9wb7+i5sIo7UirNn8ReHn0Nj4uo3qQgxhpv4mXpGrRPO+gTUepb6bibGxu7wHjLf14877r/baR9q4bFq9KhIudK6cA+ofH2TCR5fvxmRYw/fZ2RnbEM68yXhL/mOtMMivxEnPWV/srqip1kfE7YWFuB5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUAgkZaz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e719bab882so9935861fa.3;
        Thu, 30 May 2024 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717077220; x=1717682020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvWDuGZydvfwWw+VcnsyJcShHeGi2zyYheK4PDOMSDM=;
        b=YUAgkZazkuF0gjm0ZBxTBMtTjwrsrG2Er3yUcpwbIG7ICr1soS+9hFudQUu2cjaK7i
         AsF8b6a1I0z5zhR8+OMDjS/vSLbx4ASawfIb3y3SRF5hq/nZFOmtmTDopQKPmeknR2Q8
         RbIvNS+HGv83L6o5ZBHO3hsK9P5Pkzmq6oJOCSQOF6ui8T1EImXgKsZlwdHQctpqqUph
         yUgQzFdPV+alkS3GhZjkgMu23vPI2HtDpQ95wqMnD5frCNNVAnIfzvePjmpWa8I3e8JP
         pNO0YZT9j2I5oQmfiX0A28QGISn6nJq5+cpNIHjTfI1Geucpv0F8j1FmQ+yhoBihahke
         0fhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717077220; x=1717682020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvWDuGZydvfwWw+VcnsyJcShHeGi2zyYheK4PDOMSDM=;
        b=VaLMMcnLyyEl8WWzU03k/l4iRrnz/ws8POJv3oLr4iXfljLp7rkLWhBvITVnU3Z/Pu
         BLIACQU0mbehzv2zq9/3ReEKqc3IGHA0Qp31jOiwrl67MB71NwV7O7a6SBtdBMaLdYph
         QmwNor/0uBUodamzvMbrTDpVZgTukNLFWTuYk4zI1xLMgD1XHzhr1zZ/JJCKihMT/ptq
         FT2E003yEDt4x/PlUWYKMtiK7vopZ6i8g8mb7LBtmj5JsbohVHTDBw9YCoeOJzeGhfcO
         un+UymS7L0SiFgLzECGw6HtZbkK8ETiodnKr9facDV07E1ah7T0Y2ojyJeGaJ2UAetfC
         jeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA0X1cIRawq/njisLA/hbfSzBhe0xdKZYTrF5sYRpIHhAqyVUBKVFqzKclH/vIpst5jqvilWUi58plTcX3FFvdBqASrRELVKZ3TdkvsxmNyjnbMtOErxXsVVa+Y9nIuJM49EmD
X-Gm-Message-State: AOJu0YzZ/mQYdCq0RLdBomted9SSrE7BBflbkDawN2EStqZ2uDAaejzI
	vmYEyXPFfitDa4FHAicgRSChAEEYQBOsmrS6XvV5yoQlAU3Q0CIWiugL8eUj
X-Google-Smtp-Source: AGHT+IEQ3q2ebeicCl5ECrFOc1Y5NMP3EcVlOA2vB1sH5Lg/m8+rLvzw2p8HkitK/FnXeqX9/RPJrw==
X-Received: by 2002:a2e:9858:0:b0:2d4:54f2:c409 with SMTP id 38308e7fff4ca-2ea84892132mr14288601fa.38.1717077219409;
        Thu, 30 May 2024 06:53:39 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270791c7sm25921725e9.31.2024.05.30.06.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:53:37 -0700 (PDT)
Date: Thu, 30 May 2024 16:53:35 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Xiaolei Wang <xiaolei.wang@windriver.com>, Andrew Lunn <andrew@lunn.ch>,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net v2 PATCH] net: stmmac: Update CBS parameters when speed
 changes after linking up
Message-ID: <20240530135335.yanffjb3ketmoo7u@skbuf>
References: <20240530061453.561708-1-xiaolei.wang@windriver.com>
 <f8b0843f-7900-4ad0-9e70-c16175e893d9@lunn.ch>
 <20240530132822.xv23at32wj73hzfj@skbuf>
 <ZliBzo7eETml/+bl@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZliBzo7eETml/+bl@shell.armlinux.org.uk>

On Thu, May 30, 2024 at 02:40:30PM +0100, Russell King (Oracle) wrote:
> On Thu, May 30, 2024 at 04:28:22PM +0300, Vladimir Oltean wrote:
> > On Thu, May 30, 2024 at 02:50:52PM +0200, Xiaolei Wang wrote:
> > > When the port is relinked, if the speed changes, the CBS parameters
> > > should be updated, so saving the user transmission parameters so
> > > that idle_slope and send_slope can be recalculated after the speed
> > > changes after linking up can help reconfigure CBS after the speed
> > > changes.
> > > 
> > > Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> > > Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> > > ---
> > > v1 -> v2
> > >  - Update CBS parameters when speed changes
> > 
> > May I ask what is the point of this patch? The bandwidth fraction, as
> > IEEE 802.1Q defines it, it a function of idleSlope / portTransmitRate,
> > the latter of which is a runtime variant. If the link speed changes at
> > runtime, which is entirely possible, I see no alternative than to let
> > user space figure out that this happened, and decide what to do. This is
> > a consequence of the fact that the tc-cbs UAPI takes the raw idleSlope
> > as direct input, rather than something more high level like the desired
> > bandwidth for the stream itself, which could be dynamically computed by
> > the kernel.
> 
> So what should be the behaviour here? Refuse setting CBS parameters if
> the link is down, and clear the hardware configuration of the CBS
> parameters each and every time there is a link-down event? Isn't that
> going to make the driver's in-use settings inconsistent with what the
> kernel thinks have been set? AFAIK, tc qdisc's don't vanish from the
> kernel just because the link went down.
> 
> I think what you're proposing leads to the hardware being effectively
> "de-programmed" for CBS while "tc qdisc show" will probably report
> that CBS is active on the interface - which clearly would be absurd.

No, just program to hardware right away the idleSlope, sendSlope,
loCredit and hiCredit that were communicated by user space. Those were
computed for a specific link speed and it is user space's business to
monitor that this link speed is maintained for as long as the streams
are necessary (otherwise those parameters are no longer valid).
One could even recover the portTransmitRate that the parameters were
computed for (it should be idleSlope - sendSlope, in Kbps).

AKA keep the driver as it is.

I don't see why the CBS parameters would need to be de-programmed from
hardware on a link down event. Is that some stmmac specific thing?

Xiaolei may have a bone to pick with the fact that tc-cbs takes its
input the way it does, but that's an entirely different matter..

