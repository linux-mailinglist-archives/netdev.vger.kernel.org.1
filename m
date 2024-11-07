Return-Path: <netdev+bounces-142869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E749C0844
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC09CB2147B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7606212630;
	Thu,  7 Nov 2024 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wr7GaOMa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357491E502
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987979; cv=none; b=QaYaELFY6Nf5650lsUUmtzRF5Cgn84oOJWJNErgSRQuo/Un6SbLNY5hOioYuk8vRJLIVWR1lgqXTl/JV9toK1qVNH9eA8BjxAJrRDkdwsN4ecrx95A9CvXwepaXfpWTUFtYAczcFlLD5S+bDdXAaN6Sj7d9e3lG7fhyRKe6v97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987979; c=relaxed/simple;
	bh=OQLnOEmBaDmsBPtFGs6fvs1NVt7tHuk9MBrY4dFLnhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDQWgDhu4PNVb+kcR7yf1dhGzfFxrkZF4z11807ln7/YgTuxxXMikLg48jS0jGOoIIA8GtiLMwZ1SwSaImY78LkaWCPLDGz+18LJ2+tEFmX7Sm9M3j32GyFhH3iOhDpIArvkV8p88oBagDqIgP1Qdd9tVs2Vfps9VK5cAdo8ix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wr7GaOMa; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb58980711so9514001fa.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 05:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730987976; x=1731592776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjPqhF+YlcQn0yIhmNKRs/DhEwJmEmeP8iLWLpMI6mA=;
        b=Wr7GaOMaAYAJ1NumEbw4IY7fXVLdY6k3FRbDryNGPudP+GFe6PH574ZUEP3F1J3ET5
         qvdNxZKWV1vPjWDEjCW2qBHJNzZY2volY6RpZ7bMlGDyYFeZPp24OyzEy+O/MxdGhLBQ
         OT51vFSysuK8aSYMnClXWh7Hs/5OASk4VQW8TMgP9hwuGhwocAoxV8Pn+VY8JvqOa9l8
         kjyCK/CuoDd5sRu+qE2hGqC0LXFYfnF9feBH22Khq3cuuw57OlawB4wKzyYMtIsN5NlB
         TFXjKGQV4e8pErGMrdAuqCjzlID5ZyQDJg5NeJ80/ZzFmEt50p620pPNUpjuzOOvceen
         8xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987976; x=1731592776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjPqhF+YlcQn0yIhmNKRs/DhEwJmEmeP8iLWLpMI6mA=;
        b=jeUay/Nf1wqr1sSWjI8SxZKntktGaxY0fAp3nNKHjtg66CR8kWb1MlJoojTH6vk610
         buKxq+yUUWKbNPrjs9tj0C7QFZ+03T26Y6EK52lSIgO7O7nF9QqvX241QxSCjYO/wutm
         ZgDwaALFvBuNP1Sft7MJmlDeBlk+fMUB35i27nfyi4gjA36Ktm/PJ5ZTI1XYsZMboJC4
         SfZFDZOwJ5tVdbNuAWlUoP5m19/RzndkysbRr4zW7VMQKopeBlgtQwrbPTpOtWhUk7oK
         leX6z1hk5CH78mYubHzxpCXAkZEF+sfH9L9+b4iRbLFprSljuMSkqySN3s1cGIO4/n77
         x3aA==
X-Forwarded-Encrypted: i=1; AJvYcCXXDQ0Php330DF2OQ9FRWyu97nx6eRLDJunGCRRLK4agZkfgy8d1PwClGi4gB/YiX7mgtzRhaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBEKrAao08JUldN4TP8MZD+h909gnSoWyMq1ta+fEOEzzHtEoO
	M6Kvh4n0OVu234uEhzwbxkwn2SnsmYMUouoWd9dxYdb8qVjdbmeDICHi0rmzZPt6c2xk59T6rCn
	1YFSIsxhqtiIVIpn5wIpdaLDMV9UNBJg1nRbnmw==
X-Google-Smtp-Source: AGHT+IEOhHmLmRUqDNgrDsObWsI4Bps1lbW63qufnLX/1tK5ugJfjlWHaCi62d8USJPOFp5KNIZcOECyI4iQH4ffxXg=
X-Received: by 2002:a05:651c:507:b0:2fc:a347:6d90 with SMTP id
 38308e7fff4ca-2fcbdfe2dcbmr202626861fa.27.1730987976405; Thu, 07 Nov 2024
 05:59:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107214351.59b251f1@canb.auug.org.au>
In-Reply-To: <20241107214351.59b251f1@canb.auug.org.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Nov 2024 14:59:25 +0100
Message-ID: <CACRpkdaxB1APxK_rRFEhcwBw0JZc20YN0z_881_iYVxeKs95LQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pinctrl tree with the net-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, 
	Drew Fustini <dfustini@tenstorrent.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:43=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:

> Today's linux-next merge of the pinctrl tree got a conflict in:
>
>   MAINTAINERS

Thanks Stephen, looks trivial enough but will try to remember to mention
this to Torvalds.

Yours,
Linus Walleij

