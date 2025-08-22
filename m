Return-Path: <netdev+bounces-215970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C739B312AF
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A0E1CE5C02
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DA8194124;
	Fri, 22 Aug 2025 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm46M+sI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16727393DEB
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854152; cv=none; b=LplOSzebxybwYiMb+btirRdE0anMj1TLww35Gvw0bQpl+WArjfBf2b6sSoUGPzGITSGS/oFFV6SfODRCMl3WXiRDJLpk/sCNFVVt7p6L+JefEHmMUiVeSdGKxUdmvz6Kxhw3jDDvq9hOR8qV3z74+bj1bQmweDn8aeexUbBmurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854152; c=relaxed/simple;
	bh=pvSz2Byxm2uVRbE+wzOFlcGdg+rrXKCtuNJBR7eFJ1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/tEHvItqfliT2O9Yz+zhQzMo3U7CoKiFGRsS8e/IhqlPimk6bOzmGJPGo8Luh1gtumLcTNY5h6dH1xP9FbkM725duuRqv2LY4Uu0hZSUAo6TORxTUfDtsY776QY3JKXB1XtCQtWBSeXLL9eChqsX8QzGkB9mWoVnIFylHMWLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm46M+sI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb78da8a7so282695066b.1
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755854149; x=1756458949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IcYuqXwMMOHEAHK6AEjcauuepvcjq2vzOAXXoNc5zMk=;
        b=Qm46M+sIs0J2AaicQ+km3mj/v0zUCKlrvGy77IUJoJJC0sCcKimlGlQPcvRMFpacFV
         4A5oj23dH6VRTq+bMnDAS+sIwf7LbbUwo7I+WiRHu93gpDqeVFn2FERJ4m1o7gAXua3j
         nHKCXUhK4j05olWWZP8mHKcd+fu+X3B12uISaKdVhmVV6g2WfkPt2i3PvDu356JmsdpY
         LdLckdTSsYahtG/YKxUxrf3TiBSs+E/cF2TSKwy+e/q4rPJixFQcfM0ANnYhZXGWZ0Rv
         +HOUVxtdNGA9PNWd27aWhHu56u5GgSe9slFwOScbxDCMEj8cd7dXzZLLGXzLBoi3LtHM
         CeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854149; x=1756458949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcYuqXwMMOHEAHK6AEjcauuepvcjq2vzOAXXoNc5zMk=;
        b=DWTy68h4+088WTy9v3scK1rVwTREyEafNBnZhVyvfktLN+bDkwFP3oymQpTDVS5NqO
         pX1okdShoC2OcNovVgBjlSogqeXHWqMuFwx9afaB3fpc1We43kR65pTVCg493Y5jHnvF
         UNjiRP0UbJnifrgnbVRfz84IGssXGYUsRXiMUpB9V4raz/9PlH5EuvoRbt76L43V0pSP
         e7Eaiq+L85QxX1gCwt0SfEoMzkNP+3VtB5yIZwDHLNp4buNhOQAGqPiuY74xJUo8dL3V
         o/+qP/Zl+tzLgeINxJznX+J1cSlHOfZrCNevlIjpET3+dpi291Waqp602y6C7jpmQYqv
         dtgg==
X-Gm-Message-State: AOJu0YwjDSUitmaREGWVFx3rSkPTEOULxbKVe1O+8rPXF5I7HUSZqREg
	LuOMeGXkQb7Ip2BzmuAfa70OhqTy5PVnUIYlrTOyk4jLlwKr5bOyx/96
X-Gm-Gg: ASbGncseJQNKm90/p2cA8XivtQTkEjlQccRU0LcZ4M6rIuKCTZteOAA2hoAAqubqvST
	y3lKCv+gAMX60q4nwySfhL8sNJv9rI3LPbdT8TEcIwSGrAeK0PEN1iVbZPB3UAu7nJss4NZFUwp
	bbDKwBMKf3ZPq6laFJFoMYuBuFFg1+/B52N1SEMhmTTyvXhZ8MNFlvs7MWDX8+ZbPulNiL5MUNQ
	eXlJiNcuxO7syfkwnAzBVIIDkAEtS18Hi1Zv9sk2ra5PxbpmPfLhuHUIzZQoESyVWecFGePlgqR
	ObuT4+SfYGshiioqF3DhQhZNkdBykxbRYWlsupIRHq62iuYgSMvwOcv+A/jXgYv77DpzYYeSviC
	6rTiCOCSwH79/sqkb0H5DqwVxC3E1xl2b8quXpSS73eQGDvWv0TjQBo1EsQ==
X-Google-Smtp-Source: AGHT+IFx+7umhxoGvvRasF+/fgNq+CQQOHxbtaOYLimA+4lHVda9qvy/BwXglNDFOnzuhbFXjFy5jQ==
X-Received: by 2002:a17:907:1b29:b0:afa:1b3f:37a2 with SMTP id a640c23a62f3a-afe295d2b84mr202455066b.37.1755854149309;
        Fri, 22 Aug 2025 02:15:49 -0700 (PDT)
Received: from bzorp3 (178-164-207-89.pool.digikabel.hu. [178.164.207.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded478ff9sm565413666b.57.2025.08.22.02.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:15:48 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:15:46 +0200
From: Balazs Scheidler <bazsi77@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [RFC, RESEND] UDP receive path batching improvement
Message-ID: <aKg1Qgtw-QyE8bLx@bzorp3>
References: <aKgnLcw6yzq78CIP@bzorp3>
 <CANn89iLy4znFBLK2bENWMfhPyjTc_gkLRswAf92uV7KY3bTdYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLy4znFBLK2bENWMfhPyjTc_gkLRswAf92uV7KY3bTdYg@mail.gmail.com>

On Fri, Aug 22, 2025 at 01:18:36AM -0700, Eric Dumazet wrote:
> On Fri, Aug 22, 2025 at 1:15 AM Balazs Scheidler <bazsi77@gmail.com> wrote:
> > The condition above uses "sk->sk_rcvbuf >> 2" as a trigger when the update is
> > done to the counter.
> >
> > In our case (syslog receive path via udp), socket buffers are generally
> > tuned up (in the order of 32MB or even more, I have seen 256MB as well), as
> > the senders can generate spikes in their traffic and a lot of senders send
> > to the same port. Due to latencies, sometimes these buffers take MBs of data
> > before the user-space process even has a chance to consume them.
> >
> 
> 
> This seems very high usage for a single UDP socket.
> 
> Have you tried SO_REUSEPORT to spread incoming packets to more sockets
> (and possibly more threads) ?

Yes.  I use SO_REUSEPORT (16 sockets), I even use eBPF to distribute the
load over multiple sockets evenly, instead of the normal load balancing
algorithm built into SO_REUSEPORT.

Sometimes the processing on the userspace side is heavy enough (think of
parsing, heuristics, data normalization) and the load on the box heavy
enough that I still see drops from time to time.

If a client sends 100k messages in a tight loop for a while, that's going to
use a lot of buffer space.  What bothers me further is that it could be ok
to lose a single packet, but any time we drop one packet, we will continue
to lose all of them, at least until we fetch 25% of SO_RCVBUF (or if the
receive buffer is completely emptied).  This problem, combined with small
packets (think of 100-150 byte payload) can easily cause excessive drops. 25%
of the socket buffer is a huge offset. 

I am not sure how many packets warrants a sk_rmem_alloc update, but I'd
assume that 1 update every 100 packets should still be OK.

-- 
Bazsi
Happy Logging!

