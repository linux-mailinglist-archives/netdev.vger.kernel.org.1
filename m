Return-Path: <netdev+bounces-103447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B81290812F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 03:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7931C21495
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73281773D;
	Fri, 14 Jun 2024 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMGmGctS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2519D88A
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718330250; cv=none; b=joN3JoAKQyUA5bkLtq0a7WgT7j1tVw8FaXme77uN9OI5/apCtjEAncgaSumOjTmWa3HTpj7FoWy4HtajKAiaG30mWZ1tTbSKFCRlr2W8y2x9Es9qElbMpeHgp+tegDxh4LnueLDBQrU/drS8PequPB33LY6FVzSRWeKASXuOJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718330250; c=relaxed/simple;
	bh=5UgsinmFIF3B9EnSVAHU4r/3KDevlNjF1L48MiCeOjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLfbd7EC9rn0YZ3K2e84B2v3voDe/uR57Ixmd/jmE1g7LuysbI++6eNcpQDiMZPBR3pUkVAL9kPdGIgZdkIRe8WbJCPwZXa8pdZ4nkdgBqHoefJBpOaEMHJkfDOImlGekwJAs3CVFKqzp7h+1QkFrseGqLJp/LIqG/es/7kbgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMGmGctS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9B8C2BBFC;
	Fri, 14 Jun 2024 01:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718330250;
	bh=5UgsinmFIF3B9EnSVAHU4r/3KDevlNjF1L48MiCeOjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMGmGctS/AsZRmHSrtA7btYY+6QyV87iY/JcWcpSkwHRh7VqjiRXmRzHbOz5zsBfY
	 4dJFYPUmwnD6TrM575uWyw9nNybkPtYZNnLdF22e+Ggh2ukBwmJfUYDdjBcqNiLEaT
	 lgYsduKXn+UwRkpriaikNa5gfqESN1VqLm0cdCOuIYvlA9bZRas37fFsNEvkbMm1ab
	 96tY3/F8W1118UUe+5hSKK59mejhyNzs+JWQy1Ew1GGR50uzt5AZhFn93Dty8Cjn0V
	 acDCGFxuTY9VM3xtd8qRhZ7F4Rg7fqjH9JiDYIrIkkWcOUZO84Nh7PrKlz9TntQl8+
	 4KgJIfUFaM8jg==
Date: Thu, 13 Jun 2024 18:57:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: make for_each_netdev_dump() a little more
 bug-proof
Message-ID: <20240613185728.6e7bf9ad@kernel.org>
In-Reply-To: <d6e29acc-c759-48ce-bea2-3088b4d3ea86@intel.com>
References: <20240613213316.3677129-1-kuba@kernel.org>
	<d6e29acc-c759-48ce-bea2-3088b4d3ea86@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jun 2024 03:45:47 +0200 Przemek Kitszel wrote:
> you are right, it would be easier to go one step [of macros] up, we have
>   453=E2=94=82 #define xa_for_each_range(xa, index, entry, start, last)  =
       \
>   454=E2=94=82         for (index =3D start,                             =
         \
>   455=E2=94=82              entry =3D xa_find(xa, &index, last, XA_PRESEN=
T);      \
>   456=E2=94=82              entry;                                       =
       \
>   457=E2=94=82              entry =3D xa_find_after(xa, &index, last, XA_=
PRESENT))
>=20
> You could simply change L456 to:
> entry || (index =3D 0);
> to achieve what you want; but that would slow down a little lot's of
> places, only to change value of the index that should not be used :P
>=20
> For me a proper solution would be to fast forward into C11 era, and move
> @index allocation into the loop, so value could not be abused.

I think we're already in C11 era for that exact reason =F0=9F=A4=90=EF=B8=8F
But please don't take this as an invitation to do crazy things!

In netlink dumps, tho, we keep the index in persistent socket context,
because the iteration is split into multiple recvmsg() calls,
each one continuing where the previous one left off.

