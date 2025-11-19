Return-Path: <netdev+bounces-240201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0180AC7166D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F39C346308
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 22:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2579C3002A8;
	Wed, 19 Nov 2025 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at85dKXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F920B80D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593128; cv=none; b=MAVUqTE9OikthlPeZvwTsenU+chw2ybczUkn7HFby52Xc9eHAMCRwvyDiChT+1+mByU4vl3j+4urq5wNdJ0A+AijyofpIhnHGsh1ycnzP1Cgd69GR4vFagbIDEjIqyrWrWYJiF7o5GEp7gRV+4o7sOFfaPZbN19AuLi0Q8DlZ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593128; c=relaxed/simple;
	bh=f2l5MkKNSF6v8HTpthCW9c0REcYxtwaiNPwhFd/gKsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIAjp9fUVa5FzQUIldzmVN04G83ND7pftasJlOl0ShVd8wihQ2LL7co/O/BF0aA+855Ls3jvhR4Zz/C0XPq5gEzXjtkRIPeSiz5uLsvxXFgqKtOEkoTO9A8YDr+qIiuU5miSp0fhn0kief+6QHj6IYp6JLVfsPL9EYZ3GJP8xXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at85dKXL; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63fb5a43d0aso36502d50.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763593125; x=1764197925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2l5MkKNSF6v8HTpthCW9c0REcYxtwaiNPwhFd/gKsY=;
        b=at85dKXLFmwm0KYJmh7+JqEt1Y9DRGf2x2iFegbBk7ak4T3eQ6QWZeGkMurNjkGlpM
         jLw7XfjyjClDMv74r9dTYztEeSBnDkKj9Qgd29Zl7hatVH0/yyjrReKBbW6JoS2rUZdQ
         PIUAEMgxTdxEMT1lO0R2fBtFNnS1bDvx5iso6zZYpGjf+cs4uj5K5yrF4xWqOLWVOJLs
         7WO1HEcsxQH3shGT3b7/WtiE65K9NNl8C6Rbsyq7h8UK0Jv+pRVnplBIJS0qwP8/b7ok
         9fyeOlMfbCFvk0vADUqSzm+y8w3OvuN6cCTLfEn/5EVGlrFcOeH02yuv+HSJbsiV9bKD
         Kpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763593125; x=1764197925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f2l5MkKNSF6v8HTpthCW9c0REcYxtwaiNPwhFd/gKsY=;
        b=TWYI7RdrIBTZzongc8OKSLYm1i4i522QuWgQcucSc/tyZ29KM0utAhe97sautC3f+E
         aQ5zJz4d8aXd5nRPOFBbzHuYIfbURYRM0597RLstmkH5uba6vzHZdgOLtHIof0f/q0WA
         zCsnIiKaPpVcojGk5RQFp7KSfbokv+51isP38tQOymkHRvk/46eQdBkO/PYbzxXo0pts
         nC2Wn7GhlNT1+9AiLCR9YjnqNeMgiQfhPzFySyHPY2SeVVcvTUhZnsSiw0+V0TQd0k4i
         5478AbB8gwrP2vBb+mFZlh+OIwubQkbMHHyjAIZ4Cjf7SGD48T4yadZsJ8jDweoQilAg
         pVjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1MtYLzV9w5nUICyq/3NiYHlP/qN99sBARObUHZMc4oHJ3jOVpTndoCH13ZC7LRJTDsB+q3Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+2gBlMbUkzhCq4asUqtxDyfGsATmZzEJXzHDr1gIOZ7/epdH
	2A/LfzglVZKazwBZ81fHhp7KCnBxRGndrTlVZp+hFOANOJlsPoU/1tU2Q4zcDANuCnh7BlU3N5u
	7HFBOMX2XRYmmfvjJfsTQFNRs9AEz4yc=
X-Gm-Gg: ASbGnct81Zg6II1sJU7VQJH0dkee/Q58bAG7BEGAPAJcB3rxa36e9NUF6FYYACK6cZs
	w3ErdpLCMDcgls9/IaV5IBbSJsuJPgT8mHLm5nna3aPJzuXanpP8z3gnfhQYpAZj9icQcWyZi8l
	1N3gvJc4tf0qc0v31yLtuyvoSmPRDQAuAewLDEBoVouqhohJSFQ5iNaim8glNcHDtl2lkRZmsbD
	1lFPP1pEuNw24H5PskTk/ztOGEmals4LyeruuihuHOITAvblgOt4Pqv9ZnXFM5wEj1Nnqq2/120
	x7CT7AgehTtOOrxkTT3xRrKZQfh91KA=
X-Google-Smtp-Source: AGHT+IFIbdlD0slMDf0ec9/PDny5wf8Cs5EBojHNy7+PN47moxCbujYhgeKqvmUnVr7j4rMEgn4Rfe7CinYPHNqGi6g=
X-Received: by 2002:a05:690c:d:b0:787:deea:1b85 with SMTP id
 00721157ae682-78a796139f6mr7902247b3.7.1763593125345; Wed, 19 Nov 2025
 14:58:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
 <20251113-netconsole_dynamic_extradata-v2-4-18cf7fed1026@meta.com> <v4xuuka7oovpcmcw4ualj5mdhw6jlgtcdheybbwtuy7qhd6nyd@3kav6dwkkdac>
In-Reply-To: <v4xuuka7oovpcmcw4ualj5mdhw6jlgtcdheybbwtuy7qhd6nyd@3kav6dwkkdac>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 19 Nov 2025 22:58:34 +0000
X-Gm-Features: AWmQ_bkblqT4UnsE6iXRexrupNu4V6Dl9BSuZjWsv7DfjnR_A5WtYtp478fk8Kc
Message-ID: <CAGSyskU2awfHd4JCFysCJ=Gf8z2tj_oZRZ4TD3_=K2KRuM=U1g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/4] netconsole: Increase MAX_USERDATA_ITEMS
To: Breno Leitao <leitao@debian.org>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:07=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Thu, Nov 13, 2025 at 08:42:21AM -0800, Gustavo Luiz Duarte wrote:
> > Increase MAX_USERDATA_ITEMS from 16 to 256 entries now that the userdat=
a
> > buffer is allocated dynamically.
> >
> > The previous limit of 16 was necessary because the buffer was staticall=
y
> > allocated for all targets. With dynamic allocation, we can support more
> > entries without wasting memory on targets that don't use userdata.
> >
> > This allows users to attach more metadata to their netconsole messages,
> > which is useful for complex debugging and logging scenarios.
> >
> > Also update the testcase accordingly.
> >
> > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
>
> Reviewed-by: Breno Leitao <leitao@debian.org>
>
> Please expand netcons_fragmented_msg.sh selftest to have ~100 userdata,
> so, we can exercise this code in NIPA.

I had a quick look and netcons_fragmented_msg.sh needs some
refactoring to be more reliable before I can do this. I will send this
as a separate patch set.

