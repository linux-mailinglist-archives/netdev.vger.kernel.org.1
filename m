Return-Path: <netdev+bounces-123186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E184964021
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B231C208EE
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3286A18EFD8;
	Thu, 29 Aug 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGj85rDs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3F18E36F
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923745; cv=none; b=nHCzGR1WKrBzECpADCfSnMWiljPWTOt2CnubKVMRN7hJmL3KohkyPtSEcX3j3M23ZaoGQi8tsjy0sNn5LyFAAohjTlKzUjnl8TfrrraDh3/vIkfojwb3KeOpjyW0l9D7j1YBQYRY3eLNLhsTJgkBiH+jMeCVy/Let/8+OKvprPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923745; c=relaxed/simple;
	bh=Fr87K6K05I1PHCxvShbULjDlyeEsS9XDMtISg8bgQJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJKlQGe5lgKL+G7Wx9kYwzxO+nnZgxSnpseGzPyA4LdBcDBavjDVJMrUvZX1vNXjPNEGq2R7OzGrShfF1rDUUWxTuCjtTRpmULwLFamqDFnIjChfcXZOBUU34biCwAExDAZLi+suNoYD1i2gf2jI5wy8pMk4lYS6gB8DFIZBzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGj85rDs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2021c08b95cso11779675ad.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724923743; x=1725528543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZI0Q9Gl1So4Rj3j54ChfdkqE4JTXnUEVN5Q00SIiKs=;
        b=XGj85rDsa20+V/mR9k8O2NtpcAV0zwIdewvqPJI/4sh0XXpQuhQIWf472X5hZjh4Nd
         aqFb1rSsjEpi8vPccauH+494OCmeyV7SqlZgbRoO1DCcFSJ5WZLg4T/jMrA5NylJr41i
         NCumD3+8SvVWQrIbznfnOL82JIHfK2cTuLVKIh3tdUEUvyR5e2wCIcnL1VMjwyQX0BrR
         ivWMHjxaA1ESO9WkY6Tu7cj7EPi1xTGO9jCsl0mctkAxE1WOue1QAbe6LpbpJyGl1oCW
         kz4/6Fje0Sh53U5+Oj7eQoWpstvF64XFv2lp6+rMgElPcw9fps4UxOY/DneqG7arh6fd
         xi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923743; x=1725528543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZI0Q9Gl1So4Rj3j54ChfdkqE4JTXnUEVN5Q00SIiKs=;
        b=P58CVs0RtPH7yJaGxAagXHaxSt6oze0gfK23oTKQDjlF8xbc5UyeC5mYX3SFZerF2w
         bk2KAYDgkVbGVNB7y6BW8J5wHDkuwVyRU3hXrR/tllIR/cZZXDMsre44+5VCVVCBxcz8
         bg/IMfleBIQ3JHrYuXbpLKCWzbFFJyOewP5rnGOWYekSZ5eBM0CELzGR2z0ZaIMXJfiI
         x84C+M6xVvT8X43y9UmoKPLYarYbAEbOK85h2Py0vSJ0BMEANRAv1NI/iB0ETP+6EjBq
         s80JhSSPDem07gwP0A9y7zFbwYFkfbGGhpiSoYXVlEsW9/Ox2pba3y98cUAPjnvw07MU
         3wVA==
X-Forwarded-Encrypted: i=1; AJvYcCVwVRTfPpgZqLebKiqFUdi7pu3H4PY9G6v/f/kKtn/7g3ZxA8A0xg6+XCXKwD5dmfsH/N6eyDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmAQWBh48SMgSinmZYNxGREkU8qFw2NjHE9jfFa4IOjwGijm86
	O0pTn5sHktSYbl6YA8RiITuv46ssSWmSRWB0eSkxpcMzrMP0cA6H
X-Google-Smtp-Source: AGHT+IHmphtPlZSuoUjCWgBAdjvztlh26qKhBX7aiIYZ45XYQS7l5OFUFZBtho5uqke0QcX5z9pB7A==
X-Received: by 2002:a17:902:e80b:b0:1fc:4680:820d with SMTP id d9443c01a7336-20516703755mr14509685ad.9.1724923742613;
        Thu, 29 Aug 2024 02:29:02 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b14ddsm7675065ad.19.2024.08.29.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:29:02 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:28:56 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCHv4 net-next 1/3] bonding: add common function to check
 ipsec device
Message-ID: <ZtA_WOA-E4qkBBJO@Laptop-X1>
References: <20240821105003.547460-1-liuhangbin@gmail.com>
 <20240821105003.547460-2-liuhangbin@gmail.com>
 <20240827130619.1a1cd34f@kernel.org>
 <Zs55_Yhu-UXkeihX@Laptop-X1>
 <20240828144326.GN1368797@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828144326.GN1368797@kernel.org>

On Wed, Aug 28, 2024 at 03:43:26PM +0100, Simon Horman wrote:
> On Wed, Aug 28, 2024 at 09:14:37AM +0800, Hangbin Liu wrote:
> > Hi Jakub,
> > On Tue, Aug 27, 2024 at 01:06:19PM -0700, Jakub Kicinski wrote:
> > > On Wed, 21 Aug 2024 18:50:01 +0800 Hangbin Liu wrote:
> > > > +/**
> > > > + * bond_ipsec_dev - return the device for ipsec offload, or NULL if not exist
> > > > + *                  caller must hold rcu_read_lock.
> > > > + * @xs: pointer to transformer state struct
> > > > + **/
> > > 
> > > in addition to the feedback on v3, nit: document the return value in
> > > kdoc for non-void functions
> > 
> > I already document the return value. Do you want me to change the format like:
> > 
> > /**
> >  * bond_ipsec_dev - Get active device for IPsec offload,
> >  *                  caller must hold rcu_read_lock.
> >  * @xs: pointer to transformer state struct
> >  *
> >  * Return the device for ipsec offload, or NULL if not exist.
> >  **/
> 
> nit-pick: I think that the ./scripts/kernel-doc expects "Return: " or
>           "Returns: "

Thanks, I will post a new version for this.

Hangbin

