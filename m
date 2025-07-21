Return-Path: <netdev+bounces-208628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84951B0C706
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A461887C08
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ABA2874E5;
	Mon, 21 Jul 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Dg9KglOZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E718F6C
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109702; cv=none; b=QVDm1ZtIJ6wQ7hcj3ASSchEUgVFa38ULJwLRlkG3nxHb6jz77vm/s17oTOE+HFCII0uAS7At4tRH0MsHENMTdPTZP+7mrEbB4IGmKt2wVHh77c+ZCremxLsrd2DfhaaDeh9YL1nsGp0mnHL1j7RMPUn7dFFWUrP649/Bj/QM620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109702; c=relaxed/simple;
	bh=B5/SeSeHzxWetKPd+pOdRh7jpeM3SVOOiV/6Res8kr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSL7EVY9/b8TguR2/vLHSqlXwLHCHBDFd/XqeuKmQ2eM5LGGTsl9lC57MjHWvB416TN4VBk8wEO23Yo0AdPCr1QKoUzS0gR+6y/oxTF5GANer05NFq9sjeiI6J52BnpUjQGSqMntvmFSZyRqQGIPFkj3Dz2HIEgrTjsR35Rq1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Dg9KglOZ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e334de8df9so497062785a.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753109699; x=1753714499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5/SeSeHzxWetKPd+pOdRh7jpeM3SVOOiV/6Res8kr0=;
        b=Dg9KglOZPfUTf1flskOCnl4kMjadjJjQSMLrYkddT/t4xMVgp6hajhss+ZhMUkR5F1
         yU5JDK/2B2LTq60zMR9SnWRf1wpVWQ1MXttuPrlGvUGDFNdZ7JNHeIwOfAUEM4UCqNjy
         dXO+aVgMuJlyEnz1eCrR9yrbzdoMgGZ0sDG8OqsHEI4wQEoGFJcOX/pQuIsuCqWH1qL/
         cmLKwpQ2LTPK4+ADV2A6CZy48iCdqT6p4mFy84XYZWtIEc6iBvd3RaoJz5tkusFGb9Dp
         Tuy+0MGks2m21xpCx55ZDGGnaApuVHH/2cvU5a9yVajRwqvLp8vxN2RS7OyOgfpb576i
         Z4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109699; x=1753714499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5/SeSeHzxWetKPd+pOdRh7jpeM3SVOOiV/6Res8kr0=;
        b=NepmAGGP/YlGuRxYiww19mu1nQOZI6Uzm8Yv4+r9mnDruFXuWG3O0jU7Mq2SgqY6aK
         jp9k2qfsrraiI1KC5ZJfijYfLQNPMgZH1beKTIGMTOz1SdgEYr+vNMpFeIaWUgf8q9UD
         HtM5mhM9hBf5uvEg5K92Sa3yxzfNiP14gnKnwfQm4B4JFlUkLp8yeyjBwsyB5m6EWL/4
         PD5u3bbKAkJvRHJtp55RvfiG2k/JKSrb0HhyNoxvJa+nlcbNxbB70Qryk4b1EOeatWMr
         6gjpkwBviYS1y3fE8d6wYbkzhph7+60swbCYZVmtye7JVs9+f8EcHs/qoo5MOTnpi7AW
         ksCg==
X-Forwarded-Encrypted: i=1; AJvYcCXp8uey2Iv5MTSgnns74D6lFrCmKSyXNCtYDHB/IHeZfRxcruW1XcgvixlhZbu0NuN+QlmRKyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQWwlNUNoRojkX7lwdYYFbq4j+x0lWP/Bspft2qyeV1rYjIGKh
	pgi4WWv8auzYL+hCJRb4z5RU29C2ujfeU/3lry8ZNvSLxEXtc9yy9MJV43JOhPwEprFecgJKzwo
	N0j1e
X-Gm-Gg: ASbGncu9/DZBn58mVCNS2DAu2gTbX3cpT7hEIysAr1ydVLMaDqu10rZYnVoKarLjKJz
	go7Y+NP41ZGOlkfYyjWJq8eFw2f5Gh1debOgaZ9wLtg8zSI//ZcdSI4BkGa/O3DQe/O1fR56PDs
	/LbmDNt/cwd7jKLegK+neO1Du7j1Vx5LR2lKanm0eBAzc3Il3eGT7sy5ddp8OzHMZAk8I4bLBK0
	zG9CKaAWZ3uuFn9WYtKjGRXnZpECjo6Qrv9FTuqNr6YYTqzWjjgusZGpe1OmAx1ytS91uNg+WLp
	+2Uc2i3tlJX9mpsjxG4P0QnqILyBMA0UhmvNAZ3ArFKA5vAtwmrFshoRx/M7SJqbzdCyeC/FSAj
	qQVJZ/PrlxkEFAeNZdkULrQ66QqY9HmuhnNJJL1hwHayz51otip92iKCry3tNHWN1nrYzyk2lAL
	U=
X-Google-Smtp-Source: AGHT+IHH9FgDdZLV44C3cyMSMZJIbe8ZPLPzKhjrS/XfNBoMPd2ohwieV09F54hs0VcpFll6BjiQ8A==
X-Received: by 2002:a05:620a:618c:b0:7e3:3935:ec0c with SMTP id af79cd13be357-7e34356544bmr3015947885a.19.1753109699394;
        Mon, 21 Jul 2025 07:54:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c3f872sm421999585a.53.2025.07.21.07.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:54:59 -0700 (PDT)
Date: Mon, 21 Jul 2025 07:54:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 will@willsroot.io
Subject: Re: [Patch v4 net 0/6] netem: Fix skb duplication logic and prevent
 infinite loops
Message-ID: <20250721075456.6cf6bf7c@hermes.local>
In-Reply-To: <CAM0EoMmTZon=nFmLsDPKhDEzHruw701iV9=mq92At9oKo0LGpA@mail.gmail.com>
References: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
	<CAM0EoMmTZon=nFmLsDPKhDEzHruw701iV9=mq92At9oKo0LGpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Jul 2025 10:00:30 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> On Sat, Jul 19, 2025 at 6:04=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.c=
om> wrote:
> >
> > This patchset fixes the infinite loops due to duplication in netem, the
> > real root cause of this problem is enqueuing to the root qdisc, which is
> > now changed to enqueuing to the same qdisc. This is more reasonable,
> > more predictable from users' perspective, less error-proone and more el=
egant.
> >
> > Please see more details in patch 1/6 which contains two pages of detail=
ed
> > explanation including why it is safe and better.
> >
> > This replaces the patches from William, with much less code and without
> > any workaround. More importantly, this does not break any use case.
> > =20
>=20
> Cong, you are changing user expected behavior.
> So instead of sending to the root qdisc, you are looping on the same
> qdisc. I dont recall what the history is for the decision to go back
> to the root qdisc - but one reason that sounds sensible is we want to
> iterate through the tree hierarchy again. Stephen may remember.
> The fact that the qfq issue is hit indicates the change has
> consequences - and given the check a few lines above, more than likely
> you are affecting the qlen by what you did.
>=20
> cheers,
> jamal

I don't remember why the original version re-queued to the root.
But probably related to trying to keep proper semantics and accounting
especially when doing rate limits.

