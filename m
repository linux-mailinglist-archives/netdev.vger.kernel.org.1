Return-Path: <netdev+bounces-114814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525C99444B6
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121C42817E9
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3E158528;
	Thu,  1 Aug 2024 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWWCiV22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8061BDC3
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494913; cv=none; b=H7I98ZX3wa7zlNQIQGuFI6e5FYNPcAk+5leQvYWHNlOX2+pSPXY3E7nOerpyNLsjC4zexJH087CMfhlMQhjHKz9qhAv4hQmCkhGwK4tl7kHk2306B8+Rn6rFpSa1Ly19pVRqgaIMet2J891tl0VaMtM/5YbB/TuLacqyIdFmI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494913; c=relaxed/simple;
	bh=0WkbWOqOsr6U5qrS6AbkvgQiCKC2EJOwFpdCvshaLRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDud4OwEPNuEc5id78ddpOEl3OEFrw1/8qAk8BvIlva6ijIm0XkXLh33S2NJwBeoHYGl1dOq5JrnDt+iH/nl2GfctW4dezjcYohjvqg0sig9HBwEE5lljiBnL1PxPFFNc2bYnm5MHJRwEd6GqAVMHZd6F383PHQ+636rMWJy7lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CWWCiV22; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso29076a12.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722494910; x=1723099710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WkbWOqOsr6U5qrS6AbkvgQiCKC2EJOwFpdCvshaLRc=;
        b=CWWCiV22IAvj3nFW/nY/BO0aUPflPYHjOMz10+2bhSNn3qzYhxl9QzU9BHjsFAu/ep
         PUdwmXCVSK8oaULUHnWBa9N2G/ljmEcfoDPmHLgHJKXbaF50dhmka8zuN7Qw2hQ1gwgz
         nyufulp3Sks9qxo9N0Z6YxuIrvWnpNiPMWYDJ2MYoJ4GXEnWraQmVpoIPYUCKN1Hh5hN
         cH50s5sT5fVtVtvj31XJtxDF/n8bGofUZEudq7giDfNgfsjWIe2Y7Vrj/VhZHr9bwmqP
         L57FDCK+Fd/m5hR35beuObaL/Igp95ukr3IKFULmxJf2oyfFYmma37XDqmRTxrRXTnik
         CaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494910; x=1723099710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WkbWOqOsr6U5qrS6AbkvgQiCKC2EJOwFpdCvshaLRc=;
        b=Ii+ZP75069bQ/esstrRYYi+rvpkRB4MP1/v+obowybCl2e3fMuFOsNpX7JW2AoX1i6
         PPn9XHDLMvqae9S1478QK+uxkS4T6f1GHSaZFaMq4Tdhhr4cS2bQ+lKUTDiXwKUyYid0
         xIqphInKlWnKBkb31Ft7xJ4E44WgkTkkW3kFT5OZ2wfWx3133r6QN/PMSRjy/qINGHml
         ankUQPVTDcNCtEoLe3n7Oq7xscd3JofPqutOBuXD36ZvQsIbIemTDaXXuw12+MEy5EqN
         AUSrSPtx80QumpyVIbLE8RLDrY6oDMokdrAMPPAnHVWIoTyt/KdagdSVDEYdxF39uPYF
         sANg==
X-Forwarded-Encrypted: i=1; AJvYcCXxHWIeLYhqpvQCDfbb8Q5l1oeTTvNfOwGN4rNRf3q19qZEMHQuI9BU/b0KtyUzjXvKVAc52LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdwtkIVG+lsX6n6qdeD5ONFe2aGiMXQEe2yOZvVqmOiXv6uMx
	PETK2WCPGgFHd7Ie329uE3lDbUk7XZozWIWWqYjr5y0s9qnqU9MCwzewKPBRUkKy272VWOUcRhE
	CRMM2go1hOZ26ddmKszwu6B0m7ZqXC3IKqvKx
X-Google-Smtp-Source: AGHT+IESRkjAvDEMKHNFzzBDNEXfjoJSaBcwCNKpX+DRRCSLqWyeP7fBSHCCSE029LvKR01Uxtb8Z9yNsGS791TdWoY=
X-Received: by 2002:a05:6402:40c4:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5b71bbd2aacmr82932a12.4.1722494910125; Wed, 31 Jul 2024
 23:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731120955.23542-1-kerneljasonxing@gmail.com> <20240731120955.23542-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240731120955.23542-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 08:48:19 +0200
Message-ID: <CANn89iLTZfwKuy5hm2=mSev5kFupyGG2jeuwtaQueKtECbuXBg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/6] tcp: rstreason: introduce
 SK_RST_REASON_TCP_ABORT_ON_LINGER for active reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:10=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Introducing a new type TCP_ABORT_ON_LINGER for tcp reset reason to handle
> negative linger value case.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

