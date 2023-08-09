Return-Path: <netdev+bounces-25958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7C776499
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BEC281CDD
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F871BB4C;
	Wed,  9 Aug 2023 15:59:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831F18AE1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 15:59:49 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09381FF9
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:59:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9a828c920so106361411fa.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691596778; x=1692201578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pKgMv/zwB6Y77QMgXunD2xiaajtdokS/KsQJJ/MXzU4=;
        b=XLXtDjfocJ7lke8vKhvyI+xMWdTMPJVgoWaglonOxPQXd+unHG1ror48w1ygDqAyWL
         5BEuBdyiAJpedrqkR2VE4QwC8ZezQlek69jokqkQ9SFCWuIbITCuxVESSfJDC1Ro8c9V
         yajuQsA8F+xAspp+gAsA0G3OUXJPDZIRKseVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596778; x=1692201578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKgMv/zwB6Y77QMgXunD2xiaajtdokS/KsQJJ/MXzU4=;
        b=bLs2d1EGf5APNMVDSjXptTW/P8pvOD9DP1EiAzqCrzRGEZx01W+C/7wgSC71ZPo+v8
         IPpuyochyt94f+WHh8w7lOIPUCDqpb85woKnmGSIJZgTc97J+95QefPv5gKzUkQA8zJp
         O6nx63Og79QhiJ6DjrsUcAzYlAGsYIoXpTs2vpuMD8fd7fVVe1fjnKpJ9dgROO1JVa9r
         h2mjKwoEa7nuD/aPCnAuB00RcNgvhWzngRk+T3ZUsABRn77QwPAWViQ5qZ6X3IBQNU+J
         bF0kKsoD92IR0Clt/b9PrMUY6LLgps9NmWMjjXzwHXzzQaFSvF4XCFzl74BuAwhTcQNs
         hriA==
X-Gm-Message-State: AOJu0YypbLWvh73L9n7kp1pBMWOb0E6m5K0TlWI8WgoKc3p+6RKVoXFG
	fXiz+XFM78HGrz0tS4+Vziy5lHLZzcBjnkTVGuBt4ESQ
X-Google-Smtp-Source: AGHT+IH5aK5VkWeBJ80loD3IrRZ1WtcHL7oM1pUCehozf6QDeE/b0fmwovb92Sl+h4QnKeEaf2KglQ==
X-Received: by 2002:a2e:3c18:0:b0:2b7:3b73:2589 with SMTP id j24-20020a2e3c18000000b002b73b732589mr2171801lja.32.1691596778557;
        Wed, 09 Aug 2023 08:59:38 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id bw5-20020a170906c1c500b00988f168811bsm8248276ejb.135.2023.08.09.08.59.37
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:59:37 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5233deb7cb9so3976066a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 08:59:37 -0700 (PDT)
X-Received: by 2002:a17:906:5350:b0:992:d013:1131 with SMTP id
 j16-20020a170906535000b00992d0131131mr2505461ejo.52.1691596777526; Wed, 09
 Aug 2023 08:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87edkce118.wl-tiwai@suse.de> <20230809143801.GA693@lst.de> <87a5v0e0mv.wl-tiwai@suse.de>
In-Reply-To: <87a5v0e0mv.wl-tiwai@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Aug 2023 08:59:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGV61xrG=gO0=dXH64o2TDWWrXn1mx-CX885JZ7h84Og@mail.gmail.com>
Message-ID: <CAHk-=wgGV61xrG=gO0=dXH64o2TDWWrXn1mx-CX885JZ7h84Og@mail.gmail.com>
Subject: Re: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 9 Aug 2023 at 07:44, Takashi Iwai <tiwai@suse.de> wrote:
>
> The remaining question is whether the use of sockptr_t for other
> subsystems as a generic pointer is a recommended / acceptable move...

Very much not recommended. sockptr_t is horrible too, but it was (part
of) what made it possible to fix an even worse horrible historical
mistake (ie getting rid of set_fs()).

So I detest sockptr_t. It's garbage. At the very minimum it should
have had the length associated with it, not passed separately.

But it's garbage exactly because it allowed for conversion of some
much much horrid legacy code with fairly minimal impact.

New code does *not* have that excuse.

DO NOT MIX USER AND KERNEL POINTERS. And don't add interfaces that
think such mixing is ok. Pointers should be statically clearly of one
type or the other, and never lied about.

Or you go all the way, and do that whole iterator thing, and make it
very clear that you're doing something truly generic that can be
passed fairly widely along across subsystem boundaries.

             Linus

