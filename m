Return-Path: <netdev+bounces-21581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD630763F1E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71E01C211A9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB044CE7A;
	Wed, 26 Jul 2023 18:59:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B37E1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:59:25 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3600B19A0
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:59:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fdddf92b05so194603e87.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690397962; x=1691002762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ltB90dbZBs9x2w+zTel/ot+HALu1Ht+7bi6jGbPAdk=;
        b=H2XJWiCoD7KhXfeojnRimRKEFZc2C/9H5g8aJ4i1DGkWQVukNSDP33l4XgAR3Vr9q7
         CJG0DYnu+674+LKE0mfCHvAvLMZ75UrdhRTrU30CAglnbvmOv3qyb0iWgsD8pTXPDOrc
         xxd3Gpjakobk15VI731GXxslOpbzWfz+pyo6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397962; x=1691002762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ltB90dbZBs9x2w+zTel/ot+HALu1Ht+7bi6jGbPAdk=;
        b=IY0sqgEY/Ru90RRyHPWdjmHr2nBbe1NokE5LNCn7dMMDGa2+vQ08K2qDv3HFNLkPkU
         U2bqynCdLmdgY5QcQCNsZVXqaZCASkBxN8px8sk2b/z0nwDFZpC4AwTYxIPyX4uxBX8R
         E8FRwtm6mk6QTq6RzF7ga0I7ulTwF9WWAudAsH/RfJUBfPVzN1zQ3o0UeBhBLUNJI1jd
         zUPcb7WPDW5XjiFoxUv+KIPWEnO2r5HCf/kvEB8F1vW5FQygFPnzq5o3wdB/BqehaER/
         17a4gpcXOmc236QTpu7jJrhdKcpqdS1kQqLcaBn4XscmWdRVzUtb7ak4swd26McCXPr6
         vVUw==
X-Gm-Message-State: ABy/qLYtk9l/rJsZJxMWnSXoqj+Oi1EkkzncKDsCx2Sg7CCflbp6qqdJ
	8SPFoCplTKSb0U/jtX61Ed+D2H8Dp13YCYzn3XTQO9hy
X-Google-Smtp-Source: APBJJlHXO219Q7wGMqNvO1K1mXORyfeghhPBpQLZUPP5AjyTylvUI3APa5wIdkDd0BCB8CemImLuSA==
X-Received: by 2002:ac2:4c93:0:b0:4f3:b708:f554 with SMTP id d19-20020ac24c93000000b004f3b708f554mr25015lfl.47.1690397962334;
        Wed, 26 Jul 2023 11:59:22 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id n7-20020a056512388700b004fb9d7b9922sm3429540lft.144.2023.07.26.11.59.21
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 11:59:21 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b97f34239cso887041fa.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:59:21 -0700 (PDT)
X-Received: by 2002:a2e:9510:0:b0:2b5:9d2a:ab51 with SMTP id
 f16-20020a2e9510000000b002b59d2aab51mr1859153ljh.5.1690397960827; Wed, 26 Jul
 2023 11:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726151515.1650519-1-kuba@kernel.org> <11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
 <20230726092312.799503d6@kernel.org> <CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
 <20230726112031.61bd0c62@kernel.org> <CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
 <20230726114817.1bd52d48@kernel.org>
In-Reply-To: <20230726114817.1bd52d48@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Jul 2023 11:59:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuR7_A=PbN8jhmqGPJQHypUHR+W4-UuSVhOVWvYXs1Tg@mail.gmail.com>
Message-ID: <CAHk-=wiuR7_A=PbN8jhmqGPJQHypUHR+W4-UuSVhOVWvYXs1Tg@mail.gmail.com>
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

On Wed, 26 Jul 2023 at 11:48, Jakub Kicinski <kuba@kernel.org> wrote:
>
> We get at least one fix a week where author adds a Fixes tag
> but somehow magically didn't CC the author of that commit.
> When we ask they usually reply with "but I run get_maintainer -f,
> isn't that what I'm supposed to do?".

Bah. I think you're blaming entirely the wrong people, and the wrong tool.

Your complaint seems to be "we got a fix, it even says what commit it
is fixing, and the tool that the person ran didn't add the right
people automatically".

And my reaction is "I use that tooling, I want it to do exactly what
it does right now, why are you blaming that tool"?

You're already using 'patchwork'. Why don't you instead go "Oh, *that*
tool isn't doing the right thing?"

                  Linus

