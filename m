Return-Path: <netdev+bounces-73591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3407D85D3C1
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2CA1F23BB3
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4942E3D0BF;
	Wed, 21 Feb 2024 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjUmDCtS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D153C6A4
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508220; cv=none; b=gQvPVz5Ekh72ElY1xpFz+U2rUHVtFKs+6lIj/wCp6gToArWYtzR5oghVT1ClvRGu7/XmDChy49+cpR8vWIfskjpUgCkjMsaY8nIFTa2Q4u9GrjzMifPX/NUv6eKT99myGQfdmsZ6AubxVR/wOQYxgCPSHPT6JW8pNzp2ONxTnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508220; c=relaxed/simple;
	bh=PhLELtG5IxNh9PrEknz1pO27mDw60ZMNk3CeHFdXbOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QW84yFgg4eTnzS2O5a4df/vlqePUdl/JkP5j0nP4VbA8P4xknIYxR31mpis2yv5TXNFCMgso42qXUeUK/4HIEdFb8LOC6C911/woaNXTUvcirGlPErLVXkLONoNuZdrwxgcK13vWA0vRtJ0oa6wCCTvy4sc2/zy1ygS98wNmeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjUmDCtS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso6063a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 01:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708508217; x=1709113017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhLELtG5IxNh9PrEknz1pO27mDw60ZMNk3CeHFdXbOM=;
        b=GjUmDCtSP8FOQvKGG+hVnqTkz4Zt9PxU9Y1JW+NDLrb3ew1xX8H65EW6ZhVlrQJ/gj
         veTR3lk3usBvH+NFkbnlOu+zzxDuBRGxkpf10/UufzhpllDAQNDPgktsAq/+LnzP8pkr
         LXPeAluDTW7IDUbUoN0xKneur4mEzeuSx0qSE5+9vdB6req+8ItrhfOYkyqbMi3Rjmxt
         MbjcscT66YqPLV3YZDv3a14ZZoTmrfeRbD8sVSlm37iKUoVQhxoGBNZ9Hhm9iU1Gjusw
         +Qx9aaiWg2yV0ly72QW9/16lT4RwYmsM/5v3R1X3pukZHXTYt9eOtH6ymJSIbQFIV1Jb
         l0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508217; x=1709113017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhLELtG5IxNh9PrEknz1pO27mDw60ZMNk3CeHFdXbOM=;
        b=CqDcFZHirQxrtu9W8DyWTO7SVaMp0Udn6o0RHcHtQr3bNggA7Lspg9HtKZp83dxKdV
         /7WInc5zOtMw+9c6oiARQw6vHNBhH9cIXsMg7USuQVfBbYBXzHB0pmxveMehWPcU/ZVo
         9A8GPE6Ppc+EM5JC3wBEzgXo6V0qsjbpJ55dzGyunQE7r2pwVDlZ3v8j/BpH2Qvx01JF
         wrAzKWEi2K+NYA7POmlUf6MmM909pfn+8zMrCZpqXU2bGqs6+TOzPP0rWzgWreFmDz3v
         GEg+Q7T0DOrrqPvBem8DcycUVYdJ/hNtOsQasrHxT+7jsyn7lz8wbsygUhRlzsCIm3MW
         FyLA==
X-Forwarded-Encrypted: i=1; AJvYcCVdyUQyOsUifTt7BumpRfRa+kvr4uxo2GP2oahz7jL9g6mwn1jqbSrpx9lB/MZ0iGENLod/z7ikSbw1NxabQ/FcIStAIszv
X-Gm-Message-State: AOJu0YzUGhRel8wjPt62wBFe5dzUpYpcJt12TT+BBgnOu1eyinw31Fko
	qQ7HUiR0NVcx8gkhTHdiNqi0j9rx8RT56ldlbnRDCQhpvIEwnBZZvlAgPgnm6554B4i6ebXevKy
	nFgtv+eA1LY89jlwfjpBvpgDw0lcA4SuIjCrN
X-Google-Smtp-Source: AGHT+IGyf7QompJduXk0v9VBuzsBFbP01ZH2IsTKitqAN9FwI1bGeigCPcHEcxC4CGH+vNkvt1e11Yz/HJZQfZmUOI0=
X-Received: by 2002:a50:bb29:0:b0:55f:8851:d03b with SMTP id
 y38-20020a50bb29000000b0055f8851d03bmr84895ede.5.1708508216667; Wed, 21 Feb
 2024 01:36:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com> <20240221025732.68157-5-kerneljasonxing@gmail.com>
In-Reply-To: <20240221025732.68157-5-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 10:36:45 +0100
Message-ID: <CANn89iL8M=1vFdZ1hBb4POuz+MKQ50fmBAewfbowEH3jpEtpZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 04/11] tcp: directly drop skb in cookie check
 for ipv6
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:58=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Like previous patch does, only moving skb drop logical code to
> cookie_v6_check() for later refinement.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

