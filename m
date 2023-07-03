Return-Path: <netdev+bounces-15017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6906E745469
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 06:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B9E280C5F
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 04:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CB6644;
	Mon,  3 Jul 2023 04:12:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA0625
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 04:12:18 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8894B180
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 21:12:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6a662b9adso57887961fa.2
        for <netdev@vger.kernel.org>; Sun, 02 Jul 2023 21:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688357535; x=1690949535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qBnUTmfwj8DTmLsYwNeO+K9GBJ5hWqy0KG0bHBi8Ysg=;
        b=ZB+I5tnGi707l4ssSNWkCL2Ur3x6+YGIFZCnV3Cpo+/WAksrMxR3fXHedwh7X4Rv/N
         yL/QwxyoWBenrpWBsntqK3SSp86RrXYS3QfxBvO+Fq/Du/++ZQpm713V9iAviEadjpHY
         REtR+d8pifaI9Hd1iKQHDGyV/PrjODiCZ6xQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688357535; x=1690949535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBnUTmfwj8DTmLsYwNeO+K9GBJ5hWqy0KG0bHBi8Ysg=;
        b=l9bLDskZx8vctXIUTxI6sfRuk9PirHmONmA00vlg0bIdBQ8g2dvZenvWsWTyujcnna
         8daOcMLy6uQsg4GB8/4JXJIcCF4QwpQLNbqTbLId4ZwmV85XanPB2ZkwroLF9h+bJe7x
         yatplYHQOjNGRrPJo/YLBN/D0SoocHCXeDqOeBIqKHJ3Xj65GAMT1P0uoEuAW+wyHg+g
         W00aIlbfePrb6u0HSog+WaoPNrQlvXL3NlAxBviUx2Wu0tkczm8OxxYG5Veb/wWV7oJT
         JgIAl9HWzbUB1Vc/FC1zsLF0mIib7Vnfa+FtMIoCm+q2pKhXUkBTECbzzFri9n958tVd
         L/ng==
X-Gm-Message-State: ABy/qLbJBs4g5vvR8/mcG6fSBkRBZB8UIhbFNLa264xYl7t85qZAeEzi
	SdSk0rO0yjqarXbPJ87WWjxuU91Qa9eG7N8K0CflxjFH
X-Google-Smtp-Source: APBJJlFNt5IVh+rND6ZjAgtbdY+3NDM43Amo7GphrTy+LmESaWpL0N+IgiKW4cYxUrPM3SwkyYNQXw==
X-Received: by 2002:a05:6512:3703:b0:4f8:7551:7485 with SMTP id z3-20020a056512370300b004f875517485mr4515352lfr.5.1688357535515;
        Sun, 02 Jul 2023 21:12:15 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056512488700b004fb79feb288sm3370539lfb.152.2023.07.02.21.12.14
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 21:12:14 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b6a16254a4so58162671fa.0
        for <netdev@vger.kernel.org>; Sun, 02 Jul 2023 21:12:14 -0700 (PDT)
X-Received: by 2002:a2e:95cc:0:b0:2b6:be6a:7e1b with SMTP id
 y12-20020a2e95cc000000b002b6be6a7e1bmr5153385ljh.49.1688357534559; Sun, 02
 Jul 2023 21:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703012723.800199-1-Jason@zx2c4.com> <20230703012723.800199-2-Jason@zx2c4.com>
In-Reply-To: <20230703012723.800199-2-Jason@zx2c4.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 2 Jul 2023 21:11:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgStQOQ+rG1EQ_GczUbPQ3Tv39Eve=_39agf-jvyfZV6Q@mail.gmail.com>
Message-ID: <CAHk-=wgStQOQ+rG1EQ_GczUbPQ3Tv39Eve=_39agf-jvyfZV6Q@mail.gmail.com>
Subject: Re: [PATCH net 1/3] wireguard: queueing: use saner cpu selection wrapping
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Manuel Leiner <manuel.leiner@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 2 Jul 2023 at 18:27, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Using `% nr_cpumask_bits` is slow and complicated, and not totally
> robust toward dynamic changes to CPU topologies. Rather than storing the
> next CPU in the round-robin, just store the last one, and also return
> that value. This simplifies the loop drastically into a much more common
> pattern.
>
> Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
> Cc: stable@vger.kernel.org
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>

Heh, thank you. Your memory is better than mine. That "Reported-by"
mystified me, so I had to go search for it.

March is clearly too long ago for me to remember anything.

I'm like a goldfish.

              Linus

