Return-Path: <netdev+bounces-160505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D85BA19FF6
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867C316797F
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 08:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019B120C010;
	Thu, 23 Jan 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQFDZQKR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B97020B800
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621338; cv=none; b=WjKSCRm1AvaF8DvsexfETJOz78MwcGkZtAiD4FC+5i53XvU8cwjeV/LlIHtR4oP4B1DAivAohI9/FtOU4ErmNOKXMw6fChkQitubPYqIyUOFdWrvWJhUVQWj/UtGCgYEZD11SjJ7TOrQaAdfQ8A3eWA1Txzy20NbHLuJwSFc3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621338; c=relaxed/simple;
	bh=ZimtWzmtoRn0zBBmr3fNGH8DWBXEuJMF4xxVwaG4Du4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6vBSvrU4UV/HNCKh2Laxnn3quEbyO460MFdHHabk3r2Zf17sP7WDQjAGwtkR9Zj41y9Yor64LoTRlx9IZaIamSw7o61K0sA/fi5t5X70UF3cxUj2nNsHyCuJvWdOQ/eSY1vMSeb1Q1DaDfuvSqLaPJn8TGqg8P6yp/lSRMHReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQFDZQKR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so1167978a12.2
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 00:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737621335; x=1738226135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZimtWzmtoRn0zBBmr3fNGH8DWBXEuJMF4xxVwaG4Du4=;
        b=eQFDZQKRWjXx3mhkKrBZkY+6p/BXrdKUJhEVhX/KbK0p40b2t+vWPZP405pzZ/kH5r
         w3n4ThP9jPXxUbmBQ7YXUP0/3ygjN333GAFixv5ObzfeK4wR2ZNtsmXsIuh74n5aG9tk
         42ppH+fog0KMisB+VHn76nV3IuKr4r2lOmhaEiecueqfYRAdBdCoySlhqUdUtgAfL/df
         UOE1iBR0pCLBjTXEhKUqNqDr4zqVtHJZDaAX25SbrmDxQZjs7XPioSzz+MP6LPPR4CaZ
         pA6fICMgfIniCVhDuGbJEuJHTep4Uq+cCJ3vpXC13itaueIZCT+x9GsX33J7bPX51K/9
         Krlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737621335; x=1738226135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZimtWzmtoRn0zBBmr3fNGH8DWBXEuJMF4xxVwaG4Du4=;
        b=oXTvNerzmgnnVAlYj8avYciy0RjusNwV3J+CSxdmwfViqsmAylK8Z/NrDHWaVdn+lP
         L8ctIUDuPdofzhCO8sQ3ldipTHW5LTlpkvG6kYpdZhaLoyBgp0FpnbYZZFQ8Gtc1oOI8
         WjIrbW5I6PwIkH0YvzA/MWo4GhT23C6brfF/EnH1Pa0CoeCzNjtIcNGeb7/mxERvJN9C
         5V7EYwdzb1MaPwycAWfPK11UUf0JGRLaYrP9TP2tlObMhj5KhzjqSp/P62vdfD8iuhvB
         wyueLemK+Fz58/28Zd3TlMUskthri1mPvpY1EWz65ZZUP0uW1hrhTJP7aQylHO+9gpNN
         +LnA==
X-Forwarded-Encrypted: i=1; AJvYcCWZKYreOw7SfNZNgHkAoNFxywi1G6UJZTp6M49AqmBAOB2rGYe2J3RJG1pDhhIgttkdVtAej+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpcS9yeJOYtk6gQCYEXERrNTqwkbesorqxHlMK6qu0FicRS+pe
	D9i9KX05AXT6fV/Yo0N64IS1Ep4gEszP9U9LbshCOfqSo+Ab65yMMzBdKuqGMCP5Hy1lrB4ZGja
	9nnp5KLpYuboeV0n5z202r3ocFGZKxBQe4SZ9mnR0ba6FJOuXfg==
X-Gm-Gg: ASbGncs0Q3UBpLL5xoGhh8Q2QV1wrS3rkHra/OdVfis3L7O/ICyJrUgWEoXjLq3KmS8
	CISUH9CMGelYFRIhbChq7DTQ+TwBWkFs0hxATgtyj0Nqtbb6tQqxKakaLYRxQ
X-Google-Smtp-Source: AGHT+IFtxqHGcNwvgxixlmy6o4ew/qdNykOEAqnleRnPUq4Ps2wzf24D53UtjIbG41bsJtZ26ww1MyyHBK0syc3BnbE=
X-Received: by 2002:a05:6402:3550:b0:5d3:ce7f:abee with SMTP id
 4fb4d7f45d1cf-5db7db08623mr22895163a12.25.1737621335315; Thu, 23 Jan 2025
 00:35:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123004520.806855-1-kuba@kernel.org> <20250123004520.806855-7-kuba@kernel.org>
In-Reply-To: <20250123004520.806855-7-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Jan 2025 09:35:24 +0100
X-Gm-Features: AWEUYZkWOcjVIxf35MkfasYofnVKj4UG_H6rnEdLpG0RxgNyviKVDUkt8zWkI8U
Message-ID: <CANn89iJM8Rb=zYDbvUjwV+MKqA4m3nBzau+OkPHKtquc=yF1kQ@mail.gmail.com>
Subject: Re: [PATCH net v2 6/7] eth: via-rhine: fix calling napi_enable() in
 atomic context
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, dan.carpenter@linaro.org, 
	kevinbrace@bracecomputerlab.com, romieu@fr.zoreil.com, kuniyu@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 1:45=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> napi_enable() may sleep now, take netdev_lock() before rp->lock.
> napi_enable() is hidden inside init_registers().
>
> Note that this patch orders netdev_lock after rp->task_lock,
> to avoid having to take the netdev_lock() around disable path.
>
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanle=
y.mountain
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

