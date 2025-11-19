Return-Path: <netdev+bounces-240083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BB6C702C2
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 10B21241CD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0953935FF44;
	Wed, 19 Nov 2025 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zQKN4TkC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96778357A3C
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570630; cv=none; b=RcrcmWf3Zcz55Jjl1Ooom5zu12p28I4iQvj7VD8espe8BdrSWYJZzG7Q2fA8yrCs73FFxC4w5w6Eu15U9+ZVlObA2YlLXOdfKhwbMtI1SWpHl86scg2I0oVcvOgXOVWpKttMv8cNnIc4K7TcPcbhNy2BqMp+dNvOYIKAeKSkES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570630; c=relaxed/simple;
	bh=Yg4h9ZoBZSf2fN80/wI58wieYZU0OhcEWmfDkoRo8WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJ9pqE7/Ysei2Oj653zWkMVHDuWciS6AuYUllt0Pf6whCDSNvB4Di2FMDlb0FDENE4SOWVJaUIRkLNYasFQwNnU64jYB7ZBJ2OLiRPEXNpLfSd8RpmD/Fr2tsLaYZPdL5xkhEhOsSDsIp8+JRVKGn6cHttinOWxe+vuiijM9JQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zQKN4TkC; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ed67a143c5so404181cf.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763570627; x=1764175427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjksBMQXAoENtPtwnuRcbD+3/S2W5wgjkf6h7aFT+ko=;
        b=zQKN4TkC4KlZPjefVY0ngY5R8jAIc26/QPXXnOevudHXG3mB9lD/0IDUcj/LwpYH5t
         5yDqg4Dlg6V3effA0tYQ3U2GA+czv/SXKtXi4dvOdWt3Q6GSHS/MoCrIrBJ5ThuEjNjx
         3faw+iFz+f/pSaH83N/eiGmJYee02sLaDz2pUDz3CRkTGFimrmg7ZGn9JQ3vCrLEuFoU
         xbEhCD8VodyZWSG3WbVmk2EmVyCkQ63UU7Zw+cg18vkIsiJsEPvElTtcfZHlox0bMe8N
         t2+U8+avMS/nnb43ZYFOOwqM17Yudfkj2oNWG5GL0Hz6mnuAqaeb1p4POXxdBCzeGDCu
         +htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763570627; x=1764175427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjksBMQXAoENtPtwnuRcbD+3/S2W5wgjkf6h7aFT+ko=;
        b=Fzg1VsKmbPXVuWAPNmnU89/fgCbareY+dge6h3nXQQwT8WbVZR2NuCj9GoPiDGbppv
         N3fis4t8QHJ2r1AOan7ZfORF12t0v7kSTPNDObhorwtybABKKviuUdDuv5S4ca3AOpQC
         tTBZTdLs/LJE5GnBoHnds+KPLeqG+7pi7ktp39MT6AUXHvg5+/JxirpCoAxNYFVd/m5/
         q9WKoy8gB+7ryklJQYd1uR+0puUTvUs1P6a1XlQKibszA0AvruTa79fn0gX0sVE/jSad
         ml331I5tg2lMHR9NPP6kPdCZVqoAs+vORIeJOgVEizVzr4PfHKygZ9gQZSmcJ1fMgFKC
         hbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUReB8VvaMFJJdcrfInJDv7df5zEn/R/QdRXCcCyxo933XfGo4K8Cu/z43f+d4MZakn6VBwR7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5fftginuLyYTeLl52wKWf3eBgJ7tu6iljdcXGn89r2Rm9Lsb
	MC2j+dm1CL1sccVhJ0+S1LBALNjcYIUaf9ZvpDLyZZBoTA+Qh7FiaS3lo2XfBehsSJmcJx7+een
	XIDyxGrs2iMmoeO+a9hKkGU/G0m09BjbCJnxIKEz1
X-Gm-Gg: ASbGncsw2ovIcOAzmBpU63wk9/59vRetWIIZlPW2GrjmupvzUsTWtFjZTwHhwo0N7y3
	qW2yNUJoPy+HIRAmTPfBaaTY4ww6vr4l5FTBu/ZwNwIPqUWlVafGgFLCLINC3JgCKn+I5V5bIfz
	IhImz9BT2cMNuwJUlOgBJfOM+/SVXnxOHad0FMWXdzFLQ/dWsuD3mYc770cdwwjbkfYurFPxMNl
	yZR15RT71f0iWo8IBqh70jmc75kAP6vQlu4we0EdUGX4lyzrzYiprBLMpcfhKrBsKg5anbsU/bW
	/G4om9clrfbU5I9GBT2VvO7mvEJQWHfl1q4ShHEyYZaZdnpSLh5zQq1QnrA2uxqX48z2ZA==
X-Google-Smtp-Source: AGHT+IGbIdbiWHak8Qxlz9ydWi/6aEOw4I9OPmNoBQO/qVTPeKatu3hvfjPA+9PbfkMYL+SK3kTAkbMYIyMqcDs3aJ4=
X-Received: by 2002:ac8:574d:0:b0:4ed:5f45:447c with SMTP id
 d75a77b69052e-4ee3eac377bmr7812151cf.6.1763570627276; Wed, 19 Nov 2025
 08:43:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OS7PR01MB13832468BD527C1623093DDDA95D7A@OS7PR01MB13832.jpnprd01.prod.outlook.com>
In-Reply-To: <OS7PR01MB13832468BD527C1623093DDDA95D7A@OS7PR01MB13832.jpnprd01.prod.outlook.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 19 Nov 2025 11:43:30 -0500
X-Gm-Features: AWmQ_blOdp8vvqwNojTplDWjPeljVaHkP1Suj8amqzq8fR9a2fs9MXvaDMljVnY
Message-ID: <CADVnQy=4BRX-z97s2qnNjLDSOr5hce4x6xknaySy6=Wrpjhn1A@mail.gmail.com>
Subject: Re: [PATCH] tcp:provide 2 options for MSS/TSO window size: half the
 window or full window.
To: "He.kai Zhang.zihan" <hk517j@hotmail.com>
Cc: edumazet@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 11:30=E2=80=AFAM He.kai Zhang.zihan <hk517j@hotmail=
.com> wrote:

Please read the following before sending your next patch:

https://docs.kernel.org/process/maintainer-netdev.html
https://docs.kernel.org/process/submitting-patches.html

Rather than attaching patches, please use "git send-email" when
sending patches, with something like the following for networking
patches:

# first check:
./scripts/checkpatch.pl *.patch
# fix any issues

# then send:
git send-email \
  --to 'David Miller <davem@davemloft.net>' \
  --to 'Jakub Kicinski <kuba@kernel.org>' \
  --to 'Eric Dumazet <edumazet@google.com>' \
  --cc 'netdev@vger.kernel.org'  *.patch

On the specifics of your patch:

(1) Can you please send a tcpdump packet trace showing the problem you
are trying to solve, and then another trace showing the behavior after
your patch is applied?

(2) Can you please provide your analysis of why the existing code in
tcp_bound_to_half_wnd() does not achieve what you are looking for? It
already tries to use the full receive window when the receive window
is small. So perhaps all we need is to change the
tcp_bound_to_half_wnd() logic to not use half the receive window if
the receive window is less than 1 MSS or so, rather than using a
threshold of TCP_MSS_DEFAULT?

thanks,
neal

