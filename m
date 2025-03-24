Return-Path: <netdev+bounces-177205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03528A6E445
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4331885B27
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396DA19408C;
	Mon, 24 Mar 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xAny8cAd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836108634A
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847812; cv=none; b=gXD8CkfwysZ522/+KWe86F32dIyLrB4LUMtg+z0poZP46AqkdCu3LO45ZTJ9NTOiIb7NK9DXTk24VHbIFMYC+7H/mNSOaiNtTKgZhP6UTvQMdx24saw9ZIJE5vnbqg8/sTHdckrBVAyh3mhI+0Me7Jx2xN+4mG56zmyh/Ru7USU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847812; c=relaxed/simple;
	bh=FTVvZcbXSCRG4isEJ37AdJ6AjKt0CLK/juUcRo4yxHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taWp9MVeazMgtMrGRozU2YPsvvxu7msfYGx+pk7mOik/sKfvywrQaMp1f7PVC8FVI5p7eR8yXWetAmjJtaEQho5S1IhU60BfKKoTvYnSrZ25DQ9VgKOvNsv9y/ixCvPGqgh3xXQQnQED8qoIEIIjOlrU1sO4J0Gc6wP6R1fPZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xAny8cAd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2242ac37caeso13035ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742847810; x=1743452610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw8MdqEuI16bDGqrLJKWmzL8QotMRkbFBhxUcalD3S8=;
        b=xAny8cAdpyLGz8FUPbg/Xkc/2JdpFcMT4Iq1fwc4Rd1LKW+B2L1v2PFOastIO88mTA
         Q25moB+M3tju0iEvtxi4ze4UgtOB6ObFFZPkZcWYtUyJxnLrddEIK0uKscct6O8/UpmP
         cSBQKak6iYnMrjUDCUc44BrjHWbtLWDGde41VBzVDKQhXnJjc/nRcwCD2TWhwhmMz/J2
         16ZTDmg/tP4B5WrOLYrLMXJtX8Zf6zO1wbPkogvP5t9HWYFCKVT4s5gIgQXDdE0cU3MN
         bntkFdna4O5rUC+nDCNYbDQ9a6Rje469GEYSdOykbrb/gNra7vDkf4MCq7a/U3bx2nFE
         5NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742847810; x=1743452610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw8MdqEuI16bDGqrLJKWmzL8QotMRkbFBhxUcalD3S8=;
        b=Z6nVEGojMcG+6SEjBHt/dSmKvC8n9axZE/S8ZtM1NPFLiujXF3u3DYynnYw6TT5fw5
         3iTNHfMfy2p0PPP6fmtFOF9TfZENlklW45/LLbzlalZxBmsyJLWVL0vdZFDNUH0QeYEM
         p2HatM4/WMM2AKQwPbrrY/1XByWNfhS/setIAAmV2w+nNFQfwSoptIV2VjLugQvllu6B
         p9i4E/gsLUPZqaJUqGUVYR2z1FFVQ4v/BPfandWHPD/EqhyMYt+ilnDqXFmMclzyYF8V
         1GN12p+Fe8+S2atrQkINGuXaF+dFybDfOSsMUge7AxAJwtU92lKOzrnubGr2mOKdRSra
         R9jQ==
X-Gm-Message-State: AOJu0YztNCCA+Z/Q9g+C77dEcnRjHWV7QyfTB5gRYUQZV+4BhiuwvSR6
	t4MG4vtqTs8YwB5BL9K3gP+o8b6+fXdvEZAgZvedmf8Fvqcen1yGFulwYVb5BerT7u7PuC6AG/G
	toNKclJgTq4WyYGuPWeXnB0ggrx7PSRhbDaZ0
X-Gm-Gg: ASbGncsEHs5cTG6WHhE3LUDRaovCc70o0usIBW4ArwofN643KVcc/sKDWRf8hluLCnK
	L8W4WNDcS9sWr+t6FEZrUj3eYqcY7DhZFi0U7AhQG0D2X5uRaFUqktdErBXQje7ezdBKq4ot5KF
	C/PwQhWLXPQxXKIPJIswDbzKAAFRrr5/s5gkQX4zzYgfbC1PzQCKo8LNEL
X-Google-Smtp-Source: AGHT+IFLZV57rHCQSpiZkuDB2IWC15ckkgVSb8eGoGJ0utu9e+eN/tXjQwdtpGXfCiQi+TJYjIfu/4mIRu5qEpxoc74=
X-Received: by 2002:a17:902:eccc:b0:223:3b76:4e25 with SMTP id
 d9443c01a7336-22799f781fbmr4578925ad.17.1742847809328; Mon, 24 Mar 2025
 13:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309084118.3080950-1-almasrymina@google.com> <87a59txn3v.fsf@toke.dk>
In-Reply-To: <87a59txn3v.fsf@toke.dk>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 24 Mar 2025 13:23:16 -0700
X-Gm-Features: AQ5f1JrIxy1e_i27ZockKLHmrfEKrX2c10NDCEOTcJajcc6hpoW3WD2cL4qKx3I
Message-ID: <CAHS8izM30jZ+bKkpeKQLKk3BGj8nBFLpUFgS2qM7x8EPMV7KOQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v1] page_pool: import Jesper's page_pool benchmark
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 2:15=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > From: Jesper Dangaard Brouer <hawk@kernel.org>
> >
> > We frequently consult with Jesper's out-of-tree page_pool benchmark to
> > evaluate page_pool changes.
> >
> > Consider importing the benchmark into the upstream linux kernel tree so
> > that (a) we're all running the same version, (b) pave the way for share=
d
> > improvements, and (c) maybe one day integrate it with nipa, if possible=
.
> >
> > I imported the bench_page_pool_simple from commit 35b1716d0c30 ("Add
> > page_bench06_walk_all"), from this repository:
> > https://github.com/netoptimizer/prototype-kernel.git
> >
> > I imported the benchmark, largely as-is. I only fixed build or
> > checkpatch issues.
> >
> > Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > RFC discussion points:
> > - Desirable to import it?
>
> I think so, yeah.
>
> > - Can the benchmark be imported as-is for an initial version? Or needs
> >   lots of modifications?
>
> One thing that I was discussing with Jesper the other day is that the
> current version allocates the page_pool itself in softirq context, which
> leads to some "may sleep" warning. I think we should fix that before
> upstreaming.
>

I don't think I saw that warning for whatever reason. Do you by any
chance have a fix that I can squash? Or do you think it is very
critical to fix this before upstreaming? I.e. not follow up with a
fix?


--=20
Thanks,
Mina

