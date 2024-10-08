Return-Path: <netdev+bounces-133317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ADD995981
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22211F22862
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA18E215F55;
	Tue,  8 Oct 2024 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SINnj/yD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD6215F47
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424760; cv=none; b=QNQXmnzrUijzKQxFdEC1+gnLqNUlDxtXOXsdG8NFzUybAPh2IBzI90jY98dbqVOPMBLjgxK6Ahfbn9yksP9ag0nNgokum4Np3soigaqHlTdTUvBEgLcL5bV1bOaOOskS+pwt6cOgHBGHu/EXdCY96eUndCQbK4m/zJfH/PJt5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424760; c=relaxed/simple;
	bh=xw3KXM944BfpSLuPPvYdbUEL+qZg7O9ZK5U9/C225+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haMB32Wfw/Nqep/cbDOCuoPJZXpTkhG9Lp65AKQV4/6cSGyEKd7dQ0mGZURdTtQEc4kaJU/mSQAnOXZP6/ERkCWuCg45NbQmpF9iM7Jl1bbVbnxYynHLJ4ErDeQp3nPg+2PekVvGdCLX2bmzRR/KuaOFdjOinmWyFrAE5DvKBHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SINnj/yD; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-835393b3c05so12404139f.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728424758; x=1729029558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW+ok1g/buM3zTdkY7NXRZHh9e50Wa4OPCNFcvWVdXU=;
        b=SINnj/yD+d6Y5HrAmVVE6VjqzjsVh4OTe8S9XHHMunZOVjeOTHUQZaqTUPBGXD0j+x
         YIWJW38UsH4BcT0GLB2sb7z+/JLwvWtjrJ6/2PIUGDm1CrlX5/grlGRaeKjEzJbR/1uO
         YI3PJcp5me7tW7qCV1qcmL3ialSxDS7dikoz6KGnaUWJEEMLi6av2UyJkNnHv3GIpNQf
         a/nQ22vrzE7ah2FzAsNhfFMB2BLKMnlYk3ZgbVmBYHQe0QbNkDPYXQoyR8NpCjTBDrhh
         G5I/7bZiYQ3WRlNW3L642dulKz+XDcMlIbCDZtPvU46vjQ4aoxBS/ZSn1FwvMWZemn9i
         /axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728424758; x=1729029558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW+ok1g/buM3zTdkY7NXRZHh9e50Wa4OPCNFcvWVdXU=;
        b=QD3mH+i/5cIgxW99f0H+i67SbejvO7P/n/TUIqCRXae1iMvmF07oWdmNCxvfKMFm+w
         eZPkFU7UN1uRan1jtjB8kjMokBKqOakRavHSbFtc0EP6/JjKDpS0x4y94pPvedmG5ii2
         gaBdnUwUA5sEH426O7dwMo+CBPlmpJMI8em9dxiC1mXxSEk3txv6KEGe4EJpNO82D0Vu
         tbv6lzraTpD7/GxWfQiTOshFXSX0df5ZOGixfj7I7io9B6EXAweuKCGWnpcDIEdXhnXh
         Lcm2/GpJYsfcTb77HY1qCwQDHor7O0la463+eOr/IAptNigPj/qr6TRMCa0k1yRAdAlr
         jHiw==
X-Forwarded-Encrypted: i=1; AJvYcCWY1RJXPdO2Vqj/jBevu/4VKFrt1Xbbcw2jsux4wk3Fk4vbZqDuhA9yCfKyKS+etNZKB9cQqZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRbzHTeFCf/I1OefLs2dHKgSvLQUefyF/VwktSHV+cZE3vsgrA
	HXGmTh9MjD8ey8TGEwc/qtdKN+QSaAAtFNsOVHnqYLjsKAsx2pv+EqSpPKcy1EGUQAbdhAxccLQ
	TJ/a7IRHxKiJC5LQsslQHmoBQG4pXEvdx
X-Google-Smtp-Source: AGHT+IGP8a5nastoMTGzFw/FmESzTW36/SX5ld5cl/pQy/OlB69UFNODaCVgbJw2DJ5W0O3eBq+nq49UTcHihdPTzzs=
X-Received: by 2002:a05:6e02:2162:b0:3a0:9cd5:92f7 with SMTP id
 e9e14a558f8ab-3a397d259c3mr2920215ab.17.1728424758205; Tue, 08 Oct 2024
 14:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008143110.1064899-1-edumazet@google.com>
In-Reply-To: <20241008143110.1064899-1-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 8 Oct 2024 17:59:07 -0400
Message-ID: <CADvbK_eeeBtTZiOfE3Pp2GR=aKt8NP_56M1g_n8g18EQRtt5RQ@mail.gmail.com>
Subject: Re: [PATCH net] net: do not delay dst_entries_add() in dst_release()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:31=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> dst_entries_add() uses per-cpu data that might be freed at netns
> dismantle from ip6_route_net_exit() calling dst_entries_destroy()
>
> Before ip6_route_net_exit() can be called, we release all
> the dsts associated with this netns, via calls to dst_release(),
> which waits an rcu grace period before calling dst_destroy()
>
> dst_entries_add() use in dst_destroy() is racy, because
> dst_entries_destroy() could have been called already.
>
> Decrementing the number of dsts must happen sooner.
>
> Notes:
>
> 1) in CONFIG_XFRM case, dst_destroy() can call
>    dst_release_immediate(child), this might also cause UAF
>    if the child does not have DST_NOCOUNT set.
>    IPSEC maintainers might take a look and see how to address this.
>
> 2) There is also discussion about removing this count of dst,
>    which might happen in future kernels.
>
> Fixes: f88649721268 ("ipv4: fix dst race in sk_dst_get()")
> Closes: https://lore.kernel.org/lkml/CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf=
7aGtiYgZnkjaL=3Dw@mail.gmail.com/T/
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>

Reviewed-by: Xin Long <lucien.xin@gmail.com>

