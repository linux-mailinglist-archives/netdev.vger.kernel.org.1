Return-Path: <netdev+bounces-164705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A65A2EC6C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919203A3C68
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DADC20CCE6;
	Mon, 10 Feb 2025 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4DZ9pK3E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7437528E7
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739190376; cv=none; b=iLqpkfMLDsTNkdFyEco0J6PBTLkfsGXxVLpQABKnIIULYAG+mQsi2JLdI/4wUHP8zAB4NWDsUEDlr+Qejdbwno6KQ8IJqSGrPCsAA0730srgjGO2IWIZk3yT3AwBSEYmbw61dDPBX8wbLErnPN3LxyKGxxE8A7e5+SVuf0uMjdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739190376; c=relaxed/simple;
	bh=4VQ7I1Iyv/yBYzSNjAn7ui8DOzbKWKL02BVPofKLPzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i24TFokRnBjKNwFb2+r8M1b+1a2IT/VRWHIdpkBlFSUXQP56e2JlkvqjRqdX4o8VuIQjspKYtNAlBrE1zZyoLRUlrdK5rfn7elcj8Oac+aENRVRxF4UnYziY9i5YZ60Sj/LnldGB9jxQ/FTg2I6vkMXXgrqaJvKUhYd8LCmTGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4DZ9pK3E; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de4d4adac9so5576292a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 04:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739190373; x=1739795173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VQ7I1Iyv/yBYzSNjAn7ui8DOzbKWKL02BVPofKLPzs=;
        b=4DZ9pK3EFlYB419ULxsiJvOQWBOO9mZNPck3EpkVE9QloJpk2jSzOr85dKyIG0qQ4r
         w+6vXpFPCAFVaZGLpD3Q7IZjAMdIiZF5bZXZGMjQ4/0eHsg+7HRZvz2wYTPagJWByDHV
         8cC1w6/X8H4bjjZgWgiS1jXfRSCgtuOyBzxZFdpESEMwUiwl1bpGJEg92JYVtgoCWFiF
         yeDCDH0tEHqX7tl1GNHCqL60wBpaAooGM+Id4lT5X+dRs3Q0lQBxgCCZTz2slkCuI02b
         Gd0idHmRekUzbCNDw1i3QFNX+vRLKHDHhceT5XHpdLM3VyuoT83IMbADGKm1/jkBETnc
         q4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739190373; x=1739795173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VQ7I1Iyv/yBYzSNjAn7ui8DOzbKWKL02BVPofKLPzs=;
        b=GD0vWTrwgM8uLdusMy/vtTOumyjICOeyW/CkIDJHhwpLZxFi+zOJjM74aNl8OVtqv2
         0ABYgsMFmKVWApqPyB/OCkCiilgwMq4j2H4mvnh8myrQau8jHkcIjt8FNhhbkk+qBXKV
         syZik5U1SW4ISe1Sy2R+hyX83hl/AihJUxClqgdGTiyE+KuKnrfmU4yvGBudiZNMyLYL
         kEch5LSKlan0c6+z6sXHqkbn+wvNIjQ2TZhzq5F4XCUAKHjTmKlGLDqjCjhmzOwsxqD6
         ktcCXaeSyH1YoWacb+xfO81RTK/3DaTWH6RMIk7k2nIuzAt009coKqHKFxDaxvZZvGdf
         9ziA==
X-Forwarded-Encrypted: i=1; AJvYcCWrY27Qu0f0O2Z255WBY22zhmuERnPEtNlOvt6faonysS4WYzpBslOBeNnzbgFtOeC34C/BAbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE4u6h7ImoNdG6196VHNSdrX2cB0WgorHPyioM9FXZfwIwPe97
	GP9gzayr7BUEXrW9wfeujMALUq0OQFnmE/m9otg52NK8JGTfj6zLZH07MFG8PVspeJ1UuH56tyI
	M4KouUIQ0esYw9h/NjBWcFUQf2YOBUSJ6bmas
X-Gm-Gg: ASbGncsGkfz5PcP2PJMTres9CyhogwMumoiLl05/+93BS3sijUtg+TWytkaXkXs1RTK
	JUN/zz0FGOhAyQ1zmbAJBYs4o3oo/3fAZyGSny0KMwYLsFFS3DD+nKL0Wu/7uP2yccWoWMadF
X-Google-Smtp-Source: AGHT+IH2PdfeIyEiVSG02ORlHdFwVrC4lYmmGqQcte2M1wxsqJzuJREjkizum69brBt9IRcZhkkIEFlPgiTEEncMaq4=
X-Received: by 2002:a05:6402:4304:b0:5db:f4fc:8a0c with SMTP id
 4fb4d7f45d1cf-5de45089da5mr11643051a12.21.1739190372580; Mon, 10 Feb 2025
 04:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210082805.465241-1-edumazet@google.com> <20250210082805.465241-4-edumazet@google.com>
 <Z6nHRDtxEG393A38@hog> <CANn89iLCrohtJrfdRKvB3-XNtVjKDucNeTcxrmn4vAutgFyXAA@mail.gmail.com>
 <CANn89iJFcibv9J+fe+OzNVw4t5tS-47GZpmHKacSQ9mS+g1TUA@mail.gmail.com> <Z6nkddoL7RAHw-y5@hog>
In-Reply-To: <Z6nkddoL7RAHw-y5@hog>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 13:26:01 +0100
X-Gm-Features: AWEUYZmNwwW7HZ_het_KofsPt9_BaWwfsAqoZTHiqH6heTL6pEXStO3XNdURSBg
Message-ID: <CANn89iLNhfjegwD5TUbxEJwMvDGqh2gsjsDe_7Ktp53=58k0oQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 12:35=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.ne=
t> wrote:
>

> I ran a quick build since I was concerned about what the Chelsio TOE
> driver might be using, but spotted this instead:
>
> ERROR: modpost: "secure_tcpv6_seq" [drivers/infiniband/hw/irdma/irdma.ko]=
 undefined!

Indeed, I had the same error.

