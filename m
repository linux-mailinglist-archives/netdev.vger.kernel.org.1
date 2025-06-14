Return-Path: <netdev+bounces-197711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2353AD99ED
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 05:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4C93BB4F3
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A01B87D9;
	Sat, 14 Jun 2025 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9YfK+Jl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7026F2F2
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749871424; cv=none; b=NAtnmHN9HfGsXJHj6KubHFcc+xZ577lPVHlSYRy4qp25dFJS+Z5x6+ONtbnkmF1zcxTF5oIfRqUTOvy0jZOmuLpetCtItf38eCVk0bRWf+PMoqN1jGwiLisHkGmi1SxxYpWL+ofhIcub2s8NLV0oruOAwbPmt0AYIMcFj8j4VFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749871424; c=relaxed/simple;
	bh=ks+qgcinxfP2t0Ff5arUdhpbKGhmd/HNmuw7bvh83zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMrjHbBt7s8Q5QUH1RycKpT9xwYe8nchT8ltVYXfjPQmBIf29CbkAZc6AVIQZbvCV3LElPWyuw3tf05u0qYQNpL6qPwCqcolnHMomm+KhzxbJfqdueQK+e+Jib+dYaLQyitq5V6J/UQ1JtBvtfSEV5GBiPJt/VaSMqm+rWRGo0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9YfK+Jl; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ddc7905075so05ab.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 20:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749871421; x=1750476221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMC1RgubSI8jxz91HSzJ6Iomy1CrrH+KUaf8/z5C7uM=;
        b=M9YfK+JluehVwcqaR7x5IvlFJiuEsbFNnux4limO89c4+tdeohTFk14wbPMMlS110w
         J3xhKPwFlpaIc0ppy1jgLv+hJK1lP9sgh6z0Cgfju7Wsrn41/MeyzERwLoWB1HhRwCCl
         g/KJnc7yr+Rq8HXDZ2EAYcuZBV5OcRGkMhqo4UBF5sw6APyiBmCMETFC0vGpWNgco0Wf
         B4814TIi8sAvf57Bl0cAx41wtsfokeh1lD7IvrxW0R9Hx85v+b26gw414I2REXLYEuon
         QNSs65LWghJEl8IeyaYyiDKoclGQJQ0jogPHDKAJz+vjv/Sz5WpaFKvvMC0WPGolFWpH
         Am+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749871421; x=1750476221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMC1RgubSI8jxz91HSzJ6Iomy1CrrH+KUaf8/z5C7uM=;
        b=d6Y/f62bSwODQ6Cbapdz4ZjZC+m7RVtfVOJvRHdg1C1i3sgUATdVOSHN3e0zGQznhW
         5uSwA0DFO+ibRm2HDI21o+MBI8xGTYM0UU8XgJrf1Gdp27em8HoFTcHKfnIZtX8Sb3LQ
         4SQp3cPCEmMyW3Km4doK9L32P6yTCIHhvU43zEXiXkpfHo8+ekpeTJ3TDJu0im2G4rQz
         +geTl9Un+48Ijd6l22LlwxQffqRXuYrQ7g63/gBB0GehTxSRCJSuOxl5goM9ZvpIJ7KY
         ncYFxKWVWsl5tQPw/iwq8JRYUtqNgP35jh3l+dEepttdOQg8oJKjqo5LqBVu+a8rBlWJ
         vP+g==
X-Forwarded-Encrypted: i=1; AJvYcCW/s9euw3/jLUCgINB08NpCRQnypoSxyd7B/IlTXj8WWp1lzVs10HznU4KokqxlZREYAO+c3PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxgQHM06HbvEbOe63Ml/UvpNUJi6cxJNK1iWwQoYGXBe7t2/9
	7nx+ZPxEDlynp5kWhMoVfCKcEqOXnJ9bxoa/8Jxvslr3CZNATjpaus127IiD+vOpuEe9tkLkNjq
	Y6UChMQdCOfMpMWdqZsU+CcpIN6yS4ZvJhrT2igeL
X-Gm-Gg: ASbGnctewBMcx2+dK9v8euqiq9zCRl++XuJYuMGlkw33CoQU0T2ntlYhvY7fSDAgrlL
	A3s0lMN5ZqAomPJFDRBk+hQ4NI6qqrnbsfhq8TvlidGMtvZzahSqMbZzzXiP72LbV96JGUHf/hA
	6IVYwYwGCk5YfdOusr4mllB0y1MvU21PQaVaShsypWT0HrRb0kB2f1gLHmyohzMuOs+AbQDLLgE
	H4D
X-Google-Smtp-Source: AGHT+IGlo6uYJF3Gn+pJN5jxgxVqy47hoLKB0YLDiznhdZSCh4GpZSc2oGthgnIZd8sYwsSUIl4f1nc2rSzZ3zzdsK4=
X-Received: by 2002:a05:6e02:2506:b0:3d9:3ee7:a75b with SMTP id
 e9e14a558f8ab-3de0817db53mr1219875ab.1.1749871420405; Fri, 13 Jun 2025
 20:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612020514.2542424-1-yuyanghuang@google.com> <20250613172941.6c454992@kernel.org>
In-Reply-To: <20250613172941.6c454992@kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Sat, 14 Jun 2025 12:23:03 +0900
X-Gm-Features: Ac12FXxi5jeP--oHy4Yft2q1FN2un7YHLfDbIUoTs8jLrWX9Uvhk2nC5jLxyXBc
Message-ID: <CADXeF1HJ7dyw5gp7sKZvRgf_WLuEJatqfKmfxzpWtLibB=e9rg@mail.gmail.com>
Subject: Re: [PATCH net-next, v3] selftest: Add selftest for multicast address notifications
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the suggestion.

>Perhaps move these to lib.sh as a separate commit?
>They seem generic.

I am looking at the existing test cases, and it seems that each case
is doing its own way of handling the end_test()/run_cmd(). It's
non-trivial to unify everything into lib.sh, and it seems to be a huge
refactor if we want to do it this way. I can also imagine each test
case might want to customize the behavior a little bit differently.

On the other hand, it seems some of the helper functions I copied over
can be simplified. I will refactor the code a little bit to reduce the
duplication.

Thanks,
Yuyang


On Sat, Jun 14, 2025 at 9:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Jun 2025 11:05:14 +0900 Yuyang Huang wrote:
> > +VERBOSE=3D0
> > +PAUSE=3Dno
> > +PAUSE_ON_FAIL=3Dno
> > +
> > +source lib.sh
> > +
> > +# set global exit status, but never reset nonzero one.
> > +check_err()
> > +{
> > +     if [ $ret -eq 0 ]; then
> > +             ret=3D$1
> > +     fi
> > +     [ -n "$2" ] && echo "$2"
> > +}
> > +
> > +run_cmd_common()
> > +{
> > +     local cmd=3D"$*"
> > +     local out
> > +     if [ "$VERBOSE" =3D "1" ]; then
> > +             echo "COMMAND: ${cmd}"
> > +     fi
> > +     out=3D$($cmd 2>&1)
> > +     rc=3D$?
> > +     if [ "$VERBOSE" =3D "1" -a -n "$out" ]; then
> > +             echo "    $out"
> > +     fi
> > +     return $rc
> > +}
> > +
> > +run_cmd() {
> > +     run_cmd_common "$@"
> > +     rc=3D$?
> > +     check_err $rc
> > +     return $rc
> > +}
> > +
> > +end_test()
> > +{
> > +     echo "$*"
> > +     [ "${VERBOSE}" =3D "1" ] && echo
> > +
> > +     if [[ $ret -ne 0 ]] && [[ "${PAUSE_ON_FAIL}" =3D "yes" ]]; then
> > +             echo "Hit enter to continue"
> > +             read a
> > +     fi;
> > +
> > +     if [ "${PAUSE}" =3D "yes" ]; then
> > +             echo "Hit enter to continue"
> > +             read a
> > +     fi
> > +
> > +}
>
> Perhaps move these to lib.sh as a separate commit?
> They seem generic.
>
> Please fix the shellcheck warnings. The "info"-level messages
> are up you, SC2317 can be ignored.
> --
> pw-bot: cr

