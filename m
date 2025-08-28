Return-Path: <netdev+bounces-217597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B97B39264
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 06:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9096C7C0316
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80791F4162;
	Thu, 28 Aug 2025 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EudWopbJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA92144D7
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756353867; cv=none; b=XtTtir78Q8nNEgXJT00gj4VePCj4/UXxjznGo5RDbDK9wTjobHTniGJjJSelE1SMKst/oG2FnF9sbvouvCVUl+wuL5edmGzKut2KqTBvQwZCiHKLrrgC7OLZg9ZpoHo2ekQj6vWUAuygXYDbMOt0O9UH3ddrULYpYY42Ucd5OfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756353867; c=relaxed/simple;
	bh=gtOgAdp0yT+NL1OViY+er+sH/YrclLDXbWh7hTyG1Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvcPodGTRN11mFcxfubGjZIjDmxo69ZHcoED0qg+eDFydME5L+d9AMVybrtGOmulewWlvtJn6bB8jammNBFgKRnw5kMLKj6ceuFQLcVb9LbYceTefg/bm+HhXIXZcDdomxGerrp9Fm8ZhEkB2H27Mtf461qtZmiXBMZa5cDisK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EudWopbJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24456ce0b96so6325215ad.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 21:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756353866; x=1756958666; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0DvYBS4p/VobAI0awl0GcVuGCpHvaVuv7N+lckUpnd4=;
        b=EudWopbJRxD/g+zwpUfBkeMx1ff/q4gaClK6QKJr8SF3UR7g3SoHFdDHOgxW7q0HTl
         QyYX/i2ddzZ0qcG2zV4T2SKHGIpcxEoXLXoNiMULsh0Kk3EKBN8ROSEzXntxxVtEyt87
         3dN0hxPrKNU4yhhv/FNBkPCSHA1YT7aWtg8u5JB6dRcy/fk+2JUZyJGmoBE2LdNz5YCv
         1JUdypWIKfwzUL+6pPrxFxFFJNjx6J8q5EVo837IF54EQslHs3+RhFcC95mFoKDDnpLV
         TVVNLF2e3dS2uCldkKvUrLHRZZ/m5HW4VzPq1T/Hqn11Ke48jGm0vimoc8I/ZiWpww+9
         lr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756353866; x=1756958666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DvYBS4p/VobAI0awl0GcVuGCpHvaVuv7N+lckUpnd4=;
        b=I7E1QfYABHl01fU6hZI7+OMJ3UIvt6lpAPQ80b0rGAlKdq9jT/2vcVcpOdnuVq+aNy
         nHVkYaxXHIGAj3ctR7JZuE9v6hpneSMqjLjjxK8l/Mcz5ggU/sSAk2AwuoywdbtrK4YQ
         2aPLh9AlVxQK6EgkS1eaChC1Nf5ieGzMatzMsTONes0eOSwK7VRCfTj0ycyy8k5xRcNK
         uEWw6vO6SqqqFCOtRqrHI+CYzLzkd8sdFEW9z604c62ameE7kSzt6WReemX2GGLE9fDx
         iafYybW6QgFDSy/D3IrLCO/PxDQoYn8O2N+lXoUHxmVLOSNgoOgzsJ2KnJGYKCdma8Xq
         3BqQ==
X-Gm-Message-State: AOJu0YyYLy8dVJGWMDMtvrel6iv+JZ8TYeLp8c2kbL55Rxuv6dUQFLIi
	hH/rHQlhmMibrvSuLJYcI35Z1VL+cbOPXAfcICeeWpXCEL4gy2oAFmD6
X-Gm-Gg: ASbGnctwQVQ8Q/FNv5MBsTA1gkVXMCP4xjdZXE09SBl0rmUMF1ExTnYlCjpyFZSvR77
	jFgiwyvmJaeHfnUGkxrJjtOUA9z09zhYA+GgUssopf6656DOx7Rba57wW4emnD3pwJ3WOD8+Qe/
	K6xRE0+tWrCWS65FKXU+qNgo7EC8yN8UEeUga66KJ1BYPMw8zVIAoXwEteRSMzaJZTs3iiE5u8S
	P96d81nyR6xpBgP3ygcN/vWaH/S6R946Gd1l+sCa28BbyXMnR0UMqiREi+OrKgVkm4IdWyESCvR
	4e7BfIDMmUleiDcCi66xOD3jixkQBiDWEELtMSAjfxnTPtCpBg9ciT4IkN2mgSwndJ98UHGkkal
	1yCy6B8rOUeP03E9PY9jHFr6CyzA=
X-Google-Smtp-Source: AGHT+IGQOieiq4fUCAfS2uAVZvm0Kinwp15cpfGmFA4O/G/4ecvY36rgkPxFOIIP4S+/FtoLUV++rg==
X-Received: by 2002:a17:902:c947:b0:246:50c0:ae8b with SMTP id d9443c01a7336-248753a2457mr103163125ad.0.1756353865710;
        Wed, 27 Aug 2025 21:04:25 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3279b4b279asm761787a91.6.2025.08.27.21.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 21:04:25 -0700 (PDT)
Date: Thu, 28 Aug 2025 04:04:18 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jakub Acs <acsjakub@amazon.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH net] hsr: use netdev_master_upper_dev_link() when linking
 lower ports
Message-ID: <aK_VQurV1-eQ0UJ9@fedora>
References: <20250826013352.425997-1-liuhangbin@gmail.com>
 <20250827180603.001b85b3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827180603.001b85b3@kernel.org>

On Wed, Aug 27, 2025 at 06:06:03PM -0700, Jakub Kicinski wrote:
> On Tue, 26 Aug 2025 01:33:52 +0000 Hangbin Liu wrote:
> > Unlike VLAN devices, HSR changes the lower device’s rx_handler, which
> > prevents the lower device from being attached to another master.
> > Switch to using netdev_master_upper_dev_link() when setting up the lower
> > device.
> > 
> > This also improves user experience, since ip link will now display the
>        ^^^^
> 
> Why this "also" here? You haven't mentioned any benefit of this change
> up to this point. AFAIK having the master link is the only one?

Apart from the "fix"(I thought), we can "also" benefit of the ip link output.

> 
> > HSR device as the master for its ports.
> > 
> > Fixes: e0a4b99773d3 ("hsr: use upper/lower device infrastructure")
> 
> The current behavior is 5 years old, AFAICT. We need a reason to treat
> this as a fix, right now this looks like net-next material..

If you think this is not a fix. Sure I can remove the "also" word and post to
net-next :)

Thanks
Hangbin

