Return-Path: <netdev+bounces-161663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1BFA231D0
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5FA1886EB2
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 16:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402B1E8840;
	Thu, 30 Jan 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tY7tASqR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F31EE00E
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254564; cv=none; b=GDKCNvWdHAg0o9OJWt/OJBI1zn0WNSMfk6ugSaFcdFcHhlsD3gG4plQ0VQEU/IgKcn5/94hfPY/e9i1kJYXoNdtXYI3oPy4IO4kiFWqhgVSPQBatqkz5doNPaLZxfs7kiaP9LW2UHzgwwvSloGbYqjg3r9s4qOfekkZFPZoUwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254564; c=relaxed/simple;
	bh=t83gBk3R1gJYHaKAAfvjNUShPqKhN3qh0uSgLbPTP6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8aitm6JCjlAxJzt9+oSmEiSkA43AHOM7FqB9csN+8U87efm88T1JzHb9ceRRHijkevQwkfnVUZo7r7movV/jZ8RWNLC3w2oLNtg3c+7mwFeHvQmIuWJpaBmRa2vGiuPE/EWEURCpA0tbqRy4W7ApJL8EEgiWBYjp2+QIz2ZcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tY7tASqR; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46c7855df10so16172671cf.3
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738254561; x=1738859361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaELnFzz9aRPiHl2MvgwZe5wGfHA1Rh3SyrWRVQiS98=;
        b=tY7tASqRwmsVr0Dhlx1A8MFyV/JSYFFol9/Bes0rqSbY9GWcaUPkgNkGRpWEcPlo5B
         878X5HvRTANi1bsYLe16QeRnx8iNkiTevyzI9fEjA8b5QeGYtIdM1GbI5wr4+hi/Keyj
         2iZu1umLxJx+cXQ55F/Bmm2r7ALCuowRI7rjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738254561; x=1738859361;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaELnFzz9aRPiHl2MvgwZe5wGfHA1Rh3SyrWRVQiS98=;
        b=q1udUAAB6uvcpYvBwbCjV4m6IrIgGDPIUFanJsoI3VlxfHGtD23otKGOAErFQ3Btpc
         skos12eGgaEl72uDHLMfuF7OgMbGd+kcGyOQZdXpXfP8laBwPzHOQPzR85y7ZrBwK34j
         dfq7otGQHz6ZhwMmCLIiIBS62vM9QG2EwSFW/ry9HStBPRnKo6CQJ2FbUhPK3rdVrus7
         kHTPUNXPeZ7kRFtrKlBTAS5Ak8Np7cdLenNbwd4GbqYs7yJFJ7LIK3owbT54952U8Yz3
         J4pOOz74l3Tv0frujgzRYppWtDDY9mSazmUiS4/eNU+wnsM4NQYAfgvbg4ilOeN4gIsj
         ntHw==
X-Gm-Message-State: AOJu0Ywv1Tgs5SjMD1SfQ88ap/v1Hj0rVbQaOX3+3YzeFYTB0Q+FR6sk
	2gpyXvlDLCCD0zGzxGqLMi16sa6ixA6F040COX+Jrmh3l7Dgqc8ISBN1+AWYMhg=
X-Gm-Gg: ASbGncua/mE+mGnXOXtHLbKDkwevtGUYt5GFF7N9gicisw6C1ZJCd0UCKJl5l3Yncpl
	rgOHSmXc/ek19Z62qv4ZdVIWNk9zazqQmEqxSFc/5JKoa0Z/yOXkMu5xoMhYk/Bsbj6PrKd0SNW
	mkgMwKsHBjYYvSN99jropdFZKs96hpzrk0x7dIZrfk6cFdyuq1Ymj9++d/0cxxu86eDBgoXawtq
	zMW7gUPiCRGeBuM/SSlanY8uAzXFkRSv5NBZHK//TYz8tp/lvUmZoPpQQM8xDPl6CdE2gq0ZUsn
	g7tpboIWhM9mdZD2eQbT
X-Google-Smtp-Source: AGHT+IFMhjJxwdWrG2OptdCx16imUHT/yVI/4gwEFDkVKpzed2hScRedqGpI22WePJd4xDb4S84Whg==
X-Received: by 2002:a05:622a:114d:b0:46c:791f:bf3e with SMTP id d75a77b69052e-46fd0ba20c4mr121048431cf.48.1738254561168;
        Thu, 30 Jan 2025 08:29:21 -0800 (PST)
Received: from LQ3V64L9R2 ([208.64.28.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0e0d5fsm8544561cf.44.2025.01.30.08.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 08:29:20 -0800 (PST)
Date: Thu, 30 Jan 2025 11:29:18 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, sridhar.samudrala@intel.com,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [RFC net-next 2/2] selftests: drv-net: Test queue xsk attribute
Message-ID: <Z5uo3ugZB13k1aKW@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com, Shuah Khan <shuah@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250129172431.65773-1-jdamato@fastly.com>
 <20250129172431.65773-3-jdamato@fastly.com>
 <20250129180751.6d30c8c4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129180751.6d30c8c4@kernel.org>

On Wed, Jan 29, 2025 at 06:07:51PM -0800, Jakub Kicinski wrote:
> On Wed, 29 Jan 2025 17:24:25 +0000 Joe Damato wrote:
> > Test that queues which are used for AF_XDP have the xsk attribute set.
> 
> > diff --git a/tools/testing/selftests/drivers/.gitignore b/tools/testing/selftests/drivers/.gitignore
> > index 09e23b5afa96..3c109144f7ff 100644
> > --- a/tools/testing/selftests/drivers/.gitignore
> > +++ b/tools/testing/selftests/drivers/.gitignore
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  /dma-buf/udmabuf
> >  /s390x/uvdevice/test_uvdevice
> > +/net/xdp_helper
> 
> Let's create our own gitignore, under drivers/net
> we'll get conflicts with random trees if we add to the shared one

OK, SGTM.

> >  def sys_get_queues(ifname, qtype='rx') -> int:
> >      folders = glob.glob(f'/sys/class/net/{ifname}/queues/{qtype}-*')
> > @@ -21,6 +24,31 @@ def nl_get_queues(cfg, nl, qtype='rx'):
> >          return len([q for q in queues if q['type'] == qtype])
> >      return None
> >  
> > +def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
> > +    test_dir = os.path.dirname(os.path.realpath(__file__))
> > +    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
> > +                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
> > +                           text=True)
> 
> add:
> 	defer(xdp.kill)
> 
> here, to make sure test cleanup will always try to kill the process,
> then you can remove the xdp.kill() at the end

OK, will do.

> > +    stdout, stderr = xdp.communicate(timeout=10)
> > +    rx = tx = False
> > +
> > +    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> > +    if queues:
> 
> if not queues:
> 	raise KsftSkipEx("Netlink reports no queues")
> 
> That said only reason I can think of for no queues to be reported would
> be that the device is down, which is very weird and we could as well
> crash. So maybe the check for queues is not necessary ?

I kind of feel like raising is slightly more verbose, which I tend
to slightly prefer over just a crash that might leave a future
person confused.

I'll go with the raise as you suggested instead.

