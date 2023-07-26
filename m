Return-Path: <netdev+bounces-21567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA45763E90
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664AD280A7C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067061989F;
	Wed, 26 Jul 2023 18:30:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDCC3798D
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:30:05 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDB626B9
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:30:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9891c73e0fbso7740866b.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690396203; x=1691001003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pqzzz+WGHeTgkjEnwwenqQNoyLcS/ky4WeoPGc3iJ2Q=;
        b=HvBE4SHGxe0kK3mWyWpaNsr5zvXfbRehmrUwoj3uztHBKo9R0hb+tv5acR86F9W3VX
         iF20KGD7ZwWJXeHdC5JspdJOznUtmOtLc08Kbp1bcpkE//2UJl83hcA/UCWTNgUIBHH0
         uRXoUHKgmtwd2lffhSMM8aTwNpYpuT9lYNguY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690396203; x=1691001003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqzzz+WGHeTgkjEnwwenqQNoyLcS/ky4WeoPGc3iJ2Q=;
        b=DJ8EHHuGLiN+8LhmGz4hCPNpI5IA7YHigOqSPIuhmFBKoQuB/TNu0bx55JNRIfhl0j
         RFYrd12+YFE/+es8ytGrdyt+BWixCHVndO9gj+JWachp1c2znga2JpLaMIKNpjXH4sLc
         2sRhg5P47GflNrqhVo6eeNNDzXX+uz2atTioWE2dCySXMwrq9Ywgc0SIZCixT2BTcNg8
         NHHfYYEW2/2sZBpP60Bl0ycMR4YcMPocrl3KU8A7mZU7JeZinYPE6llCM9iwZ2D6eY6+
         8Y6eZbK1qel/5lLSQN8qunn8v+lLaeGPjFlCO5CH+aPaCV5BXhkcjg9qBDMxJbSnw+J4
         csCQ==
X-Gm-Message-State: ABy/qLaBdRRUN/w8RqRxi+J79IjMOXYbWH+PJiS4IJafbME6igf96wPY
	6hc9/JcpZNKrERzm6O2l9j6CbemwbtjspeeibLY4Cr9M
X-Google-Smtp-Source: APBJJlGCoLJxsijDiA2Da6Y7jTRxNvwKUAA+9AM2vQL3I74G3SRluEBZ+QOGP3Fz4O9K1YgXquPDzw==
X-Received: by 2002:a17:907:7f25:b0:997:b8dc:30a2 with SMTP id qf37-20020a1709077f2500b00997b8dc30a2mr320353ejc.33.1690396202918;
        Wed, 26 Jul 2023 11:30:02 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906049500b0099364d9f0e9sm9878397eja.102.2023.07.26.11.30.01
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 11:30:02 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so11242866b.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:30:01 -0700 (PDT)
X-Received: by 2002:a17:906:7391:b0:993:eee4:e704 with SMTP id
 f17-20020a170906739100b00993eee4e704mr252853ejl.38.1690396201556; Wed, 26 Jul
 2023 11:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726151515.1650519-1-kuba@kernel.org> <11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
 <20230726092312.799503d6@kernel.org> <CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
 <20230726112031.61bd0c62@kernel.org>
In-Reply-To: <20230726112031.61bd0c62@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Jul 2023 11:29:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
Message-ID: <CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from using
 file paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Perches <joe@perches.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	workflows@vger.kernel.org, mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 26 Jul 2023 at 11:20, Jakub Kicinski <kuba@kernel.org> wrote:
>
> You are special,

So my mother tells me.

> you presumably use it to find who to report
> regressions to, and who to pull into conversations.

Yes. So what happens is that I get cc'd on bug reports for various
issues, and particularly for oops reports I basically have a function
name to grep for (maybe a pathname if it went through the full
decoding).

I'm NOT interested in having to either remember all people off-hand,
or going through the MAINTAINERS file by hand.

> This tool is primarily used by _developers_ to find _maintainers_.

Well, maybe.

But even if that is true, I don't see why you hate the pathname thing
even for that case. I bet developers use it for that exact same
reason, ie they are modifying a file, and they go "I want to know who
the maintainer for this file is".

I do not understand why you think a patch is somehow magically more
important or relevant than a filename.

               Linus

