Return-Path: <netdev+bounces-98593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABD28D1D7A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0361C2263B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448D16FF4B;
	Tue, 28 May 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8qOwrkn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D8616F297
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904178; cv=none; b=sVBOTJHk6r3mbYT64j59XbUDKCVofiYBwWDiAhkeCpH4Lsb6xxkB5bHP9IgFCBlWmX7aunhcjOVQ7yXMgXNDDHZxifOVnZlq6rJ7H3YoCJPJn96DpR0JX56qiifEvHDYgC7WH/ppWqvtSuFLJ40kOo+3oFTmqHaMr/Yhmx4OMeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904178; c=relaxed/simple;
	bh=ob+67oZoR+LhCy2C5rQAiZ4cUz83q/sv/8ktLGOp+gE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rQp9kBRIAtXxBShQ0dYx4McqORUeqw683grlBIrSg/cA3Ju67hnFygeBQHN9YKsnAexgkzBWtxgvW/FgmEYRlXLRbkXSYea1EQgqSPPjsxpX/LBSacGltUbx2uJS5wwGB1iDRni9sfUmnGOqBBiV6p2pSze6Y6B9bS4O6Y5MXDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8qOwrkn; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24c91c46d00so370654fac.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 06:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716904175; x=1717508975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYuDoH/shZ39efiGoLr1Jha6aMlkiQiMeeZMvOvScUA=;
        b=h8qOwrknVVG65rkL+30GUPifw9tR3T/lyVp3rLaN18+SoAl3H1NZ0hack9FSe4Hu7J
         Hg2cnip/Zs/VLqE1d8zZLfR5Dmhps5GC7i3QHEBJzSUEwtzOEfz+draYS5cbbt6hn+Rq
         D4ZQg28PZrRJOWjctfC5oDUzpM4fo8sObEVDcGrXm8PKcT7pSjXny1tl7eGiWkgC92ny
         dyGjvOYbXhfJRvqADHA7+ipCW9XMUbDMr1vfHQ67PxmePLG8kjIBPMUCIP98FeTrrU0Y
         KJZHlYF+wb6z9vGvPGBU5GIolfx6QPp5+x9/FJ4VoSThz8Wkjc3Q3oTcVBOB82h1Vopv
         mAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716904175; x=1717508975;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DYuDoH/shZ39efiGoLr1Jha6aMlkiQiMeeZMvOvScUA=;
        b=In0LJd0u9K9NAw/BbtICfqT6+Rbf1E3gZUc8L9QIHHfw/a8jhIEkik064RrlZcoqNz
         PMPrNaNHgeKP25Agfv8xgBjNSB8/xFfAWIQkjbTuiFWeN3NVhWhFSMRUzf8zD6ArTtCL
         QQXT7BGuOEsIslZVYoJC6vLgkdkwlpFBGUMsnmqnj13qVMAx7gc4qAoZhRVYbv4pYreW
         GDllzWwobsjMlzZnnswo1zTKLfR4hfxKAZ1EDOTSiygCQIYQL31ydvK5f3YuKAs8Vznd
         k7shsYeh4XZ7NkbvdoaazWS9phh7HDKEpbOoDqF3CVFckXMc/830tIGa5dybLv/thbF7
         5M3w==
X-Forwarded-Encrypted: i=1; AJvYcCW6uRFsgTRpzL62uH3cpriymLqEL0InIihOdUI/AvyFak0bfwAVC9eQQXA9B7kM2mkrrE3ko4Nc/3Wv6sh/Q7h/KSMi6Nz2
X-Gm-Message-State: AOJu0YyQCPHCnl44o7akckiLxjxr/oxITLVZNIN8pSrQOnlkpZHrKvCj
	ipR10fVqzwAkfNe5TWERP2l5qhg2IP90AksRRzajIJ4yQXbSRMlB
X-Google-Smtp-Source: AGHT+IFm1FiMSDg2/Np99KVw/LvGQI1cqNHtff6boYCn9TSgmgwnNb84jdda85ADEJUB1sQYGwsAHA==
X-Received: by 2002:a05:6870:718f:b0:24f:e8f1:6774 with SMTP id 586e51a60fabf-24fe8f1cb22mr7261987fac.44.1716904175498;
        Tue, 28 May 2024 06:49:35 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18b0e3bsm42686261cf.68.2024.05.28.06.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:49:35 -0700 (PDT)
Date: Tue, 28 May 2024 09:49:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, 
 Paul Wouters <paul@nohats.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 borisp@nvidia.com, 
 gal@nvidia.com, 
 cratiu@nvidia.com, 
 rrameshbabu@nvidia.com, 
 tariqt@nvidia.com
Message-ID: <6655e0eecb33a_29176f29427@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZlWm/rt2OGfOCiZR@gauss3.secunet.de>
References: <1da873f4-7d9b-1bb3-0c44-0c04923bf3ab@nohats.ca>
 <ZlWm/rt2OGfOCiZR@gauss3.secunet.de>
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

Steffen Klassert wrote:
> On Wed, May 22, 2024 at 08:56:02AM -0400, Paul Wouters wrote:
> > Jakub Kicinski wrote:
> > 
> > > Add support for PSP encryption of TCP connections.
> > > 
> > > PSP is a protocol out of Google:
> > > https://github.com/google/psp/blob/main/doc/PSP_Arch_Spec.pdf
> > > which shares some similarities with IPsec. I added some more info
> > > in the first patch so I'll keep it short here.
> > 
> > Speaking as an IETF contributor, I am little surprised here. I know
> > the google people reached out at IETF and were told their stuff is
> > so similar to IPsec, maybe they should talk to the IPsecME Working
> > Group. There, I believe Steffen Klassert started working on supporting
> > the PSP features requested using updates to the ESP/WESP IPsec protocol,
> > such as support for encryption offset to reveal protocol/ports for
> > routing encrypted traffic.
> 
> This was somewhat semipublic information, so I did not talk about
> it on the lists yet. Today we published the draft, it can be found here:
> 
> https://datatracker.ietf.org/doc/draft-klassert-ipsecme-wespv2/
> 
> Please note that the packet format specification is portable to other
> protocol use cases, such as PSP. It uses IKEv2 as a negotiation
> protocol and does not define any key derivation etc. as PSP does.
> But it can be also used with other protocols for key negotiation
> and key derivation.

Very nice. Thanks for posting, Steffen.

One point about why PSP is that the exact protocol and packet format
is already in use and supported by hardware.

It makes sense to work to get to an IETF standard protocol that
captures the same benefits. But that is independent from enabling what
is already implemented.



