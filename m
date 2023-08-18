Return-Path: <netdev+bounces-28708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D578053D
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 06:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB77A2822BB
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 04:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACB311CA7;
	Fri, 18 Aug 2023 04:59:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8B965E
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 04:59:11 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B2235BD
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:59:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so3441542a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692334748; x=1692939548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IbnlWB7AtC2a2bEKPJCs9bv9rfX3lG0Fd+mTh2luRKU=;
        b=eQ64rGqbgkqXejGtmQMxz6nvW1OUKRjlcO+yC8W/lFlG+SVXRBB2SZ6hyHCTz/8lR2
         lf0LxdQSQPNX7qe+wOs75cE9+j9/szRZTuZL1vZ7FaB+2p3XT20QRW8fhYtGQNZbzMrk
         M3WR1Gt7fQ/sEZS+6DTEUYre5RFvsrCc61woc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692334748; x=1692939548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbnlWB7AtC2a2bEKPJCs9bv9rfX3lG0Fd+mTh2luRKU=;
        b=N4YyZkmHJ5xa+JXvRLchlgmmbPIsL32D/uAEc2BFjxaXQG73OVOoPGJjXY582z2vmR
         U/LGjhmb62df3hwa5oeV31WXlLPqqw/kSueZfd6d9VNYaka0xTi45ZHnw223Sx977ezX
         QnrT5QXvMaKE+U9w4ZK2g63+MglPYN0Y+gxffDPAGyevKAe6/ac80b41G1ul9fvwCEeq
         saRGCSNRccgkup+4jsXtov1cuQt+SU1Llko2/HfzozkaU8O38zGS1pvDFQYLx7YR44Uq
         oP/cJz+bqkf/uCaRJyL0oIUWjRudZ2UJihgdA9z32iUGAlTbed26lTT+7b14tAdJYue2
         5JQQ==
X-Gm-Message-State: AOJu0YwCUkL5kRjKh30BGv5bHDz9CjzJdkwctm7qocqOLvAdOdTkTJ98
	9IKif8igNK2rFkImExf3t9w/H21OxMagd//nzSG75gKN
X-Google-Smtp-Source: AGHT+IGI7ZdjPQpgmwIToFk7l7cDC+1RtH1j9S8TEu8Shbo5fXfOmzeHvKgvn9tF1MJJOBt+qlDBkg==
X-Received: by 2002:a17:907:7851:b0:993:d632:2c3 with SMTP id lb17-20020a170907785100b00993d63202c3mr1499997ejc.21.1692334748227;
        Thu, 17 Aug 2023 21:59:08 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id l16-20020a170906415000b00992bea2e9d2sm694859ejk.62.2023.08.17.21.59.06
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 21:59:06 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so110847766b.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:59:06 -0700 (PDT)
X-Received: by 2002:a17:907:7851:b0:993:d632:2c3 with SMTP id
 lb17-20020a170907785100b00993d63202c3mr1499942ejc.21.1692334746234; Thu, 17
 Aug 2023 21:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230817221129.1014945-1-kuba@kernel.org>
In-Reply-To: <20230817221129.1014945-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Aug 2023 06:58:49 +0200
X-Gmail-Original-Message-ID: <CAHk-=wi-DdiZu-zMfE3X5nx4i5farupHmJawz-My_Z2nk9Qkow@mail.gmail.com>
Message-ID: <CAHk-=wi-DdiZu-zMfE3X5nx4i5farupHmJawz-My_Z2nk9Qkow@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.5-rc7
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 18 Aug 2023 at 00:11, Jakub Kicinski <kuba@kernel.org> wrote:
>
> The diffstat is a little massaged here, it's generated from the merge
> of x86/bugs, I merged x86/bugs on top of our previous merge point, and
> you already have those, so I _think_ this is exactly the diffstat
> you'll see when pulling..

Indeed.  Thanks.

> Fixes to fixes:

Heh. New header for an old problem ...

                Linus

