Return-Path: <netdev+bounces-25641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8AF774F9F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 02:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29481C21076
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676E1C9F7;
	Wed,  9 Aug 2023 00:00:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85F171C4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:00:15 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2712FD2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:00:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686e29b058cso4493318b3a.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 17:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691539213; x=1692144013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm5B+owbZtJ+LAFpreHAl1yfs2i6hETlV0UI2KgsE5I=;
        b=S7jrgnEEVtUldEZ4fNsxO5xEuNoE09AvfT2epMDZGQwiwLRniNAO2qXPn/6oani3Iy
         y4s2i5y5E7eP3BXt/GkDQ4kjTfxQGB4SkA14rz4hamND0QYauUTmcIS/uSJRQYbug7do
         jM9Zck/hWLwlAHtfJLiKY7st0kDikdcU5ZVQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691539213; x=1692144013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fm5B+owbZtJ+LAFpreHAl1yfs2i6hETlV0UI2KgsE5I=;
        b=Npdj2rDnQHt9oVzEqlmajCtiHMEJWdi8w9UUwtmAyne0efLon2wWxbdiDVa3hJIUBD
         oWz/DLPwrc9fulkkG3PL80CLCJJ+3wtThrfEf6e8KywXEwljOlSNiKNEP8VbO9HJCA/E
         HM0q7EQ9WnsE4kkwsYWFzQvR3bqaf07b84627iPCjltIulW0nhCAmRsRR4F1RRZfSvFu
         5lCYNIGmVxgrCb6GhPLF2/jFW8khOHNkgT4dAnPbDSpjKygdFDpy92u8IvYmhq0MNP3p
         jgPZr5D8DbofUY+BQCTokFEgPJemzcIZPYp6v2ZoDtrZ9H4MDkEvU55eN3mehtdjRa04
         WQ8g==
X-Gm-Message-State: AOJu0Yx5bd9rYO3QRAQaJJf5o6Qg4/vD89n0QALPeqyxP9Snp5Cl0NZr
	oKQCxuVtTHPiCSdHUdJNTqMwvQ==
X-Google-Smtp-Source: AGHT+IGsb7fkWGDseQQ2Ri6YAXrzLtLS9DjCLOnwlVVwzX1UZy1oeQM7mZIdp9cIPi7Q5ULncQgshQ==
X-Received: by 2002:a05:6300:808d:b0:13d:ee19:7723 with SMTP id ap13-20020a056300808d00b0013dee197723mr980401pzc.35.1691539213546;
        Tue, 08 Aug 2023 17:00:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7860e000000b00686bb3acfc2sm8609957pfn.181.2023.08.08.17.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:00:12 -0700 (PDT)
Date: Tue, 8 Aug 2023 17:00:11 -0700
From: Kees Cook <keescook@chromium.org>
To: Florian Westphal <fw@strlen.de>
Cc: Justin Stitt <justinstitt@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hardening@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] netfilter: ipset: refactor deprecated strncpy
Message-ID: <202308081659.BD539443@keescook>
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
 <20230808-net-netfilter-v1-1-efbbe4ec60af@google.com>
 <20230808233855.GI9741@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808233855.GI9741@breakpoint.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 01:38:55AM +0200, Florian Westphal wrote:
> Justin Stitt <justinstitt@google.com> wrote:
> > Fixes several buffer overread bugs present in `ip_set_core.c` by using
> > `strscpy` over `strncpy`.
> > 
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > 
> > ---
> > There exists several potential buffer overread bugs here. These bugs
> > exist due to the fact that the destination and source strings may have
> > the same length which is equal to the max length `IPSET_MAXNAMELEN`.
> 
> There is no truncation.  Inputs are checked via nla_policy:
> 
> [IPSET_ATTR_SETNAME2]   = { .type = NLA_NUL_STRING, .len = IPSET_MAXNAMELEN - 1 },

Ah, perfect. Yeah, so if it needs to zero-padding, but it is always
NUL-terminated, strscpy_pad() is the right replacement. Thanks!

-- 
Kees Cook

