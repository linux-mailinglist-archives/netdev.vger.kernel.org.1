Return-Path: <netdev+bounces-159551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EEEA15C08
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 09:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F2C16125E
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390D614F9FD;
	Sat, 18 Jan 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hr8hamqX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064F143759
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737190083; cv=none; b=QRp1WJtNORscDG5eyVI4UvcFdQ5JMV6Dx6MKPK/S56ThSKDGIOruy72qFmo1WJCgODWiL+CMV8YMeKK38aBsCHAcrXJDkwzn5w/WmsHFwINPwaWCVYqZRI/aGMCxJW0k7UszOgZd8h6FC7r91R90QSswS2rgCXtGEeZyRewiNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737190083; c=relaxed/simple;
	bh=0yJx5rRNGPV2l//PfLqqSInaxcxnUNTXnqRmV0nyU6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItrHc1s0xNJPcnr/qRmYNo0YDpcf25iv4hEX7cgUuwKPWC8PqiIjQzIl8hydBYMZMa61KJFfERwT4ATpoKVOdBLoukaolR6MeG+Sbwqyhe0I/JkAF1JUJVbuwiqEt3VLz+/t72CTzHZ8OnDhGJ0sOTSX9xpmWSA6VDnihM83bhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hr8hamqX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so4385943a12.3
        for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 00:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737190080; x=1737794880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yJx5rRNGPV2l//PfLqqSInaxcxnUNTXnqRmV0nyU6g=;
        b=Hr8hamqXgo+k3dEURbW4G0fbCmMWWDzcOdiEro8+es0m9L26FGO5XYfOLik2oWFK0i
         ssumVP/xAaAyrXv9VAKtmJnB8JOb9guG/l32SxPyBuQIwbvLLCDd68g8UwWjYl8tBydE
         5PcIfQQTX8zpF2+7p05Hx5TcM03R5BWzIZYe3HxZnBBx1fm3FzEclPW290EKz/s1UB+k
         ElExSc9ApLqbm+AadLK75kwFPGjGuMGQBma651C7QhmanWPufl7IA2QBrkiFOqwTg96N
         33N6wqOXR+xb1DqtNo1HQFuwA5+gjw0kxZIrGirmfO3ZnmTjDDfSld+AXd7umtXq03jZ
         /R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737190080; x=1737794880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yJx5rRNGPV2l//PfLqqSInaxcxnUNTXnqRmV0nyU6g=;
        b=AJY1I85dVGm46iYyumnuna+1Af6rGoH3tc/JYD5iaH8xy6JyZftK+w9MmqQJBTZkGO
         3Trvg3HEtddS13p2VM4/ocmNi5u57yZc5nphVGUG1HhkQhXP9q3qFppv7WEjZwsqu+kg
         E6U7FQTwRMX2mjDIW0bMz30Y5u5POaMbvVlpfXPZzurJwk0kU9FP/w2dMVOql4g88lN1
         LTff53MRU5ka6dXr6CSw5T5wBOmZnJ7pT4z8+2u+9fjk9YYDSlr6qTKP5I1P+45NVIBH
         vVsS1ciglcVhYkAlZP4K2dQJAmCMtwFY1zAcEfwQ/utJuCHEnOALzNd7k2s+noujBWU4
         Frxg==
X-Gm-Message-State: AOJu0YyjQLGKRsJHjWXzGtP6JKXRyeUUuyhbj5SuilzDwB/QzlyFEb+u
	cij1eP0wuALOFYN3Z/ZlFmr7qNAO01MxqMSnoGV/GCVlNPoszHziw72ublJtLdogNtwX4Fg2jXZ
	zU1lfZCzjQxnLqs8APkpDJMdFCjdnoXSbF9GcEtuw86aNrxviqw==
X-Gm-Gg: ASbGncvWWjtPTK31mSlGaoKYwNom1HR2iJxWnc789Cps5PsQ0VbhjTV50KoAWVKv6Ei
	UiamMJwEdsrXzdr92T73cjn9FvCXdesvhT39RNNFv8gI850Vrhy4/
X-Google-Smtp-Source: AGHT+IEnFwhXnm03J3SWw+PQ/PlNc/FcffcGA6TRFCWyhVXYc0TbLUc8te3RmEVGJ9UU/RePdfsr6z/avMIPC9/FWGQ=
X-Received: by 2002:a05:6402:2686:b0:5db:67a7:e741 with SMTP id
 4fb4d7f45d1cf-5db7d2f5e87mr4146630a12.8.1737190079506; Sat, 18 Jan 2025
 00:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z4jq71F78d0gKo7/@gauss3.secunet.de>
In-Reply-To: <Z4jq71F78d0gKo7/@gauss3.secunet.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 18 Jan 2025 09:47:48 +0100
X-Gm-Features: AbW1kvb-Opu_yaUE8oq17iAd7lQEqWisrPfErkRj-q97QTYe1xNRfLssWdtuUb0
Message-ID: <CANn89iKg4255p92EVVm2JYinok=AVL8tPEn50yRGpnevrvnTDg@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm: Fix the usage of skb->sk
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, Shahar Shitrit <shshitrit@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 12:18=E2=80=AFPM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> xfrm assumed to always have a full socket at skb->sk.
> This is not always true, so fix it by converting to a
> full socket before it is used.
>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

SGTM, thanks Steffen !
Reviewed-by: Eric Dumazet <edumazet@google.com>

