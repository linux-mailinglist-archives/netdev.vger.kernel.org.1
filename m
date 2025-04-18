Return-Path: <netdev+bounces-184110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1A8A935DD
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3244179147
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA8B2741C4;
	Fri, 18 Apr 2025 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afCMAfsx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7B52741BA;
	Fri, 18 Apr 2025 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971063; cv=none; b=moPEjlCVh1aDrHhigOtonlVCxxV2J6yRLxUnNvEb0GMuRCObo7Om5aACfkidyLg2Ojx1YuFXV+3Q1zULNND9/nKxITry4NkQc9uasmRfxMd/UG104oqtI1UyHTb1Wq45ss6e8esbDaUThcboBJTyqV0ZkQhVEo9wbcZpQG5N+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971063; c=relaxed/simple;
	bh=n17hHD71fjfeCryWjsaHFoLT9UFwBym7iAQ/KR8Xlv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh22JZ5e16/Xs76ilFKuz4o1mqwCPJ2EPc467e0Oj/LxEB1Om5JftERtnSeSMHmMrh2R6RdRbeTEH3CW+Ng3fQwpdtgxJxF1W2C4hC8d4TbC9W6knLf2bOfiTJWM6Pgy8/IXbbwA/0elCXGFihpy5B+KZH6QkZAxW+m77ODCWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afCMAfsx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso344381866b.0;
        Fri, 18 Apr 2025 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744971060; x=1745575860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QMDDZSKx+HwZEHjuUq4iy5QAOO2sg5Fgy5qC6TXwyqw=;
        b=afCMAfsxkfM2/OCwqBwYDzsm6txlge2JSTavkwsV7EscSPRtYZDxdvMsB+JoCV17Fm
         LT3GHc64xjSoH1l8tmHb1Q+ypPe5fTEg/92D1boT9pFhkTRUUjcBT3LNV8Li3p4bQUde
         1piOWa8hcrI8TTbDBoOkojQGUjLuUU0WCtZ67Q3fx38IO1HgevCVKowNrlNIlLD/CsSQ
         HswDG/IhRC9wWKZwFSIjCY3G8Nh+aNl4zUX9uHG6ZikvT9DcmCbt+4bjTD6wGdqwnQqL
         I8Y+uMN+liZk8eapaIF7Wkeii68TgvRq+uymAUsdFHH/fKNG0nAjbULKp3m/FGlYhFqI
         1c3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744971060; x=1745575860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMDDZSKx+HwZEHjuUq4iy5QAOO2sg5Fgy5qC6TXwyqw=;
        b=PfZWuJBEEdyLPCDI8LSGIGlds1opgae2Jte3oMmNAyf65dh4Z0aAjgW3+qaaM2qFSO
         XyvvmGpAHxUO0NHdJaMm+RlN7jZRcuhT7ikYEPNIRBoHpCEgc5PHH6O2MQNrQXAxG7QB
         dGnyDLNyJqpBaIT/rKIBW7B6YqS64YSwJMMrA/q+xLSL+TbQdZ5nUXxu3RwqBwsTM+rp
         wrONbtxRYIMpmDIUm2cvKnRFXB0PMaDToWbnYbyJmLvnK6oWCxdBFc5hJebWGz3FeL9L
         9fiwWer5c/eJtIqt64knEpKExROCF6cZmQqVdogMg9vGBN0//dzXZiK+kjETM2Tne6Jb
         uaOg==
X-Forwarded-Encrypted: i=1; AJvYcCU2kJEIUW+khTkl2O0YM7zGRet4itP3Vg9AZDeIeZcXIwFAbayb05IsghY8avFuvMJqFPjR9b0MFe4/oRE=@vger.kernel.org, AJvYcCXx7I3JkaXaJOR7kPG1Bw4HoZXH3Xjw44r2ie7ynCs7IkoDmoH6ww7J/CCMBmVHFtgWRQB/SND8@vger.kernel.org
X-Gm-Message-State: AOJu0YzDj62g3pY2VssnMdD5P9UCYg3HuZdom4iOjYMoMBAaU5m0IXeH
	Tav/lj+TJSaO8Oeq5HVcXv2G7bCaOqbp5tBxwQsqAkt0jy/+FTntsguV7XE2Ms3PtdQlQS/FkKO
	zdGZWtHbRzbl/y5jZEI8yMf5ZjOw=
X-Gm-Gg: ASbGncvKz1jMO3tEHIiLbrKLCnGMwE7OOPtTJKutxIP8tmvC3SAHGJyXw6BHdWIGu/b
	OB1JbDEycA0R9GgLmXys+CK4w4mlde9xxSeVgMktnUWSWpa5/3jzkghWWQztHgyHuuQAG+sOOrA
	WmW69TZMNJm/ohqbxcTta2GxtqnlBsvD/H
X-Google-Smtp-Source: AGHT+IF3BRJBFKZjrvyGuLznFO6Arg9RBKnUGBXM/JtZX+cpufwbmsR98eLJ59m6j06coIrrVpxtGH6iPeV3EHJAtis=
X-Received: by 2002:a17:907:9488:b0:ac2:baab:681c with SMTP id
 a640c23a62f3a-acb74b7faedmr223636366b.28.1744971059552; Fri, 18 Apr 2025
 03:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121745.8061-1-danny@orbstack.dev>
In-Reply-To: <20250325121745.8061-1-danny@orbstack.dev>
From: Matteo Croce <technoboy85@gmail.com>
Date: Fri, 18 Apr 2025 12:10:23 +0200
X-Gm-Features: ATxdqUGvaUeq8HzGS8oLadD-F1TQFMu7yoW5hnxkRkO8pw_-UJwEquanfAYYgfk
Message-ID: <CAFnufp14ap0UfJcn2uwU4-3cstr313J86HvRCcKULZLRU=nZ6Q@mail.gmail.com>
Subject: Re: [PATCH v4] net: fully namespace net.core.{r,w}mem_{default,max} sysctls
To: Danny Lin <danny@orbstack.dev>, netdev@vger.kernel.org
Cc: Matteo Croce <teknoraver@meta.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 18 apr 2025 alle ore 12:06 Danny Lin
<danny@orbstack.dev> ha scritto:
>
> This builds on commit 19249c0724f2 ("net: make net.core.{r,w}mem_{default,max} namespaced")
> by adding support for writing the sysctls from within net namespaces,
> rather than only reading the values that were set in init_net. These are
> relatively commonly-used sysctls, so programs may try to set them without
> knowing that they're in a container. It can be surprising for such attempts
> to fail with EACCES.
>
> Unlike other net sysctls that were converted to namespaced ones, many
> systems have a sysctl.conf (or other configs) that globally write to
> net.core.rmem_default on boot and expect the value to propagate to
> containers, and programs running in containers may depend on the increased
> buffer sizes in order to work properly. This means that namespacing the
> sysctls and using the kernel default values in each new netns would break
> existing workloads.
>
> As a compromise, inherit the initial net.core.*mem_* values from the
> current process' netns when creating a new netns. This is not standard
> behavior for most netns sysctls, but it avoids breaking existing workloads.
>
> Signed-off-by: Danny Lin <danny@orbstack.dev>

Hi,

does this allow to set, in a namespace, a larger buffer than the one
in the init namespace?

Regards,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

