Return-Path: <netdev+bounces-105349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FA49108B1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491A61F23A7E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1082719B3E1;
	Thu, 20 Jun 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+w2N4id"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFD42ABA;
	Thu, 20 Jun 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894690; cv=none; b=GHf0V2BGcmH7jSMA1AKX+IjDniwWQXkL9+ZvPMAZiEum96xi9u+H2elH2J2z/e8fz7jZs0o9j3xl5uQaheaCNn/8sxXWhdkF660LNWYGltWBRJS5WOAlmanEXjIQGslyceTRatGaJpf4OBhucw9UKKxJOHRxj3jUQE4diD96SHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894690; c=relaxed/simple;
	bh=8iQO6Emy2tRVwzuEDA/kchE+iTXyfAsBpVBTDwQk+20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hplbC0UUBL3/tin7r6Dpp2qSmdAOoUvjjA5H+SNuUQilZyycM3bZvWvOe5O2jo9PqXX87wuTjiHXNJhF3TtoIwWUk4az453AKe6fvE1YzrIa9fF+paDu9F1SyGONyPU4NYh4cFLELLx7rYRFh6HXfgG4ucYGizqzmsGOrQMMdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+w2N4id; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso10445211fa.3;
        Thu, 20 Jun 2024 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718894686; x=1719499486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LKx+R33v9q2HX/fanb0Z4m7vD2boYqK/YJS3URbx8w=;
        b=g+w2N4idUT2fjibYIvPzATzVGv+EesjbgxcSouwmvwa2soD9yX1Th5JM+jkt5Vx9P/
         6Dk/lwUcT3DV1KUQAtoLmJPOGfKhazv0C2EQngwzL0/NttgvubYuRJuVn4Dwk/ByPEqN
         ISVEA1le0aOn/IilW1IpFPZZ0CUaDuEBjRLwqnqpkHJccxJhrTbhTtoD6KwjIiV8MiVO
         YoqJb1kJQShMXc6vyadp51iHNPrwj2sa+zkfxeWLn39s3+65tEQmLgo/I+5NvTGIto3j
         OPk568TVUw/jUpi8UHOcuS/o3oZNj07M8pNYcMzb9GCX/mJlfm4D/cUVRGMWy/cHV7/6
         u7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894686; x=1719499486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LKx+R33v9q2HX/fanb0Z4m7vD2boYqK/YJS3URbx8w=;
        b=SJy2xO3iR/iWu4LpMRYfLdoZkm9+dQVnVcvuKiCao0A9tiBw6Q6XfaU3c8eqjY2L5D
         ZYIbfY0SH5dwctqtG9hT6o7PY5mMJHfSqhLD5EYMdcQJWb5/cyvd8XmwrlFsAOFrDhFg
         LBUn+cM1s8USgVFQdUH1obbR0Jx4AYJcUCUfjmSeydfRTaTN/7UuJ7nL2//PKLMyjGpF
         qCbAMom1HCtBOkEOpx3DuWAggdJLXiR/1oPHfMVjfAQ+IBncvKxnNw3toBtpuoInhut0
         eUGDexXzSZ7EBx6iBZpH1Z6n3QyBfdUCUlF6bi8GtypZmvhQpGZsdpsUaydTayLiWNmE
         YpZg==
X-Forwarded-Encrypted: i=1; AJvYcCVEvuG6LThhci4Kr4Xg1BGI+hs2Kdp+Ys8disLiVDvzfzWdofNaAbx5M22Te+jjrK/RnMlAzVENotiqqhxcfr4/cVm7U79kmy/HZwXA5bQc1DSjHc8rx8W5tdLsObc8f+BV8v8CTdaAvl0dQvHSKYBu81O3hmZ5FkWla3ewPTb7gLqJfmQbhgGfZrU2T/j7nnFBzFd8MSXK0O1XWQ+bph3OWA==
X-Gm-Message-State: AOJu0Yxiq/3NabxVTzi8VayyY5jUk2PD2iTbc4FlQ0OwvkS+4YtBQH+U
	R6boXMMuqbmanpCxjaXkcskHnTTOc7gH4UyO0OWdsEmjruoFTUSk9+akrWWcSu7GBbnctyR7GP8
	XhoYpx/kg11kXoNN/t6wqfy+7qBhPaA==
X-Google-Smtp-Source: AGHT+IFGt5VFR6NbS7vC8yOPohi01Zz2iGk0PJPFzYYvy0RDy+DrDiBt0qqDTV3QQD7ZUMTNRB5WaHWxcskX5F6+xKY=
X-Received: by 2002:a2e:8086:0:b0:2eb:ed3a:9c65 with SMTP id
 38308e7fff4ca-2ec3ceb6b04mr34150741fa.15.1718894686390; Thu, 20 Jun 2024
 07:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612075829.18241-1-brgl@bgdev.pl> <171889385052.4585.15983645082672209436.git-patchwork-notify@kernel.org>
 <8d6af7e2-76f8-4daa-a751-a1abe29af103@kernel.org>
In-Reply-To: <8d6af7e2-76f8-4daa-a751-a1abe29af103@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Jun 2024 10:44:33 -0400
Message-ID: <CABBYNZJ5z91HExR-dkwrEPoF1pEGbkAP0X6tpftEGz-kd7vdsw@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable tag between the Bluetooth and pwrseq
 branches for v6.11-rc1
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: patchwork-bot+bluetooth@kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, marcel@holtmann.org, 
	krzk+dt@kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bartosz.golaszewski@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Thu, Jun 20, 2024 at 10:35=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 20/06/2024 16:30, patchwork-bot+bluetooth@kernel.org wrote:
> > Hello:
> >
> > This pull request was applied to bluetooth/bluetooth-next.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >
> > On Wed, 12 Jun 2024 09:58:29 +0200 you wrote:
> >> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> Hi Marcel, Luiz,
> >>
> >> Please pull the following power sequencing changes into the Bluetooth =
tree
> >> before applying the hci_qca patches I sent separately.
> >>
> >> [...]
> >
> > Here is the summary with links:
> >   - [GIT,PULL] Immutable tag between the Bluetooth and pwrseq branches =
for v6.11-rc1
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/4c318a2187f8
>
>
> Luiz,
>
> This pulls looks wrong. Are you sure you have correct base? The diffstat
> suggests you are merging into rc2, not rc3. This will be confusing in
> merge commit. It is much safer, including possible feedback from Linus,
> if you use exactly the same base.

So you are saying I need to rebase? I usually only rebase when it
comes the time to do a pull-request using net-next as a base since
that is where bluetooth-next normally lands.

> Best regards,
> Krzysztof
>


--=20
Luiz Augusto von Dentz

