Return-Path: <netdev+bounces-158114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78927A107AF
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE89188813B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6F6246332;
	Tue, 14 Jan 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xISF7MZ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE3236EC1
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861123; cv=none; b=jX8G6TwR38WHHYCaLur92Yd8/gSII6W+dGt7o4oRTF4+6DYvjMIcI+Wga4eJDFfRVenbQq9D0PV0cGQiPaWDAdWBENRcFsEA3lx2O4wdUt4AMBBEWmK5NxTY5TSMeMGaRxH6GNfbUeFa54EXvh+nf5NgZFtZE7aYWfTNGrYlUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861123; c=relaxed/simple;
	bh=SV86mLfH2qulLkaFoaZuHBdXwGvvIm0KfODsbYPfvz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fv1sbOGWo7jEbkkuy43rurhSYf0ONWVRG90RU8MeLmgGrPejc9TJlCpUKIBVHvHiilVaRCZ1lxhju6d4m96LAce3796Q6pFMKJRUBtMIuAcQpTNIY84hPBFBllzc+WYSnb6AG5OjlhQYWRJZv00Krx+eT2opJpOMaCmbElpDM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xISF7MZ8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso967701266b.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 05:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736861120; x=1737465920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SV86mLfH2qulLkaFoaZuHBdXwGvvIm0KfODsbYPfvz8=;
        b=xISF7MZ8CuN2PTXcD9XPNDHKH9tm2feDbGGdG/zwbaQVsXHKJ0kmDB1mvKrWLq6rUS
         bveNWhgtDc+g9JqnLdH6M0FBafljRCGDDHJN5U0O9bN69bVDFxnA4Z6Xh5abjjgATRqa
         tHtsrxx+aE5jXtyaosHHCf4sQkbu1lliO8f2HF5cH3hirTuBpodCweAJMuzoF92uEGpc
         370zNBowBfk0FSmn9WBLc3o3g/V6WIbGgL66BPNEgP+ccAyLh1jYR1+D/U2a5FYZMH/d
         t1x9pb1NFCvpnZV2C0CW5kucNlfZQMTKrGsCiX6T52wUY+d0oAZ3Y9cxcoyVA511m7e1
         O2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736861120; x=1737465920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV86mLfH2qulLkaFoaZuHBdXwGvvIm0KfODsbYPfvz8=;
        b=WYmEdGkRAvmoybkNsAGtCZXhKb2lpvDoW7Jwg1Aj6AA/RStMXMwXqUCGwlrFylqUOh
         yGd9LMSL1xgMlczaHbeHmp29jdUNYq0VmPKaz6TYX/cTYgNdIe83RYipbF2+d/BYva3u
         yAa4IINFeRfug0BnP/mWi83/TaJDXOBu09ywhWLQZBj1FwRNMu+YkIQ6SZMeaOwOIfU8
         6Nn2cy5OLVfrhkyEcR3dvb5vNwtF1jrMt9MECfhyEQOdORU12lzISyyqXFojii//wnfI
         oaELjcTba1l9cERtuzo7hOiqvb2KpR/ceq35KkpsSNvJPYF2hsJ0XBCj42nXEFBFAV9+
         clvw==
X-Forwarded-Encrypted: i=1; AJvYcCUPR46mtTOll26ybHhKwjX7z9/Lc/yChvkbKsJ8YjptH2rQO3sJAeudRnLFhwBy4CPyfskKpXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+sMNmfankX+X/wmXu/s58afGla8gTm5/eYaDftammqqPof2o
	vY8EcdYIqmSRE1amLuJOObZnfTrpXI/zsp2V0TSQtE0rGj2kltVMig53qPc42xrsX0EW+c03Atn
	bLH45yqpLwQcAopuC/vQJfvYfchwpMka7Mtcb
X-Gm-Gg: ASbGncsancE6LDlzS1TAE4+tHJJWwSNpxlqxVX9c5gwg8oXXTGbdNbsgTMQOnxvWpSd
	A1xguupQcokdr6OVMaQ8TvM0DJjsCIuDI3bh5eA==
X-Google-Smtp-Source: AGHT+IG6+0zkonIw+2h9nrkHRFstNyak85Mve3pFwFCrg26ZQs/niCLBKhqu6NV/iXbHAtDAfxtCLSgtYfSm12WEhQc=
X-Received: by 2002:a17:907:7d94:b0:aab:8a9d:6d81 with SMTP id
 a640c23a62f3a-ab2abc6e270mr2038851866b.44.1736861119878; Tue, 14 Jan 2025
 05:25:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114035118.110297-1-kuba@kernel.org> <20250114035118.110297-12-kuba@kernel.org>
In-Reply-To: <20250114035118.110297-12-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 14:25:09 +0100
X-Gm-Features: AbW1kvboT8eHHM3kTg2uGJd948NGmEkMU9iip547WDv2Um0A9rWNrC9MfQd-EW0
Message-ID: <CANn89iJXZfsPC_fSziLW_aUjO3sEmRZV-hRKYzQS4NSad0uDsg@mail.gmail.com>
Subject: Re: [PATCH net-next 11/11] netdev-genl: remove rtnl_lock protection
 from NAPI ops
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> NAPI lifetime, visibility and config are all fully under
> netdev_lock protection now.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Very nice series Jakub, thanks a lot.

Hopefully we can use this per device lock in more contexts soon (ethtool...=
)

Reviewed-by: Eric Dumazet <edumazet@google.com>

