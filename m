Return-Path: <netdev+bounces-25629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14B0774F3E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423112817FB
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FC41BB53;
	Tue,  8 Aug 2023 23:20:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC118035
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:20:37 +0000 (UTC)
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C2A19AF;
	Tue,  8 Aug 2023 16:20:36 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
	id 5916758730BD3; Wed,  9 Aug 2023 01:20:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 5716D60C2FC35;
	Wed,  9 Aug 2023 01:20:34 +0200 (CEST)
Date: Wed, 9 Aug 2023 01:20:34 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: Justin Stitt <justinstitt@google.com>
cc: Pablo Neira Ayuso <pablo@netfilter.org>, 
    Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org, 
    Kees Cook <keescook@chromium.org>, netfilter-devel@vger.kernel.org, 
    coreteam@netfilter.org, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] netfilter: xtables: refactor deprecated strncpy
In-Reply-To: <20230808-net-netfilter-v1-7-efbbe4ec60af@google.com>
Message-ID: <35rnr776-4ssp-314r-0473-p19q3r880ps1@vanv.qr>
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com> <20230808-net-netfilter-v1-7-efbbe4ec60af@google.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Wednesday 2023-08-09 00:48, Justin Stitt wrote:

>Prefer `strscpy` as it's a more robust interface.
>
>There may have existed a bug here due to both `tbl->repl.name` and
>`info->name` having a size of 32 as defined below:
>|  #define XT_TABLE_MAXNAMELEN 32
>
>This may lead to buffer overreads in some situations -- `strscpy` solves
>this by guaranteeing NUL-termination of the dest buffer.

It generally will not lead to overreads.
xt not only deals with strings on its own turf, it even takes
them from userspace-provided buffers, which means extra scrutiny is
absolutely required. Done in places like

x_tables.c:     if (strnlen(name, XT_EXTENSION_MAXNAMELEN) == XT_EXTENSION_MAXNAMELEN)


(Which is not to say the strncpy->strscpy mop-up is bad.)

