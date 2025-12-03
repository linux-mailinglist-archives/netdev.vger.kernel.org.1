Return-Path: <netdev+bounces-243459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF36CA1A04
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 22:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A00993038F53
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257FD2D3225;
	Wed,  3 Dec 2025 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeFtVoLw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7082BD001
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796064; cv=none; b=uZPHRpDnD/MF6XMIY0mc+qZ7TLyv1rzWic3XR45sxjmO0myF7K1SYwxGpaQGhs9BZvWO75GPmHZx/rYdwOClO8QgPdmqcjy2b7StfmBEhlEQumhnLAMZOM9x9Yzie4M4C+RXPrgwSGz6kUuOMsp+xdFCkcIvB4suKw01JjNc4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796064; c=relaxed/simple;
	bh=3d9aGC6njWAs8y8BO9Q+if9lLi5u+CBRThmGFWSqsLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPls4A+WZRYMroyIGPCMgXjZ6O/cDSnUxPaYQOCzfxpnvYbY7TGpSLsrotLkPK1AQBBix0HH3OEO9GSzFVZVLHRwUolt8/lKRSOr/RPeX7iu62n2TzmZjW1/YimTXYC/IC3j8keJcOYBdjUvFacR7XijOiK48vpsnyaI5ANkkeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeFtVoLw; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5e18598b9b1so200187137.0
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 13:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764796058; x=1765400858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d9aGC6njWAs8y8BO9Q+if9lLi5u+CBRThmGFWSqsLE=;
        b=FeFtVoLwIernLHUcn2tQqHiCCMCChIRDz/sHWZexupT27i5LLMWRsNV3AwTcwXotNC
         5WD2yOsJGCfBuzAHZmDzkwm8mV6+dFWjnjhjSv2dPXilOHLmQ1ZpUL1giYXRtOsEQsLv
         Ep2TL3Ce2aHB4K6URlCb0enJ1cYp1jTjkOq/Pa5CgYxNOHzLgJQGyl70yLsqnv07h3dV
         zG8YiWzWOxeqnDmBHLzsDoK+GUloMQ/eRQptHhOsTDp5lp9e0kepjTKaQOGAdmCCoLCQ
         3nftLqeRAdEglN6ILLaN2O3qtebSebp5XGLT0SDfLsd2DOWrSDJj05mSh4vN5cj2H/pN
         UvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764796058; x=1765400858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3d9aGC6njWAs8y8BO9Q+if9lLi5u+CBRThmGFWSqsLE=;
        b=eCqe7MZum+sE6IuUeMdkl9uGc/hy9eFXD8nT1BOvJkunNMg1/NgDYECf815eKI3Bsc
         vTp9a6fG4XBv6cte4BlfLAK6lO0SOE1H/ENW6VWnU3XRwIe5yDFcENsl3b4i44kekfS9
         RMs9Zxzpu8uqu/0Oa22b7Bx4YuZcbZU1Cm+NMy51BZLofmg+aL2MrrBKyIqDXxNeBhbM
         y/uzLZ/MoMDCrHic0sESWsFVnwo2YwqLIR5Hy/2aPaY+StGNYeGgOZ3HO8zY8cUSSbMx
         9cdrKvYf1Fqo4s0kJipju61hSZs8dSvprbAQSEgbG0lo6lOW1xIcqrmY2McXQMqw7Tem
         wJzw==
X-Forwarded-Encrypted: i=1; AJvYcCW/NM7J0y9t3Aq0tcqrE7071/qLuV9xQvNEVLw4SrppknyXV7bZdZHQIcoQSkV61TyDTBTQAMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKII1PrgwKN2NHeVMn/DTFjZV/lk6dGM/LMxQt1x/lTVT4rK4Y
	GhN8ZXOZxXLdnKDpwnbAIqfO5U2/oq55X2+7WM5WDLGLnPA1qZzkGnptGRetwe1FT7dkhczDwRC
	ZG/htImlO2MPiX+IfiVj+Pny9TQkvlAY=
X-Gm-Gg: ASbGnctCzplwQA2h4xh3bC62t3FsGmxyij7YE0WrLJr566HfIoR1chj0L4Kur2SfYAo
	ceYnMRSN69lxY+ok0NWWQhDdKa2hwKnqWmyT7c7bMmv4qqIPKUYyR6u6qdRk7FiQt6Ciw/B4uBV
	3d+m11xVcMbUV4qg9hoAulVK4ni5xQNb+jofWo1NlKETRdb+JWCRL7pAgWTU+jNFXFb6BKVIYQG
	tglutx86vjnKuNsgCVEke9K5Zx1mS6z2vMuldVLHSExvM5Zl7lGULvJin5BRFz2oAlj+72kn21Y
	HkKQUqP0YLfZE7mgoncED3I=
X-Google-Smtp-Source: AGHT+IHdAfimol68DLumAqunidsHIT0rEt6ihzkJKjfjB1Fpx4xO6ifuhvmA045Unpi4oj8UbhPgZh3GuuMpgILmXeQ=
X-Received: by 2002:a05:6102:4193:b0:5dd:c568:d30d with SMTP id
 ada2fe7eead31-5e48e36caafmr1498913137.30.1764796058300; Wed, 03 Dec 2025
 13:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122003720.16724-1-scott_mitchell@apple.com>
 <CAFn2buA9UxAcfrjKk6ty=suHhC3Nr_uGbrD+jb4ZUG2vhWw4NA@mail.gmail.com> <aTCEOnaJvbc2H_Ei@strlen.de>
In-Reply-To: <aTCEOnaJvbc2H_Ei@strlen.de>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 3 Dec 2025 13:07:26 -0800
X-Gm-Features: AWmQ_bn6jvlgEQX1iRcPAlpxmFuQ2XesxYMt5bijkTTCvXVOrAoKa4yW5JnmoQE
Message-ID: <CAFn2buD9PZsahDwH25n3kxoVtkk1G_dCErCZViqxeC7jnbO06Q@mail.gmail.com>
Subject: Re: [PATCH v5] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the timely response! If you are satisfied I'm happy to have
it placed in nf-next:testing whenever convenient.

On Wed, Dec 3, 2025 at 10:41=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Scott Mitchell <scott.k.mitch1@gmail.com> wrote:
> > Hello folks, friendly ping :) Please let me know if any other changes
> > are required before merging.
>
> net-next is closed and I don't think that it will re-open before new
> year, so this patch (like all others) has to wait.
>
> I could place it in nf-next:testing but it won't speed up the
> required pull request.

