Return-Path: <netdev+bounces-199279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED7DADF9EE
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC11188D383
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B140284B3B;
	Wed, 18 Jun 2025 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="epLsLDBb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8741F09BF
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750290941; cv=none; b=HiWUSy0vtIW7XE7nzbu24AADDl7TNw2pC52Tdg8ZwqVz97U3rr+fAZYylu8+LJ6lCTZqxRIy/6w7fLYiINYR+U5v44Ei9PPrirNrrJOGXPMh3jQj2KBeMPoxe1Kl6USrt6gTlNLhhX2TzZROrCQDtq13ff37hmZQJX9PeFi36pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750290941; c=relaxed/simple;
	bh=jXiE9rzeNs/RRjF+fEh/djBAzoD6GL5vfoqjbMTJVtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aatw7Qx59G3LYMuZCZhgxbRlvrxcEu2TbZUPrIi00yhVdSEoxqwo0wDTQ8Idl8Z8EjwpWhAmACjFTk8IuX7sNdwKxqC/q9c+uSn+9DcqsE96eeTChqcOwsbTtVXlBFWoYVz5T9ez2dBFAS81rPWzUtnQn7KxwEQMoMwNnw9eV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=epLsLDBb; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3de247e4895so05ab.1
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 16:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750290939; x=1750895739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhvnUJBdUC24eZOisoPiZwhVd/LIwB2bYvJ6RT4qk7Y=;
        b=epLsLDBbkmHP5kptTc0JsZlOWw5LmHVUQmlaOnYKZgkwi8aq9NDDJaYJBPxB4bUhp0
         SIdzS1haD9EBI8ud71RIm1LIx4NgaT+yM3COPyw+mpvzZp2VZF+dXEhTmiTcbbjlFl6K
         NjLajHkgthw2JUgCPzsO5LDKcDHXH+IuhOKzCdv0iz+u6U4QsP/XmILQcc56g25qesah
         esSfc+lG8Licz36wDKwkxhMbOsh/o3waZ+vQGGyokI1ii9TqFDWcabIwbXAG+JT02MHT
         a5FKqdKLZacGuYGWl6tA+Wdql/PRxTBJKghz7P55Vs/Zji5F1OdqlxpJuWXA43fnolPf
         MkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750290939; x=1750895739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhvnUJBdUC24eZOisoPiZwhVd/LIwB2bYvJ6RT4qk7Y=;
        b=ingFKeMsDYYbyjpn5/3XUFsMvY5CTYCFLLLZgNzf01wfANVnmwrcU+Usl+gFyWQNBb
         Tk05jMaZx2rMkjJe3Ux57WyJNfWZWP60JcJ9I4n0koDezaIthXaE3PaiD1RjNXd5J6Ud
         eYmCHQ0AmvNDRJ2+ggid9GUQfcI39CNddMfvqe7OX7zPPGdCRjjcQKJRvYul4QISaaM1
         PMklJJMHZbDJDgo+tfgmiEA6NQDzv+0WYU3UYXBGRM6VLN7/Mzqz8rSFlc8lWdGQ/2CZ
         PlMD6Iq/hA4vANP9kS2y8Tt00YUd9jPk5Em9oOKm2AMY4u34OycpYNBC26THuOGmDycq
         W4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU8wckyRWluXMliQG752l+8lZmLdK3R6CPaBVvK1Q9kYFlDpoRwS1JbCJ5zsQQdh9CE4jxatzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Xqwf4xnpt1CEl6rNUPCdDUgUX/InX6So3CudPOgBZgJu9pQu
	mr7AqcD+tPmi4DNnVuq0rgohwPTHT9pMh9VRJG3oFTRevLVsc4TJ4lZ1enMihA0D4yIFvm192C4
	fkGBw6nPSCHlCHqhjLq2fUD1dXXYjFI5W7sZapOgv
X-Gm-Gg: ASbGncs+tSi/mZoLfA/behrYiKsTnkuJpq8MyC3nK4piXTUs9hee4mEQ296pReohzid
	6BYmRdzAnlneP3RMFW2PPV+P1mSBFDmzZy49fa4HQ3J/uQpc5BAxz1HqFpizEnm9Vhpp3CliqGt
	Z6N9W7AyRjEzLuZcmiaWG7Wz7iW9zEJSVJbNf3SgCzTZVFbHhoBR8ZWiN52SWDV7Yrm2DLC3DTx
	kKx
X-Google-Smtp-Source: AGHT+IEAj3oIerZ8VMhDsBvB9jTtKhynwQ/opLvvI7poEt160ct1eaw1qJ+tjnjOnXuXTGGXuUfKXdzM8SueivuxuaI=
X-Received: by 2002:a05:6e02:4507:20b0:3d9:3ee7:a75b with SMTP id
 e9e14a558f8ab-3de304f2062mr903775ab.1.1750290938367; Wed, 18 Jun 2025
 16:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618104025.3463656-1-yuyanghuang@google.com> <20250618182029.GV1699@horms.kernel.org>
In-Reply-To: <20250618182029.GV1699@horms.kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 19 Jun 2025 08:55:01 +0900
X-Gm-Features: Ac12FXz88D2o7FcO2slqJtiNgJD5NxCpvCi7fsUGH4HLmFCQnQ7_XC7-NAVyGH8
Message-ID: <CADXeF1F6q5NfboqbnoGJPFf9C1x3-v2OkspKqYhnFOVL2=1vdg@mail.gmail.com>
Subject: Re: [PATCH net-next] selftest: add selftest for anycast notifications
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review feedback, I will move the clean up to a seaparte patc=
h.

On Thu, Jun 19, 2025 at 3:20=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Jun 18, 2025 at 07:40:25PM +0900, Yuyang Huang wrote:
> > This commit adds a new kernel selftest to verify RTNLGRP_IPV6_ACADDR
> > notifications. The test works by adding/removing a dummy interface,
> > enabling packet forwarding, and then confirming that user space can
> > correctly receive anycast notifications.
> >
> > The test relies on the iproute2 version to be 6.13+.
> >
> > Tested by the following command:
> > $ vng -v --user root --cpus 16 -- \
> > make -C tools/testing/selftests TARGETS=3Dnet
> > TEST_PROGS=3Drtnetlink_notification.sh \
> > TEST_GEN_PROGS=3D"" run_tests
> >
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> > ---
> >  .../selftests/net/rtnetlink_notification.sh   | 52 +++++++++++++++++--
> >  1 file changed, 47 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/rtnetlink_notification.sh b/to=
ols/testing/selftests/net/rtnetlink_notification.sh
>
> ...
>
> > @@ -18,12 +20,11 @@ kci_test_mcast_addr_notification()
> >       local tmpfile
> >       local monitor_pid
> >       local match_result
> > -     local test_dev=3D"test-dummy1"
> >
> >       tmpfile=3D$(mktemp)
> >       defer rm "$tmpfile"
> >
> > -     ip monitor maddr > $tmpfile &
> > +     ip monitor maddr > "$tmpfile" &
> >       monitor_pid=3D$!
> >       defer kill_process "$monitor_pid"
> >
> > @@ -32,7 +33,7 @@ kci_test_mcast_addr_notification()
> >       if [ ! -e "/proc/$monitor_pid" ]; then
> >               RET=3D$ksft_skip
> >               log_test "mcast addr notification: iproute2 too old"
> > -             return $RET
> > +             return "$RET"
> >       fi
> >
> >       ip link add name "$test_dev" type dummy
>
> > @@ -53,7 +54,48 @@ kci_test_mcast_addr_notification()
> >               RET=3D$ksft_fail
> >       fi
> >       log_test "mcast addr notification: Expected 4 matches, got $match=
_result"
> > -     return $RET
> > +     return "$RET"
> > +}
>
> ...
>
> > @@ -67,4 +109,4 @@ require_command ip
> >
> >  tests_run
> >
> > -exit $EXIT_STATUS
> > +exit "$EXIT_STATUS"
>
> Hi,
>
> While I like the changes above (that I haven't trimmed-out)
> these seem to be clean-ups that aren't strictly related
> to the subject of this patch. IOW, they don't belong in this patch
> (but could be a separate patch).
>
> --
> pw-bot: changes-requested

