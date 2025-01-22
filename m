Return-Path: <netdev+bounces-160183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B94A18AEE
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 05:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011D016628D
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 04:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6229F158862;
	Wed, 22 Jan 2025 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leDNzgi2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393598467;
	Wed, 22 Jan 2025 04:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737518981; cv=none; b=KNX/AvM65XyWoEU7WEyCMVJrb6pPzBlAbiD8Bz78YY4Exe+fq+mXBI314MpQyzIXel8SWQloXv6YrMHuSPhYr1CQuSQD7h+VW3UW/ZbUvRUyXuE4vH3bQM+963q++YU5wr3pZsIG9VyQN2Uk79iOuxbslH7ckv8vAoxp0diWje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737518981; c=relaxed/simple;
	bh=6SfJfQjzLtST0Yq+yaGTF/b70gSByACb4yDZimVTQvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ca76J4KETtShVd7cZTKmCt7Bs6u3h5dCsg7uD3H7HYi9dXf2ccKUKSA2tVZJ33aNViy/Jqrdpvjh26iLeBcmdBZWqGZC1qgy945MR2mmRgVwxzTFBWiC7A6ezgXelsCNvAyZ3vv+7S6stl/WgncQhPRzuaDeMJpWyLVTIqMx39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leDNzgi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AA6C4CEE4;
	Wed, 22 Jan 2025 04:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737518980;
	bh=6SfJfQjzLtST0Yq+yaGTF/b70gSByACb4yDZimVTQvY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=leDNzgi2xOZiv8bygiEslg9mNY6Zg/G57H+6u3QbG2Z8BCRd1dXxeK8ndkxZErjyj
	 wE2iS7G0wTpVmPDX/SOGM1juH5ihk5Ezn4sHnVCiQmcrN7QtvR3/15RECIj7x+1Mg9
	 XJQvKUeg0waFfAv6BD48qb8ljXKdBegyCsT/W0WyKeWFFHJHNgawl1/nf87gRTMC/d
	 Cv4SubwHqnGUmCDu+jRqX9Qn7ngkY8GSU7jfSHPlvl3b/wfdjkjUUp9PpUiEQ3vCIK
	 O8i4cVvK+ZhJnKwx9NJMGZgsF/XworO6pFgBKyWaTM0bLfou5oAotDJY/CF07CssGw
	 PZfT3o+tBwdhQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso9999664a12.2;
        Tue, 21 Jan 2025 20:09:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKPT4SZenjY6YRsDuhTpzSZra3va8M5K0y+lmvevRDISotRNfiOq3kre4XeUf2yOti6LSvsLpv@vger.kernel.org, AJvYcCXV0Fzgl6eca7SNxueAw65wjqEGTvYUn45NK5s4PDEB7rpPJM56JzwY7hDbEQRkw2wY738eH8DiqmrFsoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwSXYpkuwC5loQQHSJyPbIzZbYvFRcsJHr9t9Qh0trvqQ7IIRy
	Bynzyr9+QNUgGFsvM3z/cjhNVPn45A+X0DaHngHgQhGY+WseKFke3LWAbPpKgas6SlWwpO1D70B
	x0ObJ012xHORYkT9tTcV7Qezr5SM=
X-Google-Smtp-Source: AGHT+IH4lHqnyHsRuGktvUptLHu6v24gv23EmvFpq7uzvlDcmEy19Fs91EyXg2Jk2HqWEty/JTL+R8RYTHZ0KVUAe2A=
X-Received: by 2002:a17:907:1b1c:b0:aab:d8de:64ed with SMTP id
 a640c23a62f3a-ab38b165f86mr1680588966b.25.1737518979142; Tue, 21 Jan 2025
 20:09:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
 <CAAhV-H7LA7OBCxRzQogCbDeniY39EsxA6GVN07WM=e6EzasM0w@mail.gmail.com> <20250121101107.349a565b@kernel.org>
In-Reply-To: <20250121101107.349a565b@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 22 Jan 2025 12:09:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6HDOvjr5sA3n+dUMTLm22_p9fAFaTgEUcrufR3XHrj9Q@mail.gmail.com>
X-Gm-Features: AbW1kvYyHoSfUV4Y7rKzt4loTuGX6YrpFbpLikCcI11jI6dLozt2wMSQwYS5WMc
Message-ID: <CAAhV-H6HDOvjr5sA3n+dUMTLm22_p9fAFaTgEUcrufR3XHrj9Q@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset function
To: Jakub Kicinski <kuba@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, si.yanteng@linux.dev, 
	fancer.lancer@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jakub,

On Wed, Jan 22, 2025 at 2:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 21 Jan 2025 17:29:37 +0800 Huacai Chen wrote:
> > Hi, Qunqin,
> >
> > The patch itself looks good to me, but something can be improved.
> > 1. The title can be "net: stmmac: dwmac-loongson: Add fix_soc_reset() c=
allback"
> > 2. You lack a "." at the end of the commit message.
> > 3. Add a "Cc: stable@vger.kernel.org" because it is needed to backport
> > to 6.12/6.13.
>
> Please don't top post.
I know about inline replies, but in this case I agree with the code
itself so I cannot reply after the code.

Huacai

