Return-Path: <netdev+bounces-204756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FABAFBFAA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAE51AA178B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 01:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166631E0083;
	Tue,  8 Jul 2025 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRQg8qR1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1A5383
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936929; cv=none; b=jtEKgJ8H+tiik8IfileVwCeOmxrMT0JmOdJCcT0dci53PLddMVcp+pu3A/cFOxx0Uraa8yRkf2imwYigl9x4pG0QXjjEi4BIum6nSUbEheAYABY6bomv57pIpScdOwraDlFnaZKS8HJARmjWgNJ69I5+MJQ9IWZKCkZXuOpR+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936929; c=relaxed/simple;
	bh=lWq2QVnb2rHkSVmWkifSy4zaxU3cbBsnVAff2DFUkQ0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=E6HXsb+hYLQnUotrzfP9UySUNjsQe05hVXnnAGpaeSO0ZEoY5cDY/EqLS0zRtQRfwvHwPdnGb19J1Jqn4LUAG2jHLhvc7qmSBPW7IS5cxD7HaMrkOvHXUrWXlQOyEouVn1DEe9r4TyJ1+510swE+nDCSwzA94I2JUUaaQsQdGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRQg8qR1; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e812fc35985so3139365276.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 18:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751936926; x=1752541726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fo3ArsZMIZd1JI/Use8Ux9cQouA96qqNLspHVLhZ6cc=;
        b=eRQg8qR1DbxtfCql+6xDlJARF5NTpPdix8p7TCzovhbs4ySB9uYe2gXVoOOtkR8rTF
         BGt08XPtJuA2xNe2KNxH4tHBbyAOydyHXV13IXnGBzYJ9Utd/oPZlDrC7SzNRBdUnxdX
         ryPS6b+YO0ru7yELSq1/7W90W9Tv7TcFwYNJ6hqsNOohyoDOKUD9ph6JdHjeulDuJgMS
         btB9CBb6oB5TOOSC1F1YBCBrbarrJlJkiic5MKOTP58fBVfUIP0OF+/II4dMViY9Hwxf
         mKfzvuIIPkQYY+gRX322TZwaPppY+7YLs2/nmi4i1FMtY5ITRgEEKHqwxtX28cNGL4y4
         bbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751936926; x=1752541726;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fo3ArsZMIZd1JI/Use8Ux9cQouA96qqNLspHVLhZ6cc=;
        b=KmlMcCeCH32m4lOQ/IRDrn0VSp6neEGYRQOk6fZ2wus1qfkcmhqZ5b82Y+KdkCgxrJ
         +isVk+PkljStvd8qh7RoFOJb+U/nHevgtqVGbVZODi6UJ5M76HTYjzwBArXB/0bZMckF
         JomT5sK7KwEUC3+APqMPQa+uNCGxUwsumFFkA6+mFNBT2bkI4dyK/EVhJ3M5ZPVJsplF
         cy9vpivjzBGARZMAFYUids3+wHaeVuqqCpjlMlKyIi0djJituOre+Zp5c6nFeW2Aur5R
         MdozvTnfhrAdQJNO47TMXYcBxhz2V0ToXAhxVKEgiHMkpG0A7lQFJjL1FGiJ+9arL+5U
         BLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOs4qOq3Jvq/qZSsGRiyUsN+dy1D+AhcmZbTPJDIMLszqk2Auy7mEY/yyKMeLHcBj0o0bpHvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkA0xTdHeuUssX81fgbH0kzgskA73hOz+Dw7bXGhWUDp1M5S/5
	EMsbj30Jqf52R5lVRCOFn6Ze6Ay6xvVJS478ZhUUbyLBhiT72OgNDq51
X-Gm-Gg: ASbGncuLA/03rFUoSLnh35DNd1BVMq6OmJpt0b0qxgprvJXLd15jzqU81w+pyH1n8/3
	90OJskZKWoOzJ24xxYL2wOLLcZ/foOGqHMvE8KdFmE0X1Y9OUy+BARD8JsnJ9Tf5SrbY1S0XQge
	cplKPAmYaudVmrAMS3T8QHZUGmzXJY2XEXc+kfb3dZ2lcRjipfFxpctTECXLI1iEHREkzHeh9qq
	FWvnCtDCsSlNqudyPtQW7ndEwSx+SS+h9TnAXKkPIKGJgTiGdtX717273XSDq4HsETQTJt1V+pH
	2kQncXKuPOeXP96M2OAaajhOdT0obTrrl4jrFVDdwayNH+Shb4lbOiXcQ5hhBbVYNt5SE1lTtOf
	GjdczuT1+pcIgpq3UhljMKo9oTPY4J89tLaHEVaMG7kSuYAsusw==
X-Google-Smtp-Source: AGHT+IFgeEUu/KX+4P3pIcWgv63nDyN2P4eBvqyggJmspnKbnHG5VwkcvLAdro0L11CiYjeQ38cS2w==
X-Received: by 2002:a05:6902:1024:b0:e87:af63:ebc9 with SMTP id 3f1490d57ef6-e8b62a41056mr902924276.12.1751936926247;
        Mon, 07 Jul 2025 18:08:46 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c3032f6sm2924705276.4.2025.07.07.18.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 18:08:45 -0700 (PDT)
Date: Mon, 07 Jul 2025 21:08:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686c6f9d25851_266852947d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250707140206.0122c47e@kernel.org>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-3-daniel.zahka@gmail.com>
 <686a96ed46da5_3ad0f32941e@willemb.c.googlers.com.notmuch>
 <20250707140206.0122c47e@kernel.org>
Subject: Re: [PATCH v3 02/19] psp: base PSP device support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 06 Jul 2025 11:31:57 -0400 Willem de Bruijn wrote:
> > > +/**
> > > + * struct psp_dev - PSP device struct
> > > + * @main_netdev: original netdevice of this PSP device
> > > + * @ops:	driver callbacks
> > > + * @caps:	device capabilities
> > > + * @drv_priv:	driver priv pointer
> > > + * @lock:	instance lock, protects all fields
> > > + * @refcnt:	reference count for the instance
> > > + * @id:		instance id
> > > + * @config:	current device configuration
> > > + *
> > > + * @rcu:	RCU head for freeing the structure
> > > + */
> > > +struct psp_dev {
> > > +	struct net_device *main_netdev;
> > > +
> > > +	struct psp_dev_ops *ops;
> > > +	struct psp_dev_caps *caps;
> > > +	void *drv_priv;  
> > 
> > not used?
> 
> I'd rather keep it from the start. The driver-facing API needs to be
> relatively complete otherwise drive authors will work around what's
> missing rather than adding it :(

Sounds good.

