Return-Path: <netdev+bounces-193462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8614CAC421C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505243A3637
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E118720DD7E;
	Mon, 26 May 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="mldWkfCn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85021FCF41
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748272207; cv=none; b=T6STrSyOYEg/R5Q7WHSl3Hu7zvSdScf8w3SB8E25xMA+rKlBrLYZnOoQFSphJawkHiwRvmJtr21plC2Js/5LB0kzsfq8rXEnFrBw88z/7FbwxHLrf5s++0tA2S0M/0CnlYdpS9d/rktbplYfRxkS2gJLkseZroxyId/WgcW9EDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748272207; c=relaxed/simple;
	bh=UkpG70aQ9C5l0djwEMxzgnUQNMMgAMUiA/MpQffdu+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnVjBbvxtUDkUpz3OET4ggFV1qAc9gjNA4FepcBJQd2b5/q3AH1OnNgR2elylo7b/2/VJKjNsuiT0l9dM5cSlMZoszX4WzKxufZgf1YZJpBOvE9u0TWgCW/0mwMEQSZ8yOEgDaW+pBi6azCWQ646mayLP6AVzMqnDE2B/nZ/kPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=mldWkfCn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60410a9c6dcso4102492a12.1
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748272204; x=1748877004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyxgITVotO26gEz9vrOHDhmjmbho3SpaiIa7lFdxGY4=;
        b=mldWkfCnf3tl3unAgRB4egcwIUWvOEGVrjwlAmyM/PEL76iq9HIsOeuQQdqbpvOGks
         eWaPRDMW02EqTGJjsU5T0AzobZho+MjP7aQeEEYNzlItCwndmH1Sb1AufBhNgdXTs4U4
         J3UILSAWdhx89/+X3SHzkXiTEvDUJVd8+GMxTBtZo5fxqpCJTd/XsNp0EvyiZB9P5OM6
         Vddk6t/0gQZJb+BrkO9WTr66nEioXjlsIlhdH5uWuusfUWe1Mkmd8ZuMPF4FhHpUxuzz
         0V6CDfuFEj8sgrY4YogQsH7p/9K9VdCkn1p69EQQlbVzIhn+lNg8w9dFxdb0X25OVQNJ
         yMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748272204; x=1748877004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyxgITVotO26gEz9vrOHDhmjmbho3SpaiIa7lFdxGY4=;
        b=PeqPIUtX+R1Cd0sWzZ0vp79OrB5XqKlE0/3vA89EmEMwM6omOBFwD748H6MDmsmnaR
         6HnUtH9uK4/RIhUEpGF43+HbeK6VmEUEhbtvYYJcnOwQouqE8Bs7OFQp1YODrdXvDVDb
         nkGeowJzbbIe6XIkujIPOb16sqglSivy1K9VPLACcVM7NoXIlDYlA5oxn2immJZx77+a
         w90bohEs9DTSdOhNsi6faLfCBA09pMW14bT/7m6OLqAus7FMUcL+VZ1mLHoI3k4AHw2R
         ioUtJNJCBogErIvKUfFH9okJNY6QCiqWpviqIIjvDUxUMsWcLKfVLT0fXowBGb2G6Vxm
         N6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxQdViYNyX+Lae6m+JQnIJf/I2LGWDGligaNduuXrWjSyo3xpPim5K9zodS1lZ4BBmZyDXxl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykvX1FVnMXXLC1UAAjndzf+8RrX0QhO8abCnMe1XizwqjhmLmB
	v+7jDOhkwaS6huoQITXOlaT2pEiwqWn6hFfK455jmN10BoOsNgizoLOTii0W/yCNJ2w=
X-Gm-Gg: ASbGnctbDmSPmgpLwjzt7+pAUVOFhcdCkLVEvhs2cwOTtOmLEmPmo0N53vOQVmWLbkf
	ux3FSNyLz8YPPVnOE5dt+Dy6+dmafkqfusnyktPnwKzp+IRmjtlLSQt6Ka0ONArZRUh27Nz0JJy
	KT1DgD94MXvD/QoFvxo/F10drGDWqlamL7+jsH2ajbQ2Hml0cTme8kpVKZHhUgaatUPQcPQezhD
	ei70ws4D9Rwiw51Kow0j7Sn/4Fgc40COuF9McL2b4/64w8//XjLX6DlHdDuTmJvA32r0RbhkjTA
	3MsoJbLXQNeyfoavGsbLi2vrkjdpB/u4ByJY8eyLBt5UiMNT3BdIhlS7NHAjd2mIoWfdykb00nl
	7FKegt1VdL/G2k3DFTNzfxHsg28dk
X-Google-Smtp-Source: AGHT+IEqUuX9uEm+wKSnls6D9dGmtvUJOTCp8H6lZs13wAjUjj5NeswtmoYjB2JN5RGyluCgqprewQ==
X-Received: by 2002:a05:6402:27d4:b0:5f8:504a:88d5 with SMTP id 4fb4d7f45d1cf-602d9df9801mr7422681a12.7.1748272203955;
        Mon, 26 May 2025 08:10:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005a6e3ca0sm16582995a12.42.2025.05.26.08.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 08:10:03 -0700 (PDT)
Date: Mon, 26 May 2025 08:09:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ricard Bejarano <ricard@bejarano.io>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, netdev@vger.kernel.org,
 michael.jamet@intel.com, YehezkelShB@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <20250526080956.7f64a5f5@hermes.local>
In-Reply-To: <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
	<20250523110743.GK88033@black.fi.intel.com>
	<353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
	<20250526045004.GL88033@black.fi.intel.com>
	<5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
	<20250526092220.GO88033@black.fi.intel.com>
	<4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
	<f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 16:28:23 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > > Simple peer-to-peer, no routing nothing. Anything else is making things
> > > hard to debug. Also note that this whole thing is supposed to be used as
> > > peer-to-peer not some full fledged networking solution.  
> >   
> > > Let's forget bridges for now and anything else than this:
> > >  Host A <- Thunderbolt Cable -> Host B  
> > 
> > Right, but that's precisely what I'm digging into: red->blue runs at line speed,
> > and so does blue->purple. From what I understand about drivers and networking,
> > it doesn't make sense then that the red->blue->purple path drops down so much in
> > performance (9Gbps to 5Mbps)  
> 
> Agreed.
> 
> Do the interfaces provide statistics? ethtool -S. Where is the packet
> loss happening?
> 
> Is your iperf testing with TCP or UDP?  A small amount of packet loss
> will cause TCP to back off a lot. Also, if the reverse direction is
> getting messed up, ACKs are getting lost, TCP will also stall.
> 
> Maybe try a UDP stream, say 500Mbs. What is the packet loss? Try the
> reverse direction, what is the packet loss. Then try --bidir, so you
> get both directions at the same time.
> 
> 	Andrew
> 

What is MTU? Bridging is L2 and if MTU does not match packets are
silently dropped.

