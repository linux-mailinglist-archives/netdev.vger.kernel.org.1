Return-Path: <netdev+bounces-161257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B59DDA20382
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 05:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4281887394
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 04:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B94E19DF52;
	Tue, 28 Jan 2025 04:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="BqpzoCtp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10644315F
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 04:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738038422; cv=none; b=tbjTcM/uYU+t5xW2KMw16JCX1suYATjbFrotKPhem8FjfyKGXyns2xvcQnczt8RSm4AtPw2s7VLDp6LrnnzikgSI9rQFNpTMY7OkdO7VTfplUOPYXA+iMWnmqjtSUmU5uph9yCVtw1hBW2f+1Shf4CAgUl3qEIK12MJUU5f8ooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738038422; c=relaxed/simple;
	bh=Kzml2V52+BTPTW7hDbYqvGU/zuEgDIha+UrdEs/pc+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hA0/a8Qipy4GDm48vggc2IpOzzwT4sFa8acHXghaTw3h73TsBgrTEowycmXLZ0dJBO+LYgrBIJW/pGUq1BEBazKRCu2/GUimMCtctnx3xLaFkfnejOKc77MMSS/lazya2vi9eu6TrXsN84fnAXu4UJfzVDcAl5WqBMyLHThNwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=BqpzoCtp; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ACM3pEAH2aULWHwKk+fHWFoepTuzeBgAIxtgNjxuQkc=; t=1738038420; x=1738902420; 
	b=BqpzoCtpXLqYRLKmfaGI7Te4P0oScA2HQ4yYJNp+KcJy7iTSe2eQ/PSVfqIu3+64whYKlFCVSIR
	YnHuubHiw8R6HHJfD8sH4vyX6MqTz1QyU2TpXt1f8dzzZsTMnGwDIJOj5d1z/nMyE4Fhz1gsZM5mA
	yu/v5ydOTHt3chGZsVqHAUrutVsJWHrzm7RHeengxBoa/2LiqgeOsW2xr1NVbPPPmrbNAJ8l7rWCL
	gXBirIV9zlAhSL7DrjX78w/N+Z+khS2t6PVkb/XOLHs9/WTyEuNdaG5rHlsaU7K1KsF2iAoqCI+XM
	1rCLkonng3O/pXhFocEtnw0iLh7ddY11qFSQ==;
Received: from mail-oa1-f43.google.com ([209.85.160.43]:58647)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tcdBj-0001ko-OR
	for netdev@vger.kernel.org; Mon, 27 Jan 2025 20:27:00 -0800
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29fad34bb62so2691007fac.1
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 20:26:59 -0800 (PST)
X-Gm-Message-State: AOJu0Yx9FXWJmabKz/KZN+mEoyshlcLzBrhg2k9JXw+ph0Th8da3yaXJ
	3OmKrRe86FD4/3QV7rcBfWCKmXQCW4U0AM4sHFShARrn6KEt10Q5ZMXQjrqH8VPdsCPehGKg8SE
	E1fQG9UXqv374u6tqxBOOAa1Pz48=
X-Google-Smtp-Source: AGHT+IE4/eY8+DEjLC6YvEvhFvMRKLqtlscx64fBFh/iHosqNe4x4fJE2WWasPs9vB96s9bdPfpGBNUGWVAybDa81AQ=
X-Received: by 2002:a05:6870:b022:b0:29e:6096:c25f with SMTP id
 586e51a60fabf-2b1c0ab53f5mr24688125fac.23.1738038419176; Mon, 27 Jan 2025
 20:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-8-ouster@cs.stanford.edu>
 <028f492f-41db-4c70-9527-cf0db03da4df@redhat.com> <CAGXJAmxqoPw8iTH0Bt4z5V2feM8rekDDOJapek4eyMuLJhUAtA@mail.gmail.com>
In-Reply-To: <CAGXJAmxqoPw8iTH0Bt4z5V2feM8rekDDOJapek4eyMuLJhUAtA@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 27 Jan 2025 20:26:21 -0800
X-Gmail-Original-Message-ID: <CAGXJAmwcsyngTjX3XihgVZ88a+-nW6QQb-UO1hYHBjfD8jNEDA@mail.gmail.com>
X-Gm-Features: AWEUYZnVIiwSIHAi_th2nAGnSwcWQlpFekG2ut6JmWwOxU9Gdqljrp6vAdQ_ESE
Message-ID: <CAGXJAmwcsyngTjX3XihgVZ88a+-nW6QQb-UO1hYHBjfD8jNEDA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/12] net: homa: create homa_sock.h and homa_sock.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: acf3039aa8d32d1ac60a71149e52b94c

On Mon, Jan 27, 2025 at 4:40=E2=80=AFPM John Ousterhout <ouster@cs.stanford=
.edu> wrote:

> > This homa_socktab thing looks quite complex. A simpler implementation
> > could use a simple RCU list _and_ acquire a reference to the hsk before
> > releasing the RCU lock.
>
> I agree that this is complicated. But I can't see a simpler solution.
> The problem is that we need to iterate through all of the sockets and
> release the RCU lock at some points during the iteration. The problem
> isn't preserving the current hsk; it's preserving the validity of the
> pointer to the next one also. I don't fully understand what you're
> proposing above; if you can make it a bit more precise I'll see if it
> solves all the problems I'm aware of and does it in a simpler way.

Responding to my own email: about 15 minutes after sending this email
I realized what you were getting at with your suggestion.  I agree
that's a much better approach than the one currently implemented, so
I'm going to switch to that. Among other things, I think it may allow
all of the RCU stuff  to be encapsulated entirely within the socket
iteration mechanism  (no need for callers to invoke rcu_read_lock).

-John-

