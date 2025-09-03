Return-Path: <netdev+bounces-219636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4ECB4272C
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446205676B2
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD64307AFC;
	Wed,  3 Sep 2025 16:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9BB304971;
	Wed,  3 Sep 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917876; cv=none; b=UITIU8MtjdOuzMSxjSRkDsbor64fAmkSrsyleJ5fxYN9Khg0S2oBMvnyOR4XAAs8WqBUPxYSLJHeNJ0AXZnNMR2wkPklGjoLgdFKh7LbkCrZs6AZEo2kGynmXel6IwZ/3ZAATKhPdrk4wo9tScA7lyxAJeUcqriDw/Ign2SPmXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917876; c=relaxed/simple;
	bh=ariY+FcwAGaGYyROXJ//ip+a+qed9bzuJqi587Emzwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWp5Tzmz9TkIBpWrMPmuYdpnnc23M/eahLFgS7WNwspHiOsAP/MPKgXzZpYKFxP7mNrDAPT02enD3hDyuYDtkFJGnHmHZfxRQOHIBBD5j8v/RkWTVibBIUDdRjeI36+4mgvqqNGSTy+KzPZj23mkYt5E/GK8SI2dxR9gYZ+Xv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61e8fe26614so61197a12.1;
        Wed, 03 Sep 2025 09:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756917873; x=1757522673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9FL6tV8n13zlBvWYA3e3xfxYg9pjFXyRGdxyyVqxgY=;
        b=bbXFH0FVl/pQx5GEvDg864XUfVolmy5QOnHAKYX7kHhRYLK1Ple3ppuvf/brX4NRDH
         5TsAAIk4TcNIoEU/FV7MZqRqlUv9yKJNKQI3q8T6vFjHli8KFGAqddoxLNWLecuqm5il
         d+VaoeUE8O3fcqLsFdPmZ30Lzk7w35coDLek8Y0gcaHD3YatH3ITENxB5emhhOi0Fh8T
         z2alWqkqKXL7N0wNI+r9rg4XwwgVSrlWouYLwK3Ymfyc5ZO4un7Algmp1aqRbhEp9d+O
         ic4rjth0Xxsp6jx6f27omJLkZQjGT1yPtoIj3RrrARAxXKVwH7KJzvMZNvdC/JMlp3tq
         9b3A==
X-Forwarded-Encrypted: i=1; AJvYcCUi9CrIR6d8MVFobzqleMksP3bL5AR9IB8m7yQygNTYWkgeZjvLgV4n3uxS73GKLb6h8hijC1FWsybwRGE=@vger.kernel.org, AJvYcCXQWC7SH6uVxkuRMtH8XIsozkxy7RdlvoEJnYl1VaRit81eBpx2nb2p2oVZ/TOegdA6tapVSUV6@vger.kernel.org
X-Gm-Message-State: AOJu0YzzOqa3Qor8leQ51+RAnQphQrKWkpdZtVIB3WsOJU3NoRArt3io
	8jw6WoDAps8qsnqkmq7RN8wvptJ6rCgGnTz0WTW0ollgM6tmkrns9iBE
X-Gm-Gg: ASbGncu5qlUqvgrEr64Y2AptVFqYY5WOyhw5mPyzVKLx9F8FqsRTaIe2ibXAbIaYKsu
	KMPU1l/LrjzVTuHelZvhYN8ATL+qSmvV++vGhS4DWKFVbRLpUSNqbnEzDJ0FAzxbkoOyKYjAGFB
	3w1+Q4Agr78x3x6YTkKcgymp6YTcacj6V3X0nNiC9qtcJC4aRmTF8NuvMGivMoGfA+KxPOQO1NS
	NjVUAsjwN3Q8aw/iDa6q0VVjcNWPszL5NAp50Nv8VXouC4kaEISb6TOJiErbXGPjhBK/iYsfmyN
	1Z1sOqfNYVu8xEhVjZrUr1KiWI/V0J3kCmHVZB4ldUmXEBoEa91lje9tcfjAyk3uS1U6R1CNCtf
	rLq1jd79T0eB2
X-Google-Smtp-Source: AGHT+IHfDVVrl1wHNyJKDwCmpxOKb3QmVNSXv+pI7nurrc1BarqU4QHmNG3rluy6cGrnQiIAHjnrBA==
X-Received: by 2002:a17:906:5909:b0:b04:1b90:8d7a with SMTP id a640c23a62f3a-b041b908f01mr1209368966b.27.1756917872692;
        Wed, 03 Sep 2025 09:44:32 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01af44a01fsm1099042866b.23.2025.09.03.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:44:32 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:44:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, calvin@wbinvd.org
Subject: Re: [PATCH 3/7] netpoll: Move netpoll_cleanup implementation to
 netconsole
Message-ID: <vxad5ijytxk66i2rja2uzmueajzpbccy3xcc4nokfnc6chapqb@j2kxvpyb63rh>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-3-51a03d6411be@debian.org>
 <willemdebruijn.kernel.2c7a6dc71163b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2c7a6dc71163b@gmail.com>

On Tue, Sep 02, 2025 at 06:49:26PM -0400, Willem de Bruijn wrote:
> Breno Leitao wrote:
> > Shift the definition of netpoll_cleanup() from netpoll core to the
> > netconsole driver, updating all relevant file references. This change
> > centralizes cleanup logic alongside netconsole target management,
> > 
> > Given netpoll_cleanup() is only called by netconsole, keep it there.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> What's the rationale for making this a separate patch, as the
> previous patch also moves the other netconsole specific code from
> netpoll.c to netconsole.c?

I just tried to isolate the changes in small patches as possible.
previous functions needed to go all together, given it was they were in
a chain.

this one netpoll_cleanup() is more independent, so, I decided to
separate it, making the patches smaller individually.

> And/or consider updating prefix from netpoll_.. to netconsole_..

Good point, and I agree with the feedback.

In cases like this, should I rename the function while moving, or,
adding an additional patch to rename them?

Thanks for the review,
--breno

