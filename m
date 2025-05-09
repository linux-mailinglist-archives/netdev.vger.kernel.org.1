Return-Path: <netdev+bounces-189128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA382AB089B
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 05:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF309E5AF4
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 03:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4591238D52;
	Fri,  9 May 2025 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5WLDakk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3722D9E6
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760504; cv=none; b=kIhNcoiIn2z8mDvWs2dZZ+JIqegHB1JalqHwwT2IYYa51tN+bpoIqeyeVN0RZ++UjSzujU365zeDN2SBMWD0usKu7ksZmLhsteI0Yp7TIfDnmPoIsUF5xHlOL/pNAtdfDu4ESIt4a5k+aTMogMyBaroZVAATE8adLMeDjZJ9Nac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760504; c=relaxed/simple;
	bh=NnBIZ9fjH0rLP735QwjU8cvpxRKzqJs1xZEpIdxaIwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVHGyA6pw+DmPapk2mAKs+htc/wASREUFSJnwY1NoE39NS5XKeQF7pGgCvJlWc5ZhL24KUYLv9EgiB4NpKSVgWgGoPvRS/+hio6z7AUN2rxGQrZ7fwlzxD8a6vziKuD0hSR9NybaUC+DLXYSsOgq0yWkUwBhqQuL2IVqG8Vla4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5WLDakk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD993C4CEE7;
	Fri,  9 May 2025 03:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746760504;
	bh=NnBIZ9fjH0rLP735QwjU8cvpxRKzqJs1xZEpIdxaIwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k5WLDakkQcXTJQ45Ve0r2feuWEoYN6zxFfAWanPgzbLj1s86wtYaTPUjaIkuujXg/
	 D89K4g47YgKSshaVqqAzBv0IhXZDP8O3//6pKb3GiSA2ootO7+T2RncH8QATr8TCqa
	 CddOVi80vvsM/MDwUWzy1d56I0OpjTCb/6NgfzhiN9d0iXH+bWGwTA3b7A3sBL03ps
	 x1qQWajwAV1VStkM62I8CPan0VARSXvfXyhBoDa76kw6BQvOEy8Ru3r/g7ZwerzXXH
	 EJwx2/n2vKpgu5KrDnxEkpltmwBTywaocdevF47Tb3w4JGFVNe708dyIZrhXY7vEe4
	 v0a4Rwb/JO7hQ==
Date: Thu, 8 May 2025 20:15:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Simon Horman <horms@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 4/7] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC}
 to sk->sk_flags.
Message-ID: <20250508201502.5bbbc51e@kernel.org>
In-Reply-To: <20250508013021.79654-5-kuniyu@amazon.com>
References: <20250508013021.79654-1-kuniyu@amazon.com>
	<20250508013021.79654-5-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 May 2025 18:29:16 -0700 Kuniyuki Iwashima wrote:
> diff --git a/include/net/sock.h b/include/net/sock.h
> index f0fabb9fd28a..48b8856e2615 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -964,6 +964,10 @@ enum sock_flags {
>  	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
>  	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
>  	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
> +	SOCK_PASSCRED, /* Receive SCM_CREDENTIALS ancillary data with packet */
> +	SOCK_PASSPIDFD, /* Receive SCM_PIDFD ancillary data with packet */
> +	SOCK_PASSSEC, /* Receive SCM_SECURITY ancillary data with packet */
> +	SOCK_FLAG_MAX,
>  };

32b builds break:

include/linux/compiler_types.h:557:45: error: call to =E2=80=98__compiletim=
e_assert_809=E2=80=99 declared with attribute error: BUILD_BUG_ON failed: B=
YTES_TO_BITS(sizeof(sk->sk_flags)) <=3D SOCK_FLAG_MAX
--=20
pw-bot: cr

