Return-Path: <netdev+bounces-64349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D13B5832A45
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 14:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF221C222D6
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CEB51C4E;
	Fri, 19 Jan 2024 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="04KW5BjY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C7524A8
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670628; cv=none; b=IopqfVOoBBELO9/6AbEFBlffgckbJBZ6ZitlBz7eSVbQgqUyLSFov1aEfuC3L55Hw1HSwx5xTpOczjaJJ+6/BtuZzvVtndB03Trc9X8XqBsuCkwY1uHRPJG7tdRdMEW2uyOJNaMtWqu6En1L1CEUPX9ekn/D2CSoOyOCKU4kGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670628; c=relaxed/simple;
	bh=/6q7WmZN2QZiEFi7yw5AvxWnDQlQYQMX0HRzwUcZ0pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TS/FCb2+sULbO5bc8dJqEG+RzUkWz2zBrbD82n8TuP9/pH8W8fymLKwZvYr8DaUvaLGgOJp1/8AV6KYrIdlhhismN6PsOIyxfaf9aCUH3DLxm7O0VFpGQyMzjnqLoG/2x1Oi1kqhPDxp/Bv/fox3FrGf03SPWoCmFnn4lIvOLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=04KW5BjY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso12884a12.0
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 05:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705670625; x=1706275425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7wD20faGLko54A1TjsrLYIf5/QZlvwKZTeu3M7534k=;
        b=04KW5BjYPFlcjfSt0QcgwacS3j8Y2yyn4sTfy79wATNocs1vcpzTKVfGdX4su22H2D
         LFj8qjNHuWsoJRblK0joYYJbYCruJPZwht5zRnzaAEuXh18skPj9jLT/yd7skRG+yrtU
         AaU+7hgx4Hd2rNfFTN5PKPNi4Riz1m2iAJZLgHqGNQDEOi4XzOwExgTIsknE58JLGfWT
         dUNZtr6LCkV5XYSwiBxO1z7WK0qUuMP3NrHG+RlrNveOs3OqmPx/vHwn75Z6RBoY1xal
         B9ogqbCt0pX95SMzh4WkibTP0YpvNtltThM48ZaoGF64S9/zVqYJgm8WJ0CcFzj7lyw7
         8ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705670625; x=1706275425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7wD20faGLko54A1TjsrLYIf5/QZlvwKZTeu3M7534k=;
        b=RwfcaflJqESyeYU+OvKQbSiE2ToRGYxYenQhrOTwiRJHHoga8eDsDj0HmfGbCUB5XC
         isHWiGXUusUdP8N2CmPaz3k6gbcUb7D6kHCvRuESV4101PP6zFDF+b9V5+pt3co8qayF
         kdpDTAFMs8Z+07S8FjDV60BhiukR2gkwz71gNd0RNWfEqQUuFIafxoeOZuSDOPjYlnx3
         6EeUWZtlMD+YKngiTW1fmPsZCrmsTD0bJ5Brg1a9ZcgcYCO7MF4gEk5NScnybekBrTkp
         pjbPWllsfKH+al0G/nvf+pMidEhysiIAA3bscJWndwvmphwS33DWdf5sbbhP3O1qW/ni
         +9gw==
X-Gm-Message-State: AOJu0YysiNIB5CBz94lKOrNGm+qeahye73Wh0aAymClIKz3crsTR+roz
	wRA5hylYXwfE+g+vf/Yh+Ptt3WYUJtc4jDleAx1kWS/nCU054B4S4XHFfeiyjzGFK24yPmKxlAJ
	6p/1+sNNk6h+ZGqzpT32IEH6EAFxIE305a4ZB
X-Google-Smtp-Source: AGHT+IFPnpRV5CQ9+rlkKneQtcvkMvcqQluFqZiTLra/feVpzQdLNyACkkqPvTGWjhvU/7tGhxEeR+ZNfGP0SWEapHk=
X-Received: by 2002:a05:6402:3134:b0:55a:5fe0:87e4 with SMTP id
 dd20-20020a056402313400b0055a5fe087e4mr95152edb.0.1705670624833; Fri, 19 Jan
 2024 05:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119005859.3274782-1-kuba@kernel.org>
In-Reply-To: <20240119005859.3274782-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Jan 2024 14:23:32 +0100
Message-ID: <CANn89iL2Cfy6yfY5xF-n+4OEyzCVGm__nH_xo3t0jy8zL8KW+g@mail.gmail.com>
Subject: Re: [PATCH net] net: fix removing a namespace with conflicting altnames
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	=?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= <socketpair@gmail.com>, 
	daniel@iogearbox.net, jiri@resnulli.us, lucien.xin@gmail.com, 
	johannes.berg@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 1:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Mark reports a BUG() when a net namespace is removed.
>
>     kernel BUG at net/core/dev.c:11520!
>
> Physical interfaces moved outside of init_net get "refunded"
> to init_net when that namespace disappears. The main interface
> name may get overwritten in the process if it would have
> conflicted. We need to also discard all conflicting altnames.
> Recent fixes addressed ensuring that altnames get moved
> with the main interface, which surfaced this problem.
>
> Reported-by: =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=
=B1=D0=B5=D1=80=D0=B3 <socketpair@gmail.com>
> Link: https://lore.kernel.org/all/CAEmTpZFZ4Sv3KwqFOY2WKDHeZYdi0O7N5H1nTv=
cGp=3DSAEavtDg@mail.gmail.com/
> Fixes: 7663d522099e ("net: check for altname conflicts when changing netd=
ev's netns")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: daniel@iogearbox.net
> CC: jiri@resnulli.us
> CC: lucien.xin@gmail.com
> CC: johannes.berg@intel.com
>
> I'll follow up with a conversion to RCU freeing in -next.

Okay then...

Reviewed-by: Eric Dumazet <edumazet@google.com>

