Return-Path: <netdev+bounces-234555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D630C22E9B
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20ABC3AEC62
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65E6223707;
	Fri, 31 Oct 2025 01:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjC3aXiN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497C1F462D
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 01:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875308; cv=none; b=omE50QtTfinYkd5/ZlAcIgKc4riDOSpgs/1hISYqR2LGCP1MvRToUpzI7YD8g/eJh4JP9AZMcdD3rQfIwKvRJsZ7kPD0KiEEVfRwVZTJ4PKr0XwwCItSA3XqozbBIsESQwhmwFyqnicSTzNIJ6uIjlQgyZ4b/1op5lYbnZaUi3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875308; c=relaxed/simple;
	bh=Du9ZyS2Cbxuruu3547ww7SVm0S6hl9QhWSPLchalFho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr/BetdN0ee1SbGlTOWZIg4pqXhN7KMsMy7oagMUWhjunEcgJRUgUGw6z01atisMpO4jOghsyCNv9sCCKl93meHInrgO8omzOEWchlEx/hv61HMNHjPy/GmKsPI2vOq30Q4ztX6Rs4/nO4EKCHKYL2VQmWo7VWD3ksvYPNNDehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjC3aXiN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso1802021b3a.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 18:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761875307; x=1762480107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XvW3x2A1aiKOi9TStaIpbipIp65f9ks4AmwOQj0V3qw=;
        b=DjC3aXiNFKQHdep8PFKrSmRcv6UI+Ji/eZcE+fVIsPMrgCOzHdZqvJkeMHo0DYixJS
         H93zbZ4PGJkQIqmfdlwi9+MzXuntVpS/fk7W6S2grvK/4bU9ZfruZTp22Ep0CsWXve3u
         RJSGFA0Za21qarNqddmAza2vC/b8/zVrxVpvx00mngJydT5aVcHQa8pxZjNrCeib4fS1
         C8/gznESiYX8t3NxdCj5WsRZ1oBXZlord7ksFE1hiqQgY/7nWtwaBMu1eEsAz7GTGU+y
         hCxDjkB8jaGVh5wDP7i3naAwXQsFyhN17sbZke1eUn1si04lURo9rrH8BNUgXIofz/Sq
         d76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761875307; x=1762480107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvW3x2A1aiKOi9TStaIpbipIp65f9ks4AmwOQj0V3qw=;
        b=sna8OkTal9KoE5vWO2hsx+u2LhO5hwtfbeprgQvgcJj2pAonj6lozwSL/3GsL0j0D8
         K2LaZg/sku8YUJxWak68AFWQjARjmCFXdHrTV1w+S2iGXUZFa6nHYi19cVhTLLGE+FHS
         sCVDLX62kt/kAM8MtpNJ9n87mYCS0p5ZxJt8+j4C+gc4MNU1NFn1ftKBpGAseTFE205B
         EC+yu6sCKZbouPpiBWpYYS270O7PyVzIWpDpC6s7l09cWmMRkcPxAWhBzYpmMUPwc+tS
         6TjhDrdqhL5TLkFA4Nmz1kfp6Qs+IlB1EYsJ6LDLxQdk5o3p7x1q5fa8IM27MRjAPIp2
         EOcA==
X-Gm-Message-State: AOJu0YyMk30kCvBva32PFEV4T4JGNN6pIbpOKAE4bgLyh00CnulRDoqJ
	cHahLQblFKzMddjC9LuPDGluHWfxLU9VKI+P2WZHDmpItPou88l4Bi+U
X-Gm-Gg: ASbGncvvVHC96puE2LIDdi27Hr5yuzQpV+X32BLpULEVd9XkHyVclEctlQ4aPDz5KGU
	5OOjKi6DC5Qn0DcuqHPRweK+YObpfPJUihO/MkgBVt79cVdn7tlY1luDYmDSfhZC78Py9XSc0fY
	KiIXSA7KeDV+AerW3J2PMJGC9pX61gt5hDOcoHyYW0lYYPAYdw9iiQMtkh1U/XBUGd5f0waOkgH
	KDwx7Xa+4ZpsKupVhmh3tgP6qQjVTgYb+ZovXZfTXxI7ALxrkFSr69A7303uHfJ/Cqm9DmxPqEg
	QqfwcIv2tvPFk+3DKWlKjijrtsM/N11lMv/mM5Kicask69+jwYx81p7jAaPob0qiSVl0oAQCduh
	8UC1tiEl2NFvqHb1c6Ijx4A0kMn+iZ1cnkQJldmzRfuDor52gKZrFpjFIaRtaPkadwJSp9mowK/
	3+Rh/X
X-Google-Smtp-Source: AGHT+IFSezywW/GcQJEgVuB0h4ZGuHd0XLMgb06dMPeu74sFNrjvw9oWY8GGl1Cc6cXExGzGLt+bVw==
X-Received: by 2002:a05:6300:2109:b0:347:8414:da90 with SMTP id adf61e73a8af0-348c77e0360mr2343316637.0.1761875306608;
        Thu, 30 Oct 2025 18:48:26 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm214543b3a.60.2025.10.30.18.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 18:48:26 -0700 (PDT)
Date: Fri, 31 Oct 2025 01:48:17 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: net: add YNL test framework
Message-ID: <aQQVYU1u3CCyH8lQ@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-4-liuhangbin@gmail.com>
 <20251029164159.2dbc615a@kernel.org>
 <aQL--I9z19zRJ4vo@fedora>
 <20251030083944.722833ac@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030083944.722833ac@kernel.org>

On Thu, Oct 30, 2025 at 08:39:44AM -0700, Jakub Kicinski wrote:
> On Thu, 30 Oct 2025 06:00:24 +0000 Hangbin Liu wrote:
> > > Hm, my knee-jerk reaction was that we should avoid adding too much ynl
> > > stuff to the kernel at this point. But looking closer it's not that
> > > long.
> > > 
> > > Do I understand correctly, tho, that you're testing _system_ YNL?
> > > Not what's in tree?  
> > 
> > Kind of. With this we can test both the system's YNL and also make sure the
> > YNL interface has no regression.
> 
> Meaning we still test the spec, right?

I just do `make install` in tools/net/ynl. Both the ynl scripts and specs are
installed. So I think the specs are also tested.
> 
> To state the obvious ideally we'd test both the specs and the Python
> tools. Strictly better, and without it adding tests for new Python
> features will be a little annoying for people running the selftest.

Yes

> Maybe the solution is as simple as finding and alias'ing ynl to the
> cli.py ?

I didn't get here. The `ynl` calls pyynl.cli:main, that should be enough.
Do you mean we should find the `cli.py` path and call it like
`$source_code/tools/net/ynl/pyynl/cli.py --spec
$source_code/Documentation/netlink/specs/xxx.yaml ...`?

Thanks
Hangbin

