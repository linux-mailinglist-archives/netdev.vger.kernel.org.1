Return-Path: <netdev+bounces-25640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABB2774F9D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0C51C21041
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923561C9F6;
	Tue,  8 Aug 2023 23:57:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F1414017
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:57:36 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3F419A1;
	Tue,  8 Aug 2023 16:57:35 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qTWZt-0005i1-79; Wed, 09 Aug 2023 01:57:29 +0200
Date: Wed, 9 Aug 2023 01:57:29 +0200
From: Florian Westphal <fw@strlen.de>
To: Justin Stitt <justinstitt@google.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] netfilter: x_tables: refactor deprecated strncpy
Message-ID: <20230808235729.GK9741@breakpoint.cc>
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
 <20230808-net-netfilter-v1-6-efbbe4ec60af@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808-net-netfilter-v1-6-efbbe4ec60af@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Justin Stitt <justinstitt@google.com> wrote:
> Prefer `strscpy` to `strncpy` for use on NUL-terminated destination
> buffers.
> 
> This fixes a potential bug due to the fact that both `t->u.user.name`
> and `name` share the same size.

This replacement seems fine.

> Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> ---
> Here's an example of what happens when dest and src share same size:
> |  #define MAXLEN 5
> |  char dest[MAXLEN];
> |  const char *src = "hello";
> |  strncpy(dest, src, MAXLEN); // -> should use strscpy()
> |  // dest is now not NUL-terminated

This can't happen here, the source string is coming from the kernel
(xt target and matchinfo struct).

But, even if it would it should be fine, this function prepares
the translated 64bit blob which gets passed to translate_table(),
and that function has to check for '\0' presence.

Normally it handles the native (non-compat) data originating from
userspace, so m-->user.name can not be assumed to contain a \0.

