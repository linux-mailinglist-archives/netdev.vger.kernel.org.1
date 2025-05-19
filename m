Return-Path: <netdev+bounces-191590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE227ABC5A8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D7B7AF4BD
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE784288C89;
	Mon, 19 May 2025 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2mtNDa2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6794E288518
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675868; cv=none; b=Tg/B6q3SRz7rn/dLjojdzMB83TeqoobUpsxKTDp33TpaRzpe+DdErbpYEDuRtHt11WHNXYu5vbznkLtR/AVs87/ff9W5b3X7vbpRRiAKb3CSkmTLNR5Qgo53Zad7pVeKR7J3Iu7bi3ElS/6n97Nvh2feG2DlRzKtbjJ46Cozdks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675868; c=relaxed/simple;
	bh=9k3rSkCOUuBoGczbRjC9e6BrYoiZJsdyvLLsXOGHPTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOrBT56wX6XsRHHJYqEZ/IFVHbZlU0Rbd6v1yhyDcy+0PINIlLjaOh8cN4gjm3wcOCr6zZeKJzXeklYJcnQ17rb8sAVbXddCptapWjagzrdx188o+UGt8MGBujSmKLWpl+EVefOvk671YrPSa+mgeLKhNOjBJWCdLDowZModR/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2mtNDa2U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231f37e114eso477185ad.1
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747675866; x=1748280666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k3rSkCOUuBoGczbRjC9e6BrYoiZJsdyvLLsXOGHPTE=;
        b=2mtNDa2UCZjQd5G64gKNgvhl/EPIIqYesvKxSqxk/yd9DR4QkGrdBVqUGXgdXIBwrX
         panzXFMmFo222Py+QFlkwUJaYiHleOo0qEfJThS/zYAZptw6HFm7+As7OjcU0KIeiobC
         9ni2HzVPv1rSMkNomYUW9qHF2+76rgX8Oh6WByMEsqiwM9vrjgrdTZdW3+MnixVZGYhL
         uaSQl0Mdx5BSnBGI5onxvmYic/cyEWh4sUeDLcKoMzeWRcsg5Pmy2DsqK1ixq9oChnC8
         J2GZbQ3I6+ORpczhfawUkubTkqrees6WsYwIT3XwAL1hXne/QizzV9zd0hn2ZRsEMz+O
         QCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747675866; x=1748280666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9k3rSkCOUuBoGczbRjC9e6BrYoiZJsdyvLLsXOGHPTE=;
        b=oBwuT5t+obm6uQkb5jvbE31hbBSFZtdt/UaiB5ty+VHqGlzQ+TaQaL8rcoHkt7Nqaq
         0U++sgHTYL5rNx+JyO73gHVrPwJgonM8Bm5+O4oDt2ZDRznemcymhJOyVuzmmfiNdtXZ
         2CzvcN8czPinHj49hAkx1Ee7WNBM6qavQfJ53q72Kz26unfr9Z+edJDYi5921858Yo8r
         VT+ODd3eBqdR1zQ1203aIUa6md6ySua9YTNRqBZKf6u6gZSJZR4rFFKejF/iJPPQNw1G
         ZO+k0NaKeqiSSa/WEUbxQqVFOfH1zwJerdCyUw+KSOa1ZRHwFUR0/+uYPGHzuNytkDvX
         MkCA==
X-Gm-Message-State: AOJu0Yxtip3t4XXNNCRAUh7keP1TLB7yQbfflPDSCRHmzJh5+iRTJpuT
	i2AckcXOObm5sGaxlNtWOZBgLIFYh1+w0nkJqK9GTBOQ7jQQorH9x8arpe5zF+rfZt056Ku2JLo
	WM10U/jE4trh1jSOrjT8uYCiNxZAmwJJAJvxcokmw
X-Gm-Gg: ASbGncvga39KLBOhrf+fJhZWtu4H1Zqag9RhUGZzhbpnXRx4wEON8WVvx601GdAgGHi
	xlgxNNEQjW8LqGjMTjwI+yctd72SqG+50EyVqlUiuKhlI6FL+cTtCkrGuVFqN2QfRWn4aObp7k9
	GMs4eZwk037ugl7vHc+ZStIimT3GPm8yZvPCFSMSo3TWJP
X-Google-Smtp-Source: AGHT+IEEIZ5rIpCccmFXs6TxZYXiYRfp12vQO1P3n/ZqrkCa4SEVdMDrNAx9mJoPegE4qe9PiPx3y2eAjD4yYx4laKE=
X-Received: by 2002:a17:903:2350:b0:21d:dd8f:6e01 with SMTP id
 d9443c01a7336-23203ed3169mr4290135ad.5.1747675866236; Mon, 19 May 2025
 10:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-5-almasrymina@google.com> <aCtNYJo01UfMOLfr@mini-arch>
In-Reply-To: <aCtNYJo01UfMOLfr@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 May 2025 10:30:52 -0700
X-Gm-Features: AX0GCFufj5h-vFrrv9zQxEBaDXmM181og-1BYf2_XB1nm1053kjiQphd_FW10KQ
Message-ID: <CAHS8izOMLm5jLr+778nY0AdFoOWPSb+UV+1sZmOkFb5SSqTGqg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/9] net: devmem: ksft: remove ksft_disruptive
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 8:25=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 05/19, Mina Almasry wrote:
> > As far as I can tell the ksft_disruptive here is unnecessary. These
> > tests are largerly independent, and when one test fails, it's nice to
> > know the results from all the other test cases.
>
> We currently don't do anything special for disruptive tests. I'm assuming
> anything that changes nic configuration is disruptive and was thinking of
> an option to run all disruptive tests at the end of the run. But so far w=
e
> haven't had any problem with mixing disruptive and non-disruptive tests,
> so it's all moot. I'd prefer to keep everything as is for now (or remove
> this whole disruptive category).

I've noticed that if all the tests are marked disruptive, and one test
fails, the others don't run at all, which seems unnecessary. I'd like
to see if the rx test passed if the tx one failed and vice versa for
example. Removing the disruptive tag seems to resolve that.

dmabuf bind is automatically unbound when ncdevmem exits, so i don't
think these tests leave the nic in a bad state or anything that
warrants blocking running the other tests?

--=20
Thanks,
Mina

