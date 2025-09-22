Return-Path: <netdev+bounces-225378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755EEB93288
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA8C1908151
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDBA3112C4;
	Mon, 22 Sep 2025 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDHEkBH+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C3927B343
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758571055; cv=none; b=Qph3ljllBcB1aed6/SYhQLTUgklCq1UA3/NvO8++Xd5Siilp1xbL4hLCwZ5jlQMuq6JNcwe0dPtO2DUdBqXf/s2ewqMQCDENuP1mzNjZSdH3i87Ouvq3Xg8Ct+GdiAOGwahaVutDToKVeK/aoM7FaHB8QzpJdUS5kkSEnAbjI4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758571055; c=relaxed/simple;
	bh=6dSoAAYhz3cwGVfk4zabHDqSxNRod72MiDNEA3WOIhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BG6Q04Ov3WWDTh8sG7x28IanDAffNXQj3fpOGjpkkASvpsvmpsGwHgPKlM+sAuu+tY7A2bzHBFVtRuKCe6vxBEsZZInRTKDQb4xn8eCFpTvWoK8chSBwNZxtn5XzE5146qZuUHAJpOhOaHgL726RiqMCFaSQ/empN+R53AgVgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDHEkBH+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4c794491480so25958431cf.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758571052; x=1759175852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dSoAAYhz3cwGVfk4zabHDqSxNRod72MiDNEA3WOIhQ=;
        b=CDHEkBH+M2gbi2r7rj9p9IBb9weyctjLbqLf89jiXKTa1xn6Lvtla+Rf5LG/skYxXG
         FtCp4075DDcaM54u/B7gcZ46hhdSgRdSR+l+Os43dr7DkUyT6yYKBTE3eKCMWGXA6UK9
         HCIcmOE+jMyUg1R3lcnk0aUO5cTxTy37SihLyC1GSPp7NjhCMv529vIAB72AN5CgOc7Y
         kHlOHsD12fcbNkJ9VCmDoZpf5+QyeKEyPP1cvdyli/BjohIofLujhhfVcWRrLKMW9rKc
         2gjVdOlV7Qpyjtsd6GKwuBDp+el9qnUUS9AHweijNKZHwTIP2jYnqE2SXzONBoUzwMeE
         Uobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758571052; x=1759175852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dSoAAYhz3cwGVfk4zabHDqSxNRod72MiDNEA3WOIhQ=;
        b=g6JmDFST81r4GVcaQbbyj88EEMdemXnEShiDyc0N6Wk1DoJJZ0HoF+pDsb1ncJ4R42
         mJmtIyahzB4eqw9bMbZjntHmlOA66A5WYsS8KGtPwbkd/vOl171UEv3jxmoBLeaA7tTK
         UwnpBUbwxCb/1laZ9GVXLMqZ/eO0xyRx9p48JTSXBy95zVm2lF06Uc+JWtxYKjBzeSJI
         MJkeXr5sOmUwetl5oxx809fFLFql8QAnzIdSOTuJ46sYkSZ2H5OJNz0aMc3pcmdUD3w5
         Opn9h9Gx8a1HPWwMrhLD6GuXnyDVsSLJpMFvX6cbynZBvhjI6tKsA0JSBF+J3ihgG3p0
         Xjbg==
X-Forwarded-Encrypted: i=1; AJvYcCV//f5+yG6mSjwgUmSZ3Fi162SyTJ2xJjwV2JsUA3ctyq3WaeROZKSPp+9LIdIsdPpAzrTTORo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmd6ul9N5koHwAUbOvyVpl7ALfh7LOJtKtaIbe+swOzeu2baW
	YcfhDgJ+2+76sP0JDqyksl9fcXvM53WnxQKUjkRO80NJtWPD1cT6nynjiMuqJqeeBpQE2xPbwEy
	hhZ91vQIGbwc7IxNhDUGndwjDMtaXgLpqQ2napIvt
X-Gm-Gg: ASbGncuZQQr/Qsap+GCsQrDZrCQYw9+DklJRlQLbdM6JJyoTe4zxPHPMVqdj5os/rlM
	lE1oR8t8VmH1WOLDgq8jaODQQyB5i61nk17aOhP0FfPIjTbXYoIwoi4IFUpba+RlhmC+x+gjHLO
	Exp4WOgspceF9jgiZDdJkxZhUjJMGrJpVZDzsRJBMqg3WnuHqAD28p8Os7fKK9flXA3rw8G2t3k
	4GVUDM=
X-Google-Smtp-Source: AGHT+IEeviadhncbrfeMEEuR73auhdbI1jMRLd+NxNAMS1vJ8sJYiukZi0tcp9HuQo9jrqmfGDrK+b5Ag4ZnsKKUmQs=
X-Received: by 2002:ac8:7dd6:0:b0:4d2:5b2b:95a5 with SMTP id
 d75a77b69052e-4d367a1dc0bmr1104251cf.13.1758571051733; Mon, 22 Sep 2025
 12:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922191957.2855612-1-jbaron@akamai.com>
In-Reply-To: <20250922191957.2855612-1-jbaron@akamai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Sep 2025 12:57:19 -0700
X-Gm-Features: AS18NWA3cCg3f4HmavVtv-Q_SWtDz_qJwoo5c9pasDG7TwmOUAr2LOdUw7aJjbE
Message-ID: <CANn89i+rT0=9vVOH7dVqm4aFHjwEf0JEw4bF1PgH+FwtJNAt2g@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: allow alloc_skb_with_frags() to use MAX_SKB_FRAGS
To: Jason Baron <jbaron@akamai.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 12:20=E2=80=AFPM Jason Baron <jbaron@akamai.com> wr=
ote:
>
> Currently, alloc_skb_with_frags() will only fill (MAX_SKB_FRAGS - 1)
> slots. I think it should use all MAX_SKB_FRAGS slots, as callers of
> alloc_skb_with_frags() will size their allocation of frags based
> on MAX_SKB_FRAGS.
>
> This issue was discovered via a test patch that sets 'order' to 0
> in alloc_skb_with_frags(), which effectively tests/simulates high
> fragmentation. In this case sendmsg() on unix sockets will fail every
> time for large allocations. If the PAGE_SIZE is 4K, then data_len will
> request 68K or 17 pages, but alloc_skb_with_frags() can only allocate
> 64K in this case or 16 pages.
>
> Fixes: 09c2c90705bb ("net: allow alloc_skb_with_frags() to allocate bigge=
r packets")
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> ---
> Changes:
> v2: Add Fixes: tag

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks Jason !

