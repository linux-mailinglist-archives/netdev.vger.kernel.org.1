Return-Path: <netdev+bounces-56535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A73880F442
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B8F281953
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A513A7B3D2;
	Tue, 12 Dec 2023 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="BEp6F5BW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832C0B7
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 09:17:32 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d331f12f45so7790895ad.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 09:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1702401452; x=1703006252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AV5Lpy/FmGlD6uTwu3DedMj9WKbwIn9FCuRUo8JWf8=;
        b=BEp6F5BWAjdaGTKCeZcLcPQou6hnhzkTn8BrIeWIsPOB3bquSB6GGuylk2d4eodrh4
         2QIKQ8l24KJGLBBc0w24UUQcJNBrUsyn0C4cEhHK+RiInCXYG+91ICLGxb/HZF/p2zlq
         qhklZXf1SKd7SdjwgxGs1477rWaXE+MD2ZX8jQ3TwF3OJpYePQ16zgZ5XWNULfs1fzZL
         cnMIjWU9TqUOamIQWR/z9/kcS+JgQ57NdDCV8uI+SRtp1E5SuublmLOu1spElNQ7v78q
         G0RhWIrkvSAp2inDr0mD9/xbb636/NioCTu07/wWn2+HWOwJqILfOIuLDaEQkFvOVvQX
         dC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401452; x=1703006252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AV5Lpy/FmGlD6uTwu3DedMj9WKbwIn9FCuRUo8JWf8=;
        b=Ntk7+tpkF8vVjFVtZ8VOHcqqAy2rF+4tagv7kyn5e0JIwcaUKLNCZZaZSXVlVeAlDo
         6O0BF9TBRISOz9u3vA3IxOEVBAoE7GZt2ShcwhxdgZ6/hTN9FWr9TjyeHOmvpOYLigt3
         vkI7xu0xfkpExtnHrK/JLSTxbczk1iGOOA2Uqb5yBM7g0Z1dLDZ1g3YnkpNRQK3JfLHr
         ajB5RXP5p/KHoXtN6X4aMlqmzdsCPhKkYgZak9cBrt4pGOS4mOPCaa88SuppRuVmqfmV
         OQl6AWmP4XgmHmKtNMGEtrO4h1gTjUI/U9p1b20Kk/1zFM5a7J0SeWm7PZsozsLAJqoP
         hTkg==
X-Gm-Message-State: AOJu0YyaiWnOa0BktF0fzxOpcWsCDoy7ZFnLyzN31n1/9dZx5Ey1e8MC
	RUqzAhdWrm0ng0tTkPhYIiWeFA==
X-Google-Smtp-Source: AGHT+IGXv9SQ+t5Ea5RvYnNo6mDoj+vC0/iRcgEMXcz6NepKf0EO0yMOqe7jpzWA3z+NObJPilEzJg==
X-Received: by 2002:a17:902:be04:b0:1d0:965f:b003 with SMTP id r4-20020a170902be0400b001d0965fb003mr2954208pls.67.1702401451980;
        Tue, 12 Dec 2023 09:17:31 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001cc307bcdbdsm8904875plg.211.2023.12.12.09.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:17:31 -0800 (PST)
Date: Tue, 12 Dec 2023 09:17:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Fernando F. Mancera" <ffmancera@riseup.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: Preferred term for netdev master / slave
Message-ID: <20231212091729.56e32e45@hermes.local>
In-Reply-To: <6715f514-f3a7-4297-8720-53872eea8056@riseup.net>
References: <m2plzc96m4.fsf@gmail.com>
	<6715f514-f3a7-4297-8720-53872eea8056@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 10:57:05 +0100
"Fernando F. Mancera" <ffmancera@riseup.net> wrote:

> On 11/12/2023 15:05, Donald Hunter wrote:
> > I'm working on updates to the YNL spec for RTLINK and per
> > Documentation/process/coding-style I want to avoid any new use
> > of master / slave.
> > 
> > Recommended replacements include:
> > 
> >      '{primary,main} / {secondary,replica,subordinate}'
> >      '{initiator,requester} / {target,responder}'
> >      '{controller,host} / {device,worker,proxy}'
> > 
> > Is there an existing preference for what to use in the context
> > of e.g. bridge master / slave?
> >   
> 
> Hi Donald,
> 
> In other projects like NetworkManager, rust-netlink libraries.. the 
> terms that are being used in the context of linux bridging are 
> controller / port.
> 
> > If not, then how about one of:
> > 
> >      primary / secondary
> >      main / subordinate
> > 
> > Thanks!
> >   
> 
> Thanks!
> 

For iproute2 my intention is to replace slave with member
and not use the term master and instead refer to the interface as bridge.
Ditto for bonding.

This aligns with some other OS and implementations. 



