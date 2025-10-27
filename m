Return-Path: <netdev+bounces-233257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2C7C0F87B
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C1819C0844
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC9315D48;
	Mon, 27 Oct 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4enI5y2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E4315D21
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584854; cv=none; b=tmwLXuO8Yt4x/zSndeoFNebdXABI7xLcJFIEgGD1rPrB/tQYDESPQWLFiamBqOwrmC1uRrFDSgc/8JXOykCXEXLxkn79W4x1mKWzKNojF1zBODw60U+4uNtt+IDui+lXsS8NNHqj1OpA+roZGBGHFjPhBEssSIzc6EycMtH2j6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584854; c=relaxed/simple;
	bh=pXhyWAWuGnSUpajeVnpBPQzXFWmidBoPTWSdt4kyAJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyaeVC/fBmIerbjTnEguZxZxW3Y7aG929xOXq+wx1eB1no4LEaNuL+jwh1VfX2uQI3xTH/O1L5MrZ9rCgYrIVEsXifdLHIFH9W8uZjF5hch4XQODfU6NlspqHiujjCVki1rXU+bUDOCjy9aL67FtbE2D9OnbW/QITLl/z3jgm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4enI5y2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290dc63fabbso46923695ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761584852; x=1762189652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXhyWAWuGnSUpajeVnpBPQzXFWmidBoPTWSdt4kyAJ0=;
        b=K4enI5y20l8fIH5u0qFACoovSg1fwSi2b3l0MjGSPnnBeaMxjytIY4lXd98U7sCTXK
         seRS+OsTaRJfeyPdN9FWG++SfihE8Dj6EBTmeFYS+MIf1/npvutuxA7T7uC60nJIiXiQ
         9iCoVJ3GE1MleXeFqIUiJWg/x+ZwhWXjI8gZkFI3ViGyE+pF/5aN74It6SyXcQ6rnexq
         5dfrQ8sMTdEteUpr0hT0U7Cvr5KNDtJ7WgArcR/1YaS9yo2bb+wLtAmxsUnihS8dmcvT
         wm9geLo/fqbzWM238/1GvHWlpJHhXG0J32RmUmdEjC7HfjYCxoh1K6kyG0wNK7w410kt
         +NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584852; x=1762189652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXhyWAWuGnSUpajeVnpBPQzXFWmidBoPTWSdt4kyAJ0=;
        b=F7NRcGX6boQdaniJ/OiiM3r38bBd40A1LIChd1beZk077QaYUoJgh+kOPMi2hccOok
         Uf0duZRDOYsOWY8HXYqTPANnM8ybTKnkpI89M5ls5DmhPNkRsWQRqgGhBEh0MGBLrUUL
         Iwwv4V9bUtR4g2JSonUTxs8atg1NuYt5cy6oNDcWSDoXEBGfv6CxDWPrxsrqIRCCbrUG
         zIEYMUCFe7NRmOchWXPN/91hSeTuY1OloNDgnTRHIeNfPpOKkzPb6Vt2jh+DNO1x/dCb
         X8q2wJ8lhjuYQUQWh4zaVpiDa98YJGgQRf8gUu4FV27UuFC1f2LGo4joQfTKD2F1hK5Z
         3NQA==
X-Forwarded-Encrypted: i=1; AJvYcCVIDD8pR5Za0HqOTMZyh87aLZc6mTW/eL42R+EfbAA331kwlgom7ZL/Zh81ew4GEC/GnmdBH/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmuHwLQAZ2tz40bT7c1danaFPDZHwjWnmpmh7r6U6BLDuOEnhT
	K3HoDfLhqY/jzms0CraP5twni5RdiaskGmfhmaFAYhGKPd8hG7p1LM+XFXWwPofsKeGUFiVeZCC
	/MhyRIGpUh3/UTS9N0ktJAZUzQ7mJC0z8YXjXidEc
X-Gm-Gg: ASbGncsMLbLdawCJzjrmBmt7WwJIWaHHqqPZBl0MrR7d8h9daQ1x/o4zUnUkiTMZKv3
	+8saKGRw/qMCUC6n8eRgppAn1AfNQwQJvqR+XbqXOoAgN94ppBPDgLGDDsb47ofG7CU2Exru9qP
	lZ9XeuF6sPVjQXrU+TcYPeY98irS4DntBMDTN3sB5EMOC5jklbAGdiC7WcUwu7cAm1S/XbuXbk6
	GHaqdtaDqvwzE4sdNr2R1qvl7Oz6wJAm69JpaRGMRS8TMTDsXIAQZQtFcbQvcQc9BoaGKU1Rdro
	1SUWi97uwdfLVLYTlIHPw7iNyg==
X-Google-Smtp-Source: AGHT+IGdxT0iOAl8sO+2gv2Hl8b1Yxxk7F5THOUZoQnJ9Xb8hx4TOyF4K4n5Lv/dFQm/oZVKuAxFLrI6/IGqrGKV8Vs=
X-Received: by 2002:a17:902:ce12:b0:27e:ef27:1e47 with SMTP id
 d9443c01a7336-294cb50e38bmr7221485ad.31.1761584851883; Mon, 27 Oct 2025
 10:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024090517.3289181-1-edumazet@google.com>
In-Reply-To: <20251024090517.3289181-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 27 Oct 2025 10:07:20 -0700
X-Gm-Features: AWmQ_bm924ol2jlKpR6m6x-64aia0uqBbx2LhphdSf3eKc4dFQCX-Brra5CXjWc
Message-ID: <CAAVpQUDfHEqJFw-g5fp7BWeam=WYnX_Rf9yEHWBjqKrGEzworQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: optimize enqueue_to_backlog() for the fast path
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:05=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Add likely() and unlikely() clauses for the common cases:
>
> Device is running.
> Queue is not full.
> Queue is less than half capacity.
>
> Add max_backlog parameter to skb_flow_limit() to avoid
> a second READ_ONCE(net_hotdata.max_backlog).
>
> skb_flow_limit() does not need the backlog_lock protection,
> and can be called before we acquire the lock, for even better
> resistance to attacks.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

