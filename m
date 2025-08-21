Return-Path: <netdev+bounces-215700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF1B2FE81
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F28A21A18
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBF227E7DA;
	Thu, 21 Aug 2025 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lc/cDHRh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968AA277017
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789763; cv=none; b=bD1VMX2EqVVQSrBVGCoOQ8ZiI8gKZaB4dTsnfGvjEg8O+7os+wIbA/Jui+GyqzAOWeDzgq84vLIyL7dFudOXTOxldY4LWBbO3xqYzMsUPjRuZXPBxUGOYINM2md+QkGc6IhY/77TdRYMa0vS6IU6nMjWbUNoHjrHUJ5yCUEWzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789763; c=relaxed/simple;
	bh=/udiYEKcTUsuPB+7ChQ0XCmaKQaeMPlmRqwsAFpTUY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5Y8wZGtszRNsid0D/75PdCEeCIFqKFB4kbqscR0xhBco1t6shW2wE0Qu6d+dGsqSO9mlPPMCbzCDdCa0RMCVD6HhnlLR2+sOnGP66C8aAwa7kVYAszjG895KHHOpLMMD523rBEMI5O8/qgyjFHQQyLEmUZ3Eflwvug9966tZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lc/cDHRh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55e0be9425aso8552e87.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755789760; x=1756394560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/udiYEKcTUsuPB+7ChQ0XCmaKQaeMPlmRqwsAFpTUY8=;
        b=Lc/cDHRhwBa3/W1UWU8vM2PSW1mR6lgkUeBGf/F19cVRxNABwcxnD5mfcjNsCyYlSK
         qMApcKN6cZFgZT+V/Aty//f9+8k9SEbcrWkkhM+NdkaKu8t4k+XvxyF3Z4IXD4Mej59X
         px9Ei6K3XH63qZ/clz1fRShpGumTCKtUBWMTLlvr140UkUn1H+rUkzE9I6K4NfEqypgl
         3KguEbP1ddU7XRUQVpQyKMxb2qhtmD4Ue2NPUCj11adoViu0VgO4cnaDyqDjM5/Iu+ky
         FZSucspD4oM0BpYcwx/UhUd4dLtOmTAASBtMKKPYFiT3gkJKXYhXN/aInGDa6gowC9aX
         SDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755789760; x=1756394560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/udiYEKcTUsuPB+7ChQ0XCmaKQaeMPlmRqwsAFpTUY8=;
        b=sdIuFxTQqABM4Lx5ayMHQ/kXua2y1UHE+JTkjY128DtvXYEBC8mehFveHX1iYFll0R
         ujZkh9cKdzF43XNhaED4o++cWN/MWUZ7EPT9vl2oW/an1TfEKhJbvG9AW6cRUriWDHy1
         jYvgIrGlc/z6MlYcr6M1Xd56aM0G9EmJfNsM2uOv+SulU7XypqG0DTMJdfMRHjEcE1Qf
         euP44qFgrdDtpaiW32/P3DLbspcmY/vGNM6uMcP6hAaWN+otFdSNs1QKkiqQhaRst/ht
         zyRzsTeY8QyWosMkCQ3yKb7cE+aYGj0JHvQLS9f3JT//C2B6eQNu7GyWQs1SrLpEbyAq
         bh8A==
X-Forwarded-Encrypted: i=1; AJvYcCWmSyu2pxPmEf/eATmovcNPd34OlkqiI1dyDiffVZsrcYDYJ/2KwtCbyV7nGaB5Mxk7JAdaYvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YynKMVHvGSQnsTcn0B9SkqT89FMmuBPC/NT1o/tk9jocU7nt0rw
	CkevP1JAtjwXXklc4FHhOgfPj33YvlYHinaPRGilbbg5Zh8U33T0ycu11N0kFyJzy+/IqKwCBPe
	wV39umue5yh6poCqEuiWddNX+BbEpp82V9V/x/y0J
X-Gm-Gg: ASbGncvb/PzFLbBW52t8NMFYQKubCkbzAGTCHZuvHZmOKcd5dnENOsYGuV2DzYde2HA
	GBOERQ6DQjXJRx7W0fzi+12t2o40PzUyt+FImlS0iuttPOtadM6QodzXVXzdxlsZwHJiNgTP1Xa
	PPMs/zn3u9yRZinwawHyCKHruQHOuWEvtVWEzyH5AjEJXhphJrR3VB0Z4n3oHM//arkOWWiH8ED
	FDihoN/ctithyk=
X-Google-Smtp-Source: AGHT+IFFjgtdrSr7zdj2qCEe9pZXVkYTDOeSPgdyPrZkx4/TlwJP2LvRUvqMbjnJ43qxQdSwOTec5g77tPJUYRMYpTg=
X-Received: by 2002:a05:6512:63d1:20b0:55c:f078:44b4 with SMTP id
 2adb3069b0e04-55e0d7f2e03mr177076e87.4.1755789759426; Thu, 21 Aug 2025
 08:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820025704.166248-1-kuba@kernel.org> <5bba5969-36f4-4a0a-8c03-aea16e2a40de@redhat.com>
 <20250821072832.0758c118@kernel.org> <CAMArcTW7jTEE1QyCga5mpt+PLb1PDAozNSOwn8D7VwNYBp+xTg@mail.gmail.com>
 <20250821080332.7282db12@kernel.org>
In-Reply-To: <20250821080332.7282db12@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 21 Aug 2025 08:22:27 -0700
X-Gm-Features: Ac12FXyi_WSm0aaLAXx43cC99H5zzaPzLSL8Wt2cvRKZPkXv_OkvH0bLL3P2Z4I
Message-ID: <CAHS8izMHOzC2MUqZWgcQksLkTW_D7MJ4mndozA4pyfwAPzw0vQ@mail.gmail.com>
Subject: Re: [PATCH net-next 00/15] eth: fbnic: support queue API and
 zero-copy Rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: Taehee Yoo <ap420073@gmail.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, tariqt@nvidia.com, dtatulea@nvidia.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, alexanderduyck@fb.com, 
	sdf@fomichev.me, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 8:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 21 Aug 2025 23:53:37 +0900 Taehee Yoo wrote:
> > > I haven't looked closely either :) but my gut feeling is that this
> > > is because the devmem test doesn't clean up after itself. It used to
> > > bail out sooner, with this series is goes further in messing up the
> > > config, and then all tests that run after have a misconfigured NIC..
> > >
> > > Taehee, are you planning to work on addressing that? I'm happy to fix
> > > it up myself, if you aren't already half way done with the changes
> > > yourself, or planning to do it soon..
> >
> > Apologies for the delayed action.
> > I would appreciate it if you could address this issue.
>
> Will do, thanks!
>
> Let me apply the first patch of this series, and the rest has to wait
> until I fix the devmem test, I guess.

I'll take a look.

...although I happen to be running into a random machine capacity
issue at the moment. I hope to resolve that sometime this week and
look into this.

--=20
Thanks,
Mina

