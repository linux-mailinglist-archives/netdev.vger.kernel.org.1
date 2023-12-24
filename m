Return-Path: <netdev+bounces-60145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903CB81DC53
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 21:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50BC1C21118
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABBCDDDD;
	Sun, 24 Dec 2023 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCoTCa/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26126DDB6
	for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7813df02a07so140756285a.3
        for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 12:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703449592; x=1704054392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX/wa2f4vk3KNMPxnbz3QmCJZSJ/BFuWsbQ3Mi1QNbY=;
        b=gCoTCa/ukBEmlMf7e/xiEuNEKq+mAsXKiU19y18xmTrnir126nmmRvfsruKnuZ650d
         f4jM2HrlG6tXKxMZdA0nE5dZJvUM/mHJzmYtHaT0QY2E52+HjmQXXzSb6sdCciR8rBW9
         JXaZZx+IAZBm0HQ+N6ZhGI36iYu2eMZPiK34qTmBUr5fy9G9nSlUU+PYOQ9YCQNiTapY
         n8/cjoyIW1qQR2Cm3DB6N2HLx1QWAjCsWbs6vZGRsYem7j+vjDbXEu7ow+OhDe7n4mWn
         HyLVa67PP2wzAQxgldF+Kz7GZGwYGrX+P0lC0i4sfBLPVFP6mxWycstARYhtt5pbAFgF
         nj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703449592; x=1704054392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX/wa2f4vk3KNMPxnbz3QmCJZSJ/BFuWsbQ3Mi1QNbY=;
        b=nntCBR/FISVHY9mOXUEKmfjiRpDc9xEcwaE7FrxE62RLLA7/JejAzqjhGuh039SWle
         gpcNHKw/6L1KaLTm0JNWoprSaw7ajzW5VSwut2tnISac4n7e59LekZ5kN4KnzMylDOf4
         IUWfXDMrRjq9bc5ji5nyQkYrbTreBmusp+nOVFeXsY4JRylrv8YCs2DBgX/JvmlZ1L2t
         X+sEvuLWBdlISTNuW1B8+2gwfetLZBsbXu5DowA/Gur8T12lW+Q8s8aq23EnaV95B1oi
         +h9FsZYhtriqsvPCDgbZcfCkJVsm1rywbK/4lUXH4CWAxwRBMfp+PHVBEG0aJC7Ru4e+
         NgpA==
X-Gm-Message-State: AOJu0Yy1JqC5X0OBpIp/OJ9G3uPKomymBPT4jdpHQJ5+dsyEebOGxzKa
	3mAhDw5pcrGJIo30t8SZKLX7eUVgW1qr93y6L/o=
X-Google-Smtp-Source: AGHT+IHdcJH9eaiBMJLeB27vGKhx7LutKoCN5faobURtrC0nmBPh608JGxllLTlLJmd6IAbyFA2j5BO48/+U/f8ZR9s=
X-Received: by 2002:ac8:7fc6:0:b0:425:4043:5f18 with SMTP id
 b6-20020ac87fc6000000b0042540435f18mr7982695qtk.86.1703449591930; Sun, 24 Dec
 2023 12:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222173758.13097-1-stephen@networkplumber.org>
In-Reply-To: <20231222173758.13097-1-stephen@networkplumber.org>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Sun, 24 Dec 2023 12:26:20 -0800
Message-ID: <CAHsH6Gu+jF-HhCzRni9N33sq8iesEuqQK_n9LYpeLYpd1yusoA@mail.gmail.com>
Subject: Re: [RFC iproute2-next] remove support for iptables action
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 22, 2023 at 9:38=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This is a trial ballon to see how wide the impact would be.
> Also, removes the actions-general doc because it is very out of date
> and has lots of grammar issues.
>
> Do we want to go this far and kill all of tc-xt?
>
> ---
>  configure                            | 181 ----------
>  doc/actions/actions-general          | 256 --------------
>  include/ip6tables.h                  |  21 --
>  include/iptables.h                   |  26 --
>  include/iptables/internal.h          |  14 -
>  include/libiptc/ipt_kernel_headers.h |  16 -
>  include/libiptc/libip6tc.h           | 162 ---------
>  include/libiptc/libiptc.h            | 173 ---------
>  include/libiptc/libxtc.h             |  34 --
>  include/libiptc/xtcshared.h          |  21 --
>  man/man8/tc-xt.8                     |  42 ---
>  tc/Makefile                          |  24 --
>  tc/em_ipset.c                        | 260 --------------
>  tc/em_ipt.c                          | 207 -----------

FWIW we use em_ipt.

Eyal.

