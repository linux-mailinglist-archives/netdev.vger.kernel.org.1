Return-Path: <netdev+bounces-216026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41357B31952
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85690B6808C
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5425828BABA;
	Fri, 22 Aug 2025 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HC41IH88"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07692D97BB
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868951; cv=none; b=FvxrvcneWj4sY8dhITHaZysXx9Dz16RKA1CX4m9JXr6Zj3Jch0WSIIBMbLb0RLIQDvY9Hzjoj8Rb8A8+Qd0ppgt94+2M9wipLVqRPWFTnL9FJqMX48Zw/zEDZWCGRRTrvEdswd9BgOTyrEX5LN1ygB5WcxidI/CVWuol0S5d7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868951; c=relaxed/simple;
	bh=B2Us0TQDkvLJo5wPiHbvVUA51tb9PfbUWrylt20eeNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6DlkpxqMWHWkiwCXXOXfBa0pRzRZouZC63nfjMDuEwhL88NbzuQB6H5aeDTLZ3qmJm+4h/JuIb8fQzerEE3sKcHW7n37i/BdE1MflcB1lOD2O7kHDdm430sVO9rK2MOLPzmayVqyMg+R+mArmpZFIFZUjjluC0MQEY1yN0ZYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HC41IH88; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b12b123e48so317651cf.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755868949; x=1756473749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hw2SJCeFgACCq7+EFXEIRogC8i0ffLWeT4H+yfBm7PI=;
        b=HC41IH88OxYUnX3iEZi1MASyyhfVfsAy0BWi4geFhsbFFGA0K2iOx4pMSTW50QxohY
         +vKCQQSMZEaDRYHN73j3z439hODo9pgDz4KBdzN6fq9Ocsn+s4HnC0GAusL7bRPvDphO
         2Y2rP6RNkQG3FgV3KV37CgAAayfwc2G97d7UFNNUWawUdVZmDlykYviv0R5TFBFZq2FB
         GdIXD+tFVaAkNFux24LNTbdd5uZ945I8TbWOAsyLeppjm9Sf+44ddLxm2a9lcjVk1kuk
         Okb9AAgaHPQzaqkxaGRZr8DfEXYR3tStvmtRpa7xC71jJx2YVfAwPtaqUPqXO/V2KLLQ
         dbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755868949; x=1756473749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hw2SJCeFgACCq7+EFXEIRogC8i0ffLWeT4H+yfBm7PI=;
        b=N2JXTTchZ5u9UCgO/8mSALNfcV1gOPogAjTgzaehhB0J6fe0CDj+bVIQmVdtot4eyV
         7moVHj5HelqQ30P3GmrFyprD7QuC5eNbchViLnoEuU6PVkB3YXLwF5stAUWSX2hMW3PH
         m1dNWjoEZx3M40a+OFnDeY/LRzj0CZhh19HDWAZzrSHqXgVN3JwIeEMiSb7jQUK+EbL1
         DH3KGEb+6QmDQ+7XGdzwaa8KFIfBKsLLI/gySESSRrP6Vw3LOw+4EDgKEa7SH9mL6l5b
         YpT6iRgnI3in3DBPDCHu18TZyIxCpo7+gl+ZzEbfdhOL9WzkHCbMo18u37HgQoA6wxVZ
         oxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCViJ3lVPwOnMPreylDTVplaj9nRUS469Q4hYmcVy7MN7Dq5+M3BOe9ofZLHI+XDDUaYsB2LbBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtqZM7PVXzxraVdL5+jKXUYLoUezFpVNvc2jplOBbFqbuMavH
	0gf4k/uKDIh81wtEvvMjIv4eFbZtnZVBeMp42YZYImN64WnLegw0erOCVo+hZ+cQc5fJwxbA4eI
	tL2n9IakdxUWpkpyM/pTgFgtHMT/zme2bFFELtUYK
X-Gm-Gg: ASbGncsMgyQlf5MaGJ79MB2Ih0RmKyxBBtU1QXjD/6LCMXUmygG+xtkDS5ezM6jX/8j
	OKUGVxqKTJJ/RbYvYJ6pQgpyvvxqFicunshWaMM2OlSYs0XafzUIr/GqcRi5ARSDV701PmVouz6
	ZJRQBcALY9R/3uKa7QMpclB1QKNU2QN4v7Mzat7J6GFW4zrmnPE6wGbqQsgFAjUwyGKsxZamykD
	P44aObb3eqQnfHo4MpaIAJw
X-Google-Smtp-Source: AGHT+IErMQiMS91SQ56WqovZ1fX6HlUvwh9HoobViQIqs3vmYDmCjYzXa+f2hGUBbCo6N9haoM4LGrgyfwt3QOvMv9A=
X-Received: by 2002:ac8:7dcd:0:b0:4a9:e17a:6288 with SMTP id
 d75a77b69052e-4b2ac591609mr4349921cf.13.1755868948172; Fri, 22 Aug 2025
 06:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822091727.835869-1-edumazet@google.com> <20250822091727.835869-3-edumazet@google.com>
In-Reply-To: <20250822091727.835869-3-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 22 Aug 2025 09:22:12 -0400
X-Gm-Features: Ac12FXxiCwZr-dme8Z88M_UAmmmbTleAeDX1BfbIrjP7EusgAt2NBy12wEbJx88
Message-ID: <CADVnQy=D7dFCS3ZtQNQsNBuz+6GDsq3NBy=b1BYXQA7E=YyTCA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: annotate data-races around icsk->icsk_probes_out
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:17=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> icsk->icsk_probes_out is read locklessly from inet_sk_diag_fill(),
> get_tcp4_sock() and get_tcp6_sock().
>
> Add corresponding READ_ONCE()/WRITE_ONCE() annotations.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

> +       WRITE_ONCE(icsk->icsk_probes_out, icsk->icsk_probes_out + 1);

> +                       WRITE_ONCE(icsk->icsk_probes_out, icsk->icsk_prob=
es_out + 1);

Do we want a READ_ONCE as well for those 2 cases? Like:

WRITE_ONCE(icsk->icsk_probes_out, READ_ONCE (icsk->icsk_probes_out) + 1);

Perhaps it's not strictly necessary, though I see several places in
the code base that use this approach for increments...

neal

