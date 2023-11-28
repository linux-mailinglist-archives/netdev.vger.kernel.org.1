Return-Path: <netdev+bounces-51876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A97FC9C5
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542062830CE
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 22:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3A1640C;
	Tue, 28 Nov 2023 22:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XrgSoy+K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD14719B1
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 14:44:02 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d00689f5c8so7745415ad.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 14:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701211442; x=1701816242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAa4aZwEAz/pdNTEjQNN1fkhZj4LqrtvUzLeLg+TUjQ=;
        b=XrgSoy+Kqi967rwb1fdg3Zn2SabPnu/rzrPynnuGGNJNKNa33MmWyZdA7pPRbj+9N2
         0UFbKtfYSW80eE89e4RCP5CUDtoKq2B/OJw9Q93yYw+zAF1PxU4bpqwKLlHvf0UteW8L
         QW0t+Vwl461LCuzGqlk99BSWvt/Ctcjk5wjr0mkAgcD/lRB/3WqkesMa9tBzvcJy5Xey
         66/oMNT/rSYjr2QnFY/lzGh28gtGvaGM9BhiQTt6F3j23cTJjNu2puBIT5sOC26mN6H9
         Ct1XOUBaf35NLzWv/TDGBby6diIL0JMaM77vYBJlkpZJx/RyH+WxdeQ4ivPWQmf/6p6C
         XgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701211442; x=1701816242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAa4aZwEAz/pdNTEjQNN1fkhZj4LqrtvUzLeLg+TUjQ=;
        b=pKNkfVJdb1DZqC0iRA4Hri4PINa/NA/Vz/Jm3mPmQYpZpHj/MkRaVOwvn1LyQEFAQi
         l6+L73yf9B+9uYF8G1klMa/+O47UHMHfBuJs9CvJpiHr3stDH+kns6BJpK8XPK0hj3AG
         k6p38lcO3qks9HedHWf8zbgNFDB0CuaiKelNqO7MnZlOwQBwL5gp4Tqwnc0XlifnuUx2
         O9nIl1pH/UVk/+RWokx6W6v7DAFP3KXkNztVXTqsNMCCaEalzVbSCSvHMlDYUrzsnoPz
         5DEFLrd3Xx971Bam3qnrsR8Fzw8XwcXIGR+3DyWg8EYtEYuMejtdvmpGubCOoVeORsMF
         5EhA==
X-Gm-Message-State: AOJu0YwYm7kp/k91UQuWoPkgpN9w9gglFZAfBoFlFgJxD0+kC7ESfPWv
	ZCBTnDN2wbARaJ1zZAxkRxgb4NBi88R/gLHAIDE=
X-Google-Smtp-Source: AGHT+IEp/UvTapmKEkhyW74XCwAR+Bmlh06wJ7uxkg7nOq07xAkhXwCFPhVlUBwMe+TFnVUN4OR/VA==
X-Received: by 2002:a17:902:e80e:b0:1cf:daca:2b5e with SMTP id u14-20020a170902e80e00b001cfdaca2b5emr7984404plg.38.1701211442035;
        Tue, 28 Nov 2023 14:44:02 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ce9200b001cff026df52sm2322407plg.221.2023.11.28.14.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:44:01 -0800 (PST)
Date: Tue, 28 Nov 2023 14:43:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Quentin Deslandes <qde@naccy.de>
Cc: <netdev@vger.kernel.org>, David Ahern <dsahern@gmail.com>, Martin KaFai
 Lau <martin.lau@kernel.org>
Subject: Re: [PATCH 0/3] ss: pretty-printing BPF socket-local storage
Message-ID: <20231128144359.36108a3d@hermes.local>
In-Reply-To: <20231128023058.53546-1-qde@naccy.de>
References: <20231128023058.53546-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 18:30:55 -0800
Quentin Deslandes <qde@naccy.de> wrote:

> BPF allows programs to store socket-specific data using
> BPF_MAP_TYPE_SK_STORAGE maps. The data is attached to the socket itself,
> and Martin added INET_DIAG_REQ_SK_BPF_STORAGES, so it can be fetched
> using the INET_DIAG mechanism.
> 
> Currently, ss doesn't request the socket-local data, this patch aims to
> fix this.
> 
> The first patch fixes a bug where the "Process" column would always be
> printed on ss' output, even if --processes/-p is not used.
> 
> Patch #2 requests the socket-local data for the requested map ID
> (--bpf-map-id=) or all the maps (--bpf-maps). It then prints the map_id
> in a dedicated column.
> 
> Patch #3 uses libbpf and BTF to pretty print the map's content, like
> `bpftool map dump` would do.
> 
> While I think it makes sense for ss to provide the socket-local storage
> content for the sockets, it's difficult to conciliate the column-based
> output of ss and having readable socket-local data. Hence, the
> socket-local data is printed in a readable fashion over multiple lines
> under its socket statistics, independently of the column-based approach.
> 
> Here is an example of ss' output with --bpf-maps:
> [...]
> ESTAB                  2960280             0 [...]
>     map_id: 259 [
>         (struct my_sk_storage) {
>             .field_hh = (char)127,
>             .<anon> = (union <anon>) {
>                 .a = (int)0,
>                 .b = (int)0,
>             },
>         },
>     ]
> 
> Quentin Deslandes (3):
>   ss: prevent "Process" column from being printed unless requested
>   ss: add support for BPF socket-local storage
>   ss: pretty-print BPF socket-local storage
> 
>  misc/ss.c | 822 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 818 insertions(+), 4 deletions(-)


Useful, but ss is growing into a huge monolithic program and may need some
refactoring. Also, this cries out for a json output format. Which ss doesn't
have yet.

