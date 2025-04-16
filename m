Return-Path: <netdev+bounces-183365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0460A90830
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCB919E0C13
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB8B211494;
	Wed, 16 Apr 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ceJY0ajc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418FC1487F6
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819252; cv=none; b=RrKJir+zdKJdbO18ZPs/fZXbulckfTS/FFB+dh0JTjSUAmbhg2YcyWB5adODI3Md+CLmXJRuQ8R9Hnf7Lbb8FZALYr6s5wSOCaIAknZ59i4h/MIhRWOMRLVVfhjQBXKF4PFk4KQshAxIgrRS/eGD3mN0nH1JbIjbOKXjF/fX5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819252; c=relaxed/simple;
	bh=OQ2LUVURG5ZBoCwWh5loGiUwdSTfHuVc1849YbckkqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbT2aLmdmDYzv0ZoLgIj3A2b63uzcb2M21l/DIvi/kzOSonTq4FL9oTdxPMNu6iNTkWSwyWIm+wv4Fhy5IuGgo+aT4dzIhHyMHLBpJFsMpERFYTlo3uh/0hxWCErNqTgqa4uawz4k64BUJj8FWztkLm4VF51rJWnqREziep8Vlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ceJY0ajc; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-549963b5551so8064893e87.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744819248; x=1745424048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBPmcg0bFH2XY3Hin8L4B6RZDr/nTgPQCfRGMZTM/dg=;
        b=ceJY0ajcpp4Etwtg/oRJQk7GiAqywh6FqfWax9RM6aOqARUGEnt1SyS4osZjvEebcO
         S3Uc/Vd7j2Ujy9gXs87Qer/GFW0/C7rdE/cLOsVyRIKcDSxwaeV0Ygqvlf2JrMOd59br
         Q9da2Oq5TZXBUk2wENpmLSlwtySz5sEe5k3SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819248; x=1745424048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBPmcg0bFH2XY3Hin8L4B6RZDr/nTgPQCfRGMZTM/dg=;
        b=VwfRfSr6lW6JbfY9OhnVljZkA9FLiBt3zcjS4oYNu5/D9HNvp2S4m3nvm5a1Nrmlr4
         3xu8likrmfinymUB44C5H2EYXdZnAc2MSg0z77lXgQuLTaq3yKVMyMNBXTItxPVje2sY
         +7lRNDhP7OAVjh5dpopFkf2y6qMPON3GWSZxdEC34G35AMi55xkDsDQtX2vLnXzInk7Z
         cvPP2PilArQ63FdArYRu41nj/B/f4Ty8uObbkpOisomMHwDhD00WdOUbQzCHWWohd2gA
         F8YzAmHVf2Tt5a2Z0uinq/LTYgpLPkeRmrIe2sjjPUi8loFH+VnE1S/Cj8zfWVqYTHOs
         3bEA==
X-Forwarded-Encrypted: i=1; AJvYcCVYT1XgyPfLAmhYerofe3iDrtGLrKhKl3mtg6Abys/H7r0wYr3Yeu+YElhR9bfKqhSX5zRoKog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJUcMXXyA6wXluRwBVLhyBKeURfQmBCfPdh5ksHQKoSTPAEmKb
	jgu0V5IrITwG5oO2HJ4mQVPsF+FSAasUQuM49eD80ncRlbNd61pOXet29xXgDRzIN9ZHDBR58yo
	74PsCGoQt7K0/6Osrlx6+09Ek4wPPjQciWrRC
X-Gm-Gg: ASbGncsBYzIfgjkCGj1Nfusf/ZD9pbkQCsL3UL0JXOnBsyEo7Ia1eXE6ufrdP+ZPM5A
	flTZKUd6tb09rEtaCxS1akD8jupY0pbuNZ0K/3U2E3qXAAk/GH02J7x9BOAdgpu7coRbF2f//kN
	cQzVuqiNcpEO5JRx0fAVE4wOfffDweLqlY
X-Google-Smtp-Source: AGHT+IFlK7R096/+OAh92R+N0wIujqmp0uU3OFtKyNa2K1gFmEshtOax20fuvbKOa8HxCYGz77KZC4LpcqUinUZDXA8=
X-Received: by 2002:a05:6512:1090:b0:549:912a:d051 with SMTP id
 2adb3069b0e04-54d64798c06mr830233e87.0.1744819248030; Wed, 16 Apr 2025
 09:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415071017.3261009-1-dualli@chromium.org> <20250415071017.3261009-2-dualli@chromium.org>
 <69763528-bb00-44c5-a3ce-8c30530b29ee@schaufler-ca.com>
In-Reply-To: <69763528-bb00-44c5-a3ce-8c30530b29ee@schaufler-ca.com>
From: Li Li <dualli@chromium.org>
Date: Wed, 16 Apr 2025 09:00:36 -0700
X-Gm-Features: ATxdqUEvTcc4Mrcasz-DJMu04qcEN1mqV4hfHibSLmGFJSE6dIDY98ewYmt9cyM
Message-ID: <CANBPYPgfW+3jeTPZmpHfkgr=hX8sRkMLgrEeLFYa6rOPftXeFg@mail.gmail.com>
Subject: Re: [PATCH v17 1/3] lsm, selinux: Add setup_report permission to binder
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, 
	omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, tweek@google.com, paul@paul-moore.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, ynaffit@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Casey! I'll resend this specific patch to linux-security-module l=
ist.

Should I include the other 2 binder patches as well as they are using
this new permission?

On Tue, Apr 15, 2025 at 9:13=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 4/15/2025 12:10 AM, Li Li wrote:
> > From: Thi=C3=A9baud Weksteen <tweek@google.com>
> >
> > Introduce a new permission "setup_report" to the "binder" class.
> > This persmission controls the ability to set up the binder generic
> > netlink driver to report certain binder transactions.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Signed-off-by: Li Li <dualli@google.com>
> > ---
> >  include/linux/lsm_hook_defs.h       |  1 +
> >  include/linux/security.h            |  6 ++++++
> >  security/security.c                 | 13 +++++++++++++
>
> This patch needs to be sent to the linux-security-module list.
>

