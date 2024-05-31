Return-Path: <netdev+bounces-99764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FF18D64C0
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27525B271C2
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735035337C;
	Fri, 31 May 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIxqLIOy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46B2233E
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166809; cv=none; b=kFVoUpPlnKSA5sC4F1ce6YvOuw1xKOQrntyh8xuQ/ZYKYTstEcTVfr+MHNcF7lo/uizuxgz4z3GiiFiMgmGtWWy4qOtuO2V8R+zQTvlHMfvAp62UxaQSd7u5YaOM8nrqeOmlaqGxbCQmeeZ2Xkq/O1aQbJDgprHFLOULwV3iVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166809; c=relaxed/simple;
	bh=7cuhSZIVrf02s7Dqtu4woIFIW46cbVuZlO2z9yNeyNw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=i06HOghz2HFcFKGnQDPKTM3MEHkthdwROV2fzixBSLMfb3DhszPS/cwBQYuFYc8pleapDs9MvZ+VGUOK9CD+yzmmwoBnLJ9KTbOlpX4DnqtJSv9tKkEpjw6fwPrJjh2uYOH4pBOuUNVbGY/tVKtoinnpoPD7frX0mu0hWUEphsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIxqLIOy; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43fb058873bso5720651cf.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717166807; x=1717771607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pncjrM/rcfmj22XxUpDcMXbqLWqiXgeyTc6o80S9nw=;
        b=NIxqLIOybrO6jEuMwNa19YVMpiifQV0IZjrgN12meb6qKsffRZQPmm0dZU9Xk9IndM
         pz2kHbvz1CEY18wc1A0e5jfyhrjYQhkXIIcIvN3x73iNbWH2JEgXxwnpxbWqT7SMCudQ
         O4SwvWM+dNFJw3mY6FYaJPFzWRP0+4SDsHXxxxoGPW1uL+83ycVUbsHiRbz7z7jumj+I
         pc2q+OJetK6mAOM2phEtLbqjMWw0FLlJ1fqQ7FVRwnSrRr95VORMspY19/W1k0TNgteZ
         g3Sjb9nokJ2Plr3dEKNq1shjaWP0xhjlsKWlB7jNIyRb8IR6FvOD3h8bsmx45IGX9iIX
         ewAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717166807; x=1717771607;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+pncjrM/rcfmj22XxUpDcMXbqLWqiXgeyTc6o80S9nw=;
        b=ufjs26yPW3GahonOWAhzKXwQCVuky23PLWYQO+4NeTm1eZEWJhe6CubQFWN72o8QBv
         k/mpanHdQ/qQhnyCBNHRUuXO4I+vCLivb+vtNP2WBP2kOZzQD7BrHSNiHzLdZkbepM4k
         29Ty0CCGXQtMZfZDygZonuM6RQwqu2N5jjNrmWw/51jjM3Z9MV//SKZMcFArlagyF8K0
         G/JiAyKI/BYSYD5m+GbdsXt7RPRK4VeYAz0JfNZE6nbA/lT2vwGW/Og2OsjvPy6Se+oD
         O2Io4+C/iq8q3PzNIIQ8J2D2WOPY3gXlKlo3z5llnvkkXSK1MJ1Veu77LPmBayT5sDGX
         FutQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKd7CTwvzx0kO1MX5URSNfddv3FDkdiHU9kB8rlXHzLHfcVIRKOwZ6NiNJ0V54P6mc9DnpHtnL18edj/446R9CCZ2xoRWH
X-Gm-Message-State: AOJu0YzY/1GOKe+pBMFHut5aCkR8lI306/AwlzJcDIH8lLI2hpnyk3tG
	OsqQ/GkPwxD7Pi1Rpv0N5yMVUxTU2nx+I1PiQ0uKPe4iVFJqdSjR
X-Google-Smtp-Source: AGHT+IEX7L5Mgxn6feqnRT+guMTMGPipb4tnNQ34PwSG81TpaM2Vx4QZi7dX1C3DDv+klgITpKxGCQ==
X-Received: by 2002:a05:6214:3204:b0:6ae:abc:82fe with SMTP id 6a1803df08f44-6aecd59a276mr23897826d6.27.1717166806635;
        Fri, 31 May 2024 07:46:46 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b417a3esm6907086d6.116.2024.05.31.07.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 07:46:46 -0700 (PDT)
Date: Fri, 31 May 2024 10:46:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paul Wouters <paul@nohats.ca>, 
 Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 borisp@nvidia.com, 
 gal@nvidia.com, 
 cratiu@nvidia.com, 
 rrameshbabu@nvidia.com, 
 tariqt@nvidia.com
Message-ID: <6659e2d5cd07e_3fde492947a@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZllpgEvQ4QnfP3m7@gauss3.secunet.de>
References: <1da873f4-7d9b-1bb3-0c44-0c04923bf3ab@nohats.ca>
 <ZlWm/rt2OGfOCiZR@gauss3.secunet.de>
 <6655e0eecb33a_29176f29427@willemb.c.googlers.com.notmuch>
 <ZllpgEvQ4QnfP3m7@gauss3.secunet.de>
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
> On Tue, May 28, 2024 at 09:49:34AM -0400, Willem de Bruijn wrote:
> > Steffen Klassert wrote:
> > > On Wed, May 22, 2024 at 08:56:02AM -0400, Paul Wouters wrote:
> > > > Jakub Kicinski wrote:
> > > > 
> > > > > Add support for PSP encryption of TCP connections.
> > > > > 
> > > > > PSP is a protocol out of Google:
> > > > > https://github.com/google/psp/blob/main/doc/PSP_Arch_Spec.pdf
> > > > > which shares some similarities with IPsec. I added some more info
> > > > > in the first patch so I'll keep it short here.
> > > > 
> > > > Speaking as an IETF contributor, I am little surprised here. I know
> > > > the google people reached out at IETF and were told their stuff is
> > > > so similar to IPsec, maybe they should talk to the IPsecME Working
> > > > Group. There, I believe Steffen Klassert started working on supporting
> > > > the PSP features requested using updates to the ESP/WESP IPsec protocol,
> > > > such as support for encryption offset to reveal protocol/ports for
> > > > routing encrypted traffic.
> > > 
> > > This was somewhat semipublic information, so I did not talk about
> > > it on the lists yet. Today we published the draft, it can be found here:
> > > 
> > > https://datatracker.ietf.org/doc/draft-klassert-ipsecme-wespv2/
> > > 
> > > Please note that the packet format specification is portable to other
> > > protocol use cases, such as PSP. It uses IKEv2 as a negotiation
> > > protocol and does not define any key derivation etc. as PSP does.
> > > But it can be also used with other protocols for key negotiation
> > > and key derivation.
> > 
> > Very nice. Thanks for posting, Steffen.
> > 
> > One point about why PSP is that the exact protocol and packet format
> > is already in use and supported by hardware.
> > 
> > It makes sense to work to get to an IETF standard protocol that
> > captures the same benefits. But that is independent from enabling what
> > is already implemented.
> 
> Sure, PSP is already implemented in hardware and needs to be supported.
> I don't want to judge if it was a good idea to start this without
> talking to the IETF, but maybe now Google can join the effort at the
> IETF do standardize a modern encryption protocol that meets all the
> requirements we have these days. This will be likely on the agenda of
> the next IETF IPsecME working group meeting, so would be nice to
> see somebody from the Google 'PSP team' there.

Sounds good. We'll try to have someone join the next WG meeting
during IETF 120.

