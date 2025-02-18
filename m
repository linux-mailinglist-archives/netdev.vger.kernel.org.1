Return-Path: <netdev+bounces-167384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487EAA3A0C2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D47D16510E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA35D26AA8F;
	Tue, 18 Feb 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeHK4GAE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5522AE4E
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890993; cv=none; b=uYDeLQt1XwvLQM4rTy2t8N193v7qu7AS5tRcF7yig4pPxqVlRjPwt3FH2nA+euA/vgxWF+LOaNp8iInlUxrhi9ZTO1GsCos6STEXv64ESQfUC3wrw73NAk2TmSXEGCDawVLVmLdMMlT407prL4CUj+xDtdm2mKqrW1gM/7OxKuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890993; c=relaxed/simple;
	bh=c74ZNXkpLj18bQQ/GIrBnl1QCYsto29cWJfNxFpdddY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kYGnyKHe4+ewdEdQMmGC1SHYvztAJwMEWN99NOMksdb1E91+NluTA4eMYGcDxzpbZQw16BdwaoYHxuSNz60fXlEM/1qUFqQtbAuQOBN1Fc4hDFQDqs+RhlWKBS5mQKXviQEV5e5koRQMApTYB9a1yohAS9PzlxPg8IgmnHPM0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeHK4GAE; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c07838973eso531499585a.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 07:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739890991; x=1740495791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kujaYswuwb3oO/m0MI7vxd44W0z40aE/z6FCixYlClI=;
        b=NeHK4GAEkNN301D9veacO6tjky9qJtainMTcFvPd30u+Vzy8xQR63OoeW1m6e2QuuU
         EMf9hqv54uCDPB6A2loj9V0XX8iif0eSUnWJc/9ioIrIrBQBRXbZDhOPoczLPhYpy5C9
         LqgCEBIkiTYbJzkuAEud5+pY4rhieIhJ1HzZcYvtzStiFhjbD/jFxBXiBBcVfMMkXdKk
         ajxmgGrvUI+WFXaCPS7yLDmllyGQvMmH7eiYJPhDvZKRJ1PoJzayV061MAPrhXaEzaNT
         OxPsERyhA5wDhidlFPG+njfBCGsmZVcDcbEDKntIrLWJexiIPAVNVoFrivyvQf/s4S+G
         SjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739890991; x=1740495791;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kujaYswuwb3oO/m0MI7vxd44W0z40aE/z6FCixYlClI=;
        b=ssfVt/113tdqL6LbawUXu5DmwzoAX/k65OiZhsgrU5ZAHmJCLMpXY4W5ABmPRajBhO
         JNTa2XnGu8/BYiwndu7fKHhtq4y3de6S+KI2E7ygcixbUt5dr07Mi4oLvSLlz4hgJocs
         6tNjy5YVxpBkHr4LksoaIHlYEdt/vpLwfHgnbGYKm8XMpac7o0ZlVkxh2PvdFxCo7CAr
         /ER7fWrskjXyOB/oDY69pDN+B+VdLeFnx0/imbF5DXJkCue3QpyIOiDG/dE+pJhez0yD
         cPPj7CcIfuj0tk5PUZCbHUguibxU/sCuWGDg3hMZIDEk0SmCnbrEr8TbWy0/gKh8LYBF
         FEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF4Bj7I8ETE/nUiVdhiSR+KR3XVcmhmP34RuXfO42UDyRaeWFW6JDWgyddtk7cvaJ8jZBsL/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrb1PjW61p5vXfHM5CIagoLLW21lPg/GmyIIWHs+i/AuwCA/nl
	YLJPmDip03QBb60iy9xR0s8zFnbX4LxLinHmb6Ew4vnrNJtz6gae
X-Gm-Gg: ASbGnctyakY8XMfGozdWE5kldVrbBYkwshD/kM69lfO1Q3uKImSwyiH030NN03DJbmz
	+PpPuTdNiRFu8LQoOdjKKDS8dq5cB4x8+y2ROBh+1exlHo5x4e0RCNXKHICyOrE9NK0Fr6bV+Th
	EevPqaez7XcZ3zF26E+LRoyyPV6ZP6DrxVj3erMBybMtzWiR4XpgNLgXcQdKHRQbMQOwiDtq99N
	ZR9Gk/20ZBy+N37jbBqxW0xKyYL1ko3Gl7j4uVdqn2lvfbdKKzcJwl5ujexdwziPt/Mod1/LB0j
	8kkaeC42sVpB4w3dO+OV14KFpu48dkNs6mvvFJvaLOOL+lElsgM4icK1ZnwuWuU=
X-Google-Smtp-Source: AGHT+IH12YOvfE4C+/XGnHePJZcmUpPNJjWDYSLZeQKfAgImQe3rBIEzYPcDz37ONKO83tpgXLTgiw==
X-Received: by 2002:a05:620a:44ca:b0:7c0:af6d:a522 with SMTP id af79cd13be357-7c0af6da6f2mr279844285a.33.1739890990996;
        Tue, 18 Feb 2025 07:03:10 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a40b2sm64426236d6.58.2025.02.18.07.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 07:03:10 -0800 (PST)
Date: Tue, 18 Feb 2025 10:03:10 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 petrm@nvidia.com
Message-ID: <67b4a12e2c118_11781b294a2@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250218064801.2b43ad83@kernel.org>
References: <20250217194200.3011136-1-kuba@kernel.org>
 <20250217194200.3011136-4-kuba@kernel.org>
 <67b3df4f8d88a_c0e2529493@willemb.c.googlers.com.notmuch>
 <Z7QK5BBo-ufND1yB@mini-arch>
 <20250218064801.2b43ad83@kernel.org>
Subject: Re: [PATCH net-next v3 3/4] selftests: drv-net: store addresses in
 dict indexed by ipver
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
> On Mon, 17 Feb 2025 20:21:56 -0800 Stanislav Fomichev wrote:
> > > >  def test_v4(cfg) -> None:
> > > > -    cfg.require_v4()
> > > > +    cfg.require_ipver("4")
> > > >  
> > > > -    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
> > > > -    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
> > > > +    cmd(f"ping -c 1 -W0.5 {cfg.remote_addr_v["4"]}")
> > > > +    cmd(f"ping -c 1 -W0.5 {cfg.addr_v["4"]}", host=cfg.remote)  
> > > 
> > > Here and below, intended to use single quote around constant?  
> > 
> > Let's kick it off the testing queue as well..
> > 
> > # overriding timeout to 90
> > # selftests: drivers/net: ping.py
> > #   File "/home/virtme/testing-18/tools/testing/selftests/drivers/net/./ping.py", line 13
> > #     cmd(f"ping -c 1 -W0.5 {cfg.remote_addr_v["4"]}")
> > #                                               ^
> > # SyntaxError: f-string: unmatched '['
> 
> Huh, it worked for me locally, must be a python version thing..
> 
> Python 3.13.2
> 
> >>> a={"a": ' '}
> >>> f"test{a["a"]}test"
> 'test test'

Failed for me on 3.11.

Apparently this was indeed addressed in 3.12:

https://realpython.com/python-f-strings/#using-quotation-marks

