Return-Path: <netdev+bounces-98721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8400A8D2312
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 20:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D26F2854D6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A828547F6F;
	Tue, 28 May 2024 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw99YE3x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA947F60
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919895; cv=none; b=hL7GvJmZBSFIFG/gfepkik0IvISaBCFE/yyzCk5B9wI+nj5+Y/ugx3AYWKOqon1JFkkjLVT6TfRJYXX9zLOGHyEu3s+GBat0ao4dgzKqMSSHtN38HDzjZzUDZlALjM+V8LnNQmd+Xkoha7jvzjAhC6UEHt4rPG02tyt8us2Fft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919895; c=relaxed/simple;
	bh=dj3fL4Jht9uP0/bqXlKqz2ORLXpqwY7jMEh4A1lPzeo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KsDE+3qdEyzyCRZzeYoLFd+8o43R30+DPq+veXacnBQd4ntN3pX15dgltKBL6Y4Sx0WMe7WhlWIOrOFb7JSx/YUyiS1H9RzZ58rfoq6xkVwe8FPcPSOu+xB1pDy4Q5de8Ljbyp3QXhgiFWcu1W/6kJfcYUX0kjARpGV9JCC5uU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw99YE3x; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7930504b2e2so46613285a.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716919893; x=1717524693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2K8TotcMPhlU0acugWyt0BB0cCsOs1bjv5grev9YWaM=;
        b=Gw99YE3x7EfV6FQ4hkQzlxsHR/NkZyNClQhUFf3gAc2T+yYn8LeZOKiaJ/r/MrWff3
         XqP2xQ2om60pmoZVFZA63EV7whIQUerNOdlIO6LPRB2OtP8NP9VKC71WjnYemF68FIMB
         j+TYVqlqRBGmIDet1I1p/5cYnpiaMRcUmCg0IRAwlfAGJNdCScOtQPrK1bvi8U4QGQkB
         bJ6NJbMMdZDo7EKDAbxGtYCDF5FrP0MwWl38bZIDHHgcfQXttz+NlwS60HIIqpLxEvMk
         P7a2r5Wl86Fb/pq/FqMMWaUivD882ZZxKzCFTR4seT2ls+I8GrfoePovGxF2L8+4Q3mQ
         J8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716919893; x=1717524693;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2K8TotcMPhlU0acugWyt0BB0cCsOs1bjv5grev9YWaM=;
        b=RFVR/cw37VZi3ql6NFJZmsmgn1EYjtwv87E6+uuixU/EvrBTZFaX6e6ScQmL4F+rNE
         0pzYSFt0vdyHkQ6bnoWHgka+DI+ZNn2l5oHyIMkEr9b93ZVEBFSyHQcf6eiXNxyT09my
         +cmZIrgGik4r+Op9X3ABV5GU5brfpGPxC0VE/fou1DCtIR5KXfU2txuQmlmNCg+w6k7F
         f5cWsdFXMV/A6v05zmqfQXcwg57G3UpLh+tfQXd3tKVEKlwhLrR6IintaCsEFdkiE7pL
         PfagUoz/B9v1lDHDOfipMEDnbQEN5xjVj4gdnVx14nDoqUnNGKvj8REQhZQ9FS7CGQbQ
         B0yw==
X-Forwarded-Encrypted: i=1; AJvYcCUdwG48AoO2XiVUyPc0DJ5WO+LbVemalY3GseMvFJvY5rpbGQaEotzpISjmcBXBnxXbWsUMnDlNnd4lDHrDKaNbIaBdbqse
X-Gm-Message-State: AOJu0YywwlOphQp+TTn3JAzFZJeWfRtmCxoEkfbYhjvJUwPWiQGM8yFt
	2hpf1aRYC4lrNRc2O1wfLfsSN/hrTGRSo5RaIRArn0LRKs3aE9vn
X-Google-Smtp-Source: AGHT+IEPKsWUXHkspjw08SLduDcERCP/oRf5ttrSeIBd7bmmWNPKsxw16lK3WHAGNrqQRQOGnGBj1A==
X-Received: by 2002:a05:620a:198b:b0:794:de79:f5d6 with SMTP id af79cd13be357-794de79f832mr25840285a.3.1716919893002;
        Tue, 28 May 2024 11:11:33 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd30bc9sm398890485a.115.2024.05.28.11.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:11:32 -0700 (PDT)
Date: Tue, 28 May 2024 14:11:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paul Wouters <paul@nohats.ca>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 borisp@nvidia.com, 
 gal@nvidia.com, 
 cratiu@nvidia.com, 
 rrameshbabu@nvidia.com, 
 tariqt@nvidia.com
Message-ID: <66561e53a11be_2a1fb929472@willemb.c.googlers.com.notmuch>
In-Reply-To: <81646030-00b9-10ad-abed-a7a78f0c511e@nohats.ca>
References: <1da873f4-7d9b-1bb3-0c44-0c04923bf3ab@nohats.ca>
 <ZlWm/rt2OGfOCiZR@gauss3.secunet.de>
 <6655e0eecb33a_29176f29427@willemb.c.googlers.com.notmuch>
 <81646030-00b9-10ad-abed-a7a78f0c511e@nohats.ca>
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP connections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paul Wouters wrote:
> On Tue, 28 May 2024, Willem de Bruijn wrote:
> 
> > One point about why PSP is that the exact protocol and packet format
> > is already in use and supported by hardware.
> 
> Using mostly the IPsec hw code? :)

Not necessarily.

A goal of PSP was to allow an O(1) state device implementation that
does away with the SADB. Using key derivation on Rx and keys in
descriptor on Tx.
 
> > It makes sense to work to get to an IETF standard protocol that
> > captures the same benefits. But that is independent from enabling what
> > is already implemented.
> 
> How many different packet encryption methods should the linux kernel
> have? There are good reasons to go through standard bodies. Doing your
> own thing and then saying "but we did it already" to me does not feel
> like a strong argument. That's how we got wireguard with all of its
> issues of being written for a single use case, and now being unfit for
> generic use cases.
> 
> Going through standards organizations also gains you interoperability
> with non-linux (hardware) vendors, again reducing the number of
> different mostly similar schemes that need to be supported and
> maintained for years or decades.

I don't disagree on the merits of a standards process, of course. It's
just moot at this point wrt PSP. Hardware support and some users are
here. A new packet format cannot be supported retroactively.

That said, an IETF (ESP) protocol is a potential upgrade path even for
existing users in the longer term. If we can make sure that it covers
all the key PSP features.


