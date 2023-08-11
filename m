Return-Path: <netdev+bounces-26593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E491778490
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F34281F6D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 00:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD41629;
	Fri, 11 Aug 2023 00:38:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140D371
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:38:07 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111E0211B
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:38:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c0cb7285fso199976966b.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691714284; x=1692319084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NkgHjHcvv02JLA5d7L4Oy9GtZPKfjzxj4synHJJ/uXE=;
        b=bYaKtwd/TgMJVcIGH417oLRnGhU15YTlWNKl77y6xJuM6ET4RvpzElut2U4VLGJ0zu
         QG8wnHvu298UTxVQVBA9G5RQRgNRn4N4cp7ujswe8KxYOf4UqAGTHgq66gdJxkFYOTPx
         EH7atJcXPkg0RYcUL6ls21udZc63PbK1zu0sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691714284; x=1692319084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkgHjHcvv02JLA5d7L4Oy9GtZPKfjzxj4synHJJ/uXE=;
        b=WpeILnyJVeKJ9hyFOml5BfZZZHOhMZUdbrGfUmFcb22WUut7lki4wN/6lm5m4myxMZ
         VPDjF17tI4moXuDDvwXQ7IVsYb048eaA1ug3FcPyKInJBz13QSYji7fJUvA4md4ZM7pd
         m96++v2ukDbjva/2ObmrRlzNSiFHL5x64ciwsOBFzqdxuyAfj2vdMY6q8N/EseU38dyH
         EJGq0fbn4xv/KVfcyFsp+iWnCAfmG0+a8AFlonpc6B5E4h7t/FSMlxoFM0xi5ky5JNoL
         nVa59eRQPNHeEdfAYXSjPk3ExWlZZ3fh4bm8dItKMQlNr/d6Xqnrp0uOsxkSslhEtnSL
         88cQ==
X-Gm-Message-State: AOJu0YxIZ1CSS/bTeIoB4n0N69eaIgjaY0T1b888WgRloT859pKtqdQ2
	Msxahm7tltfosu1RuyrOJQMp48uHuSkdg4gGKWLBiepe
X-Google-Smtp-Source: AGHT+IGnep0ca5YnNdyHJGpijZayQX6mt4xQ1TrLOe/nIO4XXAoOwYhdzwhsQ7yQILs1zKAK+8Nm2A==
X-Received: by 2002:a17:906:5391:b0:99c:f966:9e9e with SMTP id g17-20020a170906539100b0099cf9669e9emr323604ejo.49.1691714284471;
        Thu, 10 Aug 2023 17:38:04 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709062dc800b0099b7276235esm1562675eji.93.2023.08.10.17.38.03
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 17:38:03 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so1811817a12.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:38:03 -0700 (PDT)
X-Received: by 2002:aa7:c446:0:b0:523:4c93:1c0f with SMTP id
 n6-20020aa7c446000000b005234c931c0fmr384315edr.21.1691714282708; Thu, 10 Aug
 2023 17:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809-gds-v1-1-eaac90b0cbcc@google.com> <169165870802.27769.15353947574704602257.tip-bot2@tip-bot2>
 <20230810162524.7c426664@kernel.org> <20230810172858.12291fe6@kernel.org>
In-Reply-To: <20230810172858.12291fe6@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Aug 2023 17:37:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_b+FGTnevQSBAtCWuhCk=0oQ_THvthBW2hzqpOTLFmg@mail.gmail.com>
Message-ID: <CAHk-=wj_b+FGTnevQSBAtCWuhCk=0oQ_THvthBW2hzqpOTLFmg@mail.gmail.com>
Subject: Re: [tip: x86/bugs] x86/srso: Fix build breakage with the LLVM linker
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Daniel Kolesa <daniel@octaforge.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Sven Volkinsfeld <thyrc@gmx.net>, Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 10 Aug 2023 at 17:29, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Are the commit IDs stable on x86/bugs?

I think normally yes.

> Would it be rude if we pulled that in?

If this is holding stuff up, you have a pretty good excuse. It
shouldn't be the normal workflow, but hey, it's not a normal problem.

As I mentioned elsewhere, I hate the embargoed stuff, and every single
time it happens I expect fallout from the fact that we couldn't use
the usual bots for build and boot testing.

All our processes are geared towards open development, and I think
that's exactly how they *should* be.

But then that means that they fail horribly for the embargoes.

Anyway, go ahead and just pull in the fixes if this holds up your
normal workflow.

And if we end up with duplicates due to rebases (or worse yet, merge
issues due to rebases with other changes), it is what it is. Can't
blame you.

              Linus

