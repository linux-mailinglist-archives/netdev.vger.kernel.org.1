Return-Path: <netdev+bounces-210626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ACBB14126
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 19:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD173B05C5
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7D6274B52;
	Mon, 28 Jul 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="oFfqiisZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94425C83A
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753723450; cv=none; b=iTi7dSsNS1TS0AJh/al6gW58FLQsEhrol1lh+PwPPi6Qtcg1r6nOUPakXBpDAuuVQ0i5Z6uQVtHtPMkt3IpfIdxL/KAxrHIhMC1AH/YMwze78+/6xwLc/Hd0TZ83qZnfVpWKcqPg050yZU1Ah0LJJNGBmlm4oTJdGBkN7QgVSH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753723450; c=relaxed/simple;
	bh=2ZdwF4PQYW8147pzn4fPe5HUYoQfVvkk9RKNY+W2sFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGHafNH82bLD6eeskwjaDqx/seWPctfkwyShfiGwQrlHCQZz2MOwRuWhdNjg15IB39iECxImL+SIq5HKEllbddkGkMd+3RcNIvto3CV5I8NUt0ZWGnGvRXM33Qn0/IZLp1sMb8pzqNuOQpxW8qdo7E/OeZOqDSDXRYOYm18HSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=oFfqiisZ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso40389836d6.2
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753723448; x=1754328248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XdqDqbJDwpBMe3m0FOfH7VD8pnof2gn6I7X5rLReRs=;
        b=oFfqiisZYO5wCla3SH4BvnBhGCqgeALrVtPIFnG5G5tgZr1Qtj8SKODdsEattfQtIy
         oAS60hUo8gWsAVZffO4SWt0Vr8NPKV5hQg+uGZ3Qfr+6VH2GA1ZkRDHwFfPFNyWOTNCb
         QRBZH8uPb4geRq6lZwY7NjWV62eyojt5amb7KoxqLS2LyMR1kChJNta9lIBPYj37Ku/K
         DNf/u7SlbqYy+Z41nBF32zrOUgtUIuuuOI1guBqApAswaeo/mMZu9Ld5kHY65wtXsfZO
         UgDB+/szoQ387mzVXm9eTBwGZK9wH89SQPGOYcCbdqlIS/hn0mpAm84uq+xJ/HORWMQr
         auGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753723448; x=1754328248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XdqDqbJDwpBMe3m0FOfH7VD8pnof2gn6I7X5rLReRs=;
        b=IbabLh8a9wIMBfDscV/Exo6oMFezj4a/n2rHhH8h7RBbwmH1BGO5X7u58qKG0/h4Cn
         LVgMdZsVF4gKOwkkrlTkegcOMKdfvuqvEbyAeD1LFgQM7lC7yCjxk3HOZPJk7xWKnsFL
         imEcpomZijNTMEG9HxAJlWQaBDB0iv/kV5hp4QBmLXjes/9QpA2Fj9yDt0ASnNbKqXAn
         K2zH2mGRiAJOJrdTJuspnp0rFJwXjlKvNvoxnEUDxQevTHYM1XE5xTpja1c9cvGcGtv4
         JkM1jJ6DS3YPNZTQgXEwUqFasQEuYDMoYpq05FQUKXrMfM+DtOFqXO7+mI2vQ1lLzF9u
         Wgwg==
X-Forwarded-Encrypted: i=1; AJvYcCWzcy9vpbyTqyhweHcAzqvhE89uF+4F++5bcov+OlNDpyaYAHLvSaDjKLCjWWRMbhbYng9z+sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQ11gpomSAhO1i1xetihj8/a4TGkEj8e6Pz4pkKL93qjEcRkA
	HTU515awcG7HgRdWifUMrPLOAJBKbXKpe/8FzM9UjfVi7c9b7cAw5WJXX51SyQaFans=
X-Gm-Gg: ASbGncvKe9jIRIhkTDO4jJYhj3mDT3OCF5vjrktUTH9JZeEIaRpuoBMPkrLIz0UIVb3
	/R7Udmi2uiTbZiOsvz97XZ07LQ1TKHL2mKkznQoAoITqxtBOCWr6ulsAgE1dQuJ2EKDbuvB/c/P
	a0jhiVSP0m3/vre+bZeqkw0txxNKZOWCYUJjJZZS7ynlONU2pkuaTN3PQM9beseBRxN8wRcQkEv
	pFoZMcJfcKpQvZ0vu17DfOWXXU7hedYeRl156SjmIlWGvheKSBhvr91quOTfFk+oLyRI8ziqDt5
	5+FPE7RInAmAQX4oQfdAFws08jVJXuu4/qdKip1gu7ZEnqvvdH6y9D3gUW1iaX+9S29IuuYwwpj
	QpCZFcTxz93yc2oGEjKAqtdz1ivu/QzxoR/KpYTHZtDx2ESS378lo/15E8gDmP6b4eo6OfvEUUG
	o=
X-Google-Smtp-Source: AGHT+IHY0LkystMqkqxAK7PK7GfR60GTUEUQKdwp2aWknAFkvv9APqEaMLJSHGrUrYhnngwMHSEy0w==
X-Received: by 2002:ad4:5ccf:0:b0:707:38e8:d10b with SMTP id 6a1803df08f44-70738e8d36amr98246666d6.24.1753723447718;
        Mon, 28 Jul 2025 10:24:07 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c4db6bsm33605116d6.70.2025.07.28.10.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 10:24:07 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:24:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Jason Wang
 <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, KY Srinivasan
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michael Kelley
 <mhklinux@outlook.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Kees Cook <kees@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki
 Iwashima <kuniyu@google.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Guillaume Nault <gnault@redhat.com>, Joe
 Damato <jdamato@fastly.com>, Ahmed Zaki <ahmed.zaki@intel.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
Message-ID: <20250728102403.14269ea7@hermes.local>
In-Reply-To: <20250728081907.3de03b67@kernel.org>
References: <20250718061812.238412-1-lulu@redhat.com>
	<20250721162834.484d352a@kernel.org>
	<CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
	<20250721181807.752af6a4@kernel.org>
	<CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
	<20250723080532.53ecc4f1@kernel.org>
	<SJ2PR21MB40138F71138A809C3A2D903BCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
	<20250723151622.0606cc99@kernel.org>
	<20250727200126.2682aa39@hermes.local>
	<20250728081907.3de03b67@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 08:19:07 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sun, 27 Jul 2025 20:01:26 -0700 Stephen Hemminger wrote:
> > On Wed, 23 Jul 2025 15:16:22 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:  
> > >  
> > > > Actually, we had used the common bonding driver 9 years ago. But it's
> > > > replaced by this kernel/netvsc based "transparent" bonding mode. See
> > > > the patches listed below.
> > > > 
> > > > The user mode bonding scripts were unstable, and difficult to deliver
> > > > & update for various distros. So Stephen developed the new "transparent"
> > > > bonding mode, which greatly improves the situation.      
> > > 
> > > I specifically highlighted systemd-networkd as the change in the user
> > > space landscape.    
> > 
> > Haiyang tried valiantly but getting every distro to do the right thing
> > with VF's bonding and hot plug was impossible to support.  
> 
> I understand, but I also don't want it to be an upstream Linux problem.
> 
> Again, no other cloud provider seems to have this issue, AFAIU.

The problem is that other cloud providers don't expose the VF, the hide it in HW firmware.
The userspace world is a mess, with systemd, netplan, cloud init, and the SuSe stuff.
And custom appliances that assume that there is a default eth0 device on boot.
Yes, there were users that expect to see eth0 all the time.

