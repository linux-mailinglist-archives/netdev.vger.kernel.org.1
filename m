Return-Path: <netdev+bounces-192261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4116FABF269
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E47FC7ACFB4
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481BB262807;
	Wed, 21 May 2025 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="tnNcaERp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F53A261568
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825686; cv=none; b=Gpfy5pPRPf2qkzWr+aTXnVSTFKpawO8jWJOmnf54vDZVQrdbqGTMGeueb1/W4uDNY02pBqVx0jnaHIIExrJ8KM8ru6ZY8ZuMK50ULWdP3e7f7x7Bg7N+sNTozoAVtVFnpvPZHX33pwwD8PHPO1Pj35qhVKW7e750WbPf0tqQg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825686; c=relaxed/simple;
	bh=XVbRaDerIyD1GwaZ95UFLunumBvPrxXai8ccr9OzpEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7++dP1ok6wv1HZg5DdIKTa5flThZIVy3DvDBw+3hxexXdh9cDvaVES4xm0KzdaOcNMsf3WSCk5ZA9L4NRKc6mk71l+9rAUPHt2OXlYwDCOB366U0gdB9RwogBuxBuu3S9E6OMfxWcT6leCH3PqVAE2nY/04lG3A8RdJz1BvWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=tnNcaERp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399838db7fso6253595b3a.0
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 04:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1747825683; x=1748430483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IxjjkrWjp8AFqhIJZ3L4A7cTzC/C6p7siKh70KP82k=;
        b=tnNcaERpE35jQO7mJSxuiKJazEvYldRB2uKEbt/Cjw3Mho+cC5HApqyWGS7kPgYUp0
         mGLnYlM0of9j1qbNH6+xLNqCCadVqIPadc2+19mrOKO5PBFiBO9Yn/D+m+ucKvk2oClf
         7NJG5y532VDVtn281hKXooJnHjEFGv4F3wbIms1zQ3s2eWDYHa6K3s5wrzc0734uyEr3
         bfmnHTzPYaIMNCznpbb5cWZF/HkjtJFtH2aRezWTi8QZUHaWdiNhBkEBDjE2iUyvhY4s
         sVI05BVZMGFn1VRCyLRmpHMXFBycK304YgIPg+GcEzDrJze97tJvoqd5+Z4gnpfcjPsw
         xZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747825683; x=1748430483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IxjjkrWjp8AFqhIJZ3L4A7cTzC/C6p7siKh70KP82k=;
        b=PPYlzaZdMAlo28ZrroNTm6lCSX+PYrTMEjSzgoYIKm6CgwhtUOSeyC8DawSntEoP4U
         HKKEdwtkDZ5wp1TmImgL5eSy0bXojvR0+CsEhZs6gIHSoDF3DweVIObsM1xRfa0hASBq
         WNyAKQsPDAtTvmp/sWhcP8NBzkkKrPvXtrtywfjTzyhKcfkmI47hPWCWJmyrT1raGooq
         Sa0QBT5ylb3BuzM2IyKO7JJYqOQVdp8E21c+GnKmsMZMVNBnIgSpnQc7k9+CuD1TooBv
         QcQ9dsJCm6zVLOJ1LJEnf2uBm51NxVNQpYtbdfQliaZxiGhuC/YSIc/8lWZ+x3qRaT91
         0r5Q==
X-Gm-Message-State: AOJu0YzZL2R4X/HJpYdbIbLHvxXFaMmxMxsq67+1aSHszFp9mWgJNpxu
	yjkbLGRwhQmKU/zY75+myOdnvXO5vX/bMS15yYO5b3/dZx6lsMf1hMcM0HuBiVsvTY+eAy6NcTl
	v40z6ltTp6Jk+Ey/q9bHSbvSZKCoWFX1bQtP0Ryxo
X-Gm-Gg: ASbGncvpqHmJSAGrnXahU2OaiZm0xyqG45M9gWkzi742D7dFQ6DuUHsJnRWyck96qeR
	mtZ3cyi1QTqu14QBNAB4EVTWRFpzU1IiXwu0FkES5twOJdhuoKU45P/L6e9/cp+iyQtYxXmYZ0r
	qJ/U7+gteeRk88PV+DUFovulJnS7lZkAEt7WhcbVMxzw==
X-Google-Smtp-Source: AGHT+IFUhRaHw+dzQT6VcPQ8JYrBD6KYGetXdoO4wRl2KsdoXqrvYAd7Paog3wRB8xQl51nbWZc9d2Nrn8WHaJdCqkc=
X-Received: by 2002:a05:6a00:3d01:b0:740:58d3:71a8 with SMTP id
 d2e1a72fcca58-742a99fabb8mr25224197b3a.1.1747825683453; Wed, 21 May 2025
 04:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518222038.58538-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250518222038.58538-1-xiyou.wangcong@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 21 May 2025 07:07:52 -0400
X-Gm-Features: AX0GCFsEUpS1i6naLW-NtoOHkz0WGIwifnKNk9e5bxAdW9bMjwOws0JqS__5UHY
Message-ID: <CAM0EoM=0xo9FCr6UAowqCom5whmKwWvvagNCUn_4uAaN+Cy6eg@mail.gmail.com>
Subject: Re: [Patch net 0/2] net_sched: Fix HFSC qlen/backlog accounting bug
 and add selftest
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 6:21=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> This series addresses a long-standing bug in the HFSC qdisc where queue l=
ength
> and backlog accounting could become inconsistent if a packet is dropped d=
uring
> a peek-induced dequeue operation, and adds a corresponding selftest to tc=
-testing.
>

For the series:
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
> Cong Wang (2):
>   sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
>   selftests/tc-testing: Add an HFSC qlen accounting test
>
>  net/sched/sch_hfsc.c                          |  6 ++---
>  .../tc-testing/tc-tests/infra/qdiscs.json     | 27 +++++++++++++++++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
>
> --
> 2.34.1
>

