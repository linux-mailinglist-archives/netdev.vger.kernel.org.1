Return-Path: <netdev+bounces-65251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B99E839BB6
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 23:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C213B225A2
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58B833CCA;
	Tue, 23 Jan 2024 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8oT6HUv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047334F205
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047371; cv=none; b=cbcxonOAt8NYiXusfsJNmS54k0/pRTjlee7LdkrB9LMLzJ29AAlr9EeqG95kCxtNBqP684VX335FRW0iW/TrnFEjZIKLbbHRVNg7UgFQvirH1/dJXfchXP1gNqYGkt9SN05pnwXuU2BYnaXvgK1oLudjQtTtPWOci1oFOwAb9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047371; c=relaxed/simple;
	bh=HgTRRVjyuzAuc+uFsVWjvlHsJe4nAGYNRCrTr1McRp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVTIdq+HAeqwa1G5vTO540lrNkBCzeGFNq9PfGvObKK0qlgbWv6Z9SQST8UPxlOiKlhe9VRJcJPofbtQ6jDc4T14BcPjG06q2pLIwkM9m1t2zi1peIuhOxYCtGuk5cCsGsU/o2WP+XQn2A5oIqnyvxh/UnFmk9XbYldf7yzZDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W8oT6HUv; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ff7ec8772dso40678177b3.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 14:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706047369; x=1706652169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgTRRVjyuzAuc+uFsVWjvlHsJe4nAGYNRCrTr1McRp8=;
        b=W8oT6HUvRfOF/tcgM17M+2Oxv3Pj/o8OpY/Hxn44ZdwyRM8giAFOF3Thxovqe78NPN
         E11vGjA+hvYOAGv0vIL+jf/WCf/AxReeqVSDgm/CVSH6DD1y4+y7iCUJXgAjy/quCTUq
         qvDpynfpHBnVV7aJw1D3ul8+DxApOFCXUtdP6RzzQS/kpjPSaUxr1XyUs03rB63mXqS5
         omhAfOAXmu+YvP9c3I2um8LPopOBRXNz1bA4LK4jmHHcttkUuKEFej6q5ql4O3wkeN/9
         jwsO5XB5BvvZLCbKKwMvV6nVUqlVnPn4YxApG9cSyC0ql1v908e/UPBinc24x2GaezPc
         SeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047369; x=1706652169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgTRRVjyuzAuc+uFsVWjvlHsJe4nAGYNRCrTr1McRp8=;
        b=M6wHLsUdpsVXPc7GdfWezmkcsUk9iCl5aWRxlRhNajjVizyIByanjLwqf5jKmrg/zV
         bmpv0zgF6HYc8t/oeT41OfmF6a09SB8YCNI61whCJ8Ex8TDR+yn2PT+VkkvEkzixj0fh
         PtGemRb4PPrvZ02ZBmJwe/rcUIiNHsNa3de7yEGqBpP33oaMg13qAo8ey9pnJs981imx
         SwNoEFon1/0Jnq+fzRNOkXysj/CFh3ARmwGlQxm9FTLeddS7Fq84AuThQ/hJQhIVkRbU
         NtMUxlohFSbvJ1ftGfgJOTgS/+81PMthfWjq/+Oi8UPfFwdCzT8gh8OF63ob+bkR8uGm
         Dl/A==
X-Gm-Message-State: AOJu0Yw4qInNefKcmI6HRj/IAPLOvbY2yl7q4sSdCB4rCYwCJm7JxXwN
	n1k7y67A9twbPA561SsBSmBQjz4xsbh6gtWjlRPZe2Lw5H6JSUev9cy82MGmg0dGvFoMr8YIHAJ
	9urfzxjDEBHOBa61v1GN/uv3ZYL1p+F8PgySVfeRDcniBn+QAE8E=
X-Google-Smtp-Source: AGHT+IFbEKDHqQmuehxqhp8FfEkVg8iS6AJ6u08P9ZuFWtI25K4qsjori8s0DwJzbDWn7qVPqEE1EkAPc0omeV6ElPo=
X-Received: by 2002:a0d:e207:0:b0:5ff:af99:54f2 with SMTP id
 l7-20020a0de207000000b005ffaf9954f2mr4468429ywe.50.1706047368667; Tue, 23 Jan
 2024 14:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123214420.25716-1-luizluca@gmail.com> <CAJq09z4H5TmOq4tM1RifGrVQPrSs57dR7yCv=1+gnxZadFobbA@mail.gmail.com>
In-Reply-To: <CAJq09z4H5TmOq4tM1RifGrVQPrSs57dR7yCv=1+gnxZadFobbA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Jan 2024 23:02:37 +0100
Message-ID: <CACRpkda=zELXRSvXT98FiQh8jv9xJ3HU_Rn9iJLGzgBWmNeb+g@mail.gmail.com>
Subject: Re: [PATCH 00/11] net: dsa: realtek: variants to drivers, interfaces
 to a common module
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 10:55=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Sorry for the mess. The cover-letter broke the subject-prefix I was
> using. I'll resent using the correct prefix/version.

Why not check out the "b4" tool? It helps with this kind of
stuff.
https://lore.kernel.org/netdev/CACRpkdaXV=3DP7NZZpS8YC67eQ2BDvR+oMzgJcjJ+GW=
9vFhy+3iQ@mail.gmail.com/

It's not very magical, from v4 I would create a new branch:
b4 prep -n rtl83xx -f v6.8-rc1
b4 prep --force-version 5
b4 prep --set-prefixes net-next
b4 prep --edit cover
<insert contents of patch 0/11 cover letter>
then cherry pick the 11 patches on top of that branch
and next time you b4 send it, it will pop out as v5.

OK I know it's a bit of threshold but the b4 threshold is
really low.

Yours,
Linus Walleij

