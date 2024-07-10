Return-Path: <netdev+bounces-110515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D77E992CC57
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15982861EE
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3E584A27;
	Wed, 10 Jul 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpkaeFse"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0817BB17;
	Wed, 10 Jul 2024 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598250; cv=none; b=q0kqy13tACOeF5rq7Qwm84rO+hubI7Iir+/AYz4v7FgeOiO+gZqFvYm9HH3SCjjzU6RL394GCAoyNrjTYzrE8dDIGjQKpHFn6y8NXFw1l/ISqCPRuSbBeIQXzMftZxGuxgXx8uAfVirtAhx3ysnrHFVfxY8ImD9ivrASSBraxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598250; c=relaxed/simple;
	bh=i42cyECbHzlN26RdEGKZmFhzW0fNAKgkRQXnsJsIEEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7cxgulSGLczDQJ1N0kYicMNQG/KZEftiPDIEHL8yjGDx+7BCaeph7kqVPeNZkli4yS7dULhsScVxKrz00ix0C5iuHyDwugeioUpwnhT62d9rsIX3p1bDmOfwrTfJGy5/uSKD6OxO58LNt2+oc2iUmszzGItvc+0eoWAf5c/maI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpkaeFse; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb0d88fd25so3664065ad.0;
        Wed, 10 Jul 2024 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720598248; x=1721203048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL3xB5qZUeDvQW0Bt9eHIWR5Sgy7Fo6pxuuDb821234=;
        b=LpkaeFseIh20YLaDxEVbONEG1D9v17osqvud3CAhqBbNbjv5BjBinJOyMnekOhhhAX
         gaW4S47t0/ADuOiEQ4DyH92f/W1lh76qa9kAkPX9KmK9rTw7QWzIcwF+KdqxuI8xTrP2
         AIpwv1ueJUsX+mNEBmhcy3DkLS5rx/bLGuwsi0KuW7zX9GWEL8X/0nA88RH+VPJncWGY
         neOMGavYWmjvTeDXkzTkZcnKVAFaTUSuCfVj3RyB+MnqWVNGRzwcGJekTG9JaxSpC/Wh
         1eSX1iKTmg7XZ6N/2iflUze9FaPZcMKFjoX9Z48/dvOky2ntsd8QZ6qvZnyi57u8EWEc
         nE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720598248; x=1721203048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL3xB5qZUeDvQW0Bt9eHIWR5Sgy7Fo6pxuuDb821234=;
        b=LzUs6y2Ej9aC8IApbqCBvIvhfK1GuThv0xJ1UIfiRID802eZCTSjxXIKcgJpX+qaUG
         wZW+B8pjDIL6+Jry2ScTAGMvRE+bvvo7hHGUNc+BwqKFH35ksgnZK1/+h0fC1dNeqbdY
         9CVsGjv5n7Yg7bO6NzLKZBSyTxsLgN5PRUaO3aTwR715gUQUXTESP6a21PfMBtEbZ9fD
         MmqqR6TOwwIswgfl5cMR0XXqUmDcDJRJckjjf990TWgXMUyNl7inYWLxyQDYMc7WdSAA
         dfr75aWPnPEi3nZObclUYIYwqBeYycUjH5P26IC3Y1ZUlrcQ0EqkWXAIHtqEs6Vijk0J
         opXw==
X-Forwarded-Encrypted: i=1; AJvYcCVTFpR4Uvw5pK6UVwHw38YSweoQgiG6lGF4nhw8vKDZambKRJzXs6TX5P3PaoErip6Mf6czQwxXzJXcS6fms9LCORacKi+NTeFyUgV6TAMvziCLlnjKyFK9nM54f6XOUWEVTcpO
X-Gm-Message-State: AOJu0YyN38sMrVRbeZ41zAFymj21IO/VDwILBtQNQJzhFmmGdIG4Chdn
	bRAVR2cPrXcKD9sPqKpINE8JW3bXr4wptkwJ6ZlqHeoEvNGgqJZk
X-Google-Smtp-Source: AGHT+IEuKjHd15gR0P5vFk2U3b61+gsTLHqlQVreOnbUjVAf1fwZQtG7Ac4RBBngQ0FVGYThZcZ7bA==
X-Received: by 2002:a17:902:f141:b0:1f7:1bf3:db10 with SMTP id d9443c01a7336-1fbb8015510mr44928735ad.20.1720598247862;
        Wed, 10 Jul 2024 00:57:27 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6b31977sm27555975ad.287.2024.07.10.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:57:27 -0700 (PDT)
Date: Wed, 10 Jul 2024 15:57:14 +0800
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jianheng Zhang
 <Jianheng.Zhang@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 1/7] net: stmmac: xgmac: drop incomplete FPE
 implementation
Message-ID: <20240710155714.000010cb@gmail.com>
In-Reply-To: <20240709171018.7tifdirqjhq6cohy@skbuf>
References: <cover.1720512888.git.0x1207@gmail.com>
	<d142b909d0600b67b9ceadc767c4177be216f5bd.1720512888.git.0x1207@gmail.com>
	<b313d570-e3f3-479f-a469-ba2759313ea4@lunn.ch>
	<20240709171018.7tifdirqjhq6cohy@skbuf>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vladimir

On Tue, 9 Jul 2024 20:10:18 +0300, Vladimir Oltean <olteanv@gmail.com> wrote:
> Hi Andrew, Furong,
> 
> On Tue, Jul 09, 2024 at 03:16:35PM +0200, Andrew Lunn wrote:
> > On Tue, Jul 09, 2024 at 04:21:19PM +0800, Furong Xu wrote:  
> > > The FPE support for xgmac is incomplete, drop it temporarily.
> > > Once FPE implementation is refactored, xgmac support will be added.  
> > 
> > This is a pretty unusual thing to do. What does the current
> > implementation do? Is there enough for it to actually work? If i was
> > doing a git bisect and landed on this patch, could i find my
> > networking is broken?
> > 
> > More normal is to build a new implementation by the side, and then
> > swap to it.
> > 
> > 	Andrew
> >   
> 
> There were 2 earlier attempts from Jianheng Zhang @ Synopsys to add FPE
> support to new hardware.
> 
> I told him that the #1 priority should be to move the stmmac driver over
> to the new standard API which uses ethtool + tc.
> https://lore.kernel.org/netdev/CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com/
> https://lore.kernel.org/netdev/CY5PR12MB63727C24923AE855CFF0D425BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com/
> 
> I'm not sure what happened in the meantime. Jianheng must have faced
> some issue, because he never came back.
> 
> I did comment this at the time:
> 
> | Even this very patch is slightly strange - it is not brand new hardware
> | support, but it fills in some more FPE ops in dwxlgmac2_ops - when
> | dwxgmac3_fpe_configure() was already there. So this suggests the
> | existing support was incomplete. How complete is it now? No way to tell.
> | There is a selftest to tell, but we can't run it because the driver
> | doesn't integrate with those kernel APIs.
> 
> So it is relatively known that the support is incomplete. But I still
> think we should push for more reviewer insight into this driver by
> having access to a selftest to get a clearer picture of how it behaves.
> For that, we need the compliance to the common API.
> 

After some searching and learning about your commits for FPE using the
generic framework, I think it is clear enough to me to implement the new
standard driver interface which uses ethtool + tc, and then the refactor
of low level FPE function can follow.
Thanks.

