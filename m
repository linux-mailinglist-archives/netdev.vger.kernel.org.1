Return-Path: <netdev+bounces-131750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0576598F6C9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5B228114E
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242BC1AB6D4;
	Thu,  3 Oct 2024 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWpwbukQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A238DD1
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982620; cv=none; b=bazGe7P2DkCT/KzZdgg8jnwuRmEBj+XvQuCvGaMiI/+5LYkYcJeHDfjhfW/+LKglf8JA7GcbaRxwFIj8c73MdIAT0486D9n84ZDQOaxK1Kip+tRvkHTm3nlxl1tHXiy8pa1BDtM5jvDGltL6E86uXyqnxivQlJhPdhSGYoMkPHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982620; c=relaxed/simple;
	bh=h+9r1lyWAAoHA75sblFF5HtpRJTBhoLTD+qKvD/N5EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVw4QBE1txPrLeSDBiYGfyqNeqkv/3bRj2yaix7oSvICqoD+6szPnqmEyJXujusFgEPxxz+pUVHwLfrY6t+hcAm2ulWXzuv606h/6RzDjkM3v/WuzsBFhSIGLlqEu11kSWt/CmEQUJQEC4Ey8H0StvzRxwNbN4tBHNM8XBv7ksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WWpwbukQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45b4e638a9aso53921cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727982616; x=1728587416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+9r1lyWAAoHA75sblFF5HtpRJTBhoLTD+qKvD/N5EU=;
        b=WWpwbukQX+V0zn8SRL7UOi9H2R28qzkS8qs+82DSrt+WuOnDZpI3mx1BY5oM7wDCuo
         3ajeARabi5lfmMCCPkuCljNL6JvyeuYlYiUbl8xbME5sjkqhsU2ruaMK1zJf8gLhLJAj
         jT8LKdAnzOYugMJHYMF2/TcnZP+yVTdv6Zv8j8fGWhsaa3IHSBuc3xy286Z6l8/oaW2y
         srYRYmGHeIWy64i3i8kIrB6V8iURD0b79J5PyfrAcRGT9QfPAa7mjqe9pR/MlHfv24c5
         qbzQ400CKDa5HEU6AOurZRj8BVMFQXGbrlCyxvAI2CJsqDQ1YRfrJXZ/i9CoYs5FIBIa
         aH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727982616; x=1728587416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+9r1lyWAAoHA75sblFF5HtpRJTBhoLTD+qKvD/N5EU=;
        b=Yy9pWtviOoybGqk//Wj+nzacGab6CLiuTwpbOMKK4NkCrDwDc4b0gJs5i19vPJGGpM
         /47XYCKN5iIgGTMDlleKhZ2WgKxmURCdH0gvS5+KnLwaukBp4WsNRY79c967V2v6SBFq
         UCxQLVK7aeoBfTuTm5RLcSVVw4pVpYZO4hGPVc3tU74zc/mnXljfN8d6Rb1lQzeLi4mT
         AZ/6WkRo6IJejaqaBU3aPMJMCznt1rUxW3qP+xUw5/rtpSG2txcEWlU87DI1W8qPP+I/
         tgUMKRxS79Am149NS6vDn9n9AdxY9ObyyAAF5lwfrKRqbKtCTSvgWY637NtJBnvSe/pA
         diJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXkwY9x0Vj7yKa0hyktE3K0flpoB6tVkSJ8KJhFABSDD/CRtvorn4iGWsQMGnWRiaZN9tA2YM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+gRlYEcfgWSy72bHwkNBu619MQO3y2PHX6zykyj9OOEDnrYN
	i0ySpIl/3h566yx/gNAx7A3pNjAWuPCcg5RGMgBIfiRofkSkaQfcuQ82jiXRgWYpWBUrQdU9qd8
	rPv9N5wfRYWIbe2X8EUhQD7GHPQ4ToHpWEOjh
X-Google-Smtp-Source: AGHT+IGdcEomv1z5AKFks4Uk6Kk/s9zZOnK6ekNr8n1MtvSE50ZOzRP+CGHm1K54MN6VmhgvSKfUzGo+eK9BuhoJUUc=
X-Received: by 2002:ac8:64c8:0:b0:45d:840f:7c1d with SMTP id
 d75a77b69052e-45d9bef9fa8mr60901cf.13.1727982616244; Thu, 03 Oct 2024
 12:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-11-sdf@fomichev.me>
 <CAHS8izNwYgweZvD+hQgx_k5wjMDG1W5_rscXq_C8oVMdg546Tw@mail.gmail.com> <Zv7R_dRFZ0VGindy@mini-arch>
In-Reply-To: <Zv7R_dRFZ0VGindy@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 12:10:02 -0700
Message-ID: <CAHS8izM1MGAurmE76nO9vBkura-+kAwJET_Az6UhPsw49a1J7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 10/12] selftests: ncdevmem: Run selftest when
 none of the -s or -c has been provided
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 10/03, Mina Almasry wrote:
> > On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomich=
ev.me> wrote:
> > >
> > > This will be used as a 'probe' mode in the selftest to check whether
> > > the device supports the devmem or not.
> >
> > It's not really 'probing'. Running ncdevmem with -s or -c does the
> > data path tests. Running ncdevmem without does all the control path
> > tests in run_devmem_tests(). It's not just probing driver for support,
> > it's mean to catch bugs. Maybe rename to 'control path tests' or
> > 'config tests' instead of probing.
>
> Re 'probing' vs 'control path tests': I need something I can call
> in the python selftest to tell me whether the nic supports devmem
> or not (to skip the tests on the unsupported nics), so I'm reusing this
> 'control path tests' mode for this. I do agree that there might be an
> issue where the nic supports devmem, but has some bug which causes
> 'control path tests' to fail which leads to skipping the data plane tests=
...
>
> We can try to separate these two in the future. (and I'll keep the word
> 'probing' for now since it's only in the commit message to describe the
> intent)

Ah, got it. Thanks for the explanation.

Complete probing should call the binding API and assert that the
return is EOPNOTSUPP or something like that. Other errors in the
control path tests should be considered failures and not test skips.
But probing is necessary to run this test and this is a good way to do
it for now. We can improve later if necessary. Thanks!

--=20
Thanks,
Mina

